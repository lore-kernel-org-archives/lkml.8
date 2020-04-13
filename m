Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBE4C2BB85
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 01:34:25 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5840220678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 01:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fmTKMsW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5840220678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgDMBeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 21:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgDMBeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 21:34:23 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B2AC0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 18:34:22 -0700 (PDT)
Received: from oscar.flets-west.jp (softbank060142179096.bbtec.net [60.142.179.96]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 03D1WsFq003537;
        Mon, 13 Apr 2020 10:32:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 03D1WsFq003537
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1586741575;
        bh=BJbt349d1GFRoVaxKRMr2OOu2ZIUsOrtI77b0u4o6KI=;
        h=From:To:Cc:Subject:Date:From;
        b=fmTKMsW7Mb4qSZ2Qxx5qs13u7Bhatv1VPfUDo7caOIskmNiRX99kycLGcIUCS+iHP
         dAueM0zk/+G+Kzk0lcDQEH2//DFrSSZgRuW5TF6JfglS8MCTHGaHA3LiFUbGCf2GLJ
         zJY98yrO9zh2g+/KN7lKM02K3Wp+ygRIBhN7JjD82fLph7g1d7uJKnSwX1E22wRyq+
         H6tI0cNUzbVAQbX3Kul0o6itC2IKOEIiFwNQc0uU9LbX9qXzNWyFSp9l8fyByqyxkx
         zE2MtyDojqOQUQx1mm/AgnUk9pxQRE7NlW7A/I7nSxi1OSRCQxxtzwhU8wHJoqvcfz
         +/U/ER6ceLAAQ==
X-Nifty-SrcIP: [60.142.179.96]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arc: ptrace: hard-code "arc" instead of UTS_MACHINE
Date:   Mon, 13 Apr 2020 10:32:40 +0900
Message-Id: <20200413013240.8659-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARC uses the UTS_MACHINE defined in the top Makefile as follows:

  UTS_MACHINE     := $(ARCH)

We know it is "arc" when we are building the kernel for ARC.
Hard-code user_regset_view::name, like many other architectures do.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arc/kernel/Makefile | 3 ---
 arch/arc/kernel/ptrace.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
index 75539670431a..8c4fc4b54c14 100644
--- a/arch/arc/kernel/Makefile
+++ b/arch/arc/kernel/Makefile
@@ -3,9 +3,6 @@
 # Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
 #
 
-# Pass UTS_MACHINE for user_regset definition
-CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
-
 obj-y	:= arcksyms.o setup.o irq.o reset.o ptrace.o process.o devtree.o
 obj-y	+= signal.o traps.o sys.o troubleshoot.o stacktrace.o disasm.o
 obj-$(CONFIG_ISA_ARCOMPACT)		+= entry-compact.o intc-compact.o
diff --git a/arch/arc/kernel/ptrace.c b/arch/arc/kernel/ptrace.c
index d5f3fcf273b5..f49a054a1016 100644
--- a/arch/arc/kernel/ptrace.c
+++ b/arch/arc/kernel/ptrace.c
@@ -253,7 +253,7 @@ static const struct user_regset arc_regsets[] = {
 };
 
 static const struct user_regset_view user_arc_view = {
-	.name		= UTS_MACHINE,
+	.name		= "arc",
 	.e_machine	= EM_ARC_INUSE,
 	.regsets	= arc_regsets,
 	.n		= ARRAY_SIZE(arc_regsets)
-- 
2.25.1

