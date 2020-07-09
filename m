Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421F6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E61206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgGIKeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgGIKeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:34:13 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F21C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:34:13 -0700 (PDT)
Received: from cap.home.8bytes.org (p549adb3d.dip0.t-ipconnect.de [84.154.219.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id CC3B2189;
        Thu,  9 Jul 2020 12:34:09 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        joro@8bytes.org
Subject: [PATCH] x86/idt: Make sure idt_table takes a whole page
Date:   Thu,  9 Jul 2020 12:33:55 +0200
Message-Id: <20200709103355.11359-1-joro@8bytes.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

On x86-32 the idt_table with 256 entries needs only 2048 bytes. It is
page-aligned, but the end of the .bss..page_aligned section is not
guaranteed to be page-aligned.

As a result, symbols from other .bss sections may end up on the same
4k page as the idt_table, and will accidentially get mapped read-only
during boot, causing unexpected page-faults when the kernel writes to
them.

Avoid this by making the idt_table 4kb in size even on x86-32. On
x86-64 the idt_table is already 4kb large, so nothing changes there.

Fixes: 3e77abda65b1c ("x86/idt: Consolidate idt functionality")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/idt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 0db21206f2f3..83e24f837127 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -157,8 +157,13 @@ static const __initconst struct idt_data apic_idts[] = {
 #endif
 };
 
-/* Must be page-aligned because the real IDT is used in the cpu entry area */
-static gate_desc idt_table[IDT_ENTRIES] __page_aligned_bss;
+/*
+ * Must be page-aligned because the real IDT is used in the cpu entry area.
+ * Allocate more entries than needed so that idt_table takes a whole page, so it
+ * is safe to map the idt_table read-only and into the user-space page-table.
+ */
+#define IDT_ENTRIES_ALLOCATED	(PAGE_SIZE / sizeof(gate_desc))
+static gate_desc idt_table[IDT_ENTRIES_ALLOCATED] __page_aligned_bss;
 
 struct desc_ptr idt_descr __ro_after_init = {
 	.size		= IDT_TABLE_SIZE - 1,
@@ -335,6 +340,9 @@ void __init idt_setup_apic_and_irq_gates(void)
 	idt_map_in_cea();
 	load_idt(&idt_descr);
 
+	BUILD_BUG_ON(IDT_ENTRIES_ALLOCATED < IDT_ENTRIES);
+	BUILD_BUG_ON(sizeof(idt_table) != PAGE_SIZE);
+
 	/* Make the IDT table read only */
 	set_memory_ro((unsigned long)&idt_table, 1);
 
-- 
2.27.0

