Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D06C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46795214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581957130;
	bh=G2x/hcIZgjfTD4IZeUf1w/CuOjyhAfKvMkN8o462eUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LOc0MbKvEObT6XDu48i9DshgYFC46peBGThhBPJJCoD1fNKgz/fMwdyu6I8Sm6snB
	 OD1ghUq3tjO6r1fAAPVGUAaIJz0Cl3He6tFQFcZgB4LNFNmOOwBzxpOUyWXPbNHZGo
	 yF3Wa9fr0dsziFIR2M7cny/PbFgEWcRpFD4raRew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgBQQcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:32:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbgBQQcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:32:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FBD1214D8;
        Mon, 17 Feb 2020 16:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581957128;
        bh=G2x/hcIZgjfTD4IZeUf1w/CuOjyhAfKvMkN8o462eUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IfnA7PO4kayrrGf+qoG8q7MueEM8YAJjHbLMpu6oF71uhHKdiXw/N+KO7nHYgsITU
         uM1bJ3Dpidm1ApH93bTg0vqxwbURCFIYmczuHu6Q8/diHDy2FSj6YxhH3OqQu78lZD
         kEy7z3Np1frMm8ob6jmyBGWMGsK1L/weyN55VUMg=
Date:   Mon, 17 Feb 2020 17:32:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        smohanad@codeaurora.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        hemantk@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/16] bus: mhi: core: Add support for registering MHI
 controllers
Message-ID: <20200217163205.GE1502885@kroah.com>
References: <20200211192055.GA1962867@kroah.com>
 <20200213152013.GB15010@mani>
 <20200213153418.GA3623121@kroah.com>
 <20200213154809.GA26953@mani>
 <20200213155302.GA3635465@kroah.com>
 <20200217052743.GA4809@Mani-XPS-13-9360>
 <20200217115930.GA218071@kroah.com>
 <20200217130419.GA13993@Mani-XPS-13-9360>
 <20200217141503.GA1110972@kroah.com>
 <CAK8P3a28cZzOD7NfjBR=g6fADGgqwE7PFgOJrh6fph3QmDhKGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a28cZzOD7NfjBR=g6fADGgqwE7PFgOJrh6fph3QmDhKGQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 05:04:52PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 17, 2020 at 3:15 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Mon, Feb 17, 2020 at 06:34:19PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Feb 17, 2020 at 12:59:30PM +0100, Greg KH wrote:
> > > ```
> > > struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl)
> > > {
> > > ...
> > > dev->parent = mhi_cntrl->dev;
> > > ...
> > > ```
> > >
> > > Hence, having the parent dev pointer really helps.
> >
> > Yes, saving the parent device is fine, but you should be doing your own
> > dma calls using _your_ device, not the parents.  Only mess with the
> > parent pointer if you need to do something "normal" for a parent.
> 
> The MHI device is not involved in DMA at all, as it is not a DMA master,
> and has no knowledge of the memory management or whether there
> is any DMA at all. I think it is the right abstraction for an MHI driver to
> pass kernel pointers into the subsystem interfaces, which then get
> mapped by the bus driver that owns the DMA master.
> 
> This is similar to how e.g. USB drivers pass data into the USB core
> interfaces, which then get the HCI driver to map/unmap it into the
> DMA masters.

Ok, then this needs to be named a whole lot better than the original
"dev" name had it.  Heck, even "parent" does not show that type of
representation, make it "controller" or something else a whole lot more
descriptive of what it really is please.

thanks,

greg k-h
