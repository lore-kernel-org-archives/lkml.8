Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8044DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474C820838
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597342855;
	bh=eYRnVCx+kGvQN0sevfFUKsl7sCBkYj27WjTIGLH4d2Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=FKzSqQIPtUwHz/66le/93O8o8x0+Y7zI2BuPoPJK2JSw+XIukxtZrhaScvoznOI3F
	 CSYPXbq8GCguGzJMeDs6V6P8BSTXvYjlwuJSEqbGxediODX7NXuqlpaLR6GTAPK57H
	 gJkBaqYyeKv1TSsMehSnr/Hfhr5zVdlNES08ydLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHMSUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHMSUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 14:20:53 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40289204EC;
        Thu, 13 Aug 2020 18:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597342853;
        bh=eYRnVCx+kGvQN0sevfFUKsl7sCBkYj27WjTIGLH4d2Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bdlYiV/yFOIIKX253p9IMBsP3O+Pnsq967Fq4PfKBpmYS5PIvAkD6XZsXdQPXZIZn
         wrGClttuHSP4nRfL9fAAZ30uAUR8ceA7sHm2scQ95k6tEGQxIlJUuqi61vT6mmrYuP
         arFkJNcB24d8XND/6aLrfqVgcDrux4vh+c5CutzE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D9880352279C; Thu, 13 Aug 2020 11:20:52 -0700 (PDT)
Date:   Thu, 13 Aug 2020 11:20:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
Message-ID: <20200813182052.GE4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200527135329.1172644-1-arnd@arndb.de>
 <878serh1b9.fsf@nanos.tec.linutronix.de>
 <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com>
 <87h7t6tpye.fsf@nanos.tec.linutronix.de>
 <20200813173701.GC4295@paulmck-ThinkPad-P72>
 <20200813180933.GA532283@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813180933.GA532283@rani.riverdale.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 02:09:33PM -0400, Arvind Sankar wrote:
> On Thu, Aug 13, 2020 at 10:37:01AM -0700, Paul E. McKenney wrote:
> > On Thu, Aug 13, 2020 at 07:28:57PM +0200, Thomas Gleixner wrote:
> > > Nick Desaulniers <ndesaulniers@google.com> writes:
> > > > On Thu, Aug 6, 2020 at 3:11 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >> > + *
> > > >> > + * Clang sometimes fails to kill the reference to the dummy variable, so
> > > >> > + * provide an actual copy.
> > > >>
> > > >> Can that compiler be fixed instead?
> > > >
> > > > I don't think so. The logic in the compiler whether to emit an
> > > 
> > > Forget that I asked. Heat induced brain damaged.
> > > 
> > > > I'd much rather remove all of __force_order.
> > > 
> > > Right.
> > > 
> > > > Not sure about the comment in arch/x86/include/asm/special_insns.h
> > > > either; smells fishy like a bug with a compiler from a long time ago.
> > > > It looks like it was introduced in:
> > > > commit d3ca901f94b32 ("x86: unify paravirt parts of system.h")
> > > > Lore has this thread:
> > > > https://lore.kernel.org/lkml/4755A809.4050305@qumranet.com/
> > > > Patch 4: https://lore.kernel.org/lkml/11967844071346-git-send-email-gcosta@redhat.com/
> > > > It seems like there was a discussion about %cr8, but no one asked
> > > > "what's going on here with __force_order, is that right?"
> > > 
> > > Correct and the changelog is uselss in this regard.
> > > 
> > > > Quick boot test of the below works for me, though I should probably
> > > > test hosting a virtualized guest since d3ca901f94b32 refers to
> > > > paravirt.  Thoughts?
> > > 
> > > Let me ask (hopefully) useful questions this time:
> > > 
> > >   Is a compiler allowed to reorder two 'asm volatile()'?
> > > 
> > >   Are there compilers (gcc >= 4.9 or other supported ones) which do that?
> > 
> > I would hope that the answer to both of these questions is "no"!
> > 
> > But I freely confess that I have been disappointed before on this sort
> > of thing.  :-/
> > 
> > 							Thanx, Paul
> 
> Ok, I found this, so gcc developers consider re-ordering volatile asm
> wrt each other a bug at least.
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602

Whew!!!  ;-)

							Thanx, Paul
