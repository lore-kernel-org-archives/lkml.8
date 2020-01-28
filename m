Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5913C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5102467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kDwUCNrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgA1ISv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:18:51 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33132 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgA1ISv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:18:51 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so11227465otp.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 00:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4GlTMy4Y3SA0CBLCaMbQ0jYDnrNseGrKS93a9KZAwb8=;
        b=kDwUCNrgRn/3C3bVB1kRgtG3n1ky4uQEXolzTBOduE7+eKFSIiCQkfy2Xk9MMjTU6t
         wEDt6leL/UQlPwoIF8PTTAPFyM4adqgKKPcAnie/KcxW5xumW9JDG2F08fUV+cEeFoPw
         dqy4fVcsBrWwHcnbOW0hBkFWBpn/9NzX6M6//cvd090dprM5stdXYf4dGwsmW1alw7oK
         ZqM+rsXKrUDanW6RLofYLIMqEERwj4xJJMsJWHhyjsf6OqDlTHEwNag6qpORIYJiUJhv
         6arZ3U3OLhqh82NANalaMASeIzpNjxdPIfCxcSME+ic3GbZAHIIdKlk6/53yUXmuymIC
         IFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GlTMy4Y3SA0CBLCaMbQ0jYDnrNseGrKS93a9KZAwb8=;
        b=Gx0pRTQQlx9dEo8CDjYeeMSTyUFhGlKiSkW0/+6z4Ttp6LwOG1D5ken0VDEslp4xRf
         ZcjBcgeHx0PYwQxH7wvl71g7bZGa7RKLQuOXzhXdBywiVB+qnQ+BQghQbVFOz6XeXNOa
         QkzLYzhsY9w70K/+gjLTwS5GiwU5NzY3nBixcROpwoIt2GJx4QFskoe1g/EdGz2mvg0t
         UMbOJSLl6Ph5tcXa8WAzG8VLhgRG86V9sPBiWe1BbBgjSHIxN63J3Q9R1joSURk8IWvU
         //jvDuqdlQILiP98LCkZS2Kdw+Eg+Fm155QRE6V76o5a/OPpn28qzi9AekVxU2IpXG9C
         zHJg==
X-Gm-Message-State: APjAAAVrTDcoQGNnFFran4onFjTFOrU+FeG7RR3VAAeN5fX2ymzQIpH4
        dAMCElRnpSA5cR22Lv0xebbWmnH1hVv+P5GFYiW9mSltalM=
X-Google-Smtp-Source: APXvYqwRzU+qocaYPUl1YFvQFwiW71hV/tDUZwdiLaexhyOtjv3KsK0M7N+2MHqVGQDL2F1WJzRGdWj1RWQLD7czCRc=
X-Received: by 2002:a05:6830:1d7b:: with SMTP id l27mr14494358oti.251.1580199529855;
 Tue, 28 Jan 2020 00:18:49 -0800 (PST)
MIME-Version: 1.0
References: <20200122165938.GA16974@willie-the-truck> <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
 <20200122223851.GA45602@google.com> <20200123093604.GT14914@hirez.programming.kicks-ass.net>
 <2E13BFD2-A2E5-4CAA-B0D0-0DF2F5529F1B@lca.pw>
In-Reply-To: <2E13BFD2-A2E5-4CAA-B0D0-0DF2F5529F1B@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Jan 2020 09:18:38 +0100
Message-ID: <CANpmjNMzvcrQWpGWVgNRxvZroecAEZYYa2yYAtm5+ekcK=H3OQ@mail.gmail.com>
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020 at 04:13, Qian Cai <cai@lca.pw> wrote:
>
> > On Jan 23, 2020, at 4:36 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Jan 22, 2020 at 11:38:51PM +0100, Marco Elver wrote:
> >
> >> If possible, decode and get the line numbers. I have observed a data
> >> race in osq_lock before, however, this is the only one I have recently
> >> seen in osq_lock:
> >>
> >> read to 0xffff88812c12d3d4 of 4 bytes by task 23304 on cpu 0:
> >>  osq_lock+0x170/0x2f0 kernel/locking/osq_lock.c:143
> >>
> >>      while (!READ_ONCE(node->locked)) {
> >>              /*
> >>               * If we need to reschedule bail... so we can block.
> >>               * Use vcpu_is_preempted() to avoid waiting for a preempted
> >>               * lock holder:
> >>               */
> >> -->          if (need_resched() || vcpu_is_preempted(node_cpu(node->prev)))
> >>                      goto unqueue;
> >>
> >>              cpu_relax();
> >>      }
> >>
> >> where
> >>
> >>      static inline int node_cpu(struct optimistic_spin_node *node)
> >>      {
> >> -->          return node->cpu - 1;
> >>      }
> >>
> >>
> >> write to 0xffff88812c12d3d4 of 4 bytes by task 23334 on cpu 1:
> >> osq_lock+0x89/0x2f0 kernel/locking/osq_lock.c:99
> >>
> >>      bool osq_lock(struct optimistic_spin_queue *lock)
> >>      {
> >>              struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
> >>              struct optimistic_spin_node *prev, *next;
> >>              int curr = encode_cpu(smp_processor_id());
> >>              int old;
> >>
> >>              node->locked = 0;
> >>              node->next = NULL;
> >> -->          node->cpu = curr;
> >>
> >
> > Yeah, that's impossible. This store happens before the node is
> > published, so no matter how the load in node_cpu() is shattered, it must
> > observe the right value.
>
> Marco, any thought on how to do something about this? The worry is that
> too many false positives like this will render the tool usefulness as a
> general debug option.

This should be an instance of same-value-store, since the node->cpu is
per-CPU and smp_processor_id() should always be the same, at least
once it's published. I believe the data race I observed here before
KCSAN had KCSAN_REPORT_VALUE_CHANGE_ONLY on syzbot, and hasn't been
observed since. For the most part, that should deal with this case.

I will reply separately to your other email about the other data race.

Thanks,
-- Marco
