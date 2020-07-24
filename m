Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D092C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1AE20674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqBrJCQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgGXQGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgGXQGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:06:45 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6E1C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 09:06:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f1so8243899wro.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qZJfAhP5RcYiO5VJpoh1/POga8l2SOHIu6lplyiVFBE=;
        b=aqBrJCQFa5B/aBq6qeyTr9fuyyBnA11Wl65/X50Q59SPxPvtajc3QcT3FN60PsABHA
         rt33VA1ynxONlttakPqkagTFx2H/rTB0Xa7GETBkZLm8XcLjHuLFI9vExLBIDA73FGML
         xTJXDudUbujENDQ+jJG0bWhnPoA5Wh8r7GbFAnIGxQXPeDjvlt29JfPpwRiWwi9JZM5P
         H7SQ7Z6+gHhYk+tUXSJnBTtu5FoTG125HjJBPdRRfPiwsQhwdROW+ecDzUAYKP3krH3m
         bdzMeFUS54BAFWV7I/UnKi5t5FBr3EA2WSnvfTmHGsIaHG/8HICHWuQHuWulcl00dRVB
         KcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qZJfAhP5RcYiO5VJpoh1/POga8l2SOHIu6lplyiVFBE=;
        b=G7GVVHha3wp4VP05QKiBto0Je+MM3jzwyH/W/erRZqK258AapDmwEiR9qQXpmlr4Xp
         /Le3zprkFadpMI32Av2HDAzXHqgrdqqMymeWJcCeyE6WUcX4bsa0XAbWb1Sj8VCmofLG
         /2aqsO4HKV8NZ1YhSIlK44t2ECDV4o4Aq/mPbgNEidM0N4y4O2WLbjO18f+rbZhKWNqR
         +JLcs3SQ0MNrjqb/O6hyUpBB4+e9dRIpdQQ9Lba8vglkRdrD4RM6onxEdTi9pEJzGVWl
         UundKtX2HefwLk2EBluWlFmkwqrgwwhQM6iKpbATfMYEof8ElBEZJte5AOgnbaY2Zyx4
         uQoQ==
X-Gm-Message-State: AOAM531ZK/ReRAkRAyAZwb1mzeGbjFJhzhNOhGbGY7xgZLqsoGJPZ20V
        UkX8Hti1Cne9PUgQnDrItG0CLQ==
X-Google-Smtp-Source: ABdhPJwm5w0NWI4nXGrF8b8IQJU/6d1yMLwWHQGb8NE9xQmPETxAvZPDq6tlRTseQWlLgJruMEi8wg==
X-Received: by 2002:adf:e486:: with SMTP id i6mr9068152wrm.258.1595606804047;
        Fri, 24 Jul 2020 09:06:44 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id p8sm1927886wrq.9.2020.07.24.09.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 09:06:43 -0700 (PDT)
Date:   Fri, 24 Jul 2020 17:06:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>,
        Tony Lindgren <tony@atomide.com>,
        Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v2] mfd: syscon: Use a unique name with regmap_config
Message-ID: <20200724160641.GB1850026@dell>
References: <20200127231208.1443-1-s-anna@ti.com>
 <20200224100037.GK3494@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224100037.GK3494@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020, Lee Jones wrote:

> On Mon, 27 Jan 2020, Suman Anna wrote:
> 
> > The DT node full name is currently being used in regmap_config
> > which in turn is used to create the regmap debugfs directories.
> > This name however is not guaranteed to be unique and the regmap
> > debugfs registration can fail in the cases where the syscon nodes
> > have the same unit-address but are present in different DT node
> > hierarchies. Replace this logic using the syscon reg resource
> > address instead (inspired from logic used while creating platform
> > devices) to ensure a unique name is given for each syscon.
> > 
> > Signed-off-by: Suman Anna <s-anna@ti.com>
> > ---
> > v2: Fix build warning reported by kbuild test bot
> > v1: https://patchwork.kernel.org/patch/11346363/
> > 
> >  drivers/mfd/syscon.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Waiting for Arnd to review.

Still waiting for some input from Arnd.

Might be worth submitting a [RESEND].

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
