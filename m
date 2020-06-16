Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080BCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4E220767
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgFPIgv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:36:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45168 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgFPIgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:36:51 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jl75M-0005FX-8z
        for linux-kernel@vger.kernel.org; Tue, 16 Jun 2020 08:36:48 +0000
Received: by mail-pj1-f69.google.com with SMTP id j43so1780657pje.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4luD9Pjs2w7u5TOT9P/1cM0hYy6m6xjsnc/GO2bXHUI=;
        b=CLyKLFRIVi9r5MmREDDQoqU8ZmFRu59AM9zb580xkIqsGQm26rbvz4GJ8K1KeyBswv
         6funrjBMRfdcFIB1Xsf0V1AFJAqzL1ZP96tNDrv7a5QCet2OCaNR/XYY6FeTfgWrtqcd
         pCQCR0A3tz9TulPD1hHYxJklkiy8Tn/fq78h/ztJzm42hmicg7rbWSkDrZqxqfhUuOtL
         XpFBsjjEZBcQdGVevb16TdbgXQ3qJ7eTAZD8OrURbdoXno93Ieca35MmBBwtDs8oxtMl
         r/d1sk+bwPduJiCmV2kQN5CfSMA5M6baKJ/RJ05226YC4gHiYPF7W5s3jms9T1rF8DJ0
         fXQQ==
X-Gm-Message-State: AOAM533Y6oMpLYjKOdfEkEJE5vdxgFeJPQUpFlrswSlvL4ebJQRcD/A1
        9gzBTNoQ3eixwuMrYXmvN3pZtZNTAD6HUQLWDwCqPkfOYPunhzqjOFBPELAd7SSSQfI8HU4gkKs
        0yGjStsrdHRfvKfxrwShJD0lJK/6VDIMRfOarEhNXrA==
X-Received: by 2002:a17:902:6bcb:: with SMTP id m11mr1171721plt.126.1592296606482;
        Tue, 16 Jun 2020 01:36:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwr46RVkzz2pu7Plw4kJd58Tn68BBk+EPxhGs7rpMn1DvmsWcr5I98wLFFpjURYCM5noKBbYQ==
X-Received: by 2002:a17:902:6bcb:: with SMTP id m11mr1171698plt.126.1592296606019;
        Tue, 16 Jun 2020 01:36:46 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id a12sm15906822pfr.44.2020.06.16.01.36.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 01:36:45 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/2] ALSA: hda: Make codec controlled LED support more
 generic
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5himfr30cv.wl-tiwai@suse.de>
Date:   Tue, 16 Jun 2020 16:36:41 +0800
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Tomas Espeleta <tomas.espeleta@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B11E093E-6A30-4820-AC0E-C2887F5462F2@canonical.com>
References: <20200616044702.17570-1-kai.heng.feng@canonical.com>
 <s5himfr30cv.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 16, 2020, at 16:01, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Tue, 16 Jun 2020 06:46:58 +0200,
> Kai-Heng Feng wrote:
>> 
>> Currently, only HDA codec GPIO controlled LED class is supported, and
>> only via platform specific quirk.
>> 
>> There are systems that control LED via COEF instead of GPIO, and to
>> support those systems, move the LED class registration to
>> snd_hda_gen_add_micmute_led(), so all systems can facilitate the same
>> interface.
> 
> This will result in creating the led cdev always when the mic-mute LED
> feature is used, not only for HP but also for Dell and Huawei.
> Is this the intended result?

Ok, I can see there are other vendors calling snd_hda_gen_fixup_micmute_led() to create LED class.
And no, that's not the intended result.

I guess a chained function can be a better approach.

I'll send another series.

Kai-Heng

> 
> 
> thanks,
> 
> Takashi
> 
>> 
>> In addition to that, add LED_CORE_SUSPENDRESUME flag since some systems
>> don't restore the LED properly after suspend.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> sound/pci/hda/hda_generic.c   | 28 ++++++++++++++++++++++++++++
>> sound/pci/hda/patch_realtek.c | 30 ------------------------------
>> 2 files changed, 28 insertions(+), 30 deletions(-)
>> 
>> diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
>> index f4e9d9445e18..4242407734c0 100644
>> --- a/sound/pci/hda/hda_generic.c
>> +++ b/sound/pci/hda/hda_generic.c
>> @@ -4006,6 +4006,28 @@ static const struct snd_kcontrol_new micmute_led_mode_ctl = {
>>  *
>>  * Returns 0 if the hook is established or a negative error code.
>>  */
>> +
>> +#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
>> +static int micmute_led_set(struct led_classdev *led_cdev,
>> +			   enum led_brightness brightness)
>> +{
>> +	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
>> +	struct hda_gen_spec *spec = codec->spec;
>> +
>> +	spec->micmute_led.led_mode = !brightness;
>> +	call_micmute_led_update(codec);
>> +	return 0;
>> +}
>> +
>> +static struct led_classdev micmute_led_cdev = {
>> +	.name = "hda::micmute",
>> +	.max_brightness = 1,
>> +	.brightness_set_blocking = micmute_led_set,
>> +	.default_trigger = "audio-micmute",
>> +	.flags = LED_CORE_SUSPENDRESUME,
>> +};
>> +#endif
>> +
>> int snd_hda_gen_add_micmute_led(struct hda_codec *codec,
>> 				void (*hook)(struct hda_codec *))
>> {
>> @@ -4019,6 +4041,12 @@ int snd_hda_gen_add_micmute_led(struct hda_codec *codec,
>> 	spec->cap_sync_hook = update_micmute_led;
>> 	if (!snd_hda_gen_add_kctl(spec, NULL, &micmute_led_mode_ctl))
>> 		return -ENOMEM;
>> +
>> +#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
>> +	micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
>> +	if (devm_led_classdev_register(&codec->core.dev, &micmute_led_cdev))
>> +		codec_warn(codec, "failed to register micmute LED\n");
>> +#endif
>> 	return 0;
>> }
>> EXPORT_SYMBOL_GPL(snd_hda_gen_add_micmute_led);
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index 6d73f8beadb6..cead44a6c6cd 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -4109,26 +4109,6 @@ static void alc_gpio_micmute_update(struct hda_codec *codec)
>> 			    spec->gen.micmute_led.led_value);
>> }
>> 
>> -#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
>> -static int micmute_led_set(struct led_classdev *led_cdev,
>> -			   enum led_brightness brightness)
>> -{
>> -	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
>> -	struct alc_spec *spec = codec->spec;
>> -
>> -	alc_update_gpio_led(codec, spec->gpio_mic_led_mask,
>> -			    spec->micmute_led_polarity, !!brightness);
>> -	return 0;
>> -}
>> -
>> -static struct led_classdev micmute_led_cdev = {
>> -	.name = "hda::micmute",
>> -	.max_brightness = 1,
>> -	.brightness_set_blocking = micmute_led_set,
>> -	.default_trigger = "audio-micmute",
>> -};
>> -#endif
>> -
>> /* setup mute and mic-mute GPIO bits, add hooks appropriately */
>> static void alc_fixup_hp_gpio_led(struct hda_codec *codec,
>> 				  int action,
>> @@ -4136,9 +4116,6 @@ static void alc_fixup_hp_gpio_led(struct hda_codec *codec,
>> 				  unsigned int micmute_mask)
>> {
>> 	struct alc_spec *spec = codec->spec;
>> -#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
>> -	int err;
>> -#endif
>> 
>> 	alc_fixup_gpio(codec, action, mute_mask | micmute_mask);
>> 
>> @@ -4151,13 +4128,6 @@ static void alc_fixup_hp_gpio_led(struct hda_codec *codec,
>> 	if (micmute_mask) {
>> 		spec->gpio_mic_led_mask = micmute_mask;
>> 		snd_hda_gen_add_micmute_led(codec, alc_gpio_micmute_update);
>> -
>> -#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
>> -		micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
>> -		err = devm_led_classdev_register(&codec->core.dev, &micmute_led_cdev);
>> -		if (err)
>> -			codec_warn(codec, "failed to register micmute LED\n");
>> -#endif
>> 	}
>> }
>> 
>> -- 
>> 2.17.1
>> 

