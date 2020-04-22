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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3797C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D462082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZzzMniS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgDVPVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgDVPVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:21:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62386C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:21:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id q18so1232589pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HG3yYEiNc0envK1euxexUufAAl4nbvpE6zokSUWiokM=;
        b=nZzzMniSbj02OzHpHPqt7kEflsYgvSeEH9cTwn32djvqykD4v7ut2HI16jk3LX5r1m
         iGJjGN6nX4/mbNsBmDdw0/GVUxyLLmkkigSgSw1+asfeW49OyLUMk/Dt2QmHRTAgKHTS
         B1kmamcknz9dE0f2mrkp6MSfyryWNo0kaB9qEPmQzlI9ASonUsbSIQSf1XI+oK/44n8+
         FxFctYO1yg0MQxAHmqMb+igSj2MkWzVBP2KAG2cplRraTSkWMjMmFTPEuI59rtJ4YIn1
         NTPLjH6j4PDkayI4MHAtVfOe0VCbXyJou0UJcCJXkRbUUmTbwVZ9Lqwbh95+amDK5ISD
         SoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HG3yYEiNc0envK1euxexUufAAl4nbvpE6zokSUWiokM=;
        b=jt1DwU1+u4PjvZ03/+aMGK25nFZvyUbWq/vreGaF+dVjNEZuPXRTR652riitdmKpni
         lvELppjTB4uKSy5zii9KEUK1VobuvyxB3QnumF8JneDuvvIxCo9sHm6cJ0mVrsZ1CYsN
         e5vAPic6Q2f4OCHdsII/HuAAIQgfDTNizRTpIgISAbxU8L9VQmWMYlleIfHHnu50bO0Y
         sApH40ELAuWQyNuwKvcK6wIvXAAnQXx9vU4osCrF55ACrj9ouWfLL1zZVh3+7aKt4e5S
         RSXxR4ZCkcqvO/N0rcn8FmAO9XwbJUlsZEnG315MJ90Zt/Gh2NjYkwIJpueb6ncNv9lH
         oFyg==
X-Gm-Message-State: AGi0PubJLmZryL4nSVPp126lbvYesnBx7JBOtnmS9DidoznUE9U7drz8
        lJhlM1zy1lvqL3vrt9TlGy4=
X-Google-Smtp-Source: APiQypLh7oHfDORxCtqZwJwOyMBu9z4t1h/pwGHqNs7EvgsRntlz9Au3nusIGydC3+aAKxF7K73PSA==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr25840974pgh.53.1587568907934;
        Wed, 22 Apr 2020 08:21:47 -0700 (PDT)
Received: from localhost ([89.208.244.140])
        by smtp.gmail.com with ESMTPSA id 79sm5468092pgd.62.2020.04.22.08.21.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Apr 2020 08:21:47 -0700 (PDT)
Date:   Wed, 22 Apr 2020 23:21:42 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kraxel@redhat.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] drm/bochs: fix an issue of ioremap() leak
Message-ID: <20200422152142.GA26943@nuc8i5>
References: <20200421164543.16605-1-zhengdejin5@gmail.com>
 <CAHp75Ve4JwkM+=WHHF73jwNwRS39E-xPDrcn77zCUTpVkj8buA@mail.gmail.com>
 <20200422135215.GA25950@nuc8i5>
 <CAHp75Vf2j-QraBxKofgyhtAxpHXnik3DP9kefPhA_d3BuSjfvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf2j-QraBxKofgyhtAxpHXnik3DP9kefPhA_d3BuSjfvw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:40:51PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 22, 2020 at 4:52 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
> >
> > On Tue, Apr 21, 2020 at 08:24:24PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 21, 2020 at 7:45 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
> > > >
> > > > It forgot to call bochs_hw_fini() to release related resources when
> > > > bochs_pci_probe() fail. eg: io virtual address get by ioremap().
> > >
> > > Good start, although I think the best is to switch this driver to use
> > > pcim_*() functions and drop tons of legacy code.
> > >
> > Andy, thanks for your encouragement, I think we might be able to fix this
> > issue first, after that, drop tons of legacy code by pcim_*() functions.
> > Do you think it is ok?
> 
> It's really up to maintainer. I'm not the one here.
>
Thanks Andy.

Hi Gerd:

I am a newbie, andy gave me some directions to submit the patch, eg: check
ioremap leak. At this time, I found that the bochs driver may have similar
problems, so I submitted this patch, then, Andy said the best is to switch
this driver to use pcim _ * () functions and drop tons of legacy code.
I think we might be able to fix this issue first, after that, drop tons
of legacy code by pcim_*() functions. Can you give me some suggestions?
thank you very much!

BR,
Dejin

> > > > Fixes: 81da8c3b8d3df6 ("drm/bochs: add drm_driver.release callback.")
> > > > CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/bochs/bochs_drv.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> > > > index addb0568c1af..210a60135c8a 100644
> > > > --- a/drivers/gpu/drm/bochs/bochs_drv.c
> > > > +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> > > > @@ -138,6 +138,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
> > > >         return ret;
> > > >
> > > >  err_unload:
> > > > +       bochs_hw_fini(dev);
> > > >         bochs_unload(dev);
> > > >  err_free_dev:
> > > >         drm_dev_put(dev);
> > > > --
> > > > 2.25.0
> > > >
> > >
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
