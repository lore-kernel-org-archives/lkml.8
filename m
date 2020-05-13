Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7143ACA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D82320575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589364293;
	bh=BkUzNAvRjDhZ5sh9KsFgyFVKv9jNomu1O2R+MD3pou8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LDn/I+mbhgDtFHMGhN9zEOTU9EIbXAlDcC6ou/IeRjRisAEQYTUq9sC99Od/1n8JT
	 +5ijs+cNK+lhluWhSldXO24KRnqyhM1lvLhGm4xTZXnSUfGz/Co5etd5NfdyVhpcUv
	 tkV8/JTiZcnSDARgbLjUfT75TGMJonn64KLuKu+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388711AbgEMKEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732876AbgEMKEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:04:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E505A206B8;
        Wed, 13 May 2020 10:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589364288;
        bh=BkUzNAvRjDhZ5sh9KsFgyFVKv9jNomu1O2R+MD3pou8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PV5yqOxp7v0teWZ5crR2ehluwOXrr3DcmlDcWZhM/f7bVtRBh3J3jGfx5jnfBhP2B
         176rRIBdxukTGVFgS0qqR0iPcOSHajdIJXAg4RNUMFJJLU3l1lzt9L6CKaKl6WEa5S
         EoNHAQIZWgoUsUYUmjrmADoa3W7ZzdcmSboXjA8g=
Date:   Wed, 13 May 2020 12:04:46 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Ravich, Leonid" <Leonid.Ravich@dell.com>
Cc:     "Idgar, Or" <Or.Idgar@dell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: CMA enhancement - non-default areas in x86
Message-ID: <20200513100446.GB868852@kroah.com>
References: <CH2PR19MB3767236EDC9BE964FC3AB91BFEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
 <20200513064755.GA763968@kroah.com>
 <CH2PR19MB376794E120B9B02856DC87C3FEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
 <20200513071413.GB766804@kroah.com>
 <DM6PR19MB26827EFC4DDC6CB9DD5C52D098BF0@DM6PR19MB2682.namprd19.prod.outlook.com>
 <20200513083343.GA772573@kroah.com>
 <DM6PR19MB268231FBFEA47D7C4CEAF29098BF0@DM6PR19MB2682.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR19MB268231FBFEA47D7C4CEAF29098BF0@DM6PR19MB2682.namprd19.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 09:43:45AM +0000, Ravich, Leonid wrote:
> > On Wed, May 13, 2020 at 08:29:16AM +0000, Ravich, Leonid wrote:
> > > PCIe NTB
> > > Documentation/driver-api/ntb.rst
> > 
> > > 1) Basically PCI bridge between to root complex / PCI switches
> > > 2) using out of OS memory is one solution but then this memory is
> > > Limited for usage by other stack, ex: get_user_pages on this memory
> > > will fail, Therefore attempting to use it for block layer with (o_direct) will
> > fail.
> > >
> > > Acutely any generic stack which attempts to "pin" this memory will fail.
> > 
> > So why isn't the BIOS/UEFI properly reserving this from the general operating
> > system's pages so that the driver knows to use them instead?
> > 
> > Is UEFI wrong here about these being valid memory ranges for general use?
> > If so, why not fix that?  If not, how in the world is the OS supposed to know
> > these memory ranges are _not_ for general use?  I feel like there is
> > something missing here...
> >
> Maybe I am miss understanding something here , but if BIOS/UEFI will reserve this pages 
> They will be "out of kernel" which will work for propriety driver but this memory will not 
> be useable for generic driver which will attempt to pin this memory with get_user_pages() .
> so we can go and try to fix that  (not sure this is the right way) .

What do you mean by "propriety" driver vs. "generic" driver?

Shouldn't there be some "generic" way that UEFI tells any driver where
these memory locations are that can not be used as general memory?  If
not, try fixing up UEFI for that.

> another option here is to use some kernel infrastructure  which  from one side reserve the memory from general use
> on the other hand kernel will be aware of this pages so get_user_pages()  will work on this memory .
> 
> from what we saw CMA infrastructure can support  such requirements.

CMA needs to be told where to reserve the memory at boot time.  If you
want to use that, great, but something has to tell it, so perhaps just
get that info from UEFI as that is the "equilivant" to a device tree,
right?

Try it all out and see, all of this is pointless without real patches,
which is why we almost never have these kinds of discussions without
working code.

thanks,

greg k-h
