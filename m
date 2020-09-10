Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D09C2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4690020BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599769607;
	bh=j1D8IPJ4Y08qnoWlFLiDNLrabhQVaPZSJO9zVTmslg8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=asfV/rIgiZgvFJaFRYbzU0OBme7ta4nt3voNz2gqcY7DiP+Ii4ZPVXG+CDXW4MFjp
	 AzFL6iuG1RBE942vjP73RjyFeojmNHl/q3CATkOgPF47MssxdJbgSlIPpY3kVOduoV
	 eju4D3uyN1Dp/+kcGKeCGtw8pfEgfBB6L19VIODQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgIJU0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgIJUZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:25:28 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E83E20829;
        Thu, 10 Sep 2020 20:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599769527;
        bh=j1D8IPJ4Y08qnoWlFLiDNLrabhQVaPZSJO9zVTmslg8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=doPdBnJsbif/E+6P+b8WZBM0DPFyC8Ar2wQffAXUnGxFuH8CuQy6cIoH1ChJxEEdp
         T/094BXQngRogk0hZw0MrLqFPTkSpdB3jz95pU+oOeYJExyZ+BkHTDqXzi+TVSEyPF
         W22Q8DV32RdLZ+Yl4WNrQphSoWVZuPu3oZHwDtKg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CF0923523080; Thu, 10 Sep 2020 13:25:26 -0700 (PDT)
Date:   Thu, 10 Sep 2020 13:25:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 01/10] mm: add Kernel Electric-Fence infrastructure
Message-ID: <20200910202526.GU29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200907134055.2878499-1-elver@google.com>
 <20200907134055.2878499-2-elver@google.com>
 <CACT4Y+bfp2ch2KbSMkUd3142aA4p2CiMOmdXrr0-muu6bQ5xXg@mail.gmail.com>
 <CAG_fn=W4es7jaTotDORt2SwspE4A804mdwAY1j4gcaSEKtRjiw@mail.gmail.com>
 <CACT4Y+awrz-j8y5Qc8OS9qkov4doMnw1V=obwp3MB_LTvaUFXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+awrz-j8y5Qc8OS9qkov4doMnw1V=obwp3MB_LTvaUFXw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 07:11:41PM +0200, Dmitry Vyukov wrote:
> On Thu, Sep 10, 2020 at 6:19 PM Alexander Potapenko <glider@google.com> wrote:
> >
> > On Thu, Sep 10, 2020 at 5:43 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> >
> > > > +       /* Calculate address for this allocation. */
> > > > +       if (right)
> > > > +               meta->addr += PAGE_SIZE - size;
> > > > +       meta->addr = ALIGN_DOWN(meta->addr, cache->align);
> > >
> > > I would move this ALIGN_DOWN under the (right) if.
> > > Do I understand it correctly that it will work, but we expect it to do
> > > nothing for !right? If cache align is >PAGE_SIZE, nothing good will
> > > happen anyway, right?
> > > The previous 2 lines look like part of the same calculation -- "figure
> > > out the addr for the right case".
> >
> > Yes, makes sense.
> >
> > > > +
> > > > +       schedule_delayed_work(&kfence_timer, 0);
> > > > +       WRITE_ONCE(kfence_enabled, true);
> > >
> > > Can toggle_allocation_gate run before we set kfence_enabled? If yes,
> > > it can break. If not, it's still somewhat confusing.
> >
> > Correct, it should go after we enable KFENCE. We'll fix that in v2.
> >
> > > > +void __kfence_free(void *addr)
> > > > +{
> > > > +       struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
> > > > +
> > > > +       if (unlikely(meta->cache->flags & SLAB_TYPESAFE_BY_RCU))
> > >
> > > This may deserve a comment as to why we apply rcu on object level
> > > whereas SLAB_TYPESAFE_BY_RCU means slab level only.
> >
> > Sorry, what do you mean by "slab level"?
> > SLAB_TYPESAFE_BY_RCU means we have to wait for possible RCU accesses
> > in flight before freeing objects from that slab - that's basically
> > what we are doing here below:
> 
> Exactly! You see it is confusing :)
> SLAB_TYPESAFE_BY_RCU does not mean that. rcu-freeing only applies to
> whole pages, that's what I mean by "slab level" (whole slabs are freed
> by rcu).

Just confirming Dmitry's description of SLAB_TYPESAFE_BY_RCU semantics.

							Thanx, Paul
