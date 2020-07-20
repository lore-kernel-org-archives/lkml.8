Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E59C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23C222C9D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="liI8qj38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgGTOyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTOyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:54:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2518C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:54:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so22545196wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2HQ9WNdGoOa/CwIT79FZmwN2wIlYigkcboh5TFIst00=;
        b=liI8qj382ayQB0NSb2owvG3UxSLUff0mldH1n6TLUcWypVFzXS2rgB/iXysgz3XNOx
         Is1y5KLq2ozy3dggJrJhcSH3SZg/rUCORgYHs9av6RFC4v8CpHObZI3BErLMGcCjGpjq
         miRojRYwoBWVi8xxEnRrZI2dqQ2PXxy9dRMnQ9zQB9/rkizwJLACyRKFX7ZZDYvkel3E
         gGTOH1MFfpsf9pPvntMP2BmlonSpqYBDDwHRDAdpTJEhbiHlhJ3eeaX0FOj/VsMBg0MO
         JhA+sltxOCZyrbwtPjXTYSez+E+5LZL3XmrtJf2bTy3i42XRO4rat9dr4SM+/d3258OL
         DaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2HQ9WNdGoOa/CwIT79FZmwN2wIlYigkcboh5TFIst00=;
        b=OOD5AcCs/pkVkPSsRzKjR17/Ksp0j0GOYSG9Y1McuF/MO+vzNMu0y7k+PTw+mEj+ET
         NR0rwR8ArubfoH/hXffXctHPokreuQ3kasmcmeUz7A0qiPxXjiYBeN3RnOJZgQcOMP/Z
         ouatz67Px9hBIjKFol6+KQiHQtdocwVkdtLPKphJmElvF2WBOytN01NzcfRi+5+HMpr6
         CPJ5NTHAtI1WB7114YHXXu1+MPIlE/seBM//ixjCi6S4Pfs/zNHtNLjjV05s42+aYQn4
         E+5xfaJh3Jnkq5EagfYmG7RsN5bldhD6T4OMhshO3b4UWMC6Lbd2jRxGJ+31V76EtYdD
         r29g==
X-Gm-Message-State: AOAM532SSiPWemvlHToZ+k4o13/cHM861xFGkykfH3PjyKmoUmWyhBn3
        ACNBVqJGvwusSO/jYDvLUqJTRQ==
X-Google-Smtp-Source: ABdhPJzy+0wOfpiE6LNYySlZaHbDcWwb4VOTDYMPwGCSTSlzWPwT2BICiSwU4oN658n/kwOnVQzUJg==
X-Received: by 2002:a7b:cb92:: with SMTP id m18mr21097163wmi.94.1595256874417;
        Mon, 20 Jul 2020 07:54:34 -0700 (PDT)
Received: from dell ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id 62sm17771123wrq.31.2020.07.20.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 07:54:33 -0700 (PDT)
Date:   Mon, 20 Jul 2020 15:54:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     ricky_wu@realtek.com, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, rui_feng@realsil.com.cn,
        Bjorn Helgaas <bhelgaas@google.com>, kdlnx@doth.eu,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] misc: rtsx: Add support new chip rts5228 mmc: rtsx: Add
 support MMC_CAP2_NO_MMC
Message-ID: <20200720145432.GB621928@dell>
References: <20200706070259.32565-1-ricky_wu@realtek.com>
 <CACRpkdbkpwMaS3FR1F1-WU5AjwvBchwLDKDhgHAA+-sKZLRpsg@mail.gmail.com>
 <20200720145202.GA621928@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200720145202.GA621928@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020, Lee Jones wrote:

> On Mon, 20 Jul 2020, Linus Walleij wrote:
> 
> > On Mon, Jul 6, 2020 at 9:03 AM <ricky_wu@realtek.com> wrote:
> > 
> > >  drivers/misc/cardreader/Makefile   |   2 +-
> > >  drivers/misc/cardreader/rts5228.c  | 740 +++++++++++++++++++++++++++++
> > >  drivers/misc/cardreader/rts5228.h  | 168 +++++++
> > >  drivers/misc/cardreader/rtsx_pcr.c |  89 ++--
> > >  drivers/misc/cardreader/rtsx_pcr.h |   5 +
> > 
> > This drivers/misc/cardreader business is a big confusion for my mind.
> > 
> > Is it really that fantastic that it needs to be a unique special case?
> > 
> > To me it looks like a drivers/mfd thing which should have separate
> > drivers/regulator/rts5228.c (LDOs)
> > drivers/clk/rts5228.c (clocks)
> > subdrivers.
> > 
> > See for example drivers/mfd/sta2x11-mfd.c thay spawns a few
> > devices off a PCI card.
> 
> Thanks for Cc'ing me Linus.
> 
> Can you please bounce the diff to me too?

Never mind, I found it.

So you may use MFD to register the (regulator, clk, card reader) child
devices, but pretty much none of that *functional* code belongs in
drivers/mfd.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
