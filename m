Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8F0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B757A20780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 10:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcB1Osga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgGBK1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 06:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgGBK1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:27:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46FBC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 03:27:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so27532146wrv.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 03:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=43XB0eC1/F767YChsoswsUl8WKG5LpvTnDvwDbF5waY=;
        b=lcB1OsgavV6AS6xXpHASRHbQIS9mdi+5CWDIKAPK6byFGjS2kShfucTE6wRte8SXdA
         xnb/NH/QzB1T34ITNbyEh9iRkUFAasKd/cDPVKWtG9msCV4MWqkj0MBQnVKb6bxSqw0X
         Jinj71DqZs8L9cvTp+vcCb0iHjTPx1QKxEE2mmwWnKDodM7YZE4biJv01RwYPOuosSHm
         GWnWTrjgzmvp0fsRu310N6f7b/oQTXQYjYiivWeAOJ+05ZWNWq0sZDLJjIeZpI8GStFq
         t4rmjQn0HjLvuTLx3g9Kbek7aYxR7kXcRPexu4CJDJ0Kp9qW66pvjCP/gmVErnjkReQt
         o6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=43XB0eC1/F767YChsoswsUl8WKG5LpvTnDvwDbF5waY=;
        b=cyxoboEu8Kys9sP/PKkbwzMIZmzsIFjSmV7gVP4nlj0XRN4TEqnsaxAubXUb/r3VG9
         VlJV9EBqdLSRxbBSkmcpZyQ9z4d2gydGflUfSunRQRFE/O+WNFzWAkx1D0zsTZurWqGd
         hczLYwW+j8UEPysX+P5hIlMbmX6y1hQvkd7ELR4pCJG0+E7PmQuLF/Nz/aeoRUJbqAul
         dmjUs06E0yd2gxlYHhxNDKBj7RqJraLLSj+IFmQ0ayqhaf6G8QtvbX+L4MU4TPTNAtoQ
         UFIa0hcOWeZ7jSIO3E26bmtM4z5mKrPxpkYc0fKZmsuFmqbymghHbpvtQdfzAP0YBV6y
         82Rw==
X-Gm-Message-State: AOAM533uJPPW+umSxpYnhnc2adRn6jmFhMvEJDa3QZmJol4N4EWpo1TS
        6iLOTyEpAm3MgMTq6hEgpLlZ+A==
X-Google-Smtp-Source: ABdhPJxfvipf12m9Fun1ABvXSxv8cHUNe7t7xgAGmyrBPnhrmnJtU/sJ2LuWrBq69N6HUDPIIlbzwA==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr1728275wrs.368.1593685671492;
        Thu, 02 Jul 2020 03:27:51 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 65sm10874282wre.6.2020.07.02.03.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 03:27:50 -0700 (PDT)
Date:   Thu, 2 Jul 2020 11:27:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     jic23@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        matthias.bgg@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, dmurphy@ti.com, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: Re: [PATCH v2 2/4] mfd: mt6360: implement i2c R/W with CRC
Message-ID: <20200702102748.GS1179328@dell>
References: <1592567631-20363-1-git-send-email-gene.chen.richtek@gmail.com>
 <1592567631-20363-3-git-send-email-gene.chen.richtek@gmail.com>
 <20200701071620.GQ1179328@dell>
 <CAE+NS35Kj_H9uSgBiff4hogTWmwh6z+vmPNWDh_yU1=p68xQZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS35Kj_H9uSgBiff4hogTWmwh6z+vmPNWDh_yU1=p68xQZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jul 2020, Gene Chen wrote:

> Lee Jones <lee.jones@linaro.org> 於 2020年7月1日 週三 下午3:16寫道：
> >
> > On Fri, 19 Jun 2020, Gene Chen wrote:
> >
> > > From: Gene Chen <gene_chen@richtek.com>
> > >
> > > imlement i2c R/W with CRC when access sub-device PMIC and LDO part
> >
> > Please use proper grammar, including capital letters at the start of
> > the sentence and for abbreviations such as "I2C" and full stops.
> >
> > Also this doesn't make sense to me.  Please elaborate.
> >
> 
> ACK
> 
> > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > ---
> > >  drivers/mfd/Kconfig        |   1 +
> > >  drivers/mfd/mt6360-core.c  | 541 +++++++++++++++++++++++++++++----------------
> >
> > This patch is doing way too much wacky stuff all at once, making it
> > very difficult to review.  Please break it up into functional pieces
> > and submit as separate logical patches (in a set of course).
> >
> 
> If I understand correctly, I need to separate patch[2/4] but not
> entire mt6362-core.c into several patches.

Yes please.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
