Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F5BC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3AB24955
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgEHOHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:07:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbgEHOHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:07:02 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EE47FB0CF30C41FAAC70;
        Fri,  8 May 2020 22:06:59 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 8 May 2020
 22:06:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <vneethv@linux.ibm.com>, <oberpar@linux.ibm.com>,
        <heiko.carstens@de.ibm.com>, <gor@linux.ibm.com>,
        <borntraeger@de.ibm.com>, <gustavo@embeddedor.com>,
        <yuehaibing@huawei.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] s390/cio: Remove unused inline functionidset_sch_get_first
Date:   Fri, 8 May 2020 22:06:43 +0800
Message-ID: <20200508140643.30540-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 8ebd51a705c5 ("s390/cio: idset.c: remove some unused functions")
left behind this, remove it

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/s390/cio/idset.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
index 77d0ea7b381b..45f9c0736be4 100644
--- a/drivers/s390/cio/idset.c
+++ b/drivers/s390/cio/idset.c
@@ -59,18 +59,6 @@ static inline int idset_contains(struct idset *set, int ssid, int id)
 	return test_bit(ssid * set->num_id + id, set->bitmap);
 }
 
-static inline int idset_get_first(struct idset *set, int *ssid, int *id)
-{
-	int bitnum;
-
-	bitnum = find_first_bit(set->bitmap, set->num_ssid * set->num_id);
-	if (bitnum >= set->num_ssid * set->num_id)
-		return 0;
-	*ssid = bitnum / set->num_id;
-	*id = bitnum % set->num_id;
-	return 1;
-}
-
 struct idset *idset_sch_new(void)
 {
 	return idset_new(max_ssid + 1, __MAX_SUBCHANNEL + 1);
-- 
2.17.1


