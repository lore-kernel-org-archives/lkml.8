Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9EFC2D0EB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA1F2078E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hZ1nGrOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgCZDYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:24:42 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:38596 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgCZDYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:41 -0400
Received: by mail-qv1-f66.google.com with SMTP id p60so2273460qva.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=1sXDoN/0mmZM9G5VQCpkVjfGjiuUeqm4crDPDAsOHEU=;
        b=hZ1nGrOxfoCkdXKc9+oZYoV6RJjuD0p9MZ71hvhqEwktdZnAwhR8USNLiMMRIzSvr8
         4dAJ/Qng+EqH/L8T2YvB4diRuMDjG8aZxC4mjh9wwPRlw8w9bC1mrL4ws1P1gNp1rrFC
         +6eJ30RkDIe+pX9uULUN79m18FbctcvvLI2V9cXNwu8BPRGzawYOQHRShV8Zj6cPtESq
         GiSdQsysD/DhROSextRE98zpT3/oBWuPBIYd6SHJz6h1TTiDD4AXO0ACo8fzX9tda8qI
         oBpxusITsP9ivVZ3u/IZXPd6nii4qA0Rm9hatT59/XhM1por3EzgpjRaN/m7SLvbs7Sv
         rZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=1sXDoN/0mmZM9G5VQCpkVjfGjiuUeqm4crDPDAsOHEU=;
        b=SHPBoySyV9q+PnLDB/Ns6Wfz5NsSXfiJDOjHfIznJ5ROT0F309MV9SWrzOuEBBlDl5
         VuimUzOMnEEUJL8nHOARMvmT3ntPBUTbgk6Qb1Kq5OibDlIcnmYkvl43n6UG6F/0ONGI
         cOw2vftxCR5sDZ3Vj/WSmY+69iiN9pWmVSvcQImFLGPAJ39eqzsmnYFdIHsNjEoJbBZy
         m7VyMNpCvM6UQOQ59v1O8XEuYhYAFB8S/8OvnTEC1TTd+bv03jBrkazuwtogFZGzHTO1
         aY+rvuWWY8HhjqKG2lKY8BCR8wmuVfEbem8NHc27aZI4dgcV1R7gKGCvZ29/ZMbMJ0BL
         RiRg==
X-Gm-Message-State: ANhLgQ2JdDkuUasUq8ImL7LZroFlXgTjHFzWJlPrUjqNkQ5PRi8j7r2n
        h5LQY2RLSj7Z7Dvy5YPVZ8qb2g==
X-Google-Smtp-Source: ADFU+vuHBal1QvkuYASS6ow0XdJSQnH9DVYSoMN2LDG8Rk9VPDx+WBVW2GkTO+Nv+BgfPUM8flR07w==
X-Received: by 2002:a05:6214:11f4:: with SMTP id e20mr6354087qvu.66.1585193079735;
        Wed, 25 Mar 2020 20:24:39 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm620034qka.35.2020.03.25.20.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 20:24:39 -0700 (PDT)
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
Subject: [PATCH v9 11/18] arm64: kexec: arm64_relocate_new_kernel clean-ups
Date:   Wed, 25 Mar 2020 23:24:13 -0400
Message-Id: <20200326032420.27220-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326032420.27220-1-pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove excessive empty lines from arm64_relocate_new_kernel.
Also, use comments on the same lines with instructions where
appropriate.

Change ENDPROC to END it never returns.

copy_page(dest, src, tmps...)
Increments dest and src by PAGE_SIZE, so no need to store dest
prior to calling copy_page and increment it after. Also, src is not
used after a copy, not need to copy either.

Call raw_dcache_line_size()  only when relocation is actually going to
happen.

Since '.align 3' is intended to align globals at the end of the file,
move it there.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/relocate_kernel.S | 50 +++++++----------------------
 1 file changed, 11 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index c1d7db71a726..e9c974ea4717 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -8,7 +8,6 @@
 
 #include <linux/kexec.h>
 #include <linux/linkage.h>
-
 #include <asm/assembler.h>
 #include <asm/kexec.h>
 #include <asm/page.h>
@@ -17,25 +16,21 @@
 /*
  * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
  *
- * The memory that the old kernel occupies may be overwritten when coping the
+ * The memory that the old kernel occupies may be overwritten when copying the
  * new image to its final location.  To assure that the
  * arm64_relocate_new_kernel routine which does that copy is not overwritten,
  * all code and data needed by arm64_relocate_new_kernel must be between the
  * symbols arm64_relocate_new_kernel and arm64_relocate_new_kernel_end.  The
  * machine_kexec() routine will copy arm64_relocate_new_kernel to the kexec
- * control_code_page, a special page which has been set up to be preserved
- * during the copy operation.
+ * safe memory that has been set up to be preserved during the copy operation.
  */
 ENTRY(arm64_relocate_new_kernel)
-
 	/* Setup the list loop variables. */
 	mov	x18, x2				/* x18 = dtb address */
 	mov	x17, x1				/* x17 = kimage_start */
 	mov	x16, x0				/* x16 = kimage_head */
-	raw_dcache_line_size x15, x0		/* x15 = dcache line size */
 	mov	x14, xzr			/* x14 = entry ptr */
 	mov	x13, xzr			/* x13 = copy dest */
-
 	/* Clear the sctlr_el2 flags. */
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
@@ -46,14 +41,11 @@ ENTRY(arm64_relocate_new_kernel)
 	pre_disable_mmu_workaround
 	msr	sctlr_el2, x0
 	isb
-1:
-
-	/* Check if the new image needs relocation. */
+1:	/* Check if the new image needs relocation. */
 	tbnz	x16, IND_DONE_BIT, .Ldone
-
+	raw_dcache_line_size x15, x1		/* x15 = dcache line size */
 .Lloop:
 	and	x12, x16, PAGE_MASK		/* x12 = addr */
-
 	/* Test the entry flags. */
 .Ltest_source:
 	tbz	x16, IND_SOURCE_BIT, .Ltest_indirection
@@ -69,34 +61,18 @@ ENTRY(arm64_relocate_new_kernel)
 	b.lo    2b
 	dsb     sy
 
-	mov x20, x13
-	mov x21, x12
-	copy_page x20, x21, x0, x1, x2, x3, x4, x5, x6, x7
-
-	/* dest += PAGE_SIZE */
-	add	x13, x13, PAGE_SIZE
+	copy_page x13, x12, x0, x1, x2, x3, x4, x5, x6, x7
 	b	.Lnext
-
 .Ltest_indirection:
 	tbz	x16, IND_INDIRECTION_BIT, .Ltest_destination
-
-	/* ptr = addr */
-	mov	x14, x12
+	mov	x14, x12			/* ptr = addr */
 	b	.Lnext
-
 .Ltest_destination:
 	tbz	x16, IND_DESTINATION_BIT, .Lnext
-
-	/* dest = addr */
-	mov	x13, x12
-
+	mov	x13, x12			/* dest = addr */
 .Lnext:
-	/* entry = *ptr++ */
-	ldr	x16, [x14], #8
-
-	/* while (!(entry & DONE)) */
-	tbz	x16, IND_DONE_BIT, .Lloop
-
+	ldr	x16, [x14], #8			/* entry = *ptr++ */
+	tbz	x16, IND_DONE_BIT, .Lloop	/* while (!(entry & DONE)) */
 .Ldone:
 	/* wait for writes from copy_page to finish */
 	dsb	nsh
@@ -110,16 +86,12 @@ ENTRY(arm64_relocate_new_kernel)
 	mov	x2, xzr
 	mov	x3, xzr
 	br	x17
-
-ENDPROC(arm64_relocate_new_kernel)
-
 .ltorg
-
-.align 3	/* To keep the 64-bit values below naturally aligned. */
+END(arm64_relocate_new_kernel)
 
 .Lcopy_end:
 .org	KEXEC_CONTROL_PAGE_SIZE
-
+.align 3	/* To keep the 64-bit values below naturally aligned. */
 /*
  * arm64_relocate_new_kernel_size - Number of bytes to copy to the
  * control_code_page.
-- 
2.17.1

