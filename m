Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8348BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E09B21473
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcA01VsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgGBI3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgGBI3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:29:51 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B7EC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 01:29:51 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id i18so23482861ilk.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 01:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PFI6JgeUlJ0zCkzBIfqc7DEBAwFXOrcce0CKNSdhhaY=;
        b=NcA01VsImeoYRghLx1f/WoCed8K77wkg/n2nxdjujvgeFu2ykNf91zWIdX1PgDF3bV
         em7xudIT0qkiaGrFgK6BufPqJwFNBNTqz7dFJj7d3rvB0/bWFTarqjivuOptBwOD8Ust
         +rmOlxyPBS8wJ5Ya/rrAkyuLHuOS3I6efbcAFYqVTRJ+pOEDgUeYfddbbaf+Cq8JnoN8
         zktQlYolsZJThAht2LFFVUCgSkokUdBPvLowvkkzUaU/R6CM31lQjrFcRKMqndGnx5KB
         JGWd9gfpLVsaNfW/EUkWNkcFqZ3PlycrOxGIhRVzY5gUOASui0lREVAWgEph38VQzlAH
         XERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PFI6JgeUlJ0zCkzBIfqc7DEBAwFXOrcce0CKNSdhhaY=;
        b=S6G/qsN/jaApvJOZGfzbwko3N5N0hQ4d7cKIdikL39YpZIjEhsZnwYyTTX8+pUSwG5
         XXuIDKGPfgxI4mouB9OS98uQLG4/118jJojLjnKNMfILG0Jcoa3hQ4a6AfUF26a8ZJVV
         RKSPX3D6nHtN5OGSYyH9TxrSGLx3oSE5iCBgSZgO34gk6KF/hrBygpLx37eMs1OhfIoT
         Pi03bYMmAS+9l7w8jjGNbgFJAKZhhqj2uTA3FfvO4MALqIVLXZFMatqntAkDsd57TOpI
         A66uukMFVzWl0O1zs4Z8Jk3al1y940zEyHivr9CzbOzJmTiAe+eOxu3Cfvm1ceIZ/C5h
         Nupw==
X-Gm-Message-State: AOAM532tbPZSQ+UoSaGVO5FpzjFj51fu5hNPrGETHBax/IXOvBDnYEQm
        QeY1izr8PQmwIUZPG7En4jZKL3e1xhD0iuJLtiM=
X-Google-Smtp-Source: ABdhPJwNPbq0R1jANb1XdVAr90ksp6Cce11K5919+RTL7nX3VNOYDmwKtakBxB6hfuabbbme20388qd6mlT1cFzkquM=
X-Received: by 2002:a92:9f96:: with SMTP id z22mr8671290ilk.266.1593678591282;
 Thu, 02 Jul 2020 01:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <1592567631-20363-1-git-send-email-gene.chen.richtek@gmail.com>
 <1592567631-20363-3-git-send-email-gene.chen.richtek@gmail.com> <20200701071620.GQ1179328@dell>
In-Reply-To: <20200701071620.GQ1179328@dell>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Thu, 2 Jul 2020 16:29:38 +0800
Message-ID: <CAE+NS35Kj_H9uSgBiff4hogTWmwh6z+vmPNWDh_yU1=p68xQZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mfd: mt6360: implement i2c R/W with CRC
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jic23@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        matthias.bgg@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, dmurphy@ti.com, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B47=E6=9C=881=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, 19 Jun 2020, Gene Chen wrote:
>
> > From: Gene Chen <gene_chen@richtek.com>
> >
> > imlement i2c R/W with CRC when access sub-device PMIC and LDO part
>
> Please use proper grammar, including capital letters at the start of
> the sentence and for abbreviations such as "I2C" and full stops.
>
> Also this doesn't make sense to me.  Please elaborate.
>

ACK

> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > ---
> >  drivers/mfd/Kconfig        |   1 +
> >  drivers/mfd/mt6360-core.c  | 541 +++++++++++++++++++++++++++++--------=
--------
>
> This patch is doing way too much wacky stuff all at once, making it
> very difficult to review.  Please break it up into functional pieces
> and submit as separate logical patches (in a set of course).
>

If I understand correctly, I need to separate patch[2/4] but not
entire mt6362-core.c into several patches.

> >  include/linux/mfd/mt6360.h | 240 --------------------
> >  3 files changed, 357 insertions(+), 425 deletions(-)
> >  delete mode 100644 include/linux/mfd/mt6360.h
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
