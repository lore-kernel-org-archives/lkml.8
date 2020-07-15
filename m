Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0376DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F9E2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgGOHUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:20:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7753 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728883AbgGOHUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:20:05 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 47DBF5D28DC6A2756BB1;
        Wed, 15 Jul 2020 15:20:01 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.174.186.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 15 Jul 2020 15:19:52 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <suzuki.poulose@arm.com>, <maz@kernel.org>, <steven.price@arm.com>,
        <guohanjun@huawei.com>, <olof@lixom.net>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
Subject: [PATCH v3 2/3] arm64: enable tlbi range instructions
Date:   Wed, 15 Jul 2020 15:19:44 +0800
Message-ID: <20200715071945.897-3-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200715071945.897-1-yezhenyu2@huawei.com>
References: <20200715071945.897-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.186.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TLBI RANGE feature instoduces new assembly instructions and only
support by binutils >= 2.30.  Add necessary Kconfig logic to allow
this to be enabled and pass '-march=armv8.4-a' to KBUILD_CFLAGS.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/Kconfig  | 14 ++++++++++++++
 arch/arm64/Makefile |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 66dc41fd49f2..e385361f8137 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1596,6 +1596,20 @@ config ARM64_AMU_EXTN
 	  correctly reflect reality. Most commonly, the value read will be 0,
 	  indicating that the counter is not enabled.
 
+config ARM64_TLB_RANGE
+	bool "Enable support for tlbi range feature"
+	default y
+	depends on AS_HAS_ARMV8_4
+	help
+	  ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
+	  range of input addresses.
+
+	  The feature introduces new assembly instructions, and they were
+	  support when binutils >= 2.30.
+
+config AS_HAS_ARMV8_4
+	def_bool $(cc-option, -Wa$(comma)-march=armv8.4-a)
+
 endmenu
 
 menu "ARMv8.5 architectural features"
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index a0d94d063fa8..4e823b97c92e 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -82,11 +82,18 @@ endif
 # compiler to generate them and consequently to break the single image contract
 # we pass it only to the assembler. This option is utilized only in case of non
 # integrated assemblers.
+ifneq ($(CONFIG_AS_HAS_ARMV8_4), y)
 branch-prot-flags-$(CONFIG_AS_HAS_PAC) += -Wa,-march=armv8.3-a
 endif
+endif
 
 KBUILD_CFLAGS += $(branch-prot-flags-y)
 
+ifeq ($(CONFIG_AS_HAS_ARMV8_4), y)
+# make sure to pass the newest target architecture to -march.
+KBUILD_CFLAGS	+= -Wa,-march=armv8.4-a
+endif
+
 ifeq ($(CONFIG_SHADOW_CALL_STACK), y)
 KBUILD_CFLAGS	+= -ffixed-x18
 endif
-- 
2.19.1


