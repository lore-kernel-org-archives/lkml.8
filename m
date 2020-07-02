Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2724C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B439320737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgGBPBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:01:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39452 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbgGBPBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:01:41 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6EEEFAEEB2DD48F10D2E;
        Thu,  2 Jul 2020 23:01:33 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 23:01:26 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Alasdair Kergon <agk@redhat.com>,
        "Mike Snitzer" <snitzer@redhat.com>, Hannes Reinecke <hare@suse.de>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] dm zoned: fix unused but set variable warnings
Date:   Thu, 2 Jul 2020 23:11:40 +0800
Message-ID: <20200702151140.5466-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix unused but set variable warnings:

drivers/md/dm-zoned-reclaim.c:504:42: warning:
 variable nr_rnd set but not used [-Wunused-but-set-variable]
  504 |  unsigned int p_unmap, nr_unmap_rnd = 0, nr_rnd = 0;
      |                                          ^~~~~~
drivers/md/dm-zoned-reclaim.c:504:24: warning:
 variable nr_unmap_rnd set but not used [-Wunused-but-set-variable]
  504 |  unsigned int p_unmap, nr_unmap_rnd = 0, nr_rnd = 0;
      |                        ^~~~~~~~~~~~

Fixes: f97809aec589 ("dm zoned: per-device reclaim")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/md/dm-zoned-reclaim.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/md/dm-zoned-reclaim.c b/drivers/md/dm-zoned-reclaim.c
index dd1eebf6e50f..7e0cc2d732cf 100644
--- a/drivers/md/dm-zoned-reclaim.c
+++ b/drivers/md/dm-zoned-reclaim.c
@@ -501,7 +501,7 @@ static void dmz_reclaim_work(struct work_struct *work)
 {
 	struct dmz_reclaim *zrc = container_of(work, struct dmz_reclaim, work.work);
 	struct dmz_metadata *zmd = zrc->metadata;
-	unsigned int p_unmap, nr_unmap_rnd = 0, nr_rnd = 0;
+	unsigned int p_unmap;
 	int ret;
 
 	if (dmz_dev_is_dying(zmd))
@@ -527,9 +527,6 @@ static void dmz_reclaim_work(struct work_struct *work)
 		zrc->kc_throttle.throttle = min(75U, 100U - p_unmap / 2);
 	}
 
-	nr_unmap_rnd = dmz_nr_unmap_rnd_zones(zmd, zrc->dev_idx);
-	nr_rnd = dmz_nr_rnd_zones(zmd, zrc->dev_idx);
-
 	DMDEBUG("(%s/%u): Reclaim (%u): %s, %u%% free zones (%u/%u cache %u/%u random)",
 		dmz_metadata_label(zmd), zrc->dev_idx,
 		zrc->kc_throttle.throttle,

