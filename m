Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043C0C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D74E6216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/n/PE8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgEAQKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEAQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:10:22 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A21CC061A0C;
        Fri,  1 May 2020 09:10:21 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t12so4857047ile.9;
        Fri, 01 May 2020 09:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DegXdIet2b3uX8GSVrSI8KoyXiaxanbxBIa5N8IqYXU=;
        b=q/n/PE8Pno3XGS2iraJbkhoAMFS5b7SRmXX+JxzSyDKYrPTHHa1J1ZJM9H4rr/b68f
         h9MU6+7hrRg01D7id1+xtP9Av47i26V9LSdo9AZcPWey2N6z+/+B8U0pSwr8BElRPH5Y
         sHKI8KDnh+ffNCheUE1TM5+CZnnl/Wa4XqNHPutbpWOvPBiUWAjDZEsf55C7g5ZyX56P
         xA/mz5SfYZNLTiLY/ZjFfkNUcdQp8YTRCsKw78GbCz/R8Zcz1E9I5zaB6DGdt0mHsu9M
         hxM+3fno8Q+Cc6NBXvMu/B9NBzzTKueBjtVZsggo+Sqlaiy7CsVoegZRlvXOdJSR7EbP
         vVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=DegXdIet2b3uX8GSVrSI8KoyXiaxanbxBIa5N8IqYXU=;
        b=OilrEqFe21Ehj4P9ks/9lbepYNJZzBI53cNFyzXGH3ZJKMUp8+jwJW2cvARyaf2gTl
         bMSnFKAu7/jHYOa03BWjBQYb6FSN/S5fJoLvEa1skV6tdpwORZRzypoM3jqDkV+rD8Ed
         b6RbnwKWmKIOcK2TSQuU1JHokCKEPdujDsXAjjPmi2ZPl+cy3RBcmFRokqC5DqK+BGXy
         eOXtkIHpgi6Xi8qOVcwRlZwdxsLe9VcS0v9mGICZm0yn3Y2kSvpt0dJt2NcQHvr1NIa3
         jtECYA0acNdl777D+fPvSR6i++aY4luOs0XB2zTRKhlDo1ghppqWtz0OO6uiAt9iiKAq
         sGcg==
X-Gm-Message-State: AGi0PuZfU0bzLLCz2tausNAGbiyogC8IF+O37RgTh7REJSkGmXR2uTWG
        cjGv0X5CswEGIWdZv9/8Pr41hNyj4zxGU+/pDjA=
X-Google-Smtp-Source: APiQypK6yA5MKN0z9uIfc44vJiUhjDoDY9tPJZAn5r+n8DzkVBGv2LC+DqAq1GW+o172geijZU4d5a0lxsFt8Z26kgc=
X-Received: by 2002:a92:3c56:: with SMTP id j83mr3859096ila.37.1588349419659;
 Fri, 01 May 2020 09:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <752db40d-5aed-4a97-a050-bc1376547f87@xilinx.com> <20200428100350.12699-1-matwey@sai.msu.ru>
In-Reply-To: <20200428100350.12699-1-matwey@sai.msu.ru>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Fri, 1 May 2020 19:10:08 +0300
Message-ID: <CAJs94Eb0k-Yf7FrOJwyusBqnYvnxsbD=2vxybbSAvLg0ZJ210w@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: zynq: Fix ethernet PHY for v5 schematics
To:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ZYNQ ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Anton Gerasimov <tossel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

I hope you are doing good. Could you please check this patch, since
you are initial author of zynq-zturn.dts and I suppose you do have the
"v4" board variant to test.

=D0=B2=D1=82, 28 =D0=B0=D0=BF=D1=80. 2020 =D0=B3. =D0=B2 13:04, Matwey V. K=
ornilov <matwey@sai.msu.ru>:
>
> There are at least two different versions existing for MYIR Zturn:
>
>  * v4 schematics has Atheros AR8035 PHY at 0b000
>      http://www.myirtech.com/download/Zynq7000/Z-TURNBOARD_schematic.pdf
>  * v5 schematics has Micrel KSZ9031 PHY at 0b011
>      v5 schematics available at DVD disk supplied with the board
>
> Specify both PHYs to make ethernet interface working for any board
> revision. This commit relies on of_mdiobus_register() behavior.
> When phy-handle is missed, every nested PHY node is considered,
> while ENODEVs are ignored.
>
> Before the patch:
>
> [   28.295002] macb e000b000.ethernet eth0: Could not attach PHY (-19)
>
> After the patch:
>
> [   28.257365] macb e000b000.ethernet eth0: PHY [e000b000.ethernet-ffffff=
ff:00] driver [Micrel KSZ9031 Gigabit PHY] (irq=3DPOLL)
> [   28.257384] macb e000b000.ethernet eth0: configuring for phy/rgmii-id =
link mode
>
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>

Cc: Anton Gerasimov <tossel@gmail.com>

> ---
> Changes since v1:
>  - reworded commit message
>
>  arch/arm/boot/dts/zynq-zturn.dts | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/zynq-zturn.dts b/arch/arm/boot/dts/zynq-zt=
urn.dts
> index 5ec616ebca08..07da9cf60d02 100644
> --- a/arch/arm/boot/dts/zynq-zturn.dts
> +++ b/arch/arm/boot/dts/zynq-zturn.dts
> @@ -67,10 +67,17 @@
>  &gem0 {
>         status =3D "okay";
>         phy-mode =3D "rgmii-id";
> -       phy-handle =3D <&ethernet_phy>;
>
> -       ethernet_phy: ethernet-phy@0 {
> -               reg =3D <0x0>;
> +       ethernet-phy@0 {
> +               compatible =3D "ethernet-phy-ieee802.3-c22";
> +               reg =3D <0>;
> +               max-speed =3D <1000>;
> +       };
> +
> +       ethernet-phy@3 {
> +               compatible =3D "ethernet-phy-ieee802.3-c22";
> +               reg =3D <3>;
> +               max-speed =3D <1000>;
>         };
>  };
>
> --
> 2.16.4
>


--=20
With best regards,
Matwey V. Kornilov
