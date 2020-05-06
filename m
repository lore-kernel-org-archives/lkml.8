Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE099C47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA5A8206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgEFC1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 22:27:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51946 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729553AbgEFC1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 22:27:35 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 69940334E4C9448177D9;
        Wed,  6 May 2020 10:27:32 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 6 May 2020 10:27:25 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Samuel Zou" <zou_wei@huawei.com>
Subject: [PATCH -next] powerpc/kernel/sysfs: Use ARRAY_SIZE instead of calculating the array size
Date:   Wed, 6 May 2020 10:33:36 +0800
Message-ID: <1588732416-33233-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix coccinelle warning, use ARRAY_SIZE

arch/powerpc/kernel/sysfs.c:853:34-35: WARNING: Use ARRAY_SIZE
arch/powerpc/kernel/sysfs.c:860:33-34: WARNING: Use ARRAY_SIZE
arch/powerpc/kernel/sysfs.c:868:28-29: WARNING: Use ARRAY_SIZE
arch/powerpc/kernel/sysfs.c:947:34-35: WARNING: Use ARRAY_SIZE
arch/powerpc/kernel/sysfs.c:954:33-34: WARNING: Use ARRAY_SIZE
arch/powerpc/kernel/sysfs.c:962:28-29: WARNING: Use ARRAY_SIZE

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 arch/powerpc/kernel/sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 571b325..13d2423 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -850,14 +850,14 @@ static int register_cpu_online(unsigned int cpu)
 #ifdef HAS_PPC_PMC_IBM
 	case PPC_PMC_IBM:
 		attrs = ibm_common_attrs;
-		nattrs = sizeof(ibm_common_attrs) / sizeof(struct device_attribute);
+		nattrs = ARRAY_SIZE(ibm_common_attrs);
 		pmc_attrs = classic_pmc_attrs;
 		break;
 #endif /* HAS_PPC_PMC_IBM */
 #ifdef HAS_PPC_PMC_G4
 	case PPC_PMC_G4:
 		attrs = g4_common_attrs;
-		nattrs = sizeof(g4_common_attrs) / sizeof(struct device_attribute);
+		nattrs = ARRAY_SIZE(g4_common_attrs);
 		pmc_attrs = classic_pmc_attrs;
 		break;
 #endif /* HAS_PPC_PMC_G4 */
@@ -865,7 +865,7 @@ static int register_cpu_online(unsigned int cpu)
 	case PPC_PMC_PA6T:
 		/* PA Semi starts counting at PMC0 */
 		attrs = pa6t_attrs;
-		nattrs = sizeof(pa6t_attrs) / sizeof(struct device_attribute);
+		nattrs = ARRAY_SIZE(pa6t_attrs);
 		pmc_attrs = NULL;
 		break;
 #endif
@@ -944,14 +944,14 @@ static int unregister_cpu_online(unsigned int cpu)
 #ifdef HAS_PPC_PMC_IBM
 	case PPC_PMC_IBM:
 		attrs = ibm_common_attrs;
-		nattrs = sizeof(ibm_common_attrs) / sizeof(struct device_attribute);
+		nattrs = ARRAY_SIZE(ibm_common_attrs);
 		pmc_attrs = classic_pmc_attrs;
 		break;
 #endif /* HAS_PPC_PMC_IBM */
 #ifdef HAS_PPC_PMC_G4
 	case PPC_PMC_G4:
 		attrs = g4_common_attrs;
-		nattrs = sizeof(g4_common_attrs) / sizeof(struct device_attribute);
+		nattrs = ARRAY_SIZE(g4_common_attrs);
 		pmc_attrs = classic_pmc_attrs;
 		break;
 #endif /* HAS_PPC_PMC_G4 */
@@ -959,7 +959,7 @@ static int unregister_cpu_online(unsigned int cpu)
 	case PPC_PMC_PA6T:
 		/* PA Semi starts counting at PMC0 */
 		attrs = pa6t_attrs;
-		nattrs = sizeof(pa6t_attrs) / sizeof(struct device_attribute);
+		nattrs = ARRAY_SIZE(pa6t_attrs);
 		pmc_attrs = NULL;
 		break;
 #endif
-- 
2.6.2

