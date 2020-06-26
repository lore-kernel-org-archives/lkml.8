Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98C8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F4F207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Exo588RY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgFZMd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgFZMd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:33:57 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F612C08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:33:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d10so4233313pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 05:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QIrPElFOoGOkG8/yu4vipgcYcnZC8OQgtGOaryS+ejA=;
        b=Exo588RY5BBvn/tEP2XnLCrnhhaTQBj+mdvD0AQNbFTSuXT4iSAJ76V8mLK24Zl/ds
         dRaUriAoSqXpmiQnsIBvF5E6pogKYrmWVoszZC1LjkDzs5Ck+NT4g/wfiLVRpxfK723p
         I1j1TZScRSo4W4TnVnOhnAafQfljpLcMmmakZkaILQXYewUZsitRw9RSWevgDNbOzYdE
         mNYbhHpyAESoAV386tY9i2lDolZMagafjAP07cIDobltj0am0eEMs1AvokHgEgg3K6Gx
         XRuUW98P749/QE7gUmj8IBpei0EcoEyaZ1S4TpgG5+gqTJG0kSgm75qoKCo2ZGm01nHv
         0evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QIrPElFOoGOkG8/yu4vipgcYcnZC8OQgtGOaryS+ejA=;
        b=AM1n+Qbuy3zJ3J6N5vxduQOyCFYa3b+QNY5GvXhKjefuHMKLRt9pF/bKIIkT46LnYs
         QCWnX7X52MXjUBZ4Tx7vncpiId2paF0/3nd6BmnoPrBq2/DGgBjtN1Ih8AZAqFpgbOoV
         NL2Ao/0hPBwVI2kTX/870/CEYWaQ7b9be7rcfM1xRd5fuWgtVIJiqAPpHDmJKRZcDB6b
         LCZcy9YjhDoPPlyEC7v98EC48r95a3XpKbXGTPhrk0BDSYuT5TTKJXa8rL4/m097XggQ
         wgEx8nMVd+28zVxOqAAGqr5kB+lINTXWLaMF+7sAdrqO4RaRl+In9Pjo21JkIcdyt8MY
         holQ==
X-Gm-Message-State: AOAM532rMHYCZp+zEREzoNN9ZADKi6Qd6Evgpm5kzhSdZETwYY3Nw5jB
        Of1QAEEw2qKH8nZqH/D55og=
X-Google-Smtp-Source: ABdhPJyeT84DHG/dM9KZ48m7blL63YnCjnBsNKVZTzsgDlp4WiwTQsvQvWWf+ZCitZDX4ToCCFRldg==
X-Received: by 2002:a17:902:aa09:: with SMTP id be9mr2343018plb.206.1593174835998;
        Fri, 26 Jun 2020 05:33:55 -0700 (PDT)
Received: from localhost ([216.24.184.172])
        by smtp.gmail.com with ESMTPSA id q6sm917980pfg.76.2020.06.26.05.33.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jun 2020 05:33:55 -0700 (PDT)
Date:   Fri, 26 Jun 2020 20:33:51 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1] reset: intel: fix a compile warning about REG_OFFSET
 redefined
Message-ID: <20200626123351.GA24630@nuc8i5>
References: <20200604153039.22957-1-zhengdejin5@gmail.com>
 <69be7e39936ced4501107aeff6a93ca930e62f49.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69be7e39936ced4501107aeff6a93ca930e62f49.camel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 12:38:13PM +0200, Philipp Zabel wrote:
Hi Philipp:

Thanks very much for your review!

> Hi Dejin,
> 
> On Thu, 2020-06-04 at 23:30 +0800, Dejin Zheng wrote:
> > kernel test robot reports a compile warning about REG_OFFSET redefined
> > in the reset-intel-gw.c after merging commit e44ab4e14d6f4 ("regmap:
> > Simplify implementation of the regmap_read_poll_timeout() macro"). the
> > warning is like that:
> > 
> > drivers/reset/reset-intel-gw.c:18:0: warning: "REG_OFFSET" redefined
> >  #define REG_OFFSET GENMASK(31, 16)
> > 
> > In file included from ./arch/arm/mach-ixp4xx/include/mach/hardware.h:30:0,
> >                  from ./arch/arm/mach-ixp4xx/include/mach/io.h:15,
> >                  from ./arch/arm/include/asm/io.h:198,
> >                  from ./include/linux/io.h:13,
> >                  from ./include/linux/iopoll.h:14,
> >                  from ./include/linux/regmap.h:20,
> >                  from drivers/reset/reset-intel-gw.c:12:
> > ./arch/arm/mach-ixp4xx/include/mach/platform.h:25:0: note: this is the location of the previous definition
> >  #define REG_OFFSET 3
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Fixes: e44ab4e14d6f4 ("regmap: Simplify implementation of the regmap_read_poll_timeout() macro")
> 
> Hm, shouldn't this rather be:
> 
> Fixes: c9aef213e38c ("reset: intel: Add system reset controller driver")
> 
> even though e44ab4e14d6f4 triggered the issue by including iopoll.h?
>
Ok.

> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > ---
> >  drivers/reset/reset-intel-gw.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/reset/reset-intel-gw.c b/drivers/reset/reset-intel-gw.c
> > index 854238444616..5cfb4892b399 100644
> > --- a/drivers/reset/reset-intel-gw.c
> > +++ b/drivers/reset/reset-intel-gw.c
> > @@ -15,7 +15,7 @@
> >  #define RCU_RST_STAT	0x0024
> >  #define RCU_RST_REQ	0x0048
> >  
> > -#define REG_OFFSET	GENMASK(31, 16)
> > +#define REG_OFFSET_MASK	GENMASK(31, 16)
> >  #define BIT_OFFSET	GENMASK(15, 8)
> >  #define STAT_BIT_OFFSET	GENMASK(7, 0)
> 
> Could you add the _MASK suffix to BIT_OFFSET and STAT_BIT_OFFSET as
> well, for consistency?
>
I will add it in next patch version. Thanks!

BR,
Dejin

> regards
> Philipp
