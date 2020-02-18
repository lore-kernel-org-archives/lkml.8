Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7421C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29B720722
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VTaMuOJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgBRJcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:32:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34808 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgBRJcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:32:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id s144so1752029wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=5Vu5NREMqZNgn/ugbyRfT/sUu90ARmdAjTNhjJow4ng=;
        b=VTaMuOJvmVCVZGf1e9CGkyUz0S7jnNLCV/LN8dgXGfFMuX4otjCtJEleDAkB7PKZ8o
         finjLiRZn9hxUlDm5FFUzNrUqi5yMCiAIiE3kgiOhaMxk1Wxm95lDMK3z7G/5cA3e+oC
         5tmZTCUDAQITGFsC0xMfCZxzU/LqxSN7r1HyZgmlAJb3sartwnrRAfr5I4MXHIuO6noq
         3pm+SVBsJdPEFJjLePstjpAErRzCtPbQbNgwb2Us2U735qsUQzMZQY6h7b5CFezJMa2s
         RbSYFS4nwDvDaQY8mUkapbLA+9QXUaxNH/M4xrdZrgOpewi+H95lc3Svb9hC9XQD9SXN
         Pt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=5Vu5NREMqZNgn/ugbyRfT/sUu90ARmdAjTNhjJow4ng=;
        b=rvrg6bDiXO2czA8wJjlrAQRdy0gDthk7lY9XNcKLqMMi0TK2gz0kKkwfizB14zsCFV
         U9VmCUWRN/akjTtOCd8bx1i9Orn/su7fqoMkHxXJvz2cTd2BsIe+IJsWLqWOPMdgPoza
         m/EVIpkCs0afRwtel+BcK8c+UTcnQUAXmimpH1q8M+YU4Gc7TofZsgxDgzghE0KatB7/
         DITAHxnFdE33LVwCfzzi6b/Sykh3tTHkNcB86HvgZOFwNJJ8wU+ui5apylQ8EwPKlDNJ
         /oPfwQfQUPkAcne6wAAbWcD9rO5EYEfqeXTxq0b35p+SHAsNZUqx8u/Hm6VhaP1bx9p3
         oNyQ==
X-Gm-Message-State: APjAAAUI2Klc0k9nAJCOGUH18hQRo4wCJtboBO9uZuvtTFgAJuD7kM7k
        C/Xe6JgIXY2rjsX8YDp1Hyss/w==
X-Google-Smtp-Source: APXvYqwA4p4xTRLmc1PHQhlRYoA9irCDEUh5d1GD4hj2Qv/UyOsb4cp+cyo8BLIu2TaPKadjOksZpw==
X-Received: by 2002:a1c:1fc5:: with SMTP id f188mr2117144wmf.55.1582018367152;
        Tue, 18 Feb 2020 01:32:47 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id y1sm5239049wrq.16.2020.02.18.01.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 01:32:46 -0800 (PST)
References: <20557448-d6d2-7584-e2ac-c46d337e1778@samsung.com> <CGME20200217180640eucas1p220a8a33489d01a860821370060953153@eucas1p2.samsung.com> <20200217180626.593909-1-jbrunet@baylibre.com> <e70bb7a5-21b0-0e71-871e-2c02b35f86ea@samsung.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [RFT/DONTMERGE] ASoC: devm_snd_soc_register_component fixup
In-reply-to: <e70bb7a5-21b0-0e71-871e-2c02b35f86ea@samsung.com>
Date:   Tue, 18 Feb 2020 10:32:45 +0100
Message-ID: <1jblpw5jgi.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 18 Feb 2020 at 07:47, Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> Hi Jerome,
>
> On 17.02.2020 19:06, Jerome Brunet wrote:
>> Hi Marek, would you mind trying the following patch. It should target the
>> component removal intead of removing them all. I'd like to comfirm this is
>> your problem before pushing in this direction. Thanks
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>
> It helps a bit. There is no warning from sysfs, but vc4-drm is still not 
> registered properly:
>
> raspberrypi-firmware soc:firmware: Attached to firmware from 2019-07-09 
> 14:40
> raspberrypi-clk raspberrypi-clk: CPU frequency range: min 600000000, max 
> 1200000000
> vc4_hdmi 3f902000.hdmi: ASoC: CODEC DAI vc4-hdmi-hifi not registered
> vc4_hdmi 3f902000.hdmi: Could not register sound card: -517
> vc4-drm soc:gpu: failed to bind 3f902000.hdmi (ops vc4_hdmi_ops): -517
> vc4-drm soc:gpu: master bind failed: -517

It explains why the original patch of this thread triggered the issue.

The problem is at drivers/gpu/drm/vc4/vc4-hdmi.c:1108
The driver derives the component name directly from the device name and
assume all 3 components have the same name.

This is not ideal:
* We seen that debugfs was already warning about the name collision
* ASoC should be allowed to set the name

With this patch, the component name of the 2nd and 3rd component changed
but the name claimed by the card driver remain unchanged which is why the
card probe defers.

This particular issue can probably be solved with lookup of the
component name instead of a direct derivation. I'll check.

>
>> ---
>>   include/sound/soc.h                   |  1 +
>>   sound/soc/soc-core.c                  |  8 +++++++
>>   sound/soc/soc-devres.c                | 32 ++++++++++++++++++---------
>>   sound/soc/soc-generic-dmaengine-pcm.c |  2 +-
>>   4 files changed, 31 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/sound/soc.h b/include/sound/soc.h
>> index f0e4f36f83bf..e5bfe2609110 100644
>> --- a/include/sound/soc.h
>> +++ b/include/sound/soc.h
>> @@ -442,6 +442,7 @@ int snd_soc_add_component(struct device *dev,
>>   		const struct snd_soc_component_driver *component_driver,
>>   		struct snd_soc_dai_driver *dai_drv,
>>   		int num_dai);
>> +void snd_soc_del_component(struct snd_soc_component *component);
>>   int snd_soc_register_component(struct device *dev,
>>   			 const struct snd_soc_component_driver *component_driver,
>>   			 struct snd_soc_dai_driver *dai_drv, int num_dai);
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index 6a58a8f6e3c4..bf6a64fbfa52 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -2599,6 +2599,14 @@ static void snd_soc_del_component_unlocked(struct snd_soc_component *component)
>>   	list_del(&component->list);
>>   }
>>   
>> +void snd_soc_del_component(struct snd_soc_component *component)
>> +{
>> +	mutex_lock(&client_mutex);
>> +	snd_soc_del_component_unlocked(component);
>> +	mutex_unlock(&client_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_del_component);
>> +
>>   int snd_soc_add_component(struct device *dev,
>>   			struct snd_soc_component *component,
>>   			const struct snd_soc_component_driver *component_driver,
>> diff --git a/sound/soc/soc-devres.c b/sound/soc/soc-devres.c
>> index a9ea172a66a7..d5e9e2bed2ce 100644
>> --- a/sound/soc/soc-devres.c
>> +++ b/sound/soc/soc-devres.c
>> @@ -11,7 +11,7 @@
>>   
>>   static void devm_component_release(struct device *dev, void *res)
>>   {
>> -	snd_soc_unregister_component(*(struct device **)res);
>> +	snd_soc_del_component(*(struct snd_soc_component **)res);
>>   }
>>   
>>   /**
>> @@ -28,21 +28,31 @@ int devm_snd_soc_register_component(struct device *dev,
>>   			 const struct snd_soc_component_driver *cmpnt_drv,
>>   			 struct snd_soc_dai_driver *dai_drv, int num_dai)
>>   {
>> -	struct device **ptr;
>> -	int ret;
>> +	struct snd_soc_component *component;
>> +	struct snd_soc_component **ptr;
>> +	int ret = -ENOMEM;
>> +
>> +	component = devm_kzalloc(dev, sizeof(*component), GFP_KERNEL);
>> +	if (!component)
>> +		return -ENOMEM;
>>   
>>   	ptr = devres_alloc(devm_component_release, sizeof(*ptr), GFP_KERNEL);
>>   	if (!ptr)
>> -		return -ENOMEM;
>> +	        goto err_devres;
>>   
>> -	ret = snd_soc_register_component(dev, cmpnt_drv, dai_drv, num_dai);
>> -	if (ret == 0) {
>> -		*ptr = dev;
>> -		devres_add(dev, ptr);
>> -	} else {
>> -		devres_free(ptr);
>> -	}
>> +	ret = snd_soc_add_component(dev, component, cmpnt_drv, dai_drv,
>> +				    num_dai);
>> +	if (ret)
>> +		goto err_add;
>> +
>> +	*ptr = component;
>> +	devres_add(dev, ptr);
>> +	return 0;
>>   
>> +err_add:
>> +	devres_free(ptr);
>> +err_devres:
>> +	devm_kfree(dev, component);
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(devm_snd_soc_register_component);
>> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
>> index 2cc25651661c..a33f21ce2d7a 100644
>> --- a/sound/soc/soc-generic-dmaengine-pcm.c
>> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
>> @@ -474,7 +474,7 @@ void snd_dmaengine_pcm_unregister(struct device *dev)
>>   
>>   	pcm = soc_component_to_pcm(component);
>>   
>> -	snd_soc_unregister_component(dev);
>> +	snd_soc_del_component(component);
>>   	dmaengine_pcm_release_chan(pcm);
>>   	kfree(pcm);
>>   }
>
> Best regards

