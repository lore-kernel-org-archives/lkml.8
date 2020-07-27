Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5CAC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C355320838
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgG0XJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:09:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:18892 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgG0XJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:09:23 -0400
IronPort-SDR: C1iJeFphE6OzP+LUY/2jpvYy2OtoYgCZsg6tfwRP7aNZBp+08Ilj25LCSzZ9BNimdiSVSSIVmq
 oIqL08gi2heA==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="148589452"
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="148589452"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 16:09:23 -0700
IronPort-SDR: HDbucH1thtwxMh88SEKKCtGjqWlByDLLLDk/PuNdKzt/O7HLFLf68vmBlRxP5eZ42A5H7qnVyK
 L+NHJwfyNnog==
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="328157482"
Received: from ticela-az-051.amr.corp.intel.com (HELO [10.254.114.193]) ([10.254.114.193])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 16:09:22 -0700
Subject: Re: [PATCH] scripts/kernel-doc: optionally treat warnings as errors
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20200724230138.153178-1-pierre-louis.bossart@linux.intel.com>
 <20200727162805.3ef9bacf@lwn.net>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8048e2c6-8c2d-f41e-972b-9f4730aa6726@linux.intel.com>
Date:   Mon, 27 Jul 2020 18:09:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727162805.3ef9bacf@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank Jon for the feedback,

>> The kbuild bot recently added the W=1 option, which triggered
>> documentation cleanups to squelch hundreds of kernel-doc warnings.
>>
>> To make sure new kernel contributions don't add regressions to
>> kernel-doc descriptors, this patch suggests an option to treat
>> warnings as errors in CI/automated tests. A command-line option is
>> provided to the kernel-doc script, as well as a check on environment
>> variables to turn this optional behavior on.
>>
>> Examples for the two subsystems I contribute to:
>>
>> KCFLAGS="-Wall -Werror" make W=1 sound/
>> KCFLAGS="-Wall -Werror" make W=1 drivers/soundwire/
>>
>> Randy Dunlap also suggested adding a log for when generating
>> documentation. The documentation build is however not stopped for now.
>>
>> KDOC_WERROR=1 make htmldocs
> 
> So I'm not opposed to this, but I'm missing a couple of things in the
> changelog:
> 
>   - A statement that you are adding a -Werror option that invokes this
>     behavior.
> 
>   - Mention of the fact that you also cause it to look at a couple of
>     environment variables and change its behavior based on that.
> 
> Could I get a version with that clarified a bit?

Both points were covered by the sentence "A command-line option is
provided to the kernel-doc script, as well as a check on environment
variables to turn this optional behavior on".

I can try and make this clearer, maybe by moving this sentence to the 
start of a new paragraph?

