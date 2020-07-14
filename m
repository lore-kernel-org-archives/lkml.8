Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BE9C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C011C22224
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGjyAIe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgGNLyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgGNLyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:54:19 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BCCC061755;
        Tue, 14 Jul 2020 04:54:19 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t9so11282527lfl.5;
        Tue, 14 Jul 2020 04:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kviBBfRUXF6FyQ/T2lhXR2kEq+3oh1SIHqgwdRSis9Y=;
        b=mGjyAIe06bIfAGY9o+A+teKJimbQB9fcw5z9/KlcKfAtHrhaDEIaNygzGUvgoZ+QTt
         XghQsz8XBAB2bkgGRD+UEOKVGhB9kR6/BVEL6sswnabb2kVyo1bTKhXU7z5eS3gL29Zl
         ZPIN+zueHJOgUGbizzx5H++vBAm1v6mqANd359vfEEPdydDt/CGju+Y7qv3Shotg9g+w
         lqxHDunaNeFzftnW9ZzWBsylmFWfLU0cjE3u5nhuLW7P2rI9RLujnqg0kDfqRf8wXsta
         V3x+9pmiRkL03D6iPTAOtMT72ucaSA2BBQC1FlV2PrnOJDnggWXai8C+wEIBx8N0PHZJ
         gBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kviBBfRUXF6FyQ/T2lhXR2kEq+3oh1SIHqgwdRSis9Y=;
        b=gPI9XRbAGylFvvDVlkIhWMgIRbCVoBcWwAy66upT5fZ9mrI7M6KZP97Q09HUEhL3Kv
         VbzjbKAtRzOoBQfS61be3VSlSrQp5BNYKIFPvChN4udA6DIJPBVn7BBGNjsTgloCo3cU
         xp1y5oRDsXSRtQRA61e6uZ6teunzIQjmP2uJcgDEbVbB59M6xMBwVg/FP0Ky4jIFef8F
         fmMQSNVve5mY2zgdflaqSLWBFS4UfJKuIWN2h2xMzvRwcvtlbpkGi1xfxQRXwLZBeE16
         ROZsndyUwgoZz5QaDr4Mz0AsQC/OdnEay6Xy7pspcmgl8keZ4kbVrBUK/3kUkKDZeEqn
         tGvg==
X-Gm-Message-State: AOAM5324nr+om7faitrLCf0U7AISoZTnxZohEl1nh/328sn62bIooDYt
        MKgbMjGaxLzBMHJ7wVVu5G4I0PIThTdFY6HE5+Q=
X-Google-Smtp-Source: ABdhPJzpcBS8ojSUurssZkclJ5NwsbqUtkf7ZoPFrW6jtuQRlH1WOTGDaI75hN8OcOkECKQp0To/UNg6SgeB36TJmjQ=
X-Received: by 2002:a19:7e09:: with SMTP id z9mr2009713lfc.69.1594727657785;
 Tue, 14 Jul 2020 04:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200629114927.17379-1-bruno.thomsen@gmail.com>
 <20200629114927.17379-2-bruno.thomsen@gmail.com> <20200713025246.GY21277@dragon>
 <CAH+2xPAHKY6YfhO-jXfKN+TRN5LDT1Kkn8a8HUj_EOqFt=75nQ@mail.gmail.com>
In-Reply-To: <CAH+2xPAHKY6YfhO-jXfKN+TRN5LDT1Kkn8a8HUj_EOqFt=75nQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 14 Jul 2020 08:54:06 -0300
Message-ID: <CAOMZO5DsyqRgD8n-w=6OmnXuMX+1T2DDOjQLNK133=FaqtWXVQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: imx7: add support for kamstrup flex concentrator
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bruno Thomsen <bth@kamstrup.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bruno,

On Tue, Jul 14, 2020 at 7:03 AM Bruno Thomsen <bruno.thomsen@gmail.com> wrote:

> I have not yet been successful in converting the deprecated properties
> to generic phy properties, so hoping I could get a hit.
>
> Kernel error messages:
> mdio_bus 30be0000.ethernet-1: MDIO device at address 1 is missing.

Please double-check whether 1 is the correct address for the KSZ8051
Ethernet PHY as per your schematics.

Are there external pull-up/pull-down resistors for strapping the
various configuration pins for the PHY? Or are the pull-up/pull-down
provided by the i.MX7D pins?

If there are no external pull-ups, please make sure to configure the
pinctrl_enet1 accordingly, so that the Ethernet PHY address can be
properly configured and then mdio_bus driver can find it at the
correct address.

Please check in arch/arm/boot/dts/imx6qdl-sr-som.dtsi for an example
on how to configure the Ethernet PHY pin strapping via iMX IOMUX.
