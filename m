Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D41C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9592065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xP+CinPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgEOKp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbgEOKpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:45:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F1BC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:45:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l18so2976695wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Cd7qB8BAMww/iv9WmCLhIPHREYnAoZQ6w79B6P0E6xg=;
        b=xP+CinPdhHJdBjl9cEQqmu4DEA3UtVXZdBP7jqRNyAo0v9749k2ET+YUkOxJpV8x48
         /zi9CEO2JexEpMGzWxjP+uS7KXXviQr7dpYE8UAf3Yhvjt9YIOIeSMSlQ6arlBHRgllI
         GSyelo7kJIw2le571fQUHCKuHVftyT/NiPioOYLVs6camgsZAbgkYFMSwOu7e0nwDQB6
         a66nTFdjPwh+BuzvO8QOtsWxvH/AFnK4HGT8J7Yxoybk1PSqW7a62ZOMEAodFlT86hS5
         0iw+hj9gW3zvmz1F0DySLxkKplkE60LPynfbBQtp7qra3lLh2Qoqa+pqhfZeVVv8unTh
         Z1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Cd7qB8BAMww/iv9WmCLhIPHREYnAoZQ6w79B6P0E6xg=;
        b=ZpAIzn+Rz3K+rlot+Svh6DlGsCEXhNBu26BSIlghdq70/M8nstC5UOmWAmyy09U/+m
         W4IkcIpeUsiM2PpoiX433oXXB8QDgSA9sJssz4PFhWCRmy+JEsqutTxpR0N1fP9XwNGQ
         Mq9nm+hXqc/DrhPv8mLvr/azP9o/F7k6VAcO8liCZb6ubcrx+UJTZZvq37F/JIvhP5TL
         HwOpMBYgJO/ZEbVlohBmuxpeQZsUZhrhMnrtyfJPE0WO+uM3jmN9/Q0JL8lmoUtgBT9w
         3IfyZKfFQKAPz4aSj+cUe00h1eO9i6z4H4dLqN4nfRyqFNQvQGc5wb6dhb9l6cBbk0jg
         g53A==
X-Gm-Message-State: AOAM533znwEgUOQbBz5MrO7PbZ0dGldzCjSkB++/BOnXpMa52Stek261
        lVSNTVS5bAGXoTYiUz/NYCaDiQ==
X-Google-Smtp-Source: ABdhPJzbfw5o04oHo9dS73R/kDPCPBnMrv+TxxiUYGhV32BiVaTVeZw53f6QhVV5pucVUf2qfhjPXw==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr3533148wrm.224.1589539522608;
        Fri, 15 May 2020 03:45:22 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id b14sm3022482wmb.18.2020.05.15.03.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:45:21 -0700 (PDT)
Date:   Fri, 15 May 2020 11:45:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mfd: Introduce QTI I2C PMIC controller
Message-ID: <20200515104520.GK271301@dell>
References: <cover.1588115326.git.gurus@codeaurora.org>
 <5644dea146f8b49a5b827c56392ff916bfb343e9.1588115326.git.gurus@codeaurora.org>
 <20200429075010.GX3559@dell>
 <20200501011319.GA28441@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200501011319.GA28441@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020, Guru Das Srinagesh wrote:

> On Wed, Apr 29, 2020 at 08:50:10AM +0100, Lee Jones wrote:
> > On Tue, 28 Apr 2020, Guru Das Srinagesh wrote:
> > 
> > > The Qualcomm Technologies, Inc. I2C PMIC Controller is used by
> > > multi-function PMIC devices which communicate over the I2C bus.  The
> > > controller enumerates all child nodes as platform devices, and
> > > instantiates a regmap interface for them to communicate over the I2C
> > > bus.
> > > 
> > > The controller also controls interrupts for all of the children platform
> > > devices.  The controller handles the summary interrupt by deciphering
> > > which peripheral triggered the interrupt, and which of the peripheral
> > > interrupts were triggered.  Finally, it calls the interrupt handlers for
> > > each of the virtual interrupts that were registered.
> > > 
> > > Nicholas Troast is the original author of this driver.
> > > 
> > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > ---
> > >  drivers/mfd/Kconfig         |  11 +
> > >  drivers/mfd/Makefile        |   1 +
> > >  drivers/mfd/qcom-i2c-pmic.c | 737 ++++++++++++++++++++++++++++++++++++++++++++
> > 
> > The vast majority of this driver deals with IRQ handling.  Why can't
> > this be split out into its own IRQ Chip driver and moved to
> > drivers/irqchip?
> 
> There appear to be quite a few in-tree MFD drivers that register IRQ
> controllers, like this driver does:
> 
> $ grep --exclude-dir=.git -rnE "irq_domain_(add|create).+\(" drivers/mfd | wc -l
> 23
> 
> As a further example, drivers/mfd/stpmic1.c closely resembles this
> driver in that it uses both devm_regmap_add_irq_chip() as well as
> devm_of_platform_populate().
> 
> As such, it seems like this driver is in line with some of the
> architectural choices that have been accepted in already-merged drivers.
> Could you please elaborate on your concerns?

It is true that *basic* IRQ domain support has been added to these
drivers in the past.  However, IMHO the support added to this driver
goes beyond those realms such that it would justify a driver of its
own.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
