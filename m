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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3DAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC6BE21744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vnX3xR9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbgGaQfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:35:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54290 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbgGaQfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:35:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VGVlkn078057;
        Fri, 31 Jul 2020 16:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=kY7CmQPbJGPQ7Ca5hDfD6T9GR+fCzTCcIL6Wwh9TPds=;
 b=vnX3xR9Qgpa5JN6c6YptW9v/xDsENA4N6S2E0v1Z0ZVM210/e0jF0R0ahrtqEbm71oKF
 U7YLJlddHNc5x3sgNHfgE6+3AS8y1NAXIKlMoWBGiI1ZxWB2yo7up1JsqnpBR8LV8qrA
 4/T9z7NiEnaMHVVlIgDhrR7d5DLanJgNgXR9derZy5W9tZu4swEtRM8ypvFJx5rS16IP
 aBoRCAGA/dj3hBC5wLOF4k8LEdlvdno+s7JOlHNA9xYpZfW7Gc9mK/WJAjUeUZ5dQgtR
 PX/TdH6OGWVLO2S+WKPGE6sjY8BnoiaMqjuG5KcEpa+AVjyakpRxu29oPrlio7cbZtB9 iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32mf9g2ak2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jul 2020 16:35:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VGTUEG055165;
        Fri, 31 Jul 2020 16:33:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32hu600p3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 16:33:35 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06VGXY8t023570;
        Fri, 31 Jul 2020 16:33:34 GMT
Received: from dhcp-10-152-34-21.usdhcp.oraclecorp.com.com (/10.152.34.21)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Jul 2020 09:33:34 -0700
From:   George Kennedy <george.kennedy@oracle.com>
To:     george.kennedy@oracle.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, b.zolnierkie@samsung.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, dhaval.giani@oracle.com
Subject: [PATCH 2/2] vt_ioctl: change VT_RESIZEX ioctl to check for error return from vc_resize()
Date:   Fri, 31 Jul 2020 12:33:12 -0400
Message-Id: <1596213192-6635-2-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596213192-6635-1-git-send-email-george.kennedy@oracle.com>
References: <1596213192-6635-1-git-send-email-george.kennedy@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=3 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=3 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vc_resize() can return with an error after failure. Change VT_RESIZEX ioctl
to save struct vc_data values that are modified and restore the original
values in case of error.

Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Reported-by: syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com
---
Version of patch available for Mainline also.

 drivers/tty/vt/vt_ioctl.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 91c3017..a4e520b 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -806,12 +806,22 @@ static int vt_resizex(struct vc_data *vc, struct vt_consize __user *cs)
 		console_lock();
 		vcp = vc_cons[i].d;
 		if (vcp) {
+			int ret;
+			int save_scan_lines = vcp->vc_scan_lines;
+			int save_font_height = vcp->vc_font.height;
+
 			if (v.v_vlin)
 				vcp->vc_scan_lines = v.v_vlin;
 			if (v.v_clin)
 				vcp->vc_font.height = v.v_clin;
 			vcp->vc_resize_user = 1;
-			vc_resize(vcp, v.v_cols, v.v_rows);
+			ret = vc_resize(vcp, v.v_cols, v.v_rows);
+			if (ret) {
+				vcp->vc_scan_lines = save_scan_lines;
+				vcp->vc_font.height = save_font_height;
+				console_unlock();
+				return ret;
+			}
 		}
 		console_unlock();
 	}
-- 
1.8.3.1

