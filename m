Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77A8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BE5221E7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599838151;
	bh=ouSe3E1BUgGedI46aMfPRrEMheKNTw50AdAlm0Y74ac=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sa4db49b63XCp8U2VNLAdhiM1jLTPXaUhWVCc1UNL4m8Vj+jRKz0BUlh5Dk1PAD19
	 Q2fhY75QD8FFnV4H5PQ3caVkfgmnZf/1WqgZ+jJ4VL2l8m/3i9u1Agyu0/ojIGwQ4d
	 VlwA94PfaMo3AFlSMk8d49YU2JTFQudyNc8lNgvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIKP3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:29:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgIKPZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:25:30 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2559222BB;
        Fri, 11 Sep 2020 14:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599834846;
        bh=ouSe3E1BUgGedI46aMfPRrEMheKNTw50AdAlm0Y74ac=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TSlmQcxVEbkc4r6vpe2ZTb1CsL7jXAQaU0zDUG/YmAg4hIgTGUmXfaM/KLAl/v5ft
         syogXF7HnkJbXpg/TB/oTq7Qf1X+dERYaDNVzKzWZD8ZntQgiIya5i53/y+Og4YBzJ
         ovzPawY47ZwZtbiAAKXiB4jI/3D+kj8MG4RaInHg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 3/3] ARM: s3c: Bring back notes from removed debug-macro.S
Date:   Fri, 11 Sep 2020 16:33:43 +0200
Message-Id: <20200911143343.498-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911143343.498-1-krzk@kernel.org>
References: <20200911143343.498-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation references notes from a removed debug-macro.S file so
bring the contents here.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c/s3c64xx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c/s3c64xx.c b/arch/arm/mach-s3c/s3c64xx.c
index b5fc615a482f..4dfb648142f2 100644
--- a/arch/arm/mach-s3c/s3c64xx.c
+++ b/arch/arm/mach-s3c/s3c64xx.c
@@ -95,7 +95,12 @@ static struct cpu_table cpu_ids[] __initdata = {
 
 /* minimal IO mapping */
 
-/* see notes on uart map in arch/arm/mach-s3c64xx/include/mach/debug-macro.S */
+/*
+ * note, for the boot process to work we have to keep the UART
+ * virtual address aligned to an 1MiB boundary for the L1
+ * mapping the head code makes. We keep the UART virtual address
+ * aligned and add in the offset when we load the value here.
+ */
 #define UART_OFFS (S3C_PA_UART & 0xfffff)
 
 static struct map_desc s3c_iodesc[] __initdata = {
-- 
2.17.1

