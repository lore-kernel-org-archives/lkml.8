Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF73C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6281E21569
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581448958;
	bh=6QUFO4XLIl152E/aHV9pWHYp1OSMRQfAtAj8YjYbj2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UOzatnJiNIvheGcQSGpU50l5kuJ2sAn6mtkZNZO8/YKnSncVEy+OhEJr62h3eI52M
	 ca9dEwk2OVyJYK4Pq4DviqqVECS6q8Tjaw9ewbCOh8yiYqchISTtcywzRTYQrS5dYz
	 BHrxLVZ0CCTMUYUxKmjHA4UB7cc9YsuswHzakpv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbgBKTWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:22:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730822AbgBKTWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:22:37 -0500
Received: from localhost (unknown [104.133.9.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B924120842;
        Tue, 11 Feb 2020 19:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581448956;
        bh=6QUFO4XLIl152E/aHV9pWHYp1OSMRQfAtAj8YjYbj2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=idbo4s+/FPE3E/07cj+a1jbxOwhs5O3G+6H/GRfnEOt/KiMoy5jI4Eha8wrYRw6qB
         LCha0a3iz+Xy66b0zWDBmBhFjUs72qIO+SYea/TBEwaJtGbjDrlXpZMNxOu25uSo1+
         E+25XjTOGNz82OFPoDm5FG8tdA5ywuxz5uPGa7T8=
Date:   Tue, 11 Feb 2020 11:22:36 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     arnd@arndb.de, smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/16] bus: mhi: core: Add support for registering MHI
 controllers
Message-ID: <20200211192236.GB1962867@kroah.com>
References: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
 <20200131135009.31477-3-manivannan.sadhasivam@linaro.org>
 <20200206165606.GA3894455@kroah.com>
 <20200211191147.GB11908@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211191147.GB11908@Mani-XPS-13-9360>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:41:47AM +0530, Manivannan Sadhasivam wrote:
> Hi Greg,
> 
> On Thu, Feb 06, 2020 at 05:56:06PM +0100, Greg KH wrote:
> > On Fri, Jan 31, 2020 at 07:19:55PM +0530, Manivannan Sadhasivam wrote:
> > > +static void mhi_release_device(struct device *dev)
> > > +{
> > > +	struct mhi_device *mhi_dev = to_mhi_device(dev);
> > > +
> > > +	if (mhi_dev->ul_chan)
> > > +		mhi_dev->ul_chan->mhi_dev = NULL;
> > 
> > That looks really odd.  Why didn't you just drop the reference you
> > should have grabbed here for this pointer?  You did properly increment
> > it when you saved it, right?  :)
> > 
> 
> Well, there is no reference count (kref) exist for mhi_dev.

Then something is wrong with your model :(

You can't save pointers off to things without reference counting, that
is going to cause you real problems.  See the coding style document for
all the details.

> And we really needed to NULL the mhi_dev to avoid any dangling
> reference to it.

Again, that's not how to do this correctly.

> The reason for not having kref is that, each mhi_dev will be used by
> maximum of 2 channels only. So thought that refcounting is not needed.
> Please correct me if I'm wrong.

Please read section 11 of Documentation/process/coding-style.rst

thanks,

greg k-h
