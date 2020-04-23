Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ABCC55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F09C20736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uN98XlX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgDWSGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:06:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58232 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbgDWSGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:06:13 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03NI65in005826;
        Thu, 23 Apr 2020 13:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587665165;
        bh=Kwy0dcW3MJxuHI8JGhD0GVu8dadJkA3R87aPNEJSfoM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uN98XlX5Q2zEL2ss2EJJMiNZk+/kH+UAPDc+hYIEl+7/+NOWJMTDc50E/0kS/AAEk
         Erj52h36RnVv0LJyinmhfSRu9JEdjWJLSVn/iNaYEd+GWRPBeh3GaCYxByAQS7+hbG
         BzJs4WCM6wGeA+RfeJUtoOEq9lUJINgpfwXLuAG4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03NI65f2091770;
        Thu, 23 Apr 2020 13:06:05 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Apr 2020 13:06:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Apr 2020 13:06:04 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03NI63FN116909;
        Thu, 23 Apr 2020 13:06:04 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 3/5] arm64: arch_k3: enable chipid driver
Date:   Thu, 23 Apr 2020 21:05:43 +0300
Message-ID: <20200423180545.13707-4-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423180545.13707-1-grygorii.strashko@ti.com>
References: <20200423180545.13707-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select TI chip id driver for TI's SoCs based on K3 architecture to provide
this information to user space and Kernel as it is required by other
drivers to determine SoC revision to function properly.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 55d70cfe0f9e..174dd4fc6cf2 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -98,6 +98,7 @@ config ARCH_K3
 	select TI_SCI_PROTOCOL
 	select TI_SCI_INTR_IRQCHIP
 	select TI_SCI_INTA_IRQCHIP
+	select TI_K3_SOCINFO
 	help
 	  This enables support for Texas Instruments' K3 multicore SoC
 	  architecture.
-- 
2.17.1

