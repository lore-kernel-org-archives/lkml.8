Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F8CC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08ED120C09
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="DtKHEcqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbgIGS4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:56:41 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:53310 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729887AbgIGS4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:56:08 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087IoVCc011081;
        Mon, 7 Sep 2020 18:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type; s=pps0720;
 bh=LB8gDcP5xT5vI1DQi4l4ZXWlIg0XZilz2Y2Ki/ifv2Q=;
 b=DtKHEcqECbLk6WLQAnOD0FzZiGg5VI+uHI5g9lSClYAxCQcPir9wZAt3uk4GzjVSqgnf
 /QXu8pRcmPgb1FZrC8953FbfPJ4rfDCiXuFEB/dEnHDRWvybvel3ma5p83ExRvML+nCn
 +FBTSvtg6CvuNx3rMvc9pacrQI2pFMl002fXmCuNikVdspE7ykhWX4peNl8ASzgViByY
 io1SGep6T/NE7t9oTV6B2ZAumoOX2TFfsKiMO06pNY4M2o0DeyXaFk/wwSP1U+ovckYP
 Fg2nv+Q07QgMe1wVhuBifAumFpXhDOjFl0QEmicFT98ixXXIZw+064So4+3TickNHWdG yA== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 33cm1x4r57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 18:54:32 +0000
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 4F331AF;
        Mon,  7 Sep 2020 18:54:31 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id BC63230060F0B; Mon,  7 Sep 2020 13:54:30 -0500 (CDT)
Message-ID: <20200907185430.685975987@hpe.com>
User-Agent: quilt/0.66
Date:   Mon, 07 Sep 2020 13:54:33 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@suse.de>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 03/12] x86/platform/uv: Adjust references in UV kernel modules
References: <20200907185430.363197758@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_11:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=718
 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a symbol clash from the auto-generated uv_mmrs.h file that
clashes with code in the UV kernel modules (is_uv() is the symbol).
Change those prior to the symbol clash so as to not cause a compile error.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 drivers/misc/sgi-xp/xp.h            |   11 ++++++-----
 drivers/misc/sgi-xp/xp_main.c       |    7 ++++---
 drivers/misc/sgi-xp/xp_uv.c         |    9 ++++++---
 drivers/misc/sgi-xp/xpc_main.c      |    9 +++++----
 drivers/misc/sgi-xp/xpc_partition.c |    5 +++--
 drivers/misc/sgi-xp/xpnet.c         |    5 +++--
 6 files changed, 27 insertions(+), 19 deletions(-)

--- linux.orig/drivers/misc/sgi-xp/xp.h
+++ linux/drivers/misc/sgi-xp/xp.h
@@ -3,7 +3,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2004-2008 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (c) 2018-2020 Hewlett Packard Enterprise Development LP
+ * Copyright (c) 2008-2017 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
 /*
@@ -17,11 +18,11 @@
 
 #if defined CONFIG_X86_UV || defined CONFIG_IA64_SGI_UV
 #include <asm/uv/uv.h>
-#define is_uv()		is_uv_system()
+#define is_uv_sys()		is_uv_system()
 #endif
 
-#ifndef is_uv
-#define is_uv()		0
+#ifndef is_uv_sys
+#define is_uv_sys()		0
 #endif
 
 #ifdef USE_DBUG_ON
@@ -79,7 +80,7 @@
 
 #define XPC_MSG_SIZE(_payload_size) \
 				ALIGN(XPC_MSG_HDR_MAX_SIZE + (_payload_size), \
-				      is_uv() ? 64 : 128)
+				      is_uv_sys() ? 64 : 128)
 
 
 /*
--- linux.orig/drivers/misc/sgi-xp/xp_main.c
+++ linux/drivers/misc/sgi-xp/xp_main.c
@@ -3,7 +3,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (c) 2004-2008 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2018-2020 Hewlett Packard Enterprise Development LP
+ * Copyright (c) 2008-2017 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
 /*
@@ -233,7 +234,7 @@ xp_init(void)
 	for (ch_number = 0; ch_number < XPC_MAX_NCHANNELS; ch_number++)
 		mutex_init(&xpc_registrations[ch_number].mutex);
 
-	if (is_uv())
+	if (is_uv_sys())
 		ret = xp_init_uv();
 	else
 		ret = 0;
@@ -249,7 +250,7 @@ module_init(xp_init);
 void __exit
 xp_exit(void)
 {
-	if (is_uv())
+	if (is_uv_sys())
 		xp_exit_uv();
 }
 
--- linux.orig/drivers/misc/sgi-xp/xp_uv.c
+++ linux/drivers/misc/sgi-xp/xp_uv.c
@@ -3,7 +3,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (c) 2008 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2018-2020 Hewlett Packard Enterprise Development LP
+ * Copyright (c) 2008-2017 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
 /*
@@ -148,7 +149,9 @@ xp_restrict_memprotect_uv(unsigned long
 enum xp_retval
 xp_init_uv(void)
 {
-	BUG_ON(!is_uv());
+	WARN_ON(!is_uv_sys());
+	if (!is_uv_sys())
+		return xpUnsupported;
 
 	xp_max_npartitions = XP_MAX_NPARTITIONS_UV;
 #ifdef CONFIG_X86
@@ -168,5 +171,5 @@ xp_init_uv(void)
 void
 xp_exit_uv(void)
 {
-	BUG_ON(!is_uv());
+	WARN_ON(!is_uv_sys());
 }
--- linux.orig/drivers/misc/sgi-xp/xpc_main.c
+++ linux/drivers/misc/sgi-xp/xpc_main.c
@@ -3,7 +3,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (c) 2004-2009 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2018-2020 Hewlett Packard Enterprise Development LP
+ * Copyright (c) 2008-2017 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
 /*
@@ -1043,7 +1044,7 @@ xpc_do_exit(enum xp_retval reason)
 
 	xpc_teardown_partitions();
 
-	if (is_uv())
+	if (is_uv_sys())
 		xpc_exit_uv();
 }
 
@@ -1226,7 +1227,7 @@ xpc_init(void)
 	dev_set_name(xpc_part, "part");
 	dev_set_name(xpc_chan, "chan");
 
-	if (is_uv()) {
+	if (is_uv_sys()) {
 		ret = xpc_init_uv();
 
 	} else {
@@ -1312,7 +1313,7 @@ out_2:
 
 	xpc_teardown_partitions();
 out_1:
-	if (is_uv())
+	if (is_uv_sys())
 		xpc_exit_uv();
 	return ret;
 }
--- linux.orig/drivers/misc/sgi-xp/xpc_partition.c
+++ linux/drivers/misc/sgi-xp/xpc_partition.c
@@ -3,7 +3,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (c) 2004-2008 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2018-2020 Hewlett Packard Enterprise Development LP
+ * Copyright (c) 2008-2017 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
 /*
@@ -433,7 +434,7 @@ xpc_discovery(void)
 	 */
 	region_size = xp_region_size;
 
-	if (is_uv())
+	if (is_uv_sys())
 		max_regions = 256;
 	else {
 		max_regions = 64;
--- linux.orig/drivers/misc/sgi-xp/xpnet.c
+++ linux/drivers/misc/sgi-xp/xpnet.c
@@ -3,7 +3,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1999-2009 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (c) 2018-2020 Hewlett Packard Enterprise Development LP
+ * Copyright (c) 2008-2017 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
 /*
@@ -515,7 +516,7 @@ xpnet_init(void)
 {
 	int result;
 
-	if (!is_uv())
+	if (!is_uv_sys())
 		return -ENODEV;
 
 	dev_info(xpnet, "registering network device %s\n", XPNET_DEVICE_NAME);

