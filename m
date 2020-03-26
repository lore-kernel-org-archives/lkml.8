Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97463C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651AF20737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="k9Ab71Xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgCZDYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:24:50 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41290 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgCZDYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:49 -0400
Received: by mail-qv1-f68.google.com with SMTP id o7so2268843qvq.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=CuDr5qYI6GlVY7shRkQ5EEeBFfzJFE9mbrZpS9eu2hQ=;
        b=k9Ab71XtQB4E3Bo3yPvSRsgc6cg7BdCEUZQt3yKAdiPxDjmADIKr8GdGF5S7Z3a5Ah
         rNYbsEruPq1t8nZXb0xuXVlx2JWWoe/a72sEW5hTQBaNY677SAb1LGa/f5l6BIqyeqgG
         eivitYpBTw3+tss381Da/ah6BbrepWmF+R118dYCkh/zXBrZiBMXTlPt3Fb8OIp6c0mu
         xfZdJN1JkoYMNNpPPERjqGte2DtVAtcsVsxd6/Eatw/TjCMTo29rL0YxqfMoerpQ73am
         XG5zeqNhqa2/0MqkudJRTb1yIkKTce404h2QZGyCAgfu0FyF9yl7XL0MtFu94R6xijCI
         3EbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=CuDr5qYI6GlVY7shRkQ5EEeBFfzJFE9mbrZpS9eu2hQ=;
        b=rAr7AYW20U0MTePFIgWdCbHwWF16DKo8zVjyhIX+8/q45u6+2TYGb+dKFQpJ2HF5yn
         VTG7vlHa8au0fy3rOHrwwim4UkQOk+gQD4quDqrUxbyAwfH4zmpDqJ/yBuIG0yNdOab3
         wLh/shcrUQ9+HUDKwSb1gFFoK9Htyde5+Q4QgCZm+9JN1Wtz9HwOW+F5zMkmTSwrYE48
         93NVpNHMFTvJjV6rvxwXW0qdBF9BacN3Lg8O//ZGdOF1slIT9Nq+P3x7VHsjkZSVxAov
         onrZooHQyLrQO9msJ9S6evDHZt8pzgpbUpiWj4XNM9Q8YzM/3wg9TdMkdrl/RrFs7U8A
         /rqg==
X-Gm-Message-State: ANhLgQ0/+EWZ5S84+cQSBA+sC7sQTeLhBPygRgRSduCH/iC9YCx2cY0U
        n3SIDWqtEftAqKtpnmh3V/dvjFHg4C4=
X-Google-Smtp-Source: ADFU+vt6UIEixLCExT8KxYiu1rT68zpEIs/PcykYXkt1mnb3MyWxWvCSpYV+q14Kv0orn+Tr3gtsYw==
X-Received: by 2002:a0c:ac48:: with SMTP id m8mr6284600qvb.13.1585193087675;
        Wed, 25 Mar 2020 20:24:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm620034qka.35.2020.03.25.20.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 20:24:47 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de, selindag@gmail.com
Subject: [PATCH v9 16/18] arm64: kexec: configure trans_pgd page table for kexec
Date:   Wed, 25 Mar 2020 23:24:18 -0400
Message-Id: <20200326032420.27220-17-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326032420.27220-1-pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure a page table located in kexec-safe memory that has
the following mappings:

1. identity mapping for text of relocation function with executable
   permission.
2. linear mappings for all source ranges
3. linear mappings for all destination ranges.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    | 12 ++++
 arch/arm64/kernel/asm-offsets.c   |  6 ++
 arch/arm64/kernel/machine_kexec.c | 92 ++++++++++++++++++++++++++++++-
 3 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 0f758fd51518..8f4332ac607a 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -108,6 +108,12 @@ extern const unsigned long kexec_el2_vectors_offset;
  * el2_vector	If present means that relocation routine will go to EL1
  *		from EL2 to do the copy, and then back to EL2 to do the jump
  *		to new world.
+ * trans_ttbr0	idmap for relocation function and its argument
+ * trans_ttbr1	linear map for source/destination addresses.
+ * trans_t0sz	t0sz for idmap page in trans_ttbr0
+ * src_addr	linear map for source pages.
+ * dst_addr	linear map for destination pages.
+ * copy_len	Number of bytes that need to be copied
  */
 struct kern_reloc_arg {
 	phys_addr_t head;
@@ -117,6 +123,12 @@ struct kern_reloc_arg {
 	phys_addr_t kern_arg2;
 	phys_addr_t kern_arg3;
 	phys_addr_t el2_vector;
+	phys_addr_t trans_ttbr0;
+	phys_addr_t trans_ttbr1;
+	unsigned long trans_t0sz;
+	unsigned long src_addr;
+	unsigned long dst_addr;
+	unsigned long copy_len;
 };
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index ff974b648347..58ad5b7816ab 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -137,6 +137,12 @@ int main(void)
   DEFINE(KEXEC_KRELOC_KERN_ARG2,	offsetof(struct kern_reloc_arg, kern_arg2));
   DEFINE(KEXEC_KRELOC_KERN_ARG3,	offsetof(struct kern_reloc_arg, kern_arg3));
   DEFINE(KEXEC_KRELOC_EL2_VECTOR,	offsetof(struct kern_reloc_arg, el2_vector));
+  DEFINE(KEXEC_KRELOC_TRANS_TTBR0,	offsetof(struct kern_reloc_arg, trans_ttbr0));
+  DEFINE(KEXEC_KRELOC_TRANS_TTBR1,	offsetof(struct kern_reloc_arg, trans_ttbr1));
+  DEFINE(KEXEC_KRELOC_TRANS_T0SZ,	offsetof(struct kern_reloc_arg, trans_t0sz));
+  DEFINE(KEXEC_KRELOC_SRC_ADDR,	offsetof(struct kern_reloc_arg, src_addr));
+  DEFINE(KEXEC_KRELOC_DST_ADDR,	offsetof(struct kern_reloc_arg, dst_addr));
+  DEFINE(KEXEC_KRELOC_COPY_LEN,	offsetof(struct kern_reloc_arg, copy_len));
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index bd398def7627..db96d2fab8b2 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -20,6 +20,7 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
+#include <asm/trans_pgd.h>
 
 #include "cpu-reset.h"
 
@@ -70,10 +71,90 @@ static void *kexec_page_alloc(void *arg)
 	return page_address(page);
 }
 
+/*
+ * Map source segments starting from src_va, and map destination
+ * segments starting from dst_va, and return size of copy in
+ * *copy_len argument.
+ * Relocation function essentially needs to do:
+ * memcpy(dst_va, src_va, copy_len);
+ */
+static int map_segments(struct kimage *kimage, pgd_t *pgdp,
+			struct trans_pgd_info *info,
+			unsigned long src_va,
+			unsigned long dst_va,
+			unsigned long *copy_len)
+{
+	unsigned long *ptr = 0;
+	unsigned long dest = 0;
+	unsigned long len = 0;
+	unsigned long entry, addr;
+	int rc;
+
+	for (entry = kimage->head; !(entry & IND_DONE); entry = *ptr++) {
+		addr = entry & PAGE_MASK;
+
+		switch (entry & IND_FLAGS) {
+		case IND_DESTINATION:
+			dest = addr;
+			break;
+		case IND_INDIRECTION:
+			ptr = __va(addr);
+			if (rc)
+				return rc;
+			break;
+		case IND_SOURCE:
+			rc = trans_pgd_map_page(info, pgdp, __va(addr),
+						src_va, PAGE_KERNEL);
+			if (rc)
+				return rc;
+			rc = trans_pgd_map_page(info, pgdp, __va(dest),
+						dst_va, PAGE_KERNEL);
+			if (rc)
+				return rc;
+			dest += PAGE_SIZE;
+			src_va += PAGE_SIZE;
+			dst_va += PAGE_SIZE;
+			len += PAGE_SIZE;
+		}
+	}
+	*copy_len = len;
+
+	return 0;
+}
+
+static int mmu_relocate_setup(struct kimage *kimage, void *reloc_code,
+			      struct kern_reloc_arg *kern_reloc_arg)
+{
+	struct trans_pgd_info info = {
+		.trans_alloc_page	= kexec_page_alloc,
+		.trans_alloc_arg	= kimage,
+	};
+	pgd_t *trans_pgd = kexec_page_alloc(kimage);
+	int rc;
+
+	if (!trans_pgd)
+		return -ENOMEM;
+
+	/* idmap relocation function */
+	rc = trans_pgd_idmap_page(&info, &kern_reloc_arg->trans_ttbr0,
+				  &kern_reloc_arg->trans_t0sz, reloc_code);
+	if (rc)
+		return rc;
+
+	kern_reloc_arg->src_addr = _PAGE_OFFSET(VA_BITS_MIN);
+	kern_reloc_arg->dst_addr = _PAGE_OFFSET(VA_BITS_MIN - 1);
+	kern_reloc_arg->trans_ttbr1 = phys_to_ttbr(__pa(trans_pgd));
+
+	rc = map_segments(kimage, trans_pgd, &info, kern_reloc_arg->src_addr,
+			  kern_reloc_arg->dst_addr, &kern_reloc_arg->copy_len);
+	return rc;
+}
+
 int machine_kexec_post_load(struct kimage *kimage)
 {
 	void *reloc_code = page_to_virt(kimage->control_code_page);
 	struct kern_reloc_arg *kern_reloc_arg = kexec_page_alloc(kimage);
+	int rc = 0;
 
 	if (!kern_reloc_arg)
 		return -ENOMEM;
@@ -89,9 +170,18 @@ int machine_kexec_post_load(struct kimage *kimage)
 		kern_reloc_arg->el2_vector = __pa(reloc_code)
 						+ kexec_el2_vectors_offset;
 	}
+
+	/*
+	 * If relocation is not needed, we do not need to enable MMU in
+	 * relocation routine, therefore do not create page tables for
+	 * scenarios such as crash kernel
+	 */
+	if (!(kimage->head & IND_DONE))
+		rc = mmu_relocate_setup(kimage, reloc_code, kern_reloc_arg);
+
 	kexec_image_info(kimage);
 
-	return 0;
+	return rc;
 }
 
 /**
-- 
2.17.1

