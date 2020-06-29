Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09137C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11C9206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUD5GVMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbgF2TXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732295AbgF2TWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:22:45 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B686BC02E2FB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:37:36 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k15so15671735otp.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cveXjL+4X4gh1TmXdX8oqUnZgc2Vd1IaF1EU/HiH/po=;
        b=pUD5GVMvZNlTyNPmyJi9IXsTZfrSpSaM0QY7ebsyC1zCo0OHvFNpbLVF1pJscNAUqe
         IFyUSK2FgPrznhkiChklKg/G7qoGD7VR+JxDCQ+2fGlXHzsXTAeebGDSbDi+xKb4oeiQ
         r7TCH5o2rRa9F7dzql1Y0Y4WBuhpBWi1/YxuFjhqYkw3Gk8eneRiedH9eIkkpmhuMVqw
         oLoc7SDNFwvw9CyUztYOctHv3EI/iIZ6WPxRIm3c+LnISDzu8GPBBQTtWbyUAoIKTPkK
         TcQTR90pveM86/MHrDr6nAEk9rl3U5f0rwT6CQHlwFY7wh5l0XX7yi+KGFgnVqS4+XCo
         sevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cveXjL+4X4gh1TmXdX8oqUnZgc2Vd1IaF1EU/HiH/po=;
        b=ifeew4E+VXO5QXSsvQiln15uO6ojzZmj3urM5kYIuXSAARhzLuREF6RbfbbQuikSJS
         53rVdeubR5Nfoho1pH6tJxUaICsJC0oT/pjxg4NGqUP7aZom99fUxJWjQomfJXFBJCJX
         AUDZ25osnNuatFWABx5Hb/0KzTHMYF2Z85S/eCSdi9Lh+OzNUBx+lhBpyZlT6ly3eWZp
         BmtyIrmmlcoZ79A1OfV6a5/+hf29BPPfBmV0aa5DsRsRRcvWFKPDXY0frUa0Uj14wzie
         vAXlHh8hqks6sFQHjjWUlbOXAPsDCdCVxqgSaJEN6f5qiOtd2vmG/YahohDrrvbACpnS
         dF4A==
X-Gm-Message-State: AOAM530QcdMcb+hITD1l+Ul9Z783NLj5cTBD9vQMr8nv4nrY+CbBuUZf
        TeEUeTYcr8aXJhJXbWWv/9iSOiK9QkZ3oHl0cxM=
X-Google-Smtp-Source: ABdhPJxR9g/vuVB4KPn3jdGd9TFAWyi4TL/l19BuOkeMaOra6mdLr30ClOYBUAd6kOsB5YS6iY65MEoC5vi4wUTht3Y=
X-Received: by 2002:a9d:2c26:: with SMTP id f35mr14207086otb.232.1593441455928;
 Mon, 29 Jun 2020 07:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200625140105.14999-1-TheSven73@gmail.com> <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
 <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com> <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
In-Reply-To: <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 29 Jun 2020 10:37:25 -0400
Message-ID: <CAGngYiW=Pc_QjsjCv4Pc_R9OZk7nOAKm=k=b4TMbYRZ-08zKrQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing of
 clk_enet_ref where possible
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Fugang Duan <fugang.duan@nxp.com>,
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

Hi Fabio,

On Mon, Jun 29, 2020 at 10:26 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Just tested 5.4.24_2.1.0 on an imx6qp sabresd and DHCP also fails there.

I think I discovered the problem !

When I compare the sabresd devicetree on mainline with the actual sabresd
schematics, the devicetree is incorrect ! Things still work, but only
by accident.

The sabresd has an AR8131 PHY, which generates the enet ref clock, not the
imx6. So on the schematic we see that the clock output of the PHY is wired
to imx6 ENET_REF_CLK, so it can be used as a clock source. And GPIO_16
is disconnected, as it should, because the imx6 is not generating the ref clk.

But the devicetree is written as if the imx6 is providing the clock ! See
here:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/arm/boot/dts/imx6qdl-sabresd.dtsi?h=v5.7.6#n513

Also there is no override of the fec PTP clock:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/arm/boot/dts/imx6qdl-sabresd.dtsi?h=v5.7.6#n202

Although Shawn's mainline patch mandates this?
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.7.6&id=810c0ca879098a993e2ce0a190d24d11c17df748

This will work, but only by accident. So on a plus, when we
(incorrectly) switch the
bypass bit on, things stop working.
