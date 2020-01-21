Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3C5C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B9E24655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579599628;
	bh=VgJ+Vrsu4/FV5/6PAsTdWdGxtgPUJliPeEo6bRmPSso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OKa0LuOLx6CN5cR0OGU1TJ58pgFgTKIiQzkDno+dx5PURMau+KDTRsz2f/xtGMkpV
	 6tiodkdaAVM5+Ws89sxga6GiQ6VmTy5Da7oDL+RkBlpycTwmhgvwpRcOZ+4MUjgql5
	 BCTBG2pZ9oorlr1D/4v5+BvU4uISyKjgBrHvTXUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgAUJk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:40:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbgAUJk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:40:27 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C82D217F4;
        Tue, 21 Jan 2020 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579599625;
        bh=VgJ+Vrsu4/FV5/6PAsTdWdGxtgPUJliPeEo6bRmPSso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXUjcOC3q1e2ijdq7CvubBXfpev13jxYEqdLM8xXSThcO47M5bx29bmBsvYNzYxq7
         ZCEP1xeIeR18Hb9kQbX1LqfKYvPFOBhRzG9nTa310pSXrXCKU6f/mSXLFKCNFCTv+/
         5azhWFions6A06XsEpk/l/tjjehiG+IgEkKRmO9I=
Date:   Tue, 21 Jan 2020 10:40:23 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: No master_xfer_atomic for i2c-mv64xxx.c
Message-ID: <20200121094023.jywheey6sjsgrr44@gilmour.lan>
References: <da0061d1-917f-d807-a7ac-05d302d88565@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ri2cc3wayxbar2zz"
Content-Disposition: inline
In-Reply-To: <da0061d1-917f-d807-a7ac-05d302d88565@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ri2cc3wayxbar2zz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Florian,

On Sat, Jan 18, 2020 at 08:21:43PM -0800, Florian Fainelli wrote:
> Happy new year to all of you!

Happy new year to you too ;)

> On a lamobo R1 (A20) the trace below can be seen by typing "halt"
> which makes us try to perform an i2c transaction in atomic context
> by the X-powers AXP20x driver while the i2c-mv64xxx.c driver does
> not support it.
>
> I am not familiar enough with this i2c controller to suggest a way to
> refactor it such that it would easily gain master_xfer_atomic support.
> Is this something you could look at?
>
> Thanks!
>
> [ 1617.999014] reboot: Power down
> [ 1618.002111] ------------[ cut here ]------------
> [ 1618.006752] WARNING: CPU: 0 PID: 2427 at drivers/i2c/i2c-core.h:41
> i2c_transfer+0x108/0x144
> [ 1618.015092] No atomic I2C transfer handler for 'i2c-0'
> [ 1618.020222] Modules linked in: pppoe ppp_async pppox ppp_generic slhc
> crc_ccitt cmac
> [ 1618.027987] CPU: 0 PID: 2427 Comm: procd Not tainted 5.5.0-rc5+ #0
> [ 1618.034158] Hardware name: Allwinner sun7i (A20) Family
> [ 1618.039376] Backtrace:
> [ 1618.041837] [<c0238488>] (dump_backtrace) from [<c0238710>]
> (show_stack+0x20/0x24)
> [ 1618.049400]  r7:00000029 r6:60000093 r5:00000000 r4:c10a197c
> [ 1618.055061] [<c02386f0>] (show_stack) from [<c096ae4c>]
> (dump_stack+0x9c/0xb0)
> [ 1618.062282] [<c096adb0>] (dump_stack) from [<c0252548>]
> (__warn+0xe0/0x108)
> [ 1618.069237]  r7:00000029 r6:00000009 r5:c075d948 r4:c0aefafc
> [ 1618.074895] [<c0252468>] (__warn) from [<c0252944>]
> (warn_slowpath_fmt+0x94/0x9c)
> [ 1618.082369]  r7:c075d948 r6:00000029 r5:c0aefafc r4:c0aefbc0
> [ 1618.088026] [<c02528b4>] (warn_slowpath_fmt) from [<c075d948>]
> (i2c_transfer+0x108/0x144)
> [ 1618.096195]  r8:00000032 r7:c10a93e4 r6:00000001 r5:ea32fd3c r4:ea945ca8
> [ 1618.102892] [<c075d840>] (i2c_transfer) from [<c075d9d0>]
> (i2c_transfer_buffer_flags+0x4c/0x5c)
> [ 1618.111579]  r6:eb3c6501 r5:00000001 r4:00000002
> [ 1618.116199] [<c075d984>] (i2c_transfer_buffer_flags) from
> [<c0675658>] (regmap_i2c_write+0x24/0x40)
> [ 1618.125229]  r4:00000002
> [ 1618.127768] [<c0675634>] (regmap_i2c_write) from [<c06703d8>]
> (_regmap_raw_write_impl+0x72c/0x908)
> [ 1618.136713]  r5:00000001 r4:ea8d9c00
> [ 1618.140291] [<c066fcac>] (_regmap_raw_write_impl) from [<c0670630>]
> (_regmap_bus_raw_write+0x7c/0xa0)
> [ 1618.149501]  r10:00000058 r9:ea32e000 r8:fee1dead r7:00000080
> r6:00000032 r5:c066be98
> [ 1618.157319]  r4:ea8d9c00
> [ 1618.159857] [<c06705b4>] (_regmap_bus_raw_write) from [<c066fa08>]
> (_regmap_write+0x7c/0x164)
> [ 1618.168371]  r7:ea8d9c00 r6:00000080 r5:00000032 r4:ea8d9c00
> [ 1618.174029] [<c066f98c>] (_regmap_write) from [<c0671294>]
> (regmap_write+0x4c/0x6c)
> [ 1618.181679]  r9:ea32e000 r8:fee1dead r7:0002e574 r6:00000080
> r5:00000032 r4:ea8d9c00
> [ 1618.189420] [<c0671248>] (regmap_write) from [<c067d0ac>]
> (axp20x_power_off+0x3c/0x48)
> [ 1618.197328]  r7:0002e574 r6:28121969 r5:c1004e90 r4:4321fedc
> [ 1618.202985] [<c067d070>] (axp20x_power_off) from [<c023605c>]
> (machine_power_off+0x34/0x38)
> [ 1618.211332] [<c0236028>] (machine_power_off) from [<c027850c>]
> (kernel_power_off+0x7c/0x80)
> [ 1618.219676] [<c0278490>] (kernel_power_off) from [<c02786a0>]
> (__do_sys_reboot+0x190/0x1f4)
> [ 1618.228019] [<c0278510>] (__do_sys_reboot) from [<c0278774>]
> (sys_reboot+0x18/0x1c)
> [ 1618.235669]  r8:c0201324 r7:00000058 r6:b6f69010 r5:becbbe2c r4:00000000
> [ 1618.242366] [<c027875c>] (sys_reboot) from [<c0201120>]
> (ret_fast_syscall+0x0/0x4c)
> [ 1618.250013] Exception stack(0xea32ffa8 to 0xea32fff0)
> [ 1618.255062] ffa0:                   00000000 becbbe2c fee1dead
> 28121969 4321fedc 0002e574
> [ 1618.263231] ffc0: 00000000 becbbe2c b6f69010 00000058 ffffffff
> 00000000 0000201d 00000001
> [ 1618.271398] ffe0: 0002de54 becbbd5c 0001ac8c b6f8e408
> [ 1618.276443] ---[ end trace 526da779414c6638 ]---

Is that on every reboot?

However, I'm not entirely sure how we could implement it without
sleeping. The controller is basically a state machine that triggers an
interrupt on each state change, so you first set the address, get an
interrupt, then set the direction, then you get an interrupt, etc.

I guess we could implement it using polling, but I'm not sure if
that's wise in an interrupt context either.

Maxime

--ri2cc3wayxbar2zz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXibHBwAKCRDj7w1vZxhR
xed3AQDW98W0fhDteKz/9jBs4zA1M/HReTMmE/nSSDc3j9xl4AEA2f79EAP6nRnf
qq8Yym9sFmc671FrxOQSpEBvO2L2nQE=
=oMXB
-----END PGP SIGNATURE-----

--ri2cc3wayxbar2zz--
