Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D32C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371D320738
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4nkmgZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgIGSQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgIGSQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:16:26 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4E2C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 11:16:25 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id g26so402319ooa.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5wKHqfwSX4tMBwD67UcVJ4BSt4O+DvIHtBQvGXOV+4=;
        b=K4nkmgZMU1BL8hol3wBtjK0bL6d36hR7CBWsM+3EgMDiiO0PBpF7JHwRYDUmwUPg4h
         1VP8mrfm0Zlp7D5JlqFqXYERaQenl7jM/yjbcMYdxU9HSL6OAJI0DdvYZZ40BLHDbNjf
         dwy4NZUDXO/663GUjnvP/MfzrQRQYarLEiUC7NP8ih8TL3tQ18xEmCiJ98A+YqBOaM+U
         jYxUtc8GanrjiDuP0syRYpXV+b32IGS4EPIf30MZ5u4647BXbRocBScurypnJuEEwJwt
         9YBgAOWBClGCz7tWtWYjp92GK4+pfzHsuCuY3pqK9m/AFlrXpb/U4wpN/1eNzJoOHmn2
         7TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5wKHqfwSX4tMBwD67UcVJ4BSt4O+DvIHtBQvGXOV+4=;
        b=GRFq4aZL1iMumMNyVRrj95UNCTuhDhLmx4OUIKjr4WpbgCuBS/C2v0DLhjwLjMpZTJ
         b6UlWYHAEDBbyVNhsWPK76kv+7re4xXoloQ03lF/fNU8C1A9C0Eua87LsFC43zZJOL5j
         olG0I4CNnJhrJ7HsUvo3wii9wvY7trTtHx3QuvYmNg3BV4eWym1eX20kIQQD2vvwYjFX
         kBxsSe+3K2qwBN72/+AY/R4xUZL8CNa7QExoOXxb/X3rQkh032YAOsX0xTL/DzRVn9UQ
         3/FxDIsarJTuC5WH4UJznw8qBNuWk00LlbcFavbZlOKUP2BpfGhSAR9Xv06o+pPquDYi
         sITw==
X-Gm-Message-State: AOAM53097I5xZMUqKgZ9fvXjgjhe+bWPeuW3AgtHrlmqM9NM6T7spRRE
        sNZb5FzsjRbOwUgLYaLRseazXCIb8k7qqVvJHoXy8A==
X-Google-Smtp-Source: ABdhPJzAEWw7U1yg3vx4wRYG07d5NYt11k3IChID/WYGphofmGzgUHpslTr9pCxK3O5lHYRzrb3fnqposjMk5wp8nSU=
X-Received: by 2002:a4a:4fd0:: with SMTP id c199mr15788309oob.54.1599502584851;
 Mon, 07 Sep 2020 11:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <20200907134055.2878499-10-elver@google.com>
 <CAAeHK+zGpJd6szPounYz6wogO9TMT18TmQu_mfXUWQd65QTf0w@mail.gmail.com>
 <CANpmjNM14iW8vDuLANrCGBds930r2bZ=gwkoqORpuLa5-8gW6g@mail.gmail.com> <CAAeHK+w35Aqt8csAvBHg5rcKHm4cL0rPCM4VupfyG-58eMK-UQ@mail.gmail.com>
In-Reply-To: <CAAeHK+w35Aqt8csAvBHg5rcKHm4cL0rPCM4VupfyG-58eMK-UQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Sep 2020 20:16:13 +0200
Message-ID: <CANpmjNP9DPMdKqYGT-1gpc8Vhca3LoB2s+fbiL_2LvcSdozRTw@mail.gmail.com>
Subject: Re: [PATCH RFC 09/10] kfence, Documentation: add KFENCE documentation
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Sep 2020 at 19:55, Andrey Konovalov <andreyknvl@google.com> wrote:
> On Mon, Sep 7, 2020 at 6:33 PM Marco Elver <elver@google.com> wrote:
[...]
> > > > +Guarded allocations are set up based on the sample interval. After expiration
> > > > +of the sample interval, a guarded allocation from the KFENCE object pool is
> > > > +returned to the main allocator (SLAB or SLUB).
> > >
> > > Only for freed allocations, right?
> >
> > Which "freed allocation"? What this paragraph says is that after the
> > sample interval elapsed, we'll return a KFENCE allocation on kmalloc.
> > It doesn't yet talk about freeing.
>
> It says that an allocation is returned to the main allocator, and this
> is what is usually described with the word "freed". Do you mean
> something else here?

Ah, I see what's goin on. So the "returned to the main allocator" is
ambiguous here. I meant to say "returned" as in kfence gives sl[au]b a
kfence object to return for the next kmalloc. I'll reword this as it
seems the phrase is overloaded in this context already.

[...]
> > > > +Upon deallocation of a KFENCE object, the object's page is again protected and
> > > > +the object is marked as freed. Any further access to the object causes a fault
> > > > +and KFENCE reports a use-after-free access. Freed objects are inserted at the
> > > > +tail of KFENCE's freelist, so that the least recently freed objects are reused
> > > > +first, and the chances of detecting use-after-frees of recently freed objects
> > > > +is increased.
> > >
> > > Seems really similar to KASAN's quarantine? Is the implementation much
> > > different?
> >
> > It's a list, and we just insert at the tail. Why does it matter?
>
> If the implementation is similar, we can then reuse quarantine. But I
> guess it's not.

The concept is similar, but the implementations are very different.
Both use a list (although KASAN quarantine seems to reimplement its
own singly-linked list). We just rely on a standard doubly-linked
list, without any of the delayed freeing logic of the KASAN quarantine
as KFENCE objects just change state to "freed" until they're reused
(freed kfence objects are just inserted at the tail, and the next
object to be used for an allocation is at the head).

Thanks,
-- Marco
