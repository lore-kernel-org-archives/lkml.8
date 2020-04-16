Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B11C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5885520732
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052079;
	bh=rcjh3l3DjFWYTa13HVk4wQSTUrOgmQ2s6RvdNQnB9Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2kBMj78ZK9uIIFlvP0pW2pAyRUkW6OTnusWbMKdcB7lBJpQLjB30YEEJ4IHriIXsD
	 UKr1GCBGn8aQXAGZ+iPyOnfNBEgH+9zasXzo+Kikaj5Dt6uiG6pFqSjogDJLUgUut+
	 Mfd8uGcoCjk5/zGxkcx0Gq8+oOg5R/AG/5PhQXoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410570AbgDPPrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896725AbgDPNdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:33:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E138221F7;
        Thu, 16 Apr 2020 13:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044013;
        bh=rcjh3l3DjFWYTa13HVk4wQSTUrOgmQ2s6RvdNQnB9Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CsQXGV9PSkJRUvJrFg0bj3bEMAUl4g6wwF1cdPzvwl1IpwvOLhRw42WZuIWR2X04q
         o+0jW36dVUhUi8l4l/QF4U75t1buZelzaYzIzUKdPcgUx3riDc17A/QWc8SnyD4LIy
         lgIfMTHAZ2vq+ExUlzpsZ6YPN4fD9HgD4vnA77dk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Bob Liu <bob.liu@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 046/257] block: keep bdi->io_pages in sync with max_sectors_kb for stacked devices
Date:   Thu, 16 Apr 2020 15:21:37 +0200
Message-Id: <20200416131331.693890006@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
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
index c8eda2e7b91e4..be1dca0103a45 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -664,6 +664,9 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
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



