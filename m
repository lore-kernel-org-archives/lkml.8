Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D37C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 20:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B660F2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 20:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eb/+Qll3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgBDUbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:31:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgBDUbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 15:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Eu9GqXtK/l01BRKY5MaH0T26o4LWxGBFtxT+Sqy2At0=; b=eb/+Qll3sWrmKSHxQU9iT1kfMP
        k7NzIrfllcEgTOM34fqnUWirEWv0G1hJunMF3t+myQgtLvn5p2TZ56dnHB9wAUhjRBHK30B7glzST
        3p7oZAN5uqaFPul0fNPvu6UiDGmv0sVOksrLLMJGXE+c4UYDQ3KtTTQZOir5r1TSnyrF+RVq4sZQr
        dn8pGIkB5B+Ib9Lmxjg2mWMPTFARfRt4LSflK3OGsHiwkQP4vVKwiYwuAuTAEmWQbDMAhX8QO0qkl
        M3/OZh4WSN/y9kilO2XQhX30g07VI//PgwJzKt46tocRFGf02dej5mPVrhC1zaUdTdSvDXT575rFO
        C9ZTlR4g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iz4qq-0007Zf-6k; Tue, 04 Feb 2020 20:31:16 +0000
Date:   Tue, 4 Feb 2020 12:31:16 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wambui.karugax@gmail.com" <wambui.karugax@gmail.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "fw@strlen.de" <fw@strlen.de>,
        "bobdc9664@seznam.cz" <bobdc9664@seznam.cz>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "brandonbonaby94@gmail.com" <brandonbonaby94@gmail.com>,
        "sandro@volery.com" <sandro@volery.com>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
        "ynezz@true.cz" <ynezz@true.cz>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "ivalery111@gmail.com" <ivalery111@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] staging: octeon: delete driver
Message-ID: <20200204203116.GN8731@bombadil.infradead.org>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <6f934497-0635-7aa0-e7d5-ed2c4cc48d2d@roeck-us.net>
 <da150cdb160b5d1b58ad1ea2674cc93c1fc6aadc.camel@alliedtelesis.co.nz>
 <20200204070927.GA966981@kroah.com>
 <1a90dc4c62c482ed6a44de70962996b533d6f627.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a90dc4c62c482ed6a44de70962996b533d6f627.camel@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 08:06:14PM +0000, Chris Packham wrote:
> On Tue, 2020-02-04 at 07:09 +0000, gregkh@linuxfoundation.org wrote:
> > On Tue, Feb 04, 2020 at 04:02:15AM +0000, Chris Packham wrote:
> > > I'll pipe up on this thread too
> > > 
> > > On Tue, 2019-12-10 at 02:42 -0800, Guenter Roeck wrote:
> > > > On 12/10/19 1:15 AM, Greg Kroah-Hartman wrote:
> > > > > This driver has been in the tree since 2009 with no real movement to get
> > > > > it out.  Now it is starting to cause build issues and other problems for
> > > > > people who want to fix coding style problems, but can not actually build
> > > > > it.
> > > > > 
> > > > > As nothing is happening here, just delete the module entirely.
> > > > > 
> > > > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > > > Cc: David Daney <ddaney@caviumnetworks.com>
> > > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > > > Cc: YueHaibing <yuehaibing@huawei.com>
> > > > > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > > > Cc: Wambui Karuga <wambui.karugax@gmail.com>
> > > > > Cc: Julia Lawall <julia.lawall@lip6.fr>
> > > > > Cc: Florian Westphal <fw@strlen.de>
> > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > Cc: Branden Bonaby <brandonbonaby94@gmail.com>
> > > > > Cc: "Petr Štetiar" <ynezz@true.cz>
> > > > > Cc: Sandro Volery <sandro@volery.com>
> > > > > Cc: Paul Burton <paulburton@kernel.org>
> > > > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > Cc: Giovanni Gherdovich <bobdc9664@seznam.cz>
> > > > > Cc: Valery Ivanov <ivalery111@gmail.com>
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > 
> > > > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > > 
> > > Please can we keep this driver. We do have platforms using it and we
> > > would like it to stay around.
> > > 
> > > Clearly we'll need to sort things out to a point where they build
> > > successfully. We've been hoping to see this move out of staging ever
> > > since we selected Cavium as a vendor.
> > 
> > Great, can you send me a patchset that reverts this and fixes the build
> > issues and accept maintainership of the code?
> > 
> 
> Yep will do.
> 
> On Tue, 2020-02-04 at 10:21 +0300, Dan Carpenter wrote:
> > My advice is to delete all the COMPILE_TEST code.  That stuff was a
> > constant source of confusion and headaches.
> 
> I was also going to suggest this. Since the COMPILE_TEST has been a
> source of trouble I was going to propose dropping the || COMPILE_TEST
> from the Kconfig for the octeon drivers.

Not having it also causes problems.  I didn't originally add it for
shits and giggles.

