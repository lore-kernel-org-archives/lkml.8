Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4822C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90880208C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgH1PSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:18:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:1989 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgH1PSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:18:20 -0400
IronPort-SDR: pz4LaaT+8mwjNDf4JDySGScND6n/AzhucaSjsG6E5qq24R6aTSZHpDZl/+dpQlAcJF/Ju9wrFo
 W8Hvc/ca1MRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="174732357"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="174732357"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 08:18:20 -0700
IronPort-SDR: lpnUix3jb1jq5RniOzI6GlxCPQkIhMwJ2N2ThQElCFiFYWFOWsKKR9DPQKVUtEpN5FFTJ5NW61
 g8ymFrLqnyBg==
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="300266458"
Received: from lilymao-mobl.amr.corp.intel.com (HELO [10.209.185.175]) ([10.209.185.175])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 08:18:18 -0700
Subject: Re: [PATCH 09/11] soundwire: intel: add dynamic debug trace for
 clock-stop invalid configs
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-10-yung-chuan.liao@linux.intel.com>
 <20200826094817.GC2639@vkoul-mobl>
 <21038e8d-dbd9-76c7-c758-9933fb45024a@linux.intel.com>
 <20200828074952.GO2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b5d8a731-d753-060a-f224-63de3b29b7d2@linux.intel.com>
Date:   Fri, 28 Aug 2020 09:54:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828074952.GO2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> Detect cases where the clock is assumed to be stopped but the IP is
>>>> not in the relevant state, and add a dynamic debug trace.
>>>
>>> you meant a debug print..and it looks like error print below (also in title).
>>
>> I don't understand the comment. Is the 'trace' confusing and are you asking
>> to e.g. change the commit message to 'add dynamic debug log'?
> 
> Question is what is dynamic about this?
dev_dbg() is part of the kernel dynamic debug capability...

https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html

Not sure what you are asking here?
