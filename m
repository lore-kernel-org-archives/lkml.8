Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14219C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F6820809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgG0XSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:18:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:32724 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgG0XSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:18:31 -0400
IronPort-SDR: uLz3O8k1FbJhKihZL2PQnDVjkqnw1uBo22gLSfy+RH3Q43kgagmsHiFxjoyohZaF7XkEf8m6a5
 sbHrP9nwZ0tQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="150295572"
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="150295572"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 16:18:31 -0700
IronPort-SDR: WWjiGGeKx/Y7RciU1RNktdIldrQm3ilnidYMZm2K/zJU2Xi+lpe3b783g0t8iZ1rDTnYWxSrp9
 aZhtPmQsC9Fg==
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="328159516"
Received: from ticela-az-051.amr.corp.intel.com (HELO [10.254.114.193]) ([10.254.114.193])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 16:18:30 -0700
Subject: Re: [PATCH] scripts/kernel-doc: optionally treat warnings as errors
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20200724230138.153178-1-pierre-louis.bossart@linux.intel.com>
 <20200727162805.3ef9bacf@lwn.net>
 <8048e2c6-8c2d-f41e-972b-9f4730aa6726@linux.intel.com>
 <20200727171506.1e05a50a@lwn.net>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2656144b-2420-de8f-9e4a-9a2306924622@linux.intel.com>
Date:   Mon, 27 Jul 2020 18:18:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727171506.1e05a50a@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/20 6:15 PM, Jonathan Corbet wrote:
> On Mon, 27 Jul 2020 18:09:21 -0500
> Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
> 
>> Both points were covered by the sentence "A command-line option is
>> provided to the kernel-doc script, as well as a check on environment
>> variables to turn this optional behavior on".
> 
> 
> Making that more prominent would be good, but a changelog like this should
> say *which* command-line option was provided, and *which* environment
> variables are checked.  Don't make people go digging through the patch to
> figure it out.  See what I'm getting at?

ok. I tried to avoid duplicating what's in the code, since it's 
relatively minimal and self-explanatory but I see your point. Will send 
a v2.
