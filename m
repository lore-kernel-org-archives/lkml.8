Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9F5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 02:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE99C206C3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 02:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgGKC0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 22:26:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20624 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbgGKC0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 22:26:02 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06B23EZ7156055;
        Fri, 10 Jul 2020 22:25:55 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326b8yvbc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 22:25:55 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06B2LD2U023542;
        Sat, 11 Jul 2020 02:25:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 326bc90jqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Jul 2020 02:25:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06B2PotF25231464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jul 2020 02:25:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0F47A4057;
        Sat, 11 Jul 2020 02:25:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60170A404D;
        Sat, 11 Jul 2020 02:25:49 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.34.17])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 11 Jul 2020 02:25:49 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v2] powerpc/pseries: detect secure and trusted boot state of the system.
Date:   Fri, 10 Jul 2020 22:25:29 -0400
Message-Id: <1594434329-31219-1-git-send-email-nayna@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_14:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=956
 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=1
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007110012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device-tree property to check secure and trusted boot state is
different for guests(pseries) compared to baremetal(powernv).

This patch updates the existing is_ppc_secureboot_enabled() and
is_ppc_trustedboot_enabled() function to add support for pseries.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: Daniel Axtens <dja@axtens.net>
---
v2:
* included Michael Ellerman's feedback.
* added Daniel Axtens's Reviewed-by.

 arch/powerpc/kernel/secure_boot.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
index 4b982324d368..efb325cbd42f 100644
--- a/arch/powerpc/kernel/secure_boot.c
+++ b/arch/powerpc/kernel/secure_boot.c
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/of.h>
 #include <asm/secure_boot.h>
+#include <asm/machdep.h>
 
 static struct device_node *get_ppc_fw_sb_node(void)
 {
@@ -23,12 +24,21 @@ bool is_ppc_secureboot_enabled(void)
 {
 	struct device_node *node;
 	bool enabled = false;
+	u32 secureboot;
 
 	node = get_ppc_fw_sb_node();
 	enabled = of_property_read_bool(node, "os-secureboot-enforcing");
-
 	of_node_put(node);
 
+	if (enabled)
+		goto out;
+
+	if (!of_property_read_u32(of_root, "ibm,secure-boot", &secureboot)) {
+		if (secureboot)
+			enabled = (secureboot > 1) ? true : false;
+	}
+
+out:
 	pr_info("Secure boot mode %s\n", enabled ? "enabled" : "disabled");
 
 	return enabled;
@@ -38,12 +48,21 @@ bool is_ppc_trustedboot_enabled(void)
 {
 	struct device_node *node;
 	bool enabled = false;
+	u32 trustedboot;
 
 	node = get_ppc_fw_sb_node();
 	enabled = of_property_read_bool(node, "trusted-enabled");
-
 	of_node_put(node);
 
+	if (enabled)
+		goto out;
+
+	if (!of_property_read_u32(of_root, "ibm,trusted-boot", &trustedboot)) {
+		if (trustedboot)
+			enabled = (trustedboot > 0) ? true : false;
+	}
+
+out:
 	pr_info("Trusted boot mode %s\n", enabled ? "enabled" : "disabled");
 
 	return enabled;
-- 
2.26.2

