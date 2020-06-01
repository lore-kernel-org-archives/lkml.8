Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9214EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1EE207BC
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1hiY3b/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgFAKsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 06:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFAKsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 06:48:02 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33588C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 03:48:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v19so10254979wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bT7R0f7BWGyBr0hAgst5dbbqM0UFMd8eOqwAQcny++Y=;
        b=n1hiY3b/F9RSBA2LKSUHu50hrgZKUYCCzPijRinlQPN7vTuclEgSXpkd496DiV7DP1
         DsxASmAvZRJEz5unbMmJguOXqfqTDEWMfdjGhFe1a/iyiJ0KZCWAo2E1tS/QffBHWx2l
         zL88lKQaxGRYigG0p70gnw9iIhV8ePSiBNicR53p8ytbREuLE49cQ3MnI3jthYftNRbD
         azoZlE+c08vQPlbq+YKBPpcsjkP4C8lNxwg3rv1tGSB+ctAuuY6bZqaE81WF2f25Zffg
         Tl7bWSKY/bsU0hLQmYdwX/YtEykaPphPNzIx8hUCbH7WH9TQgzUId1g2LKlq/9uDYIEn
         Ir2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bT7R0f7BWGyBr0hAgst5dbbqM0UFMd8eOqwAQcny++Y=;
        b=NqgZd+1y727v9IFoRFn0YphThtQ/h87bxRNB5/n9bRHGDgxDsd0vBkCX5UR001wQLs
         e5JYyrdHe6IEv5LIUzR73fvnbZOrBO5RFRz1mU+monXkIAnDTzrqkpnKHRB266S2VJQ7
         7t7CFQlgM6XHt+08MToRLB5184DK9gPCEAgNcajFjKTu3f0Uq3r8txJ+fNKJ6lddIHzr
         DF5+Po54tqIR6WAwZLQlwrI7sYfG71WX2IgA7YYWCAixNvrBhdLFXvMq8CZdg9PsEJ9J
         eS6uZsbNb8hIkjsQlfI7k8s7TQaX8EFUDTUP1hGm6vDqcZ/4V4MYSCOuG7mGwxRUEciQ
         bbAA==
X-Gm-Message-State: AOAM533sgYvcOwbulol2ypVmdNAJUz4ivgMG/oob0mv4YxEdjT+bsIFe
        5QNl+Ht8uzqqfofwWZEJe0dA++pCSac=
X-Google-Smtp-Source: ABdhPJy2Xw2o3vUtl1c+9sf4p9kJamyGwx2iHcUey0vj9MBt+fKbvfw8ZDa3QzhZp/+ZUQJs64mp0w==
X-Received: by 2002:a05:600c:2944:: with SMTP id n4mr22133991wmd.135.1591008480836;
        Mon, 01 Jun 2020 03:48:00 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id y66sm10951262wmy.24.2020.06.01.03.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 03:48:00 -0700 (PDT)
Date:   Mon, 1 Jun 2020 11:47:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     s.nawrocki@samsung.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 2/3] mfd: madera: Fix minor formatting issues
Message-ID: <20200601104758.GB3714@dell>
References: <20200529155742.18399-1-ckeepax@opensource.cirrus.com>
 <20200529155742.18399-2-ckeepax@opensource.cirrus.com>
 <20200601052433.GA3714@dell>
 <20200601095443.GJ71940@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200601095443.GJ71940@ediswmail.ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Jun 2020, Charles Keepax wrote:

> On Mon, Jun 01, 2020 at 06:24:33AM +0100, Lee Jones wrote:
> > On Fri, 29 May 2020, Charles Keepax wrote:
> > 
> > Still needs a commit log.
> > 
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > ---
> > >  drivers/mfd/madera-core.c        | 12 ++++++------
> > >  drivers/mfd/madera-i2c.c         |  1 -
> > >  include/linux/mfd/madera/pdata.h |  1 -
> > >  3 files changed, 6 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
> > > index 7e0835cb062b1..4724c1a01a39f 100644
> > > --- a/drivers/mfd/madera-core.c
> > > +++ b/drivers/mfd/madera-core.c
> > > @@ -44,7 +44,7 @@ static const char * const madera_core_supplies[] = {
> > >  };
> > >  
> > >  static const struct mfd_cell madera_ldo1_devs[] = {
> > > -	{ .name = "madera-ldo1" },
> > > +	{ .name = "madera-ldo1", },
> > 
> > What issue does this solve?
> > 
> > Why are ','s a requirement, even for single entries?
> > 
> 
> Was more just a consistency thing, we seem to have ended up with
> half the lines having commas and half not, happy to move them all
> to not having comma's if that is your preference?

I don't have a preference.  Consistency is more important to me.

Please describe your changes in the commit log.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
