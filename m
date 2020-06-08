Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95076C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7038E2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591661880;
	bh=jAO10dhZ0/bvgXRJ5ALw6c+WQy6MKBhxPTMd0JqViQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xuRkR9aGu7y5laLSroE8TG5ESNB8qqGXYXaVQ7y6GjbGJ+VSDhyRN4VAFfbnIPMGk
	 KTuotiU//YHsJXUjNgA9FzIGXD58Pqu9J6t/vQ73L5XrGE8/ojmlEdre7v3WI82b9T
	 Zr1W0GoOuaOBoShrbl6OdWr6cLmBR2L3xkAXMjwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgFHXSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbgFHXPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:15:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 921F121501;
        Mon,  8 Jun 2020 23:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658110;
        bh=jAO10dhZ0/bvgXRJ5ALw6c+WQy6MKBhxPTMd0JqViQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yp0wg583cF/EJPOSbFpdN9IqDseS+8SjiNe+I6RNd5lKW+bWA7Sg7dxHXYpvHm0oJ
         Gfa7aIoiLnNdXok2JCtEkj8WOuCcRik8BW7c5JwB/bgqLCUFXFyBE7/2mT9cDNm7nC
         lai9bI4IGeA7KA8S0NjsuY0CxyU/sYX4FnL+EWak=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, Bin Lu <Bin.Lu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 149/606] arm64: Fix PTRACE_SYSEMU semantics
Date:   Mon,  8 Jun 2020 19:04:34 -0400
Message-Id: <20200608231211.3363633-149-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keno Fischer <keno@juliacomputing.com>

commit 1cf6022bd9161081215028203919c33fcfa6debb upstream.

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

Fixes: f086f67485c5 ("arm64: ptrace: add support for syscall emulation")
Cc: <stable@vger.kernel.org> # 5.3.x-
Signed-off-by: Keno Fischer <keno@juliacomputing.com>
Acked-by: Will Deacon <will@kernel.org>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Bin Lu <Bin.Lu@arm.com>
[catalin.marinas@arm.com: moved 'flags' bit masking]
[catalin.marinas@arm.com: changed 'flags' type to unsigned long]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/ptrace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index cd6e5fa48b9c..c30f77bd875f 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1829,10 +1829,11 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 
 int syscall_trace_enter(struct pt_regs *regs)
 {
-	if (test_thread_flag(TIF_SYSCALL_TRACE) ||
-		test_thread_flag(TIF_SYSCALL_EMU)) {
+	unsigned long flags = READ_ONCE(current_thread_info()->flags);
+
+	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
-		if (!in_syscall(regs) || test_thread_flag(TIF_SYSCALL_EMU))
+		if (!in_syscall(regs) || (flags & _TIF_SYSCALL_EMU))
 			return -1;
 	}
 
-- 
2.25.1

