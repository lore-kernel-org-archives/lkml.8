Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DC9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 22:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD0520643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 22:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="BwkiLuN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgEOWW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 18:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgEOWW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 18:22:57 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0A4C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 15:22:57 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 190so4332694qki.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=TAEeLRHczjNG3Cacn9/4Eq8k480FxxPELQkCilNmlOU=;
        b=BwkiLuN3CS3wSfV5UK/uFMwWOrqdIuQqkzgFEHnZA9kg/p0ceMCfR2loMYNAIkq/7m
         fQixDxjcDe6oAk+sKgT3wjq5PUYOKFnQFT9f4IdUe+PWGoMFPfnDTP0EohFkMO9YTTvj
         0OWexima9S9sys9Y7txoCZRf4F+yVgioqoAdJf0/RbBg0B3aifD33ddB1j880f10TgqI
         8gnIeGfnCVkPvinPsCZiKQVgWgzpYDVHvpHFR+KJe2sAivPii6Ba1Rm9ol7BZx2K+IHC
         N4VCkR0oofbqlYUm5ueUJbsRooZ3d9ZX54zUi9CZ/1WD85d0MdGRZfczKjEbP8H2Sh8z
         amHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TAEeLRHczjNG3Cacn9/4Eq8k480FxxPELQkCilNmlOU=;
        b=YhapvD2KwMKolq41UJwkNOzQlIJgDVu+2Bc+oa4taCvCdJejYOzmrMY0pRTDrgprDl
         +UB6j2wJNgTw0pqzxeP7Lb9sBEWvL3UDdQP7NLTAS6xgxWyya3ZRCz4foCTuvehd0YPF
         XWHQewDOn4DpoTgoKga/VxlhIlBeRgLeb3b96rZRsvLlLS/3VMp9+v+tHTof4g46xBzB
         GrupSaQQ3EYGAmUcK1vta2W7DSOKxfRBuDYwZatOOFW7M+teLFsD4lL88x7BaFb89Jwq
         2NlhFmvmHQSURj6OTlnLhdPd48+Gjt0R4ZDSY019DBWBse1kd8q7wff22WYhBjTRB2Jl
         CtUg==
X-Gm-Message-State: AOAM532sejdAL4IXN//Y+GJSqON2Opc3KKbPHlUwDbeSJffQ+BZlYk64
        Ej++Ys7f7FRuPLtce+hm9rontvXP7Jk=
X-Google-Smtp-Source: ABdhPJxWS5ExnKqQjp6aui5DcHPI3l0EUkcpJEBffC9mwIoRBD5bOFJDjMNSjDsV2dZeT5P2n4OsFA==
X-Received: by 2002:a37:8347:: with SMTP id f68mr5438179qkd.153.1589581376285;
        Fri, 15 May 2020 15:22:56 -0700 (PDT)
Received: from juliacomputing.com ([2601:184:4780:3aef:d1fc:d97:8a48:767e])
        by smtp.gmail.com with ESMTPSA id 127sm2642035qkj.59.2020.05.15.15.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 15:22:55 -0700 (PDT)
Date:   Fri, 15 May 2020 18:22:53 -0400
From:   Keno Fischer <keno@juliacomputing.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     will.deacon@arm.com, sudeep.holla@arm.com, catalin.marinas@arm.com,
        oleg@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: Fix PTRACE_SYSEMU semantics
Message-ID: <20200515222253.GA38408@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth the man page:
```
       If the tracee was restarted by PTRACE_SYSCALL or PTRACE_SYSEMU, the
       tracee enters syscall-enter-stop just prior to entering any system
       call (which will not be executed if the restart was using
       PTRACE_SYSEMU, regardless of any change made to registers at this
       point or how the tracee is restarted after this stop).
```

The parenthetical comment is currently true on x86 and powerpc,
but not currently true on arm64. arm64 re-checks the _TIF_SYSCALL_EMU
flag after the syscall entry ptrace stop. However, at this point,
it reflects which method was used to re-start the syscall
at the entry stop, rather than the method that was used to reach it.
Fix that by recording the original flag before performing the ptrace
stop, bringing the behavior in line with documentation and x86/powerpc.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 arch/arm64/kernel/ptrace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index b3d3005d9515..b67b4d14aa17 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1829,10 +1829,12 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 
 int syscall_trace_enter(struct pt_regs *regs)
 {
-	if (test_thread_flag(TIF_SYSCALL_TRACE) ||
-		test_thread_flag(TIF_SYSCALL_EMU)) {
+	u32 flags = READ_ONCE(current_thread_info()->flags) &
+		(_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
+
+	if (flags) {
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
-		if (!in_syscall(regs) || test_thread_flag(TIF_SYSCALL_EMU))
+		if (!in_syscall(regs) || (flags & _TIF_SYSCALL_EMU))
 			return -1;
 	}
 
-- 
2.25.1

