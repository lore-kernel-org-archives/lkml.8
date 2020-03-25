Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9564CC2D0E6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5F820740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WJOV0JMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgCYToK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:44:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50986 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbgCYTn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:43:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PJeMF0126853;
        Wed, 25 Mar 2020 19:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=x93GzvC3CMf7UyKP0EauWpyueSzlKKQhUBj1fTAf/W0=;
 b=WJOV0JMwxWRfAgQlqj+GfX5Gmz87rx01mLuQe5wmNFZtGDaeaWJB3KxkYi1ycgOeO0Sh
 cXC/64KiYFOmtrmheGQ9QOWGU9+yBD6gdRmc3PAH41NfaV1aNhEVMA0HfEu3GCkgzEZe
 J6fB4QEcOsqhayBw/sJal4i3tN5IFHj51vfG2VN5WA1Guv0lv9CWuFzusupNuSBrYbvk
 xp1ZI9dlYcdFU3xN2+wWBaOskmHYz4V+XjwvFwfzOg+TuOWJQJQbivoHC5sx7HPRNbri
 q0VU/Px+E6lXVxiG72owH9+HSXiqp3fXDggftVKaJHKUdIB6FpAZ0sUqKIuoqBnhZAwz Lw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3005kvasye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 19:43:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PJgkYO073009;
        Wed, 25 Mar 2020 19:43:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30073b1u0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 19:43:30 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02PJhTVB008213;
        Wed, 25 Mar 2020 19:43:29 GMT
Received: from pneuma.us.oracle.com (/10.39.203.246)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 12:43:28 -0700
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 04/12] x86: Add early TPM TIS/CRB interface support for Secure Launch
Date:   Wed, 25 Mar 2020 15:43:09 -0400
Message-Id: <20200325194317.526492-5-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325194317.526492-1-ross.philipson@oracle.com>
References: <20200325194317.526492-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=2 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250157
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

The Secure Launch capability that is part of the compressed kernel
requires the ability to send measurements it takes to the TPM. This
commit introduces the necessary code to communicate with the hardware
interface of TPM devices.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
---
 arch/x86/boot/compressed/Makefile         |   2 +
 arch/x86/boot/compressed/tpm/crb.c        | 302 ++++++++++++++++++++++
 arch/x86/boot/compressed/tpm/crb.h        |  25 ++
 arch/x86/boot/compressed/tpm/tis.c        | 212 +++++++++++++++
 arch/x86/boot/compressed/tpm/tis.h        |  51 ++++
 arch/x86/boot/compressed/tpm/tpm.h        |  42 +++
 arch/x86/boot/compressed/tpm/tpm_buff.c   | 135 ++++++++++
 arch/x86/boot/compressed/tpm/tpm_common.h | 127 +++++++++
 arch/x86/boot/compressed/tpm/tpmbuff.h    |  34 +++
 arch/x86/boot/compressed/tpm/tpmio.c      |  51 ++++
 10 files changed, 981 insertions(+)
 create mode 100644 arch/x86/boot/compressed/tpm/crb.c
 create mode 100644 arch/x86/boot/compressed/tpm/crb.h
 create mode 100644 arch/x86/boot/compressed/tpm/tis.c
 create mode 100644 arch/x86/boot/compressed/tpm/tis.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpm_buff.c
 create mode 100644 arch/x86/boot/compressed/tpm/tpm_common.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpmbuff.h
 create mode 100644 arch/x86/boot/compressed/tpm/tpmio.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 1f25bbdd72fb..b9682eaf8f59 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -96,6 +96,8 @@ vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o
 vmlinux-objs-$(CONFIG_SECURE_LAUNCH_SHA256) += $(obj)/early_sha256.o
 vmlinux-objs-$(CONFIG_SECURE_LAUNCH_SHA512) += $(obj)/early_sha512.o
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/tpm/tpmio.o $(obj)/tpm/tpm_buff.o \
+	$(obj)/tpm/tis.o $(obj)/tpm/crb.o
 
 # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
 # can place it anywhere in memory and it will still run. However, since
diff --git a/arch/x86/boot/compressed/tpm/crb.c b/arch/x86/boot/compressed/tpm/crb.c
new file mode 100644
index 000000000000..7df29cb3688d
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/crb.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Apertus Solutions, LLC
+ *
+ * Author(s):
+ *      Daniel P. Smith <dpsmith@apertussolutions.com>
+ */
+
+#include <linux/types.h>
+#include "tpm.h"
+#include "tpmbuff.h"
+#include "crb.h"
+#include "tpm_common.h"
+
+#define TPM_LOC_STATE		0x0000
+#define TPM_LOC_CTRL		0x0008
+#define TPM_LOC_STS		0x000C
+#define TPM_CRB_INTF_ID		0x0030
+#define TPM_CRB_CTRL_EXT	0x0038
+#define TPM_CRB_CTRL_REQ	0x0040
+#define TPM_CRB_CTRL_STS	0x0044
+#define TPM_CRB_CTRL_CANCEL	0x0048
+#define TPM_CRB_CTRL_START	0x004C
+#define TPM_CRB_INT_ENABLE	0x0050
+#define TPM_CRB_INT_STS		0x0054
+#define TPM_CRB_CTRL_CMD_SIZE	0x0058
+#define TPM_CRB_CTRL_CMD_LADDR	0x005C
+#define TPM_CRB_CTRL_CMD_HADDR	0x0060
+#define TPM_CRB_CTRL_RSP_SIZE	0x0064
+#define TPM_CRB_CTRL_RSP_ADDR	0x0068
+#define TPM_CRB_DATA_BUFFER	0x0080
+
+#define REGISTER(l, r)		(((l) << 12) | r)
+
+static u8 locality = TPM_NO_LOCALITY;
+
+struct tpm_loc_state {
+	union {
+		u8 val;
+		struct {
+			u8 tpm_established:1;
+			u8 loc_assigned:1;
+			u8 active_locality:3;
+			u8 _reserved:2;
+			u8 tpm_reg_valid_sts:1;
+		};
+	};
+} __packed;
+
+struct tpm_loc_ctrl {
+	union {
+		u32 val;
+		struct {
+			u32 request_access:1;
+			u32 relinquish:1;
+			u32 seize:1;
+			u32 reset_establishment_bit:1;
+			u32 _reserved:28;
+		};
+	};
+} __packed;
+
+struct tpm_loc_sts {
+	union {
+		u32 val;
+		struct {
+			u32 granted:1;
+			u32 beenSeized:1;
+			u32 _reserved:30;
+		};
+	};
+} __packed;
+
+struct tpm_crb_ctrl_req {
+	union {
+		u32 val;
+		struct {
+			u32 cmd_ready:1;
+			u32 go_idle:1;
+			u32 _reserved:30;
+		};
+	};
+} __packed;
+
+struct tpm_crb_ctrl_sts {
+	union {
+		u32 val;
+		struct {
+			u32 tpm_sts:1;
+			u32 tpm_idle:1;
+			u32 _reserved:30;
+		};
+	};
+} __packed;
+
+struct tpm_crb_intf_id_ext {
+	union {
+		u32 val;
+		struct {
+			u32 vid:16;
+			u32 did:16;
+		};
+	};
+} __packed;
+
+/*
+ * Durations derived from Table 15 of the PTP but is purely an artifact of this
+ * implementation
+ */
+
+/* TPM Duration A: 20ms */
+static void duration_a(void)
+{
+	tpm_mdelay(20);
+}
+
+/* TPM Duration B: 750ms */
+static void duration_b(void)
+{
+	tpm_mdelay(750);
+}
+
+/* TPM Duration C: 1000ms */
+static void duration_c(void)
+{
+	tpm_mdelay(1000);
+}
+
+static u8 is_idle(void)
+{
+	struct tpm_crb_ctrl_sts ctl_sts;
+
+	ctl_sts.val = tpm_read32(REGISTER(locality, TPM_CRB_CTRL_STS));
+	if (ctl_sts.tpm_idle == 1)
+		return 1;
+
+	return 0;
+}
+
+static u8 is_ready(void)
+{
+	struct tpm_crb_ctrl_sts ctl_sts;
+
+	ctl_sts.val = tpm_read32(REGISTER(locality, TPM_CRB_CTRL_STS));
+	return ctl_sts.val == 0;
+}
+
+static u8 is_cmd_exec(void)
+{
+	u32 ctrl_start;
+
+	ctrl_start = tpm_read32(REGISTER(locality, TPM_CRB_CTRL_START));
+	if (ctrl_start == 1)
+		return 1;
+
+	return 0;
+}
+
+static u8 cmd_ready(void)
+{
+	struct tpm_crb_ctrl_req ctl_req;
+
+	if (is_idle()) {
+		ctl_req.cmd_ready = 1;
+		tpm_write32(ctl_req.val, REGISTER(locality, TPM_CRB_CTRL_REQ));
+		tpm2_timeout_c();
+
+		if (is_idle())
+			return -1;
+	}
+
+	return 0;
+}
+
+static void go_idle(void)
+{
+	struct tpm_crb_ctrl_req ctl_req;
+
+	if (is_idle())
+		return;
+
+	ctl_req.go_idle = 1;
+	tpm_write32(ctl_req.val, REGISTER(locality, TPM_CRB_CTRL_REQ));
+
+	/* pause to give tpm time to complete the request */
+	tpm2_timeout_c();
+}
+
+static void crb_relinquish_locality_internal(u16 l)
+{
+	struct tpm_loc_ctrl loc_ctrl;
+
+	loc_ctrl.relinquish = 1;
+
+	tpm_write32(loc_ctrl.val, REGISTER(l, TPM_LOC_CTRL));
+}
+
+u8 crb_request_locality(u8 l)
+{
+	struct tpm_loc_state loc_state;
+	struct tpm_loc_ctrl loc_ctrl;
+	struct tpm_loc_sts loc_sts;
+
+	/* TPM_LOC_STATE is aliased across all localities */
+	loc_state.val = tpm_read8(REGISTER(0, TPM_LOC_STATE));
+
+	if (loc_state.loc_assigned == 1) {
+		if (loc_state.active_locality == l) {
+			locality = l;
+			return locality;
+		}
+
+		crb_relinquish_locality_internal(loc_state.loc_assigned);
+	}
+
+	loc_ctrl.request_access = 1;
+	tpm_write32(loc_ctrl.val, REGISTER(l, TPM_LOC_CTRL));
+
+	loc_sts.val = tpm_read32(REGISTER(l, TPM_LOC_STS));
+	if (loc_sts.granted != 1) {
+		locality = TPM_NO_LOCALITY;
+		return locality;
+	}
+
+	locality = l;
+	return locality;
+}
+
+void crb_relinquish_locality(void)
+{
+	crb_relinquish_locality_internal(locality);
+}
+
+u8 crb_init(struct tpm *t)
+{
+	u8 i;
+	struct tpm_crb_intf_id_ext id;
+
+	for (i = 0; i <= TPM_MAX_LOCALITY; i++)
+		crb_relinquish_locality_internal(i);
+
+	if (crb_request_locality(0) == TPM_NO_LOCALITY)
+		return 0;
+
+	id.val = tpm_read32(REGISTER(0, TPM_CRB_INTF_ID + 4));
+	t->vendor = ((id.vid & 0x00FF) << 8) | ((id.vid & 0xFF00) >> 8);
+	if ((t->vendor & 0xFFFF) == 0xFFFF)
+		return 0;
+
+	/* have the tpm invalidate the buffer if left in completion state */
+	go_idle();
+	/* now move to ready state */
+	cmd_ready();
+
+	return 1;
+}
+
+/* assumes cancel will succeed */
+static void cancel_send(void)
+{
+	if (is_cmd_exec()) {
+		tpm_write32(1, REGISTER(locality, TPM_CRB_CTRL_CANCEL));
+		timeout_b();
+
+		tpm_write32(0, REGISTER(locality, TPM_CRB_CTRL_CANCEL));
+	}
+}
+
+size_t crb_send(struct tpmbuff *buf)
+{
+	u32 ctrl_start = 1;
+	u8 count = 0;
+
+	if (is_idle())
+		return 0;
+
+	tpm_write32(ctrl_start, REGISTER(locality, TPM_CRB_CTRL_START));
+
+	/*
+	 * Most command sequences this code is interested with operates with
+	 * 20/750 duration/timeout schedule
+	 */
+	duration_a();
+	ctrl_start = tpm_read32(REGISTER(locality, TPM_CRB_CTRL_START));
+	if (ctrl_start != 0) {
+		timeout_a();
+		ctrl_start = tpm_read32(REGISTER(locality, TPM_CRB_CTRL_START));
+		if (ctrl_start != 0) {
+			cancel_send();
+			/* minimum response is header with cancel ord */
+			return sizeof(struct tpm_header);
+		}
+	}
+
+	return buf->len;
+}
+
+size_t crb_recv(struct tpmbuff *buf)
+{
+	/* noop, currently send waits until execution is complete*/
+	return 0;
+}
diff --git a/arch/x86/boot/compressed/tpm/crb.h b/arch/x86/boot/compressed/tpm/crb.h
new file mode 100644
index 000000000000..7b39a9dcd7de
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/crb.h
@@ -0,0 +1,25 @@
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
+#ifndef _CRB_H
+#define _CRB_H
+
+#include "tpm.h"
+
+/* TPM Interface Specification functions */
+u8 crb_request_locality(u8 l);
+void crb_relinquish_locality(void);
+u8 crb_init(struct tpm *t);
+size_t crb_send(struct tpmbuff *buf);
+size_t crb_recv(struct tpmbuff *buf);
+
+#endif
diff --git a/arch/x86/boot/compressed/tpm/tis.c b/arch/x86/boot/compressed/tpm/tis.c
new file mode 100644
index 000000000000..587dc3b53155
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/tis.c
@@ -0,0 +1,212 @@
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
+#include <linux/types.h>
+#include <asm/byteorder.h>
+#include "tpm.h"
+#include "tpmbuff.h"
+#include "tpm_common.h"
+#include "tis.h"
+
+#define TPM_BURST_MIN_DELAY 100 /* 100us */
+
+static u8 locality = TPM_NO_LOCALITY;
+
+static u32 burst_wait(void)
+{
+	u32 count = 0;
+
+	while (count == 0) {
+		count = tpm_read8(STS(locality) + 1);
+		count += tpm_read8(STS(locality) + 2) << 8;
+
+		/* Wait for FIFO to drain */
+		if (count == 0)
+			tpm_udelay(TPM_BURST_MIN_DELAY);
+	}
+
+	return count;
+}
+
+void tis_relinquish_locality(void)
+{
+	if (locality < TPM_MAX_LOCALITY)
+		tpm_write8(ACCESS_RELINQUISH_LOCALITY, ACCESS(locality));
+
+	locality = TPM_NO_LOCALITY;
+}
+
+u8 tis_request_locality(u8 l)
+{
+	if (l > TPM_MAX_LOCALITY)
+		return TPM_NO_LOCALITY;
+
+	if (l == locality)
+		return locality;
+
+	tis_relinquish_locality();
+
+	tpm_write8(ACCESS_REQUEST_USE, ACCESS(l));
+
+	/* wait for locality to be granted */
+	if (tpm_read8(ACCESS(l)) & ACCESS_ACTIVE_LOCALITY)
+		locality = l;
+
+	return locality;
+}
+
+u8 tis_init(struct tpm *t)
+{
+	locality = TPM_NO_LOCALITY;
+
+	if (tis_request_locality(0) != 0)
+		return 0;
+
+	t->vendor = tpm_read32(DID_VID(0));
+	if ((t->vendor & 0xFFFF) == 0xFFFF)
+		return 0;
+
+	return 1;
+}
+
+size_t tis_send(struct tpmbuff *buf)
+{
+	u8 status, *buf_ptr;
+	u32 burstcnt = 0;
+	u32 count = 0;
+
+	if (locality > TPM_MAX_LOCALITY)
+		return 0;
+
+	for (status = 0; (status & STS_COMMAND_READY) == 0; ) {
+		tpm_write8(STS_COMMAND_READY, STS(locality));
+		status = tpm_read8(STS(locality));
+	}
+
+	buf_ptr = buf->head;
+
+	/* send all but the last byte */
+	while (count < (buf->len - 1)) {
+		burstcnt = burst_wait();
+		for (; burstcnt > 0 && count < (buf->len - 1); burstcnt--) {
+			tpm_write8(buf_ptr[count], DATA_FIFO(locality));
+			count++;
+		}
+
+		/* check for overflow */
+		for (status = 0; (status & STS_VALID) == 0; )
+			status = tpm_read8(STS(locality));
+
+		if ((status & STS_DATA_EXPECT) == 0)
+			return 0;
+	}
+
+	/* write last byte */
+	tpm_write8(buf_ptr[buf->len - 1], DATA_FIFO(locality));
+	count++;
+
+	/* make sure it stuck */
+	for (status = 0; (status & STS_VALID) == 0; )
+		status = tpm_read8(STS(locality));
+
+	if ((status & STS_DATA_EXPECT) != 0)
+		return 0;
+
+	/* go and do it */
+	tpm_write8(STS_GO, STS(locality));
+
+	return (size_t)count;
+}
+
+static size_t recv_data(unsigned char *buf, size_t len)
+{
+	size_t size = 0;
+	u8 status, *bufptr;
+	u32 burstcnt = 0;
+
+	bufptr = (u8 *)buf;
+
+	while (tis_data_available(locality) && size < len) {
+		burstcnt = burst_wait();
+		for (; burstcnt > 0 && size < len; burstcnt--) {
+			*bufptr = tpm_read8(DATA_FIFO(locality));
+			bufptr++;
+			size++;
+		}
+	}
+
+	return size;
+}
+
+size_t tis_recv(enum tpm_family f, struct tpmbuff *buf)
+{
+	u32 expected;
+	u8 status, *buf_ptr;
+	struct tpm_header *hdr;
+
+	if (locality > TPM_MAX_LOCALITY)
+		goto err;
+
+	/* ensure that there is data available */
+	if (!tis_data_available(locality)) {
+		if (f == TPM12)
+			tpm1_timeout_d();
+		else
+			tpm2_timeout_d();
+
+		if (!tis_data_available(locality))
+			goto err;
+	}
+
+	/* read header */
+	hdr = (struct tpm_header *)buf->head;
+	expected = sizeof(struct tpm_header);
+	if (recv_data(buf->head, expected) < expected)
+		goto err;
+
+	/* convert header */
+	hdr->tag = be16_to_cpu(hdr->tag);
+	hdr->size = be32_to_cpu(hdr->size);
+	hdr->code = be32_to_cpu(hdr->code);
+
+	/* protect against integer underflow */
+	if (hdr->size <= expected)
+		goto err;
+
+	/* hdr->size = header + data */
+	expected = hdr->size - expected;
+	buf_ptr = tpmb_put(buf, expected);
+	if (!buf_ptr)
+		goto err;
+
+	/* read all data, except last byte */
+	if (recv_data(buf_ptr, expected - 1) < (expected - 1))
+		goto err;
+
+	/* check for receive underflow */
+	if (!tis_data_available(locality))
+		goto err;
+
+	/* read last byte */
+	if (recv_data(buf_ptr, 1) != 1)
+		goto err;
+
+	/* make sure we read everything */
+	if (tis_data_available(locality))
+		goto err;
+
+	tpm_write8(STS_COMMAND_READY, STS(locality));
+
+	return hdr->size;
+err:
+	return 0;
+}
diff --git a/arch/x86/boot/compressed/tpm/tis.h b/arch/x86/boot/compressed/tpm/tis.h
new file mode 100644
index 000000000000..cb0b252eeec4
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/tis.h
@@ -0,0 +1,51 @@
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
+#ifndef _TIS_H
+#define _TIS_H
+
+#include "tpm.h"
+#include "tpm_common.h"
+
+/* macros to access registers at locality ’’l’’ */
+#define ACCESS(l)			(0x0000 | ((l) << 12))
+#define STS(l)				(0x0018 | ((l) << 12))
+#define DATA_FIFO(l)			(0x0024 | ((l) << 12))
+#define DID_VID(l)			(0x0F00 | ((l) << 12))
+/* access bits */
+#define ACCESS_ACTIVE_LOCALITY		0x20 /* (R)*/
+#define ACCESS_RELINQUISH_LOCALITY	0x20 /* (W) */
+#define ACCESS_REQUEST_USE		0x02 /* (W) */
+/* status bits */
+#define STS_VALID			0x80 /* (R) */
+#define STS_COMMAND_READY		0x40 /* (R) */
+#define STS_DATA_AVAIL			0x10 /* (R) */
+#define STS_DATA_EXPECT			0x08 /* (R) */
+#define STS_GO				0x20 /* (W) */
+
+static inline bool tis_data_available(int locality)
+{
+	int status;
+
+	status = tpm_read8(STS(locality));
+	return ((status & (STS_DATA_AVAIL | STS_VALID)) ==
+		(STS_DATA_AVAIL | STS_VALID));
+}
+
+/* TPM Interface Specification functions */
+u8 tis_request_locality(u8 l);
+void tis_relinquish_locality(void);
+u8 tis_init(struct tpm *t);
+size_t tis_send(struct tpmbuff *buf);
+size_t tis_recv(enum tpm_family f, struct tpmbuff *buf);
+
+#endif
diff --git a/arch/x86/boot/compressed/tpm/tpm.h b/arch/x86/boot/compressed/tpm/tpm.h
new file mode 100644
index 000000000000..45d12e424809
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/tpm.h
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Apertus Solutions, LLC
+ *
+ * Author(s):
+ *      Daniel P. Smith <dpsmith@apertussolutions.com>
+ *
+ */
+
+#ifndef _TPM_H
+#define _TPM_H
+
+#define TPM_NO_LOCALITY		0xFF
+
+enum tpm_hw_intf {
+	TPM_DEVNODE,
+	TPM_TIS,
+	TPM_CRB,
+	TPM_UEFI
+};
+
+enum tpm_family {
+	TPM12,
+	TPM20
+};
+
+struct tpmbuff;
+
+struct tpm {
+	u32 vendor;
+	enum tpm_family family;
+	enum tpm_hw_intf intf;
+	struct tpmbuff *buff;
+};
+
+extern struct tpm *enable_tpm(void);
+extern u8 tpm_request_locality(struct tpm *t, u8 l);
+extern void tpm_relinquish_locality(struct tpm *t);
+extern int tpm_extend_pcr(struct tpm *t, u32 pcr, u16 algo,
+		u8 *digest);
+extern void free_tpm(struct tpm *t);
+#endif
diff --git a/arch/x86/boot/compressed/tpm/tpm_buff.c b/arch/x86/boot/compressed/tpm/tpm_buff.c
new file mode 100644
index 000000000000..7bb684c127be
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/tpm_buff.c
@@ -0,0 +1,135 @@
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
+#include "tpm.h"
+#include "tpmbuff.h"
+#include "tpm_common.h"
+
+#define STATIC_TIS_BUFFER_SIZE		1024
+
+#define TPM_CRB_DATA_BUFFER_OFFSET	0x80
+#define TPM_CRB_DATA_BUFFER_SIZE	3966
+
+u8 *tpmb_reserve(struct tpmbuff *b)
+{
+	if (b->locked)
+		return NULL;
+
+	b->len = sizeof(struct tpm_header);
+	b->locked = 1;
+	b->data = b->head + b->len;
+	b->tail = b->data;
+
+	return b->head;
+}
+
+void tpmb_free(struct tpmbuff *b)
+{
+	memset(b->head, 0, b->len);
+
+	b->len = 0;
+	b->locked = 0;
+	b->data = NULL;
+	b->tail = NULL;
+}
+
+u8 *tpmb_put(struct tpmbuff *b, size_t size)
+{
+	u8 *tail = b->tail;
+
+	if ((b->len + size) > b->truesize)
+		return NULL; /* TODO: add overflow buffer support */
+
+	b->tail += size;
+	b->len += size;
+
+	return tail;
+}
+
+size_t tpmb_trim(struct tpmbuff *b, size_t size)
+{
+	if (b->len < size)
+		size = b->len;
+
+	/* TODO: add overflow buffer support */
+
+	b->tail -= size;
+	b->len -= size;
+
+	return size;
+}
+
+size_t tpmb_size(struct tpmbuff *b)
+{
+	return b->len;
+}
+
+static u8 tis_buff[STATIC_TIS_BUFFER_SIZE];
+static struct tpmbuff tpm_buff;
+
+struct tpmbuff *alloc_tpmbuff(enum tpm_hw_intf intf, u8 locality)
+{
+	struct tpmbuff *b = &tpm_buff;
+
+	switch (intf) {
+	case TPM_DEVNODE:
+		/* TODO: need implementation */
+		goto err;
+	case TPM_TIS:
+		if (b->head)
+			goto reset;
+
+		b->head = (u8 *)&tis_buff;
+		b->truesize = STATIC_TIS_BUFFER_SIZE;
+		break;
+	case TPM_CRB:
+		b->head = (u8 *)(u64)(TPM_MMIO_BASE + (locality << 12)
+			       + TPM_CRB_DATA_BUFFER_OFFSET);
+		b->truesize = TPM_CRB_DATA_BUFFER_SIZE;
+		break;
+	case TPM_UEFI:
+		/* Not implemented yet */
+		goto err;
+	default:
+		goto err;
+	}
+
+reset:
+	b->len = 0;
+	b->locked = 0;
+	b->data = NULL;
+	b->tail = NULL;
+	b->end = b->head + (b->truesize - 1);
+
+	return b;
+
+err:
+	return NULL;
+}
+
+void free_tpmbuff(struct tpmbuff *b, enum tpm_hw_intf intf)
+{
+	switch (intf) {
+	case TPM_DEVNODE:
+		/* Not implemented yet */
+		break;
+	case TPM_TIS:
+		b->head = NULL;
+		break;
+	case TPM_CRB:
+		b->head = NULL;
+		break;
+	case TPM_UEFI:
+		/* Not implemented yet */
+		break;
+	default:
+		break;
+	}
+}
diff --git a/arch/x86/boot/compressed/tpm/tpm_common.h b/arch/x86/boot/compressed/tpm/tpm_common.h
new file mode 100644
index 000000000000..0ed86edda9b4
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/tpm_common.h
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Apertus Solutions, LLC
+ *
+ * Author(s):
+ *      Daniel P. Smith <dpsmith@apertussolutions.com>
+ *
+ */
+
+#ifndef _TPM_COMMON_H
+#define _TPM_COMMON_H
+
+#define TPM_MMIO_BASE		0xFED40000
+#define TPM_MAX_LOCALITY	4
+
+#define SHA1_SIZE	20
+#define SHA256_SIZE	32
+#define SHA384_SIZE	48
+#define SHA512_SIZE	64
+#define SM3256_SIZE	32
+
+struct tpm_header {
+	u16 tag;
+	u32 size;
+	u32 code;
+} __packed;
+
+#define TPM_INTERFACE_ID_0	0x30
+#define TPM_TIS_INTF_ACTIVE	0x00
+#define TPM_CRB_INTF_ACTIVE	0x01
+
+struct tpm_interface_id {
+	union {
+		u32 val;
+		struct {
+			u32 interface_type:4;
+			u32 interface_version:4;
+			u32 cap_locality:1;
+			u32 reserved1:4;
+			u32 cap_tis:1;
+			u32 cap_crb:1;
+			u32 cap_if_res:2;
+			u32 interface_selector:2;
+			u32 intf_sel_lock:1;
+			u32 reserved2:4;
+			u32 reserved3:8;
+		};
+	};
+} __packed;
+
+#define TPM_INTF_CAPABILITY_0	0x14
+#define TPM12_TIS_INTF_12	0x00
+#define TPM12_TIS_INTF_13	0x02
+#define TPM20_TIS_INTF_13	0x03
+
+struct tpm_intf_capability {
+	union {
+		u32 val;
+		struct {
+			u32 data_avail_int_support:1;
+			u32 sts_valid_int_support:1;
+			u32 locality_change_int_support:1;
+			u32 interrupt_level_high:1;
+			u32 interrupt_level_low:1;
+			u32 interrupt_edge_rising:1;
+			u32 interrupt_edge_falling:1;
+			u32 command_ready_int_support:1;
+			u32 burst_count_static:1;
+			u32 data_transfer_size_support:2;
+			u32 reserved1:17;
+			u32 interface_version:3;
+			u32 reserved2:1;
+		};
+	};
+} __packed;
+
+void tpm_udelay(int loops);
+void tpm_mdelay(int ms);
+
+/*
+ * Timeouts defined in Table 16 from the TPM2 PTP and
+ * Table 15 from the PC Client TIS
+ */
+
+/* TPM Timeout A: 750ms */
+static inline void timeout_a(void)
+{
+	tpm_mdelay(750);
+}
+
+/* TPM Timeout B: 2000ms */
+static inline void timeout_b(void)
+{
+	tpm_mdelay(2000);
+}
+
+/* Timeouts C & D are different between 1.2 & 2.0 */
+/* TPM1.2 Timeout C: 750ms */
+static inline void tpm1_timeout_c(void)
+{
+	tpm_mdelay(750);
+}
+
+/* TPM1.2 Timeout D: 750ms */
+static inline void tpm1_timeout_d(void)
+{
+	tpm_mdelay(750);
+}
+
+/* TPM2 Timeout C: 200ms */
+static inline void tpm2_timeout_c(void)
+{
+	tpm_mdelay(200);
+}
+
+/* TPM2 Timeout D: 30ms */
+static inline void tpm2_timeout_d(void)
+{
+	tpm_mdelay(30);
+}
+
+u8 tpm_read8(u32 field);
+void tpm_write8(unsigned char val, u32 field);
+u32 tpm_read32(u32 field);
+void tpm_write32(unsigned int val, u32 field);
+
+#endif
diff --git a/arch/x86/boot/compressed/tpm/tpmbuff.h b/arch/x86/boot/compressed/tpm/tpmbuff.h
new file mode 100644
index 000000000000..8f51fd2ea16e
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/tpmbuff.h
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Apertus Solutions, LLC
+ *
+ * Author(s):
+ *      Daniel P. Smith <dpsmith@apertussolutions.com>
+ *
+ */
+
+#ifndef _TPMBUFF_H
+#define _TPMBUFF_H
+
+/* mirroring Linux SKB */
+struct tpmbuff {
+	size_t truesize;
+	size_t len;
+
+	u8 locked;
+
+	u8 *head;
+	u8 *data;
+	u8 *tail;
+	u8 *end;
+};
+
+u8 *tpmb_reserve(struct tpmbuff *b);
+void tpmb_free(struct tpmbuff *b);
+u8 *tpmb_put(struct tpmbuff *b, size_t size);
+size_t tpmb_trim(struct tpmbuff *b, size_t size);
+size_t tpmb_size(struct tpmbuff *b);
+struct tpmbuff *alloc_tpmbuff(enum tpm_hw_intf i, u8 locality);
+void free_tpmbuff(struct tpmbuff *b, enum tpm_hw_intf i);
+
+#endif
diff --git a/arch/x86/boot/compressed/tpm/tpmio.c b/arch/x86/boot/compressed/tpm/tpmio.c
new file mode 100644
index 000000000000..9481faed3521
--- /dev/null
+++ b/arch/x86/boot/compressed/tpm/tpmio.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Apertus Solutions, LLC
+ *
+ * Author(s):
+ *      Daniel P. Smith <dpsmith@apertussolutions.com>
+ */
+
+#include <linux/types.h>
+#include <asm/io.h>
+#include "tpm_common.h"
+
+static noinline void tpm_io_delay(void)
+{
+	/* This is the default delay type in native_io_delay */
+	asm volatile ("outb %al, $0x80");
+}
+
+void tpm_udelay(int loops)
+{
+	while (loops--)
+		tpm_io_delay();	/* Approximately 1 us */
+}
+
+void tpm_mdelay(int ms)
+{
+	int i;
+
+	for (i = 0; i < ms; i++)
+		tpm_udelay(1000);
+}
+
+u8 tpm_read8(u32 field)
+{
+	return readb((void *)(u64)(TPM_MMIO_BASE | field));
+}
+
+void tpm_write8(unsigned char val, u32 field)
+{
+	writeb(val, (void *)(u64)(TPM_MMIO_BASE | field));
+}
+
+u32 tpm_read32(u32 field)
+{
+	return readl((void *)(u64)(TPM_MMIO_BASE | field));
+}
+
+void tpm_write32(u32 val, u32 field)
+{
+	writel(val, (void *)(u64)(TPM_MMIO_BASE | field));
+}
-- 
2.25.1

