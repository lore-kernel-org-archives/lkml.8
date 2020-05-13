Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931B2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE388204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589386074;
	bh=A5HewM5jEMYQc0YI3s2HBSVxUk9g5weQjwr9X9XlfJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MmfBJdY2kAd4AnWbGwgcLNUUnQTXNGy5EKLcgpcDC0e+dP59Gbx/y7c5U3A1KIBNS
	 SqlSl9Pnr7RxbwC8yV3TjLmvg4X/ufaqEuLd5q8lpnjDaq00ns9GXKbhSu5SkvXYhs
	 URFle3WQuE/kNqODxaqVM/irxbrOFSKwtny85yHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389354AbgEMQHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729589AbgEMQHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:07:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A815B204EC;
        Wed, 13 May 2020 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589386073;
        bh=A5HewM5jEMYQc0YI3s2HBSVxUk9g5weQjwr9X9XlfJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xWckjGMvVk1t2vke8bm2d67UURIIuvH0wJ3r7mjbwut2ne90zvTkJyVb1pQ8TTTAR
         byvpJMaHrdeTStPYSNUyJ7wFSSzIFOaIcL8KthpI919GFl56YtoPutGyvRHQzQSAYY
         He8s6YPwcxITZaYlbG8WyVgiV4so3+POFtQf7XBE=
Date:   Wed, 13 May 2020 18:07:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Replace zero-length array with
 flexible-array
Message-ID: <20200513160750.GA1362525@kroah.com>
References: <20200507185318.GA14393@embeddedor>
 <20200513150343.GZ25962@localhost>
 <20200513153918.GA1360420@kroah.com>
 <20200513154807.GA25962@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513154807.GA25962@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 05:48:07PM +0200, Johan Hovold wrote:
> On Wed, May 13, 2020 at 05:39:18PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, May 13, 2020 at 05:03:43PM +0200, Johan Hovold wrote:
> > > On Thu, May 07, 2020 at 01:53:18PM -0500, Gustavo A. R. Silva wrote:
> > > > The current codebase makes use of the zero-length array language
> > > > extension to the C90 standard, but the preferred mechanism to declare
> > > > variable-length types such as these ones is a flexible array member[1][2],
> > > > introduced in C99:
> > > > 
> > > > struct foo {
> > > >         int stuff;
> > > >         struct boo array[];
> > > > };
> 
> > > >  drivers/greybus/arpc.h                    |    2 -
> > > >  include/linux/greybus/greybus_protocols.h |   44 +++++++++++++++---------------
> > > 
> > > I noticed Greg just applied this one to his -testing branch, but do we
> > > really want this in greybus_protocols.h, which is meant to be shared
> > > with the firmware side? Perhaps not an issue, just figured I'd point
> > > this out.
> > 
> > Why not, it should be the same thing, right?  No logic has changed that
> > I see.
> 
> Yes, the structure's the same, but the firmware toolchain may not
> expect flexible arrays. I believe we're holding back on these changes
> for uapi headers as well for that reason?
> 
> Again, perhaps not an issue. We can just mandate fw toolchains that
> support C99 if you want to use an unmodified header, I guess.

I think we can mandate that for now, let's see if anyone actually builds
firmware against this header file anymore :)

greg k-h
