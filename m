Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FFAC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD8E2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="YEbcqbsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgC3QEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:04:24 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:15438 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727048AbgC3QEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:04:23 -0400
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UG3j19008018;
        Mon, 30 Mar 2020 17:04:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to; s=jan2016.eng;
 bh=OeRqWDckUxTUdnb7U7+IH8Jl+3M71VIO0wPlcX5l9gM=;
 b=YEbcqbsrzzrhTK2963QDbE706sUgc36amYb+Jie4BOTbd5hbmD5pW58MU6DNU5qCXY0u
 XNhPcMNjbx6fRzX22WJf86DDWzsxGYueMuq/7oen3gBmGB5ryyxGSdiV1PkmzKYWZXbq
 DYsyg5ZPRHvK4DbrnTisMHDrqBATTycMzP/aYEPA/gCI80F8Mvt0xTkC511WxZxQ8bdN
 6B1PwseIp+smc7Rf5YJotl3wggmQXXxPgfoxBcWCCerwbJFxIuwSUcK9xt+U7Vkmf4b3
 XI5kk96HPCxceoDZgG6ByR3SHzY4DxFEGhXqsWXcfkGS83t0HUr/aExhriU3ortzAaOH 8A== 
Received: from prod-mail-ppoint4 (prod-mail-ppoint4.akamai.com [96.6.114.87] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 301vay926t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 17:04:11 +0100
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.0.27/8.16.0.27) with SMTP id 02UG2v6P022726;
        Mon, 30 Mar 2020 12:04:10 -0400
Received: from prod-mail-relay14.akamai.com ([172.27.17.39])
        by prod-mail-ppoint4.akamai.com with ESMTP id 3028dk1k3q-1;
        Mon, 30 Mar 2020 12:04:10 -0400
Received: from bos-lpjec.145bw.corp.akamai.com (bos-lpjec.145bw.corp.akamai.com [172.28.3.71])
        by prod-mail-relay14.akamai.com (Postfix) with ESMTP id 08F9085C30;
        Mon, 30 Mar 2020 16:03:58 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     rdunlap@infradead.org, songliubraving@fb.com
Cc:     neilb@suse.de, guoqing.jiang@cloud.ionos.com, agk@redhat.com,
        snitzer@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] md/raid0: add config parameters to specify zone layout
Date:   Mon, 30 Mar 2020 12:00:45 -0400
Message-Id: <1585584045-11263-1-git-send-email-jbaron@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <d8433599-cd4f-80a1-d9f7-8ddad1693850@infradead.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_07:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-2002250000 definitions=main-2003300148
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_07:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003300148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add some CONFIG_* options to directly configure the raid0 layout
if you know in advance how your raid0 array was created. This can be
simpler than having to manage module or kernel command-line parameters.

If the raid0 array was created by a pre-3.14 kernel, use
RAID0_ORIG_LAYOUT. If the raid0 array was created by a 3.14 or newer
kernel then select RAID0_ALT_MULTIZONE_LAYOUT. Otherwise, the default
setting is RAID0_LAYOUT_NONE, in which case the current behavior of
needing to specify a module parameter raid0.default_layout=1|2 is
preserved.

Cc: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc: NeilBrown <neilb@suse.de>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
Changes in v2:
- Cleaned up text (Randy Dunlap)

 drivers/md/Kconfig | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/md/raid0.c |  7 +++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index d6d5ab2..cf6baa1 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -79,6 +79,61 @@ config MD_RAID0
 
 	  If unsure, say Y.
 
+choice
+	prompt "RAID0 Layout"
+	default RAID0_LAYOUT_NONE
+	depends on MD_RAID0
+	help
+	  A change was made in Linux 3.14 that unintentionally changed the
+	  the layout for RAID0. This can result in data corruption if a pre-3.14
+	  and a 3.14 or later kernel both wrote to the array. However, if the
+	  devices in the array are all of the same size then the layout would
+	  have been unaffected by this change, and there is no risk of data
+	  corruption from this issue.
+
+	  Unfortunately, the layout can not be determined by the kernel. If the
+	  array has only been written to by a 3.14 or later kernel it's safe to
+	  set RAID0_ALT_MULTIZONE_LAYOUT. If it has only been written to by a
+	  pre-3.14 kernel it's safe to select RAID0_ORIG_LAYOUT. If it has been
+	  written by both then select RAID0_LAYOUT_NONE, which will not
+	  configure the array. The array can then be examined for corruption.
+
+	  For new arrays you may choose either layout version. Neither version
+	  is inherently better than the other.
+
+	  Alternatively, these parameters can also be specified via the module
+	  parameter raid0.default_layout=<N>. N=2 selects the 'new' or multizone
+	  layout, while N=1 selects the 'old' layout or original layout. If
+	  unset the array will not be configured.
+
+	  The layout can also be written directly to the raid0 array via the
+	  mdadm command, which can be auto-detected by the kernel. See:
+	  <https://www.kernel.org/doc/html/latest/admin-guide/md.html#multi-zone-raid0-layout-migration>
+
+config RAID0_ORIG_LAYOUT
+	bool "raid0 layout for arrays only written to by a pre-3.14 kernel"
+	help
+	  If the raid0 array was only created and written to by a pre-3.14 kernel.
+
+config RAID0_ALT_MULTIZONE_LAYOUT
+	bool "raid0 layout for arrays only written to by a 3.14 or newer kernel"
+	help
+	  If the raid0 array was only created and written to by a 3.14 or later
+	  kernel.
+
+config RAID0_LAYOUT_NONE
+	bool "raid0 layout must be specified via a module parameter"
+	help
+	  If a raid0 array was written to by both a pre-3.14 and a 3.14 or
+	  later kernel, you may have data corruption. This option will not
+	  auto configure the array and thus you can examine the array offline
+	  to determine the best way to proceed. With RAID0_LAYOUT_NONE
+	  set, the choice for raid0 layout can be set via a module parameter
+	  raid0.default_layout=<N>. Or the layout can be written directly
+	  to the raid0 array via the mdadm command.
+
+endchoice
+
 config MD_RAID1
 	tristate "RAID-1 (mirroring) mode"
 	depends on BLK_DEV_MD
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 322386f..576eaa6 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -19,7 +19,14 @@
 #include "raid0.h"
 #include "raid5.h"
 
+#if defined(CONFIG_RAID0_ORIG_LAYOUT)
+static int default_layout = RAID0_ORIG_LAYOUT;
+#elif defined(CONFIG_RAID0_ALT_MULTIZONE_LAYOUT)
+static int default_layout = RAID0_ALT_MULTIZONE_LAYOUT;
+#else
 static int default_layout = 0;
+#endif
+
 module_param(default_layout, int, 0644);
 
 #define UNSUPPORTED_MDDEV_FLAGS		\
-- 
2.7.4

