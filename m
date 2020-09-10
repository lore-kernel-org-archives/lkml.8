Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C0AC07548
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9051F214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qio5Y/ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgIJQeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgIJQUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:20:00 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032FFC061795
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 09:19:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z9so669825wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMPZ+VzJ+cGDOwRKaJNQBA78kSsKgAl4Rh0tiwYlTzE=;
        b=qio5Y/ngq6hLvVhm2468rrq1KMTKqMD6reAUvBjeUZg28PU5pE4JmNKzEpw8Dq+ZXy
         +EBIltpVv7QGDdAn4nxre70MoBcYp+ZbE2Ys3VULwUK1yP0HL3DasnxQfvmF0gkR+Q2w
         XXXT1jlovgPhzmb2Azi56ku1TTdNZxdn+K+kr78m2GsuiuQXY9gX12qF88KkpZnemGhJ
         MJssQE/2khIJzxVKek0/2AchROZlEnhoQlFEPM6sUEfKgfy2CAq/Yh22tkigFm698koO
         mMAoFZxYY/mBcRNr6lIqxmYIA0Po3F0jG8at5Ra3VRYBbSP1Kv4QWYrVQtLIm0bvwx1e
         m4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMPZ+VzJ+cGDOwRKaJNQBA78kSsKgAl4Rh0tiwYlTzE=;
        b=J8VlbpFuAgQpqLDnTq7Ve+cLk+83A1ccvbIIIOZN5ONP2R9mN6WXiGHJFWR13QgKVs
         ytGwNjhh4ihH4AjEW8+2N9nbL7Eftc6uH19TVg7bl8z4JQB+a6fU4UDz3q5L2WOZbdJG
         DOinCkkpPdXn07cm4p2970raaQvZ208OVMqFKGJspj4WNgAe61QyEo8aH9Jt9LbYybr1
         u5spc8RDwCRbvL6mp2mcOJxnVg1K9KZPk/8HjaVmiszbTqAUM8YHKSibbnVHiRLyvPsX
         73IueBcYTaaDZz7FsXYkvSXWwwYEBV3JJoJ7Nz+ASPM7W6gzZs6oMxm/R+o4lWIVwZZi
         xEZA==
X-Gm-Message-State: AOAM5323Py3v9oN9JpXuTcMeWMT/kEvY/8bGZqaBuYAvC9eUMHXWQ6nP
        p/u7SYAejaXggskb42Edu9hgujIS5pMRhrdfx7QvFA==
X-Google-Smtp-Source: ABdhPJyoPsL8Lmtmn7sZD3Htvbk1/voqEAiS4Xrou0lgQ0ny/1SONHlnFGvvgkm/zl3krXuPxJMxMt2fP0vpplN7tBI=
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr760920wmj.112.1599754762218;
 Thu, 10 Sep 2020 09:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <20200907134055.2878499-2-elver@google.com>
 <CACT4Y+bfp2ch2KbSMkUd3142aA4p2CiMOmdXrr0-muu6bQ5xXg@mail.gmail.com>
In-Reply-To: <CACT4Y+bfp2ch2KbSMkUd3142aA4p2CiMOmdXrr0-muu6bQ5xXg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 10 Sep 2020 18:19:10 +0200
Message-ID: <CAG_fn=W4es7jaTotDORt2SwspE4A804mdwAY1j4gcaSEKtRjiw@mail.gmail.com>
Subject: Re: [PATCH RFC 01/10] mm: add Kernel Electric-Fence infrastructure
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
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

On Thu, Sep 10, 2020 at 5:43 PM Dmitry Vyukov <dvyukov@google.com> wrote:


> > +       /* Calculate address for this allocation. */
> > +       if (right)
> > +               meta->addr += PAGE_SIZE - size;
> > +       meta->addr = ALIGN_DOWN(meta->addr, cache->align);
>
> I would move this ALIGN_DOWN under the (right) if.
> Do I understand it correctly that it will work, but we expect it to do
> nothing for !right? If cache align is >PAGE_SIZE, nothing good will
> happen anyway, right?
> The previous 2 lines look like part of the same calculation -- "figure
> out the addr for the right case".

Yes, makes sense.

> > +
> > +       schedule_delayed_work(&kfence_timer, 0);
> > +       WRITE_ONCE(kfence_enabled, true);
>
> Can toggle_allocation_gate run before we set kfence_enabled? If yes,
> it can break. If not, it's still somewhat confusing.

Correct, it should go after we enable KFENCE. We'll fix that in v2.

> > +void __kfence_free(void *addr)
> > +{
> > +       struct kfence_metadata *meta = addr_to_metadata((unsigned long)addr);
> > +
> > +       if (unlikely(meta->cache->flags & SLAB_TYPESAFE_BY_RCU))
>
> This may deserve a comment as to why we apply rcu on object level
> whereas SLAB_TYPESAFE_BY_RCU means slab level only.

Sorry, what do you mean by "slab level"?
SLAB_TYPESAFE_BY_RCU means we have to wait for possible RCU accesses
in flight before freeing objects from that slab - that's basically
what we are doing here below:

> > +               call_rcu(&meta->rcu_head, rcu_guarded_free);
> > +       else
> > +               kfence_guarded_free(addr, meta);
> > +}


> > +void kfence_print_object(struct seq_file *seq, const struct kfence_metadata *meta)
> > +{
> > +       const int size = abs(meta->size);
>
> This negative encoding is somewhat confusing. We do lots of abs, but
> do we even look at the sign anywhere? I can't find any use that is not
> abs.

I think initially there was a reason for this, but now we don't seem
to use it anywhere. Nice catch!

Alex
