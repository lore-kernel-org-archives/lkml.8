Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58186C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A3620767
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgICM1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 08:27:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35156 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbgICMZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:25:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id i4so2526229ota.2;
        Thu, 03 Sep 2020 05:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoH8otJKneHhR+opHL4Qe3/H5myYYwGysCvobqpQrFU=;
        b=qNuPrdImKETtHEhctvhPOLQv3LzCc1JEWOBIulpHGKUcGGBbTaadJ5kJT0HrJVkeQL
         RM4iLwqrLubl33Q5LTHZYEh3sPVKS1DvfJpL1MTvrK/6ZF99xitJy3rrtC+NgPKCcz6I
         SUcHDNWIXE2Cj6KWNx6PfuWaTkPRrASdtPmJPQRAuTvC8u8MF5Tsuuo8iWW+CcqMPIil
         aKUOP1z8yIhM9av/R9dj6LDSV0bCLorNoC84vMqufqCPV6u3gDR1tdbdE3ZY4PzdGrTR
         qXCq+5/oEfnzCTtQl/SQKaqeIS+VA0wJVrG+gr5O6E0s0nlqYtPKgZrk/add/yhcHd37
         N2gQ==
X-Gm-Message-State: AOAM531SThgdb9mwXJ/39HtCR+9cMifM6jzAuLG5BFSMQsDYLlpVFIzU
        31cYS4tQDe9cd1uxtjOQfp5fUvlvnsrGpLLnRQt9d90JplY=
X-Google-Smtp-Source: ABdhPJx6avH3C2TKsyCvh/3I9dhPX40IElmyXMkGAOAO9ix8cDNZKHbE66NR+61my3IRjdnIpw+n+bSrWEBHgpegwSk=
X-Received: by 2002:a9d:1b62:: with SMTP id l89mr1331699otl.145.1599135265698;
 Thu, 03 Sep 2020 05:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200825162718.5838-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200825162718.5838-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200825162718.5838-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Sep 2020 14:14:14 +0200
Message-ID: <CAMuHMdUbxtb+Yg=3dgRXWXn2k2tGYcmVzbS-n6rLM0QAJrfo-A@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: dts: r8a7742-iwg21d-q7: Add can0 support to
 carrier board
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Tue, Aug 25, 2020 at 6:28 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> This patch enables CAN0 interface exposed through connector J20 on the
> carrier board.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>

According to my schematics, the CAN port on J20 has its signals named
CAN0_[RT]XD on the carrier board, but connected to CAN1[RT]X (GP4_[67])
on the SoM.

Or am I looking at the wrong file?

> --- a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
> +++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
> @@ -198,6 +198,13 @@
>         };
>  };
>
> +&can0 {

can1

> +       pinctrl-0 = <&can0_pins>;

can1_pins

> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +};
> +
>  &cmt0 {
>         status = "okay";
>  };

> @@ -287,6 +303,11 @@
>                 function = "tpu0";
>         };
>
> +       can0_pins: can0 {
> +               groups = "can0_data_d";

can1_data_b

> +               function = "can0";
> +       };
> +
>         i2c2_pins: i2c2 {
>                 groups = "i2c2_b";
>                 function = "i2c2";

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
