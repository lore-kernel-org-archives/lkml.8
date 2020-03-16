Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06BBC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 04:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83DF2071C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 04:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="WCFiOpu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgCPEuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 00:50:09 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45275 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbgCPEuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 00:50:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id c145so23965717qke.12;
        Sun, 15 Mar 2020 21:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uxCRLDZ0IkMQwqs0XVpLiauYQ/QOJLqTZsxTkwxRAyY=;
        b=WCFiOpu7CYhUUeWYfysTGcsR835PmVC/GV/aSKpxW+atVSjfK72AHRQ3T4uxqOHcMD
         ygmW8Xe+hhjuc+zVNNmvLKsWo6IouNiBJIMG761CPajmDfxY1qeBto+g8sv0AYq6KxZ+
         VPtUbPtKq4E14TOu92UDlrkuAF1ZyA3vQ7wFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uxCRLDZ0IkMQwqs0XVpLiauYQ/QOJLqTZsxTkwxRAyY=;
        b=FZzKmdD8f2csQapVKVI8eS2sT1cZi/+Hx4KQCFMbeYPeJ5nSrTPc0gFBbzY6wFATEK
         wjrM3cFCuDdPy+6I5WPQBzw2ntIkhMWLosjSpRKOhMaZrghqTWkTomtTyF9Ah4SfVoJW
         3FdYUQ30gvSdqGhmpVx0iyMEhsCn8mtJgQ1vfEXE9hHvlac1ys572RKKd1/b82dzV35v
         AjoF9aIi/9BnOpEqY1R68agI+HizWoTWLSKZYAzopQ2uiPNPnVw9SXxn46oNqEX1gz7u
         8lmAVcWzATRVe/P3IRrowewMXEjn/+r1Z20SpF3Msj1WQyT6gdhqFaRRJVBKNR+pL3H4
         LzsQ==
X-Gm-Message-State: ANhLgQ0gFwW7rOApDTfiVhMyCc2c2CZo02jUengkWr1y7nRSkLyxZoid
        IagC5ZuTwUFdFM4+jDIs3ZInfQQEYjU+RvCtx1tWjZVF
X-Google-Smtp-Source: ADFU+vt9p6Gc2hMT0p448VwZq+IUNrzJ5/vgFErcVtQKm6CZXXWDuj9Qqg7E4Y9B/H+Dx2mFG0PWSWrbG2zUbsiVJco=
X-Received: by 2002:a37:6e06:: with SMTP id j6mr24529985qkc.171.1584334207132;
 Sun, 15 Mar 2020 21:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <1579123790-6894-1-git-send-email-eajames@linux.ibm.com>
 <1579123790-6894-7-git-send-email-eajames@linux.ibm.com> <CAK8P3a3HsdpLz0aDGem1BrQsNo2mEJOnOsLcKFcLjaERx9dhGg@mail.gmail.com>
 <1a303336-9ffb-353f-efe3-7d45ed114fd0@linux.vnet.ibm.com>
In-Reply-To: <1a303336-9ffb-353f-efe3-7d45ed114fd0@linux.vnet.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 16 Mar 2020 04:49:55 +0000
Message-ID: <CACPK8XcD5O0dwEOSHqWfCu38B96JkdbcvzCuJhep+PXF6foC=g@mail.gmail.com>
Subject: Re: [PATCH v6 06/12] soc: aspeed: Add XDMA Engine Driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Eddie James <eajames@linux.ibm.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 at 17:10, Eddie James <eajames@linux.vnet.ibm.com> wrote:
>
>
> On 2/10/20 10:35 AM, Arnd Bergmann wrote:
> > On Wed, Jan 15, 2020 at 10:31 PM Eddie James <eajames@linux.ibm.com> wrote:
> >> The XDMA engine embedded in the AST2500 and AST2600 SOCs performs PCI
> >> DMA operations between the SOC (acting as a BMC) and a host processor
> >> in a server.
> >>
> >> This commit adds a driver to control the XDMA engine and adds functions
> >> to initialize the hardware and memory and start DMA operations.
> >>
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > Hi Eddie,
> >
> > I'm missing the bigger picture in the description here, how does this fit into
> > the PCIe endpoint framework and the dmaengine subsystem?
>
>
> Hi,
>
> It doesn't fit into the PCIe endpoint framework. The XDMA engine
> abstracts all the PCIe details away so the BMC cannot configure any of
> the things the PCIe endpoint exposes.
>
> It also doesn't fit into the dmaengine subsystem due to the restriction
> on the ast2500 (and maybe the ast2600) that the XDMA engine can only
> access certain areas of physical memory. Also problematic would be
> pausing/resuming/terminating transfers because the XDMA engine can't do
> those things.
>
>
> >
> > Does the AST2500 show up as a PCIe device in the host, or do you just
> > inject DMAs into the host and hope that bypasses the IOMMU?
> > If it shows up as an endpoint, how does the endpoint driver link into the
> > dma driver?
>
>
> The AST2500 and AST2600 have two PCIe devices on them, so these will
> show up on the host if the BMC enables both of them. Either or both can
> also be disabled and therefore will not show up. On the host side, in
> order to receive DMA transfers, its simply a matter of registering a PCI
> device driver and allocating some coherent DMA.... Not sure about the
> details of endpoints/dma client driver?
>
>
> Hopefully this answers your questions. Thanks,

Arnd, did you have further questions about this driver?
