Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E1EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 187B920663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135928;
	bh=Nm1fwMO8wXN0SEk3BOGnkRWpZBQErIOS1mTcAjnpcs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GhZ5pn5yB5dADfsj+tA6taSfgoM0Yvf7TRzrbPyu2e6WqD06fQLIx3dAWJ4J80DcL
	 niZCyFwLNzEVbOhkUVTNK8/Nz4Fi+3zna+MPosz4GusU8LhuYH3jWLSMIRUOKv8h4M
	 SgUICdwjD/hv6KiSFxXDq6+fVF4fnYNFMwe8kQFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgGGPWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbgGGPWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:22:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 667112078D;
        Tue,  7 Jul 2020 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135344;
        bh=Nm1fwMO8wXN0SEk3BOGnkRWpZBQErIOS1mTcAjnpcs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYV6l3fi97ecIfe/eoZ752kUrB7S/BweFo8+YLEwCXg1Iii9SvV6EH4ZrJRoLKMOF
         wQnqr5Pq7ZvMyJ69fCmY8DIYx1PDPUDtf/ej5tJ5TsrROq2msjJj4gnBxa3CLhe3N1
         vZZnXwce8PBe8JVkkBgjRdDB8tqloEvwR7r/IdW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Tao <houtao1@huawei.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 39/65] virtio-blk: free vblk-vqs in error path of virtblk_probe()
Date:   Tue,  7 Jul 2020 17:17:18 +0200
Message-Id: <20200707145754.348233875@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145752.417212219@linuxfoundation.org>
References: <20200707145752.417212219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit e7eea44eefbdd5f0345a0a8b80a3ca1c21030d06 ]

Else there will be memory leak if alloc_disk() fails.

Fixes: 6a27b656fc02 ("block: virtio-blk: support multi virt queues per virtio-blk device")
Signed-off-by: Hou Tao <houtao1@huawei.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0cf2fe2902307..c1de270046bfe 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -990,6 +990,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	put_disk(vblk->disk);
 out_free_vq:
 	vdev->config->del_vqs(vdev);
+	kfree(vblk->vqs);
 out_free_vblk:
 	kfree(vblk);
 out_free_index:
-- 
2.25.1



