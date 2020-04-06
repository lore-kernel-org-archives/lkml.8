Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63CCC2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8083920719
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586195893;
	bh=e06vrVeML9BgrogDrHrkIp58yEz5FUbz+0h5lORW6os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yq3zzvogP4oeyEnrUVs3yGn4zLUFgcycTzyl3o+YJcqply2B90BeqNSEbaYx7RrJa
	 AS/p7VsNmS6xH1CvuU1Q0wPeyslTLxtJfB9DHJDlK1OzaEtABNIniKw2aP3CaUZMAu
	 2l7DOyXAsGX9vVMCdYxanrbzD1BAjIkDs5DFWHh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgDFR6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgDFR6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:58:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1730D206F8;
        Mon,  6 Apr 2020 17:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586195891;
        bh=e06vrVeML9BgrogDrHrkIp58yEz5FUbz+0h5lORW6os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0Fr7y1LzcIEae6Qsb4GharopeCTFtdrHj4Qn6VPzfRayz6ZNT4l00fWUty2aW0g/
         +ANDIgha7SuFM59OpjHfzpBhpn8VhhGc73P3D5yrkEvpyutNBWwcuRwJ5kTz42fAa1
         8D2/Kgi9YmHFX4/sFIjHzGQYoAL3lCy5VvBr+64E=
Date:   Mon, 6 Apr 2020 19:58:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Forest Bond <forest@alittletooquiet.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/3] staging: vt6656: Use define instead of magic number
 for tx_rate
Message-ID: <20200406175808.GB167424@kroah.com>
References: <20200404141400.3772-1-oscar.carter@gmx.com>
 <20200404141400.3772-3-oscar.carter@gmx.com>
 <20200406142212.GA48502@kroah.com>
 <20200406163835.GB3230@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406163835.GB3230@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 06:38:36PM +0200, Oscar Carter wrote:
> On Mon, Apr 06, 2020 at 04:22:12PM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Apr 04, 2020 at 04:13:59PM +0200, Oscar Carter wrote:
> > > Use the define RATE_11M present in the file "device.h" instead of the
> > > magic number 3. So the code is more clear.
> > >
> > > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > > Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > >  drivers/staging/vt6656/baseband.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
> > > index 3e4bd637849a..a785f91c1566 100644
> > > --- a/drivers/staging/vt6656/baseband.c
> > > +++ b/drivers/staging/vt6656/baseband.c
> > > @@ -24,6 +24,7 @@
> > >
> > >  #include <linux/bits.h>
> > >  #include <linux/kernel.h>
> > > +#include "device.h"
> > >  #include "mac.h"
> > >  #include "baseband.h"
> > >  #include "rf.h"
> > > @@ -141,7 +142,7 @@ unsigned int vnt_get_frame_time(u8 preamble_type, u8 pkt_type,
> > >
> > >  	rate = (unsigned int)vnt_frame_time[tx_rate];
> > >
> > > -	if (tx_rate <= 3) {
> > > +	if (tx_rate <= RATE_11M) {
> > >  		if (preamble_type == 1)
> > >  			preamble = 96;
> > >  		else
> > > --
> > > 2.20.1
> >
> > This doesn't apply to my tree :(
> >
> Sorry, but I don't understand what it means. This meant that I need to rebase
> this patch against your staging-next branch of your staging tree ?

Yes, and 3/3 as well, because I dropped the 1/3 patch here.

thanks,

greg k-h
