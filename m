Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D337FC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BF02078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599559344;
	bh=4r+Hu0vdZMeQ6ZFgpHqfRRAFAJ+D3s2S7DDEgGuBBlM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=k2vgRj/iCepjaIA7bn/fa7EQmR9WXefjm+jl3OMyfZP0KsDpOW4COB7RYRxoZuLlg
	 oMadWgVyMKP3wfYmObrzxDSsHbo4tnEX5DfQfVkz8FtR/wvDUStGna2rq9oQrVydpw
	 APOT9hGaaXFLeDGyulghhFZ6hgnz/MNLiSft/cSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgIHKCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728828AbgIHKCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:02:18 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B6022078B;
        Tue,  8 Sep 2020 10:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599559337;
        bh=4r+Hu0vdZMeQ6ZFgpHqfRRAFAJ+D3s2S7DDEgGuBBlM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HZk2UegX5x3An10sphFGj3Rbju5X08wpq0NLtfYaa73SA7YU4GSjbCaWG1SuENFXs
         MhVdi9W/AQafGeMC5XXQOrjPIt2SPm34EbfsTVHvmgHbYU9C7q5lAVqb9qbV04Z/T4
         7zZlSFPpIuaUEot56ZyqooIBrNtRSHElnJTamUM4=
From:   Felipe Balbi <balbi@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dwc3-of-simple: add support for Hikey 970
In-Reply-To: <731e13f9fbba3a81bedb39f1c1deaf41200acd0c.1599559004.git.mchehab+huawei@kernel.org>
References: <731e13f9fbba3a81bedb39f1c1deaf41200acd0c.1599559004.git.mchehab+huawei@kernel.org>
Date:   Tue, 08 Sep 2020 13:02:09 +0300
Message-ID: <87k0x4lh7i.fsf@kernel.org>
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

you mentioned Serror doesn't happen anymore...

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

is this splat still valid? I can edit commit while applying, just let me
know if I should remove this.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9XVqERHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbHvQ/8CPKhQXi69qrY9i4D1fA7+KdpAxntG/u3
VMchOWrzrl2+Xqj1EfZ95ZZb6Vz+LJGl0bwnyTrkk/lDqxn4KaWcMI9FICEKOLBg
1u08ZoVrBzriOR/fqlKobX9/XbJWtNdfHtvZBMhyhj6FcY7+wWOqDY33YhD7ohxt
kVOIlDlGFPugoTkxS+1EjErQ5jJG0AqapR9VkMA70lSG7aOjGAtG4wi3T5FGss4J
1SQBaxg8MsC6fVP/aPT+zoFQcSmFbFLkbXHD8o0UsxAo4QCCPP8eevjYYS2IaGHH
hREmgsAucPjUvvcd9sEVqDjpz1Wl5fZNsAJpcVxI24MQP6pUGz6vXVsC4v2o8ItF
EwCgmsOtwd21d2Z5OUill5XhJYXwLfx9EouVTfEhtZnaouK6yLqjH7REYBkxI6MG
73oZe141XJILnbJC8iKD6KJt55uQreDQcgdiTpmRUAdrTl9gzznfmQNVOt0FcZsh
z8RU55L1NXsjj3m1s3S/kGGDaf3D5u/tjmY+gNeRBO2BpSaEkvwXx3WUKs6FRHcG
wDJ05dIXD7lQBoP+UFfPFMYo6b8Se0igpNS7R6UWPw4+5Q3nws1edwXBQqKAbJ9j
1hbuprtJTo0zdS9tMANTE+eazc1Ik3ELoMUtR/6v2+/J5gm8E0ilnenS48FCSLhd
DOI21xGJcKM=
=s/wl
-----END PGP SIGNATURE-----
--=-=-=--
