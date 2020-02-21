Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C11DC11D24
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 03:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740F424653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 03:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgBUD3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:29:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32698 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729722AbgBUD2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 22:28:23 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01L3K728028531
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 22:28:22 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y92xf23jk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 22:28:22 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Fri, 21 Feb 2020 03:28:18 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 03:28:11 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01L3SAB843647038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 03:28:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F6F3AE04D;
        Fri, 21 Feb 2020 03:28:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC284AE051;
        Fri, 21 Feb 2020 03:28:09 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 03:28:09 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 69933A03DC;
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
Subject: [PATCH v3 15/27] powerpc/powernv/pmem: Add support for near storage commands
Date:   Fri, 21 Feb 2020 14:27:08 +1100
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221032720.33893-1-alastair@au1.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022103-0012-0000-0000-00000388D1CF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022103-0013-0000-0000-000021C56A70
Message-Id: <20200221032720.33893-16-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_19:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=1 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

Similar to the previous patch, this adds support for near storage commands.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/platforms/powernv/pmem/ocxl.c    |  6 +++
 .../platforms/powernv/pmem/ocxl_internal.c    | 41 +++++++++++++++++++
 .../platforms/powernv/pmem/ocxl_internal.h    | 37 +++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl.c b/arch/powerpc/platforms/powernv/pmem/ocxl.c
index 4e782d22605b..b8bd7e703b19 100644
--- a/arch/powerpc/platforms/powernv/pmem/ocxl.c
+++ b/arch/powerpc/platforms/powernv/pmem/ocxl.c
@@ -259,12 +259,18 @@ static int setup_command_metadata(struct ocxlpmem *ocxlpmem)
 	int rc;
 
 	mutex_init(&ocxlpmem->admin_command.lock);
+	mutex_init(&ocxlpmem->ns_command.lock);
 
 	rc = extract_command_metadata(ocxlpmem, GLOBAL_MMIO_ACMA_CREQO,
 				      &ocxlpmem->admin_command);
 	if (rc)
 		return rc;
 
+	rc = extract_command_metadata(ocxlpmem, GLOBAL_MMIO_NSCMA_CREQO,
+					  &ocxlpmem->ns_command);
+	if (rc)
+		return rc;
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
index 583f48023025..3e0b133feddf 100644
--- a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
+++ b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.c
@@ -133,6 +133,47 @@ int admin_response_handled(const struct ocxlpmem *ocxlpmem)
 				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_CHI_ACRA);
 }
 
+int ns_command_request(struct ocxlpmem *ocxlpmem, u8 op_code)
+{
+	u64 val;
+	int rc = ocxl_global_mmio_read64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_CHI,
+					 OCXL_LITTLE_ENDIAN, &val);
+	if (rc)
+		return rc;
+
+	if (!(val & GLOBAL_MMIO_CHI_NSCRA))
+		return -EBUSY;
+
+	return scm_command_request(ocxlpmem, &ocxlpmem->ns_command, op_code);
+}
+
+int ns_response(const struct ocxlpmem *ocxlpmem)
+{
+	return command_response(ocxlpmem, &ocxlpmem->ns_command);
+}
+
+int ns_command_execute(const struct ocxlpmem *ocxlpmem)
+{
+	return ocxl_global_mmio_set64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_HCI,
+				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_HCI_NSCRW);
+}
+
+bool ns_command_complete(const struct ocxlpmem *ocxlpmem)
+{
+	u64 val = 0;
+	int rc = ocxlpmem_chi(ocxlpmem, &val);
+
+	WARN_ON(rc);
+
+	return (val & GLOBAL_MMIO_CHI_NSCRA) != 0;
+}
+
+int ns_response_handled(const struct ocxlpmem *ocxlpmem)
+{
+	return ocxl_global_mmio_set64(ocxlpmem->ocxl_afu, GLOBAL_MMIO_CHIC,
+				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_CHI_NSCRA);
+}
+
 void warn_status(const struct ocxlpmem *ocxlpmem, const char *message,
 		     u8 status)
 {
diff --git a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
index 2fef68c71271..28e2020f6355 100644
--- a/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
+++ b/arch/powerpc/platforms/powernv/pmem/ocxl_internal.h
@@ -107,6 +107,7 @@ struct ocxlpmem {
 	struct ocxl_context *ocxl_context;
 	void *metadata_addr;
 	struct command_metadata admin_command;
+	struct command_metadata ns_command;
 	struct resource pmem_res;
 	struct nd_region *nd_region;
 	char fw_version[8+1];
@@ -175,6 +176,42 @@ int admin_command_complete_timeout(const struct ocxlpmem *ocxlpmem,
  */
 int admin_response_handled(const struct ocxlpmem *ocxlpmem);
 
+/**
+ * ns_command_request() - Issue a near storage command request
+ * @ocxlpmem: the device metadata
+ * @op_code: The op-code for the command
+ * Returns an identifier for the command, or negative on error
+ */
+int ns_command_request(struct ocxlpmem *ocxlpmem, u8 op_code);
+
+/**
+ * ns_response() - Validate a near storage response
+ * @ocxlpmem: the device metadata
+ * Returns the status code of the command, or negative on error
+ */
+int ns_response(const struct ocxlpmem *ocxlpmem);
+
+/**
+ * ns_command_execute() - Notify the controller to start processing a pending near storage command
+ * @ocxlpmem: the device metadata
+ * Returns 0 on success, negative on error
+ */
+int ns_command_execute(const struct ocxlpmem *ocxlpmem);
+
+/**
+ * ns_command_complete() - Is a near storage command executing
+ * @ocxlpmem: the device metadata
+ * Returns true if the previous admin command has completed
+ */
+bool ns_command_complete(const struct ocxlpmem *ocxlpmem);
+
+/**
+ * ns_response_handled() - Notify the controller that the near storage response has been handled
+ * @ocxlpmem: the device metadata
+ * Returns 0 on success, negative on failure
+ */
+int ns_response_handled(const struct ocxlpmem *ocxlpmem);
+
 /**
  * warn_status() - Emit a kernel warning showing a command status.
  * @ocxlpmem: the device metadata
-- 
2.24.1

