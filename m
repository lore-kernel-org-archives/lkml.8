Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D15AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DDF820707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943200;
	bh=1VP0a/n1pLxLlwN1Gt75R5tx+nl7nqYb5hTJPvj7j34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gVBAWVix1Ofn2IrkaK5kGJ+k8K9T9AG8NOx7qYWcTq2IbgUDvabc7F6m03f1Wkj1q
	 wzdKm2t6D2gSMV6aVF9agYN48/LvfmAjaQKcUxW0M2u/jgJuKEWAruCecHog0+s+Zv
	 5BPJKEyANHGNvD6qXYr+rJum1QrfNp0Vv7wyyCco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389075AbgFWUNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389067AbgFWUNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:13:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B973206C3;
        Tue, 23 Jun 2020 20:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943194;
        bh=1VP0a/n1pLxLlwN1Gt75R5tx+nl7nqYb5hTJPvj7j34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4U01EqGTeIl1e6Mn2D8WHCq1a5k6QfdgXrii9bSYMNV+9lAWbHHfr3mV1ukJDneJ
         TK0SHTfNjeAyJhk7rgHR9d1hDIW+pCKn7d0beTO+tWsNIzTTsWC5RvPFoiGipoHcP7
         NxtU2YBx+iQv8Gy39ydsgc78mkOQDxNkzI7D4ykI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 296/477] powerpc/64s/kuap: Add missing isync to KUAP restore paths
Date:   Tue, 23 Jun 2020 21:54:53 +0200
Message-Id: <20200623195421.546123540@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit cb2b53cbffe3c388cd676b63f34e54ceb2643ae2 ]

Writing the AMR register is documented to require context
synchronizing operations before and after, for it to take effect as
expected. The KUAP restore at interrupt exit time deliberately avoids
the isync after the AMR update because it only needs to take effect
after the context synchronizing RFID that soon follows. Add a comment
for this.

The missing isync before the update doesn't have an obvious
justification, and seems it could theoretically allow a rogue user
access to leak past the AMR update. Add isyncs for these.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200429065654.1677541-3-npiggin@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/book3s/64/kup-radix.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h b/arch/powerpc/include/asm/book3s/64/kup-radix.h
index 3bcef989a35df..101d60f16d466 100644
--- a/arch/powerpc/include/asm/book3s/64/kup-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
@@ -16,7 +16,9 @@
 #ifdef CONFIG_PPC_KUAP
 	BEGIN_MMU_FTR_SECTION_NESTED(67)
 	ld	\gpr, STACK_REGS_KUAP(r1)
+	isync
 	mtspr	SPRN_AMR, \gpr
+	/* No isync required, see kuap_restore_amr() */
 	END_MMU_FTR_SECTION_NESTED_IFSET(MMU_FTR_RADIX_KUAP, 67)
 #endif
 .endm
@@ -62,8 +64,15 @@
 
 static inline void kuap_restore_amr(struct pt_regs *regs)
 {
-	if (mmu_has_feature(MMU_FTR_RADIX_KUAP))
+	if (mmu_has_feature(MMU_FTR_RADIX_KUAP)) {
+		isync();
 		mtspr(SPRN_AMR, regs->kuap);
+		/*
+		 * No isync required here because we are about to RFI back to
+		 * previous context before any user accesses would be made,
+		 * which is a CSI.
+		 */
+	}
 }
 
 static inline void kuap_check_amr(void)
-- 
2.25.1



