Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF0AC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3681207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EEguI1tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgAMLKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:10:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38188 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMLKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:10:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DB8xSP180588;
        Mon, 13 Jan 2020 11:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=FxRHs2wyPRUrl8Oc/6Zrg9c7CYugb7sORMFdnS6XZdM=;
 b=EEguI1trKNhRE50HyNF9qala8xjNSPCbMzu/36c+B8D6kmzflZsKy+r5LHB1VnLIN/wN
 TAZ2AXF93hdEx+a+GKGAcmjDC8NVv1JVCHQUxhQZ0gLJaWj419yS6hLhHHXtG1xirODp
 bt3ghn2lCwBOXLCY8102zahmNNZiHavXdqDcPlsqQhJqhbUKHhlBP+rW0QDnqXns0pJQ
 wpsHYshG0FM41nBdvxc6F1m3rhGOXvF4VdU307nyKGPa70cMtJhv4fMxRqF3quN+stXv
 LbqnelXTqEqRo1K3aEYgVrBtiWrkDnyGmj4jUeQ+4urtY/2i+mTs1l5Jycq2alyxuQF2 JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xf73y68cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 11:09:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DB9B9S033603;
        Mon, 13 Jan 2020 11:09:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xfqu4c9g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 11:09:17 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00DB8QKZ006970;
        Mon, 13 Jan 2020 11:08:27 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 03:08:25 -0800
Date:   Mon, 13 Jan 2020 14:08:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrea Righi <righi.andrea@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Jani Nikula <jani.nikula@intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] fbdev: potential information leak in do_fb_ioctl()
Message-ID: <20200113100132.ixpaymordi24n3av@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd4e6f01-074b-def7-7ffb-9a9197930c31@samsung.com>
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9498 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9498 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "fix" struct has a 2 byte hole after ->ywrapstep and the
"fix = info->fix;" assignment doesn't necessarily clear it.  It depends
on the compiler.  The solution is just to replace the assignment with an
memcpy().

Fixes: 1f5e31d7e55a ("fbmem: don't call copy_from/to_user() with mutex held")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2:  Use memcpy()

 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index d04554959ea7..bb8d8dbc0461 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1115,7 +1115,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		break;
 	case FBIOGET_FSCREENINFO:
 		lock_fb_info(info);
-		fix = info->fix;
+		memcpy(&fix, &info->fix, sizeof(fix));
 		if (info->flags & FBINFO_HIDE_SMEM_START)
 			fix.smem_start = 0;
 		unlock_fb_info(info);
-- 
2.11.0

