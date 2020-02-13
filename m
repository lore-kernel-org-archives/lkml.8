Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A84C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EC220675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608144;
	bh=OBudWwLaKIgRwJwUVqgm2yLIjoeMSr2ZkCKtSc+IYjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HACl+hWePIZrElqa0TM/VmunctnrZ+LAmcI8q1AQDsZZBB6os72AX+48Vtwk3qbXg
	 vJZWyWn9D+MfMO3WFoHc5Rl9i0YvWikvHBp6hr9Qdd9Ue7NWZx65DsYq/F54vIUeIZ
	 PTBFTDYS2Ae/8Cxw1Eg3cHK1//D/JcLA/BSIoLHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbgBMPbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:31:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729525AbgBMP16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:58 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C922168B;
        Thu, 13 Feb 2020 15:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607678;
        bh=OBudWwLaKIgRwJwUVqgm2yLIjoeMSr2ZkCKtSc+IYjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9K5EbvTZEu0gM34L9V/+SHt+OtYoq4evtNEDqBbfciT2HzcTO5RD0BCF0ljWOQkw
         pHR11CTK6aThi5CMF1s20nJe6unYnTaynsusfeN+AVPpJKShCJfQj2l1cf3FEEqtic
         /ilIfZjRZC9oh15HvSD0VFkv8XeMijVH6RgjEml4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.5 001/120] IB/mlx4: Fix memory leak in add_gid error flow
Date:   Thu, 13 Feb 2020 07:19:57 -0800
Message-Id: <20200213151901.536306294@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

commit eaad647e5cc27f7b46a27f3b85b14c4c8a64bffa upstream.

In procedure mlx4_ib_add_gid(), if the driver is unable to update the FW
gid table, there is a memory leak in the driver's copy of the gid table:
the gid entry's context buffer is not freed.

If such an error occurs, free the entry's context buffer, and mark the
entry as available (by setting its context pointer to NULL).

Fixes: e26be1bfef81 ("IB/mlx4: Implement ib_device callbacks")
Link: https://lore.kernel.org/r/20200115085050.73746-1-leon@kernel.org
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx4/main.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -246,6 +246,13 @@ static int mlx4_ib_update_gids(struct gi
 	return mlx4_ib_update_gids_v1(gids, ibdev, port_num);
 }
 
+static void free_gid_entry(struct gid_entry *entry)
+{
+	memset(&entry->gid, 0, sizeof(entry->gid));
+	kfree(entry->ctx);
+	entry->ctx = NULL;
+}
+
 static int mlx4_ib_add_gid(const struct ib_gid_attr *attr, void **context)
 {
 	struct mlx4_ib_dev *ibdev = to_mdev(attr->device);
@@ -313,6 +320,8 @@ static int mlx4_ib_add_gid(const struct
 				     GFP_ATOMIC);
 		if (!gids) {
 			ret = -ENOMEM;
+			*context = NULL;
+			free_gid_entry(&port_gid_table->gids[free]);
 		} else {
 			for (i = 0; i < MLX4_MAX_PORT_GIDS; i++) {
 				memcpy(&gids[i].gid, &port_gid_table->gids[i].gid, sizeof(union ib_gid));
@@ -324,6 +333,12 @@ static int mlx4_ib_add_gid(const struct
 
 	if (!ret && hw_update) {
 		ret = mlx4_ib_update_gids(gids, ibdev, attr->port_num);
+		if (ret) {
+			spin_lock_bh(&iboe->lock);
+			*context = NULL;
+			free_gid_entry(&port_gid_table->gids[free]);
+			spin_unlock_bh(&iboe->lock);
+		}
 		kfree(gids);
 	}
 
@@ -353,10 +368,7 @@ static int mlx4_ib_del_gid(const struct
 		if (!ctx->refcount) {
 			unsigned int real_index = ctx->real_index;
 
-			memset(&port_gid_table->gids[real_index].gid, 0,
-			       sizeof(port_gid_table->gids[real_index].gid));
-			kfree(port_gid_table->gids[real_index].ctx);
-			port_gid_table->gids[real_index].ctx = NULL;
+			free_gid_entry(&port_gid_table->gids[real_index]);
 			hw_update = 1;
 		}
 	}


