Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE76C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE38720776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EYl+2DGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgE2Lzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:55:55 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:33918 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbgE2Lzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:55:54 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 378AEC03B4;
        Fri, 29 May 2020 11:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1590753354; bh=4tHxSBkm1m3j6WDpl6aUjwp+PqWpmQzY0kj71pY8N/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYl+2DGGka2JLbMyxCQCsVi+jOsRthQ1TxJLGOHMrUt3kqk8DuGGyDi/BT9iBgosC
         XzeCMD/UlphfSakd7L5vGkXQyynDwe3DHa04mu2BtgMH5kvMSTjKO5QOhj4H2J2NKD
         W+w5HREfg1qB9sPTs9MWaixUjzu5LUb4ORWpKq1fbrMfcnVqZ5Fx4sjj0bAgngKudz
         h7yeUtEH9Tq0aQ3m3qz1qGiWGSka6wwOvFoVmtc6oQnRXFCirgTLaC6f1PF8b/WEMn
         ILf0Y2BI3hnOl9JMUFvWwtgUrew5/i6VbHB4vKWdAl9odmUr6YBnLrIuSz/9+bWJzI
         yYBSp9MreQLRg==
Received: from paltsev-e7480.internal.synopsys.com (ru20-e7250.internal.synopsys.com [10.225.50.16])
        by mailhost.synopsys.com (Postfix) with ESMTP id A2760A005D;
        Fri, 29 May 2020 11:55:52 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/3] ARC: allow to overide default mcpu compiler flag
Date:   Fri, 29 May 2020 14:55:31 +0300
Message-Id: <20200529115534.22883-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200529115534.22883-1-Eugeniy.Paltsev@synopsys.com>
References: <20200529115534.22883-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default we set -mcpu=xxx compiler flag depending on the CPU ISA
version. It's good starting point, however that may be not enough
as for some platforms we may want to use some specific 'mcpu'
options for better optimization or to workaround HW issues.

We are going to use this option for HSDK-4xD board support.
In addition it also allows to awoid patching 'mcpu' in ARC Makefile
when we building Linux for some non-standard simulation or FPGA-based
platforms.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig  | 7 +++++++
 arch/arc/Makefile | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index ff306246d0f8..2d4f85dc914e 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -377,6 +377,13 @@ config ARC_HAS_SWAPE
 	bool "Insn: SWAPE (endian-swap)"
 	default y
 
+config ARC_TUNE_MCPU
+	string "Overide default -mcpu compiler flag"
+	default ""
+	help
+	  Overide default -mcpu=xxx compiler flag (which is set depending on
+	  the ISA version) with the specified value.
+
 if ISA_ARCV2
 
 config ARC_USE_UNALIGNED_MEM_ACCESS
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 20e9ab6cc521..eb88ba5b1573 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -10,8 +10,12 @@ CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux-)
 endif
 
 cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
+ifeq ($(CONFIG_ARC_TUNE_MCPU),"")
 cflags-$(CONFIG_ISA_ARCOMPACT)	+= -mA7
 cflags-$(CONFIG_ISA_ARCV2)	+= -mcpu=hs38
+else
+cflags-y			+= $(shell echo $(CONFIG_ARC_TUNE_MCPU))
+endif
 
 ifdef CONFIG_ARC_CURR_IN_REG
 # For a global register defintion, make sure it gets passed to every file
-- 
2.21.3

