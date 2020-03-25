Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC7BC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED29920773
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EJ2g/5sW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgCYToC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:44:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50973 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgCYTn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:43:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PJeMkk126847;
        Wed, 25 Mar 2020 19:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=FP7qaU675AipOERS/iECqnM/xR6f/XmrKk8YBQwUyIM=;
 b=EJ2g/5sWpPXrIVwehdxWfI/9h83TDQbW8jlC3NFj0dgvcanbV5YuxOetc5RTGwQXPMkK
 i9SpAya5rHWvCAKi0Ncaw/HGhtuDbuFkfHJOu/VS3VOlq6lzeuj59laAuHCEdHBjGXoN
 xCflDDQo1ouHWD71psyRDc5xhJJLJw1MCmUEwHhKCSrtbto4s2+phDi6CI7d/iwcjEaa
 0FPDvCAdaZ3JGki1XxIKRNRJZqj8upZDPmVDbKbFoqMQLsvgujKQPvZ5Hlviw+j6QoH3
 N9cOP/2xmVn7drnktyexCT6GQiaekWDztTN4GrewFpDkP6Vpvn54wXgVz52aSyv5dQ2O mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3005kvasyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 19:43:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PJfoHS142034;
        Wed, 25 Mar 2020 19:43:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3006r74pkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 19:43:30 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02PJhUpc025319;
        Wed, 25 Mar 2020 19:43:30 GMT
Received: from pneuma.us.oracle.com (/10.39.203.246)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 12:43:30 -0700
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 05/12] x86: Add early TPM1.2/TPM2.0 interface support for Secure Launch
Date:   Wed, 25 Mar 2020 15:43:10 -0400
Message-Id: <20200325194317.526492-6-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325194317.526492-1-ross.philipson@oracle.com>
References: <20200325194317.526492-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=2
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=2 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

This commit introduces an abstraction for TPM1.2 and TPM2.0 devices
above the TPM hardware interface.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
---
 arch/x86/boot/compressed/Makefile             |   3 +-
 arch/x86/boot/compressed/tpm/tpm1.h           | 112 +++++++++++++
 arch/x86/boot/compressed/tpm/tpm1_cmds.c      | 133 ++++++++++++++++
 arch/x86/boot/compressed/tpm/tpm2.h           |  89 +++++++++++
 arch/x86/boot/compressed/tpm/tpm2_auth.c      |  31 ++++
 arch/x86/boot/compressed/tpm/tpm2_auth.h      |  21 +++
 arch/x86/boot/compressed/tpm/tpm2_cmds.c      | 150 ++++++++++++++++++
 arch/x86/boot/compressed/tpm/tpm2_constants.h |  66 ++++++++
 8 files changed, 604 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/boot/compressed/tpm/tpm1.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm1_cmds.c
 create mode 100644 arch/x86/boot/compressed/tpm/tpm2.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm2_auth.c
 create mode 100644 arch/x86/boot/compressed/tpm/tpm2_auth.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm2_cmds.c
 create mode 100644 arch/x86/boot/compressed/tpm/tpm2_constants.h

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index b9682eaf8f59..6c2beb306631 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -97,7 +97,8 @@ vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o
 vmlinux-objs-$(CONFIG_SECURE_LAUNCH_SHA256) += $(obj)/early_sha256.o
 vmlinux-objs-$(CONFIG_SECURE_LAUNCH_SHA512) += $(obj)/early_sha512.o
 vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/tpm/tpmio.o $(obj)/tpm/tpm_buff.o \
-	$(obj)/tpm/tis.o $(obj)/tpm/crb.o
+	$(obj)/tpm/tis.o $(obj)/tpm/crb.o $(obj)/tpm/tpm1_cmds.o \
+	$(obj)/tpm/tpm2_cmds.o $(obj)/tpm/tpm2_auth.o
 
 # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
 # can place it anywhere in memory and it will still run. However, since
diff --git a/arch/x86/boot/compressed/tpm/tpm1.h b/arch/x86/boot/compressed/tpm/tpm1.h
new file mode 100644
index 000000000000..41798e9f58e3
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/tpm1.h
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Apertus Solutions, LLC
+ *
+ * Author(s):
+ *      Daniel P. Smith <dpsmith@apertussolutions.com>
+ *
+ * The definitions in this header are extracted from the Trusted Computing
+ * Group's "TPM Main Specification", Parts 1-3.
+ *
+ */
+
+#ifndef _TPM1_H
+#define _TPM1_H
+
+#include "tpm.h"
+
+/* Section 2.2.3 */
+#define TPM_AUTH_DATA_USAGE u8
+#define TPM_PAYLOAD_TYPE u8
+#define TPM_VERSION_BYTE u8
+#define TPM_TAG u16
+#define TPM_PROTOCOL_ID u16
+#define TPM_STARTUP_TYPE u16
+#define TPM_ENC_SCHEME u16
+#define TPM_SIG_SCHEME u16
+#define TPM_MIGRATE_SCHEME u16
+#define TPM_PHYSICAL_PRESENCE u16
+#define TPM_ENTITY_TYPE u16
+#define TPM_KEY_USAGE u16
+#define TPM_EK_TYPE u16
+#define TPM_STRUCTURE_TAG u16
+#define TPM_PLATFORM_SPECIFIC u16
+#define TPM_COMMAND_CODE u32
+#define TPM_CAPABILITY_AREA u32
+#define TPM_KEY_FLAGS u32
+#define TPM_ALGORITHM_ID u32
+#define TPM_MODIFIER_INDICATOR u32
+#define TPM_ACTUAL_COUNT u32
+#define TPM_TRANSPORT_ATTRIBUTES u32
+#define TPM_AUTHHANDLE u32
+#define TPM_DIRINDEX u32
+#define TPM_KEY_HANDLE u32
+#define TPM_PCRINDEX u32
+#define TPM_RESULT u32
+#define TPM_RESOURCE_TYPE u32
+#define TPM_KEY_CONTROL u32
+#define TPM_NV_INDEX u32 The
+#define TPM_FAMILY_ID u32
+#define TPM_FAMILY_VERIFICATION u32
+#define TPM_STARTUP_EFFECTS u32
+#define TPM_SYM_MODE u32
+#define TPM_FAMILY_FLAGS u32
+#define TPM_DELEGATE_INDEX u32
+#define TPM_CMK_DELEGATE u32
+#define TPM_COUNT_ID u32
+#define TPM_REDIT_COMMAND u32
+#define TPM_TRANSHANDLE u32
+#define TPM_HANDLE u32
+#define TPM_FAMILY_OPERATION u32
+
+/* Section 6 */
+#define TPM_TAG_RQU_COMMAND		0x00C1
+#define TPM_TAG_RQU_AUTH1_COMMAND	0x00C2
+#define TPM_TAG_RQU_AUTH2_COMMAND	0x00C3
+#define TPM_TAG_RSP_COMMAND		0x00C4
+#define TPM_TAG_RSP_AUTH1_COMMAND	0x00C5
+#define TPM_TAG_RSP_AUTH2_COMMAND	0x00C6
+
+/* Section 16 */
+#define TPM_SUCCESS 0x0
+
+/* Section 17 */
+#define TPM_ORD_EXTEND			0x00000014
+
+#define SHA1_DIGEST_SIZE 20
+
+/* Section 5.4 */
+struct tpm_sha1_digest {
+	u8 digest[SHA1_DIGEST_SIZE];
+};
+struct tpm_digest {
+	TPM_PCRINDEX pcr;
+	union {
+		struct tpm_sha1_digest sha1;
+	} digest;
+};
+
+#define TPM_DIGEST		struct tpm_sha1_digest
+#define TPM_CHOSENID_HASH	TPM_DIGEST
+#define TPM_COMPOSITE_HASH	TPM_DIGEST
+#define TPM_DIRVALUE		TPM_DIGEST
+#define TPM_HMAC		TPM_DIGEST
+#define TPM_PCRVALUE		TPM_DIGEST
+#define TPM_AUDITDIGEST		TPM_DIGEST
+#define TPM_DAA_TPM_SEED	TPM_DIGEST
+#define TPM_DAA_CONTEXT_SEED	TPM_DIGEST
+
+struct tpm_extend_cmd {
+	TPM_PCRINDEX pcr_num;
+	TPM_DIGEST digest;
+};
+
+struct tpm_extend_resp {
+	TPM_COMMAND_CODE ordinal;
+	TPM_PCRVALUE digest;
+};
+
+/* TPM Commands */
+int tpm1_pcr_extend(struct tpm *t, struct tpm_digest *d);
+
+#endif
diff --git a/arch/x86/boot/compressed/tpm/tpm1_cmds.c b/arch/x86/boot/compressed/tpm/tpm1_cmds.c
new file mode 100644
index 000000000000..653228fc8c4a
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/tpm1_cmds.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Apertus Solutions, LLC
+ *
+ * Author(s):
+ *      Daniel P. Smith <dpsmith@apertussolutions.com>
+ *
+ * The code in this file is based on the article "Writing a TPM Device Driver"
+ * published on http://ptgmedia.pearsoncmg.com.
+ *
+ */
+
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/byteorder.h>
+#include "tpm.h"
+#include "tpmbuff.h"
+#include "tis.h"
+#include "tpm_common.h"
+#include "tpm1.h"
+
+int tpm1_pcr_extend(struct tpm *t, struct tpm_digest *d)
+{
+	int ret = 0;
+	struct tpmbuff *b = t->buff;
+	struct tpm_header *hdr;
+	struct tpm_extend_cmd *cmd;
+	struct tpm_extend_resp *resp;
+	size_t bytes, size;
+
+	if (!tpmb_reserve(b)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	hdr = (struct tpm_header *)b->head;
+
+	hdr->tag = cpu_to_be16(TPM_TAG_RQU_COMMAND);
+	hdr->code = cpu_to_be32(TPM_ORD_EXTEND);
+
+	cmd = (struct tpm_extend_cmd *)
+		tpmb_put(b, sizeof(struct tpm_extend_cmd));
+	if (cmd == NULL) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	cmd->pcr_num = cpu_to_be32(d->pcr);
+	memcpy(&(cmd->digest), &(d->digest), sizeof(TPM_DIGEST));
+
+	hdr->size = cpu_to_be32(tpmb_size(b));
+
+	switch (t->intf) {
+	case TPM_DEVNODE:
+		/* Not implemented yet */
+		ret = -EBADRQC;
+		break;
+	case TPM_TIS:
+		if (be32_to_cpu(hdr->size) != tis_send(b))
+			ret = -EAGAIN;
+		break;
+	case TPM_CRB:
+		/* Not valid for TPM 1.2 */
+		ret = -ENODEV;
+		break;
+	case TPM_UEFI:
+		/* Not implemented yet */
+		ret = -EBADRQC;
+		break;
+	}
+
+	if (ret)
+		goto free;
+
+	tpmb_free(b);
+
+	/* Reset buffer for receive */
+	if (!tpmb_reserve(b)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	hdr = (struct tpm_header *)b->head;
+
+	/*
+	 * The extend receive operation returns a struct tpm_extend_resp
+	 * but the current implementation ignores the returned PCR value.
+	 */
+
+	switch (t->intf) {
+	case TPM_DEVNODE:
+		/* Not implemented yet */
+		ret = -EBADRQC;
+		break;
+	case TPM_TIS:
+		/* tis_recv() will increase the buffer size */
+		size = tis_recv(t->family, b);
+		if (tpmb_size(b) != size)
+			ret = -EAGAIN;
+		break;
+	case TPM_CRB:
+		/* Not valid for TPM 1.2 */
+		ret = -ENODEV;
+		break;
+	case TPM_UEFI:
+		/* Not implemented yet */
+		ret = -EBADRQC;
+		break;
+	}
+
+	tpmb_free(b);
+
+	if (ret)
+		goto out;
+
+	/*
+	 * On return, the code field is used for the return code out. Though
+	 * the commands specifications section 16.1 implies there is an
+	 * ordinal field, the return size and values point to this being
+	 * incorrect.
+	 *
+	 * Also tis_recv() converts the header back to CPU endianness.
+	 */
+	if (hdr->code != TPM_SUCCESS)
+		ret = -EAGAIN;
+
+	return ret;
+free:
+	tpmb_free(b);
+out:
+	return ret;
+}
diff --git a/arch/x86/boot/compressed/tpm/tpm2.h b/arch/x86/boot/compressed/tpm/tpm2.h
new file mode 100644
index 000000000000..b3a8bf5acaf0
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/tpm2.h
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Apertus Solutions, LLC
+ *
+ * Author(s):
+ *      Daniel P. Smith <dpsmith@apertussolutions.com>
+ *
+ * The definitions in this header are extracted and/or dervied from the
+ * Trusted Computing Group's TPM 2.0 Library Specification Parts 1&2.
+ *
+ */
+
+#ifndef _TPM2_H
+#define _TPM2_H
+
+#include "tpm_common.h"
+#include "tpm2_constants.h"
+
+
+/* Table 192  Definition of TPM2B_TEMPLATE Structure:
+ *   Using this as the base structure similar to the spec
+ */
+struct tpm2b {
+	u16 size;
+	u8 buffer[0];
+};
+
+// Table 32  Definition of TPMA_SESSION Bits <  IN/OUT>
+struct tpma_session {
+	u8 continue_session  : 1;
+	u8 audit_exclusive   : 1;
+	u8 audit_reset       : 1;
+	u8 reserved3_4       : 2;
+	u8 decrypt           : 1;
+	u8 encrypt           : 1;
+	u8 audit             : 1;
+};
+
+
+// Table 72  Definition of TPMT_HA Structure <  IN/OUT>
+struct tpmt_ha {
+	u16 alg;	/* TPMI_ALG_HASH	*/
+	u8 digest[0];	/* TPMU_HA		*/
+};
+
+// Table 100  Definition of TPML_DIGEST_VALUES Structure
+struct tpml_digest_values {
+	u32 count;
+	struct tpmt_ha digests[0];
+};
+
+
+// Table 124  Definition of TPMS_AUTH_COMMAND Structure <  IN>
+struct tpms_auth_cmd {
+	u32 *handle;
+	struct tpm2b *nonce;
+	struct tpma_session *attributes;
+	struct tpm2b *hmac;
+};
+
+// Table 125  Definition of TPMS_AUTH_RESPONSE Structure <  OUT>
+struct tpms_auth_resp {
+	struct tpm2b *nonce;
+	struct tpma_session *attributes;
+	struct tpm2b *hmac;
+};
+
+struct tpm2_cmd {
+	struct tpm_header *header;
+	u32 *handles;			/* TPM Handles array	*/
+	u32 *auth_size;			/* Size of Auth Area	*/
+	struct tpms_auth_cmd *auth;	/* Authorization Area	*/
+	u8 *params;			/* Parameters		*/
+	u8 *raw;			/* internal raw buffer	*/
+};
+
+struct tpm2_resp {
+	struct tpm_header *header;
+	u32 *handles;		/* TPM Handles array	*/
+	u32 *param_size;	/* Size of Parameters	*/
+	struct tpm2b *params;	/* Parameters		*/
+	u8 *auth;		/* Authorization Area	*/
+	u8 *raw;		/* internal raw buffer	*/
+};
+
+int tpm2_extend_pcr(struct tpm *t, u32 pcr,
+		struct tpml_digest_values *digests);
+
+#endif
diff --git a/arch/x86/boot/compressed/tpm/tpm2_auth.c b/arch/x86/boot/compressed/tpm/tpm2_auth.c
new file mode 100644
index 000000000000..cb80b644b719
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/tpm2_auth.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Apertus Solutions, LLC
+ *
+ * Author(s):
+ *      Daniel P. Smith <dpsmith@apertussolutions.com>
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <asm/byteorder.h>
+#include "tpm.h"
+#include "tpm2.h"
+#include "tpm2_constants.h"
+
+#define NULL_AUTH_SIZE 9
+
+u16 tpm2_null_auth_size(void)
+{
+	return NULL_AUTH_SIZE;
+}
+
+u16 tpm2_null_auth(struct tpms_auth_cmd *a)
+{
+	memset(a, 0, NULL_AUTH_SIZE);
+
+	*a->handle = cpu_to_be32(TPM_RS_PW);
+
+	return NULL_AUTH_SIZE;
+}
diff --git a/arch/x86/boot/compressed/tpm/tpm2_auth.h b/arch/x86/boot/compressed/tpm/tpm2_auth.h
new file mode 100644
index 000000000000..bc9d0f7dfeee
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/tpm2_auth.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Apertus Solutions, LLC
+ *
+ * Author(s):
+ *      Daniel P. Smith <dpsmith@apertussolutions.com>
+ *
+ * The definitions in this header are extracted and/or dervied from the
+ * Trusted Computing Group's TPM 2.0 Library Specification Parts 1&2.
+ *
+ */
+
+#ifndef _TPM2_AUTH_H
+#define _TPM2_AUTH_H
+
+#include "tpm2.h"
+
+u16 tpm2_null_auth_size(void);
+u16 tpm2_null_auth(struct tpms_auth_cmd *a);
+
+#endif
diff --git a/arch/x86/boot/compressed/tpm/tpm2_cmds.c b/arch/x86/boot/compressed/tpm/tpm2_cmds.c
new file mode 100644
index 000000000000..66a40905365b
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/tpm2_cmds.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Apertus Solutions, LLC
+ *
+ * Author(s):
+ *      Daniel P. Smith <dpsmith@apertussolutions.com>
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <asm/byteorder.h>
+#include "tpm.h"
+#include "tpmbuff.h"
+#include "tpm_common.h"
+#include "tpm2.h"
+#include "tpm2_auth.h"
+#include "tis.h"
+#include "crb.h"
+
+static int tpm2_alloc_cmd(struct tpmbuff *b, struct tpm2_cmd *c, u16 tag,
+		u32 code)
+{
+	c->header = (struct tpm_header *)tpmb_reserve(b);
+	if (!c->header)
+		return -ENOMEM;
+
+	c->header->tag = cpu_to_be16(tag);
+	c->header->code = cpu_to_be32(code);
+
+	return 0;
+}
+
+static u16 convert_digest_list(struct tpml_digest_values *digests)
+{
+	int i;
+	u16 size = sizeof(digests->count);
+	struct tpmt_ha *h = digests->digests;
+
+	for (i = 0; i < digests->count; i++) {
+		switch (h->alg) {
+		case TPM_ALG_SHA1:
+			h->alg = cpu_to_be16(h->alg);
+			h = (struct tpmt_ha *)((u8 *)h + SHA1_SIZE);
+			size += sizeof(u16) + SHA1_SIZE;
+			break;
+		case TPM_ALG_SHA256:
+			h->alg = cpu_to_be16(h->alg);
+			h = (struct tpmt_ha *)((u8 *)h + SHA256_SIZE);
+			size += sizeof(u16) + SHA256_SIZE;
+			break;
+		case TPM_ALG_SHA384:
+			h->alg = cpu_to_be16(h->alg);
+			h = (struct tpmt_ha *)((u8 *)h + SHA384_SIZE);
+			size += sizeof(u16) + SHA384_SIZE;
+			break;
+		case TPM_ALG_SHA512:
+			h->alg = cpu_to_be16(h->alg);
+			h = (struct tpmt_ha *)((u8 *)h + SHA512_SIZE);
+			size += sizeof(u16) + SHA512_SIZE;
+			break;
+		case TPM_ALG_SM3_256:
+			h->alg = cpu_to_be16(h->alg);
+			h = (struct tpmt_ha *)((u8 *)h + SM3256_SIZE);
+			size += sizeof(u16) + SHA1_SIZE;
+			break;
+		default:
+			return 0;
+		}
+	}
+
+	digests->count = cpu_to_be32(digests->count);
+
+	return size;
+}
+
+int tpm2_extend_pcr(struct tpm *t, u32 pcr,
+		struct tpml_digest_values *digests)
+{
+	struct tpmbuff *b = t->buff;
+	struct tpm2_cmd cmd;
+	u8 *ptr;
+	u16 size;
+	int ret = 0;
+
+	ret = tpm2_alloc_cmd(b, &cmd, TPM_ST_SESSIONS, TPM_CC_PCR_EXTEND);
+	if (ret < 0)
+		goto out;
+
+	cmd.handles = (u32 *)tpmb_put(b, sizeof(u32));
+	if (cmd.handles == NULL) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	cmd.handles[0] = cpu_to_be32(pcr);
+
+	cmd.auth_size = (u32 *)tpmb_put(b, sizeof(u32));
+	if (cmd.auth_size == NULL) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	cmd.auth = (struct tpms_auth_cmd *)tpmb_put(b, tpm2_null_auth_size());
+	if (cmd.auth == NULL) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	*cmd.auth_size = cpu_to_be32(tpm2_null_auth(cmd.auth));
+
+	size = convert_digest_list(digests);
+	if (size == 0) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	cmd.params = (u8 *)tpmb_put(b, size);
+	if (cmd.params == NULL) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	memcpy(cmd.params, digests, size);
+
+	cmd.header->size = cpu_to_be16(tpmb_size(b));
+
+	switch (t->intf) {
+	case TPM_DEVNODE:
+		/* Not implemented yet */
+		ret = -EBADRQC;
+		break;
+	case TPM_TIS:
+		ret = tis_send(b);
+		break;
+	case TPM_CRB:
+		ret = crb_send(b);
+		break;
+	case TPM_UEFI:
+		/* Not implemented yet */
+		ret = -EBADRQC;
+		break;
+	}
+
+free:
+	tpmb_free(b);
+out:
+	return ret;
+}
diff --git a/arch/x86/boot/compressed/tpm/tpm2_constants.h b/arch/x86/boot/compressed/tpm/tpm2_constants.h
new file mode 100644
index 000000000000..a1275e744ccd
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/tpm2_constants.h
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Apertus Solutions, LLC
+ *
+ * Author(s):
+ *      Daniel P. Smith <dpsmith@apertussolutions.com>
+ *
+ * The definitions in this header are extracted and/or dervied from the
+ * Trusted Computing Group's TPM 2.0 Library Specification Parts 1&2.
+ *
+ */
+
+#ifndef _TPM2_CONSTANTS_H
+#define _TPM2_CONSTANTS_H
+
+/* Table 9  Definition of (UINT16) TPM_ALG_ID Constants <IN/OUT, S> */
+#define TPM_ALG_ERROR                (u16)(0x0000)
+#define TPM_ALG_RSA                  (u16)(0x0001)
+#define TPM_ALG_SHA                  (u16)(0x0004)
+#define TPM_ALG_SHA1                 (u16)(0x0004)
+#define TPM_ALG_HMAC                 (u16)(0x0005)
+#define TPM_ALG_AES                  (u16)(0x0006)
+#define TPM_ALG_MGF1                 (u16)(0x0007)
+#define TPM_ALG_KEYEDHASH            (u16)(0x0008)
+#define TPM_ALG_XOR                  (u16)(0x000A)
+#define TPM_ALG_SHA256               (u16)(0x000B)
+#define TPM_ALG_SHA384               (u16)(0x000C)
+#define TPM_ALG_SHA512               (u16)(0x000D)
+#define TPM_ALG_NULL                 (u16)(0x0010)
+#define TPM_ALG_SM3_256              (u16)(0x0012)
+#define TPM_ALG_SM4                  (u16)(0x0013)
+#define TPM_ALG_RSASSA               (u16)(0x0014)
+#define TPM_ALG_RSAES                (u16)(0x0015)
+#define TPM_ALG_RSAPSS               (u16)(0x0016)
+#define TPM_ALG_OAEP                 (u16)(0x0017)
+#define TPM_ALG_ECDSA                (u16)(0x0018)
+#define TPM_ALG_ECDH                 (u16)(0x0019)
+#define TPM_ALG_ECDAA                (u16)(0x001A)
+#define TPM_ALG_SM2                  (u16)(0x001B)
+#define TPM_ALG_ECSCHNORR            (u16)(0x001C)
+#define TPM_ALG_ECMQV                (u16)(0x001D)
+#define TPM_ALG_KDF1_SP800_56A       (u16)(0x0020)
+#define TPM_ALG_KDF2                 (u16)(0x0021)
+#define TPM_ALG_KDF1_SP800_108       (u16)(0x0022)
+#define TPM_ALG_ECC                  (u16)(0x0023)
+#define TPM_ALG_SYMCIPHER            (u16)(0x0025)
+#define TPM_ALG_CAMELLIA             (u16)(0x0026)
+#define TPM_ALG_CTR                  (u16)(0x0040)
+#define TPM_ALG_OFB                  (u16)(0x0041)
+#define TPM_ALG_CBC                  (u16)(0x0042)
+#define TPM_ALG_CFB                  (u16)(0x0043)
+#define TPM_ALG_ECB                  (u16)(0x0044)
+#define TPM_ALG_FIRST                (u16)(0x0001)
+#define TPM_ALG_LAST                 (u16)(0x0044)
+
+/* Table 12  Definition of (UINT32) TPM_CC Constants (Numeric Order) <IN/OUT, S> */
+#define TPM_CC_PCR_EXTEND (u32)(0x00000182)
+
+/* Table 19  Definition of (UINT16) TPM_ST Constants <IN/OUT, S> */
+#define TPM_ST_NO_SESSIONS (u16)(0x8001)
+#define TPM_ST_SESSIONS (u16)(0x8002)
+
+/* Table 28  Definition of (TPM_HANDLE) TPM_RH Constants <S> */
+#define TPM_RS_PW (u32)(0x40000009)
+
+#endif
-- 
2.25.1

