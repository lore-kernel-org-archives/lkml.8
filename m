Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37EAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC04206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApvuyD6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgHRLrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgHRLrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:47:16 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85109C061389;
        Tue, 18 Aug 2020 04:47:15 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bo3so21645644ejb.11;
        Tue, 18 Aug 2020 04:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3vfWkwQeHMTsBJCMMRO8yphrmJyd9SWGqregYV9w7pU=;
        b=ApvuyD6dqJ4/45lpfpiMCyKoJ5HBgEkP2khcZUBYso0g5WV8gkyFT39VQp+555SjFm
         gk/ur8xiMu+nsH9poyTgv+SLzYFcthzPZ7d9HsNVFFfvEW+45ajFXnoymOK/B3KMisca
         2aYiEj74RbBIwkua0bIKoZ2K6BCmhYlwHVePLnig6sLQ/fir4EoXEr2n2aZ8vqodJg5i
         5HBImknPXNglaHsI+iwmGdEbbnVXhEy43wYYyz/CTkUgW5OoYAspGDvu+OtDj2orBAQU
         0wXwvbQqSg8HEzaMPP5UPJUqfTUfQn9wSisTG0ETc+xuJC29x0I7vaEvGdrJyP0tbL8F
         jlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vfWkwQeHMTsBJCMMRO8yphrmJyd9SWGqregYV9w7pU=;
        b=YopaZVy+2Z5uyYK+Lh3zE0Z0fYs5L9jERMZ5WtpNxZP0g4WSXo1KLUZJKObFOfbPtr
         IW98daZbKfuf6+6ByP7VRhZrE8QA03FvrzvzADp/SWeCbRtap8uIcX1Ksx3VXjTC4lcB
         CtzZpLSIKv5JnExzjQEo+i7YVN/+XXSWHvCDlRM9C1EvIZ694Z56B3fkvoSZDREu2zMv
         Ij4HamY2cxeCpU/f0Pqfj+3sb9K2jdY/TXg98bdOXYMFRLKjEoKmRE+zL76vY0dajdMF
         xnrpIk+qrZtwiC2PpDkKni3zquwUoHb2D5CN3np6jIjxcXVyC6lHzJI2N1mwU6i5udvd
         QZNA==
X-Gm-Message-State: AOAM531ztpExv+nGksNM1vOHY5hTR6ZEttlq2GlQMdwQb0uEs46bVFM/
        1X7qdnfrfIH4g30K1RhG3WNmVRWCBspzdEfk6dg=
X-Google-Smtp-Source: ABdhPJyOmylxJ6LkkKyRQ/DTncAq5A1OCCgnwnmNP7E6JOIoTrFXbfboQjUu7HNhCgjSrca+T4ATrIqUg82CCtywfd0=
X-Received: by 2002:a17:906:138b:: with SMTP id f11mr19133439ejc.310.1597751232528;
 Tue, 18 Aug 2020 04:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com> <1597406966-13740-16-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1597406966-13740-16-git-send-email-abel.vesa@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 18 Aug 2020 19:32:05 +0800
Message-ID: <CAA+hA=TiU_3z8a0eEn3tYfyJ7JWZ-u8Yes1NOgXEnbeh43q7TA@mail.gmail.com>
Subject: Re: [PATCH v2 15/17] arm64: dts: imx8mp: Add audio_blk_ctrl node
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 8:12 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Some of the features of the audio_ctrl will be used by some
> different drivers in a way those drivers will know best, so adding the
> syscon compatible we allow those to do just that. Only the resets
> and the clocks are registered bit the clk-blk-ctrl driver.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index daa1769..dede0ae 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -736,6 +736,22 @@
>                         };
>                 };
>
> +               aips5: bus@30c00000 {
> +                       compatible = "fsl,aips-bus", "simple-bus";
> +                       reg = <0x30c00000 0x400000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       audio_blk_ctrl: clock-controller@30e20000 {
> +                               compatible = "fsl,imx8mp-audio-blk-ctrl", "syscon";
> +                               reg = <0x30e20000 0x50C>;

0x50c

> +

remove unnecessary blank line

Otherwise:
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Aisheng

> +                               #clock-cells = <1>;
> +                               #reset-cells = <1>;
> +                       };
> +               };
> +
>                 gic: interrupt-controller@38800000 {
>                         compatible = "arm,gic-v3";
>                         reg = <0x38800000 0x10000>,
> --
> 2.7.4
>
