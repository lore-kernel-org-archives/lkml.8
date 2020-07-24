Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520C6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3843E2065E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGXMTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXMTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:19:22 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999B1C0619D3;
        Fri, 24 Jul 2020 05:19:22 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jywfW-001cC2-8O; Fri, 24 Jul 2020 12:19:18 +0000
Date:   Fri, 24 Jul 2020 13:19:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 04/20] unify generic instances of
 csum_partial_copy_nocheck()
Message-ID: <20200724121918.GL2786714@ZenIV.linux.org.uk>
References: <20200724012512.GK2786714@ZenIV.linux.org.uk>
 <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
 <20200724012546.302155-4-viro@ZenIV.linux.org.uk>
 <20200724064117.GA10522@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724064117.GA10522@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 07:41:17AM +0100, Christoph Hellwig wrote:
> On Fri, Jul 24, 2020 at 02:25:30AM +0100, Al Viro wrote:
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > quite a few architectures have the same csum_partial_copy_nocheck() -
> > simply memcpy() the data and then return the csum of the copy.
> > 
> > hexagon, parisc, ia64, s390, um: explicitly spelled out that way.
> > 
> > arc, arm64, csky, h8300, m68k/nommu, microblaze, mips/GENERIC_CSUM, nds32,
> > nios2, openrisc, riscv, unicore32: end up picking the same thing spelled
> > out in lib/checksum.h (with varying amounts of perversions along the way).
> > 
> > everybody else (alpha, arm, c6x, m68k/mmu, mips/!GENERIC_CSUM, powerpc,
> > sh, sparc, x86, xtensa) have non-generic variants.  For all except c6x
> > the declaration is in their asm/checksum.h.  c6x uses the wrapper
> > from asm-generic/checksum.h that would normally lead to the lib/checksum.h
> > instance, but in case of c6x we end up using an asm function from arch/c6x
> > instead.
> > 
> > Screw that mess - have architectures with private instances define
> > _HAVE_ARCH_CSUM_AND_COPY in their asm/checksum.h and have the default
> > one right in net/checksum.h conditional on _HAVE_ARCH_CSUM_AND_COPY
> > *not* defined.
> 
> net-next has a patch from me killing off csum_and_copy_from_user
> already:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=f1bfd71c8662f20d53e71ef4e18bfb0e5677c27f

Nothing in that patch of yours touches csum_and_copy_from_user(). what
are you talking about?
