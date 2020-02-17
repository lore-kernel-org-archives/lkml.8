Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618FCC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A73320725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eivdHkGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgBQRun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:50:43 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40061 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgBQRum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:50:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id z7so9574143pgk.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 09:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V0F+CPlKBaYQp5ssJ6bvuOMjKgVSOet/nt7N4287yH0=;
        b=eivdHkGY/h+F9sRcScDOmV2CopnSm90PCYLIK8F9DeG35We8fcAhf8d8MPRxelEmVC
         MmGHS2k/W4DnfPk1k1yQjyWopT8RJihoEy4H+cxgllhqwx8MdPC1IZiE0xH9/aygZdXx
         IyE26geE5wo/h9w/uccwHzNAf2WVtzbWFpImdnFraSasHIRtXhurOjtVdH11iVO0Tuqv
         1QODAiLxt6BChWR0oCWKg0fOrJEwJOLRAaVqIZq4oRyImSCGEjRP1AoFweca5042ODUi
         yCVXHom366cEAg8OHjqLlRb2LiWR1begT5JBn0hCnVC4zgsJB0scgwuQ4esxEeiXX3PQ
         zyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V0F+CPlKBaYQp5ssJ6bvuOMjKgVSOet/nt7N4287yH0=;
        b=XnjP6yU80dMkviK5aoSW6++Dslpak536JbYLLxS02xYhgDeRsGj2jp3mXodjCM1sv7
         1A1pEoeUlXzUoSgquc4vwdKzE5FtruOHSIjFlyPN82qOWauuskv8sujmZV/qpmNEzmp2
         qNq5noCRKrHHC1OuC754UhK4hhRwLUchMNezPiWqRU2CPUFNHCJPM7cBvLHGpUYD1taA
         0ZQtw5Vg4OMfcd5NC0kUrIHaZJXrFbqZkZPHW0FX6XcyDB3RWJghc+D5SwefA0JjNlZ4
         YASQ3b5R2AhMYfM6mLyrLh3lMsI0hwSwHLk6qBwgs42jUh/8DCsBoHow2JjmTZItpKBY
         /wNg==
X-Gm-Message-State: APjAAAUNUYD6wiKl0cJvkF0egBOpKm1fiSvvUMWKZEmWTdqjdc/NeG/B
        lQ4DbJ8FYDYxUrfGQ1UP66x7
X-Google-Smtp-Source: APXvYqwKIWYg4tOk1K2R+x/r28aatJUvrwXdBU/TrnBbBBKka5uFGaIMFJ+sdVvybQrMohx11V2hzA==
X-Received: by 2002:a63:7207:: with SMTP id n7mr18948000pgc.253.1581961840426;
        Mon, 17 Feb 2020 09:50:40 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:48d:3349:2df9:3778:ccac:a356])
        by smtp.gmail.com with ESMTPSA id z64sm1153357pfz.23.2020.02.17.09.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Feb 2020 09:50:39 -0800 (PST)
Date:   Mon, 17 Feb 2020 23:20:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, smohanad@codeaurora.org,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        hemantk@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/16] bus: mhi: core: Add support for registering MHI
 controllers
Message-ID: <20200217175031.GC7305@Mani-XPS-13-9360>
References: <20200213152013.GB15010@mani>
 <20200213153418.GA3623121@kroah.com>
 <20200213154809.GA26953@mani>
 <20200213155302.GA3635465@kroah.com>
 <20200217052743.GA4809@Mani-XPS-13-9360>
 <20200217115930.GA218071@kroah.com>
 <20200217130419.GA13993@Mani-XPS-13-9360>
 <20200217141503.GA1110972@kroah.com>
 <CAK8P3a28cZzOD7NfjBR=g6fADGgqwE7PFgOJrh6fph3QmDhKGQ@mail.gmail.com>
 <20200217163205.GE1502885@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217163205.GE1502885@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 05:32:05PM +0100, Greg KH wrote:
> On Mon, Feb 17, 2020 at 05:04:52PM +0100, Arnd Bergmann wrote:
> > On Mon, Feb 17, 2020 at 3:15 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Mon, Feb 17, 2020 at 06:34:19PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Feb 17, 2020 at 12:59:30PM +0100, Greg KH wrote:
> > > > ```
> > > > struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl)
> > > > {
> > > > ...
> > > > dev->parent = mhi_cntrl->dev;
> > > > ...
> > > > ```
> > > >
> > > > Hence, having the parent dev pointer really helps.
> > >
> > > Yes, saving the parent device is fine, but you should be doing your own
> > > dma calls using _your_ device, not the parents.  Only mess with the
> > > parent pointer if you need to do something "normal" for a parent.
> > 
> > The MHI device is not involved in DMA at all, as it is not a DMA master,
> > and has no knowledge of the memory management or whether there
> > is any DMA at all. I think it is the right abstraction for an MHI driver to
> > pass kernel pointers into the subsystem interfaces, which then get
> > mapped by the bus driver that owns the DMA master.
> > 
> > This is similar to how e.g. USB drivers pass data into the USB core
> > interfaces, which then get the HCI driver to map/unmap it into the
> > DMA masters.
> 
> Ok, then this needs to be named a whole lot better than the original
> "dev" name had it.  Heck, even "parent" does not show that type of
> representation, make it "controller" or something else a whole lot more
> descriptive of what it really is please.
> 

Okay. I'll come up with something more relative.

Thanks,
Mani

> thanks,
> 
> greg k-h
