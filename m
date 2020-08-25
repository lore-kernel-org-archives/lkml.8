Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72750C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37940206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HB8Wp3ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHYSF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:05:27 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59412 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbgHYSFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:05:25 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EB511C0BE0;
        Tue, 25 Aug 2020 18:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1598378724; bh=IcUtOy6AzwoGn6Jt34sVTfbc2thdkUgAmx/C0WQaJiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HB8Wp3dsX8ibNfBtmsc+/wY0IbLw6j5plUU8VJZKrtLAusHHDQGzR/MMX70R6euIP
         +3eMikYKG9hJmiWnV2R3kAOoJDyj3/ZIy4KRjz0dkerH2InEVOPCndPUbIv16yOP/p
         kYtJedniq5yXWU+QEV+VUpOttiTYJjSgy29KXArQ2pXWQgWy2h0RrctvzzxnnKUHxA
         OnkjIHa7FZRO7mb56eax418uATNW+5D9s6hl6C/2NPBG2DL3UgoyO6PjfSinea3Jhi
         0aSDKhHKVp8QRTmWSgCijceKhcIJoiUksnouzgZlY25HtKF2+PdQNRBvDmDdePjpHx
         u+LKSsLF6ouow==
Received: from vineetg-Latitude-7400.internal.synopsys.com (unknown [10.13.183.89])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6139DA005A;
        Tue, 25 Aug 2020 18:05:20 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        kernel test robot <lkp@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2] irqchip/eznps: Fix build error for !ARC700 builds
Date:   Tue, 25 Aug 2020 11:05:18 -0700
Message-Id: <20200825180518.25300-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825072152.725jmtlcqah5oos4@linutronix.de>
References: <20200825072152.725jmtlcqah5oos4@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eznps driver is supposed to be platform independent however it ends up
including stuff from inside arch/arc headers leading to rand config
build errors.

Fix this specific reported error as quick hacks as the correct fixes are
too much work:
 - copy AUX_IENABLE from arch/arc header
 - move CTOP_AUX_IACK from platform header

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/20200824095831.5lpkmkafelnvlpi2@linutronix.de
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

