Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A62BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04ABF22D3E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="j1Y6eOK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgHERJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:09:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:41503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbgHEREv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596647056;
        bh=30nFNzwPxZmz9Y2oABIElubYun9r6VlJJIvIzFQZ2Xg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=j1Y6eOK4/meE5OlJuq7nV5/1tZQTDbIb0WAyuTnEV9W9352mCZM3HHaq831GiceSx
         fgLA0zs30eUwgj/z5EAxrGr9g97L+Ulxo1k83AHy0VNfGgt5sBKeIEwHFaXQzQv2bW
         1f8xJG600QmOvgSFHH6ezeOrOkMafkMRsbtLzx2I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.208.209.197] ([80.208.209.197]) by web-mail.gmx.net
 (3c-app-gmx-bap13.server.lan [172.19.172.83]) (via HTTP); Wed, 5 Aug 2020
 15:01:52 +0200
MIME-Version: 1.0
Message-ID: <trinity-9f86ac52-5249-44e7-b51d-1ee00850f544-1596632511956@3c-app-gmx-bap13>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        CK Hu <ck.hu@mediatek.com>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: [PATCH 2/3] arm: dts: mt7623: move MT7623N GPU to separate
 mt7623n.dtsi file
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 5 Aug 2020 15:01:52 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20200805113013.2763510-2-dwmw2@infradead.org>
References: <8ef96e4d02ef82e171409945ee6cc0348c4fe594.camel@infradead.org>
 <20200805113013.2763510-1-dwmw2@infradead.org>
 <20200805113013.2763510-2-dwmw2@infradead.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:G8MRnqoV1D2B0ErxKua+b90DZKS/NUdemUbrgGRwofr3Vs3wa3sLtGJLSaIjAmckjfQuY
 N2q+Z1WAU5keJxhmjgF2SFnKLAx/+ssSg5jG4hUSN4rhMAozwVfyIJHClWHwJMkftrm1YI9Hdl3N
 N2EZp25fXiSYSNd4CgWyeh3C56OTSnt6jPqOH91UQ3q3+VeqQ8/hSKikviDmaPX5zjuc+ZoBk88W
 vF8v75+g6PyEv8XnV1zeMlKR5e7LgiTjKKDbo3QbXbuY0GPdBBboJNcu7cnHK7c5hBWoJyu0lqbH
 o0=
X-UI-Out-Filterresults: notjunk:1;V03:K0:eGU+7LZ5Pbw=:Sko+N8vHSN+A2ehhghqC1j
 5MMHe1kmzGXDBBaX64keZASyrgU+qlX7o+JajiNRC6IRo9MZqvUkedHsVkSpGrYyojWGuNB5H
 9KX1Vczr5d3J9h3acYQQxadMgAe7EIh1s+76gXgbfOKinVAl6wBWexiuVdHHlLm/S0sbjyF9Z
 VCg3ZXCpzu6fmA31EjSdFKB2pcoLxliB/Q7NPN3eooHXsaGpXjApg57qAs/HMfESeQDYciWaj
 1UXePZmbm63g2L6/RZcFtdy6zOGcKiETn2s1FvAeli1kHSopIklGmblk7nQcKLjMajrjcOioG
 qfKDuin+bEuUmkjk4SXsLduH2DnX/+zEHre1Jesd+haC8kLTCV8+0Geripw13gnzPZ62bT6Dh
 Ed2rUps/JEPdMUhlja5BNgD62C8B3h2JUqowbeA4SaRKReeOVoAERR3HMfyi5WPouE5xhRptf
 RegBBdMk6+sDlsVu/hMMy2GrDgn/0Kei1XN+EM2Vf3JMpezFWZIxQ5CPMViCq0kJDpQo1hKVy
 PVCsWTlDGdOqvi+A2cXB31zpPAjkQ70+ArZJtecl8ubq7u0yzeuGfM7eX6oKM00njHW43ArRA
 GiHHCcgL8ITsw5cRGaoytN9wRwUhCjEXKYOSUfXL0F6iggOsgPH7w4MqxWCpNaTGH58tI1Ihz
 dpPIcjKdEbs7ykZdlqhL5i7kp+5L5wwL7znRsOMEXPWEMJnFC1v9bUxQ489+GPvW3DQA=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David

> Gesendet: Mittwoch, 05. August 2020 um 13:30 Uhr
> Von: "David Woodhouse" <dwmw2@infradead.org>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> The MT7623A doesn't have a GPU; add it only for MT7623N boards.
>
> Fixes: 1f6ed224594 ("arm: dts: mt7623: add Mali-450 device node")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dt=
si
> index 3a6b856e5b74..dcd2f5ba4e20 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -734,30 +734,6 @@ g3dsys: syscon@13000000 {
>  		#reset-cells =3D <1>;
>  	};
>
> -	mali: gpu@13040000 {
> -		compatible =3D "mediatek,mt7623-mali", "arm,mali-450";
...
> -		clocks =3D <&topckgen CLK_TOP_MMPLL>,
> -			 <&g3dsys CLK_G3DSYS_CORE>;
> -		clock-names =3D "bus", "core";
> -		power-domains =3D <&scpsys MT2701_POWER_DOMAIN_MFG>;
> -		resets =3D <&g3dsys MT2701_G3DSYS_CORE_RST>;
> -	};

i guess you should to move g3dsys too, and maybe the mmsys which is also d=
rm-related?

I can add this to my series, but before i change my series, i need advice =
from MTK/DT owners whats the preferred way ;)

regards Frank
