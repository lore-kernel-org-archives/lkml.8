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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4CEC2D0E6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9086A2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LnuuDFrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgCYToA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:44:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37988 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgCYTn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:43:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PJdJV9019911;
        Wed, 25 Mar 2020 19:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=KuzM7ER1wQmW0K1BzS0UrXxIat5+rHyMI9dsz9hSbS8=;
 b=LnuuDFrOF9roSVM8rBvTchMJS5VEBoRrWyQQElxiXrB1z/OBZkEVVoBWtMgA/9RO8PNZ
 qLtHRljfbmipmgzZ4A5k2X4m6R86CgKvPzj1mr2zXMyKtztGU2yS7MRbpbC4Mm5qkYpv
 DWM/loL6G3SPdFjIoHfM+HhKwjqwTQP5HmL8odvN5xhdrVCZesFq5h4KmwahRQFMWbca
 xC033lk7uweauUNyQCRVEFCOMLuPenp2rMQFQr54ivii3HWxviciWe29673s+xRZsodf
 h2dZxpLh3gL1ebDNYjllSfTzrmIrEWC4illr1qPQxpFbFFDbUl702LA9XAY95O+8gDE1 hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ywabrbsq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 19:43:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PJfc5d105941;
        Wed, 25 Mar 2020 19:43:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3003gjc1p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 19:43:32 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02PJhV2n025363;
        Wed, 25 Mar 2020 19:43:31 GMT
Received: from pneuma.us.oracle.com (/10.39.203.246)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 12:43:31 -0700
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 06/12] x86: Add early general TPM interface support for Secure Launch
Date:   Wed, 25 Mar 2020 15:43:11 -0400
Message-Id: <20200325194317.526492-7-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325194317.526492-1-ross.philipson@oracle.com>
References: <20200325194317.526492-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

This commit exposes a minimal general interface for the compressed
kernel to request the required TPM operations to send measurements to
a TPM.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
---
 arch/x86/boot/compressed/Makefile  |   2 +-
 arch/x86/boot/compressed/tpm/tpm.c | 190 +++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/boot/compressed/tpm/tpm.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6c2beb306631..922223948499 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -98,7 +98,7 @@ vmlinux-objs-$(CONFIG_SECURE_LAUNCH_SHA256) += $(obj)/early_sha256.o
 vmlinux-objs-$(CONFIG_SECURE_LAUNCH_SHA512) += $(obj)/early_sha512.o
 vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/tpm/tpmio.o $(obj)/tpm/tpm_buff.o \
 	$(obj)/tpm/tis.o $(obj)/tpm/crb.o $(obj)/tpm/tpm1_cmds.o \
-	$(obj)/tpm/tpm2_cmds.o $(obj)/tpm/tpm2_auth.o
+	$(obj)/tpm/tpm2_cmds.o $(obj)/tpm/tpm2_auth.o $(obj)/tpm/tpm.o
 
 # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
 # can place it anywhere in memory and it will still run. However, since
diff --git a/arch/x86/boot/compressed/tpm/tpm.c b/arch/x86/boot/compressed/tpm/tpm.c
new file mode 100644
index 000000000000..85923d54dc04
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/tpm.c
@@ -0,0 +1,190 @@
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
+#include "tpm.h"
+#include "tpmbuff.h"
+#include "tis.h"
+#include "crb.h"
+#include "tpm_common.h"
+#include "tpm1.h"
+#include "tpm2.h"
+#include "tpm2_constants.h"
+
+static struct tpm tpm;
+
+static void find_interface_and_family(struct tpm *t)
+{
+	struct tpm_interface_id intf_id;
+	struct tpm_intf_capability intf_cap;
+
+	/* Sort out whether if it is 1.2 */
+	intf_cap.val = tpm_read32(TPM_INTF_CAPABILITY_0);
+	if ((intf_cap.interface_version == TPM12_TIS_INTF_12) ||
+	    (intf_cap.interface_version == TPM12_TIS_INTF_13)) {
+		t->family = TPM12;
+		t->intf = TPM_TIS;
+		return;
+	}
+
+	/* Assume that it is 2.0 and TIS */
+	t->family = TPM20;
+	t->intf = TPM_TIS;
+
+	/* Check if the interface is CRB */
+	intf_id.val = tpm_read32(TPM_INTERFACE_ID_0);
+	if (intf_id.interface_type == TPM_CRB_INTF_ACTIVE)
+		t->intf = TPM_CRB;
+}
+
+struct tpm *enable_tpm(void)
+{
+	struct tpm *t = &tpm;
+
+	find_interface_and_family(t);
+
+	switch (t->intf) {
+	case TPM_DEVNODE:
+		/* Not implemented yet */
+		break;
+	case TPM_TIS:
+		if (!tis_init(t))
+			goto err;
+		break;
+	case TPM_CRB:
+		if (!crb_init(t))
+			goto err;
+		break;
+	case TPM_UEFI:
+		/* Not implemented yet */
+		break;
+	}
+
+	/* TODO: ACPI TPM discovery */
+
+	return t;
+
+err:
+	return NULL;
+}
+
+u8 tpm_request_locality(struct tpm *t, u8 l)
+{
+	u8 ret = TPM_NO_LOCALITY;
+
+	switch (t->intf) {
+	case TPM_DEVNODE:
+		/* Not implemented yet */
+		break;
+	case TPM_TIS:
+		ret = tis_request_locality(l);
+		break;
+	case TPM_CRB:
+		ret = crb_request_locality(l);
+		break;
+	case TPM_UEFI:
+		/* Not implemented yet */
+		break;
+	}
+
+	if (ret < TPM_MAX_LOCALITY)
+		t->buff = alloc_tpmbuff(t->intf, ret);
+
+	return ret;
+}
+
+void tpm_relinquish_locality(struct tpm *t)
+{
+	switch (t->intf) {
+	case TPM_DEVNODE:
+		/* Not implemented yet */
+		break;
+	case TPM_TIS:
+		tis_relinquish_locality();
+		break;
+	case TPM_CRB:
+		crb_relinquish_locality();
+		break;
+	case TPM_UEFI:
+		/* Not implemented yet */
+		break;
+	}
+
+	free_tpmbuff(t->buff, t->intf);
+}
+
+#define MAX_TPM_EXTEND_SIZE 70 /* TPM2 SHA512 is the largest */
+int tpm_extend_pcr(struct tpm *t, u32 pcr, u16 algo,
+		u8 *digest)
+{
+	int ret = 0;
+
+	if (t->buff == NULL) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (t->family == TPM12) {
+		struct tpm_digest d;
+
+		if (algo != TPM_ALG_SHA1) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		d.pcr = pcr;
+		memcpy((void *)d.digest.sha1.digest,
+			digest, SHA1_DIGEST_SIZE);
+
+		ret = tpm1_pcr_extend(t, &d);
+	} else if (t->family == TPM20) {
+		struct tpml_digest_values *d;
+		u8 buf[MAX_TPM_EXTEND_SIZE];
+
+		d = (struct tpml_digest_values *) buf;
+		d->count = 1;
+		switch (algo) {
+		case TPM_ALG_SHA1:
+			d->digests->alg = TPM_ALG_SHA1;
+			memcpy(d->digests->digest, digest, SHA1_SIZE);
+			break;
+		case TPM_ALG_SHA256:
+			d->digests->alg = TPM_ALG_SHA256;
+			memcpy(d->digests->digest, digest, SHA256_SIZE);
+			break;
+		case TPM_ALG_SHA384:
+			d->digests->alg = TPM_ALG_SHA384;
+			memcpy(d->digests->digest, digest, SHA384_SIZE);
+			break;
+		case TPM_ALG_SHA512:
+			d->digests->alg = TPM_ALG_SHA512;
+			memcpy(d->digests->digest, digest, SHA512_SIZE);
+			break;
+		case TPM_ALG_SM3_256:
+			d->digests->alg = TPM_ALG_SM3_256;
+			memcpy(d->digests->digest, digest, SM3256_SIZE);
+			break;
+		default:
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = tpm2_extend_pcr(t, pcr, d);
+	} else {
+		ret = -EINVAL;
+	}
+out:
+	return ret;
+}
+
+void free_tpm(struct tpm *t)
+{
+	tpm_relinquish_locality(t);
+}
-- 
2.25.1

