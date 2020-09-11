Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4F4C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624E1207FB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgIKPQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:16:38 -0400
Received: from mail1.windriver.com ([147.11.146.13]:59212 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgIKPNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:13:23 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 08BFCplq011659
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 11 Sep 2020 08:12:51 -0700 (PDT)
Received: from pek-lwang1-u1404.wrs.com (128.224.162.178) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Sep 2020 08:12:50 -0700
From:   Li Wang <li.wang@windriver.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] vhost: reduce stack usage in log_used
Date:   Fri, 11 Sep 2020 23:09:39 +0800
Message-ID: <1599836979-4950-1-git-send-email-li.wang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warning: [-Werror=-Wframe-larger-than=]

drivers/vhost/vhost.c: In function log_used:
drivers/vhost/vhost.c:1906:1:
warning: the frame size of 1040 bytes is larger than 1024 bytes

Signed-off-by: Li Wang <li.wang@windriver.com>
---
 drivers/vhost/vhost.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index b45519c..41769de 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1884,25 +1884,31 @@ static int log_write_hva(struct vhost_virtqueue *vq, u64 hva, u64 len)
 
 static int log_used(struct vhost_virtqueue *vq, u64 used_offset, u64 len)
 {
-	struct iovec iov[64];
+	struct iovec *iov;
 	int i, ret;
 
 	if (!vq->iotlb)
 		return log_write(vq->log_base, vq->log_addr + used_offset, len);
 
+	iov = kcalloc(64, sizeof(*iov), GFP_KERNEL);
+	if (!iov)
+		return -ENOMEM;
+
 	ret = translate_desc(vq, (uintptr_t)vq->used + used_offset,
 			     len, iov, 64, VHOST_ACCESS_WO);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	for (i = 0; i < ret; i++) {
 		ret = log_write_hva(vq,	(uintptr_t)iov[i].iov_base,
 				    iov[i].iov_len);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
-	return 0;
+out:
+	kfree(iov);
+	return ret;
 }
 
 int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
-- 
2.7.4

