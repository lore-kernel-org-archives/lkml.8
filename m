Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B0AC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4B020409
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCMR2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:28:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:35220 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCMR2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:28:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 10:28:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="237017108"
Received: from sblancoa-mobl.amr.corp.intel.com (HELO [10.251.232.239]) ([10.251.232.239])
  by fmsmga008.fm.intel.com with ESMTP; 13 Mar 2020 10:28:11 -0700
Subject: Re: [PATCH 01/10] ASoC: soc-acpi: expand description of _ADR-based
 devices
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Mac Chiang <mac.chiang@intel.com>,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        Amery Song <chao.song@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        slawomir.blauciak@intel.com, broonie@kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        gregkh@linuxfoundation.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Sathya Prakash M R <sathya.prakash.m.r@intel.com>
References: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
 <20200312193346.3264-2-pierre-louis.bossart@linux.intel.com>
 <6ea77c3e-2333-2876-7fa1-ea8a2a6f35e4@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6c6585b8-e359-2ca8-69e1-d17cd7dbc646@linux.intel.com>
Date:   Fri, 13 Mar 2020 11:21:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6ea77c3e-2333-2876-7fa1-ea8a2a6f35e4@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>   static const struct snd_soc_acpi_link_adr icl_3_in_1_default[] = {
>>       {
>>           .mask = BIT(0),
>>           .num_adr = ARRAY_SIZE(rt711_0_adr),
>> -        .adr = rt711_0_adr,
>> +        .adr_d = rt711_0_adr,
>>       },
>>       {
>>           .mask = BIT(1),
>> -        .num_adr = ARRAY_SIZE(rt1308_1_adr),
>> -        .adr = rt1308_1_adr,
>> +        .num_adr = ARRAY_SIZE(rt1308_1_group1_adr),
>> +        .adr_d = rt1308_1_adr,
> 
> Is this right, you use different struct in ARRAY_SIZE and assignment?
> 
>>       },
>>       {
>>           .mask = BIT(2),
>> -        .num_adr = ARRAY_SIZE(rt1308_2_adr),
>> -        .adr = rt1308_2_adr,
>> +        .num_adr = ARRAY_SIZE(rt1308_2_group1_adr),
>> +        .adr_d = rt1308_2_adr,
> 
> Same here.

it's of course an editing issue, thanks for spotting this.
it should be the exact same things as the structure used for cml:

static const struct snd_soc_acpi_link_adr cml_3_in_1_default[] = {
	{
		.mask = BIT(0),
		.num_adr = ARRAY_SIZE(rt711_0_adr),
		.adr_d = rt711_0_adr,
	},
	{
		.mask = BIT(1),
		.num_adr = ARRAY_SIZE(rt1308_1_group1_adr),
		.adr_d = rt1308_1_group1_adr,
	},
	{
		.mask = BIT(2),
		.num_adr = ARRAY_SIZE(rt1308_2_group1_adr),
		.adr_d = rt1308_2_group1_adr,
	},
	{
		.mask = BIT(3),
		.num_adr = ARRAY_SIZE(rt715_3_adr),
l		.adr_d = rt715_3_adr,
	},
	{}
};
