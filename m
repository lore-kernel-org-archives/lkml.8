Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2624EC3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0085522B48
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbgCDCdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:33:24 -0500
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:15193 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387411AbgCDCdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:33:23 -0500
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2020 21:33:22 EST
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 4 Mar
 2020 10:18:08 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.64.44) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 4 Mar
 2020 10:18:07 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
Subject: [PATCH] x86/Kconfig: Make X86_UMIP to cover Zhaoxin CPUs too
Date:   Wed, 4 Mar 2020 10:18:05 +0800
Message-ID: <1583288285-2804-1-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.64.44]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New Zhaoxin family 7 CPUs support the UMIP (User-Mode Instruction
Prevention) feature. So, modify X86_UMIP depends on Zhaoxin CPUs too.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 16a4b39..ca4beb8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1877,7 +1877,7 @@ config X86_SMAP
 
 config X86_UMIP
 	def_bool y
-	depends on CPU_SUP_INTEL || CPU_SUP_AMD
+	depends on CPU_SUP_INTEL || CPU_SUP_AMD || CPU_SUP_CENTAUR || CPU_SUP_ZHAOXIN
 	prompt "User Mode Instruction Prevention" if EXPERT
 	---help---
 	  User Mode Instruction Prevention (UMIP) is a security feature in
-- 
2.7.4

