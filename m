Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:57558 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730055AbgCKQ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:26:49 -0400
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/2] ARC: define __ALIGN_STR and __ALIGN symbols for ARC
Date: Wed, 11 Mar 2020 19:26:43 +0300
Message-Id: <20200311162644.7667-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As of today ARC uses generic __ALIGN_STR and __ALIGN symbol
definitions from "include/linux/linkage.h"
They are defined to ".align 4,0x90" which instructed the assembler
to use `0x90` as a fill byte when aligning functions declared with
ENTRY or similar macroses. This leads to generated weird instructions
in code (when alignment is used) like "ldh_s r12,[r0,0x20]" which is
encoded as 0x9090 for ARCv2.

Let's use ".align 4" which insert a "nop_s" instruction instead.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/include/asm/linkage.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arc/include/asm/linkage.h b/arch/arc/include/asm/linkage.h
index d9ee43c6b7db..fe19f1d412e7 100644
--- a/arch/arc/include/asm/linkage.h
+++ b/arch/arc/include/asm/linkage.h
@@ -29,6 +29,8 @@
 .endm
 
 #define ASM_NL		 `	/* use '`' to mark new line in macro */
+#define __ALIGN		.align 4
+#define __ALIGN_STR	__stringify(__ALIGN)
 
 /* annotation for data we want in DCCM - if enabled in .config */
 .macro ARCFP_DATA nm
-- 
2.21.1

