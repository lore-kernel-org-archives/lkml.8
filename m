Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE389C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CB92087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580800173;
	bh=scoweAY6anUw8k9z4VoD+ICWjo02gSzC10Rh6liDJfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I4sxmqZV5WygCgSJqicQ2ed6hMneEouR+toB6uVtwrApUZDpieriJPdHKLaoijF/7
	 pb6NKKO43538jUzR8RBPvFo8TFALJfsHQGC5sYY9WPs5qZt9gv6BHGSSNJ+vx14j3C
	 TuAV88Pmftc//5qrkVp8TmIY7TFvM3OWgDCX/fvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgBDHJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 02:09:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgBDHJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:09:32 -0500
Received: from localhost (unknown [167.98.85.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A28F2086A;
        Tue,  4 Feb 2020 07:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580800169;
        bh=scoweAY6anUw8k9z4VoD+ICWjo02gSzC10Rh6liDJfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKO2dIXaArwgdWAM9HmMcFElchJGp6FfLH+JQv0mvebG6G1Tphb4/4ZEtaoWSpQzF
         0CRyYtTVRgCSwEONIxEVOpm9fBgkJY2kxsFNxloRwwRONUoDm15uVOAfDa0BMNM6z6
         N77RAxRplWp5eTl+PZCfy4C2JLSLK//B44vdO+4M=
Date:   Tue, 4 Feb 2020 07:09:27 +0000
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "brandonbonaby94@gmail.com" <brandonbonaby94@gmail.com>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "fw@strlen.de" <fw@strlen.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
        "bobdc9664@seznam.cz" <bobdc9664@seznam.cz>,
        "sandro@volery.com" <sandro@volery.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "ivalery111@gmail.com" <ivalery111@gmail.com>,
        "ynezz@true.cz" <ynezz@true.cz>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "wambui.karugax@gmail.com" <wambui.karugax@gmail.com>
Subject: Re: [PATCH 1/2] staging: octeon: delete driver
Message-ID: <20200204070927.GA966981@kroah.com>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <6f934497-0635-7aa0-e7d5-ed2c4cc48d2d@roeck-us.net>
 <da150cdb160b5d1b58ad1ea2674cc93c1fc6aadc.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da150cdb160b5d1b58ad1ea2674cc93c1fc6aadc.camel@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 04:02:15AM +0000, Chris Packham wrote:
> I'll pipe up on this thread too
> 
> On Tue, 2019-12-10 at 02:42 -0800, Guenter Roeck wrote:
> > On 12/10/19 1:15 AM, Greg Kroah-Hartman wrote:
> > > This driver has been in the tree since 2009 with no real movement to get
> > > it out.  Now it is starting to cause build issues and other problems for
> > > people who want to fix coding style problems, but can not actually build
> > > it.
> > > 
> > > As nothing is happening here, just delete the module entirely.
> > > 
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Cc: David Daney <ddaney@caviumnetworks.com>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > Cc: YueHaibing <yuehaibing@huawei.com>
> > > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > Cc: Wambui Karuga <wambui.karugax@gmail.com>
> > > Cc: Julia Lawall <julia.lawall@lip6.fr>
> > > Cc: Florian Westphal <fw@strlen.de>
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Cc: Branden Bonaby <brandonbonaby94@gmail.com>
> > > Cc: "Petr Štetiar" <ynezz@true.cz>
> > > Cc: Sandro Volery <sandro@volery.com>
> > > Cc: Paul Burton <paulburton@kernel.org>
> > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > Cc: Giovanni Gherdovich <bobdc9664@seznam.cz>
> > > Cc: Valery Ivanov <ivalery111@gmail.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> Please can we keep this driver. We do have platforms using it and we
> would like it to stay around.
> 
> Clearly we'll need to sort things out to a point where they build
> successfully. We've been hoping to see this move out of staging ever
> since we selected Cavium as a vendor.

Great, can you send me a patchset that reverts this and fixes the build
issues and accept maintainership of the code?

thanks,

greg k-h
