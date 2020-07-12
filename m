Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E009CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 18:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C239B2063A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 18:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/N/BqnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgGLSqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 14:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgGLSqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 14:46:06 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DECC061794;
        Sun, 12 Jul 2020 11:46:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n26so12460770ejx.0;
        Sun, 12 Jul 2020 11:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6Qek2fkCB/2CxHUEUFljSHTbzdbT53VAPl6aQJ65nc=;
        b=U/N/BqnUCvWI0p7yxG2u7x1vPloQ9p/Em95pZUJPFerIQ2ouVRXGI8hZUnMn/VABwx
         TXKgQCLaH7No+8qniaeGoOxzVPHABpfGm/urW4tnTUdewTx14NpliaxCjWWpfT1mtqYh
         BQeNTcszQ7vOke9OlkuoxsGkDlZ4IAYdfrq3DQ2WGE8LjvWF1h2WFSmc1uoT6sGvaTdT
         4IQQus/LxyRsRZMkQILkKsKUy5MhfM0USJIcMgPV4N51Jd5ZCwXkiKttJM5JfyDBBLUA
         h08Qv9sQ9chSfLi1rwMSDtIgTEDxaXNiUCiEuC8a7gHt6lwSVkI0q1ToIgMwf/9F53CZ
         DRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6Qek2fkCB/2CxHUEUFljSHTbzdbT53VAPl6aQJ65nc=;
        b=LTlksg3dK3iAO2bJnbk/hmcuk+7Wj0ZNK0TN4CDQqRNNJWkyABVVQj5ye9J3y7863I
         Z/7CUOp5X+gb2UHsxC/S9vjUJ8XNTB48Bxk+yMEhyfRNdcVpjKCE0UAM0nlTLXv5j+6p
         FrqvLPwXRRFeuqNvzuDxq2QE29IkL9cKBD17WklOEBWHiLbQC17QR4BmYBmtJ1hLv3/m
         lADIIhqG10acUHwaMTo2t2Cda6EUjtARm6qkq5NYpq85F2tVgameGZsysbxzEp43z4U4
         jYgcv6OW/us+B49dRIc+xLjJgR2jT8jYC+UcjIq185bCQ55gJXB4zG/sVY/vapuhJNFh
         o4NA==
X-Gm-Message-State: AOAM531XZRrHCis/mwSxqMoeb9i/HH4g49tK3+SSG86QLZZ3D+idlQql
        uv6+9SdhnvMSLBMSDwDdOueJq25de0HyU3saRJQ=
X-Google-Smtp-Source: ABdhPJwPn7kb6uSoDv+CUpFNn4npaWHCyaF2trLzwY77zvp/DeuKhGJnpDPtyB12EiCtBA3gqLudJYd+2yBlgvEE3k0=
X-Received: by 2002:a17:906:1414:: with SMTP id p20mr69197044ejc.247.1594579564886;
 Sun, 12 Jul 2020 11:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-11-git-send-email-amittomer25@gmail.com> <20200712173044.GL6110@Mani-XPS-13-9360>
In-Reply-To: <20200712173044.GL6110@Mani-XPS-13-9360>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Mon, 13 Jul 2020 00:15:28 +0530
Message-ID: <CABHD4K8+cZMwA=pQx4Gvv5Z4xLof8Ln6fUNrB0=-SS2M_0_3aw@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] arm64: dts: actions: Add uSD support for Cubieboard7
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 12, 2020 at 11:00 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Thu, Jul 02, 2020 at 08:22:56PM +0530, Amit Singh Tomar wrote:
> > This commit adds uSD support for Cubieboard7 board based on Actions Semi
> > S700 SoC. SD0 is connected to uSD slot. Since there is no PMIC support
> > added yet, fixed regulator has been used as a regulator node.
> >
> > Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> > ---
> > Changes since v4:
> >       * No change.
> > Changes since v3:
> >         * No change.
> > Changes since v2:
> >         * No change.
> > Changes since v1:
> >         * No change.
> > Changes since RFC:
> >         * No change.
> > ---
> >  arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 41 ++++++++++++++++++++++++
> >  arch/arm64/boot/dts/actions/s700.dtsi            |  1 +
> >  2 files changed, 42 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> > index 63e375cd9eb4..ec117eb12f3a 100644
> > --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> > +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> > @@ -13,6 +13,7 @@
> >
> >       aliases {
> >               serial3 = &uart3;
> > +             mmc0 = &mmc0;
> >       };
> >
> >       chosen {
> > @@ -28,6 +29,23 @@
> >               device_type = "memory";
> >               reg = <0x1 0xe0000000 0x0 0x0>;
> >       };
> > +
> > +     /* Fixed regulator used in the absence of PMIC */
> > +     vcc_3v1: vcc-3v1 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "fixed-3.1V";
> > +             regulator-min-microvolt = <3100000>;
> > +             regulator-max-microvolt = <3100000>;
> > +     };
>
> Is this regulator used somewhere?

This is something I copied from bubblegum dts as I wasn't sure what is right way
to include these regulators.

Also, another day tested it without having these regulators in , and
still it seems to
work.  So should these be removed ?

Thanks
-Amit
