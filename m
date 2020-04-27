Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2621AC5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032452063A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S7E5OSLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgD0IIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:08:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57134 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgD0IIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:08:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03R836a2062342;
        Mon, 27 Apr 2020 08:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=tGgIVpxz9WUK/2JdnEOgbUU3bqCa/maRFGSs7Nj+Jk8=;
 b=S7E5OSLL0l86lbdaSDrfP4+Dt3OsQmPPILiUf2E1HadZKn8nYxyRscwYHjPU0ko+Dcd4
 t3V7MkR2vU+SlqjVZbd4RYeGNZ6faphlaM9k2VaT7+Nch/zHg7dZFZGxbpxqHntyu9ox
 Fg/1sQD7GLUaddHdBOi7Enw0zzlP0+PJ9c1uf8q/e8X4akb8La1Q2LDxGcQoDgXOw8jH
 3r2j+bMpPooGuVtCr3Cv1/a4IkBWfJqT6IvKEcJnwdn5UiULGGOUy9Avgjc+Y/isV0Lf
 PtBM4YSqbow3cxwbQNaPFKK6WPAgYTFl9iL9cGOXoIOqOvNxMwMD8Ib4taFSpJYQJlm5 gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30mcmqw25g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 08:08:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03R82aDF038627;
        Mon, 27 Apr 2020 08:08:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30mxpcp22r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 08:08:27 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03R88K6A003051;
        Mon, 27 Apr 2020 08:08:20 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Apr 2020 01:08:20 -0700
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH RFC 2/3] x86: microcode: intel: process microcode metadata
Date:   Mon, 27 Apr 2020 10:27:58 +0300
Message-Id: <1587972479-10971-3-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587972479-10971-1-git-send-email-mihai.carabas@oracle.com>
References: <1587972479-10971-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9603 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=1
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9603 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 suspectscore=1 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Process the microcode metadata to see what changes are done on
CPU feature bits.

The default kernel policy imposed by is_microcode_allowed() is
to abort any microcode late loading if there will be removed a
feature and will continue the loading otherwise. Complex policies
can be created in the future.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 85 +++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index a54d5e6..2ef4338 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -23,6 +23,7 @@
 #include <linux/firmware.h>
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
+#include <linux/string.h>
 #include <linux/initrd.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -965,6 +966,81 @@ static bool is_blacklisted(unsigned int cpu)
 
 	return false;
 }
+/**
+ * is_microcode_allowed - parse and enforce policies
+ * @firmware - metadata blob
+ *
+ * Parses the metadata file provided with the microcode in order to see the
+ * changes brought in by the new blob.
+ *
+ * Based on the type of changes, currently it enforces the following policy: if
+ * there is a feature being removed by the new microcode, reject the loading.
+ *
+ * RETURNS:
+ * false if it rejects the microcode or true if it accepts the microcode.
+ */
+static bool is_microcode_allowed(const struct firmware *firmware)
+{
+	int ret, index, leaf, eax, ebx, ecx, edx, line_nr = 0;
+	char *data = (char *) firmware->data;
+	char *line;
+	char op;
+
+	/*
+	 * Get each line and match it with regular expression:
+	 * {m|c} {+|-} u32 [u32]*
+	 *
+	 * See section Late loading metadata file from
+	 * Documentation/x86/microcode.rst
+	 */
+	while (data && (data - ((char *)(firmware->data)) < firmware->size)) {
+		line = strsep(&data, "\n");
+		line_nr++;
+
+		/*
+		 * For each line check the first letter to see the type of
+		 * operation done by the microcode and create a sscanf call
+		 * the would match the rest of the line of that operation.
+		 * If it is not a match, exist with parsing error. If it is
+		 * a match and is a remove action (-) do not allow microcode
+		 * to be loaded.
+		 */
+		switch (line[0]) {
+		case 'c':
+			ret = sscanf(&line[1], " %c %x %x %x %x %x %x", &op,
+			    &index, &leaf, &eax, &ebx, &ecx, &edx);
+			if (ret != 7)
+				goto out_error;
+			if (op == '-')
+				goto out_cpuid_rem_notsupp;
+			break;
+		case 'm':
+			ret = sscanf(&line[1], " %c %x", &op, &index);
+			if (ret != 2)
+				goto out_error;
+			if (op == '-')
+				goto out_msr_rem_notsupp;
+			break;
+		default:
+			goto out_error;
+		}
+	}
+
+	return true;
+
+out_error:
+	pr_warn("Microcode metadata failed parsing at line %d\n", line_nr);
+	return false;
+
+out_msr_rem_notsupp:
+	pr_warn("Kernel policy does not allow to remove MSR: %x\n", index);
+	return false;
+
+out_cpuid_rem_notsupp:
+	pr_warn("Kernel policy does not allow to remove CPUID: %x leaf: %x, eax: %x, ebx: %x, ecx: %x, edx: %x\n",
+	    index, leaf, eax, ebx, ecx, edx);
+	return false;
+}
 
 static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 					     bool refresh_fw)
@@ -992,10 +1068,19 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 		return UCODE_NFOUND;
 	}
 
+	/* Load the metadata file in memory. */
 	if (request_firmware_direct(&meta_firmware, meta_name, device)) {
 		pr_debug("metadata file %s load failed\n", name);
 		pr_debug("no feature check will be done pre-loading the microcode\n");
 	} else {
+		/* Check the policy based on the metadata file. */
+		if (!is_microcode_allowed(meta_firmware)) {
+			pr_warn("kernel does not support the new microcode: %s\n",
+			    name);
+			release_firmware(meta_firmware);
+			release_firmware(firmware);
+			return UCODE_ERROR;
+		}
 		release_firmware(meta_firmware);
 	}
 
-- 
1.8.3.1

