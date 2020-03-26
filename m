Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D540AC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45F6208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ORP3E/Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgCZDYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:24:44 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41100 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgCZDYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id i3so4177225qtv.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=+QNwRXfDbgmdgwiAWzmJWWFV3AeWwC/BkLzCJNBiX7U=;
        b=ORP3E/ZpEgE98OIaAPSZGFAcOrHLCH0OZ+6B4Q98GVNlw635eAenr+Qr6UJfPlzHZY
         zwcjqMKnATW+Tkpb6om6vwznhxUoKQpNie7bBYkPOzThhNddYDKgHOwX1j7FKdprMZ0j
         slzaC/miPXlNVoqvbDQpi0b1b9HhU+3trTqExs8FfHkN9BTVYlurgItTUgg9mBvJ/4jM
         0eHkcBTq+tojnVx3RUoQkWgoO5ZREG01eZNlkd5JbuMNwpM2SmzDSMHd+kD3UHLh17E6
         4hX9u/EVkhq/ryWZUCX7I4vUDngpM8dJCfXmmrYvQCPvj4Vx6r9X4yNAf0rTcJ2FxFIa
         i0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=+QNwRXfDbgmdgwiAWzmJWWFV3AeWwC/BkLzCJNBiX7U=;
        b=jcethw40GFVIl7D8Ou9VXzy8AQm9pZmBYJJs60JVN8AGdTI6xhbFsGzGiaWLLRKHp4
         HtOdl7yn9HDi4e7AFcoOTL3ofPB8XUgShAPvPapOHPNePYCG/U+gBa+0h7omGLTDVjfn
         3XI5kpehO9nZzzro5RbF0/byImt34CcczQIuRvPeojcObgaV+ioNe2jvH/IvF1HKvEVr
         OMqVOBN30A0C9J2tbgMX05B5IAeOwAYK6mETzSzGvyIrP6IKmGDCqtLeYSIaMwiWRHBg
         2DgE4czHN8vIbcaHjW4hGZEQjjpcwfw7rCTXOLU2ZzMn4/RSXokhhW2bBVq1lBA/E9pQ
         lS7w==
X-Gm-Message-State: ANhLgQ3FdqNxeblUFDuk4ZnZ/8EHktunknIlvP3Lv/2r7KXpmp2tNcHU
        uxjVLj4aIznYSv98cICkNQeq+g==
X-Google-Smtp-Source: ADFU+vtbKYyEZjxHqMRMqVkHzcW5e1lkwXuYNftBecpITpTgyTzGVt02JTYGpZDymXDfWspDslX4ZA==
X-Received: by 2002:ac8:4641:: with SMTP id f1mr5868894qto.216.1585193081247;
        Wed, 25 Mar 2020 20:24:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm620034qka.35.2020.03.25.20.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 20:24:40 -0700 (PDT)
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
Subject: [PATCH v9 12/18] arm64: kexec: arm64_relocate_new_kernel don't use x0 as temp
Date:   Wed, 25 Mar 2020 23:24:14 -0400
Message-Id: <20200326032420.27220-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326032420.27220-1-pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x0 will contain the only argument to arm64_relocate_new_kernel; don't
use it as a temp. Reassigned registers to free-up x0.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/relocate_kernel.S | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index e9c974ea4717..41f9c95fabe8 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -32,14 +32,14 @@ ENTRY(arm64_relocate_new_kernel)
 	mov	x14, xzr			/* x14 = entry ptr */
 	mov	x13, xzr			/* x13 = copy dest */
 	/* Clear the sctlr_el2 flags. */
-	mrs	x0, CurrentEL
-	cmp	x0, #CurrentEL_EL2
+	mrs	x2, CurrentEL
+	cmp	x2, #CurrentEL_EL2
 	b.ne	1f
-	mrs	x0, sctlr_el2
+	mrs	x2, sctlr_el2
 	ldr	x1, =SCTLR_ELx_FLAGS
-	bic	x0, x0, x1
+	bic	x2, x2, x1
 	pre_disable_mmu_workaround
-	msr	sctlr_el2, x0
+	msr	sctlr_el2, x2
 	isb
 1:	/* Check if the new image needs relocation. */
 	tbnz	x16, IND_DONE_BIT, .Ldone
@@ -51,17 +51,17 @@ ENTRY(arm64_relocate_new_kernel)
 	tbz	x16, IND_SOURCE_BIT, .Ltest_indirection
 
 	/* Invalidate dest page to PoC. */
-	mov     x0, x13
-	add     x20, x0, #PAGE_SIZE
+	mov     x2, x13
+	add     x20, x2, #PAGE_SIZE
 	sub     x1, x15, #1
-	bic     x0, x0, x1
-2:	dc      ivac, x0
-	add     x0, x0, x15
-	cmp     x0, x20
+	bic     x2, x2, x1
+2:	dc      ivac, x2
+	add     x2, x2, x15
+	cmp     x2, x20
 	b.lo    2b
 	dsb     sy
 
-	copy_page x13, x12, x0, x1, x2, x3, x4, x5, x6, x7
+	copy_page x13, x12, x1, x2, x3, x4, x5, x6, x7, x8
 	b	.Lnext
 .Ltest_indirection:
 	tbz	x16, IND_INDIRECTION_BIT, .Ltest_destination
-- 
2.17.1

