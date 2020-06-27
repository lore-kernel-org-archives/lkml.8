Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F0EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 07:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124492080C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 07:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="skBZghme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgF0H5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 03:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgF0H5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 03:57:11 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214D4C03E979
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 00:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZvVsDLKfUWeVN72u7tyZYUM297bwDhD5XEzJ3uBgX68=; b=skBZghmesP9eBh/tO4PQ1NsELs
        VbsC9hrhBv+b68Si9u1RmhOVZccrGcpVwhoZW6fAxTOB8WPP2PbRBtFs1VxQC23fF0SsKWIk9PLSo
        58sfyq2vy9UHiS9ESaLbctPbRLObyBpGRpt+qC17CAaB85MOL2lMicF7QZwftDFBO5DWDzqphy19R
        FD70XZGh0JXKG4i9+MxyrrKnJQdW7MlSyn46NabA9/IUYH2ToeFJXNnJ5Rh2XZ5w6oFmQ8J8Oy+Ow
        Cjo9yJ6tTpXgcqn1XBx4F2ePXIjr738J0ZsLONqV2vweF4Rvw6IfRJQk9xSwFyPyJ37sbXr6YDY4A
        izOQK4MA==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5hi-0007u4-Ky; Sat, 27 Jun 2020 07:56:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] vmalloc: fix the owner argument for the new __vmalloc_node_range callers
Date:   Sat, 27 Jun 2020 09:56:49 +0200
Message-Id: <20200627075649.2455097-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the recently added new __vmalloc_node_range callers to pass the correct
values as the owner for display in /proc/vmallocinfo.

Fixes: 800e26b81311 ("x86/hyperv: allocate the hypercall page with only read and execute bits")
Fixes: 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page")
Fixes: 7a0e27b2a0ce ("mm: remove vmalloc_exec")
Reported-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/kernel/probes/kprobes.c | 2 +-
 arch/x86/hyperv/hv_init.c          | 3 ++-
 kernel/module.c                    | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index cbe49cd117cfec..5290f17a4d8041 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -122,7 +122,7 @@ void *alloc_insn_page(void)
 {
 	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
 			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
-			NUMA_NO_NODE, __func__);
+			NUMA_NO_NODE, __builtin_return_address(0));
 }
 
 /* arm kprobe: install breakpoint in text */
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 2bdc72e6890eca..6035df1b49e1a7 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -377,7 +377,8 @@ void __init hyperv_init(void)
 
 	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
 			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
-			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE, __func__);
+			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
+			__builtin_return_address(0));
 	if (hv_hypercall_pg == NULL) {
 		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 		goto remove_cpuhp_state;
diff --git a/kernel/module.c b/kernel/module.c
index 0c6573b98c3662..bee1c25ca5c5ec 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2785,7 +2785,7 @@ void * __weak module_alloc(unsigned long size)
 {
 	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
 			GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
-			NUMA_NO_NODE, __func__);
+			NUMA_NO_NODE, __builtin_return_address(0));
 }
 
 bool __weak module_init_section(const char *name)
-- 
2.26.2

