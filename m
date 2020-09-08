Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9531FC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 13:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6444023C2D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 13:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgIHN2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 09:28:45 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:17809 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729799AbgIHLOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:14:23 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Sep 2020 07:14:23 EDT
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 8 Sep 2020
 18:58:43 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.56.38) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 8 Sep 2020
 18:58:42 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>,
        <sean.j.christopherson@intel.com>, <liam.merwick@oracle.com>,
        <mlevitsk@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <TimGuo-oc@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>,
        <CobeChen@zhaoxin.com>
Subject: [PATCH v1 1/2] x86/cpu: replace two-condition switch-case with if statement
Date:   Tue, 8 Sep 2020 18:57:45 +0800
Message-ID: <1599562666-31351-2-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599562666-31351-1-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1599562666-31351-1-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.56.38]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if-case instead two-condition switch-case.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/centaur.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index c5cf336..5f811586 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -90,18 +90,14 @@ enum {
 
 static void early_init_centaur(struct cpuinfo_x86 *c)
 {
-	switch (c->x86) {
 #ifdef CONFIG_X86_32
-	case 5:
-		/* Emulate MTRRs using Centaur's MCR. */
+	/* Emulate MTRRs using Centaur's MCR. */
+	if (c->x86 == 5)
 		set_cpu_cap(c, X86_FEATURE_CENTAUR_MCR);
-		break;
 #endif
-	case 6:
-		if (c->x86_model >= 0xf)
-			set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
-		break;
-	}
+	if (c->x86 == 6 && c->x86_model >= 0xf)
+		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
+
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_SYSENTER32);
 #endif
@@ -145,9 +141,8 @@ static void init_centaur(struct cpuinfo_x86 *c)
 			set_cpu_cap(c, X86_FEATURE_ARCH_PERFMON);
 	}
 
-	switch (c->x86) {
 #ifdef CONFIG_X86_32
-	case 5:
+	if (c->x86 == 5) {
 		switch (c->x86_model) {
 		case 4:
 			name = "C6";
@@ -207,12 +202,10 @@ static void init_centaur(struct cpuinfo_x86 *c)
 			c->x86_cache_size = (cc>>24)+(dd>>24);
 		}
 		sprintf(c->x86_model_id, "WinChip %s", name);
-		break;
+	}
 #endif
-	case 6:
+	if (c->x86 == 6)
 		init_c3(c);
-		break;
-	}
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
 #endif
-- 
2.7.4

