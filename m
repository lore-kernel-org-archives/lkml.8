Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B7AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91ED206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgF3TtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:49:11 -0400
Received: from foss.arm.com ([217.140.110.172]:33012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbgF3TtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:49:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D8D631B;
        Tue, 30 Jun 2020 12:48:59 -0700 (PDT)
Received: from seattle-bionic.arm.com.Home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80BDC3F73C;
        Tue, 30 Jun 2020 12:48:58 -0700 (PDT)
From:   Oliver Swede <oli.swede@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/14] arm64: Improve accuracy of fixup for UAO cases
Date:   Tue, 30 Jun 2020 19:48:22 +0000
Message-Id: <20200630194822.1082-15-oli.swede@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630194822.1082-1-oli.swede@arm.com>
References: <20200630194822.1082-1-oli.swede@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This accounts for variations in the number of bytes copied to the
destination buffer that could result from the substitution of
STP instructions with 2x unprivileged STTR variants if UAO is
supported and enabled.

Rather than duplicating the store fixups with the modifications,
the relevant alternatives are inserted in-line.

Signed-off-by: Oliver Swede <oli.swede@arm.com>
---
 arch/arm64/lib/copy_user_fixup.S | 47 ++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/lib/copy_user_fixup.S b/arch/arm64/lib/copy_user_fixup.S
index 37ca3d99a02a..2d413f9ba5d3 100644
--- a/arch/arm64/lib/copy_user_fixup.S
+++ b/arch/arm64/lib/copy_user_fixup.S
@@ -205,7 +205,12 @@ addr	.req	x15
 	/* 32 < count < 128 -> count - ((addr-dst)&15) */
 	cmp	count, 128
 	sub	x0, addr, dst // relative fault offset
+	/* fault offset within dest. buffer */
+	alternative_if ARM64_HAS_UAO
+	bic	x0, x0, 7 // stp subst. for 2x sttr
+	alternative_else
 	bic	x0, x0, 15 // bytes already copied (steps of 16B stores)
+	alternative_endif
 	sub	x0, count, x0 // bytes yet to copy
 	b.le	L(end_fixup)
 	/* 128 < count -> count */
@@ -265,7 +270,12 @@ addr	.req	x15
 	sub	tmp1, count, tmp1 // remaining bytes after non-overlapping section
 	sub	x0, dstend, 64
 	sub	x0, addr, x0
-	bic	x0, x0, 15 // fault offset within dest. buffer
+	/* fault offset within dest. buffer */
+	alternative_if ARM64_HAS_UAO
+	bic	x0, x0, 7 // stp subst. for 2x sttr
+	alternative_else
+	bic	x0, x0, 15 // bytes already copied (steps of 16B stores)
+	alternative_endif
 	add	x0, dstend, x0
 	sub	x0, x0, 64
 	sub	x0, dstend, x0 // remaining bytes in final (overlapping) 64B
@@ -295,7 +305,12 @@ addr	.req	x15
 	 */
 	sub	tmp1, dstend, 32
 	sub	tmp1, addr, tmp1
-	bic	tmp1, tmp1, 15
+	/* fault offset */
+	alternative_if ARM64_HAS_UAO
+	bic	tmp1, tmp1, 7 // stp subst. for 2x sttr
+	alternative_else
+	bic	tmp1, tmp1, 15 // bytes already copied (steps of 16B stores)
+	alternative_endif
 	mov	x0, 32
 	sub	tmp1, x0, tmp1
 	sub	x0, count, 32
@@ -309,7 +324,12 @@ addr	.req	x15
 	 */
 	sub	tmp1, dstend, 32
 	sub	tmp1, addr, tmp1
-	bic	tmp1, tmp1, 15
+	/* fault offset */
+	alternative_if ARM64_HAS_UAO
+	bic	tmp1, tmp1, 7 // stp subst. for 2x sttr
+	alternative_else
+	bic	tmp1, tmp1, 15 // bytes already copied (steps of 16B stores)
+	alternative_endif
 	mov	x0, 32
 	sub	tmp1, x0, tmp1
 	sub	x0, count, 64
@@ -324,7 +344,12 @@ addr	.req	x15
 	 */
 	sub	tmp1, dstend, 64
 	sub	tmp1, addr, tmp1
-	bic	tmp1, tmp1, 15
+	/* fault offset */
+	alternative_if ARM64_HAS_UAO
+	bic	tmp1, tmp1, 7 // stp subst. for 2x sttr
+	alternative_else
+	bic	tmp1, tmp1, 15 // bytes already copied (steps of 16B stores)
+	alternative_endif
 	mov	x0, 64
 	sub	tmp1, x0, tmp1
 	cmp	count, 128
@@ -378,10 +403,20 @@ addr	.req	x15
 	/* Take the min from {16,(fault_addr&15)-(dst&15)}
 	 * and subtract from count to obtain the return value */
 	bic	tmp1, dst, 15 // aligned dst
-	bic	x0, addr, 15
+	/* fault offset */
+	alternative_if ARM64_HAS_UAO
+	bic	x0, addr, 7 // stp subst. for 2x sttr
+	alternative_else
+	bic	x0, addr, 15 // bytes already copied (steps of 16B stores)
+	alternative_endif
 	sub	x0, x0, tmp1 // relative fault offset
 	cmp	x0, 16
-	bic	x0, addr, 15
+	/* fault offset */
+	alternative_if ARM64_HAS_UAO
+	bic	x0, addr, 7 // stp subst. for 2x sttr
+	alternative_else
+	bic	x0, addr, 15 // bytes already copied (steps of 16B stores)
+	alternative_endif
 	sub	x0, x0, dst
 	sub	x0, count, x0
 	b.gt	L(end_fixup)
-- 
2.17.1

