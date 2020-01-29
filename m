Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741C1C33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFAD206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMNe8mc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgA2P35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:29:57 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45840 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgA2P34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 10:29:56 -0500
Received: by mail-oi1-f194.google.com with SMTP id v19so31470oic.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 07:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/uFh0yYZSP8uHetzeu1eWpPtJLcY84cq4Xfc1+OZCk=;
        b=HMNe8mc+qibEUT1dVO1JKR7scvnDZRi9i082jp3Jh+8JuOTDFbDJbcuIxT3NLnHkOr
         gZvvpP1mUXUH1MM22O9LmWpDwOgR7ClnYCjSIKzgnavSWJpB+aT2NkU7TXdk/vGH6WQ4
         ROkgns658Uwx4LhGXVznFakZ/8BC7KvR1i8qsNlSqhogJ2wuU8z0dy/oizaoSYRekxyS
         +CKudWFS1Cx1rLEWTV0uJEcTi/gr7QslU4KFQf4op+g8Mn/fHQuVHNHaUPfEUgwtp/di
         cljuRyJVRW5vVeVXaMBnOpLsMc09NVhSaN5hQfc8Vh6idnBNBHHv0Vp3nfklt0l2hYTg
         eNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/uFh0yYZSP8uHetzeu1eWpPtJLcY84cq4Xfc1+OZCk=;
        b=Wtd7djUFBhRw+dih3xXOKDJ7N3Z/NJfT/MzX3+BfTAdLMVxpL9bolGsDfB4uk90E/S
         V0MbdL4bK17Yo6ciIC5GqmU4RbsLcshwAYUQoNeeB/aPyC401Z5T5zYw53aiQ86c1dvP
         T92lHRQlBRMXM3NAOcApY+svPBoJ8K7gqt3iLIK0rC2F/NLI934huYa/9jOoDbchvPfx
         QOqmp/Uy68XLSTr/BgLkz0iU94cWhHDkuTeJY4N9hiq7/o0YPYOkzzShuoiCNrPRmR9j
         QyXxO3ECbufZZB4oQlWTMojtWbkrZAjjRDb7w43MqxVfyiMzrS8SVBJIlb43jNH4d9Xb
         5IJA==
X-Gm-Message-State: APjAAAXhMtN/tXI4/bd5ARHppMshSrOm22yYRcWoGaHjyl2gCVhQH5gE
        Y3E4Qjpn50a311RSsDMC3qDfbgUWdU/dZdLospg0gw==
X-Google-Smtp-Source: APXvYqxNnQQT3lS4wScoERhD8IHrcaxbj+m+JlpQ2dDP8SiPsnpY6u3QcwqrbiYsZ9qlZW94Fu54FBcJcYsgqQq2m2U=
X-Received: by 2002:aca:36c1:: with SMTP id d184mr6743720oia.70.1580311795512;
 Wed, 29 Jan 2020 07:29:55 -0800 (PST)
MIME-Version: 1.0
References: <20200122165938.GA16974@willie-the-truck> <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
 <20200122223851.GA45602@google.com> <A90E2B85-77CB-4743-AEC3-90D7836C4D47@lca.pw>
 <20200123093905.GU14914@hirez.programming.kicks-ass.net> <E722E6E0-26CB-440F-98D7-D182B57D1F43@lca.pw>
 <CANpmjNNo6yW-y-Af7JgvWi3t==+=02hE4-pFU4OiH8yvbT3Byg@mail.gmail.com>
 <20200128165655.GM14914@hirez.programming.kicks-ass.net> <20200129002253.GT2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200129002253.GT2935@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Wed, 29 Jan 2020 16:29:43 +0100
Message-ID: <CANpmjNN8J1oWtLPHTgCwbbtTuU_Js-8HD=cozW5cYkm8h-GTBg@mail.gmail.com>
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 at 01:22, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Jan 28, 2020 at 05:56:55PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 28, 2020 at 12:46:26PM +0100, Marco Elver wrote:
> >
> > > > Marco, any thought on improving KCSAN for this to reduce the false
> > > > positives?
> > >
> > > Define 'false positive'.
> >
> > I'll use it where the code as written is correct while the tool
> > complains about it.
>
> I could be wrong, but I would guess that Marco is looking for something
> a little less subjective and a little more specific.  ;-)
>
> > > From what I can tell, all 'false positives' that have come up are data
> > > races where the consequences on the behaviour of the code is
> > > inconsequential. In other words, all of them would require
> > > understanding of the intended logic of the code, and understanding if
> > > the worst possible outcome of a data race changes the behaviour of the
> > > code in such a way that we may end up with an erroneously behaving
> > > system.
> > >
> > > As I have said before, KCSAN (or any data race detector) by definition
> > > only works at the language level. Any semantic analysis, beyond simple
> > > rules (such as ignore same-value stores) and annotations, is simply
> > > impossible since the tool can't know about the logic that the
> > > programmer intended.
> > >
> > > That being said, if there are simple rules (like ignore same-value
> > > stores) or other minimal annotations that can help reduce such 'false
> > > positives', more than happy to add them.
> >
> > OK, so KCSAN knows about same-value-stores? If so, that ->cpu =
> > smp_processor_id() case really doesn't need annotation, right?
>
> If smp_processor_id() returns the value already stored in ->cpu,
> I believe that the default KCSAN setup refrains from complaining.

Yes it won't report this with KCSAN_REPORT_VALUE_CHANGE_ONLY.  (There
was one case I missed, and just sent a patch to fix.)

> Which reminds me, I need to disable this in my RCU runs.  If I create a
> bug that causes me to unknowingly access something that is supposed to
> be CPU-private from the wrong CPU, I want to know about it.
>
> > > What to do about osq_lock here? If people agree that no further
> > > annotations are wanted, and the reasoning above concludes there are no
> > > bugs, we can blacklist the file. That would, however, miss new data
> > > races in future.
> >
> > I'm still hoping to convince you that the other case is one of those
> > 'simple-rules' too :-)
>
> On this I must defer to Marco.

On Tue, 28 Jan 2020 at 17:52, Peter Zijlstra <peterz@infradead.org> wrote:
> I'm claiming that in the first case, the only thing that's ever done
> with a racy load is comparing against 0, there is no possible bad
> outcome ever. While obviously if you let the load escape, or do anything
> other than compare against 0, there is.

It might sound like a simple rule, but implementing this is anything
but simple: This would require changing the compiler, which we said
we'd like to avoid as it introduces new problems. This particular rule
relies on semantic analysis that is beyond what the TSAN
instrumentation currently supports. Right now we support GCC and
Clang; changing the compiler probably means we'd end up with only one
(probably Clang), and many more years before the change has propagated
to the majority of used compiler versions. It'd be good if we can do
this purely as a change in the kernel's codebase.

Keeping the bigger picture in mind, how frequent is this case, and
what are we really trying to accomplish? Is it only to avoid a
READ_ONCE? Why is the READ_ONCE bad here? If there is a racing access,
why not be explicit about it?

I can see that maybe this particular file probably doesn't need more
hints that there is concurrency here (given its osq_lock), but as a
general rule for the remainder of the kernel it appears to add more
inconsistencies.

Thanks,
-- Marco
