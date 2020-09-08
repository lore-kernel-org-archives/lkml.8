Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2B5C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 280ED2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbgIHR4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:56:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:60797 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731627AbgIHRzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:55:52 -0400
IronPort-SDR: 9OJTvAM4QfO6yO+jzuedL+2Oot2iPZTGsHigG38YpsB35IwCQG5vIS5syCHmZL7DOCtWAFrK5p
 XOtWb/5j5hkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="145907154"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="145907154"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:55:28 -0700
IronPort-SDR: OqijQn5XQJ2/iaYbW4T8ZpmDTkdbfTWJgBmRL58Yhk0+O9v+LxRQy+XkS4oLJ5+IycOU7C+G3l
 cvo2+SoHYBiw==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="480125764"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:55:28 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] x86/mce: Avoid tail copy when machine check terminated a copy from user
Date:   Tue,  8 Sep 2020 10:55:16 -0700
Message-Id: <20200908175519.14223-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200908175519.14223-1-tony.luck@intel.com>
References: <20200908175519.14223-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the page fault case it is ok to see if a few more unaligned bytes
can be copied from the source address. Worst case is that the page fault
will be triggered again.

Machine checks are more serious. Just give up at the point where the
main copy loop triggered the #MC and return as if the copy succeeded.

[Tried returning bytes not copied here, but that puts the kernel
 into a loop taking the machine check over and over. I don't know
 at what level some code is retrying]

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/lib/copy_user_64.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 5b68e945bf65..1a58946e7c4e 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -15,6 +15,7 @@
 #include <asm/asm.h>
 #include <asm/smap.h>
 #include <asm/export.h>
+#include <asm/trapnr.h>
 
 .macro ALIGN_DESTINATION
 	/* check for bad alignment of destination */
@@ -221,6 +222,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * Try to copy last bytes and clear the rest if needed.
  * Since protection fault in copy_from/to_user is not a normal situation,
  * it is not necessary to optimize tail handling.
+ * Don't try to copy the tail if machine check happened
  *
  * Input:
  * rdi destination
@@ -232,10 +234,15 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  */
 SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 	movl %edx,%ecx
+	cmp $X86_TRAP_MC,%eax		/* check if X86_TRAP_MC */
+	je 3f
 1:	rep movsb
 2:	mov %ecx,%eax
 	ASM_CLAC
 	ret
+3:	xorl %eax,%eax	/* pretend we succeeded? */
+	ASM_CLAC
+	ret
 
 	_ASM_EXTABLE_CPY(1b, 2b)
 SYM_CODE_END(.Lcopy_user_handle_tail)
-- 
2.21.1

