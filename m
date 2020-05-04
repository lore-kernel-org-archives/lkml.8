Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239C0C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF75220663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pl5ygeoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgEDXWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:22:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38556 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgEDXWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:22:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NJaU3187879;
        Mon, 4 May 2020 23:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=OkVKaRKTdAh7CvwJshZdXoXHVpHPdaBHw56QtZ3s47w=;
 b=Pl5ygeoGd/AsGUpcbATy8VAQjXmlrKZ/U5uTsOGBpX7YX+OUKbGTZxF0yTFVbOv0To2W
 rhpksEVoLl70CNP2iL443Xko3BOIX/X2yXarNAclWYJqKlKsAaNKWV2Vex9U1UG3133T
 Iq8XjFyB4N4dYwptManTAIZTYxfz+lRB6D23GQ9aKZvrQmtgaeLAxFXQbNCPRuUF4+Q9
 CQDWEMLnhVA5qZM8PbOTP2o3JPXTJkRFb4RWZwBgNufEzvq/oMDMG1RiRS/U7lRZTa37
 nKrXiMWU0rRD3IYU3T1IzdEyAthZSOzZgCOOheSqkwFTYb4/4OliFPzc18Lk8Y2nuoKm Ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30s09r1uxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NHKAM030664;
        Mon, 4 May 2020 23:22:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30sjncbbha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:23 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044NML25003375;
        Mon, 4 May 2020 23:22:22 GMT
Received: from tomti.i.net-space.pl (/10.175.189.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 16:22:21 -0700
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
Subject: [GRUB PATCH RFC 05/18] i386/memory: Rename PAGE_SIZE to GRUB_PAGE_SIZE and make it global
Date:   Tue,  5 May 2020 01:21:19 +0200
Message-Id: <20200504232132.23570-6-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200504232132.23570-1-daniel.kiper@oracle.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040181
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsequent patches will use that constant.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 grub-core/loader/i386/xen.c | 35 +++++++++++++++++------------------
 include/grub/i386/memory.h  |  1 +
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/grub-core/loader/i386/xen.c b/grub-core/loader/i386/xen.c
index fe92874e0..dfdddfeed 100644
--- a/grub-core/loader/i386/xen.c
+++ b/grub-core/loader/i386/xen.c
@@ -91,8 +91,7 @@ static struct xen_loader_state xen_state;
 
 static grub_dl_t my_mod;
 
-#define PAGE_SIZE (1UL << GRUB_PAGE_SHIFT)
-#define MAX_MODULES (PAGE_SIZE / sizeof (struct xen_multiboot_mod_list))
+#define MAX_MODULES (GRUB_PAGE_SIZE / sizeof (struct xen_multiboot_mod_list))
 #define STACK_SIZE 1048576
 #define ADDITIONAL_SIZE (1 << 19)
 #define ALIGN_SIZE (1 << 22)
@@ -228,7 +227,7 @@ generate_page_table (grub_xen_mfn_t *mfn_list)
 
   for (m1 = 0; m1 < xen_state.n_mappings; m1++)
     grub_memset (xen_state.mappings[m1].where, 0,
-		 xen_state.mappings[m1].area.n_pt_pages * PAGE_SIZE);
+		 xen_state.mappings[m1].area.n_pt_pages * GRUB_PAGE_SIZE);
 
   for (l = NUMBER_OF_LEVELS - 1; l >= 0; l--)
     {
@@ -323,7 +322,7 @@ grub_xen_p2m_alloc (void)
 
   map = xen_state.mappings + xen_state.n_mappings;
   p2msize = ALIGN_UP (sizeof (grub_xen_mfn_t) *
-		      grub_xen_start_page_addr->nr_pages, PAGE_SIZE);
+		      grub_xen_start_page_addr->nr_pages, GRUB_PAGE_SIZE);
   if (xen_state.xen_inf.has_p2m_base)
     {
       err = get_pgtable_size (xen_state.xen_inf.p2m_base,
@@ -379,9 +378,9 @@ grub_xen_special_alloc (void)
   xen_state.state.start_info = xen_state.max_addr + xen_state.xen_inf.virt_base;
   xen_state.virt_start_info = get_virtual_current_address (ch);
   xen_state.max_addr =
-    ALIGN_UP (xen_state.max_addr + sizeof (xen_state.next_start), PAGE_SIZE);
+    ALIGN_UP (xen_state.max_addr + sizeof (xen_state.next_start), GRUB_PAGE_SIZE);
   xen_state.console_pfn = xen_state.max_addr >> GRUB_PAGE_SHIFT;
-  xen_state.max_addr += 2 * PAGE_SIZE;
+  xen_state.max_addr += 2 * GRUB_PAGE_SIZE;
 
   xen_state.next_start.nr_pages = grub_xen_start_page_addr->nr_pages;
   grub_memcpy (xen_state.next_start.magic, grub_xen_start_page_addr->magic,
@@ -430,9 +429,9 @@ grub_xen_pt_alloc (void)
       /* Map the relocator page either at virtual 0 or after end of area. */
       nr_need_pages = nr_info_pages + map->area.n_pt_pages;
       if (xen_state.xen_inf.virt_base)
-	err = get_pgtable_size (0, PAGE_SIZE, nr_need_pages);
+	err = get_pgtable_size (0, GRUB_PAGE_SIZE, nr_need_pages);
       else
-	err = get_pgtable_size (try_virt_end, try_virt_end + PAGE_SIZE,
+	err = get_pgtable_size (try_virt_end, try_virt_end + GRUB_PAGE_SIZE,
 				nr_need_pages);
       if (err)
 	return err;
@@ -537,7 +536,7 @@ grub_xen_boot (void)
 
   return grub_relocator_xen_boot (xen_state.relocator, xen_state.state, nr_pages,
 				  xen_state.xen_inf.virt_base <
-				  PAGE_SIZE ? page2offset (nr_pages) : 0,
+				  GRUB_PAGE_SIZE ? page2offset (nr_pages) : 0,
 				  xen_state.pgtbl_end - 1,
 				  page2offset (xen_state.pgtbl_end - 1) +
 				  xen_state.xen_inf.virt_base);
@@ -675,7 +674,7 @@ grub_cmd_xen (grub_command_t cmd __attribute__ ((unused)),
       goto fail;
     }
 
-  if (xen_state.xen_inf.virt_base & (PAGE_SIZE - 1))
+  if (xen_state.xen_inf.virt_base & (GRUB_PAGE_SIZE - 1))
     {
       grub_error (GRUB_ERR_BAD_OS, "unaligned virt_base");
       goto fail;
@@ -698,10 +697,10 @@ grub_cmd_xen (grub_command_t cmd __attribute__ ((unused)),
       kern_start = grub_min (kern_start, xen_state.xen_inf.hypercall_page -
 					 xen_state.xen_inf.virt_base);
       kern_end = grub_max (kern_end, xen_state.xen_inf.hypercall_page -
-				     xen_state.xen_inf.virt_base + PAGE_SIZE);
+				     xen_state.xen_inf.virt_base + GRUB_PAGE_SIZE);
     }
 
-  xen_state.max_addr = ALIGN_UP (kern_end, PAGE_SIZE);
+  xen_state.max_addr = ALIGN_UP (kern_end, GRUB_PAGE_SIZE);
 
   err = grub_relocator_alloc_chunk_addr (xen_state.relocator, &ch, kern_start,
 					 kern_end - kern_start);
@@ -722,7 +721,7 @@ grub_cmd_xen (grub_command_t cmd __attribute__ ((unused)),
   if (xen_state.xen_inf.has_hypercall_page)
     {
       unsigned i;
-      for (i = 0; i < PAGE_SIZE / HYPERCALL_INTERFACE_SIZE; i++)
+      for (i = 0; i < GRUB_PAGE_SIZE / HYPERCALL_INTERFACE_SIZE; i++)
 	set_hypercall_interface ((grub_uint8_t *) kern_chunk_src +
 				 i * HYPERCALL_INTERFACE_SIZE +
 				 xen_state.xen_inf.hypercall_page -
@@ -821,7 +820,7 @@ grub_cmd_initrd (grub_command_t cmd __attribute__ ((unused)),
 		(unsigned) (xen_state.max_addr + xen_state.xen_inf.virt_base),
 		(unsigned) size);
 
-  xen_state.max_addr = ALIGN_UP (xen_state.max_addr + size, PAGE_SIZE);
+  xen_state.max_addr = ALIGN_UP (xen_state.max_addr + size, GRUB_PAGE_SIZE);
 
 fail:
   grub_initrd_close (&initrd_ctx);
@@ -875,7 +874,7 @@ grub_cmd_module (grub_command_t cmd __attribute__ ((unused)),
     {
       xen_state.xen_inf.unmapped_initrd = 0;
       xen_state.n_modules = 0;
-      xen_state.max_addr = ALIGN_UP (xen_state.max_addr, PAGE_SIZE);
+      xen_state.max_addr = ALIGN_UP (xen_state.max_addr, GRUB_PAGE_SIZE);
       xen_state.modules_target_start = xen_state.max_addr;
       xen_state.next_start.mod_start =
 	xen_state.max_addr + xen_state.xen_inf.virt_base;
@@ -895,7 +894,7 @@ grub_cmd_module (grub_command_t cmd __attribute__ ((unused)),
 	MAX_MODULES * sizeof (xen_state.module_info_page[0]);
     }
 
-  xen_state.max_addr = ALIGN_UP (xen_state.max_addr, PAGE_SIZE);
+  xen_state.max_addr = ALIGN_UP (xen_state.max_addr, GRUB_PAGE_SIZE);
 
   file = grub_file_open (argv[0], GRUB_FILE_TYPE_LINUX_INITRD |
 			 (nounzip ? GRUB_FILE_TYPE_NO_DECOMPRESS : GRUB_FILE_TYPE_NONE));
@@ -918,7 +917,7 @@ grub_cmd_module (grub_command_t cmd __attribute__ ((unused)),
 
   xen_state.module_info_page[xen_state.n_modules].cmdline =
     xen_state.max_addr - xen_state.modules_target_start;
-  xen_state.max_addr = ALIGN_UP (xen_state.max_addr + cmdline_len, PAGE_SIZE);
+  xen_state.max_addr = ALIGN_UP (xen_state.max_addr + cmdline_len, GRUB_PAGE_SIZE);
 
   if (size)
     {
@@ -945,7 +944,7 @@ grub_cmd_module (grub_command_t cmd __attribute__ ((unused)),
   xen_state.n_modules++;
   grub_dprintf ("xen", "module, addr=0x%x, size=0x%x\n",
 		(unsigned) xen_state.max_addr, (unsigned) size);
-  xen_state.max_addr = ALIGN_UP (xen_state.max_addr + size, PAGE_SIZE);
+  xen_state.max_addr = ALIGN_UP (xen_state.max_addr + size, GRUB_PAGE_SIZE);
 
 
 fail:
diff --git a/include/grub/i386/memory.h b/include/grub/i386/memory.h
index 7be57d6d7..c64529630 100644
--- a/include/grub/i386/memory.h
+++ b/include/grub/i386/memory.h
@@ -21,6 +21,7 @@
 #define GRUB_MEMORY_CPU_HEADER	1
 
 #define GRUB_PAGE_SHIFT		12
+#define GRUB_PAGE_SIZE		(1UL << GRUB_PAGE_SHIFT)
 
 /* The flag for protected mode.  */
 #define GRUB_MEMORY_CPU_CR0_PE_ON		0x1
-- 
2.11.0

