Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C3EC2D0E0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED68208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599497585;
	bh=Y7DfL2QIoK+7AlOig5I7K0jPWLIoatifmL4WfTHq3TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iRQGxf68vkwvoBDUdTyiDlEsmDYdQs5QZvqEOdL4sXYJuMVGnNkxFVj4o8AWoLstN
	 muw4SWFdwuIOxx8GZEG7ZPeZVMBh+jQYH3nBLgcf94hJgsWITomYQ1oTEXPLI8sQiu
	 GMhEshaHd8k3fwCZq0av5kvaPSPwVZ1mT3ZhuTvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbgIGQw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730452AbgIGQen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:34:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B9321941;
        Mon,  7 Sep 2020 16:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496482;
        bh=Y7DfL2QIoK+7AlOig5I7K0jPWLIoatifmL4WfTHq3TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wU5cYWoWfEY0BQuvEWxe/e2AwGO8id46R4BBHmf6ovpSPI+sUjN77Fi8VqEq0fOw/
         QcK3phqLfxDqDaz8TAcUIo3f8qpnH2IeBegrl9WXESPU1D/4pGWiSfP9BRoZqw7SAs
         FuLSxOwG1RwqUeeLa6ujn8dCHy4sTnJjxKy+R/OA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        kernel test robot <lkp@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 12/26] irqchip/eznps: Fix build error for !ARC700 builds
Date:   Mon,  7 Sep 2020 12:34:12 -0400
Message-Id: <20200907163426.1281284-12-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163426.1281284-1-sashal@kernel.org>
References: <20200907163426.1281284-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

[ Upstream commit 89d29997f103d08264b0685796b420d911658b96 ]

eznps driver is supposed to be platform independent however it ends up
including stuff from inside arch/arc headers leading to rand config
build errors.

The quick hack to fix this (proper fix is too much chrun for non active
user-base) is to add following to nps platform agnostic header.
 - copy AUX_IENABLE from arch/arc header
 - move CTOP_AUX_IACK from arch/arc/plat-eznps/*/**

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/20200824095831.5lpkmkafelnvlpi2@linutronix.de
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/plat-eznps/include/plat/ctop.h | 1 -
 include/soc/nps/common.h                | 6 ++++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arc/plat-eznps/include/plat/ctop.h b/arch/arc/plat-eznps/include/plat/ctop.h
index 4f6a1673b3a6e..ddfca2c3357a0 100644
--- a/arch/arc/plat-eznps/include/plat/ctop.h
+++ b/arch/arc/plat-eznps/include/plat/ctop.h
@@ -43,7 +43,6 @@
 #define CTOP_AUX_DPC				(CTOP_AUX_BASE + 0x02C)
 #define CTOP_AUX_LPC				(CTOP_AUX_BASE + 0x030)
 #define CTOP_AUX_EFLAGS				(CTOP_AUX_BASE + 0x080)
-#define CTOP_AUX_IACK				(CTOP_AUX_BASE + 0x088)
 #define CTOP_AUX_GPA1				(CTOP_AUX_BASE + 0x08C)
 #define CTOP_AUX_UDMC				(CTOP_AUX_BASE + 0x300)
 
diff --git a/include/soc/nps/common.h b/include/soc/nps/common.h
index 9b1d43d671a3f..8c18dc6d3fde5 100644
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

