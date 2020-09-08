Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26E4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7FAE21897
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599545399;
	bh=cbwWWZVrztgxZWhAchx9nUFgipYCruP9jrLcQ7v9QIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=VVn/1QeoAEiw3hDvS15BEci9gJXEGGvb62StOKY3qPuJdvNKwkCZeaao9Dz/U/Pbb
	 2ZfwKs1/PErr1e6WUJkrnLJsPxdMZq/QsDOneUCOCV5ahoEmZ5V9JM6ADyAtUgRouU
	 aPJjnbixkmklQt3inZ4y4SkBZGutTD7MZeJl4dbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgIHGJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgIHGJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:09:57 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7FEF2137B;
        Tue,  8 Sep 2020 06:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599545396;
        bh=cbwWWZVrztgxZWhAchx9nUFgipYCruP9jrLcQ7v9QIs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fB/Wf2iVNRZH3c8P8edyQCLJMVTpJsWnr04wOmtAkM5CuFvSgu1UdvXWrmX9DoX2y
         I3dPSG4JcUr3NcPJedVudZbDV4m3oNtvk272dfx6BCXqAeatnJXYavx0gJ9/56z6eW
         zoBrQ7th8dGZHoucA5Kttkq9fvTM3epC/Kmw79/I=
From:   Felipe Balbi <balbi@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        liuyu712@hisilicon.com, wanghu17@hisilicon.com,
        butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v6 04/13] usb: dwc3: Add splitdisable quirk for
 Hisilicon Kirin Soc
In-Reply-To: <20200907165000.7c42a6da@coco.lan>
References: <20190420064019.57522-1-chenyu56@huawei.com>
 <20190420064019.57522-5-chenyu56@huawei.com>
 <20200907150631.70e1bce0@coco.lan> <874ko9of80.fsf@kernel.org>
 <20200907165000.7c42a6da@coco.lan>
Date:   Tue, 08 Sep 2020 09:09:46 +0300
Message-ID: <87r1rcn6j9.fsf@kernel.org>
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
>> > I tested here, together with the Hikey 970 phy RFC patches I sent
>> > last week.
>> >
>> > Without this patch, the USB HID driver receives -EPROTO from
>> > submitted URBs, causing it to enter into an endless reset cycle
>> > on every 500 ms, at the hid_io_error() logic.=20=20
>>=20
>> > Tested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> >
>> > If you prefer, I can re-submit this one with my SOB.=20=20
>>=20
>> Please do, but since you're changing device tree, I need Rob's acked-by.
>
> Ok, I'll do that.

thanks

>> > Em Sat, 20 Apr 2019 14:40:10 +0800
>> > Yu Chen <chenyu56@huawei.com> escreveu:
>> >=20=20
>> >> SPLIT_BOUNDARY_DISABLE should be set for DesignWare USB3 DRD Core
>> >> of Hisilicon Kirin Soc when dwc3 core act as host.=20=20
>>=20
>> is this Kirin-specific or is this something that we should do a revision
>> check?=20
>
> I've no idea. I don't have any datasheets from this device.

I see

>> Why does it affect only Hikey kirin?=20
>
> As John Stultz didn't re-submit this one (and looking at the DT
> between Kirin 960 and 970 from the original Kernel 4.9 official
> drivers), I suspect that only Kirin 970 requires this quirk.
>
> It could well be due to some Dwc3 revision, but it could also be due
> to some differences at the USB part of the SoC, as there are a

the reason I ask is that if it's caused by dwc3 revision, then we don't
need the extra dt property, we can rely on a revision check. If it's
something that can't be detected in runtime, then we need a property.

> few other things different between hikey 960 and 970: it has a
> different PHY driver, and there are also some differences at the
> USB HUB which is connected into it.
>
> On both devices, the USB physical ports are actually connected
> into a HUB. In the case of Hikey 970, the hub seems to be a
> TI TUSB8041 4-Port Hub:
>=20=09
> 	$ lsusb
> 	Bus 002 Device 002: ID 0451:8140 Texas Instruments, Inc. TUSB8041 4-Port=
 Hub
> 	Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> 	Bus 001 Device 004: ID 090c:1000 Silicon Motion, Inc. - Taiwan (formerly=
 Feiya Technology Corp.) Flash Drive
> 	Bus 001 Device 003: ID 413c:301a Dell Computer Corp. Dell MS116 Optical =
Mouse
> 	Bus 001 Device 002: ID 0451:8142 Texas Instruments, Inc. TUSB8041 4-Port=
 Hub
> 	Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>
>> What's the dwc3 revision on
>> that SoC (grep SNPSID /sys/kernel/debugfs/*dwc3/regdump)?
>
> 	GSNPSID =3D 0x33313130

This isn't even listed as a known revision in dwc3/core.h. Thinh, could
the issue being described here caused by a known Erratum with this
particular revision?

>> >> +		reg =3D dwc3_readl(dwc->regs, DWC3_GUCTL3);
>> >> +		reg |=3D DWC3_GUCTL3_SPLITDISABLE;
>> >> +		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
>> >> +	}
>> >> +}
>> >> +#else
>> >> +#define dwc3_complete NULL
>> >>  #endif /* CONFIG_PM_SLEEP */
>> >>=20=20
>> >>  static const struct dev_pm_ops dwc3_dev_pm_ops =3D {
>> >>  	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
>> >> +	.complete =3D dwc3_complete,=20=20
>>=20
>> why is this done on complete? Why can't it be done at the end of
>> dwc3_resume()?
>
> Again, no idea. I didn't actually tried to suspend/resume.
>
> Maybe the original author can shed a light on it.

yeah, would be nice :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9XICoRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbqjg/+Nz3qyEteRV+PAFeR5rNbxxOQPDsAV+FO
sv1dxiF55jeVJJ+VY+EZ1+QmRAr+9ESjI+AE2RgFiRKZIKXjnsulbS6Q3nPPigvk
ymqMP+K/RrXrSrQ6+I+jRcfoPZRkbrYrSmlo78DEZzclPNMz9habgCWXv+BlUbu5
m5JEQDbMG7ruZ8tkXVOfYbNVHW06fckfuAB5kUzMdXyf4H2ABFXk8/1g+BbT1+Ti
uS6HoGety8QfVpKsgQd2LTUyTqVLSk4pP5sd9T4zn1wTpz0EYSgwnddwYj4GTYVQ
bCTmj5IIpoDwSiyj4AK6Wga5CEhR7RsLwQVjfEBFgWKFnNfvvYjSaihcUihaU7rH
ScTqceTDS3U43k2yApIBHxyJgkxPPec1EA7F9B5CfQwxi8isNYqgB7wQtVk4r+mI
fPA997nlSLxIsVRhAlv0/jeSgawOjSAh200ewlm9CBIIiHO1qjmDkhRoEsOVyIU5
+8B1lcKwAfNzS+IZLERsj2QUoezwk7wxh2nynxO7aHzVOCGurpa9t4Sdb2OJzBix
PRFQnhxmD6gdB3jnvM74kDHas+UkAer9AHK3WcR9kS8VpxUIm8Vb+9zM0oJYTA4D
rkB62QWR2gHktUE97m/fe3DCMbur3acopubrIW98EEippnEc8FoK9fsHLtFabXhH
ACJpamEPnZI=
=mVgw
-----END PGP SIGNATURE-----
--=-=-=--
