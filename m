Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9ADC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 12:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F39620578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 12:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gkQHlWIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgBQMNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 07:13:40 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51004 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgBQMNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 07:13:39 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200217121337euoutp02990e3d6ad7c80dc8c921dc69cfabbc1f~0L4UMRNqz1155611556euoutp022
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 12:13:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200217121337euoutp02990e3d6ad7c80dc8c921dc69cfabbc1f~0L4UMRNqz1155611556euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581941617;
        bh=IZX0VHNQ04ovY+9mwNorEVDKkJSLIVpz2JzA6c2FtEE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gkQHlWIqMdGE9/NyVIz2Cg9fOKCts1JMvwCJdspAr4ZNO9HgrQFZNU5dXmpSdAMP1
         ibMPYBhjU0eMEUZTtqyZZux/Ot4xrQBVP1Rj6cUkKKFDwe5YsGqc64wIltgJs08kNX
         MH6FO8oT0/mcnkSKKc+oCZcUP7Pheu1dMjM0Z9CQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200217121337eucas1p26fe5dec8f86c1da7180857fbfbc6d3cc~0L4T3-87u0285802858eucas1p2n;
        Mon, 17 Feb 2020 12:13:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4E.19.60698.1738A4E5; Mon, 17
        Feb 2020 12:13:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200217121336eucas1p2deb35417f5c4646a89762fd6146c3cf9~0L4Thf2a82297222972eucas1p2X;
        Mon, 17 Feb 2020 12:13:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200217121336eusmtrp1db1d3a82d19d521918559f67c63759cc~0L4Tg4sHA0929309293eusmtrp1O;
        Mon, 17 Feb 2020 12:13:36 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-26-5e4a8371f76e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 70.E2.07950.0738A4E5; Mon, 17
        Feb 2020 12:13:36 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200217121336eusmtip138080665b5ed946b60d82a82227e6c65~0L4TMNMMU0478804788eusmtip1N;
        Mon, 17 Feb 2020 12:13:36 +0000 (GMT)
Subject: Re: Applied "ASoC: core: ensure component names are unique" to the
 asoc tree
To:     Mark Brown <broonie@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <f666e600-2b44-f1fa-7ccf-aa44da6b8979@samsung.com>
Date:   Mon, 17 Feb 2020 13:13:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <applied-20200214134704.342501-1-jbrunet@baylibre.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djP87qFzV5xBk9ecllcuXiIyWLqwyds
        Fm8eHWG2+Halg8ni8q45bBYTb29gd2Dz2PC5ic3j/Y1Wdo+ds+6ye2xa1cnmsXlJvcfnTXIB
        bFFcNimpOZllqUX6dglcGUc2VBZ8d6k4c+ocewPjF6suRk4OCQETiW23njF1MXJxCAmsYJT4
        eWcWlPOFUeLAiTcsEM5nRokz266zw7Qc6X3ICpFYzijx/ONcZgjnLaPEorVbGUGqhAXCJZbv
        nQLUzsEhIuApceSWNEgNs8B8Romjn6eDTWITMJToetvFBmLzCthJzFk1ESzOIqAqcfXBQlYQ
        W1QgVmL2ysMsEDWCEidnPgGzOQWcJbbv2wBWzywgL9G8dTYzhC0ucevJfLAfJAQ2sUv0bn7K
        BHG2i8S2w7uhXhCWeHV8C5QtI3F6cg8LREMzo8TDc2vZIZweRonLTTMYIaqsJe6c+8UG8g6z
        gKbE+l36EGFHiUezmsC+lBDgk7jxVhDiCD6JSdumM0OEeSU62oQgqtUkZh1fB7f24IVLzBMY
        lWYheW0WkndmIXlnFsLeBYwsqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQJT0Ol/x7/u
        YNz3J+kQowAHoxIPr0OIZ5wQa2JZcWXuIUYJDmYlEV5vca84Id6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rzGi17GCgmkJ5akZqemFqQWwWSZODilGhgNEn62p57yVDjjzVe/Q2yG4lz5f5IHBb8n
        e7aqh3/cND9088Hw8z0vppZvUrG4dUE10UtzvjvXqhYD86NBBhN655beWDLr1Bkl7qU1l15X
        6nfPVJ9i2+DNmsS9TvTmD9lCm+8T5Nilv8xa8eWgx/e3GuXG3QUd2+T2PQ97c7u4Merz7RvJ
        h3YosRRnJBpqMRcVJwIAiDisZj0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7oFzV5xBj13jSyuXDzEZDH14RM2
        izePjjBbfLvSwWRxedccNouJtzewO7B5bPjcxObx/kYru8fOWXfZPTat6mTz2Lyk3uPzJrkA
        tig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jCMb
        Kgu+u1ScOXWOvYHxi1UXIyeHhICJxJHeh6xdjFwcQgJLGSVOXDrGBpGQkTg5rYEVwhaW+HOt
        iw2i6DWjxObOmcwgCWGBcInle6ewdDFycIgIeEocuSUNUsMsMJ9RYu66y2A1QgJOEivu/wYb
        xCZgKNH1tgtsAa+AncScVRPZQWwWAVWJqw8WgtWICsRK3JjZwQRRIyhxcuYTFhCbU8BZYvu+
        DWD1zAJmEvM2P2SGsOUlmrfOhrLFJW49mc80gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz0
        3GIjveLE3OLSvHS95PzcTYzAiNt27OeWHYxd74IPMQpwMCrx8DqEeMYJsSaWFVfmHmKU4GBW
        EuH1FveKE+JNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YDLIK4k3NDU0t7A0NDc2NzazUBLn
        7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAmPtY6cSP5DLtpS9qj75ZfzU/XeSHyuzUv3M2qj4V
        Pia1QinWuFDI9fyvPyEbQgSEXLSWSoveMfG1OST1NmLhT55HC2+t7j5n+O+Lq6THbqcZGWYP
        Fp9n69q58Yf6jUf2Dvv4JNXM9+lu/x8sc+yd3lGvw3PjA3K+xigm3aruWBWd+I+1xorhuRJL
        cUaioRZzUXEiAJoemR/OAgAA
X-CMS-MailID: 20200217121336eucas1p2deb35417f5c4646a89762fd6146c3cf9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200217121336eucas1p2deb35417f5c4646a89762fd6146c3cf9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200217121336eucas1p2deb35417f5c4646a89762fd6146c3cf9
References: <applied-20200214134704.342501-1-jbrunet@baylibre.com>
        <CGME20200217121336eucas1p2deb35417f5c4646a89762fd6146c3cf9@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

On 14.02.2020 21:56, Mark Brown wrote:
> The patch
>
>     ASoC: core: ensure component names are unique
>
> has been applied to the asoc tree at
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
>  From b2354e4009a773c00054b964d937e1b81cb92078 Mon Sep 17 00:00:00 2001
> From: Jerome Brunet <jbrunet@baylibre.com>
> Date: Fri, 14 Feb 2020 14:47:04 +0100
> Subject: [PATCH] ASoC: core: ensure component names are unique
>
> Make sure each ASoC component is registered with a unique name.
> The component is derived from the device name. If a device registers more
> than one component, the component names will be the same.
>
> This usually brings up a warning about the debugfs directory creation of
> the component since directory already exists.
>
> In such case, start numbering the component of the device so the names
> don't collide anymore.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Link: https://lore.kernel.org/r/20200214134704.342501-1-jbrunet@baylibre.com
> Signed-off-by: Mark Brown <broonie@kernel.org>

This patch landed in today's linux-next and I've noticed that it breaks 
registration of VC4 DRM driver on Raspberry Pi3 boards (I've compiled 
kernel from bcm2835_defconfig):

sysfs: cannot create duplicate filename 
'/devices/platform/soc/3f902000.hdmi/dma:audio-rx'
CPU: 0 PID: 67 Comm: kworker/0:2 Tainted: G        W 
5.6.0-rc2-next-20200217 #314
Hardware name: BCM2835
Workqueue: events deferred_probe_work_func
Backtrace:
[<c010c424>] (dump_backtrace) from [<c010c8a8>] (show_stack+0x20/0x24)
  r7:eb73d5c0 r6:eb53a8f0 r5:eb73d5c0 r4:eb4d3000
[<c010c888>] (show_stack) from [<c080ad40>] (dump_stack+0x20/0x28)
[<c080ad20>] (dump_stack) from [<c02be6e0>] (sysfs_warn_dup+0x60/0x74)
[<c02be680>] (sysfs_warn_dup) from [<c02bea00>] 
(sysfs_do_create_link_sd+0xa4/0xc0)
  r7:eb73d5c0 r6:eb53a8f0 r5:eb6becb8 r4:ffffffef
[<c02be95c>] (sysfs_do_create_link_sd) from [<c02beb68>] 
(sysfs_create_link+0x34/0x44)
  r9:eb698c40 r8:c093e47c r7:00000000 r6:eb537e10 r5:eb6f9900 r4:eb537e10
[<c02beb34>] (sysfs_create_link) from [<c0415afc>] 
(dma_request_chan+0x1b8/0x208)
[<c0415944>] (dma_request_chan) from [<c05f25a0>] 
(snd_dmaengine_pcm_register+0xf4/0x1bc)
  r10:c0963460 r9:eb537e10 r8:c093e47c r7:00000000 r6:eb537e10 r5:eb6f9900
  r4:c093e468
[<c05f24ac>] (snd_dmaengine_pcm_register) from [<c05f0ebc>] 
(devm_snd_dmaengine_pcm_register+0x4c/0x84)
  r10:eb715c4c r9:c093e3d4 r8:eb537e00 r7:00000000 r6:eb537e10 r5:eb7ca240
  r4:c093e468
[<c05f0e70>] (devm_snd_dmaengine_pcm_register) from [<c0492dc0>] 
(vc4_hdmi_bind+0x3a8/0x590)
  r7:eb537e10 r6:eb537e10 r5:eb715440 r4:eb715c40
[<c0492a18>] (vc4_hdmi_bind) from [<c049b6e0>] 
(component_bind_all+0x128/0x238)
  r10:eb7267c0 r9:00000008 r8:eb73f800 r7:00000018 r6:00000000 r5:eb7016c0
  r4:eb6c9240
[<c049b5b8>] (component_bind_all) from [<c048c150>] 
(vc4_drm_bind+0xe4/0x17c)
  r9:00000008 r8:eb6c88c0 r7:eb6a2840 r6:eb53b210 r5:00000000 r4:eb73f800
[<c048c06c>] (vc4_drm_bind) from [<c049adc8>] 
(try_to_bring_up_master+0x190/0x264)
  r7:eb6a2840 r6:000000a8 r5:eb7267c0 r4:eb6c9240
[<c049ac38>] (try_to_bring_up_master) from [<c049b13c>] 
(__component_add+0x80/0x114)
  r10:c0d57488 r9:00000012 r8:00000000 r7:eb6c9240 r6:c093e924 r5:c0d572f8
  r4:eb7267c0
[<c049b0bc>] (__component_add) from [<c049b1ec>] (component_add+0x1c/0x20)
  r7:c0d56f7c r6:c0d56f7c r5:eb534a10 r4:00000000
[<c049b1d0>] (component_add) from [<c0493864>] (vc4_vec_dev_probe+0x20/0x28)
[<c0493844>] (vc4_vec_dev_probe) from [<c04a43a4>] 
(platform_drv_probe+0x58/0xa8)
[<c04a434c>] (platform_drv_probe) from [<c04a2298>] 
(really_probe+0x1a8/0x428)
  r7:c0d56f7c r6:00000000 r5:c0e579b8 r4:eb534a10
[<c04a20f0>] (really_probe) from [<c04a2840>] 
(driver_probe_device+0x158/0x1ac)
  r9:00000000 r8:00000001 r7:eb70fe9c r6:c0d56f7c r5:c0d56f7c r4:eb534a10
[<c04a26e8>] (driver_probe_device) from [<c04a2a40>] 
(__device_attach_driver+0xb0/0xf8)
  r9:00000000 r8:00000001 r7:eb70fe9c r6:c0d56f7c r5:eb534a10 r4:00000001
[<c04a2990>] (__device_attach_driver) from [<c04a0408>] 
(bus_for_each_drv+0xa0/0xc8)
  r7:c04a2990 r6:eb70fe9c r5:c0d04248 r4:00000000
[<c04a0368>] (bus_for_each_drv) from [<c04a25bc>] 
(__device_attach+0xa4/0x158)
  r7:eb534a54 r6:c0d04248 r5:c0d576a8 r4:eb534a10
[<c04a2518>] (__device_attach) from [<c04a2aa4>] 
(device_initial_probe+0x1c/0x20)
  r8:eb9c7300 r7:00000000 r6:eb534a10 r5:c0d576a8 r4:eb534a10
[<c04a2a88>] (device_initial_probe) from [<c04a12d4>] 
(bus_probe_device+0x38/0x90)
[<c04a129c>] (bus_probe_device) from [<c04a1848>] 
(deferred_probe_work_func+0x70/0xb0)
  r7:00000000 r6:c0d57478 r5:c0d5746c r4:eb534a10
[<c04a17d8>] (deferred_probe_work_func) from [<c0135a50>] 
(process_one_work+0x1a8/0x2ac)
  r7:00000000 r6:c0d0c8a4 r5:c0d57484 r4:eb6ed880
[<c01358a8>] (process_one_work) from [<c0136ddc>] 
(worker_thread+0x1f0/0x2e8)
  r10:00000000 r9:c0d156e0 r8:c0d0c8b8 r7:c0d156e0 r6:c0d0c8a4 r5:eb6ed894
  r4:eb6ed880
[<c0136bec>] (worker_thread) from [<c013b5a0>] (kthread+0x120/0x130)
  r10:00000000 r9:eb6f5018 r8:eb4e9e98 r7:c0136bec r6:eb6ed880 r5:eb6e6b40
  r4:eb6f5000 r3:00000000
[<c013b480>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
Exception stack(0xeb70ffb0 to 0xeb70fff8)
ffa0:                                     00000000 00000000 00000000 
00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c013b480 r4:eb6e6b40
vc4_hdmi 3f902000.hdmi: Cannot create DMA dma:audio-rx symlink
vc4_hdmi 3f902000.hdmi: ASoC: CODEC DAI vc4-hdmi-hifi not registered
vc4_hdmi 3f902000.hdmi: Could not register sound card: -517
vc4-drm soc:gpu: failed to bind 3f902000.hdmi (ops vc4_hdmi_ops): -517
vc4-drm soc:gpu: master bind failed: -517

Reverting this patch fixes vc4-drm driver registration and 
initialization. If I find some spare time I will debug this issue 
further, but it looks that it is somehow related to deferred probe.


> ---
>   sound/soc/soc-core.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 03b87427faa7..6a58a8f6e3c4 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2446,6 +2446,33 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
>   	return ret;
>   }
>   
> +static char *snd_soc_component_unique_name(struct device *dev,
> +					   struct snd_soc_component *component)
> +{
> +	struct snd_soc_component *pos;
> +	int count = 0;
> +	char *name, *unique;
> +
> +	name = fmt_single_name(dev, &component->id);
> +	if (!name)
> +		return name;
> +
> +	/* Count the number of components registred by the device */
> +	for_each_component(pos) {
> +		if (dev == pos->dev)
> +			count++;
> +	}
> +
> +	/* Keep naming as it is for the 1st component */
> +	if (!count)
> +		return name;
> +
> +	unique = devm_kasprintf(dev, GFP_KERNEL, "%s-%d", name, count);
> +	devm_kfree(dev, name);
> +
> +	return unique;
> +}
> +
>   static int snd_soc_component_initialize(struct snd_soc_component *component,
>   	const struct snd_soc_component_driver *driver, struct device *dev)
>   {
> @@ -2454,7 +2481,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
>   	INIT_LIST_HEAD(&component->card_list);
>   	mutex_init(&component->io_mutex);
>   
> -	component->name = fmt_single_name(dev, &component->id);
> +	component->name = snd_soc_component_unique_name(dev, component);
>   	if (!component->name) {
>   		dev_err(dev, "ASoC: Failed to allocate name\n");
>   		return -ENOMEM;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

