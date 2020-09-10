Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6C7C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B032067C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1IboDV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgIJRnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgIJRl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:41:29 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAACC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:41:17 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t76so6705937oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ATdJdtrrGQs40AB3pAJaPiKELI+qIaGQiGwD413skg=;
        b=s1IboDV+5v/GRORnn7PeYV0l5Wu9lL1nSqTQFlmFaPKFJLXtecqcf/fF8tE8/TBzFO
         wwko5dfbZDLn4eQwiMdwMtaeAwbxcyMcNSrcmwcMOn3OhK75W+2R0JMdzJurCcZrbJkP
         Aj26foauya/lB6hvQxoJ9UV6SIiv7Wx7xQdQab6tQZiOH9gLwtyGWJ0sfxvcTvHLfm+n
         tsSey7Dl8WMXWipZQv8iolcq6jQBRRRGCvoNk4C55Q5vbgBS3P+t47LwGafvHf+8cbD9
         tEYY2rXnyqBrxsujG5V89lCiwKjUHnQBSjuWeBKEtLaiZF0sc5GaRbmgOg3XZZyh/Aq0
         b5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ATdJdtrrGQs40AB3pAJaPiKELI+qIaGQiGwD413skg=;
        b=X96dTxySnmCGdKnwLWAdZD7V/WaCfazVZWksTW1dBzdJdduInDhpQy9WA3BNtmca/h
         G2M7pf8/wgIQF94fv4jS19WyS1kTxjpZpGe9Ldu9KvETGI0moE1H7TdMetSB/gf7SZEb
         fW2o18ZVUn71JJCe2Iw+ych5jfLjJd2Hmz/liZvlTRxj7rBnfH98ANFHMh3+oOKOYlP3
         IYvhej7rm7/F3gA6z9hfuMd65N7dOuxozyeJ33E8KkYl3UzhI646z/VeWrGbqMyf3aJM
         2ZMupIk0Zf+c41OEJJVmo7KNzjNzxXltZzdgZBrfaIbRpquncaNW33o2eH/6yZoxMD7v
         i4VQ==
X-Gm-Message-State: AOAM531sntyTSsZY5R2xIPUd9JDu4u2UlX8twwGEnqcGOonaL0H6JvHZ
        qhDc/WxHdXhB+WWFSbwnlORekUDiK/Yqst7XUl3ImQ==
X-Google-Smtp-Source: ABdhPJzLL0bwB+luoUJV/L6Tg/d9FthCbcG3Z5v/fHjAGvSmsEKDMAUcDV0H7RwYClSVyOq990hNd20DUyp67bzsrQw=
X-Received: by 2002:aca:5158:: with SMTP id f85mr709168oib.121.1599759676956;
 Thu, 10 Sep 2020 10:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <20200907134055.2878499-2-elver@google.com>
 <CACT4Y+bfp2ch2KbSMkUd3142aA4p2CiMOmdXrr0-muu6bQ5xXg@mail.gmail.com>
 <CAG_fn=W4es7jaTotDORt2SwspE4A804mdwAY1j4gcaSEKtRjiw@mail.gmail.com> <CACT4Y+awrz-j8y5Qc8OS9qkov4doMnw1V=obwp3MB_LTvaUFXw@mail.gmail.com>
In-Reply-To: <CACT4Y+awrz-j8y5Qc8OS9qkov4doMnw1V=obwp3MB_LTvaUFXw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 10 Sep 2020 19:41:05 +0200
Message-ID: <CANpmjNOTJsZeH_sMx=3XNZuvCih+A9m3uTeSGcmpNH9YbiF2sQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/10] mm: add Kernel Electric-Fence infrastructure
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 at 19:11, Dmitry Vyukov <dvyukov@google.com> wrote:
>
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

In the case here, we have to defer freeing the object, because unlike
real SLAB_TYPESAFE_BY_RCU slabs, our page here may get recycled for
other-typed objects. We can update the comment to be clearer.
