Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB1C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9529720787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eODaU84r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgDVNwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgDVNwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:52:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033E4C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:52:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n24so945264plp.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HEwMCGWH0xcjOsy5stWmc4ah1I0kvVQlv1OL97kZJ8E=;
        b=eODaU84rKvZhPtW1/2/UZuI04TESBOxyPQP2oM7DwYZNntzWY5+fYJdm5Ys6qJqy4x
         yQlNFZODFFEZZFONOFIawiVBwnGC4fcTAkFmiM00ED55/qe3faE4lT9LhAl2IRbszqm5
         tD8wB+DY8CtsDiH+7T3S2Z82lGX+iVB8169GRL/ZiclyDStdkkjz9Os918CAk+ccxzwv
         +05pvB4gpNOTBfR0c9Wr2iNg5y7PHldG1n0bRNEqtzhaYsa2NEMdkqyPieUHe7TRQ2hn
         zTvQxILcNHFCbiGYeWD1kot3rLRVtkr2AW43WHLtEAwdgbqf7GFVN0nbvG757o1/uLA7
         VuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HEwMCGWH0xcjOsy5stWmc4ah1I0kvVQlv1OL97kZJ8E=;
        b=WCJ2mqx64oFYwxVuwPABV0BS1fmeS1C/oGVDIqgIvhp9F778cCJtDcs5XhUOTYzvkU
         acL/iwE/hw75K8BORx01JIJKCNgVCku6D1+dGfx4wTXPHOup3OrZ+D26+QnatyFzTnhc
         szAZCte/KwG0KgoALMc5TM6Ujy1qF67ZbLSTZyDu3ocpgVnDuSBWcNyvX4bUx0ARXSsk
         zDyQ+D2xfV7c4MLen4wPWkxam/zIX2nuLeKkmg/vqF7UYc1lSc9RrqGUBfDm8c4ttCn6
         GyqpmPP3iRLDVmz7cNU5xGKTUxbQusNwvKV5zWq949cMjkE7OL9YXEa+JGFvCnvWBEnZ
         DasA==
X-Gm-Message-State: AGi0PuYHSVCsmetQzMDJsoFRS9h8RJ2QjwuD9OYeYRuX75shUZ/AEphg
        eSqFWmwGEoQYLCCzLgZkZIA=
X-Google-Smtp-Source: APiQypK46J2JZt/QDCU3a/7EQZIhcDY2YqHNsCHaS5xB+ir5i4TYKlDP8o0KoPRDGmMgr1lTZwTX5A==
X-Received: by 2002:a17:90a:20ea:: with SMTP id f97mr5952983pjg.157.1587563541569;
        Wed, 22 Apr 2020 06:52:21 -0700 (PDT)
Received: from localhost ([89.208.244.140])
        by smtp.gmail.com with ESMTPSA id w126sm5547847pfb.117.2020.04.22.06.52.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Apr 2020 06:52:21 -0700 (PDT)
Date:   Wed, 22 Apr 2020 21:52:15 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kraxel@redhat.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] drm/bochs: fix an issue of ioremap() leak
Message-ID: <20200422135215.GA25950@nuc8i5>
References: <20200421164543.16605-1-zhengdejin5@gmail.com>
 <CAHp75Ve4JwkM+=WHHF73jwNwRS39E-xPDrcn77zCUTpVkj8buA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve4JwkM+=WHHF73jwNwRS39E-xPDrcn77zCUTpVkj8buA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 08:24:24PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 21, 2020 at 7:45 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
> >
> > It forgot to call bochs_hw_fini() to release related resources when
> > bochs_pci_probe() fail. eg: io virtual address get by ioremap().
> 
> Good start, although I think the best is to switch this driver to use
> pcim_*() functions and drop tons of legacy code.
>
Andy, thanks for your encouragement, I think we might be able to fix this
issue first, after that, drop tons of legacy code by pcim_*() functions.
Do you think it is ok?

BR,
Dejin

> > Fixes: 81da8c3b8d3df6 ("drm/bochs: add drm_driver.release callback.")
> > CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > ---
> >  drivers/gpu/drm/bochs/bochs_drv.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> > index addb0568c1af..210a60135c8a 100644
> > --- a/drivers/gpu/drm/bochs/bochs_drv.c
> > +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> > @@ -138,6 +138,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
> >         return ret;
> >
> >  err_unload:
> > +       bochs_hw_fini(dev);
> >         bochs_unload(dev);
> >  err_free_dev:
> >         drm_dev_put(dev);
> > --
> > 2.25.0
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
