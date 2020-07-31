Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2BEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5807E21744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pEJNjH66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbgGaQfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:35:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55268 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgGaQfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:35:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VGWxt2122023;
        Fri, 31 Jul 2020 16:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2020-01-29;
 bh=iFzxc1YO/OI/8nca19/oqfeQYCQ0TL+B2R2ElCT9KrQ=;
 b=pEJNjH66lU/piSACI7rNs0s8RQRezEvaLRR40OMANCGxg5WU2AfA57eYYuZ7MIG2/HmU
 YE3EDf+qVkrzXdFdzA+wlrTZhlx0/hkqcTq3uS8DTYqn70MZ7ehVuL1Af6nqfIpyx/32
 sZhOoolHNASSxymkgNxlIQoORSsqrZtHyBh2Pdx+jvWIJgEp1z34Y4wctUbXXlF9NDRv
 s4jWBEXQBCoWp09b6a0RKi7Sb7LZnFk1W+SwFI0kymU/H0Lk/eGfkYIkWHIpnl8XpcnP
 vGihp+7VkcFEj4RUiVwGF1IBYjKG+MEh0yg1FEb5a5Gl09URGwDVNvuKQvflnB9pl68x 7Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32hu1jt06e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jul 2020 16:35:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VGWiae067471;
        Fri, 31 Jul 2020 16:33:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 32mf70raj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 16:33:34 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06VGXXUE001003;
        Fri, 31 Jul 2020 16:33:33 GMT
Received: from dhcp-10-152-34-21.usdhcp.oraclecorp.com.com (/10.152.34.21)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Jul 2020 09:33:33 -0700
From:   George Kennedy <george.kennedy@oracle.com>
To:     george.kennedy@oracle.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, b.zolnierkie@samsung.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, dhaval.giani@oracle.com
Subject: [PATCH 1/2] fbcon: prevent user font height or width change from causing potential out-of-bounds access
Date:   Fri, 31 Jul 2020 12:33:11 -0400
Message-Id: <1596213192-6635-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=4 spamscore=0
 mlxlogscore=999 adultscore=53 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=11 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=4 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check to fbcon_resize() to ensure that a possible change to user font
height or user font width will not allow a font data out-of-bounds access.
NOTE: must use original charcount in calculation as font charcount can
change and cannot be used to determine the font data allocated size.

Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Reported-by: syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com
---
 drivers/video/fbdev/core/fbcon.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 8a31fc2..6616783 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2191,6 +2191,9 @@ static void updatescrollmode(struct fbcon_display *p,
 	}
 }
 
+#define PITCH(w) (((w) + 7) >> 3)
+#define CALC_FONTSZ(h, p, c) ((h) * (p) * (c)) /* size = height * pitch * charcount */
+
 static int fbcon_resize(struct vc_data *vc, unsigned int width, 
 			unsigned int height, unsigned int user)
 {
@@ -2200,6 +2203,24 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	struct fb_var_screeninfo var = info->var;
 	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
 
+	if (ops->p && ops->p->userfont && FNTSIZE(vc->vc_font.data)) {
+		int size;
+		int pitch = PITCH(vc->vc_font.width);
+
+		/*
+		 * If user font, ensure that a possible change to user font
+		 * height or width will not allow a font data out-of-bounds access.
+		 * NOTE: must use original charcount in calculation as font
+		 * charcount can change and cannot be used to determine the
+		 * font data allocated size.
+		 */
+		if (pitch <= 0)
+			return -EINVAL;
+		size = CALC_FONTSZ(vc->vc_font.height, pitch, FNTCHARCNT(vc->vc_font.data));
+		if (size > FNTSIZE(vc->vc_font.data))
+			return -EINVAL;
+	}
+
 	virt_w = FBCON_SWAP(ops->rotate, width, height);
 	virt_h = FBCON_SWAP(ops->rotate, height, width);
 	virt_fw = FBCON_SWAP(ops->rotate, vc->vc_font.width,
@@ -2652,7 +2673,7 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
 	int size;
 	int i, csum;
 	u8 *new_data, *data = font->data;
-	int pitch = (font->width+7) >> 3;
+	int pitch = PITCH(font->width);
 
 	/* Is there a reason why fbconsole couldn't handle any charcount >256?
 	 * If not this check should be changed to charcount < 256 */
@@ -2668,7 +2689,7 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
 	if (fbcon_invalid_charcount(info, charcount))
 		return -EINVAL;
 
-	size = h * pitch * charcount;
+	size = CALC_FONTSZ(h, pitch, charcount);
 
 	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);
 
-- 
1.8.3.1

