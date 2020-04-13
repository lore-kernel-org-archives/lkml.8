Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD07C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFD62072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586788382;
	bh=UgsFITWUZlPhGRKvUFEzShkg0Dx45Ysmuw2lAc+SDaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PUZwTMcAV9vhyitEu15adXrv1UT/DqFGtaddw9rr3EwVIoH5DjKzQJXWvFl23EH12
	 Jx2H0WDdoP5dUXLlA6ETgMDU+9vsrRCbI4E1zGVhTvh5RIC8y0I4d235kKH/LzHmEO
	 D3bS/1Ig4l5BBT2gsbdnJVCvMzQTPmH2jt4wOVZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbgDMOdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbgDMOdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:33:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD30A2072C;
        Mon, 13 Apr 2020 14:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586788380;
        bh=UgsFITWUZlPhGRKvUFEzShkg0Dx45Ysmuw2lAc+SDaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPUYRHSRHlx2GAXRo9nMBHjuEpgHckiq3M2LmlISBBRoqZH/M+444UvfX7V5w+lem
         12kt52rKzHQvF8XkB9Ipm1InslQuuJvYlHydBBV5htlnSH2LJ9I4j3Ld5cQI5GOKbN
         YtPX5TEJFVDVOOU5ObxpHQvBduqAQLhbnLZAPXlU=
Date:   Mon, 13 Apr 2020 16:32:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: vt6656: Refactor the assignment of the
 phy->signal variable
Message-ID: <20200413143258.GA3551837@kroah.com>
References: <20200411122610.7901-1-oscar.carter@gmx.com>
 <20200411122610.7901-2-oscar.carter@gmx.com>
 <20200413125616.GA3127208@kroah.com>
 <20200413142517.GB3101@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413142517.GB3101@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 04:25:17PM +0200, Oscar Carter wrote:
> On Mon, Apr 13, 2020 at 02:56:16PM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Apr 11, 2020 at 02:26:09PM +0200, Oscar Carter wrote:
> > > Create a constant array with the values of the "phy->signal" for every
> > > rate. Remove all "phy->signal" assignments inside the switch statement
> > > and replace these with a single reading from the new vnt_phy_signal
> > > array.
> > >
> > > The constant array can be of one dimension because the OR mask with
> > > BIT(3) or BIT(4) allow obtain a second value according to the rate,
> > > the preamble_type and the pkt_type.
> > >
> > > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > > ---
> > >  drivers/staging/vt6656/baseband.c | 105 ++++++++----------------------
> > >  1 file changed, 26 insertions(+), 79 deletions(-)
> >
> > This series did not apply to my tree, please rebase and resend.
> 
> Rebase the patchs is a normal process in the development or am I doing something
> wrong ?

It's normal when multiple people are working on the same area with lots
of patches flying around.  Not a problem, it doesn't bother me at all :)

thanks,

greg k-h
