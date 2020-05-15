Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D2FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE2520748
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589508957;
	bh=L9+TTBBOKheIWuMPzBAUV5fbpWKbO78Ws7uOfGtM91U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AytEfXJuUg/Vk2wLg7sXulyCFbU6eBLlhs/WqXhBL48PzKi1oxSKLCmBzESM9amXl
	 RFkPNfv+tGf8S1ss16tn6xPrZBeXbB7uDQFKrpZ10xtdHJe6o5dveB99shWhQnnFQb
	 fSlu5HEcQfKd/IxAOoTf0jTIO8WWzXY+AgvXGvkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgEOCP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 22:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgEOCP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 22:15:56 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD68D20671;
        Fri, 15 May 2020 02:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589508956;
        bh=L9+TTBBOKheIWuMPzBAUV5fbpWKbO78Ws7uOfGtM91U=;
        h=From:To:Cc:Subject:Date:From;
        b=R4YIhfDdLDZQrkzG86difRUEi0nJs0K06eGeJBj3DCbc12JXuQXcl1LmlYzeyLTG8
         Xs02DWrNtjheyiub5zZIQ+hhMePNJ8kAdd1lPHF8G77ol0smqi7ZjovaMtlpXEtekz
         r6WF7wECD7wYI4QiSIsa4wliw/CM3hgSEzyeYJjI=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: flush dirty meta pages when flushing them
Date:   Thu, 14 May 2020 19:15:54 -0700
Message-Id: <20200515021554.226835-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's guarantee flusing dirty meta pages to avoid infinite loop.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 620a386d82c1a..9a7f695d5adb3 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1266,6 +1266,9 @@ void f2fs_wait_on_all_pages(struct f2fs_sb_info *sbi, int type)
 		if (unlikely(f2fs_cp_error(sbi)))
 			break;
 
+		if (type == F2FS_DIRTY_META)
+			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
+							FS_CP_META_IO);
 		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 	}
 	finish_wait(&sbi->cp_wait, &wait);
@@ -1493,8 +1496,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
 
-	/* Here, we have one bio having CP pack except cp pack 2 page */
-	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
 	/* Wait for all dirty meta pages to be submitted for IO */
 	f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META);
 
-- 
2.26.2.761.g0e0b3e54be-goog

