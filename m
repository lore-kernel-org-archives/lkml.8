Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D16C83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E944F2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgD2CDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 22:03:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3375 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbgD2CDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:03:00 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9B848580726B20258804;
        Wed, 29 Apr 2020 10:02:58 +0800 (CST)
Received: from huawei.com (10.175.105.27) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Apr 2020
 10:02:51 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <jlayton@kernel.org>, <sage@redhat.com>, <idryomov@gmail.com>
CC:     <ceph-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <wubo40@huawei.com>
Subject: [PATCH] fs/ceph:fix speical error code in ceph_try_get_caps()
Date:   Wed, 29 Apr 2020 10:01:55 +0800
Message-ID: <1588125715-188363-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 3 speical error codes: -EAGAIN/-EFBIG/-ESTALE.
After call try_get_cap_refs function, judge the same 
error code -EAGAIN twice. So corrected the error code of judgment 
from -EAGAIN to -ESTAE.

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 185db76..1a8e20e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2749,7 +2749,7 @@ int ceph_try_get_caps(struct inode *inode, int need, int want,
 
 	ret = try_get_cap_refs(inode, need, want, 0, flags, got);
 	/* three special error codes */
-	if (ret == -EAGAIN || ret == -EFBIG || ret == -EAGAIN)
+	if (ret == -EAGAIN || ret == -EFBIG || ret == -ESTALE)
 		ret = 0;
 	return ret;
 }
-- 
1.8.3.1

