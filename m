Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0788C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A407A207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqbnnoOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHXVgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXVgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:36:23 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65647C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:36:23 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v4so11415787ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CS64ow1u7K1AnW6SMizxy7+mawRgfmsjijuw/0TUdv8=;
        b=jqbnnoOMouSXguEL85YQ9YZvQ2VWi+8wDrTt4/yxqyrzX/YbB4p0B/TNbxXE0LM0Qq
         ekwHPlA8uwdpApGR/aD31C8TlcKTkvdK+8Oj0crGjWag4KZ5POaE8m7GhsZUWQzoM7fx
         qE9+DbzDe1rXrN1f3AeAqnNx49FgJojPhDfomAsb8hPVYI1Olh4PisYuilgpZJt+IXrW
         ZpNT8pHB9gepASvrAhhdQtniI3ImChPxIytUX5pvQN0xm0KzHnOYhcmrV8awjVQTHx1I
         At9YwX6SIfSihp1AgwaJyhf7QADQT4VLSKNBLmEIHjoYQnYdLyo8feZGjMScruWYSVbl
         bTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CS64ow1u7K1AnW6SMizxy7+mawRgfmsjijuw/0TUdv8=;
        b=HjWuwz4+hN+VK/V6lqkBEOB+EwdLfLGFZweRFzxzF4QKRXB+Xeig9i1d3GBjTkk6Zk
         SMLYU5BqGRpwOhjpx8Oc78XH6dTWjFs/rGXqzs+3LngoWxk/2C81we12CtRZvm/zQ6P2
         obt+c5fSHZstUWlPyLfIeuH5KNyYkqRSYvSMeWRWGeCrRi3etIHi4dmQFfIHfdreO75c
         f5s3Zh48x2+smquZoKI2czi6DCYrolX+gTq0/TMoV7WFEMgWr559Eih0YZG3Iqc7qTQX
         6Wl1TliXUFvKn3RAuzjs0vxPc5sr0w+HXB31tiDBeq2Q6tezlf4J4b7nNiSGCIxiD71y
         NvXA==
X-Gm-Message-State: AOAM5300UTlAIEbuqWo3WS2WjCHqjHlG8VxPKbmeNRvul0sp7NAIsI19
        73UTqJOgfZQ+ZEG6M0LMrXNm9dUKQ/S4s5ZaCBs=
X-Google-Smtp-Source: ABdhPJxyAVGkeOl+bOAJvEfUvF+aASEpvjsGMjEZFv93qBUUvnZB8I4ABuVUD4pLy9ovHSMBjnkDLpBpbKLD/wlLYK0=
X-Received: by 2002:a2e:80d3:: with SMTP id r19mr3622502ljg.310.1598304979592;
 Mon, 24 Aug 2020 14:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com> <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 24 Aug 2020 18:36:07 -0300
Message-ID: <CAOMZO5DSX1pf3xxo=CGvgPmHcjMJoWFx74grVJBckSmjtF-RGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6qdl: tqma6: minor fixes
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Mon, Aug 24, 2020 at 6:10 AM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:

> diff --git a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
> index 9513020ddd1a..7aaae83c1fae 100644
> --- a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
> @@ -20,7 +20,7 @@
>  &ecspi1 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_ecspi1>;
> -       fsl,spi-num-chipselects = <1>;
> +       num-cs = <1>;

You could simply remove fsl,spi-num-chipselects without passing num-cs.

The spi core is able to count the number of chipselects passed via
cs-gpios in the device tree.
