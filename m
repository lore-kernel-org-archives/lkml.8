Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4901C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF5120857
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758375;
	bh=XCxwy+iuvEeXRUIunYRd/AZvIMUpSBS5xe9dF3w4oJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AfxfR2XLTCMq6jdSKBq7lEczyP9kb9b6C7GKm6YW+gfJLUgw4jluYVYXF2PF3635J
	 +Nn9gXQGGV/NLIT3R20hR6IEkPTw9xB2GzQ/MvVs0uSQBfORQvVD76F9uJmqZdvSyC
	 1T8kMkCcnYmpLkS+O54AQZv/cH+gELHz/NCwlLq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbgDAQ0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387869AbgDAQ0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:26:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 325EE20857;
        Wed,  1 Apr 2020 16:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758368;
        bh=XCxwy+iuvEeXRUIunYRd/AZvIMUpSBS5xe9dF3w4oJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p222NCM21VJ8xugndEJcPGyI+vKsn2nIMsdogmF4dQA/kGKcfj1PDKS4c8B3c1KD/
         G7OMJ4BKmQoSydAIq2wMQ1hCXGP0MezT67dXFP6uhhRcv7n80T2qtX1mBRHJjJ6dPB
         1gsG9aJzUrsulGOIgMvWgBm7Er9lSbzYE277ONfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.19 067/116] RDMA/mlx5: Block delay drop to unprivileged users
Date:   Wed,  1 Apr 2020 18:17:23 +0200
Message-Id: <20200401161551.826578551@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

commit ba80013fba656b9830ef45cd40a6a1e44707f47a upstream.

It has been discovered that this feature can globally block the RX port,
so it should be allowed for highly privileged users only.

Fixes: 03404e8ae652("IB/mlx5: Add support to dropless RQ")
Link: https://lore.kernel.org/r/20200322124906.1173790-1-leon@kernel.org
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/qp.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -5524,6 +5524,10 @@ struct ib_wq *mlx5_ib_create_wq(struct i
 	if (udata->outlen && udata->outlen < min_resp_len)
 		return ERR_PTR(-EINVAL);
 
+	if (!capable(CAP_SYS_RAWIO) &&
+	    init_attr->create_flags & IB_WQ_FLAGS_DELAY_DROP)
+		return ERR_PTR(-EPERM);
+
 	dev = to_mdev(pd->device);
 	switch (init_attr->wq_type) {
 	case IB_WQT_RQ:


