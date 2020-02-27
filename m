Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1108BC4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22C524650
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgB0EAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:00:41 -0500
Received: from foss.arm.com ([217.140.110.172]:45290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbgB0EAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 23:00:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C328130E;
        Wed, 26 Feb 2020 20:00:40 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C76033F73B;
        Wed, 26 Feb 2020 20:00:38 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/debug: Replace __pa() with __pa_symbol() in debug_vm_pgtable()
Date:   Thu, 27 Feb 2020 09:30:31 +0530
Message-Id: <1582776031-30344-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace __pa() with __pa_symbol() in debug_vm_pgtable() while accessing the
physical address for 'start_kernel' which is a kernel text symbol, else it
might trigger the following warning on some platforms when DEBUG_VIRTUAL is
enabled.

[   23.123852] ------------[ cut here ]------------
[   23.124486] virt_to_phys used for non-linear address: (____ptrval____) (start_kernel+0x0/0x424)
[   23.125663] WARNING: CPU: 11 PID: 1 at arch/arm64/mm/physaddr.c:15 __virt_to_phys+0x60/0x98
[   23.126877] Modules linked in:
[   23.127390] CPU: 11 PID: 1 Comm: swapper/0 Tainted: G        W 5.6.0-rc3-next-20200226-00001-g306225cc6ffd #163
[   23.129139] Hardware name: linux,dummy-virt (DT)
[   23.129898] pstate: 60400005 (nZCv daif +PAN -UAO)
[   23.130693] pc : __virt_to_phys+0x60/0x98
[   23.131359] lr : __virt_to_phys+0x60/0x98
[   23.132022] sp : ffff800011e6be10
[   23.132575] x29: ffff800011e6be10 x28: 0000000000000000
[   23.133447] x27: 0000000000000000 x26: 0000000000000000
[   23.134319] x25: 0000000000000000 x24: 0020000000000fd3
[   23.135197] x23: fffffe000bd27700 x22: ffff0002fcae8000
[   23.136069] x21: ffff800011a47000 x20: 0000000000000001
[   23.136941] x19: ffff800011350a14 x18: 0000000000000010
[   23.137815] x17: 000000006bb8910e x16: 00000000a1fdc699
[   23.138693] x15: ffffffffffffffff x14: 6c656e72656b5f74
[   23.139567] x13: 726174732820295f x12: 5f5f5f6c61767274
[   23.140441] x11: 705f5f5f5f28203a x10: 7373657264646120
[   23.141314] x9 : 7261656e696c2d6e x8 : ffff8000106b4e70
[   23.142189] x7 : 00000000000002a1 x6 : ffff800011a58bba
[   23.143067] x5 : 001fffffffffffff x4 : 0000000000000000
[   23.143939] x3 : 00000000ffffffff x2 : ffff800011881bf8
[   23.144810] x1 : 16ee3f9cb03efc00 x0 : 0000000000000000
[   23.145682] Call trace:
[   23.146097]  __virt_to_phys+0x60/0x98
[   23.146710]  debug_vm_pgtable+0xd0/0x440
[   23.147362]  kernel_init+0x18/0x100
[   23.147944]  ret_from_fork+0x10/0x18
[   23.148539] ---[ end trace fc4ccb3cb35ff225 ]---

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on linux-next (next-20200226). Tested on arm64 and x86
platforms. Build tested on several others.

 mm/debug_vm_pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index cdfab040c1f6..9d1c8570fa00 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -585,7 +585,7 @@ void __init debug_vm_pgtable(void)
 	 * helps avoid large memory block allocations to be used for mapping
 	 * at higher page table levels.
 	 */
-	paddr = __pa(&start_kernel);
+	paddr = __pa_symbol(&start_kernel);
 
 	pte_aligned = (paddr & PAGE_MASK) >> PAGE_SHIFT;
 	pmd_aligned = (paddr & PMD_MASK) >> PAGE_SHIFT;
-- 
2.20.1

