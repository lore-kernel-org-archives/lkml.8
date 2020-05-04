Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477CEC47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8972068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nUi8eSFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgEDXWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:22:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50094 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgEDXWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:22:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NMJ0q099586;
        Mon, 4 May 2020 23:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=G8Sfe9DjbDriqLwz/H5/NENIeE8ZfW9b4SOVLFoZRWQ=;
 b=nUi8eSFfo0mdNU/Yb42YEGH5Ebt6WrjbOy7a1ekCKx7OxLfR7xkRhW2HVBBFOJqcMW+S
 1jtcm5AugKee0MrC0IXSkmBNuusM29UAhHYTBhI+xceOMBSqwoFxZGpnJBiYCniEVHxZ
 ZxyO9kiyPFLRWe2Tni/lvM9hRUPldLDS4CuBtnb0ZIR3QQKjuB06iQJGnkQN154DhNPA
 uAZHBoNykeNyaARnMNiANjcmi14iffaUlzJ83oslW++XD5DMKhm6cr8TIHgryZVneCKb
 3k58V2kJCUzJNcSN2tH5xl8suYb+MZqkpBDZjdVwBlZtb6rg6E55VkLYsIgGII1ocoNb aQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30s0tm9t0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NLcra139943;
        Mon, 4 May 2020 23:22:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30t1r3j087-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:18 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044NMH85003348;
        Mon, 4 May 2020 23:22:17 GMT
Received: from tomti.i.net-space.pl (/10.175.189.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 16:22:16 -0700
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     grub-devel@gnu.org, linux-kernel@vger.kernel.org,
        trenchboot-devel@googlegroups.com, x86@kernel.org
Cc:     alexander.burmashev@oracle.com, andrew.cooper3@citrix.com,
        ard.biesheuvel@linaro.org, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, javierm@redhat.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, lukasz.hawrylko@linux.intel.com,
        michal.zygowski@3mdeb.com, mjg59@google.com, phcoder@gmail.com,
        pirot.krol@3mdeb.com, pjones@redhat.com, ross.philipson@oracle.com
Subject: [GRUB PATCH RFC 04/18] i386/memory: Rename PAGE_SHIFT to GRUB_PAGE_SHIFT
Date:   Tue,  5 May 2020 01:21:18 +0200
Message-Id: <20200504232132.23570-5-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200504232132.23570-1-daniel.kiper@oracle.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

..to avoid potential conflicts and confusion.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 grub-core/lib/i386/xen/relocator.S   |  6 +++---
 grub-core/lib/x86_64/xen/relocator.S |  4 ++--
 grub-core/loader/i386/xen.c          | 28 ++++++++++++++--------------
 include/grub/i386/memory.h           |  2 +-
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/grub-core/lib/i386/xen/relocator.S b/grub-core/lib/i386/xen/relocator.S
index 96e51b59a..dab4d8ace 100644
--- a/grub-core/lib/i386/xen/relocator.S
+++ b/grub-core/lib/i386/xen/relocator.S
@@ -75,10 +75,10 @@ VARIABLE(grub_relocator_xen_mfn_list)
 	.long	0
 	movl    0(%eax, %ebp, 4), %ecx	/* mfn */
 	movl	%ebp, %ebx
-	shll	$PAGE_SHIFT, %ebx	/* virtual address (1:1 mapping) */
+	shll	$GRUB_PAGE_SHIFT, %ebx	/* virtual address (1:1 mapping) */
 	movl    %ecx, %edx
-	shll    $PAGE_SHIFT,  %ecx	/* prepare pte low part */
-	shrl    $(32 - PAGE_SHIFT),  %edx	/* pte high part */
+	shll    $GRUB_PAGE_SHIFT,  %ecx	/* prepare pte low part */
+	shrl    $(32 - GRUB_PAGE_SHIFT),  %edx	/* pte high part */
 	orl     $(GRUB_PAGE_PRESENT | GRUB_PAGE_USER), %ecx	/* pte low */
 	movl    $UVMF_INVLPG, %esi
 	movl    $__HYPERVISOR_update_va_mapping, %eax
diff --git a/grub-core/lib/x86_64/xen/relocator.S b/grub-core/lib/x86_64/xen/relocator.S
index f5364ed0f..852cd40aa 100644
--- a/grub-core/lib/x86_64/xen/relocator.S
+++ b/grub-core/lib/x86_64/xen/relocator.S
@@ -60,9 +60,9 @@ LOCAL(cont):
 	jz	3f
 2:
 	movq	%r12, %rdi
-	shlq	$PAGE_SHIFT, %rdi	/* virtual address (1:1 mapping) */
+	shlq	$GRUB_PAGE_SHIFT, %rdi	/* virtual address (1:1 mapping) */
 	movq    (%rbx, %r12, 8), %rsi	/* mfn */
-	shlq    $PAGE_SHIFT,  %rsi
+	shlq    $GRUB_PAGE_SHIFT,  %rsi
 	orq     $(GRUB_PAGE_PRESENT | GRUB_PAGE_USER), %rsi	/* Build pte */
 	movq    $UVMF_INVLPG, %rdx
 	movq    %rcx, %r9	/* %rcx clobbered by hypercall */
diff --git a/grub-core/loader/i386/xen.c b/grub-core/loader/i386/xen.c
index 8f662c8ac..fe92874e0 100644
--- a/grub-core/loader/i386/xen.c
+++ b/grub-core/loader/i386/xen.c
@@ -91,7 +91,7 @@ static struct xen_loader_state xen_state;
 
 static grub_dl_t my_mod;
 
-#define PAGE_SIZE (1UL << PAGE_SHIFT)
+#define PAGE_SIZE (1UL << GRUB_PAGE_SHIFT)
 #define MAX_MODULES (PAGE_SIZE / sizeof (struct xen_multiboot_mod_list))
 #define STACK_SIZE 1048576
 #define ADDITIONAL_SIZE (1 << 19)
@@ -102,7 +102,7 @@ static grub_dl_t my_mod;
 static grub_uint64_t
 page2offset (grub_uint64_t page)
 {
-  return page << PAGE_SHIFT;
+  return page << GRUB_PAGE_SHIFT;
 }
 
 static grub_err_t
@@ -141,7 +141,7 @@ get_pgtable_size (grub_uint64_t from, grub_uint64_t to, grub_uint64_t pfn)
 	  continue;
 	}
 
-      bits = PAGE_SHIFT + (i + 1) * LOG_POINTERS_PER_PAGE;
+      bits = GRUB_PAGE_SHIFT + (i + 1) * LOG_POINTERS_PER_PAGE;
       mask = (1ULL << bits) - 1;
       map->lvls[i].virt_start = map->area.virt_start & ~mask;
       map->lvls[i].virt_end = map->area.virt_end | mask;
@@ -246,11 +246,11 @@ generate_page_table (grub_xen_mfn_t *mfn_list)
 	      if (lvl->virt_start >= end || lvl->virt_end <= start)
 		continue;
 	      p_s = (grub_max (start, lvl->virt_start) - start) >>
-		    (PAGE_SHIFT + l * LOG_POINTERS_PER_PAGE);
+		    (GRUB_PAGE_SHIFT + l * LOG_POINTERS_PER_PAGE);
 	      p_e = (grub_min (end, lvl->virt_end) - start) >>
-		    (PAGE_SHIFT + l * LOG_POINTERS_PER_PAGE);
+		    (GRUB_PAGE_SHIFT + l * LOG_POINTERS_PER_PAGE);
 	      pfn = ((grub_max (start, lvl->virt_start) - lvl->virt_start) >>
-		     (PAGE_SHIFT + l * LOG_POINTERS_PER_PAGE)) + lvl->pfn_start;
+		     (GRUB_PAGE_SHIFT + l * LOG_POINTERS_PER_PAGE)) + lvl->pfn_start;
 	      grub_dprintf ("xen", "write page table entries level %d pg %p "
 			    "mapping %d/%d index %lx-%lx pfn %llx\n",
 			    l, pg, m1, m2, p_s, p_e, (unsigned long long) pfn);
@@ -328,16 +328,16 @@ grub_xen_p2m_alloc (void)
     {
       err = get_pgtable_size (xen_state.xen_inf.p2m_base,
 			      xen_state.xen_inf.p2m_base + p2msize,
-			      (xen_state.max_addr + p2msize) >> PAGE_SHIFT);
+			      (xen_state.max_addr + p2msize) >> GRUB_PAGE_SHIFT);
       if (err)
 	return err;
 
-      map->area.pfn_start = xen_state.max_addr >> PAGE_SHIFT;
+      map->area.pfn_start = xen_state.max_addr >> GRUB_PAGE_SHIFT;
       p2malloc = p2msize + page2offset (map->area.n_pt_pages);
       xen_state.n_mappings++;
       xen_state.next_start.mfn_list = xen_state.xen_inf.p2m_base;
       xen_state.next_start.first_p2m_pfn = map->area.pfn_start;
-      xen_state.next_start.nr_p2m_frames = p2malloc >> PAGE_SHIFT;
+      xen_state.next_start.nr_p2m_frames = p2malloc >> GRUB_PAGE_SHIFT;
     }
   else
     {
@@ -380,7 +380,7 @@ grub_xen_special_alloc (void)
   xen_state.virt_start_info = get_virtual_current_address (ch);
   xen_state.max_addr =
     ALIGN_UP (xen_state.max_addr + sizeof (xen_state.next_start), PAGE_SIZE);
-  xen_state.console_pfn = xen_state.max_addr >> PAGE_SHIFT;
+  xen_state.console_pfn = xen_state.max_addr >> GRUB_PAGE_SHIFT;
   xen_state.max_addr += 2 * PAGE_SIZE;
 
   xen_state.next_start.nr_pages = grub_xen_start_page_addr->nr_pages;
@@ -412,7 +412,7 @@ grub_xen_pt_alloc (void)
 
   xen_state.next_start.pt_base =
     xen_state.max_addr + xen_state.xen_inf.virt_base;
-  nr_info_pages = xen_state.max_addr >> PAGE_SHIFT;
+  nr_info_pages = xen_state.max_addr >> GRUB_PAGE_SHIFT;
   nr_need_pages = nr_info_pages;
 
   while (1)
@@ -460,7 +460,7 @@ grub_xen_pt_alloc (void)
     xen_state.max_addr + STACK_SIZE + xen_state.xen_inf.virt_base;
   xen_state.next_start.nr_pt_frames = nr_need_pages;
   xen_state.max_addr = try_virt_end - xen_state.xen_inf.virt_base;
-  xen_state.pgtbl_end = xen_state.max_addr >> PAGE_SHIFT;
+  xen_state.pgtbl_end = xen_state.max_addr >> GRUB_PAGE_SHIFT;
   xen_state.map_reloc->where = (grub_uint64_t *) ((char *) map->where +
 					page2offset (map->area.n_pt_pages));
 
@@ -514,7 +514,7 @@ grub_xen_boot (void)
   if (err)
     return err;
 
-  nr_pages = xen_state.max_addr >> PAGE_SHIFT;
+  nr_pages = xen_state.max_addr >> GRUB_PAGE_SHIFT;
 
   grub_dprintf ("xen", "bootstrap domain %llx+%llx\n",
 		(unsigned long long) xen_state.xen_inf.virt_base,
@@ -811,7 +811,7 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
   if (xen_state.xen_inf.unmapped_initrd)
     {
       xen_state.next_start.flags |= SIF_MOD_START_PFN;
-      xen_state.next_start.mod_start = xen_state.max_addr >> PAGE_SHIFT;
+      xen_state.next_start.mod_start = xen_state.max_addr >> GRUB_PAGE_SHIFT;
     }
   else
     xen_state.next_start.mod_start =
diff --git a/include/grub/i386/memory.h b/include/grub/i386/memory.h
index 5cb607fb4..7be57d6d7 100644
--- a/include/grub/i386/memory.h
+++ b/include/grub/i386/memory.h
@@ -20,7 +20,7 @@
 #ifndef GRUB_MEMORY_CPU_HEADER
 #define GRUB_MEMORY_CPU_HEADER	1
 
-#define PAGE_SHIFT		12
+#define GRUB_PAGE_SHIFT		12
 
 /* The flag for protected mode.  */
 #define GRUB_MEMORY_CPU_CR0_PE_ON		0x1
-- 
2.11.0

