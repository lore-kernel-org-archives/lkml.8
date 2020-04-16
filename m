Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1DCC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261F520732
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587018650;
	bh=kqRpyAaduUyON5qHMIXra4FBqaXyvxk32qkeqxVv1Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yY4LE0PfXtoSIjmPiVWyrSWcTTgKJR275IT7BmKLhPaNmW4E/bd+WmZ3VErABfcL0
	 U0bTXu84k9f2daZ/3YZg3Wp1/EHYF2zWSucT0UUYfhIjEAghtW2dyF/HLDPAP1Z/Cm
	 qSr83oEBUluSJvXJkZnBKYIFdUYn+PjajXGUzGMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408110AbgDPGap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407332AbgDPGah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:30:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8161720732;
        Thu, 16 Apr 2020 06:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587018637;
        bh=kqRpyAaduUyON5qHMIXra4FBqaXyvxk32qkeqxVv1Uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbdwHKeK/IH1ewqwP4nqBiVouDPSTrUtcYzQe8iu4qOM6FtNEF1uU7BJBh28xKst8
         JA9NzFpRmUkMLHYDWKL6nPvpU4pyoFLYCEMNp7kKCqfF46Yk83CjubE8Tr8+rEvkat
         +xXVKkM3kxC5j5dhsVXoKUuQz7HxISVwn4yuRtr8=
Date:   Thu, 16 Apr 2020 08:30:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Scott Wood <oss@buserror.net>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Wang Wenhu <wenhu.wang@vivo.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@vivo.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2,5/5] drivers: uio: new driver for fsl_85xx_cache_sram
Message-ID: <20200416063034.GB299193@kroah.com>
References: <20200415124929.GA3265842@kroah.com>
 <20200415152442.122873-1-wenhu.wang@vivo.com>
 <20200415152442.122873-6-wenhu.wang@vivo.com>
 <37b6b890-e537-7424-6b26-04565681f40a@c-s.fr>
 <f2a1f91f92c0fe4bce46c28222dea355d96e2090.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2a1f91f92c0fe4bce46c28222dea355d96e2090.camel@buserror.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:27:51PM -0500, Scott Wood wrote:
> > > +		dev_err(&pdev->dev, "error no valid uio-map configured\n");
> > > +		ret = -EINVAL;
> > > +		goto err_info_free_internel;
> > > +	}
> > > +
> > > +	info->version = "0.1.0";
> > 
> > Could you define some DRIVER_VERSION in the top of the file next to 
> > DRIVER_NAME instead of hard coding in the middle on a function ?
> 
> That's what v1 had, and Greg KH said to remove it.  I'm guessing that he
> thought it was the common-but-pointless practice of having the driver print a
> version number that never gets updated, rather than something the UIO API
> (unfortunately, compared to a feature query interface) expects.  That said,
> I'm not sure what the value is of making it a macro since it should only be
> used once, that use is self documenting, it isn't tunable, etc.  Though if
> this isn't a macro, UIO_NAME also shouldn't be (and if it is made a macro
> again, it should be UIO_VERSION, not DRIVER_VERSION).
> 
> Does this really need a three-part version scheme?  What's wrong with a
> version of "1", to be changed to "2" in the hopefully-unlikely event that the
> userspace API changes?  Assuming UIO is used for this at all, which doesn't
> seem like a great fit to me.

No driver version numbers at all please, they do not make any sense when
the driver is included in the kernel tree.

greg k-h
