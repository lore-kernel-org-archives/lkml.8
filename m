Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA2DC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6F321897
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599544984;
	bh=mW67zDPy19xrTyXDGAMLyh553gQEFgf/Dow7ph9VSos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=SUT7o2odeAQnqP/5/cte1SgVB/7kw3+mBQX+NS4GS108iht/ZchXSMdpJoNhOURLK
	 yt9KJCa7WM1OXpbxcA1K66nguQ8s/g3+Pv5B3l3E7pGQhJgCL9Chi3QeZFZ+Q2ox4n
	 Ldir1y9HfuMVHqyy8iVVhqDZLO61cSfb86kGC7rE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgIHGDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbgIHGC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:02:59 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA0C12137B;
        Tue,  8 Sep 2020 06:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599544979;
        bh=mW67zDPy19xrTyXDGAMLyh553gQEFgf/Dow7ph9VSos=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=h/dnpTzqrDk6lp9WKT2V/5WQ3Zipd7dBVaNne1ma/9LlPVAEjm8YANsMKf1RiiBle
         QRWrGwMrlIX2aXlzK6NfPcQeEx/nSC1TPm6x5ombPpyeMjNo2wWfE8I1M5WSeLSH5M
         HSGEIXKvvKpH6JJQ7sonja5FYygCoZHp37GSNIKQ=
From:   Felipe Balbi <balbi@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] dwc3-of-simple: add support for Hikey 970
In-Reply-To: <83393769e4391d038c4ab69a67ac77e2ca34efd4.1599493845.git.mchehab+huawei@kernel.org>
References: <cover.1599493845.git.mchehab+huawei@kernel.org>
 <83393769e4391d038c4ab69a67ac77e2ca34efd4.1599493845.git.mchehab+huawei@kernel.org>
Date:   Tue, 08 Sep 2020 09:02:49 +0300
Message-ID: <87tuw8n6uu.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> This binding driver is needed for Hikey 970 to work,
> as otherwise a Serror is produced:
>
>     [    1.837458] SError Interrupt on CPU0, code 0xbf000002 -- SError
>     [    1.837462] CPU: 0 PID: 74 Comm: kworker/0:1 Not tainted 5.8.0+ #2=
05
>     [    1.837463] Hardware name: HiKey970 (DT)
>     [    1.837465] Workqueue: events deferred_probe_work_func
>     [    1.837467] pstate: 20000005 (nzCv daif -PAN -UAO BTYPE=3D--)
>     [    1.837468] pc : _raw_spin_unlock_irqrestore+0x18/0x50
>     [    1.837469] lr : regmap_unlock_spinlock+0x14/0x20
>     [    1.837470] sp : ffff8000124dba60
>     [    1.837471] x29: ffff8000124dba60 x28: 0000000000000000
>     [    1.837474] x27: ffff0001b7e854c8 x26: ffff80001204ea18
>     [    1.837476] x25: 0000000000000005 x24: ffff800011f918f8
>     [    1.837479] x23: ffff800011fbb588 x22: ffff0001b7e40e00
>     [    1.837481] x21: 0000000000000100 x20: 0000000000000000
>     [    1.837483] x19: ffff0001b767ec00 x18: 00000000ff10c000
>     [    1.837485] x17: 0000000000000002 x16: 0000b0740fdb9950
>     [    1.837488] x15: ffff8000116c1198 x14: ffffffffffffffff
>     [    1.837490] x13: 0000000000000030 x12: 0101010101010101
>     [    1.837493] x11: 0000000000000020 x10: ffff0001bf17d130
>     [    1.837495] x9 : 0000000000000000 x8 : ffff0001b6938080
>     [    1.837497] x7 : 0000000000000000 x6 : 000000000000003f
>     [    1.837500] x5 : 0000000000000000 x4 : 0000000000000000
>     [    1.837502] x3 : ffff80001096a880 x2 : 0000000000000000
>     [    1.837505] x1 : ffff0001b7e40e00 x0 : 0000000100000001
>     [    1.837507] Kernel panic - not syncing: Asynchronous SError Interr=
upt
>     [    1.837509] CPU: 0 PID: 74 Comm: kworker/0:1 Not tainted 5.8.0+ #2=
05
>     [    1.837510] Hardware name: HiKey970 (DT)
>     [    1.837511] Workqueue: events deferred_probe_work_func
>     [    1.837513] Call trace:
>     [    1.837514]  dump_backtrace+0x0/0x1e0
>     [    1.837515]  show_stack+0x18/0x24
>     [    1.837516]  dump_stack+0xc0/0x11c
>     [    1.837517]  panic+0x15c/0x324
>     [    1.837518]  nmi_panic+0x8c/0x90
>     [    1.837519]  arm64_serror_panic+0x78/0x84
>     [    1.837520]  do_serror+0x158/0x15c
>     [    1.837521]  el1_error+0x84/0x100
>     [    1.837522]  _raw_spin_unlock_irqrestore+0x18/0x50
>     [    1.837523]  regmap_write+0x58/0x80
>     [    1.837524]  hi3660_reset_deassert+0x28/0x34
>     [    1.837526]  reset_control_deassert+0x50/0x260
>     [    1.837527]  reset_control_deassert+0xf4/0x260
>     [    1.837528]  dwc3_probe+0x5dc/0xe6c
>     [    1.837529]  platform_drv_probe+0x54/0xb0
>     [    1.837530]  really_probe+0xe0/0x490
>     [    1.837531]  driver_probe_device+0xf4/0x160
>     [    1.837532]  __device_attach_driver+0x8c/0x114
>     [    1.837533]  bus_for_each_drv+0x78/0xcc
>     [    1.837534]  __device_attach+0x108/0x1a0
>     [    1.837535]  device_initial_probe+0x14/0x20
>     [    1.837537]  bus_probe_device+0x98/0xa0
>     [    1.837538]  deferred_probe_work_func+0x88/0xe0
>     [    1.837539]  process_one_work+0x1cc/0x350
>     [    1.837540]  worker_thread+0x2c0/0x470
>     [    1.837541]  kthread+0x154/0x160
>     [    1.837542]  ret_from_fork+0x10/0x30
>     [    1.837569] SMP: stopping secondary CPUs
>     [    1.837570] Kernel Offset: 0x1d0000 from 0xffff800010000000
>     [    1.837571] PHYS_OFFSET: 0x0
>     [    1.837572] CPU features: 0x240002,20882004
>     [    1.837573] Memory Limit: none
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

applied for v5.9-rc

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9XHokRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQYAKA//SJqujeOjKMno3JlLsTq/B4NUQ7Nqa++6
NxZYcbt2/umlpkf1tHUMldVCNl/vjFNmYp3zarlhd1iVeCuROaWGGEJ384QZ6nnt
moEsDsb0TPS7RSNBPjymtLtH7+fqFqg3GP5ZuMKhK5OPAKgwHGEGNBho8lQGlpo3
xrUQ83IkyK5hLmO6DMlcsiwXhgQHcJzzyREcl/NkYyp2Kd2Mm3dYcvJm4P0zptEq
zheHRWz02xRIuFL3MItsFFsZrloTDrd0K+apyoAiufw7bpyloZ3IasKQ9xjnygje
iEr/qkMVWvRTBWyZUyJnLVXhEOx9joOslvY9sqN3FJbym702xo7O/nxy8+2yvswp
y+9aQfqpPZp5KRKwBS5Ce/mtVcRzXJaJlDFlGS/FVw9ogFTKxND1wO9bCHROM/Ih
okNlkzG3zaxvOAPiRZ1dkxGdg2+jPo7dCs1wuJPwPRDW2oZL9XrtCGu+GIFuGhA6
K30EFUlmCz3bG72wU13CoMnsdemxiYPUHzL3Y0VsZYE+D2RU1amEDslZyJzzDeiP
pM/2AsqJ8ru6sOqtFQIQHruU487QemsVeg0bImWmjHl+Aw9hP+5Utnj4E2j0mv9I
Ak7G91hAv+uUSg2Fqeg2Yw1ogL/5QF1k642M2PIH+hmBXB6bKvKM8yCmaPGUOWpz
iQi/BDWB0ko=
=VUox
-----END PGP SIGNATURE-----
--=-=-=--
