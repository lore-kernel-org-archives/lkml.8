Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FE1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E742063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icCuRZwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgHQW4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgHQW4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:56:13 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4F1C061389;
        Mon, 17 Aug 2020 15:56:13 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f9so8347535pju.4;
        Mon, 17 Aug 2020 15:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u/EbLMfNqW+ecm7P7/+lVeVWoCyaxMA1ruHKaBP8G5U=;
        b=icCuRZwJpyEhTcs4ikvqOQkHvROTT02PWoLdjFa/HOzrnVkZU4wKLjhaMk2QwVvJ7U
         lk3Fp/gTh3pu2DtFl/jQGrUwY4obpqee+IiAVBiseYTfmHXpF/rtNXAPR2seeJEW4oDm
         83ygyGZTTwRb1elwEL1DBcfsBRpLogJoAs1A/ZVEeNxNT5aOgPbGO9TudnxdRe/7cotA
         OKJOxkaeekdBKkxgX6mKcuoAmUCNrUmZrugwWf/PcROdFvfbr9fGx42no6wlRy1vVH4P
         f5TfhOTVuTtkd8O053Dlauq6IgUauPKNXhdRC7nBSxc6ADoyCTKc/rPvkCoxAr7sujN2
         s32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u/EbLMfNqW+ecm7P7/+lVeVWoCyaxMA1ruHKaBP8G5U=;
        b=dZ3PLaYQoprXo2lN2nJ4LgUhpc7lBKH4dAE3op2tfyjG/832TwJOLn9zN6mbL0VcQ3
         At58nrrOmoupQ3pwNQDc5QjYzGdq0BReNuzqu7jJ50VxEaHKv/9N+yM2eQGh13Bf/ndD
         rGxa1cDm8PpVQxQXNYkEBb2YvnYU0yXdlsTTqqEqqqpyr+zMa7pAt7GXFXlhXuq3CEDR
         65V90UdWFq+IFGqqzx2PTpnFSRcEINfxBYAa26CglsGcLDHsOLy5Ns6z/kOYuFmqljNA
         vF1Bz47JgU2VPCQOta/3+fVDtUJxTJNXmoPQxa436uhuE9JrWassQuKTqUM94Vob4Asc
         nzOg==
X-Gm-Message-State: AOAM530buFdsN7YGGeCFy55vHJJ8OD2Z8WmyChQhhIJy9KBwuOGaj8gd
        Pli00UUojsPXx+ig6DH7Tq0=
X-Google-Smtp-Source: ABdhPJwZOWpNpkc4L+im7w0gYyzBUii1B7VuE8AWuGTbb1fmdzKaKgA2ZF5fn7Pjx0DMkuwkW7f7sA==
X-Received: by 2002:a17:90b:384b:: with SMTP id nl11mr14089528pjb.91.1597704971653;
        Mon, 17 Aug 2020 15:56:11 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id e142sm8475411pfh.108.2020.08.17.15.56.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 15:56:11 -0700 (PDT)
Date:   Mon, 17 Aug 2020 15:56:04 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Subject: Re: [PATCH] usb: gadget: aspeed: fixup vhub port irq handling
Message-ID: <20200817225603.GA21228@taoren-ubuntu-R90MNF91>
References: <20200528011154.30355-1-rentao.bupt@gmail.com>
 <875z9hz8k3.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z9hz8k3.fsf@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 04:49:32PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> rentao.bupt@gmail.com writes:
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > This is a follow-on patch for commit a23be4ed8f48 ("usb: gadget: aspeed:
> > improve vhub port irq handling"): for_each_set_bit() is replaced with
> > simple for() loop because for() loop runs faster on ASPEED BMC.
> >
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >  drivers/usb/gadget/udc/aspeed-vhub/core.c | 10 +++-------
> >  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  3 +++
> >  2 files changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > index cdf96911e4b1..be7bb64e3594 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > @@ -135,13 +135,9 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
> >  
> >  	/* Handle device interrupts */
> >  	if (istat & vhub->port_irq_mask) {
> > -		unsigned long bitmap = istat;
> > -		int offset = VHUB_IRQ_DEV1_BIT;
> > -		int size = VHUB_IRQ_DEV1_BIT + vhub->max_ports;
> > -
> > -		for_each_set_bit_from(offset, &bitmap, size) {
> > -			i = offset - VHUB_IRQ_DEV1_BIT;
> > -			ast_vhub_dev_irq(&vhub->ports[i].dev);
> > +		for (i = 0; i < vhub->max_ports; i++) {
> > +			if (istat & VHUB_DEV_IRQ(i))
> > +				ast_vhub_dev_irq(&vhub->ports[i].dev);
> 
> how have you measured your statement above? for_each_set_bit() does
> exactly what you did. Unless your architecture has an instruction which
> helps finds the next set bit (like cls on ARM), which, then, makes it
> much faster.

I did some testing and result shows for() loop runs faster than
for_each_set_bit() loop. Please refer to details below (discussion with
Benjamin in the original patch) and kindly let me know your suggestions.

> On Mon, 2020-04-06 at 23:02 -0700, Tao Ren wrote:
> > I ran some testing on my ast2400 and ast2500 BMC and looks like the
> > for() loop runs faster than for_each_set_bit_from() loop in my
> > environment. I'm not sure if something needs to be revised in my test
> > code, but please kindly share your suggestions:
> >
> > I use get_cycles() to calculate execution time of 2 different loops, and
> > ast_vhub_dev_irq() is replaced with barrier() to avoid "noise"; below
> > are the results:
> >
> >   - when downstream port number is 5 and only 1 irq bit is set, it takes
> >     ~30 cycles to finish for_each_set_bit() loop, and 20-25 cycles to
> >     finish the for() loop.
> >
> >   - if downstream port number is 5 and all 5 bits are set, then
> >     for_each_set_bit() loop takes ~50 cycles and for() loop takes ~25
> >     cycles.
> >
> >   - when I increase downsteam port number to 16 and set 1 irq bit, the
> >     for_each_set_bit() loop takes ~30 cycles and for() loop takes 25
> >     cycles. It's a little surprise to me because I thought for() loop
> >     would cost 60+ cycles (3 times of the value when port number is 5).
> >
> >   - if downstream port number is 16 and all irq status bits are set,
> >     then for_each_set_bit() loop takes 60-70 cycles and for() loop takes
> >     30+ cycles.


Cheers,

Tao
