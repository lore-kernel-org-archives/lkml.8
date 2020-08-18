Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEA9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176F3206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597744687;
	bh=liPekAEqEhXna7fi9pE3+yVKQDVG7V0t3PgzODIgVeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f9QYw7SwLMmbJAU+elHuLiv66FRnR3sNn5kXVY9Rfi3kgbmyMKHI3e8V4Zl212uaT
	 M7BdHQj7qbLH7ZT5FMuQXFh2mBNbmePTQcQI0QseGAWi56mm7my1uKtSpN2f+FD4Jf
	 UmLNu5/8Vd08tcJ1h5Nhz4+vxiK3vuYLQH40fZUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHRJ6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:58:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHRJ6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:58:05 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F044F206DA;
        Tue, 18 Aug 2020 09:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597744684;
        bh=liPekAEqEhXna7fi9pE3+yVKQDVG7V0t3PgzODIgVeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLZNg6fiT5Z5kpBuFHuWZrQKECS9wMB5O+KtuBKDjJVCB9o/zAa0Z7baeJ6YW7q8I
         zdXgYh6R2QGn9v/0nryXo69hNM+A/BpUqCcw7myjmWUtZ6sPJLPJy7az0vzVg57ol6
         VVmzAvsHqGoKbrYsSFcqcVIRKbjYbUeWfl0YJiiI=
Date:   Tue, 18 Aug 2020 15:28:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: renesas-xhci: remove version check
Message-ID: <20200818095800.GZ2639@vkoul-mobl>
References: <20200818071739.789720-1-vkoul@kernel.org>
 <20200818073108.GE9254@kroah.com>
 <20200818083919.GY2639@vkoul-mobl>
 <20200818084605.GA27455@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818084605.GA27455@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-20, 10:46, Greg Kroah-Hartman wrote:
> On Tue, Aug 18, 2020 at 02:09:19PM +0530, Vinod Koul wrote:
> > On 18-08-20, 09:31, Greg Kroah-Hartman wrote:
> > > On Tue, Aug 18, 2020 at 12:47:39PM +0530, Vinod Koul wrote:
> > > > Some devices in wild are reporting bunch of firmware versions, so remove
> > > > the check for versions in driver
> > > > 
> > > > Reported by: Anastasios Vacharakis <vacharakis@gmail.com>
> > > > Reported by: Glen Journeay <journeay@gmail.com>
> > > > Fixes: 2478be82de44 ("usb: renesas-xhci: Add ROM loader for uPD720201")
> > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=208911
> > > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > > ---
> > > > Changes in v3:
> > > >  - drop additional firmware versions and remove the check
> > > > 
> > > > Greg, this fixes regression for folks with preprogrammed controllers
> > > > please mark as stable material
> > > 
> > > You could have done so by putting "Cc: stable..." in the s-o-b of the
> > > kernel, why force me to do that by hand?
> > 
> > Oops, wasnt sure of your preference. Btw am sure you would have scripted
> > it :-)
> > 
> > Would you like me to send an update with stable tagged or this is fine
> > for now?
> 
> I can do it now, but in the future please be nice to maintainers, we are
> overworked as you well know :)

Thanks.

-- 
~Vinod
