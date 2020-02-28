Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31424C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0214A2469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk4abaK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgB1R7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:59:09 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37513 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1R7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:59:09 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so1602275pjb.2;
        Fri, 28 Feb 2020 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W479fFfJP8Am9FQwNANH6QZduIgFgYhViV6Kajs5bV4=;
        b=Rk4abaK2BBlJk7w0X7EVEuEOL9Da3d8ZhPiQJBKVoOa+mXQZHUXEEvkFh6W77A5wh9
         H7pcn/ozAElnkKy9m6gWdlZPyXORGd348f0fvXUQNqGbpP5ebJwTgQ5sWdyZyXMNPZ/e
         Q5/XE7cLA72SujkIVBmLJS/MWflRhpOKrtzWnXujkphGVMlyMc6tkGV94gxtfBjk6fDN
         iXXlrMgR+3wnNF8oSlllG/BEuoXc9pOrc1LeY+jMXv/TBwajeZGu3g0M72WFZguo+v8r
         g+Mwlodrm+qURSwI77zyKcHy8ReHy9qilNrApYUN9NR6iGZFxceox9RDco1m0kdF1toB
         RXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=W479fFfJP8Am9FQwNANH6QZduIgFgYhViV6Kajs5bV4=;
        b=MamvILzaEfRLJKai/iAOb5OO2LN3jgAz1LwnDMMAGUxyOHsrckFZGgEe+3iIfg43or
         QPkZUPgnJWeuIMyF/JeVeu1Jr+TjAbkBf+1f5N2SUusTx96BvtR/2jMlaWsEfZJ0rKin
         vaIHS1n+MVag4oHIP6QlrsDS7LD//daUZVD+x0EitF18zelvXF4zWttcApJmJ4vm/8cd
         5Anh8xCOD0SZLpojX62Yg+V8fWlT/OwCZ8+sV8ZBkeswfQanS67gp0RE263RxfcAgNDY
         Nxs1csGARMJWIpgvMi7lCRN6dVNWBElE+LHwlKhbvIgLYzLP/Zo+PZ/Qn/tiVNJqiDVQ
         WdRw==
X-Gm-Message-State: APjAAAWLFRC1CssRkCwU2BoNqukxI6/T3hP+6+UBwEw+arkJdmYWsA2s
        E05gG9m86MKRRryHMItbVG4=
X-Google-Smtp-Source: APXvYqyNA2lkChyKOMH60PML1VQHvFQkcLbvStr35TByxg9zQhCEqmhSaIwBoVN64dMR8fKnzqM5Ow==
X-Received: by 2002:a17:90a:f492:: with SMTP id bx18mr6103523pjb.118.1582912747908;
        Fri, 28 Feb 2020 09:59:07 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z4sm10991127pfn.42.2020.02.28.09.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 09:59:06 -0800 (PST)
Date:   Fri, 28 Feb 2020 09:59:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Antti =?iso-8859-1?Q?Sepp=E4l=E4?= <a.seppala@gmail.com>,
        Boris ARZUR <boris@konbu.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Schiller <ms@dev.tdt.de>
Subject: Re: [RFT PATCH 1/4] usb: dwc2: Simplify and fix DMA alignment code
Message-ID: <20200228175905.GB3188@roeck-us.net>
References: <20200226210414.28133-1-linux@roeck-us.net>
 <20200226210414.28133-2-linux@roeck-us.net>
 <CAD=FV=WDd4E-zDW73kb-qHo1QYQrD3BTgVpE70rzowpgeXVy7w@mail.gmail.com>
 <ce3357a1-467f-1241-ae0d-2e113116ca8d@roeck-us.net>
 <f94fc372-d81b-e8e4-e7ef-780fe7db1237@roeck-us.net>
 <CAD=FV=VNsOo--1x+pkwhWOWSGAQyVB6g6CE+o4q7phPSXaDXRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VNsOo--1x+pkwhWOWSGAQyVB6g6CE+o4q7phPSXaDXRw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 08:14:35AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Thu, Feb 27, 2020 at 8:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 2/27/20 2:27 PM, Guenter Roeck wrote:
> > > On 2/27/20 2:06 PM, Doug Anderson wrote:
> > [ ... ]
> > >>> -       if (urb->num_sgs || urb->sg ||
> > >>> -           urb->transfer_buffer_length == 0 ||
> > >>> +       if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0 ||
> > >>> +           (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP) ||
> > >>>             !((uintptr_t)urb->transfer_buffer & (DWC2_USB_DMA_ALIGN - 1)))
> > >>
> > >> Maybe I'm misunderstanding things, but it feels like we need something
> > >> more here.  Specifically I'm worried about the fact when the transfer
> > >> buffer is already aligned but the length is not a multiple of the
> > >> endpoint's maximum transfer size.  You need to handle that, right?
> > >> AKA something like this (untested):
> > >>
> > >> /* Simple case of not having to allocate a bounce buffer */
> > >> if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0 ||
> > >>     (urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP))
> > >>   return 0;
> > >>
> > >> /* Can also avoid bounce buffer if alignment and size are good */
> > >> maxp = usb_endpoint_maxp(&ep->desc);
> > >> if (maxp == urb->transfer_buffer_length &&
> > >
> > > No, transfer_buffer_length would have to be a multiple of maxp. There
> > > are many situations where roundup(transfer_buffer_length, maxp) !=
> > > transfer_buffer_length. I agree, this would be the prudent approach
> > > (and it was my original implementation), but then it didn't seem to
> > > cause trouble so far, and I was hesitant to add it in because it results
> > > in creating temporary buffers for almost every receive operation.
> > > I'd like to get some test feedback from Boris - if the current code
> > > causes crashes with his use case, we'll know that it is needed.
> > > Otherwise, we'll have to decide if the current approach (with fewer
> > > copies) is worth the risk, or if we want to play save and always
> > > copy if roundup(transfer_buffer_length, maxp) != transfer_buffer_length.
> > >
> >
> > Thinking more about this, the situation is actually much worse:
> > In Boris' testing, he found inbound transactions requested by usb
> > storage code with a requested transfer size of 13 bytes ... with
> > URB_NO_TRANSFER_DMA_MAP set. This means the requesting code has
> > provided a DMA ready buffer, transfer_buffer isn't even used,
> > and we can not reallocate it. In this situation we can just hope
> > that the chip (and the connected USB device) don't send more data
> > than requested.
> >
> > With that in mind, I think we should stick with the current
> > scheme (ie only allocate a new buffer if the provided buffer is
> > unaligned) unless Boris comes back and tells us that it doesn't
> > work.
> 
> I dunno.  I'd rather see correctness over performance.  Certainly we'd
> only need to do the extra bounce buffer for input buffers at least.
> 
> Although I don't love the idea, is this something where we want to
> introduce a config option (either runtime or through KConfig),
> something like:
> 
> CONFIG_DWC2_FAST_AND_LOOSE - Avoid bounce buffers and thus run faster
> at the risk of a bad USB device being able to clobber some of your
> memory.  Only do this if you really care about speed and have some
> trust in the USB devices connected to your system.
> 

I understand your point. Unfortunately that would only work if the driver
doesn't set URB_NO_TRANSFER_DMA_MAP.

$ git grep "=.*URB_NO_TRANSFER_DMA_MAP" | wc
    115     498   10104

isn't exactly reassuring - a quick checks suggests that almost 50%
of USB drivers set this flag.

So all we'd really accomplish is to give people a false sense of
security.

In this context, I did play around with configuring the real receive
buffer size (ie in my reproducer 1522 instead of 1536). If I do that,
reading the HCTSIZ register after the transfer reports 0x7fff2
(or -14 = 1522-1536 if I treat the value as signed) as actual transfer
size. Maybe that would be an option, if properly handled, but who knows
what the IP actually does in this case, and what it does on other
implementations (not rk3288).

Guenter
