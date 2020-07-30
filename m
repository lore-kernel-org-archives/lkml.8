Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B25C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F2820829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WS/N+oLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgG3UvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgG3UvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 16:51:23 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D6AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:51:22 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d24so12030190qtg.23
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+8IcRcjNMmg55nzAYWemaonCO3YVJFMOAlMg6/HQqZk=;
        b=WS/N+oLbFzSBBDpGrj5zhi5qc3eMKgQfUSbLNA4X6vw0fslhwV92R948HcCKCQBs4B
         3cAPHFnBjNf1GJzmYzjIdxVcT88aOw/+5Z7wY4hDcfZ5yh6wC2nAOs69NEGLdm4IKtNI
         RHkMh6NAvOxXxk7mDuS8rcqW39ze8lB0GIa6RhJc9qU7vK9N2Btacj0v68dmU6Dug9LP
         jP/tT7rYjKVlIhvetloVr2f4TprDQRLJSmx4UsvYZgDVA5qVyPFnBDK3Fkb88waPgT74
         NFiy+CaVbmI50DH86lrxVdWJKfOc9vsv3Lpzq90+nz4g64FuSpFl766z+JkRzk2031lz
         HZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+8IcRcjNMmg55nzAYWemaonCO3YVJFMOAlMg6/HQqZk=;
        b=tMrfeM9D93+MvBUe/BFAeddDkBtqEffFGBWBwzaK09xH+ht9BFyg88KO4PFZE3aOjb
         5MXQWcOyrcFqj1i/bEAZU9XepZ2u7u6ZClYJhP0SDXiA4LO+SIWzdjZ5JRd+OXhLuE22
         hHYt2/ib4AJ6QWNRyMrVmN2KtG3zdiz4SPu7jTuw05utQglnqZikfNzgRAw47NZiymlE
         9Mw5BdEh2N/x7NtXTRjID52qIgVq6+vnlB+Wk/EYzYduzEtoP7q9vkFl0VdC40vGMzi+
         kxQ1CH+fuGOhaenO6aNImGtZzxzqf4cL8JXsxfxjQRkmAz+rwemGIt0i1hoddT8d3db0
         DfFw==
X-Gm-Message-State: AOAM531GeW5FO+6mIXZFk3aG/rajDbfS2SadYHyC9r4Yk2o9yCHMgMmI
        vUgQYov373JJKzng6CQDo8E08Dk7EkwZJWMgs+I=
X-Google-Smtp-Source: ABdhPJwmD50FNu7pg+bxDxzIfP7b6FbrE4ZJaK1Bw8TAS+CDtLGbaaU90Wd09/zT21c7WigKXG7F+Uwo0u5cNy1rAbY=
X-Received: by 2002:a0c:b712:: with SMTP id t18mr958012qvd.205.1596142281418;
 Thu, 30 Jul 2020 13:51:21 -0700 (PDT)
Date:   Thu, 30 Jul 2020 13:51:08 -0700
Message-Id: <20200730205112.2099429-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 0/4] CONFIG_UNWINDER_FRAME_POINTER fixes+cleanups
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Nathan Huckleberry <nhuck15@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        clang-built-linux@googlegroups.com,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Lvqiang Huang <lvqiang.huang@unisoc.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miles Chen <miles.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We received a report of boot failure on stable/4.14.y using Clang with
CONFIG_UNWINDER_FRAME_POINTER. Turns out, this was a cascaded failure
with at least 4 different things going wrong. Working backwards from the
failure:

4) There was no fixup handler in backtrace-clang.S for a specific
address calculation. If an indirect access to that address triggers a
page fault for which no corresponding fixup exists, then a panic is
triggered. Panicking triggers another unwind, and all this repeats in an
infinite loop.  If the unwind was started from within start_kernel(),
this results in a kernel that does not boot.  We can install a fixup
handler to fix the infinite loop, but why was the unwinder accessing an
address that would trigger a fault?

3) The unwinder has multiple conditions to know when to stop unwinding,
but checking for a valid address in the link register was not one of
them. If there was a value for lr that we could check for before using
it, then we could add that as another stopping condition to terminate
unwinding. But the garbage value in lr in the case of save_stack()
wasn't particularly noteworthy from any other address; it was ambiguous
whether we had more frames to continue unwinding through or not, but
what value would we check for?

2) When following a frame chain, we can generally follow the addresses
pushed onto the stack from the link register, lr. The callee generally
pushes this value.  For our particular failure, the value in the link
register upon entry to save_stack() was garbage. The caller,
__mmap_switched, does a tail call into save_stack() since we don't plan
to return control flow back to __mmap_switched. It uses a `b` (branch)
instruction rather than a `bl` (branch+link) which is correct, since
there are no instructions after the `b save_stack` in __mmap_switched.
If we interpret the value of lr that was pushed on the stack in
save_stack(), then it appears that we have further frames to unwind.
When observing an unwind on mainline though, lr upon entry to
save_stack() was 0x00!

It turns out that this exact ambiguity was found+fixed already by
upstream
commit 59b6359dd92d ("ARM: 8702/1: head-common.S: Clear lr before jumping to start_kernel()")
which landed in 4.15-rc1 but was not yet backported to stable/4.14.y.
Sent to stable in:
https://lore.kernel.org/stable/20200730180340.1724137-1-ndesaulniers@google.com/T/#u
That gives us a value in lr upon entry to save_stack() that's noteworthy
as a terminal condition during unwinding.  But why did we start
unwinding in start_kernel() in the first place?

1) A simple WARN_ON_ONCE was being triggered during start_kernel() due
to another patch that landed in v4.15-rc9 but wasn't backported to
stable/4.14.y. Sent to stable in:
https://lore.kernel.org/stable/20200727191746.3644844-1-ndesaulniers@google.com/T/#u

Read (or unwound; pun intended) in the order 1), 2), 3), 4) explains the
cascading chain of failures that lead to a kernel not booting.

Patch 0001 fixes 3) by adding a test for NULL to the conditions to stop
unwinding. This prevents the cascade from going further.
Patch 0002 fixes 4) by adding a fixup handler. It's not strictly
necessary right now, but I get the feeling that we might not be able to
trust the value of the link register pushed on the stack.  I'm guessing
a stack buffer overflow could overwrite this value. Either way,
triggering an exception during unwind should be prevented at all costs
to avoid infinite loops.
Patches 0003/0004 are cleanup/bikeshed, feel free to NACK them and I
don't mind dropping them.  They're just minor touchups I felt helped
readability from when I was debugging these. 0001 (and slightly so 0002)
are the only patches I really care about.

Nick Desaulniers (4):
  ARM: backtrace-clang: check for NULL lr
  ARM: backtrace-clang: add fixup for lr dereference
  ARM: backtrace-clang: give labels more descriptive names
  ARM: backtrace: use more descriptive labels

 arch/arm/lib/backtrace-clang.S | 34 +++++++++++++++++++++-------------
 arch/arm/lib/backtrace.S       | 30 +++++++++++++++---------------
 2 files changed, 36 insertions(+), 28 deletions(-)

-- 
2.28.0.163.g6104cc2f0b6-goog

