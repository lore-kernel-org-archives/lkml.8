Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664FFC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FA020718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s69Kcaze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgBQOgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:36:54 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38003 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgBQOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:36:54 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200217143652euoutp017340b78dc2f14c43d3606ac1f3ce7128~0N1ZG3pMm2417824178euoutp019
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 14:36:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200217143652euoutp017340b78dc2f14c43d3606ac1f3ce7128~0N1ZG3pMm2417824178euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581950212;
        bh=Aw+GcEGAOAFjBDn4bw5HZrk4baOAINLZ2AgrAo1Nk7Y=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=s69Kcazer+F1Q43PIA9+VOyftLc/PsIB6rOo8+1Pmwx1vzDvq05be4jsNS2g/c/aD
         4fm3JZN+xTVx6arTSpSEy+YfXvEr0ybGBXexwO+118B5h2VQu0+wZtQVP6sC3blYtp
         954kxJk6O8hwIlWyFh5LsEdN3Om6fdFCUpmdvdLM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200217143652eucas1p2bc6dad066589d1b31f6a1dc6c3b32d3f~0N1Yz4D-T1002310023eucas1p2f;
        Mon, 17 Feb 2020 14:36:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C1.6E.61286.405AA4E5; Mon, 17
        Feb 2020 14:36:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200217143652eucas1p1e15e99f1bfdf755c352b383e91024347~0N1YaEhWN3210932109eucas1p1f;
        Mon, 17 Feb 2020 14:36:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200217143652eusmtrp1f3247f2e7ffee2bea81210ca5677d9ff~0N1YZgx_A2776027760eusmtrp16;
        Mon, 17 Feb 2020 14:36:52 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-59-5e4aa5046c0c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 13.99.07950.305AA4E5; Mon, 17
        Feb 2020 14:36:51 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200217143651eusmtip2e154ff93f15e86ae636b535f972227e9~0N1YBwMiP1707017070eusmtip2a;
        Mon, 17 Feb 2020 14:36:51 +0000 (GMT)
Subject: Re: Applied "ASoC: core: ensure component names are unique" to the
 asoc tree
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <20557448-d6d2-7584-e2ac-c46d337e1778@samsung.com>
Date:   Mon, 17 Feb 2020 15:36:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1jlfp1z70u.fsf@starbuckisacylon.baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djP87osS73iDGYsEre4cvEQk8XUh0/Y
        LN48OsJs8e1KB5PF5V1z2Cwm3t7A7sDmseFzE5vH+xut7B47Z91l99i0qpPNY/OSeo/Pm+QC
        2KK4bFJSczLLUov07RK4MuZ872Es+KRSsffeX/YGxgNyXYwcHBICJhILtkp3MXJxCAmsYJTY
        1bOECcL5wigxcftaKOczo8T7Oa2sXYycYB0nNk5kh0gsZ5T4dP4vI4TzllHiYtcFZpAqYYFw
        ieV7p7CA2CICnhILF/5nBiliFpjPKHH083R2kASbgKFE19suNhCbV8BOYvvDbUwgNouAqsSr
        nhdgNaICsRKzVx5mgagRlDg58wmYzSlgLXHk/mmwGmYBeYntb+cwQ9jiEreezGeCOHUTu8TJ
        R/YQtovExdlnmCFsYYlXx7ewQ9gyEqcn97CAHCch0Mwo8fDcWnYIp4dR4nLTDEaIKmuJO+d+
        sYGCjFlAU2L9Ln2IsKPEo1lNLJCQ5JO48VYQ4gY+iUnbpjNDhHklOtqEIKrVJGYdXwe39uCF
        S8wTGJVmIflsFpJvZiH5ZhbC3gWMLKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzECU9Dp
        f8c/7WD8einpEKMAB6MSD29An1ecEGtiWXFl7iFGCQ5mJRFeb3GgEG9KYmVValF+fFFpTmrx
        IUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYysTzj7VhyNeSK9NFnqU4Ot3xL+/HYr
        poLp1k3LGvi7DnF/SLrO1zRbLOfkY16rfZXHj8281DS362ZiwMvdoe03gksrM7hqDv5Olbmo
        lrfg9u86ofx1d9NmxB6fPWee9hIhb4fVQee7Z956Vso4YcWr2xc2GHBtF41/tjNl9Zb7VlVb
        JnKv/eOkxFKckWioxVxUnAgALkY+Fz0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7rMS73iDKZss7G4cvEQk8XUh0/Y
        LN48OsJs8e1KB5PF5V1z2Cwm3t7A7sDmseFzE5vH+xut7B47Z91l99i0qpPNY/OSeo/Pm+QC
        2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MuZ8
        72Es+KRSsffeX/YGxgNyXYycHBICJhInNk5k72Lk4hASWMoocXzRWVaIhIzEyWkNULawxJ9r
        XWwQRa8ZJR6ufsACkhAWCJdYvncKmC0i4CmxcOF/ZpAiZoH5jBJz111mhuj4wyix9GYjWBWb
        gKFE11uQUZwcvAJ2EtsfbmMCsVkEVCVe9bxgB7FFBWIlbszsYIKoEZQ4OfMJWC+ngLXEkfun
        wWqYBcwk5m1+yAxhy0tsfzsHyhaXuPVkPtMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nz
        i430ihNzi0vz0vWS83M3MQLjbtuxn1t2MHa9Cz7EKMDBqMTDu2KCV5wQa2JZcWXuIUYJDmYl
        EV5vcaAQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wNTQl5JvKGpobmFpaG5sbmxmYWSOG+H
        wMEYIYH0xJLU7NTUgtQimD4mDk6pBsYz/8VjJuRvXBT6Syh9UkxZ11OPjbvT8zNPqJ3/mDA9
        /r/+nOACI8utdb/44na/fLWiuOPz1Lo9RhM1PWt155y6+4/73BcbVqHCHTyZ6+q0ba3bVRlm
        L/VaJfRrelHZscemk53PqHAxxVjfuvEwy/3MqphJ4TL33JXlWFWWHZ8kdblhKl/8sYlKLMUZ
        iYZazEXFiQBmoHot0QIAAA==
X-CMS-MailID: 20200217143652eucas1p1e15e99f1bfdf755c352b383e91024347
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200217121336eucas1p2deb35417f5c4646a89762fd6146c3cf9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200217121336eucas1p2deb35417f5c4646a89762fd6146c3cf9
References: <applied-20200214134704.342501-1-jbrunet@baylibre.com>
        <CGME20200217121336eucas1p2deb35417f5c4646a89762fd6146c3cf9@eucas1p2.samsung.com>
        <f666e600-2b44-f1fa-7ccf-aa44da6b8979@samsung.com>
        <1jlfp1z70u.fsf@starbuckisacylon.baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On 17.02.2020 14:18, Jerome Brunet wrote:
> On Mon 17 Feb 2020 at 13:13, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> On 14.02.2020 21:56, Mark Brown wrote:
>>> The patch
>>>
>>>      ASoC: core: ensure component names are unique
>>>
>>> has been applied to the asoc tree at
>>>
>>>      https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>>>
>>> All being well this means that it will be integrated into the linux-next
>>> tree (usually sometime in the next 24 hours) and sent to Linus during
>>> the next merge window (or sooner if it is a bug fix), however if
>>> problems are discovered then the patch may be dropped or reverted.
>>>
>>> You may get further e-mails resulting from automated or manual testing
>>> and review of the tree, please engage with people reporting problems and
>>> send followup patches addressing any issues that are reported if needed.
>>>
>>> If any updates are required or you are submitting further changes they
>>> should be sent as incremental updates against current git, existing
>>> patches will not be replaced.
>>>
>>> Please add any relevant lists and maintainers to the CCs when replying
>>> to this mail.
>>>
>>> Thanks,
>>> Mark
>>>
>>>   From b2354e4009a773c00054b964d937e1b81cb92078 Mon Sep 17 00:00:00 2001
>>> From: Jerome Brunet <jbrunet@baylibre.com>
>>> Date: Fri, 14 Feb 2020 14:47:04 +0100
>>> Subject: [PATCH] ASoC: core: ensure component names are unique
>>>
>>> Make sure each ASoC component is registered with a unique name.
>>> The component is derived from the device name. If a device registers more
>>> than one component, the component names will be the same.
>>>
>>> This usually brings up a warning about the debugfs directory creation of
>>> the component since directory already exists.
>>>
>>> In such case, start numbering the component of the device so the names
>>> don't collide anymore.
>>>
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>> Link: https://lore.kernel.org/r/20200214134704.342501-1-jbrunet@baylibre.com
>>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> This patch landed in today's linux-next and I've noticed that it breaks
>> registration of VC4 DRM driver on Raspberry Pi3 boards (I've compiled
>> kernel from bcm2835_defconfig):
> I think I have an idea about what is going on. (good catch in the defer BTW)
>
> 1) Funny to see that the vc4-hdmi already registers several (3) ASoC
> components. It must have had warning about the debugfs entry before this patch.

Okay, right, before this patch there is a warning from debugfs I've 
missed (debugfs was not enabled in bcm2835_defconfig):

raspberrypi-firmware soc:firmware: Attached to firmware from 2019-07-09 
14:40
raspberrypi-clk raspberrypi-clk: CPU frequency range: min 600000000, max 
1200000000
debugfs: Directory '3f902000.hdmi' with parent 'vc4-hdmi' already present!
vc4_hdmi 3f902000.hdmi: vc4-hdmi-hifi <-> 3f902000.hdmi mapping ok
vc4-drm soc:gpu: bound 3f902000.hdmi (ops vc4_hdmi_ops)
vc4-drm soc:gpu: bound 3f806000.vec (ops vc4_vec_ops)
vc4-drm soc:gpu: bound 3f004000.txp (ops vc4_txp_ops)
vc4-drm soc:gpu: bound 3f400000.hvs (ops vc4_hvs_ops)
vc4-drm soc:gpu: bound 3f206000.pixelvalve (ops vc4_crtc_ops)
vc4-drm soc:gpu: bound 3f207000.pixelvalve (ops vc4_crtc_ops)
vc4-drm soc:gpu: bound 3f807000.pixelvalve (ops vc4_crtc_ops)
vc4-drm soc:gpu: bound 3fc00000.v3d (ops vc4_v3d_ops)

> 2) Let say that vc4 hdmi driver defers after the registration of the 2nd
> component (/drivers/gpu/drm/vc4/vc4-hdmi.c:1082). The devm callback of
> the 2nd component will run first and call
> snd_soc_unregister_component(). The catch is that this function
> unregisters all the components registered by the linux device so far.
>
> 3) Then the devm callback of the dma_engine will run
> snd_dmaengine_pcm_unregister()
> (sound/soc/soc-generic-dmaengine-pcm.c:466) and the lookup will not find
> the component dmaengine component since it is already unregistered. The
> function bails out and dmaengine_pcm_release_chan() is not run.
>
> 4) Next time the hdmi driver tries to probe, the it will fail to
> allocate the DMA channel because the sysfs entry already exists.
>
> I would suspect that any driver doing:
> 1) devm_snd_dmaengine_pcm_register()
> 2) devm_snd_soc_register_component()
> could be exposed to this issue, even before this patch.
> I don't really get is triggering the issue in this change.
>
> Maybe it would be better if the devm callback of
> devm_snd_soc_register_component() unregistered only the related component.

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

