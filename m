Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16689C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71ED20714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgC0Cmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:42:32 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48240 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgC0Cmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:42:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHex1-003hql-9z; Fri, 27 Mar 2020 02:42:27 +0000
Date:   Fri, 27 Mar 2020 02:42:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 5/7] x86: convert arch_futex_atomic_op_inuser() to
 user_access_begin/user_access_end()
Message-ID: <20200327024227.GT23230@ZenIV.linux.org.uk>
References: <20200323185057.GE23230@ZenIV.linux.org.uk>
 <20200323185127.252501-1-viro@ZenIV.linux.org.uk>
 <20200323185127.252501-5-viro@ZenIV.linux.org.uk>
 <CAHk-=wgMmmnQTFT7U9+q2BsyV6Ge+LAnnhPmv0SUtFBV1D4tVw@mail.gmail.com>
 <20200324020846.GG23230@ZenIV.linux.org.uk>
 <CAHk-=whTwaUZZ5Aj_Viapf2tdvcd65WdM4jjXJ3tdOTDmgkW0g@mail.gmail.com>
 <20200324204246.GH23230@ZenIV.linux.org.uk>
 <CAHk-=whnTRF5yA2MrPGcmMm=hXaGHfC2HEDtNzA=_1=szhJ4-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whnTRF5yA2MrPGcmMm=hXaGHfC2HEDtNzA=_1=szhJ4-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 01:57:19PM -0700, Linus Torvalds wrote:
> On Tue, Mar 24, 2020 at 1:45 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > OK...  BTW, I'd been trying to recall the reasons for the way
> > __futex_atomic_op2() loop is done; ISTR some discussion along
> > the lines of cacheline ping-pong prevention, but I'd been unable
> > to reconstruct enough details to find it and I'm not sure it
> > hadn't been about some other code ;-/
> 
> No, that doesn't look like any cacheline advantage I can think of -
> quite the reverse.
> 
> I suspect it's just lazy code, with the reload being unnecessary. Or
> it might be written that way because you avoid an extra variable.
> 
> In fact, from a cacheline optimization standpoint, there are
> advantages to not doing the load even on the initial run: if you know
> a certain value is particularly likely, there are advantages to just
> _assuming_ that value, rather than loading it. So no initial load at
> all, and just initialize the first value to the likely case.
> 
> That can avoid an unnecessary "load for shared ownership" cacheline
> state transition (since the cmpxchg will want to turn it into an
> exclusive modified cacheline anyway).
> 
> But I don't think that optimization is likely the case here, and
> you're right, the loop would be better written with the initial load
> outside the loop.

OK, updated branch is in the same place; changes: __futex_atomic_op{1,2}
turned into unsafe_atomic_op{1,2}, with "goto on error" folded into those.
And pointless reload removed from cmpxchg loop in unsafe_atomic_op2().
Diffstat:
 arch/alpha/include/asm/futex.h      |  5 +-
 arch/arc/include/asm/futex.h        |  5 +-
 arch/arm/include/asm/futex.h        |  5 +-
 arch/arm64/include/asm/futex.h      |  5 +-
 arch/hexagon/include/asm/futex.h    |  5 +-
 arch/ia64/include/asm/futex.h       |  5 +-
 arch/microblaze/include/asm/futex.h |  5 +-
 arch/mips/include/asm/futex.h       |  5 +-
 arch/nds32/include/asm/futex.h      |  6 +--
 arch/openrisc/include/asm/futex.h   |  5 +-
 arch/parisc/include/asm/futex.h     |  2 -
 arch/powerpc/include/asm/futex.h    |  5 +-
 arch/riscv/include/asm/futex.h      |  5 +-
 arch/s390/include/asm/futex.h       |  2 -
 arch/sh/include/asm/futex.h         |  4 --
 arch/sparc/include/asm/futex_64.h   |  4 --
 arch/x86/include/asm/futex.h        | 97 ++++++++++++++++++++++++-------------
 arch/x86/include/asm/uaccess.h      | 93 -----------------------------------
 arch/xtensa/include/asm/futex.h     |  5 +-
 include/asm-generic/futex.h         |  2 -
 kernel/futex.c                      |  5 +-
 tools/objtool/check.c               |  1 +
 22 files changed, 93 insertions(+), 183 deletions(-)

Sorry about the fuckup when sending that patchset ;-/  It ended up cc'd to
x86 list instead of the futex one; Message-Id of the beginning of the
thread is <20200327022836.881203-1-viro@ZenIV.linux.org.uk>.
