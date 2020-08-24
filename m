Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D98C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FC1C20706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GqZoOfT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgHXXB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 19:01:58 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:58650 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726519AbgHXXB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 19:01:57 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6D8864017D;
        Mon, 24 Aug 2020 23:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1598310116; bh=Ge2uvyuOUpc6xFHRstqrWHRHYOOIdJGXfTv3IcvfP2A=;
        h=From:To:Cc:Subject:Date:From;
        b=GqZoOfT85COEUSSGyYfgdJXsg6W7CAB9+jUK5yLMRrJmRKNbXqk+VnSOGaLC4gyX2
         olrTqLdQDRw9/+f1jjMjwL0ZavaKLZbRh14ocOp+KL0nBbx73ttbhT4KY3vtMc2q0h
         g4XMpKgc5F+qh9Z7ESkrVxq63wuSMsrZ03QBQQ+xxZWvmfV5xuUpUAb0FFjx9yphBh
         4FPoxlfhauwHImqlFYgJc3SKaLUGdCZeoaiPzQ9ZMU2H3arBYoVJiD1EXbDg4aOGsh
         zQWKYES7wWJmyFTkio6JhUhx9g0TfJ+foF+0EZP+iEy8abAwPsUMhQJ70oXUmESbf7
         9owylxfjEbzbA==
Received: from vineetg-Latitude-7400.internal.synopsys.com (unknown [10.13.183.89])
        by mailhost.synopsys.com (Postfix) with ESMTP id 65747A007C;
        Mon, 24 Aug 2020 23:01:50 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, oferle@mellanox.com,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        kernel test robot <lkp@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] irqchip/eznps: Fix build error for !ARC700 builds
Date:   Mon, 24 Aug 2020 16:01:49 -0700
Message-Id: <20200824230149.199656-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: http://lists.infradead.org/pipermail/linux-snps-arc/2020-August/004032.html
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/plat-eznps/include/plat/ctop.h | 1 -
 include/soc/nps/common.h                | 6 ++++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arc/plat-eznps/include/plat/ctop.h b/arch/arc/plat-eznps/include/plat/ctop.h
index a4a61531c7fb..77712c5ffe84 100644
--- a/arch/arc/plat-eznps/include/plat/ctop.h
+++ b/arch/arc/plat-eznps/include/plat/ctop.h
@@ -33,7 +33,6 @@
 #define CTOP_AUX_DPC				(CTOP_AUX_BASE + 0x02C)
 #define CTOP_AUX_LPC				(CTOP_AUX_BASE + 0x030)
 #define CTOP_AUX_EFLAGS				(CTOP_AUX_BASE + 0x080)
-#define CTOP_AUX_IACK				(CTOP_AUX_BASE + 0x088)
 #define CTOP_AUX_GPA1				(CTOP_AUX_BASE + 0x08C)
 #define CTOP_AUX_UDMC				(CTOP_AUX_BASE + 0x300)
 
diff --git a/include/soc/nps/common.h b/include/soc/nps/common.h
index 9b1d43d671a3..8c18dc6d3fde 100644
--- a/include/soc/nps/common.h
+++ b/include/soc/nps/common.h
@@ -45,6 +45,12 @@
 #define CTOP_INST_MOV2B_FLIP_R3_B1_B2_INST	0x5B60
 #define CTOP_INST_MOV2B_FLIP_R3_B1_B2_LIMM	0x00010422
 
+#ifndef AUX_IENABLE
+#define AUX_IENABLE				0x40c
+#endif
+
+#define CTOP_AUX_IACK				(0xFFFFF800 + 0x088)
+
 #ifndef __ASSEMBLY__
 
 /* In order to increase compilation test coverage */
-- 
2.25.1

