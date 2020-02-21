Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AF1C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B5224654
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVv11Zk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgBUAVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:21:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36780 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbgBUAVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:21:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so264389pfv.3;
        Thu, 20 Feb 2020 16:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a4/ljhrEhbsVqKPnJ2k+YSVwNBU/denU+0a+fK/lh98=;
        b=EVv11Zk8AYB9hS7c/Lkhd52HNoMejxxMg8MSwFwHJcv1rgn10PAhKhBkvQKJZ9BaG4
         NskY5M0YE8o7EDmxnYtEItF+4qEF9oy85BAypdcQLsWCfoUN5s6/K5sf4UBUKmZFHt21
         sPDTaDsivhrGrdnpq+r/7LFFJ6iUnNpEAJYJXg8Ee0SInqr6LR18ucHGaTIv12TSpOY7
         T3kbv9FZQGel1oR9RlWLR13Zh+N6dF1UN7NKb9P1kVE3+7PHhjs68qRSxLFcCG6rbc83
         bG7S9Xx0Y70mXDOROUbqjhVu+2fpCEoIw+v7N18ETcmTnwuHDxcgjGu+SiaRh2I9/UOe
         84zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a4/ljhrEhbsVqKPnJ2k+YSVwNBU/denU+0a+fK/lh98=;
        b=V80Bz0ZGMAnZBahABZ3L77yb8lFytDXCSKBA7nBPtQ28Vkz5vVJAvwyKnEFtcUl8Om
         XByd7hpJ5nnSJYutV5FCNeJS7+NL0FHedFxuYKjpWPVe4WuFgZ6H43cYLWLiYoI1TP0/
         epJCNra9iCkmKhIjfl+AgLdMuyXKAnhLbL3yuK1Nt2BcJOe8wBXaqBGRG40DP/CqJ35v
         babkNFvxu05nCz+7SQChrM+tcfbiL8nhAodwHoa20nqz23R2ZSrOHXS46aPQ1UXF30rD
         i+rRrsyWeo9NJW/Ge0Uls04j7ehAGU/B+stw5QM5DjUbl89/LaJezADPwWEsSFSE3ALX
         mpSw==
X-Gm-Message-State: APjAAAVkeBNq2on4geQysTic6leQngP62LjxTQPQDhg3WC6qUO5jZIw9
        ZFUQjsiVuuzds+nbV7RQFJ0=
X-Google-Smtp-Source: APXvYqyjiF/VG6y/NeQCdPXrhpSws4JsxzMcf4IkrfSRa3KYM7f7ExChm9MNA6NOGinrsiWkqQIdvQ==
X-Received: by 2002:a63:3e05:: with SMTP id l5mr35763336pga.293.1582244463971;
        Thu, 20 Feb 2020 16:21:03 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:500::6:8f30])
        by smtp.gmail.com with ESMTPSA id t11sm541459pjo.21.2020.02.20.16.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 16:21:03 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:20:59 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Subject: Re: [PATCH 2/2] usb: gadget: aspeed: fixup usb1 device descriptor at
 init time
Message-ID: <20200221002059.GB7815@taoren-ubuntu-R90MNF91>
References: <20200218235600.6763-1-rentao.bupt@gmail.com>
 <20200218235600.6763-3-rentao.bupt@gmail.com>
 <55e77bcb37ec780094b8d226f89bd5557e30d913.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55e77bcb37ec780094b8d226f89bd5557e30d913.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:39:45PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2020-02-18 at 15:56 -0800, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > This patch moves fixup-usb1-device-descriptor logic from get_descriptor
> > handler to "ast_vhub_fixup_dev_desc" function so the device descriptor
> > is only patched once (at vhub init time).
> 
> I don't like this either. We should make ast_vhub_dev_desc and patch a
> copy here too. I know today there's only one instance of the vhub in a
> given SoC but that might not always be the case.

Sure. I will introduce per-hub descripor instances in patch v2.


Cheers,

Tao
> 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >  drivers/usb/gadget/udc/aspeed-vhub/hub.c | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > index 4e3ef83283a6..b8bf54b12adc 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > @@ -76,13 +76,6 @@ static struct usb_device_descriptor ast_vhub_dev_desc = {
> >  	.bNumConfigurations	= 1,
> >  };
> >  
> > -/* Patches to the above when forcing USB1 mode */
> > -static void ast_vhub_patch_dev_desc_usb1(struct usb_device_descriptor *desc)
> > -{
> > -	desc->bcdUSB = cpu_to_le16(0x0100);
> > -	desc->bDeviceProtocol = 0;
> > -}
> > -
> >  /*
> >   * Configuration descriptor: same comments as above
> >   * regarding handling USB1 mode.
> > @@ -316,10 +309,6 @@ static int ast_vhub_rep_desc(struct ast_vhub_ep *ep,
> >  	if (len > dsize)
> >  		len = dsize;
> >  
> > -	/* Patch it if forcing USB1 */
> > -	if (desc_type == USB_DT_DEVICE && ep->vhub->force_usb1)
> > -		ast_vhub_patch_dev_desc_usb1(ep->buf);
> > -
> >  	/* Shoot it from the EP buffer */
> >  	return ast_vhub_reply(ep, NULL, len);
> >  }
> > @@ -878,6 +867,15 @@ static void ast_vhub_fixup_dev_desc(struct ast_vhub *vhub)
> >  		if (of_str[id])
> >  			ast_vhub_str_array[i].s = of_str[id];
> >  	}
> > +
> > +	/*
> > +	 * Update USB Release Number and Protocol code if vhub is running
> > +	 * at USB 1.x speed.
> > +	 */
> > +	if (vhub->force_usb1) {
> > +		ast_vhub_dev_desc.bcdUSB = cpu_to_le16(0x0100);
> > +		ast_vhub_dev_desc.bDeviceProtocol = 0;
> > +	}
> >  }
> >  
> >  void ast_vhub_init_hub(struct ast_vhub *vhub)
> 
