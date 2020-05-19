Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3719C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3DEC20829
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="wdbszZvB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4MiZn6qI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgESOcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:32:10 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:34727 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgESOcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:32:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7D7E52A9;
        Tue, 19 May 2020 10:32:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 19 May 2020 10:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=Rlk4qrJ6yWazVdgX1ne5EXVV/T
        v1KNqa9KLIo1m4QFs=; b=wdbszZvBkVf/nGSHTzPyqOPN9vPvKgqox6+6Tx8Q8Q
        vldSNqDpSAy8AguSyRpGRAwnETiPMR/HJTM6FhVJ047t1XPYNlJWCnuVNgMMncJp
        9uI946ogGknuw2J9KzuSTSTZgBQKZXM9Jr3IOftMKrxS7bgcek5PSaYyUH8CUsci
        aBVLaJv698vNiGw7y6v0gVdNZZctKw5ctQsUJaiWG8WF9lJtFAr/HegUKA6mIZcB
        E0akyQx4xNj+JyvXT4fu/vuXPuul/4X9CMZjn3CxvpvPAFUsdI/aXTUVklUjJe+B
        wjhIQq8TZ59M+YqaxB4Bu+bkuA4IZ15unSVvzQN/FtKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Rlk4qrJ6yWazVdgX1
        ne5EXVV/Tv1KNqa9KLIo1m4QFs=; b=4MiZn6qI92hnePjRBoF1j7N/HJM+eV94u
        CnkYFrQDzmlB38HcO8//yxFPSFz/dYrXxb1DeEl4jORXYBjXC65tCuQIBf2PXTdc
        UriYVntEtQbAvQTVSVibrBNI8UiMmYuF6iiAWkNc0Bu19YxF59OmNNYMc057OKoT
        IJKW+ncflE9A28DQIv+/8B0aRyT6AWVSvFRu7qw5ukATgKXsjg0E+RXnb7Id0t5M
        JnvqGIChl8Ya9/OCiFKpp7p53bHEOWC2bEVuq5G4vthB8+NXD62KsoNlASvm/ZAr
        GTIT9oW0P4y5/ejWbBnJmAaa7Zfh+Co8jG6eB8MfWnIdhkVveriNw==
X-ME-Sender: <xms:5-3DXiBLgKyNe5_lu6ngsxiJSP4vimnCE-gS8hTHS5VPXlIIVqD2WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtjedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuggftrfgrthhtvghrnhepkefhieffjeevfeevhedtieeihfefvdejle
    dvvddthefftedujeethfeuueelfedtnecukfhppedugedrvddrieeirdduvddvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifse
    grjhdrihgurdgruh
X-ME-Proxy: <xmx:5-3DXsjYlP8YJP36rhRrS2Chf4Wqc-hBzF35zbCl2ZQ3wujt9aI2Ig>
    <xmx:5-3DXllV5Mw7NxNxKyDalbWkne9Jk4rRhLEQsV6u2ersB8ixy-HV0Q>
    <xmx:5-3DXgy51YK8TfpAUu3zEWn-OmMyxs-jfzsMCnS_9bZ-Fh3mj1KDvQ>
    <xmx:6O3DXo5km_-KEyHYywfw-7wrsYmQOVB-Uh8YOMaMVmnMP0ULTxoB7A>
Received: from localhost.localdomain (ppp14-2-66-122.adl-apt-pir-bras31.tpg.internode.on.net [14.2.66.122])
        by mail.messagingengine.com (Postfix) with ESMTPA id 218AD3066429;
        Tue, 19 May 2020 10:32:05 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@armlinux.org.uk, oleg@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: Implement functions for HAVE_FUNCTION_ARG_ACCESS_API
Date:   Wed, 20 May 2020 00:01:32 +0930
Message-Id: <20200519143132.603579-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows extraction of kernel function arguments via kprobes on ARM.
Based on the arm64 implementation and adapted for the 32-bit AAPCS.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
The description for HAVE_FUNCTION_ARG_ACCESS_API was pretty vague on what was
required. I've implemented enough to enable argument extraction for kprobes; is
there anything else needed to satisfy HAVE_FUNCTION_ARG_ACCESS_API?

 arch/arm/Kconfig              |  1 +
 arch/arm/include/asm/ptrace.h | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c77c93c485a0..d82f80845e03 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -82,6 +82,7 @@ config ARM
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP if ARM_LPAE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
+	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && (CC_IS_GCC || CLANG_VERSION >= 100000)
 	select HAVE_GCC_PLUGINS
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 91d6b7856be4..71e7649deac9 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -149,6 +149,30 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
 	return *(unsigned long *)((unsigned long)regs + offset);
 }
 
+/*
+ * Read a register given an architectural register index r.
+ */
+static inline unsigned long pt_regs_read_reg(const struct pt_regs *regs, int r)
+{
+	return regs->uregs[r];
+}
+
+/**
+ * regs_get_kernel_argument() - get Nth function argument in kernel
+ * @regs:	pt_regs of that context
+ * @n:		function argument number (start from 0)
+ *
+ * regs_get_argument() returns @n th argument of the function call.
+ */
+static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
+						     unsigned int n)
+{
+#define NR_REG_ARGUMENTS 4
+	if (n < NR_REG_ARGUMENTS)
+		return pt_regs_read_reg(regs, n);
+	return 0;
+}
+
 /* Valid only for Kernel mode traps. */
 static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 {
-- 
2.25.1

