Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E618C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9ED920B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585888944;
	bh=URqBucSp0tV4kCBFGrp7/pCKkGVwDZ94X4jFcxSpXnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cp7B7yUTSJHW/dNVBAsOKMHXDy3QskTIO0zqB7Wwx5kNJ8wNNa40wDi0WK8v+rPFz
	 GORPXDmtG7qtnSY5g4+uSsRVZdNiFXISWRfhxAUBx/DB4TXb36C4b0mQLUn2xpW9u9
	 MUsP/J/XC+4JRVfFKYS47cdiHwA3VemHPj6RigGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387707AbgDCEmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733014AbgDCEmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:42:20 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71765214D8;
        Fri,  3 Apr 2020 04:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585888939;
        bh=URqBucSp0tV4kCBFGrp7/pCKkGVwDZ94X4jFcxSpXnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VBpHRpRX8IeJRQACUBi8Fkr7EtVV+xn6NZtFy87hICg8VygFv5C5CnNNMw80KAGKh
         ktVDE2rYL7MU+DdtgWZSEOT7YDcSCtVkFlE268djmxB27X8t62dQIbaSijBdt3hW9s
         +3XskOT3cMMi+OS6TwIzOBSBCiUB0i1VXLc/rFRQ=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 08/11] csky: Enable LOCKDEP_SUPPORT
Date:   Fri,  3 Apr 2020 12:41:47 +0800
Message-Id: <20200403044150.20562-8-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200403044150.20562-1-guoren@kernel.org>
References: <20200403044150.20562-1-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Lockdep is needed by proving the spinlocks and rwlocks. Currently,
we only put trace_hardirqs_on/off with csky_irq and
ret_from_exception.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/Kconfig        |  3 +++
 arch/csky/kernel/entry.S | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index a75b8e1fef1d..998188f44fd7 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -69,6 +69,9 @@ config CSKY
 	select PCI_SYSCALL if PCI
 	select PCI_MSI if PCI
 
+config LOCKDEP_SUPPORT
+	def_bool y
+
 config CPU_HAS_CACHEV2
 	bool
 
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 0bde1d9fd277..8b040a1b11d0 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -225,6 +225,13 @@ ret_from_exception:
 	cmpnei	r12, 0
 	bt	exit_work
 1:
+#ifdef CONFIG_TRACE_IRQFLAGS
+	ld	r10, (sp, LSAVE_PSR)
+	btsti	r10, 6
+	bf	2f
+	jbsr	trace_hardirqs_on
+2:
+#endif
 	RESTORE_ALL
 
 exit_work:
@@ -280,6 +287,10 @@ ENTRY(csky_irq)
 	zero_fp
 	psrset	ee
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+	jbsr	trace_hardirqs_off
+#endif
+
 #ifdef CONFIG_PREEMPTION
 	mov	r9, sp			/* Get current stack  pointer */
 	bmaski	r10, THREAD_SHIFT
-- 
2.17.0

