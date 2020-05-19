Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A7CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A032320674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="HQY7MAoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgESBGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 21:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgESBGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 21:06:07 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A76CC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 18:06:06 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e8so11774133ilm.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 18:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WXpirZqtYBddTk6Ncg43EgFZLm/F1+r+8igmhzGGDgQ=;
        b=HQY7MAoqIIownxq0AtxsvYJvwvSae2reFIl+iKa9bDLrGa1IuJYNAMJh+2Mj4ARbAo
         JE8EyfADE+R8hJOtPaIhlQle2ltGoOppsBB9IJjhVsmKz3w0LuAylPsXGxwBrwS4W15t
         M4EIB76ReUaHHRr11Cekp5H4BUWFJAGRsyBTMxWZXOf8a5HCbCRVpnZSATMiRgX/Ro87
         bxIGethFu8/zKbsoHTckhl6YuA8aR9N/T3yvoOm9Edv3ksGXNcrIGK9/DoHsepGnb5N1
         f6boqz9GPXpAy1bcgwj8mnCEFgYxhPUdiq/WqH6HAd8kMH93bBFD4oM0gu1qn26nUK2X
         o9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WXpirZqtYBddTk6Ncg43EgFZLm/F1+r+8igmhzGGDgQ=;
        b=QG+Mi7I7ejLGlQbV181B7EHNekTdq6aCP8zjMR64rmeyKCyTuzjVTmVlbhYYKnISu3
         V/+F2NX1/4CAKk8ztSgwceh50sSCx3s65IWREUz2nBm+WBN3FzLdlis4Cl9VlECifiNw
         ha3suMgkiFY8kQN6XNIxhJX9hw6fEZuAmV/ER2b1T9gPl3HSxEHHxfRmqLOmxyWIrhaY
         bY9JJRZUxYEbKnudDpCB3IMNhS7d03mhCSTjSwRCaauSv18ixg4UMMETlk8tHpQmMHhR
         vG4p9CLCHNeWQuhHVG6z54JJfuSz4YwoTQ8ReU2omuXeJ2x8H28UblKnEN2/j0NUt7Zt
         zbug==
X-Gm-Message-State: AOAM532T1siXVYkwaEXbD+Lp9FhMBIyvfyFtCQhmc4YETapPZIUjWbRC
        SKAilt1iJ8cGhkEb1ayc2QO7O9lyoZEOZ3AaQfM2NQ==
X-Google-Smtp-Source: ABdhPJxYBTk4jRaJXOTi3j1um42KqKDWBa7Ee1JL9itlM1FLHLBXo7g5TWO+tsKZbVsdDuqk755NTfcio7J5rfLIKxg=
X-Received: by 2002:a05:6e02:2:: with SMTP id h2mr16697255ilr.281.1589850365796;
 Mon, 18 May 2020 18:06:05 -0700 (PDT)
MIME-Version: 1.0
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Mon, 18 May 2020 21:05:30 -0400
Message-ID: <CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com>
Subject: arm64: Register modification during syscall entry/exit stop
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <khuey@pernos.co>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continuing my theme of "weird things I encounter
while trying to use ptrace on arm64", I ran into the
effect of the following code in the syscall entry/exit
reporting:

```
/*
* A scratch register (ip(r12) on AArch32, x7 on AArch64) is
* used to denote syscall entry/exit:
*/
regno = (is_compat_task() ? 12 : 7);
saved_reg = regs->regs[regno];
regs->regs[regno] = dir;
```

This seems very weird to me. I can't think of any
other architecture that does something similar
(other than unicore32 apparently, but the ptrace
support there seems like it might have just been
copied from ARM). I'm able to work around this
in my application, but it adds another stumbling block.
Some examples of things that happen:
- Writes to x7 during syscall exit stops are ignored, so
  if the ptracer tries to emulate a setjmp-type thing, it
  might miss this register (ptracers sometimes like to do
  this to manually serialize execution between different
  threads, puppeteering a single thread of execution
  between different register states).
- Reads from x7 are incorrect, so if the ptracer saves
  a register state and later tries to set it back to the task,
  it may get x7 incorrect, but user space may be expecting
  the register to be preserved (when might this happen? -
  consider a ptracer that wants to modify some syscall
  arguments, it modifies the arguments, restarts the syscall
  but then incurs a signal, so it tries to restore the original
  registers to let userspace deal with the signal without
  being confused - expect signal traps don't ignore x7
  modifications, so x7 may have been unexpectedly
  modified).
- We now have seccomp traps, which kind of look and
  act like syscall-entry traps, but don't have this behavior,
  so it's not particularly reliable for ptracers to use.

Furthermore, it seems unnecessary to me on modern
kernels. We now have PTRACE_GET_SYSCALL_INFO,
which exposes this information without lying to the ptracer
about the tracee's registers.

I understand, we can't just change this, since people may
be relying on it, but I would like to propose adding a ptrace
option (PTRACE_O_ARM_REGSGOOD?) that turns this
behavior off. Now, I don't think we currently have any other
arch-specific ptrace options, so maybe there is a different
option that would be preferable (e.g. could be a different
regset), but I do think it would be good to have a way to
operate on the real x7 value. As I said, I can work around it,
but hopefully I will be able to save a future implementer
some headache.

Keno
