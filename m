Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D3BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 024B82075B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E03wrYq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgFDJwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgFDJwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:52:33 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D44C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 02:52:33 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id z145so1112506ooa.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 02:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmgCAZztkKponFlSOj9eb5gBCC+mYH067uJY2h6tIxo=;
        b=E03wrYq2qk/9Su1JbFTFYDDuOW7iHKPMLOx8+W7pS1jZqglh47WBhkKee9QC2VSjEM
         tvIE+XYqvmo7ESzqR6LVCkHmsd7lNeDiAhYoceTkkuEcgiMKR/9EjPSBxfE1TEpFmiEh
         bzoaOdFGTAK8+KqrMBwRAIGnAfvFPWkb7OjHd9duKelNwV3gJylT3glftJR/PklCsgWu
         SACOQ0ZBL47eO0ziL5uk4GtCoozRHtEI5bApsN6wDR6QK3SR2znFluHgB4UIOVCbbOKV
         vqHVa12JrWiQ/Nv5jd740PBsu3jMVVDZgShkBmSuN/vh30Na+kBpDrHHAI+8TVj3nxax
         gdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmgCAZztkKponFlSOj9eb5gBCC+mYH067uJY2h6tIxo=;
        b=oKv1WxfWAS9qCx8M2JInpWcV9MyOepPn07f5GFXi8chqvcOiLcQeNUB1YU5aLKdqE8
         aNxprCJPU5uj2N2YzCshFi0Hqv4p1cl5PzRlJSG6MR9fqaXHb3NPpIMOrqPLOCuCtyro
         hK2p0C2O0tPxSLmOjNI9kbE18vDjoLV3+bmu4ICkOOD0bZlS/3KPVf15ifZwqNHtJ6Hj
         wpaC05+/8JC/qtG1Qe+gLoKXWnzZoaJ5s4c+bvBdkL2kjCeCyC+LmT12axBILmRxGMAu
         ygoNKQrAZHt2w6vLCT6gK1RIycO4d8g5RmQpYJcsKz4BRrQnyWxr6Ul/3CRQxL5we37W
         yEeA==
X-Gm-Message-State: AOAM530tx3GSCHLrkhlNvv8zcknOch4h5yHfIRpvQQ9egfOKf1cOJdUq
        tAvg0mCZxGe+n7Ab8ZJoP30h6cDdTkmjXMM9PJdnQg==
X-Google-Smtp-Source: ABdhPJx8nxv/Fp5E/Hl1veAJDLXsZdjg22RW8vJHLljIuWAQjL8St9prG4WmEpx9rR9YO0eGNraD3hSeLtKzQnHTHb4=
X-Received: by 2002:a4a:b54b:: with SMTP id s11mr3156030ooo.14.1591264352701;
 Thu, 04 Jun 2020 02:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200603114014.152292216@infradead.org> <20200603120037.GA2570@hirez.programming.kicks-ass.net>
 <20200603120818.GC2627@hirez.programming.kicks-ass.net> <CANpmjNOxLkqh=qpHQjUC_bZ0GCjkoJ4NxF3UuNGKhJSvcjavaA@mail.gmail.com>
 <20200603121815.GC2570@hirez.programming.kicks-ass.net> <CANpmjNPxMo0sNmkbMHmVYn=WJJwtmYR03ZtFDyPhmiMuR1ug=w@mail.gmail.com>
 <CANpmjNPzmynV2X+e76roUmt_3oq8KDDKyLLsgn__qtAb8i0aXQ@mail.gmail.com>
 <20200603160722.GD2570@hirez.programming.kicks-ass.net> <20200603181638.GD2627@hirez.programming.kicks-ass.net>
 <CANpmjNPJ_vTyTYyrXxP2ei0caLo10niDo8PapdJj2s4-w_R3TA@mail.gmail.com> <CANpmjNMyC+KHTbLFSxojV_CTK60t3ayJHxtyH4AckeMD2hGCtg@mail.gmail.com>
In-Reply-To: <CANpmjNMyC+KHTbLFSxojV_CTK60t3ayJHxtyH4AckeMD2hGCtg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 4 Jun 2020 11:52:18 +0200
Message-ID: <CANpmjNM48j4D7F+cgUrrof38d3nLuQjbW6pz3nTwxcZ5Q+GJqQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] x86/entry fixes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 at 08:00, Marco Elver <elver@google.com> wrote:
>
> On Wed, 3 Jun 2020 at 21:10, Marco Elver <elver@google.com> wrote:
> >
> > On Wed, 3 Jun 2020 at 20:16, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Jun 03, 2020 at 06:07:22PM +0200, Peter Zijlstra wrote:
> > > > On Wed, Jun 03, 2020 at 04:47:54PM +0200, Marco Elver wrote:
> > >
> > > > > With that in mind, you could whitelist "__ubsan_handle"-prefixed
> > > > > functions in objtool. Given the __always_inline+noinstr+__ubsan_handle
> > > > > case is quite rare, it might be reasonable.
> > > >
> > > > Yes, I think so. Let me go have dinner and then I'll try and do a patch
> > > > to that effect.
> > >
> > > Here's a slightly more radical patch, it unconditionally allows UBSAN.
> > >
> > > I've not actually boot tested this.. yet.
> > >
> > > ---
> > > Subject: x86/entry, ubsan, objtool: Whitelist __ubsan_handle_*()
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > Date: Wed Jun  3 20:09:06 CEST 2020
> > >
> > > The UBSAN instrumentation only inserts external CALLs when things go
> > > 'BAD', much like WARN(). So treat them similar to WARN()s for noinstr,
> > > that is: allow them, at the risk of taking the machine down, to get
> > > their message out.
> > >
> > > Suggested-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >
> > This is much cleaner, as it gets us UBSAN coverage back. Seems to work
> > fine for me (only lightly tested), so
> >
> > Acked-by: Marco Elver <elver@google.com>
> >
> > Thanks!
>
> I was thinking that if we remove __no_sanitize_undefined from noinstr,
> we can lift the hard compiler restriction for UBSAN because
> __no_sanitize_undefined isn't used anywhere. Turns out, that attribute
> isn't broken on GCC <= 7, so I've sent v2 of my series:
> https://lkml.kernel.org/r/20200604055811.247298-1-elver@google.com

Now that hopefully KASAN/KCSAN/UBSAN are fine, I'm looking at adding a
patch for KCOV:
https://lkml.kernel.org/r/20200604095057.259452-1-elver@google.com

Will that work?

Thanks,
-- Marco
