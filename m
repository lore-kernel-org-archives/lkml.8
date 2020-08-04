Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F147CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9E92177B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596523320;
	bh=qM66h2KOjBvSnoLO4auffKSN9+voT/hyDatDYKNZHTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KbU+qbDRIUaXacPpE8M26h2FdEr/uQzE9DMU2PYnE5uXEctzdyUPAh2jvfbN76BCR
	 VcSwuJaH0mQPo9ZV7VJkr79zRaRp6cH+Eg5O5sD4l0PWd7P47MG/15QqE6wPanTyM2
	 sGB0zuF1VGidHlhdKLtMFd1P5yy0MRfnn5lo/qts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHDGl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgHDGl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:41:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77C3120781;
        Tue,  4 Aug 2020 06:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596523317;
        bh=qM66h2KOjBvSnoLO4auffKSN9+voT/hyDatDYKNZHTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PKyVOkf0vG7jeJ3DE1PWY5i3ZbA8ivcNNOimr9LceOQj3Od4237LOVFQ22OkoedxG
         UNBQHQ9texX162I+YL9B2+9nmyFEe0y7w0+qtFfIMkrXj3nZxB2kwRA/LP4jzTG0PW
         dhPlw6tKb/k4CBG59tkO5O3HHY9mR3zCz/3wcRX8=
Date:   Tue, 4 Aug 2020 08:41:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] Platform lockdown information in SYSFS
Message-ID: <20200804064154.GE696690@kroah.com>
References: <20200730214136.5534-1-daniel.gutson@eclypsium.com>
 <20200731070053.GC1518178@kroah.com>
 <CAFmMkTGdzjjrvitY8fT+RcXFqHG1JGMB-3w1hi1c8CD0FH34Tw@mail.gmail.com>
 <20200731141503.GA1717752@kroah.com>
 <CAFmMkTG7tkFzwwo_WNe2EFFRVijvGm+NLaeN3qX6CVzTViWBag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFmMkTG7tkFzwwo_WNe2EFFRVijvGm+NLaeN3qX6CVzTViWBag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 07:04:56PM -0300, Daniel Gutson wrote:
> > > > Think of this as an input device.  You don't put the random input
> > > > attributes all in one place, you create a new device that represents the
> > > > input interface and register that.
> 
> I'm having trouble with this. What's the dev_t for the child devices?
> I'm doing
>     child_device = device_create(&my_class, &pdev->dev, MKDEV(0, 0),
> NULL, "child");
> pdev is the pci_device (intel-spi-pci)
> dmesg shows
> 
>     sysfs: cannot create duplicate filename '/class/my-class'
>     (call trace)
>     kobject_add_internal failed for my-class with -EEXIST, don't try
> to register things with the same name in the same directory.

Without seeing all of your code, I can't tell you what you are doing
wrong, but the kernel should be giving you a huge hint here...

Don't create duplicate names in the same subdirectory.

thanks,

greg k-h
