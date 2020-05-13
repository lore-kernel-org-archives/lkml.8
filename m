Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82789C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04F9206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589384364;
	bh=QMW+p/VknEQSRsiiebDSJIJu6BKqq/ST0lr0lMg3vjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UpqpkdYwghV87K4cD+dHf9v9iFgeuaxB3BpP545Dt+LgUgwjcmwpDndCAPkNxKXyb
	 e3itXMrVBgcEIMdvq7VlKDlkoewqzVCa38nrWKhUQlRMlfk9lkVSWL6jBRkD5sCKhe
	 Be7f3o97Q+NMsHU/dgtTsArL1jgVd9QPJ1dcUsmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbgEMPjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728678AbgEMPjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:39:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A4B205CB;
        Wed, 13 May 2020 15:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589384361;
        bh=QMW+p/VknEQSRsiiebDSJIJu6BKqq/ST0lr0lMg3vjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xVeWGJQEqALgzgRglNDpCMXaEA8kIZ31iN1cVQVKMEZL2SHjs1gjnD8xJkCUkbmTS
         n06rxNOiJ5fIZ59jmpV70JW2dOY+Z89JUtYEK3AVE9aHQJgkKZd5JMqGjidQjucyvy
         VIifaWt9MFQjeyI4GvBfOTLI7yIgPvAWBrO1OduU=
Date:   Wed, 13 May 2020 17:39:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Replace zero-length array with
 flexible-array
Message-ID: <20200513153918.GA1360420@kroah.com>
References: <20200507185318.GA14393@embeddedor>
 <20200513150343.GZ25962@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513150343.GZ25962@localhost>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 05:03:43PM +0200, Johan Hovold wrote:
> On Thu, May 07, 2020 at 01:53:18PM -0500, Gustavo A. R. Silva wrote:
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][2],
> > introduced in C99:
> > 
> > struct foo {
> >         int stuff;
> >         struct boo array[];
> > };
> > 
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > inadvertently introduced[3] to the codebase from now on.
> > 
> > Also, notice that, dynamic memory allocations won't be affected by
> > this change:
> > 
> > "Flexible array members have incomplete type, and so the sizeof operator
> > may not be applied. As a quirk of the original implementation of
> > zero-length arrays, sizeof evaluates to zero."[1]
> > 
> > sizeof(flexible-array-member) triggers a warning because flexible array
> > members have incomplete type[1]. There are some instances of code in
> > which the sizeof operator is being incorrectly/erroneously applied to
> > zero-length arrays and the result is zero. Such instances may be hiding
> > some bugs. So, this work (flexible-array member conversions) will also
> > help to get completely rid of those sorts of issues.
> > 
> > This issue was found with the help of Coccinelle.
> > 
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://github.com/KSPP/linux/issues/21
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/greybus/arpc.h                    |    2 -
> >  include/linux/greybus/greybus_protocols.h |   44 +++++++++++++++---------------
> 
> I noticed Greg just applied this one to his -testing branch, but do we
> really want this in greybus_protocols.h, which is meant to be shared
> with the firmware side? Perhaps not an issue, just figured I'd point
> this out.

Why not, it should be the same thing, right?  No logic has changed that
I see.

thanks,

greg k-h
