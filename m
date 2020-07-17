Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6936C43445
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7938D208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgGQJE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:04:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:64984 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgGQJE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:04:58 -0400
IronPort-SDR: fbk8fznuG35YCLotEVygdYDu9Q/Wjd7PBVQpNCHN8QJoO/0B0H243yYkdmUAyj6Q2XbxDt1EWg
 PukNIDXSK2Yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="148719424"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="148719424"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 02:04:39 -0700
IronPort-SDR: oxDGWDPvJWNBre7UxazejGNTcp7NVQeVN2tR4A2KrErWJ6rvDc82RqTLUErslqQ9ThFK9ZSBb6
 IceIci2bcDxQ==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="460786012"
Received: from enaessen-mobl1.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.251.86.9])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 02:04:35 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
List-Id: <soc.lore.kernel.org>
To:     linux-arm-kernel@lists.infradead.org, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        "Paul J. Murphy" <paul.j.murphy@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v4 1/5] arm64: Add config for Keem Bay SoC
Date:   Fri, 17 Jul 2020 10:04:10 +0100
Message-Id: <20200717090414.313530-2-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717090414.313530-1-daniele.alessandrelli@linux.intel.com>
References: <20200717090414.313530-1-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Add ARCH_KEEMBAY configuration option to support Intel Movidius SoC
code-named Keem Bay.

Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 8dd05b2a925c..95c1b9042009 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -121,6 +121,11 @@ config ARCH_HISI
 	help
 	  This enables support for Hisilicon ARMv8 SoC family
 
+config ARCH_KEEMBAY
+	bool "Keem Bay SoC"
+	help
+	  This enables support for Intel Movidius SoC code-named Keem Bay.
+
 config ARCH_MEDIATEK
 	bool "MediaTek SoC Family"
 	select ARM_GIC
-- 
2.26.2

