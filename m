Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF94C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EC1207C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHUPRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:17:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:18349 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgHUPR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:17:28 -0400
IronPort-SDR: Hlsn19nD8YWku2/mcNy7uukn9FXxqY9O+s361/9OIAMNJSI85Qhjt7tdh9wbumSpgVHdgBGIJu
 fQeqkp/nwyBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="217094652"
X-IronPort-AV: E=Sophos;i="5.76,337,1592895600"; 
   d="scan'208";a="217094652"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 08:17:27 -0700
IronPort-SDR: X3WZs6CSMS+GgnkdfsfTbfDrbYXMtwd4QXENHMbQ/vkSmOsQgjxTnbAVin/D+ElXQ3Weo9quLC
 ipOKHUYXOXLg==
X-IronPort-AV: E=Sophos;i="5.76,337,1592895600"; 
   d="scan'208";a="442377166"
Received: from pcmiller-mobl1.amr.corp.intel.com (HELO [10.209.120.121]) ([10.209.120.121])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 08:17:25 -0700
Subject: Re: [PATCH] soundwire: cadence: fix race condition between suspend
 and Slave device alerts
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200817222340.18042-1-yung-chuan.liao@linux.intel.com>
 <20200819090637.GE2639@vkoul-mobl>
 <8d60fa6f-bb7f-daa8-5ae2-51386b87ccad@linux.intel.com>
 <20200821050758.GI2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <29ea5a44-b971-770a-519c-ae879557b63f@linux.intel.com>
Date:   Fri, 21 Aug 2020 10:17:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821050758.GI2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> cancel_work_sync() will either
>> a) wait until the current work completes, or
>> b) prevent a new one from starting.
>>
>> there's no way to really 'abort' a workqueue, 'cancel' means either complete
>> or don't start.
> 
> Quite right, as that is how everyone deals with it. Stop the irq from
> firing first and then wait until work is cancelled or completed, hence
> cancel_work_sync()

No, this cannot work... The work queue in progress will initiate 
transactions which would never complete because the interrupts are disabled.

>> if you disable the interrupts then cancel the work, you have a risk of not
>> letting the work complete if it already started (case a).
>>
>> The race is
>> a) the interrupt thread (this function) starts
>> b) the work is scheduled and starts
>> c) the suspend handler starts and disables interrupts in [1] below.
>> d) the work initiates transactions which will never complete since Cadence
>> interrupts have been disabled.
> 
> Would it not be better to let work handle the case of interrupts
> disabled and not initiates transactions which wont complete here? That
> sounds more reasonable to do rather than complete the work which anyone
> doesn't matter as you are suspending

A in-progress workqueue has no notion that interrupts are disabled, nor 
that the device is in the process of suspending. It writes into a fifo 
and blocks with wait_for_completion(). the complete() is done in an 
interrupt thread, triggered when the RX Fifo reaches a watermark.

So if you disable interrupts, the complete() never happens.

The safe way to do things with the current code is to let the workqueue 
complete, then disable interrupts.

We only disable interrupts on suspend, we don't need to test if 
interrupts are enabled for every single byte that's transmitted on the 
bus. Not to mention that this additional test would be racy as hell and 
require yet another synchronization primitive making the code more 
complicated.

So yes, the current transactions will complete and will be ignored, but 
it's a lot better than trying to prevent these transactions from 
happening with extra layers of complexity that will impact *every* 
transaction.

BTW I looked at another alternative based on the msg lock, so that 
interrupts cannot be disabled while a message is being sent. However 
because a workqueue may send multiple messages, e.g. to read registers 
are non-contiguous locations, there is no way to guarantee what happens 
how messages and interrupt disabling are scheduled, so there'd still be 
a case of a workqueue not completing and being stuck on a mutex_lock(), 
not so good either.

In short, this is the simplest way to fix the timeout on resume.
