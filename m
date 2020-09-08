Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29ADC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946542166E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbgIHTz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:55:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:62851 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730514AbgIHPgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:36:50 -0400
IronPort-SDR: qGsZvNmhK/P07z8Qepcy3UyVgL6yrvHChDJdFvGyEwh/wSD8x48WMss9ofrvM7VCvbKwpjmafq
 xllwt4YsZ7nA==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="158159919"
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="158159919"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 07:21:33 -0700
IronPort-SDR: dun0+JlDEOAUH4fU6c+UUidwT3ben5QpCr8Dy5TTXNwHsxPxc5wQgdEhyKGLF6GBS0K1ukaqMF
 ZhDFW/lBiIXA==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="448802350"
Received: from mgarber-mobl1.amr.corp.intel.com (HELO [10.212.179.134]) ([10.212.179.134])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 07:21:32 -0700
Subject: Re: [PATCH v2 2/3] soundwire: SDCA: add helper macro to access
 controls
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20200901162225.33343-1-pierre-louis.bossart@linux.intel.com>
 <20200901162225.33343-3-pierre-louis.bossart@linux.intel.com>
 <20200904050244.GT2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f35a0ae7-2779-0c69-9ef3-0d0e298888ac@linux.intel.com>
Date:   Tue, 8 Sep 2020 08:33:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904050244.GT2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review Vinod,

> This is good, thanks for adding it in changelog. Can you also add this
> description to Documentation (that can come as an individual patch),

ok

>> +/*
>> + * v1.2 device - SDCA address mapping
>> + *
>> + * Spec definition
>> + *	Bits		Contents
>> + *	31		0 (required by addressing range)
>> + *	30:26		0b10000 (Control Prefix)
> 
> So this is for 30:26

I don't get the comment, sorry.

> 
>> + *	25		0 (Reserved)
>> + *	24:22		Function Number [2:0]
>> + *	21		Entity[6]
>> + *	20:19		Control Selector[5:4]
>> + *	18		0 (Reserved)
>> + *	17:15		Control Number[5:3]
>> + *	14		Next
>> + *	13		MBQ
>> + *	12:7		Entity[5:0]
>> + *	6:3		Control Selector[3:0]
>> + *	2:0		Control Number[2:0]
>> + */
>> +
>> +#define SDW_SDCA_CTL(fun, ent, ctl, ch)						\
>> +	(BIT(30)							|	\
> 
> Programmatically this is fine, but then since we are defining for the
> description above, IMO it would actually make sense for this to be defined
> as FIELD_PREP:
> 
>          FIELD_PREP(GENMASK(30, 26), 1)
> 
> or better
> 
>          u32_encode_bits(GENMASK(30, 26), 1)
> 
>> +	FIELD_PREP(GENMASK(24, 22), FIELD_GET(GENMASK(2, 0), (fun)))	|	\
> 
> Why not use u32_encode_bits(GENMASK(24, 22), (fun)) instead for this and
> below?

Because your comment for the v1 review was to use FIELD_PREP/FIELD_GET, 
and your other patches for bitfield access only use FIELD_PREP/FIELD_GET.

I really don't care about which macro is used but it wouldn't hurt to 
have some level of consistency between different parts of the code? Why 
not use FIELD_PREP/GET everywhere?

>> +	FIELD_PREP(BIT(21), FIELD_GET(BIT(6), (ent)))			|	\
>> +	FIELD_PREP(GENMASK(20, 19), FIELD_GET(GENMASK(5, 4), (ctl)))	|	\
>> +	FIELD_PREP(GENMASK(17, 15), FIELD_GET(GENMASK(5, 3), (ch)))	|	\
>> +	FIELD_PREP(GENMASK(12, 7), FIELD_GET(GENMASK(5, 0), (ent)))	|	\
>> +	FIELD_PREP(GENMASK(6, 3), FIELD_GET(GENMASK(3, 0), (ctl)))	|	\
>> +	FIELD_PREP(GENMASK(2, 0), FIELD_GET(GENMASK(2, 0), (ch))))
> 
> Also, can we rather have a nice function for this, that would look much
> cleaner

I am not sure what would be cleaner but fine.

> And while at it, consider defining masks for various fields rather than
> using numbers in GENMASK() above, that would look better, be more
> readable and people can reuse it.

Actually on this one I disagree. These fields are not intended to be 
used by anyone, the goal is precisely to hide them behind regmap, and 
the use of raw numbers makes it easier to cross-check the documentation 
and the code. Adding a separate set of definitions would not increase 
readability.

