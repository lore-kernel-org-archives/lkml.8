Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1CEC2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CAF2071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbgDAV1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:27:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732357AbgDAV1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 17:27:34 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031L3XcV151907;
        Wed, 1 Apr 2020 17:27:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304r502y5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 17:27:18 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 031L3u7H152993;
        Wed, 1 Apr 2020 17:27:17 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304r502y5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 17:27:17 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 031LPSNC023746;
        Wed, 1 Apr 2020 21:27:16 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 301x77vxrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 21:27:16 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 031LRFZ161735268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 21:27:15 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 337836A04F;
        Wed,  1 Apr 2020 21:27:15 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E6BB6A04D;
        Wed,  1 Apr 2020 21:27:14 +0000 (GMT)
Received: from [9.70.82.143] (unknown [9.70.82.143])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 21:27:14 +0000 (GMT)
Subject: [PATCH v9 03/13] powerpc/vas: Alloc and setup IRQ and trigger port
 address
From:   Haren Myneni <haren@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     npiggin@gmail.com, mikey@neuling.org, herbert@gondor.apana.org.au,
        frederic.barrat@fr.ibm.com, srikar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, hch@infradead.org, oohall@gmail.com,
        clg@kaod.org, sukadev@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, ajd@linux.ibm.com
In-Reply-To: <1585775978.10664.438.camel@hbabu-laptop>
References: <1585775978.10664.438.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 01 Apr 2020 14:26:28 -0700
Message-ID: <1585776388.10664.443.camel@hbabu-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_04:2020-03-31,2020-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 suspectscore=1 mlxscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Allocate a xive irq on each chip with a vas instance. The NX coprocessor
raises a host CPU interrupt via vas if it encounters page fault on user
space request buffer. Subsequent patches register the trigger port with
the NX coprocessor, and create a vas fault handler for this interrupt
mapping.

Signed-off-by: Haren Myneni <haren@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/vas.c | 44 +++++++++++++++++++++++++++++++-----
 arch/powerpc/platforms/powernv/vas.h |  2 ++
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
index ed9cc6d..3303cfe 100644
--- a/arch/powerpc/platforms/powernv/vas.c
+++ b/arch/powerpc/platforms/powernv/vas.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/of.h>
 #include <asm/prom.h>
+#include <asm/xive.h>
 
 #include "vas.h"
 
@@ -25,10 +26,12 @@
 
 static int init_vas_instance(struct platform_device *pdev)
 {
-	int rc, cpu, vasid;
-	struct resource *res;
-	struct vas_instance *vinst;
 	struct device_node *dn = pdev->dev.of_node;
+	struct vas_instance *vinst;
+	struct xive_irq_data *xd;
+	uint32_t chipid, hwirq;
+	struct resource *res;
+	int rc, cpu, vasid;
 
 	rc = of_property_read_u32(dn, "ibm,vas-id", &vasid);
 	if (rc) {
@@ -36,6 +39,12 @@ static int init_vas_instance(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	rc = of_property_read_u32(dn, "ibm,chip-id", &chipid);
+	if (rc) {
+		pr_err("No ibm,chip-id property for %s?\n", pdev->name);
+		return -ENODEV;
+	}
+
 	if (pdev->num_resources != 4) {
 		pr_err("Unexpected DT configuration for [%s, %d]\n",
 				pdev->name, vasid);
@@ -69,9 +78,32 @@ static int init_vas_instance(struct platform_device *pdev)
 
 	vinst->paste_win_id_shift = 63 - res->end;
 
-	pr_devel("Initialized instance [%s, %d], paste_base 0x%llx, "
-			"paste_win_id_shift 0x%llx\n", pdev->name, vasid,
-			vinst->paste_base_addr, vinst->paste_win_id_shift);
+	hwirq = xive_native_alloc_irq_on_chip(chipid);
+	if (!hwirq) {
+		pr_err("Inst%d: Unable to allocate global irq for chip %d\n",
+				vinst->vas_id, chipid);
+		return -ENOENT;
+	}
+
+	vinst->virq = irq_create_mapping(NULL, hwirq);
+	if (!vinst->virq) {
+		pr_err("Inst%d: Unable to map global irq %d\n",
+				vinst->vas_id, hwirq);
+		return -EINVAL;
+	}
+
+	xd = irq_get_handler_data(vinst->virq);
+	if (!xd) {
+		pr_err("Inst%d: Invalid virq %d\n",
+				vinst->vas_id, vinst->virq);
+		return -EINVAL;
+	}
+
+	vinst->irq_port = xd->trig_page;
+	pr_devel("Initialized instance [%s, %d] paste_base 0x%llx paste_win_id_shift 0x%llx IRQ %d Port 0x%llx\n",
+			pdev->name, vasid, vinst->paste_base_addr,
+			vinst->paste_win_id_shift, vinst->virq,
+			vinst->irq_port);
 
 	for_each_possible_cpu(cpu) {
 		if (cpu_to_chip_id(cpu) == of_get_ibm_chip_id(dn))
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index 5574aec..598608b 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -313,6 +313,8 @@ struct vas_instance {
 	u64 paste_base_addr;
 	u64 paste_win_id_shift;
 
+	u64 irq_port;
+	int virq;
 	struct mutex mutex;
 	struct vas_window *rxwin[VAS_COP_TYPE_MAX];
 	struct vas_window *windows[VAS_WINDOWS_PER_CHIP];
-- 
1.8.3.1



