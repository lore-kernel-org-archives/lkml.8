Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4ABC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB7F20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="WbNUpoTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgCZPb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:31:27 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:59396 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727345AbgCZPb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:31:27 -0400
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 02QFIStS021701;
        Thu, 26 Mar 2020 15:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id; s=jan2016.eng;
 bh=R5AMhdr9GFrZtE5J9WLWPyNbx/Ba6fwB9FoVwauw5mg=;
 b=WbNUpoTOoJVML0oufXoBUFAumZS561Kj4iY3jY0Uz9ub7RbXju5UW6RDs3B8xog2DZyX
 1i5ItoxYxZpSaXjz5Y7gg1AhTEC9m3xwjuGM1ZFcf0VLluOXtKyy3CtbrpWhBcisis9J
 iuMLLvyErv4DWbMQm50r3uZAK748UTDMI6Fk1url0u2ru6tOM2CU7AxB2NcxtAz9PPS4
 Gnx603q3JtONLQ9nppeNHuxlt4Azolkng4pfOkHj1wDutJ5UnrbCJB2Uc48LYqj4qI66
 Ssu7JWEpEocy0ANvOBi06fy7XR5aF1Xi5QhxwOamk61mQ6mxyH1GqQVsx9Qk7CrkjJKp Dg== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by m0050095.ppops.net-00190b01. with ESMTP id 300b9xvems-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 15:31:15 +0000
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.27/8.16.0.27) with SMTP id 02QFIGQP003437;
        Thu, 26 Mar 2020 11:31:14 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint2.akamai.com with ESMTP id 2ywe8uj015-1;
        Thu, 26 Mar 2020 11:31:13 -0400
Received: from bos-lpjec.145bw.corp.akamai.com (bos-lpjec.145bw.corp.akamai.com [172.28.3.71])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id A05E933E38;
        Thu, 26 Mar 2020 15:31:13 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     songliubraving@fb.com
Cc:     agk@redhat.com, snitzer@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        NeilBrown <neilb@suse.de>
Subject: [PATCH] md/raid0: add config parameters to specify zone layout
Date:   Thu, 26 Mar 2020 11:28:20 -0400
Message-Id: <1585236500-12015-1-git-send-email-jbaron@akamai.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_06:2020-03-26,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-2002250000 definitions=main-2003260118
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_06:2020-03-26,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260118
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
 drivers/md/Kconfig | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/md/raid0.c |  7 +++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index d6d5ab2..c0c6d82 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -79,6 +79,61 @@ config MD_RAID0
 
 	  If unsure, say Y.
 
+choice
+	prompt "RAID0 Layout"
+	default RAID0_LAYOUT_NONE
+	depends on MD_RAID0
+	help
+	  A change was made in Linux 3.14 that unintentinally changed the
+	  the layout for RAID0. This can result in data corruption if a pre-3.14
+	  and a 3.14 or later kernel both wrote to the array. However, if the
+	  devices in the array are all of the same size then the layout would
+	  have been unaffected by this change, and there is no risk of data
+	  corruption from this issue.
+
+	  Unfortunately, the layout can not be determined by the kernel. If the
+	  array has only been written to by a 3.14 or later kernel its safe to
+	  set RAID0_ALT_MULTIZONE_LAYOUT. If its only been written to by a
+	  pre-3.14 kernel its safe to select RAID0_ORIG_LAYOUT. If its been
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
+	bool "raid0 layout for arrays only written to be a 3.14 or newer kernel"
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

