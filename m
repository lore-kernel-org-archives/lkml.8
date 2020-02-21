Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18479C11D29
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 03:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6D220716
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 03:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgBUD2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:28:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729757AbgBUD2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 22:28:25 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L3JKFS021297
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 22:28:24 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ucnrcfx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 22:28:24 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Fri, 21 Feb 2020 03:28:20 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 03:28:12 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L3SBMp64749690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 03:28:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78E59AE045;
        Fri, 21 Feb 2020 03:28:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4B6BAE053;
        Fri, 21 Feb 2020 03:28:10 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 03:28:10 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id DE068A03E3;
        Fri, 21 Feb 2020 14:28:03 +1100 (AEDT)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     alastair@d-silva.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: [PATCH v3 22/27] powerpc/powernv/pmem: Implement the heartbeat command
Date:   Fri, 21 Feb 2020 14:27:15 +1100
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221032720.33893-1-alastair@au1.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022103-4275-0000-0000-000003A3FE66
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022103-4276-0000-0000-000038B80C7D
Message-Id: <20200221032720.33893-23-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=867
 priorityscore=1501 clxscore=1015 suspectscore=1 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

The heartbeat admin command is a simple admin command that exercises
the communication mechanisms within the controller.

This patch issues a heartbeat command to the card during init to ensure
we can communicate with the card's controller.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/platforms/powernv/pmem/ocxl.c | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl.c b/arch/powerpc/platforms/powernv/pmem/ocxl.c
index 081883a8247a..e01f6f9fc180 100644
--- a/arch/powerpc/platforms/powernv/pmem/ocxl.c
+++ b/arch/powerpc/platforms/powernv/pmem/ocxl.c
@@ -306,6 +306,44 @@ static bool is_usable(const struct ocxlpmem *ocxlpmem, bool verbose)
 	return true;
 }
 
+/**
+ * heartbeat() - Issue a heartbeat command to the controller
+ * @ocxlpmem: the device metadata
+ * Return: 0 if the controller responded correctly, negative on error
+ */
+static int heartbeat(struct ocxlpmem *ocxlpmem)
+{
+	int rc;
+
+	mutex_lock(&ocxlpmem->admin_command.lock);
+
+	rc = admin_command_request(ocxlpmem, ADMIN_COMMAND_HEARTBEAT);
+	if (rc)
+		goto out;
+
+	rc = admin_command_execute(ocxlpmem);
+	if (rc)
+		goto out;
+
+	rc = admin_command_complete_timeout(ocxlpmem, ADMIN_COMMAND_HEARTBEAT);
+	if (rc < 0) {
+		dev_err(&ocxlpmem->dev, "Heartbeat timeout\n");
+		goto out;
+	}
+
+	rc = admin_response(ocxlpmem);
+	if (rc < 0)
+		goto out;
+	if (rc != STATUS_SUCCESS)
+		warn_status(ocxlpmem, "Unexpected status from heartbeat", rc);
+
+	(void)admin_response_handled(ocxlpmem);
+
+out:
+	mutex_unlock(&ocxlpmem->admin_command.lock);
+	return rc;
+}
+
 /**
  * allocate_minor() - Allocate a minor number to use for an OpenCAPI pmem device
  * @ocxlpmem: the device metadata
@@ -1458,6 +1496,11 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err;
 	}
 
+	if (heartbeat(ocxlpmem)) {
+		dev_err(&pdev->dev, "Heartbeat failed\n");
+		goto err;
+	}
+
 	elapsed = 0;
 	timeout = ocxlpmem->readiness_timeout + ocxlpmem->memory_available_timeout;
 	while (!is_usable(ocxlpmem, false)) {
-- 
2.24.1

