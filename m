Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF71C3F2C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50261246A2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 22:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0nmU5d8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgB0W3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 17:29:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45802 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729850AbgB0W3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 17:29:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so569879pfg.12;
        Thu, 27 Feb 2020 14:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dAKQtQFMwvA4in1IKX12aA2LxpzkOZ3DeV5aYoLW1Dk=;
        b=a0nmU5d8Fqui67x7EDMrxyRLgET/G0iEKZQ3fHRK/3Dou0wE6XBiu9qf3bM08cfP6D
         /qzbSszn/RqpuBqcbVC38AaKcMIxx2t+aRQ9BuilhnT+bm4NDiyniMAVGrW5xNkH2lQ3
         v376HxpgeUt0aQI5qpIQU80drCyrzsf4PKMVY7JtmLHX2PfuOOkuzUbT0ODcIbO4ACFK
         r1D65ggKF/4q/Y77n5lN02m+1wW3RwkBkcjmYy7sSKjgDTWZMOQh41RY7Qt+eRoa1MPv
         f2ZBhfq6NThumXvbKk2/QKyT/YlxdBpgGA5Ms52RO1xNhHrbwdBMFxEuYjO6ZAkHkV/k
         35jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dAKQtQFMwvA4in1IKX12aA2LxpzkOZ3DeV5aYoLW1Dk=;
        b=oi6xq7QJGkOf2zU8pwdvRRfONMhLVf34T1z5U5eIeiuKHK2w8NVHLa1Z5YC6BG7ERF
         00NfS2O5N3Sf/H9eX61UiTseD/AabG3BILmJVrJqHKpcVjKgG24st0rk9yLUFQCqxWJL
         k1I3Y3oeD3fF6TSZo/Ih1FCQtr6ItXpJWd5+bGnHhE2sfdgBvW2cyw7P43WTtu7Fe4wH
         Md4LhRlSKMqNYzxEwT2rW34mjpHz7XsAzxEKCm9s3KjzJieF0wgC9H4tdpoMSO7C5vSy
         hVcXswnBd9WFlZrGvqxit0400jIQXgx/LUREBZ9Gcg0Yy+wV2JGk17bkZLjjwev7/mSf
         EQOA==
X-Gm-Message-State: APjAAAXGo29KcjjNlq3ZLYuSDjcz8vUw1jbkvf3D2k6Z3GsHbIbtuGaZ
        exW1bDTdJyp6vROnVG/EboY=
X-Google-Smtp-Source: APXvYqwCjo4NWg/n1zmJDAcIKJ2UE6VbP7KCZK4B2tzXfKC/iHPldab23u/RzAE40bqfKpBKWNJKFQ==
X-Received: by 2002:a63:2c85:: with SMTP id s127mr1480287pgs.138.1582842580284;
        Thu, 27 Feb 2020 14:29:40 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:500::4:d8f5])
        by smtp.gmail.com with ESMTPSA id 136sm7794224pgh.26.2020.02.27.14.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 14:29:39 -0800 (PST)
Date:   Thu, 27 Feb 2020 14:29:32 -0800
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
Subject: Re: [PATCH v4 2/7] usb: gadget: aspeed: read vhub properties from
 device tree
Message-ID: <20200227222931.GA29420@taoren-ubuntu-R90MNF91>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
 <20200226230346.672-3-rentao.bupt@gmail.com>
 <b9b8977ae185ca944e703721d93b8d8464d1475f.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b8977ae185ca944e703721d93b8d8464d1475f.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Thu, Feb 27, 2020 at 03:09:01PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2020-02-26 at 15:03 -0800, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > The patch introduces 2 DT properties ("aspeed,vhub-downstream-ports" and
> > "aspeed,vhub-generic-endpoints") which replaces hardcoded port/endpoint
> > number. It is to make it more convenient to add support for newer vhub
> > revisions with different number of ports and endpoints.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> With one minor nit that can be addressed in a subsequent patch (see
> below)
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks for the help on the patch series.

> > -		if (istat & VHUB_IRQ_DEVICE3)
> > -			ast_vhub_dev_irq(&vhub->ports[2].dev);
> > -		if (istat & VHUB_IRQ_DEVICE4)
> > -			ast_vhub_dev_irq(&vhub->ports[3].dev);
> > -		if (istat & VHUB_IRQ_DEVICE5)
> > -			ast_vhub_dev_irq(&vhub->ports[4].dev);
> > +	for (i = 0; i < vhub->max_ports; i++) {
> > +		u32 dev_mask = VHUB_IRQ_DEVICE1 << i;
> > +
> > +		if (istat & dev_mask)
> > +			ast_vhub_dev_irq(&vhub->ports[i].dev);
> >  	}
> 
> The 2400 and 2500 have very slow cores and every cycle counts in that
> interrupt handler from my experience. I would sugggest you generate a
> "mask" of all the device interrupts for enabled ports in struct vhub
> and AND istat with that mask before going through the loop. Either that
> or use find_next_zero_bit...
> 
> I wouldn't gate merging this patch on this, it can be a subsequent
> refinement.

Got it. I will take care of the improvement in a follow-up patch.

Cheers,

Tao
