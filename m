Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7E2C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFDF206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bu1b6jMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgBQNSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:18:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37775 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgBQNSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:18:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so19708967wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 05:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=YsWUgG/A1RZWWoaKKpKtl6eolamJNCA8Zl+/ra7bXwo=;
        b=bu1b6jMv6E2v000SuMorlPfUd6XRDkUoKnvwiHwZoMHbWBGLX5+Opkcv5SUahJFjxq
         cflEM4E92DiUtK84pEdyZNZzFDZi050+zm12D9jVW1FY95FkOBru8fVHglsjLvrF47zm
         q4WUXSVhW7LgeUVisf2LHEkSvH5Gzq5BbhXhPeSSnh5+t0wpPZtA/8m/BMQPXMjj80Ya
         LlQKwG0w9Mz4btcToPxvTfAYYIYrsNLJOAusI3GTRNPFw8Je4mCeo960Kd9Z29sseRVk
         m65IcIw6Oq6hTQh2S750t1kPMPMIxojcHjP4Q1tdvNXSMM4ratjIKRbYGKNW1topyamY
         IoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=YsWUgG/A1RZWWoaKKpKtl6eolamJNCA8Zl+/ra7bXwo=;
        b=hRxR9VYJbxUoeQOEHLkuNAHqSxuTzMr0kEymbQ7KA2vHvU2fX0wq498DFGWIYqQG9i
         ldXnpyBTLYl/M9qcr16x4I8aojh9odUyaZql8/thX/f9P9roF9jE+hO+pj5bhNL9MUem
         Wlsa45aq0GgdU4HH4Gg2G6kEPp4gar61FCHFXUT+xfk9lGP58VLigctlLJz419P8zoY6
         vhbtlVWB8vsF8ooQI8oCaizR9jfD9pbz2vO9VIbjicNurT95xVVPaw2EvMVhYjzMg3ju
         ru/l6XudmbEVHbo/WqMmszduYja4214NyuN54rDMBvqjmMSgSCzuIJQQQYUMW8lnbhSz
         I/7Q==
X-Gm-Message-State: APjAAAV4/dQRaObzL/J8i8rRgDuq+GCsTyDiPY5Fb162Cxfmw2q3BcWV
        rNsSmokto+bu+9u3Q6OKkwycaw==
X-Google-Smtp-Source: APXvYqyVzViNW8p+semJPrLGxN45G6nSsz6IAD2iJV9BNgd+4KsxAmit2+YXh/IlG6lm+0Fqsrsoug==
X-Received: by 2002:adf:806c:: with SMTP id 99mr21298879wrk.328.1581945522687;
        Mon, 17 Feb 2020 05:18:42 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s1sm903553wro.66.2020.02.17.05.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:18:41 -0800 (PST)
References: <applied-20200214134704.342501-1-jbrunet@baylibre.com> <CGME20200217121336eucas1p2deb35417f5c4646a89762fd6146c3cf9@eucas1p2.samsung.com> <f666e600-2b44-f1fa-7ccf-aa44da6b8979@samsung.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Subject: Re: Applied "ASoC: core: ensure component names are unique" to the asoc tree
In-reply-to: <f666e600-2b44-f1fa-7ccf-aa44da6b8979@samsung.com>
Date:   Mon, 17 Feb 2020 14:18:41 +0100
Message-ID: <1jlfp1z70u.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 17 Feb 2020 at 13:13, Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> Dear All,
>
> On 14.02.2020 21:56, Mark Brown wrote:
>> The patch
>>
>>     ASoC: core: ensure component names are unique
>>
>> has been applied to the asoc tree at
>>
>>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>>
>> All being well this means that it will be integrated into the linux-next
>> tree (usually sometime in the next 24 hours) and sent to Linus during
>> the next merge window (or sooner if it is a bug fix), however if
>> problems are discovered then the patch may be dropped or reverted.
>>
>> You may get further e-mails resulting from automated or manual testing
>> and review of the tree, please engage with people reporting problems and
>> send followup patches addressing any issues that are reported if needed.
>>
>> If any updates are required or you are submitting further changes they
>> should be sent as incremental updates against current git, existing
>> patches will not be replaced.
>>
>> Please add any relevant lists and maintainers to the CCs when replying
>> to this mail.
>>
>> Thanks,
>> Mark
>>
>>  From b2354e4009a773c00054b964d937e1b81cb92078 Mon Sep 17 00:00:00 2001
>> From: Jerome Brunet <jbrunet@baylibre.com>
>> Date: Fri, 14 Feb 2020 14:47:04 +0100
>> Subject: [PATCH] ASoC: core: ensure component names are unique
>>
>> Make sure each ASoC component is registered with a unique name.
>> The component is derived from the device name. If a device registers more
>> than one component, the component names will be the same.
>>
>> This usually brings up a warning about the debugfs directory creation of
>> the component since directory already exists.
>>
>> In such case, start numbering the component of the device so the names
>> don't collide anymore.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> Link: https://lore.kernel.org/r/20200214134704.342501-1-jbrunet@baylibre.com
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>
> This patch landed in today's linux-next and I've noticed that it breaks 
> registration of VC4 DRM driver on Raspberry Pi3 boards (I've compiled 
> kernel from bcm2835_defconfig):

I think I have an idea about what is going on. (good catch in the defer BTW)

1) Funny to see that the vc4-hdmi already registers several (3) ASoC
components. It must have had warning about the debugfs entry before this patch.

2) Let say that vc4 hdmi driver defers after the registration of the 2nd
component (/drivers/gpu/drm/vc4/vc4-hdmi.c:1082). The devm callback of
the 2nd component will run first and call
snd_soc_unregister_component(). The catch is that this function
unregisters all the components registered by the linux device so far.

3) Then the devm callback of the dma_engine will run
snd_dmaengine_pcm_unregister()
(sound/soc/soc-generic-dmaengine-pcm.c:466) and the lookup will not find
the component dmaengine component since it is already unregistered. The
function bails out and dmaengine_pcm_release_chan() is not run.

4) Next time the hdmi driver tries to probe, the it will fail to
allocate the DMA channel because the sysfs entry already exists.

I would suspect that any driver doing:
1) devm_snd_dmaengine_pcm_register()
2) devm_snd_soc_register_component()
could be exposed to this issue, even before this patch.
I don't really get is triggering the issue in this change.

Maybe it would be better if the devm callback of
devm_snd_soc_register_component() unregistered only the related component.

>
> sysfs: cannot create duplicate filename 
> '/devices/platform/soc/3f902000.hdmi/dma:audio-rx'
> CPU: 0 PID: 67 Comm: kworker/0:2 Tainted: G        W 
> 5.6.0-rc2-next-20200217 #314
> Hardware name: BCM2835
> Workqueue: events deferred_probe_work_func
> Backtrace:
> [<c010c424>] (dump_backtrace) from [<c010c8a8>] (show_stack+0x20/0x24)
>   r7:eb73d5c0 r6:eb53a8f0 r5:eb73d5c0 r4:eb4d3000
> [<c010c888>] (show_stack) from [<c080ad40>] (dump_stack+0x20/0x28)
> [<c080ad20>] (dump_stack) from [<c02be6e0>] (sysfs_warn_dup+0x60/0x74)
> [<c02be680>] (sysfs_warn_dup) from [<c02bea00>] 
> (sysfs_do_create_link_sd+0xa4/0xc0)
>   r7:eb73d5c0 r6:eb53a8f0 r5:eb6becb8 r4:ffffffef
> [<c02be95c>] (sysfs_do_create_link_sd) from [<c02beb68>] 
> (sysfs_create_link+0x34/0x44)
>   r9:eb698c40 r8:c093e47c r7:00000000 r6:eb537e10 r5:eb6f9900 r4:eb537e10
> [<c02beb34>] (sysfs_create_link) from [<c0415afc>] 
> (dma_request_chan+0x1b8/0x208)
> [<c0415944>] (dma_request_chan) from [<c05f25a0>] 
> (snd_dmaengine_pcm_register+0xf4/0x1bc)
>   r10:c0963460 r9:eb537e10 r8:c093e47c r7:00000000 r6:eb537e10 r5:eb6f9900
>   r4:c093e468
> [<c05f24ac>] (snd_dmaengine_pcm_register) from [<c05f0ebc>] 
> (devm_snd_dmaengine_pcm_register+0x4c/0x84)
>   r10:eb715c4c r9:c093e3d4 r8:eb537e00 r7:00000000 r6:eb537e10 r5:eb7ca240
>   r4:c093e468
> [<c05f0e70>] (devm_snd_dmaengine_pcm_register) from [<c0492dc0>] 
> (vc4_hdmi_bind+0x3a8/0x590)
>   r7:eb537e10 r6:eb537e10 r5:eb715440 r4:eb715c40
> [<c0492a18>] (vc4_hdmi_bind) from [<c049b6e0>] 
> (component_bind_all+0x128/0x238)
>   r10:eb7267c0 r9:00000008 r8:eb73f800 r7:00000018 r6:00000000 r5:eb7016c0
>   r4:eb6c9240
> [<c049b5b8>] (component_bind_all) from [<c048c150>] 
> (vc4_drm_bind+0xe4/0x17c)
>   r9:00000008 r8:eb6c88c0 r7:eb6a2840 r6:eb53b210 r5:00000000 r4:eb73f800
> [<c048c06c>] (vc4_drm_bind) from [<c049adc8>] 
> (try_to_bring_up_master+0x190/0x264)
>   r7:eb6a2840 r6:000000a8 r5:eb7267c0 r4:eb6c9240
> [<c049ac38>] (try_to_bring_up_master) from [<c049b13c>] 
> (__component_add+0x80/0x114)
>   r10:c0d57488 r9:00000012 r8:00000000 r7:eb6c9240 r6:c093e924 r5:c0d572f8
>   r4:eb7267c0
> [<c049b0bc>] (__component_add) from [<c049b1ec>] (component_add+0x1c/0x20)
>   r7:c0d56f7c r6:c0d56f7c r5:eb534a10 r4:00000000
> [<c049b1d0>] (component_add) from [<c0493864>] (vc4_vec_dev_probe+0x20/0x28)
> [<c0493844>] (vc4_vec_dev_probe) from [<c04a43a4>] 
> (platform_drv_probe+0x58/0xa8)
> [<c04a434c>] (platform_drv_probe) from [<c04a2298>] 
> (really_probe+0x1a8/0x428)
>   r7:c0d56f7c r6:00000000 r5:c0e579b8 r4:eb534a10
> [<c04a20f0>] (really_probe) from [<c04a2840>] 
> (driver_probe_device+0x158/0x1ac)
>   r9:00000000 r8:00000001 r7:eb70fe9c r6:c0d56f7c r5:c0d56f7c r4:eb534a10
> [<c04a26e8>] (driver_probe_device) from [<c04a2a40>] 
> (__device_attach_driver+0xb0/0xf8)
>   r9:00000000 r8:00000001 r7:eb70fe9c r6:c0d56f7c r5:eb534a10 r4:00000001
> [<c04a2990>] (__device_attach_driver) from [<c04a0408>] 
> (bus_for_each_drv+0xa0/0xc8)
>   r7:c04a2990 r6:eb70fe9c r5:c0d04248 r4:00000000
> [<c04a0368>] (bus_for_each_drv) from [<c04a25bc>] 
> (__device_attach+0xa4/0x158)
>   r7:eb534a54 r6:c0d04248 r5:c0d576a8 r4:eb534a10
> [<c04a2518>] (__device_attach) from [<c04a2aa4>] 
> (device_initial_probe+0x1c/0x20)
>   r8:eb9c7300 r7:00000000 r6:eb534a10 r5:c0d576a8 r4:eb534a10
> [<c04a2a88>] (device_initial_probe) from [<c04a12d4>] 
> (bus_probe_device+0x38/0x90)
> [<c04a129c>] (bus_probe_device) from [<c04a1848>] 
> (deferred_probe_work_func+0x70/0xb0)
>   r7:00000000 r6:c0d57478 r5:c0d5746c r4:eb534a10
> [<c04a17d8>] (deferred_probe_work_func) from [<c0135a50>] 
> (process_one_work+0x1a8/0x2ac)
>   r7:00000000 r6:c0d0c8a4 r5:c0d57484 r4:eb6ed880
> [<c01358a8>] (process_one_work) from [<c0136ddc>] 
> (worker_thread+0x1f0/0x2e8)
>   r10:00000000 r9:c0d156e0 r8:c0d0c8b8 r7:c0d156e0 r6:c0d0c8a4 r5:eb6ed894
>   r4:eb6ed880
> [<c0136bec>] (worker_thread) from [<c013b5a0>] (kthread+0x120/0x130)
>   r10:00000000 r9:eb6f5018 r8:eb4e9e98 r7:c0136bec r6:eb6ed880 r5:eb6e6b40
>   r4:eb6f5000 r3:00000000
> [<c013b480>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> Exception stack(0xeb70ffb0 to 0xeb70fff8)
> ffa0:                                     00000000 00000000 00000000 
> 00000000
> ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
> 00000000
> ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
>   r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c013b480 r4:eb6e6b40
> vc4_hdmi 3f902000.hdmi: Cannot create DMA dma:audio-rx symlink
> vc4_hdmi 3f902000.hdmi: ASoC: CODEC DAI vc4-hdmi-hifi not registered
> vc4_hdmi 3f902000.hdmi: Could not register sound card: -517
> vc4-drm soc:gpu: failed to bind 3f902000.hdmi (ops vc4_hdmi_ops): -517
> vc4-drm soc:gpu: master bind failed: -517
>
> Reverting this patch fixes vc4-drm driver registration and 
> initialization. If I find some spare time I will debug this issue 
> further, but it looks that it is somehow related to deferred probe.
>
>
>> ---
>>   sound/soc/soc-core.c | 29 ++++++++++++++++++++++++++++-
>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index 03b87427faa7..6a58a8f6e3c4 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -2446,6 +2446,33 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
>>   	return ret;
>>   }
>>   
>> +static char *snd_soc_component_unique_name(struct device *dev,
>> +					   struct snd_soc_component *component)
>> +{
>> +	struct snd_soc_component *pos;
>> +	int count = 0;
>> +	char *name, *unique;
>> +
>> +	name = fmt_single_name(dev, &component->id);
>> +	if (!name)
>> +		return name;
>> +
>> +	/* Count the number of components registred by the device */
>> +	for_each_component(pos) {
>> +		if (dev == pos->dev)
>> +			count++;
>> +	}
>> +
>> +	/* Keep naming as it is for the 1st component */
>> +	if (!count)
>> +		return name;
>> +
>> +	unique = devm_kasprintf(dev, GFP_KERNEL, "%s-%d", name, count);
>> +	devm_kfree(dev, name);
>> +
>> +	return unique;
>> +}
>> +
>>   static int snd_soc_component_initialize(struct snd_soc_component *component,
>>   	const struct snd_soc_component_driver *driver, struct device *dev)
>>   {
>> @@ -2454,7 +2481,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
>>   	INIT_LIST_HEAD(&component->card_list);
>>   	mutex_init(&component->io_mutex);
>>   
>> -	component->name = fmt_single_name(dev, &component->id);
>> +	component->name = snd_soc_component_unique_name(dev, component);
>>   	if (!component->name) {
>>   		dev_err(dev, "ASoC: Failed to allocate name\n");
>>   		return -ENOMEM;
>
> Best regards

