Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF76C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4381D2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oJJX9Bga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgG2MmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:42:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39308 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2MmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:42:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TCWqkK187880;
        Wed, 29 Jul 2020 12:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2020-01-29;
 bh=6Ty70P6NDFFXbdmIqQczjAdFy4h294/O1eoC6bSM5aI=;
 b=oJJX9BgaH/8/U+SKDvAZjnzCGP0pEziBN2nLs19NW7bnxUj/8Efu0wrF86PfWh7TU9lA
 bT09iQHT+Zqj7LZGGhV6nPro5QLNRu1fePDvGk2udk0JjplYzO8eSKXiZbOSX8Id/8y9
 og1WEkIH/wkaqjr31ESn2+AJ6wAbisdXPxH2MiVZa2GicaXCTcX6S27u7zMyDXTMMqUq
 BFmwBS/Ygd+jol8o6ctgIaHZBXzHtXBG9C5sAcPVwKY7IPKt0VMUzI/2V6/rrYYsJ+lz
 5OKMVGEnG4zbReLp4GB6J+8qUMLqfwXWTt5rrirmtmMSFohqOD7uQQGne1X41eFodmao sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32hu1jdbt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 12:42:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TCWlsu073432;
        Wed, 29 Jul 2020 12:40:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32hu5vpq4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 12:40:03 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06TCe299021178;
        Wed, 29 Jul 2020 12:40:02 GMT
Received: from dhcp-10-152-34-21.usdhcp.oraclecorp.com.com (/10.152.34.21)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 05:40:02 -0700
From:   George Kennedy <george.kennedy@oracle.com>
To:     george.kennedy@oracle.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, ebiggers@google.com, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, dhaval.giani@oracle.com
Subject: [PATCH 1/1] vt_ioctl: prevent VT_RESIZEX font height change from causing potential out-of-bounds access
Date:   Wed, 29 Jul 2020 08:39:41 -0400
Message-Id: <1596026381-5013-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=4 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a VT_RESIZEX check to ensure that changing the font height will not
cause a potential out-of-bounds access. The candidate font height contained
in "v_clin", though below the max, could still result in accesses beyond
the allocated font data size.

Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Reported-by: syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com
---
 drivers/tty/vt/vt_ioctl.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index daf61c2..6185f1a 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -342,6 +342,9 @@ static void vt_disallocate_all(void)
 	}
 }
 
+/* from fbcon.c */
+#define FNTSIZE(fd) (((int *)(fd))[-2])
+#define FNTCHARCNT(fd) (((int *)(fd))[-3])
 
 /*
  * We handle the console-specific ioctl's here.  We allow the
@@ -895,8 +898,23 @@ int vt_ioctl(struct tty_struct *tty,
 			if (vcp) {
 				if (v.v_vlin)
 					vcp->vc_scan_lines = v.v_vlin;
-				if (v.v_clin)
+				if (v.v_clin) {
+					int width, pitch, size;
+
+					width = (vcp->vc_font.width > 8) ? 8 : vcp->vc_font.width;
+					pitch = (width + 7) >> 3;
+
+					pitch = (pitch) ? pitch : 1;
+
+					/* font size = height * pitch * charcount */
+					size = v.v_clin * pitch * FNTCHARCNT(vcp->vc_font.data);
+
+					if (size > FNTSIZE(vcp->vc_font.data)) {
+						console_unlock();
+						return -EINVAL;
+					}
 					vcp->vc_font.height = v.v_clin;
+				}
 				vcp->vc_resize_user = 1;
 				vc_resize(vcp, v.v_cols, v.v_rows);
 			}
-- 
1.8.3.1

