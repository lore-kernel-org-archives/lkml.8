Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3963EC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0590A214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052969;
	bh=0dCjT5nFRePwKB1f0perCjVU+KxOZ4mV+cUHzcKpO9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dGOrpKwCWp6yxI+D8JKASVvF3Oy1MlL2tlzsCs39d8BdvKcqPHso9bLR+UwsHugL9
	 sMOPLHDMTYm616KnSq/3zaJs8jH9WVCTDyxAyg6blWcVHuVlOmFuIHfJJplgXAIlE0
	 7smKXq85eDRz2DG9r1w5IPkR6XCOJBOtUCOTOGX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636650AbgDPQCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895264AbgDPN0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:26:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C100C21D94;
        Thu, 16 Apr 2020 13:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043586;
        bh=0dCjT5nFRePwKB1f0perCjVU+KxOZ4mV+cUHzcKpO9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=esQmO9hGlxbp+UR/reyNqb62RauyXI+lxONZhe01NNRGP/bTWXjOY71pv0Z/p8/bw
         7lF1Gq8WMmqzIN/bPunPXfaWR2b3DuqHmFgvHYqOt5gcOJHR8iYsrDHK1OfcTBv3cD
         ZlxqAECl5B0xotxfV7ODq5DdoR4J3AUBcG9T0AW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Bob Liu <bob.liu@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 018/146] block: keep bdi->io_pages in sync with max_sectors_kb for stacked devices
Date:   Thu, 16 Apr 2020 15:22:39 +0200
Message-Id: <20200416131245.009435547@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

[ Upstream commit e74d93e96d721c4297f2a900ad0191890d2fc2b0 ]

Field bdi->io_pages added in commit 9491ae4aade6 ("mm: don't cap request
size based on read-ahead setting") removes unneeded split of read requests.

Stacked drivers do not call blk_queue_max_hw_sectors(). Instead they set
limits of their devices by blk_set_stacking_limits() + disk_stack_limits().
Field bio->io_pages stays zero until user set max_sectors_kb via sysfs.

This patch updates io_pages after merging limits in disk_stack_limits().

Commit c6d6e9b0f6b4 ("dm: do not allow readahead to limit IO size") fixed
the same problem for device-mapper devices, this one fixes MD RAIDs.

Fixes: 9491ae4aade6 ("mm: don't cap request size based on read-ahead setting")
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Bob Liu <bob.liu@oracle.com>
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-settings.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index be9b39caadbd2..01093b8f3e624 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -717,6 +717,9 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 		printk(KERN_NOTICE "%s: Warning: Device %s is misaligned\n",
 		       top, bottom);
 	}
+
+	t->backing_dev_info->io_pages =
+		t->limits.max_sectors >> (PAGE_SHIFT - 9);
 }
 EXPORT_SYMBOL(disk_stack_limits);
 
-- 
2.20.1



