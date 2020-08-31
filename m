Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB29C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 23:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 906512078B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 23:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6FtQVjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgHaX0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 19:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHaX0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 19:26:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61ADC061573;
        Mon, 31 Aug 2020 16:26:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n3so671606pjq.1;
        Mon, 31 Aug 2020 16:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dVqPUed6NYAwD+JrLth2cd5hFPQoV0967E1Zso4MptU=;
        b=C6FtQVjb+tO6vCWuzysuTcPpSGLKdJk7gkia3YFeAH23aoinfa3/PIuD4LDboFBjnH
         JfPIXMT9AR3TcRuKpjhxHl2DBEzjUPOsl0OQHQzfWvEebntMDgmAuU+D/QAHs6r1Tvtq
         Of46KsU+GKkJrtN2rJEfsf7HIDIr23qcIg4E6wQPr5cIeW1KUlRYp/MakFRAKVRqVn1Y
         xPSf3g6GVRUW7dYFviCXzjhdVl867ysOH7yVbuKCjcO9+QMxtk0rTR5yFxEdnA8a1IyP
         TYpn+fkJYoKYbgTI8TTNOAeXJiqr88qjCxtqY2ITftwLGtsTp6XRwpGkcvsOaRthfp4e
         9tRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dVqPUed6NYAwD+JrLth2cd5hFPQoV0967E1Zso4MptU=;
        b=gZCJZiytyN/cJVRatcIieByJVXhuVWfAmLeM6x2zgsCe+2o/k+JyFyXN+jKjxhEaS9
         hmTYPIIVcZP4+4HsmPL8NuVl2G2fxQrk5/ROaFgXLl9h5JOprp2zqhStKN5HMkEVsO4q
         YdkARKczsxIHOGGZO7xlB3M8MIAQ3f+VHaIj54JXlvagpYVFe9xHKfSjW8mGsQFKQBBt
         FYRvVSD0lFPBqUKuR4eQ19zRumEyKecoMMKnkgFkle8NOJ0kmnh85N5s4chyqVqhQUl5
         Atw8eifFMf2zgU4XFQP8zNf8de8VJEDeXGnBn+j+rf6PuNFI+oh1nzG879FhLvIvHcAI
         572w==
X-Gm-Message-State: AOAM5318cqN3WOR3Rw7uNJMSbtiQW/iFgpEcP9xBFZ65tS6+iDv0c83I
        tNANxOQbT2nvW69UoQOy3Dk=
X-Google-Smtp-Source: ABdhPJzJ6saM8zCmqhQnS70tKIwx+Bdr92ksZutTZ/A/cd+o9UimIAZzUJXkzj/t9etnpxk3zzC10A==
X-Received: by 2002:a17:90a:5609:: with SMTP id r9mr1520433pjf.194.1598916376023;
        Mon, 31 Aug 2020 16:26:16 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id w16sm686816pjd.50.2020.08.31.16.26.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Aug 2020 16:26:15 -0700 (PDT)
Date:   Mon, 31 Aug 2020 16:26:08 -0700
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
Message-ID: <20200831232607.GA4015@taoren-ubuntu-R90MNF91>
References: <20200528011154.30355-1-rentao.bupt@gmail.com>
 <875z9hz8k3.fsf@kernel.org>
 <20200817225603.GA21228@taoren-ubuntu-R90MNF91>
 <87y2lv9m32.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2lv9m32.fsf@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 12:54:57PM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Tao Ren <rentao.bupt@gmail.com> writes:
> > On Mon, Aug 17, 2020 at 04:49:32PM +0300, Felipe Balbi wrote:
> >> 
> >> Hi,
> >> 
> >> rentao.bupt@gmail.com writes:
> >> > From: Tao Ren <rentao.bupt@gmail.com>
> >> >
> >> > This is a follow-on patch for commit a23be4ed8f48 ("usb: gadget: aspeed:
> >> > improve vhub port irq handling"): for_each_set_bit() is replaced with
> >> > simple for() loop because for() loop runs faster on ASPEED BMC.
> >> >
> >> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> >> > ---
> >> >  drivers/usb/gadget/udc/aspeed-vhub/core.c | 10 +++-------
> >> >  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |  3 +++
> >> >  2 files changed, 6 insertions(+), 7 deletions(-)
> >> >
> >> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> >> > index cdf96911e4b1..be7bb64e3594 100644
> >> > --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> >> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> >> > @@ -135,13 +135,9 @@ static irqreturn_t ast_vhub_irq(int irq, void *data)
> >> >  
> >> >  	/* Handle device interrupts */
> >> >  	if (istat & vhub->port_irq_mask) {
> >> > -		unsigned long bitmap = istat;
> >> > -		int offset = VHUB_IRQ_DEV1_BIT;
> >> > -		int size = VHUB_IRQ_DEV1_BIT + vhub->max_ports;
> >> > -
> >> > -		for_each_set_bit_from(offset, &bitmap, size) {
> >> > -			i = offset - VHUB_IRQ_DEV1_BIT;
> >> > -			ast_vhub_dev_irq(&vhub->ports[i].dev);
> >> > +		for (i = 0; i < vhub->max_ports; i++) {
> >> > +			if (istat & VHUB_DEV_IRQ(i))
> >> > +				ast_vhub_dev_irq(&vhub->ports[i].dev);
> >> 
> >> how have you measured your statement above? for_each_set_bit() does
> >> exactly what you did. Unless your architecture has an instruction which
> >> helps finds the next set bit (like cls on ARM), which, then, makes it
> >> much faster.
> >
> > I did some testing and result shows for() loop runs faster than
> > for_each_set_bit() loop. Please refer to details below (discussion with
> > Benjamin in the original patch) and kindly let me know your suggestions.
> 
> no strong feelings, just surprised that you're already worried about
> 20~40 cycles of cpu time ;-)
> 
> Patch applied for next merge window

Thanks Felipe. Ben had some concerns about interrupt handling cost on
AST2400 BMC (ARM9), hence we did the comparison and noticed the small
difference :)


Cheers,

Tao
