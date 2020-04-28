Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5902DC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277B720661
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1StGchj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgD1HOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgD1HOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:14:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87C9C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:14:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d17so23337901wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MS2o89rPX08fYfLG56pnKr91VCgwEiweba5HnccU9ZY=;
        b=G1StGchj6YAW1ze/OrIrILEJzpeXsicEtD4oGcWyIGFpfJ+EPofToUYVrvEyhlvJbE
         WSXT0g+0OzVtQhxGSKdLTgDaRWpp5+av8l249FJcFr6DS1CMmH1/5s8iWjXPgTcNCw10
         4CFkO2DJMIB8mwxjCwV7KpEhULORcPvxj7R4vlG7eTvhXJcreESVeNzD7P4FNRbes2Xe
         Q+++dP9EQHBlcY8JIMNVZczd+5HaMDdGCVJxcYjTuQfivY+YSXiIbsGCzn92SItilBvc
         cu2RclbU0a/8vvXEov68dyZu3nIH/dj4Pn7p2YVkXXLFO1lHt6dsAHQzQZCszRguQCr6
         D68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MS2o89rPX08fYfLG56pnKr91VCgwEiweba5HnccU9ZY=;
        b=uQgr6W5edugcuhQRJjaZbxfocdjb0TEnP0MmKJZv0WpAF5dsUMS0HDpyErswk5Y4rm
         nM1w3LUhsqp35IV+gqJ9OLP9O5oCg8ZtwSEUeG2Zo2RghDzwNBsQGUpQXRcX1Ov9Xbzq
         RdfloKRpEIa39bUzchAX97uhXl1mpHOO7pu7S+2GamgatjSkM7QtmQwCKhcbFTn6rszg
         xoTj17pcRKthLD3W5eX78VD4Noch17X3Ydd9YA7vz+NNJvfxbw0FCFTFqUL5086Rvi/F
         yGWtgMupOq2WkY2uo2noBz7I+qELLDXg7/+/2+EcUxiFzvzKox2ZhSjiqItsLsebrYqP
         WAmw==
X-Gm-Message-State: AGi0Puadi1J+Mghljz1rViGu37uJ7v3ZBGi18yPfQ+Q7mWSPkB8NfRzv
        Ol2k+6MQRfrZIQYaglojtF8EKXhMGDY=
X-Google-Smtp-Source: APiQypLogJ8rGITshHsXLcH0LuHNPeq7kANbK4kjgMSFMdJlyRndRqefSALVr8/vzkRFOUvdPCb9Ng==
X-Received: by 2002:adf:82f5:: with SMTP id 108mr30618064wrc.43.1588058089492;
        Tue, 28 Apr 2020 00:14:49 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id d7sm23722846wrn.78.2020.04.28.00.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 00:14:48 -0700 (PDT)
Date:   Tue, 28 Apr 2020 08:14:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mfd: syscon: Add Spreadtrum physical regmap bus
 support
Message-ID: <20200428071447.GJ3559@dell>
References: <c2fd765aa388d4510194ba02c017e39bde57c8d4.1587478171.git.baolin.wang7@gmail.com>
 <CADBw62rJ8VYTgnW_3q4=TkCyZx2B1DHsG+oOmiph8FLsukUROQ@mail.gmail.com>
 <20200427090518.GG3559@dell>
 <CADBw62qXtNnoNq0F1iZrvQHryMTy86GEqcD-qXBzsJJL-B8mQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADBw62qXtNnoNq0F1iZrvQHryMTy86GEqcD-qXBzsJJL-B8mQg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020, Baolin Wang wrote:

> On Mon, Apr 27, 2020 at 5:05 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Mon, 27 Apr 2020, Baolin Wang wrote:
> >
> > > Hi Arnd and Lee,
> > >
> > > On Tue, Apr 21, 2020 at 10:13 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > >
> > > > Some platforms such as Spreadtrum platform, define a special method to
> > > > update bits of the registers instead of read-modify-write, which means
> > > > we should use a physical regmap bus to define the reg_update_bits()
> > > > operation instead of the MMIO regmap bus. Thus we can register a new
> > > > physical regmap bus into syscon core to support this.
> > > >
> > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > >
> > > Do you have any comments for this patch? Thanks.
> >
> > Yes.  I'm not accepting it, sorry.
> >
> > I'd rather you duplicate the things you need from of_syscon_register()
> > in your own driver than taint this one.
> 
> Thanks for your comments and I can understand your concern. But we
> still want to use the standard syscon APIs in syscon.c, which means we
> still need insert an callback or registration or other similar methods
> to support vendor specific regmap bus. Otherwise we should invent some
> similar syscon APIs in our vendor syscon driver, like
> sprd_syscon_regmap_lookup_by_phandle/sprd_syscon_regmap_lookup_by_compatible.

So long as the generic driver stays generic.  Providing a registration
function sounds cleaner than tainting the code with vendor specifics.

> Arnd, what do you think? Thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
