Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B43C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115F42074D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qa/JjpNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbgCLAJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:09:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39632 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLAJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:09:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id j20so1873770pll.6;
        Wed, 11 Mar 2020 17:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9ApGOF5PBkyoeBPogSoc/7/ab/yJXEM4Uq6xzW0uckE=;
        b=qa/JjpNbOa07fUsB4jPdLDm52/jZZEQRH9wlnggCo8DYirC2AP/CxM7bIpeGf+pTsZ
         Uv9+2rKZqzD67ItMqFhBlkKxIM3pO4GTO/b21mX73+MdeJ8hXW9aA30m/c7gsxNFkmvY
         2l3HzKT7rZseU2snFyYgrJqHPN997zzhpWRiGk0t+jriJZeQ3BOe/fmG//AR7IdLhdFr
         uQzd7AOSjXIYBl7IBeG3pQGBBvzaLhYsBEqU4s+4zR1iUyentr12iqjc2dKsAzemOigy
         iZ6MrnT4onYr65Ude8HVtSsE4M05XvWBLKobbUKLxWtQ+JleX207ym20znvdc2QktO4I
         g/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ApGOF5PBkyoeBPogSoc/7/ab/yJXEM4Uq6xzW0uckE=;
        b=YUG1Kq1UZ+prDqZwEjuFB0cFS+/Z+xMDNN/06MwmJmi9uLavE6pEYQJMbSsl+cBWQc
         9byuM/Pu3yNbdwayZE4Ih7fQBKQaRU0KqhOuWktZ0uT0zROjaligoNrGhoeL2WwqPAm7
         pNGzUnxTJjmgVSOJabrPvzkDhGlM0y2SNedAyCwL3WYxOqG9iyYyCrygDQdtssdlthRJ
         ZWeMWoMrXDqQ67GbU48FQ6/nsPtmuhCwC9p3UXzGG27CeLzvWulEGRm2upgkI1+n/9mc
         CN5NV2JZmjAlOO/loQDTLhQakmD0R7xoOOn7SJkh8+XtXAkC2MzwJdDIZOoFpr9P/bXj
         G27A==
X-Gm-Message-State: ANhLgQ1J8Hj/svtUJQ+mbd5lKDpstkXGE9+JsemWRlDdz1HtYczHh2Pa
        f0WIaI30Y16BJn7CsTK7pN0=
X-Google-Smtp-Source: ADFU+vtML21USPDOMZ+PmnB2abZahmaHnFt3ItHVXPSoef4wnUi8Xp1UT2B8XYgt+E7etOPYpGvc6g==
X-Received: by 2002:a17:902:d88d:: with SMTP id b13mr5144514plz.228.1583971779921;
        Wed, 11 Mar 2020 17:09:39 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-24-4-25-55.hsd1.ca.comcast.net. [24.4.25.55])
        by smtp.gmail.com with ESMTPSA id e11sm9957036pfj.95.2020.03.11.17.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 17:09:39 -0700 (PDT)
Date:   Wed, 11 Mar 2020 17:09:31 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Subject: Re: [PATCH v2] usb: gadget: aspeed: improve vhub port irq handling
Message-ID: <20200312000930.GA3956@taoren-ubuntu-R90MNF91>
References: <20200305234746.1002-1-rentao.bupt@gmail.com>
 <481e9b7d40c51505518a34ddc2515d3200dbf158.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <481e9b7d40c51505518a34ddc2515d3200dbf158.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Wed, Mar 11, 2020 at 12:31:22PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2020-03-05 at 15:47 -0800, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > This patch evaluates vhub ports' irq mask before going through per-port
> > irq handling one by one, which helps to speed up irq handling in case
> > there is no port interrupt.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >  Changes in v2:
> >    - use "for_each_set_bit" to speed up port irq handling.
> > 
> >  drivers/usb/gadget/udc/aspeed-vhub/core.c | 11 ++++++++---
> >  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  8 +++-----
> >  2 files changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > index f8d35dd60c34..af2dbd405361 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > @@ -134,11 +134,14 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
> >  	}
> >  
> >  	/* Handle device interrupts */
> > -	for (i = 0; i < vhub->max_ports; i++) {
> > -		u32 dev_mask = VHUB_IRQ_DEVICE1 << i;
> > +	if (istat & vhub->port_irq_mask) {
> > +		int offset = VHUB_IRQ_DEV1_BIT;
> > +		int size = VHUB_IRQ_DEV1_BIT + vhub->max_ports;
> >  
> > -		if (istat & dev_mask)
> > +		for_each_set_bit_from(offset, (unsigned long *)&istat, size) 
> 
> That type cast is very bad. It will not work on big endian for example
> (yes this driver isn't used on big endian today but still).
> 
> Please assign istat to an unsigned long (or make it unsigned long to
> begin with).

Thanks for pointing it out. Will fix it in v3.

Cheers,

Tao
