Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC95DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D002088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593795790;
	bh=m3e/FHb743juz8MYek0OvVhLTMbLckgasucbPdaxygo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W0I9vrn2FcKWu2LqFYpUQqM7tHPhUwm/I0wpyRzc1yom804KcNddApkUdw7X8ZO6f
	 wQFSrIN3Ta4kR5c18HGC2zkMIIWOe8I4I5i2sZtZKVxo6vRyWoDymt8hmJLIlEoyQp
	 L9ylIH32PmbXSBLBceyIUWr17FnM/uXlkIPHgsmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgGCRDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:32780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbgGCRDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:03:05 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0774620870;
        Fri,  3 Jul 2020 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593795785;
        bh=m3e/FHb743juz8MYek0OvVhLTMbLckgasucbPdaxygo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VWcP9iqyLBv+86u0kYw4lUSLm+N0UmdFgSu2iLSK/GNJbApYwyDnhINaz+bNEs1p7
         hMN7C4m0zSYIchwEG8Qlg7Nybl2H9E5LR33crsBr5uZqjHRo4Lrdk7IdDIhVUPkoSE
         iyuR325fUMzGJ+5l9/AFowXNnZBgraNpJFaIUuF4=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH entry v2 5/6] x86/ldt: Disable 16-bit segments on Xen PV
Date:   Fri,  3 Jul 2020 10:02:57 -0700
Message-Id: <92b2975459dfe5929ecf34c3896ad920bd9e3f2d.1593795633.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593795633.git.luto@kernel.org>
References: <cover.1593795633.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xen PV doesn't implement ESPFIX64, so they don't work right.  Disable
them.  Also print a warning the first time anyone tries to use a
16-bit segment on a Xen PV guest that would otherwise allow it
to help people diagnose this change in behavior.

This gets us closer to having all x86 selftests pass on Xen PV.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/ldt.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 8748321c4486..34e918ad34d4 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -29,6 +29,8 @@
 #include <asm/mmu_context.h>
 #include <asm/pgtable_areas.h>
 
+#include <xen/xen.h>
+
 /* This is a multiple of PAGE_SIZE. */
 #define LDT_SLOT_STRIDE (LDT_ENTRIES * LDT_ENTRY_SIZE)
 
@@ -543,6 +545,37 @@ static int read_default_ldt(void __user *ptr, unsigned long bytecount)
 	return bytecount;
 }
 
+static bool allow_16bit_segments(void)
+{
+	if (!IS_ENABLED(CONFIG_X86_16BIT))
+		return false;
+
+#ifdef CONFIG_XEN_PV
+	/*
+	 * Xen PV does not implement ESPFIX64, which means that 16-bit
+	 * segments will not work correctly.  Until either Xen PV implements
+	 * ESPFIX64 and can signal this fact to the guest or unless someone
+	 * provides compelling evidence that allowing broken 16-bit segments
+	 * is worthwhile, disallow 16-bit segments under Xen PV.
+	 */
+	if (xen_pv_domain()) {
+		static DEFINE_MUTEX(xen_warning);
+		static bool warned;
+
+		mutex_lock(&xen_warning);
+		if (!warned) {
+			pr_info("Warning: 16-bit segments do not work correctly in a Xen PV guest\n");
+			warned = true;
+		}
+		mutex_unlock(&xen_warning);
+
+		return false;
+	}
+#endif
+
+	return true;
+}
+
 static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 {
 	struct mm_struct *mm = current->mm;
@@ -574,7 +607,7 @@ static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 		/* The user wants to clear the entry. */
 		memset(&ldt, 0, sizeof(ldt));
 	} else {
-		if (!IS_ENABLED(CONFIG_X86_16BIT) && !ldt_info.seg_32bit) {
+		if (!ldt_info.seg_32bit && !allow_16bit_segments()) {
 			error = -EINVAL;
 			goto out;
 		}
-- 
2.25.4

