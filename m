Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99FAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB0320738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135134;
	bh=6Tc+4crn+p9A5zdLf83nRerooyDn77JqdPDXeS+DMfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zaFpHBwpufdwvqqiS/tv3pl5Ciwv1d5cafIKBi86c+nqFCpdJ4YgHNPApnezTgsnM
	 s9AI6ctsgiw9kml+yfvfzvIEAT1ovO/k0W/MiNnsjffCLyg39MWPTTDA6KIeuLCNHP
	 aB0+rtEACVAEAjfYVds6zldhpYG7Rm8YLxq4f/Ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgGGPSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbgGGPSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:18:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AB1320738;
        Tue,  7 Jul 2020 15:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135130;
        bh=6Tc+4crn+p9A5zdLf83nRerooyDn77JqdPDXeS+DMfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8qTvjt/VxIVoP9MFoiJk7fz/xkisCBD1+L9PW1QsGtNPo7awnA74zRLncuwiLmrg
         sHrLliS8by4lWgi+z6/j5A4o1jocIj2u1a1opST1/gTCZ5un9zxBjkStmeflaCBi14
         Ng0B7Z4+tf7x1BD1mvOfk8kzuY1plWrdq1/pRyoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Tao <houtao1@huawei.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 22/36] virtio-blk: free vblk-vqs in error path of virtblk_probe()
Date:   Tue,  7 Jul 2020 17:17:14 +0200
Message-Id: <20200707145750.188557862@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145749.130272978@linuxfoundation.org>
References: <20200707145749.130272978@linuxfoundation.org>
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
index 9be54e5ef96ae..075523777a4a9 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -882,6 +882,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	put_disk(vblk->disk);
 out_free_vq:
 	vdev->config->del_vqs(vdev);
+	kfree(vblk->vqs);
 out_free_vblk:
 	kfree(vblk);
 out_free_index:
-- 
2.25.1



