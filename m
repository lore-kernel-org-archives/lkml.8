Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F3EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD72207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgFMPl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgFMPl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:41:27 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3E7C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:41:27 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jk8HW-008ELI-J8; Sat, 13 Jun 2020 15:41:18 +0000
Date:   Sat, 13 Jun 2020 16:41:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
Message-ID: <20200613154118.GH23230@ZenIV.linux.org.uk>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
 <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
 <20200612135538.GA13399@afzalpc>
 <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
 <20200613120432.GA5319@afzalpc>
 <20200613125126.GE23230@ZenIV.linux.org.uk>
 <20200613125615.GF23230@ZenIV.linux.org.uk>
 <20200613134236.GA4086@afzalpc>
 <20200613153102.GG23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613153102.GG23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 04:31:02PM +0100, Al Viro wrote:
> On Sat, Jun 13, 2020 at 07:12:36PM +0530, afzal mohammed wrote:
> > Hi,
> > 
> > On Sat, Jun 13, 2020 at 01:56:15PM +0100, Al Viro wrote:
> > 
> > > Incidentally, what about get_user()/put_user()?  _That_ is where it's
> > > going to really hurt...
> > 
> > All other uaccess routines are also planned to be added, posting only
> > copy_{from,to}_user() was to get early feedback (mentioned in the
> > cover letter)
> 
> Sure, but what I mean is that I'd expect the performance loss to be
> dominated by that, not by copy_from_user/copy_to_user on large amounts
> of data.  Especially on the loads like kernel builds - a lot of stat()
> and getdents() calls there.

To clarify: stat() means small copy_to_user(), getdents() - a mix of
put_user() and small copy_to_user().  I would be very surprised if it
does not hurt a lot.
