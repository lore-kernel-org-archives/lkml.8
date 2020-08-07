Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C920C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF48F20855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1dacVuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgHGKQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 06:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgHGKQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:16:20 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3AFC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 03:16:20 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so1351239ioe.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 03:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4f8OQgzuz+LDRnj85cC5d/U7jDFEqbHAdZ2qh7RY1sE=;
        b=Z1dacVuDCDo1gA3yUPlpW/LbuFZJcYNg+aJDk2w4/De7ZXN7/G5RDsXBsZF7PBD63g
         FOdXb6jZFwbKD9NzFDRXUGHI5OtBii6Yc5csOQzqJFWgTIZfho4A3mBkhRTXmquSsGqX
         do1nFqWajSwCs2xrA7dLDZrqb8Pfx0s+rP/c5zi4NOG5OffLBV9V+8ukkVbgSpToQTnP
         fIUNXF/YqOx3/fQXxlxp6QQSnVu2fQoC+0oTDAqOP7PqnhzZRtBfXL9kEQeU+GlFgkxG
         vdEgwbpg8vMx54H4ICkHGh/mx4/yrc75EPs7MWRCJhkADRivNQGeKlTwUqeXvZYXC4Mj
         hENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4f8OQgzuz+LDRnj85cC5d/U7jDFEqbHAdZ2qh7RY1sE=;
        b=Z0F6pVrpe5E5rvkj5vVgNTy0tz/c2ueVobMLK21x38BulBHyG8mlf+vCJp3czLdJFT
         tpBVQxXd9dFqlmwX0r+hbqTOPy2I1m/H1O7DxayVYpKwMllG/V7krJbulVuhcpAnl1/t
         ZEsk38qvJGOIGDFRWFunubG3mY/vArK/pXAI/MMcx3tWh3Rsn1oskpZ/gQMzN6+I6J5m
         ux+IVvfhyhNJ2dqmEI7rF+1BM5yqrei/RQEsP7P6g5n0r5CD6Mx0/Y04FyqrAWgDOs+8
         7JdvVlU1HG4D6MJAjvauSXrLspBFFVnc+3lFOAzYhgKeNp4p+BUSDTWLAZqgzVe55Qre
         Y6ZA==
X-Gm-Message-State: AOAM533u2XiXSh4Mhs5lJrIfTha5s+ibsKAqpChlgn6p3VpID5e7a4Da
        G4mtkvXzA4pIKIyXqL7FqE0G0WcDLMMHqIkFeuU=
X-Google-Smtp-Source: ABdhPJzL42pQp9UVI3P9+3/FhcnfKuTDlRv/YHFJ3dIcTa2PaRxJ1LUbsHUpGcm5Vh/p99rU8/3beFIAcRSrrLNaq+o=
X-Received: by 2002:a05:6638:1489:: with SMTP id j9mr4177977jak.22.1596795380033;
 Fri, 07 Aug 2020 03:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
 <1596558782-3415-11-git-send-email-gene.chen.richtek@gmail.com>
 <20200805161021.GK5556@sirena.org.uk> <CAE+NS360iKLoGxiiz8NmQqCp2Uge98Eehe4g2sn_N0e-E3DgyQ@mail.gmail.com>
 <20200806121332.GB6442@sirena.org.uk>
In-Reply-To: <20200806121332.GB6442@sirena.org.uk>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Fri, 7 Aug 2020 10:16:08 +0800
Message-ID: <CAE+NS37tr65GnTue89wJkPvJzddahKj__KPgzmjzwkOfWQnc8g@mail.gmail.com>
Subject: Re: [PATCH 9/9] mfd: mt6360: Merge different sub-devices I2C read/write
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, rafael@kernel.org,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=886=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=888:13=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Aug 06, 2020 at 11:30:56AM +0800, Gene Chen wrote:
> > Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=886=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:10=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> > > It's not clear why this isn't just done in the device regmap, there's
> > > exactly one user?
>
> > because I use one regmap to access 4 I2C devices,
>
> There appears to be only one device here?
>
> > I need change the regmap_bus struct to fit I2C read/write with CRC bit
> > Therefore, MFD reviewer suggests I can move the regmap api to regmap
> > folder such as regmap-ac97.c
>
> AC'97 is an industry standard bus used by a range of devices in
> different subsystems.  You can already have custom operations for a
> device just in a regular regmap using the reg_read() and reg_write()
> operations which are there so devices that individual device support
> doesn't need to be added to the regmap core.
>

I need use regmap_raw_read to access MT6360 TYPEC part, so we need
implement bus read control

> You really also need to write a much clearer changelog, I would be hard
> pressed to tell from the changelog that this was moving things to the
> regmap core rather than shuffling regmaps within the device.

MT6360 has 4 I2C worker devices
First, I increase reg_bits from 8 to 16 bits.
Higher 8 bits, bank, indicated which worker device I want access
Then, if worker devices is PMIC or LDO part, I need calculate or check
CRC8 bits when we write or read data.
CRC8 bits is calculated by 3 parts.
1'st part include 1 byte is worker address and R/W in LSB.
2'nd part include 1 byte is register address
3'nd part include written data or read data from MT6360
I also need 1 dummy byte when write data

@Lee Jones,
I found out drivers/iio/chemical/bme680_spi.c implement their own
regmap_bus too.
Can I move regmap control back to mt6360-core.c?
