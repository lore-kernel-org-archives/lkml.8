Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CB9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7394F20734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFBSG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:06:58 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:51620 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgFBSG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:06:58 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jun 2020 14:06:56 EDT
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9435E72CCF1;
        Tue,  2 Jun 2020 21:00:51 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 77BEF7CFE82; Tue,  2 Jun 2020 21:00:51 +0300 (MSK)
Date:   Tue, 2 Jun 2020 21:00:51 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <evgsyr@gmail.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: fix syscall_get_error for compat processes
Message-ID: <20200602180051.GA2427@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If both the tracer and the tracee are compat processes, and gprs[2]
is assigned a value by __poke_user_compat, then the higher 32 bits
of gprs[2] are cleared, IS_ERR_VALUE() always returns false, and
syscall_get_error() always returns 0.

Fix the implementation by sign-extending the value for compat processes
the same way as x86 implementation does.

The bug was exposed to user space by commit 201766a20e30f ("ptrace: add
PTRACE_GET_SYSCALL_INFO request") and detected by strace test suite.

This change fixes strace syscall tampering on s390.

Fixes: 753c4dd6a2fa2 ("[S390] ptrace changes")
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: stable@vger.kernel.org # v2.6.28+
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/s390/include/asm/syscall.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index f073292e9fdb..c07633824715 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -33,7 +33,17 @@ static inline void syscall_rollback(struct task_struct *task,
 static inline long syscall_get_error(struct task_struct *task,
 				     struct pt_regs *regs)
 {
-	return IS_ERR_VALUE(regs->gprs[2]) ? regs->gprs[2] : 0;
+	unsigned long error = regs->gprs[2];
+#ifdef CONFIG_COMPAT
+	if (test_tsk_thread_flag(task, TIF_31BIT)) {
+		/*
+		 * Sign-extend the value so (int)-EFOO becomes (long)-EFOO
+		 * and will match correctly in comparisons.
+		 */
+		error = (long) (int) error;
+	}
+#endif
+	return IS_ERR_VALUE(error) ? error : 0;
 }
 
 static inline long syscall_get_return_value(struct task_struct *task,
-- 
ldv
