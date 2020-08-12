Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EEDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 11:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 692D2206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 11:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHLLJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 07:09:31 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:41856 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbgHLLJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 07:09:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U5YyoLJ_1597230558;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0U5YyoLJ_1597230558)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Aug 2020 19:09:25 +0800
From:   Liguang Zhang <zhangliguang@linux.alibaba.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: traps: clean up arm64_ras_serror_get_severity()
Date:   Wed, 12 Aug 2020 19:09:18 +0800
Message-Id: <20200812110918.18575-1-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function arm64_is_fatal_ras_serror() is always called after
arm64_is_ras_serror(), so we should remove some needless
arm64_is_ras_serror() call in function arm64_ras_serror_get_severity().

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 arch/arm64/include/asm/traps.h | 9 +--------
 arch/arm64/kernel/traps.c      | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index cee5928e1b7d..287b4d64dc67 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -79,13 +79,6 @@ static inline bool arm64_is_ras_serror(u32 esr)
  */
 static inline u32 arm64_ras_serror_get_severity(u32 esr)
 {
-	u32 aet = esr & ESR_ELx_AET;
-
-	if (!arm64_is_ras_serror(esr)) {
-		/* Not a RAS error, we can't interpret the ESR. */
-		return ESR_ELx_AET_UC;
-	}
-
 	/*
 	 * AET is RES0 if 'the value returned in the DFSC field is not
 	 * [ESR_ELx_FSC_SERROR]'
@@ -95,7 +88,7 @@ static inline u32 arm64_ras_serror_get_severity(u32 esr)
 		return ESR_ELx_AET_UC;
 	}
 
-	return aet;
+	return esr & ESR_ELx_AET;
 }
 
 bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr);
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 13ebd5ca2070..635d4cca0a4b 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -913,7 +913,7 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
 	case ESR_ELx_AET_UC:	/* Uncontainable or Uncategorized error */
 	default:
 		/* Error has been silently propagated */
-		arm64_serror_panic(regs, esr);
+		return true;
 	}
 }
 
-- 
2.19.1.6.gb485710b

