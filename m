Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52237C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3619C2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jdQcRDLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgGCSts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 14:49:48 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:11615 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGCStr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 14:49:47 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200703184944epoutp0275e227a5b0d3186d110d3a03cde9aae1~eUqSMZ9j20590705907epoutp02X
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 18:49:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200703184944epoutp0275e227a5b0d3186d110d3a03cde9aae1~eUqSMZ9j20590705907epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593802184;
        bh=R/QspwPcwTy8FD/R5OyWGoExl65xc0UtVxww1SbMj0U=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=jdQcRDLSIITKll+HW4n8IuxZdlPIu22VJjUUXmu7saHlqlzzGjOOQV6ZiqCkkniOa
         cgMECNggLCXqSMMRasLav7kfS6VVVgnM/PJpsq3QlJU8SBDDbtXS6jnjC7GrBgBoee
         MD1CxxU0jcBn5bw5WlRxZMbe619XhwaRrUKOwlvU=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200703184944epcas5p29e1ac21d7ba6c55f0e4faff8ff79abcb~eUqRjYoFN2110721107epcas5p24;
        Fri,  3 Jul 2020 18:49:44 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.1E.09475.7CD7FFE5; Sat,  4 Jul 2020 03:49:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200703184943epcas5p18c6c8114235077e065cb5898223423cf~eUqRHkB_q1451014510epcas5p1K;
        Fri,  3 Jul 2020 18:49:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200703184943epsmtrp15beb227d83760b227b6e5c277c1efefd~eUqRGtjTn2628126281epsmtrp1D;
        Fri,  3 Jul 2020 18:49:43 +0000 (GMT)
X-AuditID: b6c32a4b-389ff70000002503-78-5eff7dc7adfb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.06.08382.7CD7FFE5; Sat,  4 Jul 2020 03:49:43 +0900 (KST)
Received: from alimakhtar02 (unknown [107.108.234.165]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200703184941epsmtip111e2c65980af1da4e171ddceb6d43254~eUqPbwGVT1729017290epsmtip1Q;
        Fri,  3 Jul 2020 18:49:41 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     <krzk@kernel.org>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>
In-Reply-To: <20200703182536.9190-1-alim.akhtar@samsung.com>
Subject: RE: [PATCH] arm64: dts: exynos: Add minimal bootargs
Date:   Sat, 4 Jul 2020 00:19:40 +0530
Message-ID: <000801d6516a$b6efcb40$24cf61c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGPHXmhEFcAzbys4lSarlYwjg0bbAE59K/yqXrKW6A=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZdlhTQ/dE7f84g7u3mCzmHznHanH+/AZ2
        i02Pr7FaXN41h81ixvl9TBate4+wO7B5bFrVyeaxeUm9x+dNcgHMUVw2Kak5mWWpRfp2CVwZ
        L75OYi04x1Ux++ofxgbGTs4uRk4OCQETiYvLn7F2MXJxCAnsZpTY+OwPO4TziVHicOsjNgjn
        G6PEj2mbmbsYOcBa2nZCFe1llJiy6QMzhPOGUeL4tYOMIHPZBHQldixuYwNpEBEQlVh1XgCk
        hllgOaPErd83WEBqOAVsJA4vOcgMYgsL2Ep8n7oVrJ5FQEViYaMCSJhXwFLi79dtrBC2oMTJ
        mU/AWpkFtCWWLXzNDPGCgsTPp8vAakQErCTWnTrOBlEjLnH0Zw/YbRICP9klNuz6zgbR4CLx
        b98kVghbWOLV8S3sELaUxMv+NnaIJ7MlenYZQ4RrJJbOO8YCYdtLHLgyhwWkhFlAU2L9Ln2I
        VXwSvb+fMEF08kp0tAlBVKtKNL+7CtUpLTGxuxtqqYfEnruP2CcwKs5C8tgsJI/NQvLALIRl
        CxhZVjFKphYU56anFpsWGOellusVJ+YWl+al6yXn525iBKcYLe8djI8efNA7xMjEwXiIUYKD
        WUmEN0H1X5wQb0piZVVqUX58UWlOavEhRmkOFiVxXqUfZ+KEBNITS1KzU1MLUotgskwcnFIN
        TKmTHG4XO0mwf1pxtdVC1yu3sXCz2Tt/xbWb4+eu+pO64cjENqEUm5S/2u66mzbNCepye6tk
        pnSde1LPz+5MhvhTrZIp710XWIq7ssu57zjz7+lLz+1SFTanf5cV3nI8uaLbc0qszo69pmKF
        v4/Yl2+Sy9l/jPdiF/+e1WU5dR+fZv758SzRJdAvKtcwX3txiLE2gwtXeccMZwGf5Tv9vOtk
        lWuLnmyt3L7m38aCxEsPJe9+mHM6l7f0S++Se1HnpeQWbqra+5Rr3d1fxUf2aCrsXnJ9Rb7Z
        q53BS1PkX3FP3bX30bN5jGbrLc6eOZMVsyfM4sO/jWUGVZJeSxm+y78vfvde4Itp+BG2aZXf
        TiuxFGckGmoxFxUnAgA1GYNGoAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnO7x2v9xBk/2K1jMP3KO1eL8+Q3s
        FpseX2O1uLxrDpvFjPP7mCxa9x5hd2Dz2LSqk81j85J6j8+b5AKYo7hsUlJzMstSi/TtErgy
        Vh8tK1jEVXFjRwt7A+Ndji5GDg4JAROJtp3sXYxcHEICuxklXvWvAXI4geLSEtc3ToCyhSVW
        /nsOVfSKUeJz7xmwBJuArsSOxW1sIINEBEQlVp0XAKlhFljNKPH33h5miIZeRolzZz6zgDRw
        CthIHF5ykBnEFhawlfg+dStYM4uAisTCRgWQMK+ApcTfr9tYIWxBiZMzn4C1MgtoSzy9+RTO
        XrbwNTPEcQoSP58uA6sXEbCSWHfqOBtEjbjE0Z89zBMYhWchGTULyahZSEbNQtKygJFlFaNk
        akFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcKxoae5g3L7qg94hRiYOxkOMEhzMSiK8Car/
        4oR4UxIrq1KL8uOLSnNSiw8xSnOwKInz3ihcGCckkJ5YkpqdmlqQWgSTZeLglGpg2ifvoKa/
        h0e6N2THmnnzTiyzOM7Ac++HvntHgeRWk9rETu7N6xjmqlh9zH3C+bTU95vz49tvtisIlTZz
        rxV7mRz9/VGXWk7j154DsoK8avLdUUoOdkuL3wkFH9jZv6bU8trDI9NU7sU3T3l7v5HjddUv
        nYvvvKVOb96y99SkiW+Xu7l/yT669Hfynf1iPYrPvQv6JD+y7HRSO/c1m+H0+1OzJLu3Chf8
        fuMkZPol3t3+XuCkRyFrLmbnKxzvkbxdo31hgy+PwNyDppoZWW6/8uee/8t79cnLL7sYG7eZ
        VP9dsflFj8jpDQXqJYV7XktvYY/UfMCj5el64M6Fpy0b/6w7vd84qLMl0e210+akfUosxRmJ
        hlrMRcWJAFXNoRoEAwAA
X-CMS-MailID: 20200703184943epcas5p18c6c8114235077e065cb5898223423cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200703184543epcas5p4adb3db7693094c72477b8469d9f205ba
References: <CGME20200703184543epcas5p4adb3db7693094c72477b8469d9f205ba@epcas5p4.samsung.com>
        <20200703182536.9190-1-alim.akhtar@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Krzysztof's correct email address.
Sorry about noise.

> -----Original Message-----
> From: Alim Akhtar <alim.akhtar=40samsung.com>
> Sent: 03 July 2020 23:56
> To: rzk=40kernel.org
> Cc: devicetree=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org;=
 linux-
> samsung-soc=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> robh+dt=40kernel.org; Alim Akhtar <alim.akhtar=40samsung.com>
> Subject: =5BPATCH=5D arm64: dts: exynos: Add minimal bootargs
>=20
> Add minimal bootargs to enable earlycon and console.
> This really useful in case kernel has crashed early in boot process.
>=20
> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts =7C 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> index 790f12ca8981..d7b42d5a3b2d 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> =40=40 -24,6 +24,7 =40=40
>=20
>  	chosen =7B
>  		stdout-path =3D &serial_2;
> +		bootargs =3D =22earlycon=3Dexynos4210,0x14c30000
> console=3DttySAC0,115200n8=22;
>  	=7D;
>=20
>  	memory=4040000000 =7B
>=20
> base-commit: 9e50b94b3eb0d859a2586b5a40d7fd6e5afd9210
> --
> 2.17.1


