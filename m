Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A348C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 03:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA222072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 03:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bogjU8Yl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgBEDpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 22:45:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgBEDpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 22:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y7L1/booVthxxiJ/wy0zkPYQFHGO1CqBFtYiAgkDZbA=; b=bogjU8YlzDGSHGrbrPsxDxFVnO
        PoHGL9mrtfLaHmKf6OKN9XdD8O2vMpGmDyXAUdPJE2iEjRkpcrURJ/bC4q9ZZQZ6Lx/cnZ/Iy/4Dg
        Jh0/3pv2hPUwU8VfkqH2zwaJC7m7ZOEu0vFLUPG487x4EwFmIQ6W9sUOtnH+tJXAk6jHLl4HJ2ajW
        pYkzBoAAgq9JvqZ3nJkwEzepAm0PN596wJ4sruVR2K+AEbTIsdKJJ0pWlvX+yDv0yAAqtJhTFWiT5
        grOW7UwniG3FCPgX+s41xYkOJb+mNb5kSh0k7zsXKi34OWxg1xHUDpHcbX4Jdtzer5H+9bi2q2qBy
        3iILHU8A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izBc3-0002c9-NF; Wed, 05 Feb 2020 03:44:27 +0000
Date:   Tue, 4 Feb 2020 19:44:27 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "brandonbonaby94@gmail.com" <brandonbonaby94@gmail.com>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fw@strlen.de" <fw@strlen.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
        "bobdc9664@seznam.cz" <bobdc9664@seznam.cz>,
        "sandro@volery.com" <sandro@volery.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "ivalery111@gmail.com" <ivalery111@gmail.com>,
        "ynezz@true.cz" <ynezz@true.cz>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wambui.karugax@gmail.com" <wambui.karugax@gmail.com>
Subject: Re: [PATCH 1/2] staging: octeon: delete driver
Message-ID: <20200205034427.GS8731@bombadil.infradead.org>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <6f934497-0635-7aa0-e7d5-ed2c4cc48d2d@roeck-us.net>
 <da150cdb160b5d1b58ad1ea2674cc93c1fc6aadc.camel@alliedtelesis.co.nz>
 <20200204070927.GA966981@kroah.com>
 <1a90dc4c62c482ed6a44de70962996b533d6f627.camel@alliedtelesis.co.nz>
 <20200204203116.GN8731@bombadil.infradead.org>
 <20200205033416.GT1778@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205033416.GT1778@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 06:34:16AM +0300, Dan Carpenter wrote:
> On Tue, Feb 04, 2020 at 12:31:16PM -0800, Matthew Wilcox wrote:
> > On Tue, Feb 04, 2020 at 08:06:14PM +0000, Chris Packham wrote:
> > > On Tue, 2020-02-04 at 07:09 +0000, gregkh@linuxfoundation.org wrote:
> > > > On Tue, Feb 04, 2020 at 04:02:15AM +0000, Chris Packham wrote:
> > > On Tue, 2020-02-04 at 10:21 +0300, Dan Carpenter wrote:
> > > > My advice is to delete all the COMPILE_TEST code.  That stuff was a
> > > > constant source of confusion and headaches.
> > > 
> > > I was also going to suggest this. Since the COMPILE_TEST has been a
> > > source of trouble I was going to propose dropping the || COMPILE_TEST
> > > from the Kconfig for the octeon drivers.
> > 
> > Not having it also causes problems.  I didn't originally add it for
> > shits and giggles.
> 
> I wonder if the kbuild bot does enough cross compile build testing these
> days to detect compile problems.  It might have improved to the point
> where COMPILE_TEST isn't required.

Well, that was the problem.  I posted the patch and Dave Miller merged it
before the build bot had the chance to point out that I'd missed it.
So relying on the build bot is not sufficient.

> One of the things about having a bunch of dummy functions for
> COMPILE_TEST is that they introduce a lot of static checker warnings.
> The real function is supposed to initialize stuff but the dummy function
> just returns so now we get uninitialized variable warnings etc.

Perhaps we need a better solution for the dummy functions than just
returning.  We can initialise the variables / structs to 0, for example.
I fully accept that I did a poor job of writing the dummy functions.
