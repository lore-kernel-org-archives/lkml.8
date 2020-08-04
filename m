Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD52C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 404BE207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ashTFwDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgHDPjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:39:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:39193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbgHDPjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596555523;
        bh=KVIdFu4snYkr3f0Fmfu+cjnV5+Wi4qwOh8QwNS/ed8c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ashTFwDO+vcqxgOr36RVtsWHsXJJF443+1fukpwEObzeCAweNjSbUAzI41i+gk0qb
         Xzdu7DO1ExiCSJXwRHxM3Kk/IZ72sWE/dOXmfr4/5hAy150oJUrNAsU+2qHFqey/Wa
         fA3yDurcLYLtr1c1Eds8OOuFVgv+I1hRnyDo4rWs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.144.119] ([217.61.144.119]) by web-mail.gmx.net
 (3c-app-gmx-bap28.server.lan [172.19.172.98]) (via HTTP); Tue, 4 Aug 2020
 17:38:43 +0200
MIME-Version: 1.0
Message-ID: <trinity-387bb173-6a50-4227-bf3c-90401dbf77ad-1596555523067@3c-app-gmx-bap28>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        chunhui dai <chunhui.dai@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        CK Hu <ck.hu@mediatek.com>, Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Aw: Re: [PATCH v3 5/5] arm: dts: mt7623: add display subsystem
 related device nodes
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 4 Aug 2020 17:38:43 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAAOTY_9aDqz3muo6ynqX9r0VjW7tD5vvZOiQyR8UZOTUct8oVA@mail.gmail.com>
References: <20200804105849.70876-1-linux@fw-web.de>
 <20200804105849.70876-6-linux@fw-web.de>
 <CAAOTY_9aDqz3muo6ynqX9r0VjW7tD5vvZOiQyR8UZOTUct8oVA@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:AvRFvL6vHuGUQ5uZliiJaNJd4wt1NtazV/Qat3cVkfRNTmtJqvMDQKW9h9oDuBiDwO8Mn
 oi3RObTfOlRtNEXAyVHW2NweYjhXsSP30UIi6LJCUn5BjQhsIpG3/cN1ZFAPV/FIubTZT6SplmHU
 s5QEmlh5MhkmKG49LRBwwoJgH12ukqlazYcHIs1zvj13WAoYvMCm/GSEsMWaZMCh94kxHAz2BVP8
 /h4qsIzRszFNz6hkqNQqwICaX/HiDvg+sv31O06HNk842CYF8Gi5tNkKzwy+IUPgZWohVHLA/fS+
 z4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:yNX/tQxieYA=:BIuFsOgMQlg98Dfeok5Br6
 osXUJXBjbntsuBNNb3ofJFWKIfT1DbO93O1YCbpAemnlcFLL4EWjOEc6XY3uxMjNnKdBLg+Ai
 5+XRHi2BH1EsXm9bJdhzBbJaI/2uOKXeLBMnINw4SgEl3GYxYwIklN0zeOd9bI7s/DCboO/oy
 dptBuU7tmXyAas4ItU+c4e0ZHwDw3hlJCnXDPmkNhDG1Mi5v5JGA8eGDeNHMGQ6e+f6zCc0V1
 9jVk1G4brldrTsPn0uqoZIUkOwYG6YTYhA2xuw0ISWq42I0Hf5ugmGfiAiclVsVzsyYYl5tK/
 coGstICAYKRtHKmm/0fGNfbAedvsRNGsunnwb7+pboVtRNKpTgpBNXXbmtcxiZsAGzyLxM3pn
 DuupVksCKzDEOonkh3JZF03WMEmO/NQoxNcR4FLM/cNW/BXMVQxJ57opmoy8DCU7rnqSNhfJO
 DcjRjfJs88rSjnXgdR7yLtKIyFImhD/Qq8Vc3Mibb9APwkGRc0E6O4GPDxSQfJBTtX1S6+jxn
 TJHXE4LqumuSQxRY6lu+wJE7Lpbq5zyUFwQBd85bpJIBLUlSsjd1pO9xhN0svmJTeHvUzp292
 tWA5/bYlK/3KMd+72fwdDRJT7krem+2YP6l4mm1pU+3NYjsRO2n+vH9b/PHLRDLCC+smVLUTM
 Z2qoZ/TB457pRswiA7ISCPGYB02/HNbPgtP9fEM+OlYzqcnxcmyDPS6ZNSt3bSzdkGBY=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Dienstag, 04. August 2020 um 17:00 Uhr
> Von: "Chun-Kuang Hu" <chunkuang.hu@kernel.org>

> > +       display_components: dispsys@14000000 {
> > +               compatible =3D "mediatek,mt7623-mmsys",
> > +                            "mediatek,mt2701-mmsys";
>
> In mediatek,mmsys.txt [3], this should be:
>
> mmsys: syscon@14000000 {
>         compatible =3D "mediatek,mt7623-mmsys", "mediatek,mt2701-mmsys",=
 "syscon"
>
> [3] https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/med=
iatek/mediatek%2Cmmsys.txt

oh i see i can drop this because there is already a mmsys-node with the co=
mpatibles from documentation.
only powerdomain is missing, but this seems not be needed (hdmi works with=
out this "display_components" node)...

    mmsys: syscon@14000000 {
        compatible =3D "mediatek,mt7623-mmsys",
                 "mediatek,mt2701-mmsys",
                 "syscon";
        reg =3D <0 0x14000000 0 0x1000>;
        #clock-cells =3D <1>;
    };

    display_components: dispsys@14000000 {
        compatible =3D "mediatek,mt7623-mmsys",
                 "mediatek,mt2701-mmsys";
        reg =3D <0 0x14000000 0 0x1000>;
        power-domains =3D <&scpsys MT2701_POWER_DOMAIN_DISP>;
    };
