Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F12C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71AB214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZttBa79g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgA1Lqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 06:46:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33548 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgA1Lqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:46:39 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so11709884otp.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 03:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1m2tU4RYYXkdt6z78fcFtsSj6N8xIeX/v5Mckd3HuOk=;
        b=ZttBa79gzBgDbPkfBP8sPfD3BF/YLjtcdJXxEzmIHNFa8Wh+qbLdybQfy2wxyv9REZ
         T7zNoMa8hcPdXW/VJYqpZ0d0ot9PIg4Khkl3MS0y5FHewWqmfvJ6zDT6cGLe+IBpRdsb
         SeEmBHvk2/y0emlzZaZmvdmXK+iEDHBFjIiZnp0RNn3Yoh6ZBKQIbhM8ACNI2djVuDm1
         RvUsUhQyH8G5EQ2P9hkeq8+purJGvlDSuRDtZqMPZA+gbR51rEOMvk94+ka/lITSVHPR
         lFkEZ2aSolxL7jgRBQhOF/Qi2Wk8sGGX8JIOFVr8OHXAggzc3ifG8TJaoDR0C30xyVPO
         e5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1m2tU4RYYXkdt6z78fcFtsSj6N8xIeX/v5Mckd3HuOk=;
        b=kZ1zi7njO3tWudqAv8AazLulbJN0g3h4QOskrj5gKmAkZwwxtGr/93J/8O9DUHFwoC
         Dc2tod7L3c7DIFIGEofO6AQd7IAH5j0SaLvsA97UqhHy5trcgIBpgs9f12eEUG4WFCRp
         dhLS8Vycu5ZfobYtcW9kgupVE5deiwjNkrwpQQa3nGkwUepECIa1FRgA2qfY0EmyZe/g
         b8Fhul9Tu7jQ6sSRvluyL/s/2jPG9/uRSXnMWDgO1hkMK0hzX9nILg95EM6gsi1hMZxu
         uiBPHpSjJKfVNHd+QGsjRkvFhYUzeVsVAz+Q30e3GztwNU1lL9Z2L89JHpM2EK7v1Njo
         8zSQ==
X-Gm-Message-State: APjAAAVf9shJp6kgEP5jKIP+3cUzWSQtb598UgwEv6j58ncVhFbfQlyX
        hYaoXS++HYHRbJMGtoVhK1uCxrMcbMoLwyc0U5W3ag==
X-Google-Smtp-Source: APXvYqxOEXCf2VKOm8lc1lfUFjyefZVbf3PuAE3Myn0xbv/LYIZp5H2xnMKr9uSVMo1zbgqkLUZ2zOND8+m8OwWqXi8=
X-Received: by 2002:a05:6830:1d7b:: with SMTP id l27mr14982490oti.251.1580211998038;
 Tue, 28 Jan 2020 03:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20200122165938.GA16974@willie-the-truck> <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
 <20200122223851.GA45602@google.com> <A90E2B85-77CB-4743-AEC3-90D7836C4D47@lca.pw>
 <20200123093905.GU14914@hirez.programming.kicks-ass.net> <E722E6E0-26CB-440F-98D7-D182B57D1F43@lca.pw>
In-Reply-To: <E722E6E0-26CB-440F-98D7-D182B57D1F43@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Jan 2020 12:46:26 +0100
Message-ID: <CANpmjNNo6yW-y-Af7JgvWi3t==+=02hE4-pFU4OiH8yvbT3Byg@mail.gmail.com>
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020 at 04:11, Qian Cai <cai@lca.pw> wrote:
>
> > On Jan 23, 2020, at 4:39 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jan 22, 2020 at 06:54:43PM -0500, Qian Cai wrote:
> >> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> >> index 1f7734949ac8..832e87966dcf 100644
> >> --- a/kernel/locking/osq_lock.c
> >> +++ b/kernel/locking/osq_lock.c
> >> @@ -75,7 +75,7 @@ osq_wait_next(struct optimistic_spin_queue *lock,
> >>                 * wait for either @lock to point to us, through its Step-B, or
> >>                 * wait for a new @node->next from its Step-C.
> >>                 */
> >> -               if (node->next) {
> >> +               if (READ_ONCE(node->next)) {
> >>                        next = xchg(&node->next, NULL);
> >>                        if (next)
> >>                                break;
> >
> > This could possibly trigger the warning, but is a false positive. The
> > above doesn't fix anything in that even if that load is shattered the
> > code will function correctly -- it checks for any !0 value, any byte
> > composite that is !0 is sufficient.
> >
> > This is in fact something KCSAN compiler infrastructure could deduce.

Not in the general case. As far as I can tell, this if-statement is
purely optional and an optimization to avoid false sharing. This is
specific knowledge about the logic that (without conveying more
details about the logic) the tool couldn't safely deduce. Consider the
case:

T0:
if ( (x = READ_ONCE(ptr)) ) use_ptr_value(*x);

T1:
WRITE_ONCE(ptr, valid_ptr);

Here, unlike the case above, reading ptr without READ_ONCE can clearly
be dangerous.

The false sharing scenario came up before, and maybe it's worth
telling the tool about the logic. In fact, the 'data_race()' macro is
perfectly well suited to do this.

>
> Marco, any thought on improving KCSAN for this to reduce the false
> positives?

Define 'false positive'.

From what I can tell, all 'false positives' that have come up are data
races where the consequences on the behaviour of the code is
inconsequential. In other words, all of them would require
understanding of the intended logic of the code, and understanding if
the worst possible outcome of a data race changes the behaviour of the
code in such a way that we may end up with an erroneously behaving
system.

As I have said before, KCSAN (or any data race detector) by definition
only works at the language level. Any semantic analysis, beyond simple
rules (such as ignore same-value stores) and annotations, is simply
impossible since the tool can't know about the logic that the
programmer intended.

That being said, if there are simple rules (like ignore same-value
stores) or other minimal annotations that can help reduce such 'false
positives', more than happy to add them.

Qian: firstly I suggest you try
CONFIG_KCSAN_REPORT_ONCE_IN_MS=1000000000 as mentioned before so your
system doesn't get spammed, considering you do not use the default
config but want to use all debugging tools at once which seems to
trigger certain data races more than usual.

Secondly, what are your expectations? If you expect the situation to
be perfect tomorrow, you'll be disappointed. This is inherent, given
the problem we face (safe concurrency). Consider the various parts to
this story: concurrent kernel code, the LKMM, people's preferences and
opinions, and KCSAN (which is late to the party). All of them are
still evolving, hopefully together. At least that's my expectation.

What to do about osq_lock here? If people agree that no further
annotations are wanted, and the reasoning above concludes there are no
bugs, we can blacklist the file. That would, however, miss new data
races in future.

Thanks,
-- Marco
