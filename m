Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167B9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9444206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="i5CFN5+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgGGAVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 20:21:50 -0400
Received: from vps.xff.cz ([195.181.215.36]:46312 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgGGAVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 20:21:50 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jul 2020 20:21:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1594080977; bh=JUSgjHbMWsR63Xao324VZJbLDS8GFmaoNVS/TT1FhXE=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=i5CFN5+sNdbLqRlnX4ZrrBKnVSp7D+ff4ipeEI0LeZ6DBIg/QFNCyavWyNlipfGMv
         q78rVjZ2bBGvFQjilD45sX9UEQsuEJE2oRmC/q7gFy0SLwMXis9SLMabh428LYIduT
         e0Ueibf9L8Leq16HpKs2tXAa52Z28EnzRJpdqq9c=
Date:   Tue, 7 Jul 2020 02:16:17 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Add regulator devfreq support to Panfrost
Message-ID: <20200707001617.kwdiicqqof36i35g@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200704102535.189647-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200704102535.189647-1-peron.clem@gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Clément,

On Sat, Jul 04, 2020 at 12:25:21PM +0200, Clément Péron wrote:
> Hi,
> 
> This serie cleans and adds regulator support to Panfrost devfreq.
> This is mostly based on comment for the freshly introduced lima
> devfreq.

I tried to test the series, but I'm unsure what it's meant to
be based on.

It doesn't appply on top of linux-next and while it applies on
top of 5.8-rc3, it fails to run due to ordering of 

  dev_pm_opp_set_regulators and dev_pm_opp_of_add_table

where this patch series places

  dev_pm_opp_of_add_table after dev_pm_opp_of_add_table

which fails with this warning:

https://elixir.bootlin.com/linux/v5.8-rc3/source/drivers/opp/core.c#L1696

[    0.155455] ------------[ cut here ]------------
[    0.155473] WARNING: CPU: 2 PID: 1 at drivers/opp/core.c:1696 dev_pm_opp_set_regulators+0x134/0x1f0
[    0.155476] Modules linked in:
[    0.155487] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc4-00328-gf89269f4a65c #12
[    0.155489] Hardware name: OrangePi 3 (DT)
[    0.155496] pstate: 20000005 (nzCv daif -PAN -UAO BTYPE=--)
[    0.155502] pc : dev_pm_opp_set_regulators+0x134/0x1f0
[    0.155507] lr : dev_pm_opp_set_regulators+0x28/0x1f0
[    0.155510] sp : ffffffc01002bb00
[    0.155512] x29: ffffffc01002bb00 x28: 0000000000000000
[    0.155518] x27: ffffffc0113b03b0 x26: ffffffc011431960
[    0.155523] x25: ffffffc011397a70 x24: ffffff807b6a2410
[    0.155528] x23: 0000000000000001 x22: ffffffc010f290a0
[    0.155533] x21: ffffff80789e3880 x20: ffffff80789e3ac8
[    0.155538] x19: ffffff80789e4400 x18: 00000000fffffffe
[    0.155543] x17: 0000000000000001 x16: 0000000000000019
[    0.155548] x15: 0000000000000001 x14: ffffffffffffffff
[    0.155553] x13: ffffffc01169fe00 x12: 0000000000000005
[    0.155558] x11: 0000000000000007 x10: 0101010101010101
[    0.155563] x9 : ffffffffffffffff x8 : 7f7f7f7f7f7f7f7f
[    0.155568] x7 : fefefeff646c606d x6 : 01111d48f3f5f3f0
[    0.155573] x5 : 70737573481d1101 x4 : 0000000000000000
[    0.155577] x3 : ffffff80789e4450 x2 : 0000000000000000
[    0.155582] x1 : ffffff807b490000 x0 : ffffff8078c2fe00
[    0.155587] Call trace:
[    0.155595]  dev_pm_opp_set_regulators+0x134/0x1f0
[    0.155603]  panfrost_devfreq_init+0x70/0x178
[    0.155608]  panfrost_device_init+0x108/0x5d8
[    0.155613]  panfrost_probe+0xa4/0x178
[    0.155619]  platform_drv_probe+0x50/0xa0
[    0.155626]  really_probe+0xd4/0x318
[    0.155631]  driver_probe_device+0x54/0xb0
[    0.155638]  device_driver_attach+0x6c/0x78
[    0.155643]  __driver_attach+0x54/0xd0
[    0.155649]  bus_for_each_dev+0x5c/0x98
[    0.155654]  driver_attach+0x20/0x28
[    0.155660]  bus_add_driver+0x140/0x1e8
[    0.155666]  driver_register+0x60/0x110
[    0.155670]  __platform_driver_register+0x44/0x50
[    0.155678]  panfrost_driver_init+0x18/0x20
[    0.155685]  do_one_initcall+0x3c/0x160
[    0.155691]  kernel_init_freeable+0x20c/0x2b0
[    0.155698]  kernel_init+0x10/0x104
[    0.155703]  ret_from_fork+0x10/0x1c
[    0.155712] ---[ end trace ed26920b0484a95e ]---
[    0.155725] panfrost 1800000.gpu: [drm:panfrost_devfreq_init] *ERROR* Couldn't set OPP regulators
[    0.156710] panfrost 1800000.gpu: devfreq init failed -16
[    0.156725] panfrost 1800000.gpu: Fatal error during GPU init
[    0.156795] panfrost: probe of 1800000.gpu failed with error -16
[    0.157158] cacheinfo: Unable to detect cache hierarchy for CPU 0


thank you and regards,
	o.

> We need to add regulator support because on Allwinner the GPU OPP
> table defines both frequencies and voltages.
> 
> First patches [01-07] should not change the actual behavior
> and introduce a proper panfrost_devfreq struct.
> 
> Regards,
> Clément
> 
> Clément Péron (14):
>   drm/panfrost: avoid static declaration
>   drm/panfrost: clean headers in devfreq
>   drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
>   drm/panfrost: introduce panfrost_devfreq struct
>   drm/panfrost: use spinlock instead of atomic
>   drm/panfrost: properly handle error in probe
>   drm/panfrost: rename error labels in device_init
>   drm/panfrost: move devfreq_init()/fini() in device
>   drm/panfrost: dynamically alloc regulators
>   drm/panfrost: add regulators to devfreq
>   arm64: defconfig: Enable devfreq cooling device
>   arm64: dts: allwinner: h6: Add cooling map for GPU
>   [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
>   [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be always
> 
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   1 +
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 102 +++++++++++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c   | 165 ++++++++++++------
>  drivers/gpu/drm/panfrost/panfrost_devfreq.h   |  30 +++-
>  drivers/gpu/drm/panfrost/panfrost_device.c    |  61 ++++---
>  drivers/gpu/drm/panfrost/panfrost_device.h    |  14 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c       |  15 +-
>  drivers/gpu/drm/panfrost/panfrost_job.c       |  10 +-
>  9 files changed, 290 insertions(+), 109 deletions(-)
> 
> -- 
> 2.25.1
> 
