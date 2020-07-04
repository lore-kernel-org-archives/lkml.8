Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11AAC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 17:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879B320724
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 17:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgGDRK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 13:10:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726639AbgGDRK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 13:10:27 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 064H1CVw181054;
        Sat, 4 Jul 2020 13:10:21 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 322kcw1ybu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Jul 2020 13:10:20 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 064H676w014967;
        Sat, 4 Jul 2020 17:10:19 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 322hd80hkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Jul 2020 17:10:19 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 064H7fO965077590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 4 Jul 2020 17:07:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9C6AA404D;
        Sat,  4 Jul 2020 17:09:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A2C7A4040;
        Sat,  4 Jul 2020 17:09:00 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.65.197.207])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  4 Jul 2020 17:09:00 +0000 (GMT)
From:   Nayna Jain <nayna@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH] powerpc/pseries: detect secure and trusted boot state of the system.
Date:   Sat,  4 Jul 2020 13:08:55 -0400
Message-Id: <1593882535-21368-1-git-send-email-nayna@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-04_12:2020-07-02,2020-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=1
 spamscore=0 cotscore=-2147483648 mlxlogscore=791 mlxscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007040119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device-tree property to check secure and trusted boot state is
different for guests(pseries) compared to baremetal(powernv).

This patch updates the existing is_ppc_secureboot_enabled() and
is_ppc_trustedboot_enabled() function to add support for pseries.

Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
---
 arch/powerpc/kernel/secure_boot.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
index 4b982324d368..43fc6607c7a5 100644
--- a/arch/powerpc/kernel/secure_boot.c
+++ b/arch/powerpc/kernel/secure_boot.c
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/of.h>
 #include <asm/secure_boot.h>
+#include <asm/machdep.h>
 
 static struct device_node *get_ppc_fw_sb_node(void)
 {
@@ -23,11 +24,20 @@ bool is_ppc_secureboot_enabled(void)
 {
 	struct device_node *node;
 	bool enabled = false;
+	const u32 *secureboot;
 
-	node = get_ppc_fw_sb_node();
-	enabled = of_property_read_bool(node, "os-secureboot-enforcing");
+	if (machine_is(powernv)) {
+		node = get_ppc_fw_sb_node();
+		enabled =
+		    of_property_read_bool(node, "os-secureboot-enforcing");
+		of_node_put(node);
+	}
 
-	of_node_put(node);
+	if (machine_is(pseries)) {
+		secureboot = of_get_property(of_root, "ibm,secure-boot", NULL);
+		if (secureboot)
+			enabled = (*secureboot > 1) ? true : false;
+	}
 
 	pr_info("Secure boot mode %s\n", enabled ? "enabled" : "disabled");
 
@@ -38,11 +48,20 @@ bool is_ppc_trustedboot_enabled(void)
 {
 	struct device_node *node;
 	bool enabled = false;
+	const u32 *trustedboot;
 
-	node = get_ppc_fw_sb_node();
-	enabled = of_property_read_bool(node, "trusted-enabled");
+	if (machine_is(powernv)) {
+		node = get_ppc_fw_sb_node();
+		enabled = of_property_read_bool(node, "trusted-enabled");
+		of_node_put(node);
+	}
 
-	of_node_put(node);
+	if (machine_is(pseries)) {
+		trustedboot =
+		    of_get_property(of_root, "ibm,trusted-boot", NULL);
+		if (trustedboot)
+			enabled = (*trustedboot > 0) ? true : false;
+	}
 
 	pr_info("Trusted boot mode %s\n", enabled ? "enabled" : "disabled");
 
-- 
2.18.1

