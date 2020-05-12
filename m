Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C97C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B98206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bdcdmC5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgELPkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgELPkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:40:12 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FE0C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:40:12 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t12so12688327ile.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buiAof6WRKtSirNKD9RFN2K0N5fvI2kki67MYnTnqYI=;
        b=bdcdmC5fOGsdyRNMoB3awGe4XvO1oZFII9PVWfAT6Hnk0pNlsC3+S692t3NtLhOwJ2
         yRhzmVxElawpNsCp5SGd1/uA3ZEk+PVjHAeGZiXtTdSR1GohZMgwGOIrmiv01/IqXXq1
         et9Aui/SmQpquIkSabOibWCiW3txo14BNVKVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buiAof6WRKtSirNKD9RFN2K0N5fvI2kki67MYnTnqYI=;
        b=QEzxv0yyx57oYvENnVqe1PTVjtLVT7mD5EY2IFE4XygtKIAV4APIxGfMnj0UhRxGqW
         5XPDo1kZ1M9KV5JUSI8mOTbjXxwZI4Ahvh0KIQ1eKRplV9Ke9HwR2l+r88+uAAzxjvSB
         ZQyMHIUmSz41c49GlYyOKZMoQkqRpxvTZ8eLIPFl+gYvI5s09ZVu0K1SO6AxL5CI0/3B
         6icq+Nl5gZ2KT9iTqCNRGDCCGxJF3t6blb1/J/qdystJ+k4GIOmlpscvSBjeMbAMu6tJ
         6QfUYNCWD/MGIP/24r8vZ5riTQWhW0G+JcCO3sW+RjpthyI6axg9rylRaL2TJ58ca8Vx
         gRWw==
X-Gm-Message-State: AGi0PubyPe/J+S7Qaq+NDsOBqeOD4a67dg7jy1riDlIrJLdol7sVTbWq
        vJYT5v46pT0D4eQqhgJDXzSzxTD6Okn1hwjOeXNC8w==
X-Google-Smtp-Source: APiQypLoZjH2P99WvEMIV/Uaeurvj/6ZcrBQNQMjT0h7BcV7EXSLMSDq8qRylrHB/xNv0pEq95jnAK51Ebf7TqyFQlQ=
X-Received: by 2002:a92:bad5:: with SMTP id t82mr22740692ill.171.1589298011260;
 Tue, 12 May 2020 08:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com> <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <20200511173348.GX2869@paulmck-ThinkPad-P72> <20200512021309.GA197229@google.com>
 <bff04d71-1666-a5a8-54bf-d0c9f8737b47@gmail.com> <20200512121936.GA228684@google.com>
 <20200512141944.GC2869@paulmck-ThinkPad-P72> <2ad1db9a-cd47-51a0-4bbf-5e6b64b73cbd@gmail.com>
In-Reply-To: <2ad1db9a-cd47-51a0-4bbf-5e6b64b73cbd@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 12 May 2020 11:40:00 -0400
Message-ID: <CAEXW_YR9xu7s0jvbu-vGpi_TtJ_NMWHHNArTNVwcu98WS1t-PA@mail.gmail.com>
Subject: Re: [PATCH 0/3] tools/memory-model, Documentation/litmus-test: Sort
 out location of litmus test and README
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:39 AM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> On Tue, 12 May 2020 07:19:44 -0700, Paul E. McKenney wrote:
> > On Tue, May 12, 2020 at 08:19:36AM -0400, Joel Fernandes wrote:
> >> On Tue, May 12, 2020 at 08:50:45PM +0900, Akira Yokosawa wrote:
> >> [...]
> >>>> I think on top of this patch, I'd like to add a reference to the to the
> >>>> litmus test in tools/memory-model/ from Documentation/rcu/.
> >>>
> >>> Sounds reasonable to me. But for most people, it never changes its location.
> >>> Please find inline comments below.
> >>>
> >>>>
> >>>> Just to mention my rationale for Documentation/litmus-tests/rcu/, I was
> >>>> basically looking for a central place for RCU related litmus tests in the
> >>>> kernel sources and the idea of this new directory came up.
> >>>>
> >>>> For Akira's series,
> >>>> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>>
> >>> Thank you!
> >>>
> >>>>
> >>>> And could we add the following patch on top of Akira's series so we still
> >>>> maintain a reference to the moved RCU test?>
> >>>> ---8<-----------------------
> >>>>
> >>>> From 52fdb57551cc769d8bd690f4f2b22de36ddece99 Mon Sep 17 00:00:00 2001
> >>>> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> >>>> Date: Mon, 11 May 2020 22:06:46 -0400
> >>>> Subject: [PATCH] docs: litmus-tests: Clarify about the RCU pre-initialization
> >>>>  test
> >>>>
> >>>> Since this test was moved to tools/memory-model/, make sure that it is
> >>>> at least referenced from Documentation/litmus-tests/'s README.
> >>>>
> >>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>>> ---
> >>>>  Documentation/litmus-tests/README | 6 ++++--
> >>>>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
> >>>> index ac0b270b456c1..53f09e74734a4 100644
> >>>> --- a/Documentation/litmus-tests/README
> >>>> +++ b/Documentation/litmus-tests/README
> >>>> @@ -11,7 +11,6 @@ tools/memory-model/README.
> >>>>
> >>>>  atomic (/atomic derectory)
> >>>>  --------------------------
> >>>> -
> >>>>  Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
> >>>>      Test that an atomic RMW followed by a smp_mb__after_atomic() is
> >>>>      stronger than a normal acquire: both the read and write parts of
> >>>> @@ -23,8 +22,11 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> >>>>
> >>>>  RCU (/rcu directory)
> >>>>  --------------------
> >>>> -
> >>>
> >>> I loosely followed the convention of ReST documents in putting these empty
> >>> lines.  But I don't mind if they are removed.
> >>>
> >>>>  RCU+sync+read.litmus
> >>>>  RCU+sync+free.litmus
> >>>>      Both the above litmus tests demonstrate the RCU grace period guarantee
> >>>>      that an RCU read-side critical section can never span a grace period.
> >>>> +
> >>>> +MP+onceassign+derefonce.litmus (moved to tools/memory-model/litmus-tests/)
> >>>
> >>> As I said above, for those who don't follow developments in the lkmm branch,
> >>> MP+onceassign+derefonce.litmus stays in tools/memory-model/litmus-tests/.
> >>> So,
> >>>
> >>> +MP+onceassign+derefonce.litmus (under tools/memory-model/litmus-tests/)
> >>>
> >>> looks better to me.
> >>
> >> Yes it stays under tools/.. but is referenced here. Sounds like you agree and
> >> the only change from my follow-up patch that you want is to change "moved to"
> >> to "under".
> >>
> >> If so, Paul do you mind applying my patch and fixing this up? Or do you want
> >> to apply Akira's 3-patch series first and then have me send you another one
> >> on top?
> >
> > Let's get something that you, Akira, and Alan are good with, then I will
> > apply that, either on top of or in place of the current commits (just
> > tell me which).
>
> OK.
> I'm submitting a patch [4/3] with Alan's suggested-by and Joel's and my
> co-developed-by tags.
> The explanation under tools/memory-model/litmus-tests/README also need the same
> rewording.

Sounds good to me, thanks!!

 - Joel
