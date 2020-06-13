Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A08DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 12:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA162078E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 12:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFMM4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 08:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgFMM4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 08:56:20 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA728C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 05:56:19 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jk5hn-008AgX-Br; Sat, 13 Jun 2020 12:56:15 +0000
Date:   Sat, 13 Jun 2020 13:56:15 +0100
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
Message-ID: <20200613125615.GF23230@ZenIV.linux.org.uk>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
 <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
 <20200612135538.GA13399@afzalpc>
 <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
 <20200613120432.GA5319@afzalpc>
 <20200613125126.GE23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613125126.GE23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 01:51:26PM +0100, Al Viro wrote:
> On Sat, Jun 13, 2020 at 05:34:32PM +0530, afzal mohammed wrote:
> 
> > Observation is that max. pages reaching copy_{from,to}_user() is 2,
> > observed maximum of n (number of bytes) being 1 page size. i think C
> > library cuts any size read, write to page size (if it exceeds) &
> > invokes the system call. Max. pages reaching 2, happens when 'n'
> > crosses page boundary, this has been observed w/ small size request
> > as well w/ ones of exact page size (but not page aligned).
> > 
> > Even w/ dd of various size >4K, never is the number of pages required
> > to be mapped going greater than 2 (even w/ 'dd' 'bs=1M')
> > 
> > i have a worry (don't know whether it is an unnecessary one): even
> > if we improve performance w/ large copy sizes, it might end up in a
> > sluggishness w.r.t user experience due to most (hence a high amount)
> > of user copy calls being few bytes & there the penalty being higher.
> > And benchmark would not be able to detect anything abnormal since
> > usercopy are being tested on large sizes.
> > 
> > Quickly comparing boot-time on Beagle Bone White, boot time increases
> > by only 4%, perhaps this worry is irrelevant, but just thought will
> > put it across.
> 
> Do stat(2) of the same tmpfs file in a loop (on tmpfs, to eliminate
> the filesystem playing silly buggers).  And I wouldn't expect anything
> good there...

Incidentally, what about get_user()/put_user()?  _That_ is where it's
going to really hurt...
