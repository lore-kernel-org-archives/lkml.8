Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF73C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59C1208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgAQDUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 22:20:34 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38345 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgAQDUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:20:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id i16so20935775edr.5;
        Thu, 16 Jan 2020 19:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DuXdQ+iDwsOn6z/f7z3i1gI0wBVfOZJt0yf4ZaQCnGI=;
        b=ta75JDSwrGE+3vIHY2yb3jGezBeeANZoDjP1q28rvdcmb/asOQ/Mn0EM0/nOgJE0eu
         kq6uI4PgFq9alixNz/wJhLqpWu6SYr5u3Qsryz5fAwYW8OhyMY1deEUVEeKDwOSS3pK+
         Gu6NTMjY4jx4/oby4WtWagRqDKLsI5rMppePNo5EH3BHRkuNy5vlevKRl4kIJQKvZzrq
         bxSG6e9LpdZ2ohFGqjG894MdOry5yJiabamMQnGH/k9/wmGAO+PXh50TnrQXgMgII3RZ
         SSf7tGtd4PlKvyXBUfGh4CnumeUSAXDUxAzvGhkhJRTZEW1pBid6vw4pThBcABn7sTrd
         IXKw==
X-Gm-Message-State: APjAAAVF00t8IXheYI4i7yInQwf/2HObdGfLU2b6jb1skjNtiLXNWXEa
        E+O/7zemomo2bPs/YuKejfyCXlOGGJo=
X-Google-Smtp-Source: APXvYqyyg9x5N4zkjGEZFbPB6VW7lW6dlhN0XNk/AN4XlkpaxJ+WPoRBTWa64Zo0JFqbjF/1tW3CkQ==
X-Received: by 2002:a17:906:aad0:: with SMTP id kt16mr5935122ejb.223.1579231231598;
        Thu, 16 Jan 2020 19:20:31 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id u29sm901153edb.22.2020.01.16.19.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 19:20:31 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id b6so21299066wrq.0;
        Thu, 16 Jan 2020 19:20:31 -0800 (PST)
X-Received: by 2002:a5d:44cd:: with SMTP id z13mr661642wrr.104.1579231230948;
 Thu, 16 Jan 2020 19:20:30 -0800 (PST)
MIME-Version: 1.0
References: <20200116194658.78893-1-manu@freebsd.org>
In-Reply-To: <20200116194658.78893-1-manu@freebsd.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 17 Jan 2020 11:20:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v67U6qjNf0PPMOm191UZDQvJTGZNNREc22ZsDW61KqaUEA@mail.gmail.com>
Message-ID: <CAGb2v67U6qjNf0PPMOm191UZDQvJTGZNNREc22ZsDW61KqaUEA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add gpio bank supply for A64-Olinuxino
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 3:47 AM Emmanuel Vadot <manu@freebsd.org> wrote:
>
> Add the regulators for each bank on this boards.
>
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  .../boot/dts/allwinner/sun50i-a64-olinuxino.dts   | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> index 01a9a52edae4..1a25abf6065c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> @@ -163,6 +163,17 @@ &ohci1 {
>         status = "okay";
>  };
>
> +&pio {
> +       vcc-pa-supply = <&reg_dcdc1>;
> +       vcc-pb-supply = <&reg_dcdc1>;
> +       vcc-pc-supply = <&reg_dcdc1>;
> +       vcc-pd-supply = <&reg_dcdc1>;
> +       vcc-pe-supply = <&reg_aldo1>;
> +       vcc-pf-supply = <&reg_dcdc1>;
> +       vcc-pg-supply = <&reg_dldo4>;
> +       vcc-ph-supply = <&reg_dcdc1>;
> +};
> +
>  &r_rsb {
>         status = "okay";
>
> @@ -175,6 +186,10 @@ axp803: pmic@3a3 {
>         };
>  };
>
> +&r_pio {
> +       vcc-pl-supply = <&reg_aldo2>;

This is likely going to cause a circular dependency, because the RSB
interface that is used to talk to the PMIC is also on the PL pins.

(How does FreeBSD deal with this?)

Instead, just add a comment describing what is really used, and set
the regulator to always-on, which should already be the case.

ChenYu

> +};
> +
>  #include "axp803.dtsi"
>
>  &ac_power_supply {
> --
> 2.24.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
