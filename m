Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF2EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB9F206A5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fRKv7lRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgEDXY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:24:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40192 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgEDXY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:24:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NNaxM190740;
        Mon, 4 May 2020 23:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=U9MsE8YG2XA+6eWHIBqjagX72ut5XbC/DYIUDNw4JjM=;
 b=fRKv7lRijU3c08AnnVripNEEzP2/cn27a/3vJeN3SpHe8jFanH4PL8Sg76CJNv1TIk5G
 rfpQSpo5Ug3rf1rQoOMxZtmu4t/CsUL3wLLeZzSGgJKWgX16BxhfrixxaMsbooGQCJOa
 Tu5qCBBgnxG7oTXckryftjhGzA8e7Zebff5tmMtGZw3upwr+VNkU712SmZmCeEfvQ/3h
 jkXKtupfJjFqL5dCSdG6NCNlMlToGiaU+WASwV/PDpWPHplQ3U9eF0yFADDnRPqh/q17
 Ot9AhKrcnLfI8s5qE5I8bLwDrejOOK48dJMJe8EegmCaoTMxScTrPdr2SqL3Y0Bzg/b1 RA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30s09r1v3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:24:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NLcPt139999;
        Mon, 4 May 2020 23:22:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30t1r3j0t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:39 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044NMbGG001531;
        Mon, 4 May 2020 23:22:37 GMT
Received: from tomti.i.net-space.pl (/10.175.189.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 16:22:36 -0700
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     grub-devel@gnu.org, linux-kernel@vger.kernel.org,
        trenchboot-devel@googlegroups.com, x86@kernel.org
Cc:     alexander.burmashev@oracle.com, andrew.cooper3@citrix.com,
        ard.biesheuvel@linaro.org, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, javierm@redhat.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, lukasz.hawrylko@linux.intel.com,
        michal.zygowski@3mdeb.com, mjg59@google.com, phcoder@gmail.com,
        pirot.krol@3mdeb.com, pjones@redhat.com, ross.philipson@oracle.com
Subject: [GRUB PATCH RFC 08/18] i386/tpm: Add TPM TIS and CRB driver
Date:   Tue,  5 May 2020 01:21:22 +0200
Message-Id: <20200504232132.23570-9-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200504232132.23570-1-daniel.kiper@oracle.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=2
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=2
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be used by Intel TXT secure launcher introduced
by subsequent patches.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 grub-core/commands/i386/tpm.c | 182 ++++++++++++++++++++++++++++++++++++++++++
 include/grub/i386/tpm.h       |  36 +++++++++
 2 files changed, 218 insertions(+)
 create mode 100644 grub-core/commands/i386/tpm.c
 create mode 100644 include/grub/i386/tpm.h

diff --git a/grub-core/commands/i386/tpm.c b/grub-core/commands/i386/tpm.c
new file mode 100644
index 000000000..ff29c2e85
--- /dev/null
+++ b/grub-core/commands/i386/tpm.c
@@ -0,0 +1,182 @@
+/*
+ *  GRUB  --  GRand Unified Bootloader
+ *  Copyright (C) 2020  Free Software Foundation, Inc.
+ *
+ *  GRUB is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 3 of the License, or
+ *  (at your option) any later version.
+ *
+ *  GRUB is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with GRUB.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ *  TPM TIS and CRB driver.
+ *
+ *  Note: It is suggested to not use this driver together with UEFI TPM driver.
+ */
+
+#include <grub/command.h>
+#include <grub/dl.h>
+#include <grub/err.h>
+#include <grub/i386/memory.h>
+#include <grub/i386/mmio.h>
+#include <grub/i386/tpm.h>
+#include <grub/mm.h>
+#include <grub/types.h>
+
+GRUB_MOD_LICENSE ("GPLv3+");
+
+#define TPM_MMIO_BASE		0xfed40000
+
+/* TIS registers. */
+#define TPM_ACCESS		0x0000
+#define TPM_INTF_CAPABILITY	0x0014
+#define TPM_INTERFACE_ID	0x0030
+
+/* CRB registers. */
+#define TPM_LOC_CTRL		0x0008
+
+#define TPM_12_TIS_INTF_12	0x0
+#define TPM_12_TIS_INTF_13	0x2
+#define TPM_20_TIS_INTF_13	0x3
+
+#define TPM_CRB_INTF_ACTIVE	0x1
+
+#define TIS_RELINQUISH_LCL	0x20
+#define CRB_RELINQUISH_LCL	0x0002
+
+/* TODO: Do we need GRUB_PACKED for unions below??? */
+
+union tpm_interface_id
+{
+  grub_uint32_t raw;
+  struct
+  {
+    grub_uint32_t interface_type:4;
+    grub_uint32_t interface_version:4;
+    grub_uint32_t cap_locality:1;
+    grub_uint32_t reserved_0:4;
+    grub_uint32_t cap_tis:1;
+    grub_uint32_t cap_crb:1;
+    grub_uint32_t cap_ifres:2;
+    grub_uint32_t interface_selector:2;
+    grub_uint32_t intf_sel_lock:1;
+    grub_uint32_t reserved_1:4;
+    grub_uint32_t reserved_2:8;
+  };
+} GRUB_PACKED;
+typedef union tpm_interface_id tpm_interface_id_t;
+
+union tpm_intf_capability
+{
+  grub_uint32_t raw;
+  struct
+  {
+    grub_uint32_t data_avail_int_support:1;
+    grub_uint32_t sts_valid_int_support:1;
+    grub_uint32_t locality_change_int_support:1;
+    grub_uint32_t interrupt_level_high:1;
+    grub_uint32_t interrupt_level_low:1;
+    grub_uint32_t interrupt_edge_rising:1;
+    grub_uint32_t interrupt_edge_falling:1;
+    grub_uint32_t command_ready_int_support:1;
+    grub_uint32_t burst_count_static:1;
+    grub_uint32_t data_transfer_size_support:2;
+    grub_uint32_t reserved_0:17;
+    grub_uint32_t interface_version:3;
+    grub_uint32_t reserved_1:1;
+  };
+} GRUB_PACKED;
+typedef union tpm_intf_capability tpm_intf_capability_t;
+
+typedef enum
+  {
+    TPM_INTF_NONE = 0,
+    TPM_INTF_TIS,
+    TPM_INTF_CRB
+  }
+tpm_intf_t;
+
+static grub_tpm_ver_t tpm_ver = GRUB_TPM_NONE;
+static tpm_intf_t tpm_intf = TPM_INTF_NONE;
+
+grub_tpm_ver_t
+grub_get_tpm_ver (void)
+{
+  return tpm_ver;
+}
+
+/* Localities 0-4 are supported only. */
+void
+grub_tpm_relinquish_lcl (grub_uint8_t lcl)
+{
+  grub_addr_t addr = TPM_MMIO_BASE + lcl * GRUB_PAGE_SIZE;
+
+  if (tpm_intf == TPM_INTF_TIS)
+    grub_writeb (TIS_RELINQUISH_LCL, (void *) (addr + TPM_ACCESS));
+  else if (tpm_intf == TPM_INTF_CRB)
+    grub_writel (CRB_RELINQUISH_LCL, (void *) (addr + TPM_LOC_CTRL));
+}
+
+static grub_err_t
+grub_cmd_tpm_type (grub_command_t cmd __attribute__ ((unused)),
+		   int argc __attribute__ ((unused)),
+		   char *argv[] __attribute__ ((unused)))
+{
+  const char *tpm_ver_s = "NONE";
+  const char *tpm_intf_s = "NONE";
+
+  if (tpm_ver == GRUB_TPM_12)
+    tpm_ver_s = "1.2";
+  else if (tpm_ver == GRUB_TPM_20)
+    tpm_ver_s = "2.0";
+
+  if (tpm_intf == TPM_INTF_TIS)
+    tpm_intf_s = "TIS";
+  else if (tpm_intf == TPM_INTF_CRB)
+    tpm_intf_s = "CRB";
+
+  grub_printf ("TPM VER: %s\nTPM INTF: %s\n", tpm_ver_s, tpm_intf_s);
+
+  return GRUB_ERR_NONE;
+}
+
+static grub_command_t cmd_tpm_type;
+
+GRUB_MOD_INIT (tpm)
+{
+  tpm_interface_id_t intf_id;
+  tpm_intf_capability_t intf_cap;
+
+  cmd_tpm_type = grub_register_command ("tpm_type", grub_cmd_tpm_type,
+					NULL, N_("Show TPM version and interface type."));
+
+  intf_cap.raw = grub_readl ((void *)(grub_addr_t) (TPM_MMIO_BASE + TPM_INTF_CAPABILITY));
+
+  if (intf_cap.interface_version == TPM_12_TIS_INTF_12 ||
+      intf_cap.interface_version == TPM_12_TIS_INTF_13)
+    {
+      tpm_ver = GRUB_TPM_12;
+      tpm_intf = TPM_INTF_TIS;
+      return;
+    }
+
+  if (intf_cap.interface_version != TPM_20_TIS_INTF_13)
+    return;
+
+  tpm_ver = GRUB_TPM_20;
+
+  intf_id.raw = grub_readl ((void *)(grub_addr_t) (TPM_MMIO_BASE + TPM_INTERFACE_ID));
+
+  tpm_intf = (intf_id.interface_type == TPM_CRB_INTF_ACTIVE) ? TPM_INTF_CRB : TPM_INTF_TIS;
+}
+
+GRUB_MOD_FINI (tpm)
+{
+  grub_unregister_command (cmd_tpm_type);
+}
diff --git a/include/grub/i386/tpm.h b/include/grub/i386/tpm.h
new file mode 100644
index 000000000..ae8d4a27d
--- /dev/null
+++ b/include/grub/i386/tpm.h
@@ -0,0 +1,36 @@
+/*
+ *  GRUB  --  GRand Unified Bootloader
+ *  Copyright (C) 2020  Free Software Foundation, Inc.
+ *
+ *  GRUB is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 3 of the License, or
+ *  (at your option) any later version.
+ *
+ *  GRUB is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with GRUB.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef GRUB_I386_TPM_H
+#define GRUB_I386_TPM_H 1
+
+#include <grub/types.h>
+
+typedef enum
+  {
+    GRUB_TPM_NONE = 0,
+    GRUB_TPM_12,
+    GRUB_TPM_20
+  }
+grub_tpm_ver_t;
+
+extern grub_tpm_ver_t grub_get_tpm_ver (void);
+extern void grub_tpm_relinquish_lcl (grub_uint8_t lcl);
+
+#endif /* GRUB_I386_TPM_H */
-- 
2.11.0

