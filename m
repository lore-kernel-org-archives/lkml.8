Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7736C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8060D206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbgIHR45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:56:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:60831 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731639AbgIHRzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:55:52 -0400
IronPort-SDR: vzqi/GRlu6JxPkjbsgnX5AIcNMqHGkFtsJLYODqafhJmtHYCkPQ4wLSQ+OLZASUGCHvgcwZc15
 YvOL1Xmwb4tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="145907155"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="145907155"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:55:28 -0700
IronPort-SDR: 7CkE/gSnq4RS+N7d3i8P3GnGnFZYmGl7ifewZkWc6wWl5FKwOSZKNfLxhC4loqU7pcNpYMbZpO
 X/UDMNxSfEyw==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="480125768"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:55:28 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Youquan Song <youquan.song@intel.com>, tony.luck@intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] x86/mce: Change fault_in_kernel_space() from static to global
Date:   Tue,  8 Sep 2020 10:55:17 -0700
Message-Id: <20200908175519.14223-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200908175519.14223-1-tony.luck@intel.com>
References: <20200908175519.14223-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youquan Song <youquan.song@intel.com>

Machine check code needs to be able to determine if a faulting address
is in user of kernel space. There is already a function to do this.

Change from "static int" to "bool" and add declaration to <asm/traps.h>

No functional change.

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: <tony.luck@intel.com>
---
 arch/x86/include/asm/traps.h | 2 ++
 arch/x86/mm/fault.c          | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 714b1a30e7b0..df0b7bfc1234 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -35,6 +35,8 @@ extern int panic_on_unrecovered_nmi;
 
 void math_emulate(struct math_emu_info *);
 
+bool fault_in_kernel_space(unsigned long address);
+
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(const char *message,
 				      struct pt_regs *regs,
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6e3e8a124903..42606a04ae85 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1128,7 +1128,7 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
 	return 0;
 }
 
-static int fault_in_kernel_space(unsigned long address)
+bool fault_in_kernel_space(unsigned long address)
 {
 	/*
 	 * On 64-bit systems, the vsyscall page is at an address above
-- 
2.21.1

