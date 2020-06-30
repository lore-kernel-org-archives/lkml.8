Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EBAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5B4206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390308AbgF3R04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:26:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:3228 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbgF3R0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:26:55 -0400
IronPort-SDR: it0o/H8U+k9HIzdtbzjGHPq7CuOBBQnJbbGOJsM0UFoUt8d6IOzevnY9Iq+65Y9hMSbAqF6K+9
 Cqu+kxMGxL+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="207832970"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="207832970"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 10:26:53 -0700
IronPort-SDR: NAstuiCUVlQGHNxXkQ2FxTLqs6zfTlwZYqkktIFIgfcMxPut9azCbPgqywpOIDNKa0p+iXR9MY
 NeR+sApAgfVg==
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="281307447"
Received: from dnoeunx-mobl.amr.corp.intel.com (HELO [10.254.77.113]) ([10.254.77.113])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 10:26:52 -0700
Subject: Re: [PATCH] ASoC: Intel: bxt-da7219-max98357a: support MAX98390
 speaker amp
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "M, Naveen" <naveen.m@intel.com>, "Zhi, Yong" <yong.zhi@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Libin Yang <libin.yang@linux.intel.com>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "Song, Chao" <chao.song@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Yan <yanaijie@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1593498722-7074-1-git-send-email-brent.lu@intel.com>
 <DM6PR11MB4316CA5F11462D11D1751C6C976F0@DM6PR11MB4316.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e7bd9caf-1bf8-d57c-2b67-13a63d23ebf9@linux.intel.com>
Date:   Tue, 30 Jun 2020 11:26:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB4316CA5F11462D11D1751C6C976F0@DM6PR11MB4316.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> diff --git a/sound/soc/intel/boards/Kconfig
>> b/sound/soc/intel/boards/Kconfig index 3d820e1..b3b863e 100644
>> --- a/sound/soc/intel/boards/Kconfig
>> +++ b/sound/soc/intel/boards/Kconfig
>> @@ -291,9 +291,17 @@ config
>> SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
>>   	select SND_SOC_DMIC
>>   	select SND_SOC_HDAC_HDMI
>>
>> +config SND_SOC_INTEL_DA7219_MAX98390_GENERIC
>> +	tristate
>> +	select SND_SOC_DA7219
>> +	select SND_SOC_MAX98390
>> +	select SND_SOC_DMIC
>> +	select SND_SOC_HDAC_HDMI
>> +
>>   config SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON
>>   	tristate
>>   	select SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
>> +	select SND_SOC_INTEL_DA7219_MAX98390_GENERIC

this doesn't look too good, the only difference is the addition of 
MAX98090 which should be added in SND_SOC_INTEL_DA7219_MAX98357A_GENERIC 
above.

>>
>>   if SND_SOC_INTEL_APL
>>
>> @@ -309,6 +317,18 @@ config
>> SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
>>   	   Say Y or m if you have such a device. This is a recommended option.
>>   	   If unsure select "N".
>>
>> +config SND_SOC_INTEL_BXT_DA7219_MAX98390_MACH
>> +	tristate "Broxton with DA7219 and MAX98390 in I2S Mode"
>> +	depends on I2C && ACPI && GPIOLIB
>> +	depends on MFD_INTEL_LPSS || COMPILE_TEST
>> +	depends on SND_HDA_CODEC_HDMI
>> +	select SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON
>> +	help
>> +	   This adds support for ASoC machine driver for Broxton-P platforms
>> +	   with DA7219 + MAX98390 I2S audio codec.
>> +	   Say Y or m if you have such a device. This is a recommended option.
>> +	   If unsure select "N".
>> +

i don't think you need a different top-level config, just extend the 
existing one to say MAX98357A or MAX98390.

[...]

>>   	if (soc_intel_is_glk())
>>   		snd_soc_dapm_add_routes(&card->dapm, gemini_map,
>>   					ARRAY_SIZE(gemini_map));
>> @@ -631,17 +719,17 @@ static int bxt_card_late_probe(struct snd_soc_card
>> *card)
>>   		component = pcm->codec_dai->component;
>>   		snprintf(jack_name, sizeof(jack_name),
>>   			"HDMI/DP, pcm=%d Jack", pcm->device);
>> -		err = snd_soc_card_jack_new(card, jack_name,
>> +		ret = snd_soc_card_jack_new(card, jack_name,
>>   					SND_JACK_AVOUT,
>> &broxton_hdmi[i],
>>   					NULL, 0);
>>
>> -		if (err)
>> -			return err;
>> +		if (ret)
>> +			return ret;
>>
>> -		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
>> +		ret = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
>>   						&broxton_hdmi[i]);
>> -		if (err < 0)
>> -			return err;
>> +		if (ret < 0)
>> +			return ret;

these look like unrelated changes?


>> --- a/sound/soc/intel/common/soc-acpi-intel-cml-match.c
>> +++ b/sound/soc/intel/common/soc-acpi-intel-cml-match.c
>> @@ -15,8 +15,8 @@ static struct snd_soc_acpi_codecs rt1011_spk_codecs =
>> {  };
>>
>>   static struct snd_soc_acpi_codecs max98357a_spk_codecs = {
>> -	.num_codecs = 1,
>> -	.codecs = {"MX98357A"}
>> +	.num_codecs = 2,
>> +	.codecs = {"MX98357A", "MX98390"}

That looks just wrong?

It would be really odd to list two devices as prerequisites for loading 
a driver, when in practice they are mutually exclusive? Something's 
broken in coreboot if both are present.

see below what we used for JSL:

see static struct snd_soc_acpi_codecs jsl_7219_98373_codecs = {
	.num_codecs = 1,
	.codecs = {"MX98373"}
};

static struct snd_soc_acpi_codecs mx98360a_spk = {
	.num_codecs = 1,
	.codecs = {"MX98360A"}
};
