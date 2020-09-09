Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08F8C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D2A2067C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="o0bNKeWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgIIQA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:00:29 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:51034 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730577AbgIIP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:58:41 -0400
X-Greylist: delayed 965 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Sep 2020 11:58:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uwS0B
        ZkJxp7aqJXVSsXep+7iwuK+EfIF9+hccxzGrAk=; b=o0bNKeWGTJfkaOxtSEh1D
        +GzlLtBIscb9UKl7SP608fxmKv0nZrQj+Oi54aEY9UpoEf7mYdqKfX3sX5mtV98m
        9hyFvY1qoKiTO+LyzvclhewoOZLDuXZkV9nOaXuI4hALSFpOUYPIumz1stLulSOu
        spaq7Nb9nUpWM0nrcRdSOE=
Received: from ubuntu.localdomain (unknown [183.158.94.209])
        by smtp5 (Coremail) with SMTP id HdxpCgA3yCCm91hfB2vFJw--.5S4;
        Wed, 09 Sep 2020 23:41:27 +0800 (CST)
From:   Li Qiang <liq3ea@163.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        liq3ea@gmail.com, Li Qiang <liq3ea@163.com>
Subject: [PATCH] vhost-vdpa: fix memory leak in error path
Date:   Wed,  9 Sep 2020 08:41:20 -0700
Message-Id: <20200909154120.363209-1-liq3ea@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgA3yCCm91hfB2vFJw--.5S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw48JF1UtFy5uw47WFWxZwb_yoWfCrXE9w
        4xurn7JFn3tr4Yv3ZFyw4fAry7KFsru3Z3u3WFkryavF17Z3ZIq3W8ZrnrJw17XrWxGa43
        Crn7Cr1I9F1ftjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRIztUUUUUU==
X-Originating-IP: [183.158.94.209]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBLweabVUMN-fMFgAAsc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free the 'page_list' when the 'npages' is zero.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 drivers/vhost/vdpa.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 3fab94f88894..6a9fcaf1831d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -609,8 +609,10 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 		gup_flags |= FOLL_WRITE;
 
 	npages = PAGE_ALIGN(msg->size + (iova & ~PAGE_MASK)) >> PAGE_SHIFT;
-	if (!npages)
-		return -EINVAL;
+	if (!npages) {
+		ret = -EINVAL;
+		goto free_page;
+	}
 
 	mmap_read_lock(dev->mm);
 
@@ -666,6 +668,8 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 		atomic64_sub(npages, &dev->mm->pinned_vm);
 	}
 	mmap_read_unlock(dev->mm);
+
+free_page:
 	free_page((unsigned long)page_list);
 	return ret;
 }
-- 
2.25.1

