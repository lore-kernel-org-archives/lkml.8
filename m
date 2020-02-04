Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CF0C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191FA2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580856816;
	bh=oxwJvXSqIfXICehj/SghLfgVcbieW0oDOVxIwdXphck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LyvOkCBsTByIc6wEzprflJaqupL/3iW5c9s2SQCKOt1KMohBublMN04yqbM5Dr8i0
	 jSJ3agD3Pag6Vc9xVBhRcspPGp3u9Mmm0/liAwgtr6xOZWpir3o0iUkTdXx/oz5ojp
	 TJjQWtH9jZOnKJ1/2YAaIj2Fami5vfM5HfCIxWIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgBDWxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:53:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgBDWxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 17:53:35 -0500
Received: from localhost (unknown [167.98.85.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8A32084E;
        Tue,  4 Feb 2020 22:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580856814;
        bh=oxwJvXSqIfXICehj/SghLfgVcbieW0oDOVxIwdXphck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=suYV9xqyxODkhiSyMOMTvwm0iiZhH1MYizjV4dK0YLem/fMLCJkqGNKxe3W5QxGxK
         BXpilZWtXehy0JhBNdivHZurUzUc6VDgIJXWNMSPPrpgzMcPQ1VBqMltLFN9+0176j
         O/5Jr74Xcj9wVm7X3II2m7DeJH/ZbefC6Rek0kiw=
Date:   Tue, 4 Feb 2020 22:53:32 +0000
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "brandonbonaby94@gmail.com" <brandonbonaby94@gmail.com>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
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
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "wambui.karugax@gmail.com" <wambui.karugax@gmail.com>
Subject: Re: [PATCH 1/2] staging: octeon: delete driver
Message-ID: <20200204225332.GC1128093@kroah.com>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <6f934497-0635-7aa0-e7d5-ed2c4cc48d2d@roeck-us.net>
 <da150cdb160b5d1b58ad1ea2674cc93c1fc6aadc.camel@alliedtelesis.co.nz>
 <20200204070927.GA966981@kroah.com>
 <1a90dc4c62c482ed6a44de70962996b533d6f627.camel@alliedtelesis.co.nz>
 <20200204203116.GN8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200204203116.GN8731@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 12:31:16PM -0800, Matthew Wilcox wrote:
> On Tue, Feb 04, 2020 at 08:06:14PM +0000, Chris Packham wrote:
> > On Tue, 2020-02-04 at 07:09 +0000, gregkh@linuxfoundation.org wrote:
> > > On Tue, Feb 04, 2020 at 04:02:15AM +0000, Chris Packham wrote:
> > > > I'll pipe up on this thread too
> > > > 
> > > > On Tue, 2019-12-10 at 02:42 -0800, Guenter Roeck wrote:
> > > > > On 12/10/19 1:15 AM, Greg Kroah-Hartman wrote:
> > > > > > This driver has been in the tree since 2009 with no real movement to get
> > > > > > it out.  Now it is starting to cause build issues and other problems for
> > > > > > people who want to fix coding style problems, but can not actually build
> > > > > > it.
> > > > > > 
> > > > > > As nothing is happening here, just delete the module entirely.
> > > > > > 
> > > > > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > > > > Cc: David Daney <ddaney@caviumnetworks.com>
> > > > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > > > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > > > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > > > > Cc: YueHaibing <yuehaibing@huawei.com>
> > > > > > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > > > > Cc: Wambui Karuga <wambui.karugax@gmail.com>
> > > > > > Cc: Julia Lawall <julia.lawall@lip6.fr>
> > > > > > Cc: Florian Westphal <fw@strlen.de>
> > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > Cc: Branden Bonaby <brandonbonaby94@gmail.com>
> > > > > > Cc: "Petr Štetiar" <ynezz@true.cz>
> > > > > > Cc: Sandro Volery <sandro@volery.com>
> > > > > > Cc: Paul Burton <paulburton@kernel.org>
> > > > > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > > Cc: Giovanni Gherdovich <bobdc9664@seznam.cz>
> > > > > > Cc: Valery Ivanov <ivalery111@gmail.com>
> > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > 
> > > > > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > > > 
> > > > Please can we keep this driver. We do have platforms using it and we
> > > > would like it to stay around.
> > > > 
> > > > Clearly we'll need to sort things out to a point where they build
> > > > successfully. We've been hoping to see this move out of staging ever
> > > > since we selected Cavium as a vendor.
> > > 
> > > Great, can you send me a patchset that reverts this and fixes the build
> > > issues and accept maintainership of the code?
> > > 
> > 
> > Yep will do.
> > 
> > On Tue, 2020-02-04 at 10:21 +0300, Dan Carpenter wrote:
> > > My advice is to delete all the COMPILE_TEST code.  That stuff was a
> > > constant source of confusion and headaches.
> > 
> > I was also going to suggest this. Since the COMPILE_TEST has been a
> > source of trouble I was going to propose dropping the || COMPILE_TEST
> > from the Kconfig for the octeon drivers.
> 
> Not having it also causes problems.  I didn't originally add it for
> shits and giggles.

Yes, without this option, the code bit-rotted horribly.  It needs to be
able to be built otherwise people will change the code and it will break
and no one will notice except Guenter's build bots and then no one will
fix it :(

i.e. exactly what was happening before...

So this needs to all be fixed up properly, and really, should be merged
to the "real" part of the kernel...

thanks,

greg k-h
