Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D783AC2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B801E2054F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732833AbgDAVNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:13:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732637AbgDAVNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 17:13:24 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031L4JCW066539
        for <linux-kernel@vger.kernel.org>; Wed, 1 Apr 2020 17:13:23 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304sws8g4t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 17:13:22 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Wed, 1 Apr 2020 22:13:05 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 22:13:03 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 031LDG8v43843704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 21:13:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EB71A4053;
        Wed,  1 Apr 2020 21:13:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6946AA404D;
        Wed,  1 Apr 2020 21:13:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 21:13:16 +0000 (GMT)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [PATCH] LICENSES/deprecated: add Zlib license text
Date:   Wed,  1 Apr 2020 23:13:16 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20040121-0016-0000-0000-000002FC8AF5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040121-0017-0000-0000-000033605199
Message-Id: <20200401211316.7251-1-zaslonko@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_04:2020-03-31,2020-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=795 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new files contributed to zlib have Zlib SPDX license identifier. Since
there was no Zlib license text in LICENSES, scripts/spdxcheck.py
reported the following errors:
  lib/zlib_dfltcc/dfltcc.c: 1:28 Invalid License ID: Zlib
  lib/zlib_dfltcc/dfltcc.h: 1:28 Invalid License ID: Zlib
  lib/zlib_dfltcc/dfltcc_deflate.c: 1:28 Invalid License ID: Zlib
  lib/zlib_dfltcc/dfltcc_inflate.c: 1:28 Invalid License ID: Zlib
  lib/zlib_dfltcc/dfltcc_util.h: 1:28 Invalid License ID: Zlib

The patch adds Zlib SPDX license to LICENSES/deprecated, thus
resolving the issues reported by spdxcheck.

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 LICENSES/deprecated/Zlib | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 LICENSES/deprecated/Zlib

diff --git a/LICENSES/deprecated/Zlib b/LICENSES/deprecated/Zlib
new file mode 100644
index 000000000000..b60d0d73f131
--- /dev/null
+++ b/LICENSES/deprecated/Zlib
@@ -0,0 +1,27 @@
+Valid-License-Identifier: Zlib
+SPDX-URL: https://spdx.org/licenses/Zlib.html
+Usage-Guide:
+  To use the Zlib License put the following SPDX tag/value pair into a
+  comment according to the placement guidelines in the licensing rules
+  documentation:
+    SPDX-License-Identifier: Zlib
+License-Text:
+
+zlib License
+
+Copyright (c) <year> <copyright holders>
+
+This software is provided 'as-is', without any express or implied warranty. In
+no event will the authors be held liable for any damages arising from the use
+of this software.
+
+Permission is granted to anyone to use this software for any purpose, including
+commercial applications, and to alter it and redistribute it freely, subject
+to the following restrictions:
+  1. The origin of this software must not be misrepresented; you must not
+claim that you wrote the original software. If you use this software in a
+product, an acknowledgment in the product documentation would be appreciated
+but is not required.
+  2. Altered source versions must be plainly marked as such, and must not be
+misrepresented as being the original software.
+  3. This notice may not be removed or altered from any source distribution.
-- 
2.17.1

