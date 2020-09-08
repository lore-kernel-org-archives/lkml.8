Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B963C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCC0221F1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599568349;
	bh=Ykug4tlZvn0QcDm5UxH6t/c3Mp72WB/jwbZTgq++YCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=ItbA5ubunMfXtugFBb/ZIVMo5XKLCK+5vC0it4m1WpSrm3RrffSCs97JJMme+/2KE
	 oSHqZPZyg0ro2UG1Xatvy9Hh3s7JBS1pNMBM8SYvd9cDx/kQsAxLg3Pm01uFostccq
	 7Nk62P5NfEe7aH6tjAT372OtrLXp2M6lV9dr9dZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbgIHMcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 08:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729422AbgIHLwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:52:10 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32B062087D;
        Tue,  8 Sep 2020 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599565849;
        bh=Ykug4tlZvn0QcDm5UxH6t/c3Mp72WB/jwbZTgq++YCg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=An44oiu7XgXeHdNuYhzwlWOOWDTqUAzhOL+QhselabNvsnlIjLwpbfM6Kvylxvzm/
         FxUuSbteymwSpzR4zY0nnJIIKXEhO6jCDryKnoBnzME6Ro6nyNaYrwB52VeQinIikm
         6yvayXQTph7HNuT3KXgHVg90xGwoBK+rlWZ0OWqo=
From:   Felipe Balbi <balbi@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dwc3-of-simple: add support for Hikey 970
In-Reply-To: <20200908122311.55346806@coco.lan>
References: <731e13f9fbba3a81bedb39f1c1deaf41200acd0c.1599559004.git.mchehab+huawei@kernel.org>
 <87k0x4lh7i.fsf@kernel.org> <20200908122311.55346806@coco.lan>
Date:   Tue, 08 Sep 2020 14:50:41 +0300
Message-ID: <87h7s8lc6m.fsf@kernel.org>
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
>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>> > This binding driver is needed for Hikey 970 to work,
>> > as otherwise a Serror is produced:=20=20
>>=20
>> you mentioned Serror doesn't happen anymore...
>>=20
>> >     [    1.837458] SError Interrupt on CPU0, code 0xbf000002 -- SError
>> >     [    1.837462] CPU: 0 PID: 74 Comm: kworker/0:1 Not tainted 5.8.0+=
 #205
>> >     [    1.837463] Hardware name: HiKey970 (DT)
>> >     [    1.837465] Workqueue: events deferred_probe_work_func
>> >     [    1.837467] pstate: 20000005 (nzCv daif -PAN -UAO BTYPE=3D--)
>> >     [    1.837468] pc : _raw_spin_unlock_irqrestore+0x18/0x50
>> >     [    1.837469] lr : regmap_unlock_spinlock+0x14/0x20
>> >     [    1.837470] sp : ffff8000124dba60
>> >     [    1.837471] x29: ffff8000124dba60 x28: 0000000000000000
>> >     [    1.837474] x27: ffff0001b7e854c8 x26: ffff80001204ea18
>> >     [    1.837476] x25: 0000000000000005 x24: ffff800011f918f8
>> >     [    1.837479] x23: ffff800011fbb588 x22: ffff0001b7e40e00
>> >     [    1.837481] x21: 0000000000000100 x20: 0000000000000000
>> >     [    1.837483] x19: ffff0001b767ec00 x18: 00000000ff10c000
>> >     [    1.837485] x17: 0000000000000002 x16: 0000b0740fdb9950
>> >     [    1.837488] x15: ffff8000116c1198 x14: ffffffffffffffff
>> >     [    1.837490] x13: 0000000000000030 x12: 0101010101010101
>> >     [    1.837493] x11: 0000000000000020 x10: ffff0001bf17d130
>> >     [    1.837495] x9 : 0000000000000000 x8 : ffff0001b6938080
>> >     [    1.837497] x7 : 0000000000000000 x6 : 000000000000003f
>> >     [    1.837500] x5 : 0000000000000000 x4 : 0000000000000000
>> >     [    1.837502] x3 : ffff80001096a880 x2 : 0000000000000000
>> >     [    1.837505] x1 : ffff0001b7e40e00 x0 : 0000000100000001
>> >     [    1.837507] Kernel panic - not syncing: Asynchronous SError Int=
errupt
>> >     [    1.837509] CPU: 0 PID: 74 Comm: kworker/0:1 Not tainted 5.8.0+=
 #205
>> >     [    1.837510] Hardware name: HiKey970 (DT)
>> >     [    1.837511] Workqueue: events deferred_probe_work_func
>> >     [    1.837513] Call trace:
>> >     [    1.837514]  dump_backtrace+0x0/0x1e0
>> >     [    1.837515]  show_stack+0x18/0x24
>> >     [    1.837516]  dump_stack+0xc0/0x11c
>> >     [    1.837517]  panic+0x15c/0x324
>> >     [    1.837518]  nmi_panic+0x8c/0x90
>> >     [    1.837519]  arm64_serror_panic+0x78/0x84
>> >     [    1.837520]  do_serror+0x158/0x15c
>> >     [    1.837521]  el1_error+0x84/0x100
>> >     [    1.837522]  _raw_spin_unlock_irqrestore+0x18/0x50
>> >     [    1.837523]  regmap_write+0x58/0x80
>> >     [    1.837524]  hi3660_reset_deassert+0x28/0x34
>> >     [    1.837526]  reset_control_deassert+0x50/0x260
>> >     [    1.837527]  reset_control_deassert+0xf4/0x260
>> >     [    1.837528]  dwc3_probe+0x5dc/0xe6c
>> >     [    1.837529]  platform_drv_probe+0x54/0xb0
>> >     [    1.837530]  really_probe+0xe0/0x490
>> >     [    1.837531]  driver_probe_device+0xf4/0x160
>> >     [    1.837532]  __device_attach_driver+0x8c/0x114
>> >     [    1.837533]  bus_for_each_drv+0x78/0xcc
>> >     [    1.837534]  __device_attach+0x108/0x1a0
>> >     [    1.837535]  device_initial_probe+0x14/0x20
>> >     [    1.837537]  bus_probe_device+0x98/0xa0
>> >     [    1.837538]  deferred_probe_work_func+0x88/0xe0
>> >     [    1.837539]  process_one_work+0x1cc/0x350
>> >     [    1.837540]  worker_thread+0x2c0/0x470
>> >     [    1.837541]  kthread+0x154/0x160
>> >     [    1.837542]  ret_from_fork+0x10/0x30
>> >     [    1.837569] SMP: stopping secondary CPUs
>> >     [    1.837570] Kernel Offset: 0x1d0000 from 0xffff800010000000
>> >     [    1.837571] PHYS_OFFSET: 0x0
>> >     [    1.837572] CPU features: 0x240002,20882004
>> >     [    1.837573] Memory Limit: none=20=20
>>=20
>> is this splat still valid?=20
>
> What I tried to say, is that, if the dwc3 is described this way at the
> DT bindings:
>
>
>     / {
> 	dwc3: dwc3@ff100000 {
> 		compatible =3D "snps,dwc3";
> 		reg =3D <0x0 0xff100000 0x0 0x100000>;
> 		clocks =3D <&crg_ctrl HI3670_CLK_GATE_ABB_USB>,
>                          <&crg_ctrl HI3670_HCLK_GATE_USB3OTG>,
>                          <&crg_ctrl HI3670_CLK_GATE_USB3OTG_REF>,
>                          <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
>     ...
>
> The panic occurs, with the logs posted at the patch.
>
> The fix is to use dwc3-of-simple to initialize the clocks earlier,
> e. g., using this binding:
>
>     / {
> 	usb3: hisi_dwc3 {
> 		compatible =3D "hisilicon,kirin970-dwc3";
> 		#address-cells =3D <2>;
> 		#size-cells =3D <2>;
> 		ranges;
>=20=20
> 		clocks =3D <&crg_ctrl HI3670_CLK_GATE_ABB_USB>,
>                          <&crg_ctrl HI3670_HCLK_GATE_USB3OTG>,
>                          <&crg_ctrl HI3670_CLK_GATE_USB3OTG_REF>,
>                          <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
>
>
> 		dwc3: dwc3@ff100000 {
> 				compatible =3D "snps,dwc3";
> 				teg =3D <0x0 0xff100000 0x0 0x100000>;
>     ...

now it's clear, I'll apply as is :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9XcBERHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQanlA/6AviME0f13AQ7e8+04/8997iPxEbRBND5
YA4b6MGoDrp7NiDbwrfLaSAF46HBEUI70jJGZxt0DeY6Qp081nusCZ4WOzxpqkJJ
2TJLfqpALYpbZ+KLAZ9hvjDkwqvwDVt5+/CxpfcaEL3UtKb5/cMBrjcMOpW20eq0
bRSYq97rjsd/cbn+MyoCcqYQ4QgJgZFXcq4MccYmwFlGT7XCfY4Jez33jQ3uMkY4
GG8hUUCfSpBl2mxYhX+Y6i+XTozCna9Xz7lDLbx3dLGMIpO648AHUACXc8XKnVlk
UAtQaCaqCM6U2OUTBgyjK8JAM8I89iF90aK6SqlBq0ciP0roLl1p8JajNiVIrJfM
xsHn2j+l39oPVCkWToeb7PKK0+bZLGOtfu4QyOHZW3ahN6mOj5xPhgpQ2pLdjJSl
Vqh5oI92muIiWVneLPLKYgzLtTfVFMJ4uefrLLK5cA+O2de/KHC0ZPtK2P4gv1xt
Tt7omnabnZKlEEimN/MxFggHt0oTGy/ML3H92PhdjKC5T6BiwRlkvdrUyvyWgd+u
OXzMZCiHMwa1qAT6daNBUx144fz9kGfvbqDPHt7lkVIyAPwcEbn/RoJwjEjX6HtM
ReoCk/WuHyPjqkwSQEHLUurleF78z/kqMFmtb2qYVmLjg9SXHKsQblhuFIDbwH+N
JRjSrCTCJ24=
=fZWs
-----END PGP SIGNATURE-----
--=-=-=--
