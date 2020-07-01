Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9819CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F382078A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3Ofc3mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgGAHQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgGAHQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:16:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF27AC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:16:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so21254221wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IGhhk32SvHiFdB0hZEKj8zNTTDQsZ1TsfgdXo8+49ys=;
        b=A3Ofc3mzIf50ua0wXQbeXXTcFuIzOZwfEOsrrtzKlW0px5KeRaL13sgueXXuzVj8OK
         3o2jJL///kb2aDttgf81Lu5R+QJP76q1sm1EASEhQ2C3OC/8qOoGb2qSIe1QN0Cwxgho
         oWvaeHGQ2aBLqdd6z2sWCYHj+tsbfiP3M3IsJxr6veM4O4BIoxJaqYuBwnIzEJzDLRBM
         mjawO8dSakI9nRS3X84xCHkOgn9O/7RyEcva+qZ0e2ebh954QSVE5Cq4m+trVh3QKFpW
         WicGjQsGCgEtYnmillibWxYqbPY/Nfndq9XXrzonyyyGmClHjWbpGPvcm0ZEdTqA2Vos
         /n1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IGhhk32SvHiFdB0hZEKj8zNTTDQsZ1TsfgdXo8+49ys=;
        b=VDuC/OO8PmUoofx3ns3HsZlp3Tl5oLbi6h9gKjbiIGaRK3rdOQ6zd6599w2YA1sQ5s
         zhdRHQOhl7Ul2XFTrJnsOjgD89I3LkMP8Ui1vQ/+GwH2ETaJUcviUDwbyihCTzW/o4Lj
         pitqMKkfs5G0xsgI0PLTYoux824QmCPxc22UKOQGuXohgcy2e7lJo7x17xpwt32kDT1M
         rYx/mJIJZSmw/bylCX2J92ntd71/soeRtA7Dj5fgjnIyTduk3ntEOi4J2voRFTiCVtsV
         /EV3/EO9vHDQvz+WrqV5j6z9NO9UnnZBCam2DsLfVNhKSyFSQ+vJf0UA2DZIX6QIjwIV
         0sbA==
X-Gm-Message-State: AOAM532/cYUOAWpf0D3ce8Ij0P6O+OfOTgTcAqrrjTQgstQb5mW7dpCF
        NzG2CucWqcr3LoIj5FDoS2xmhg==
X-Google-Smtp-Source: ABdhPJyf/QJmTPtaPrKrIWWP1HO2uuxJnD19rp3j2PuXJ9f9qdns0XDOvWyRa78gSLklXHnc7IaRug==
X-Received: by 2002:a1c:9d0c:: with SMTP id g12mr18744257wme.107.1593587783414;
        Wed, 01 Jul 2020 00:16:23 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id n14sm6508639wro.81.2020.07.01.00.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 00:16:22 -0700 (PDT)
Date:   Wed, 1 Jul 2020 08:16:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     jic23@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        matthias.bgg@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, dmurphy@ti.com, lgirdwood@gmail.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: Re: [PATCH v2 2/4] mfd: mt6360: implement i2c R/W with CRC
Message-ID: <20200701071620.GQ1179328@dell>
References: <1592567631-20363-1-git-send-email-gene.chen.richtek@gmail.com>
 <1592567631-20363-3-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1592567631-20363-3-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> imlement i2c R/W with CRC when access sub-device PMIC and LDO part

Please use proper grammar, including capital letters at the start of
the sentence and for abbreviations such as "I2C" and full stops.

Also this doesn't make sense to me.  Please elaborate.

> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/Kconfig        |   1 +
>  drivers/mfd/mt6360-core.c  | 541 +++++++++++++++++++++++++++++----------------

This patch is doing way too much wacky stuff all at once, making it
very difficult to review.  Please break it up into functional pieces
and submit as separate logical patches (in a set of course).

>  include/linux/mfd/mt6360.h | 240 --------------------
>  3 files changed, 357 insertions(+), 425 deletions(-)
>  delete mode 100644 include/linux/mfd/mt6360.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
