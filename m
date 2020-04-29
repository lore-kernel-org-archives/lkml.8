Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC69BC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95CDB20731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgD2BOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 21:14:35 -0400
Received: from netrider.rowland.org ([192.131.102.5]:34119 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726353AbgD2BOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 21:14:35 -0400
Received: (qmail 26903 invoked by uid 500); 28 Apr 2020 21:14:34 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Apr 2020 21:14:34 -0400
Date:   Tue, 28 Apr 2020 21:14:34 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: raw-gadget: fix gadget endpoint selection
In-Reply-To: <CAAeHK+yscLbzCh3P5uhOpxtB8-xhQbBSmSHpj6ugM=AMqjE7NA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.2004282110170.26482-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020, Andrey Konovalov wrote:

> Hi Alan,
> 
> This patch uses the approach that I mentioned in the discussion about
> endpoint selection. Does this look acceptable?

I haven't had time to look through it yet.

> I'm not sure which endpoint limits it makes sense to expose via
> USB_RAW_IOCTL_EPS_INFO. I'm more or less sure about maxpacket_limit
> and max_streams, but I don't exactly know what maxburst is used for.
> Maybe there are some others?

maxburst is a USB-3 thing.  It mainly affects just throughput, not 
functionality, and it's handled pretty much entirely by the hardware.  
You shouldn't worry about it, at least, not now.

> I also wonder if we need to expose ep0 limits via USB_RAW_IOCTL_EPS_INFO too.
> expose ep0 parameters?

I don't think there are any significant attributes for ep0.  In
general, gadget drivers have to live with what the hardware supports --
or else fail to run at all.  After all, the driver can't substitute a 
different endpoint for ep0.

Alan Stern

