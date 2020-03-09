Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE587C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8C32464B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="czH3TJwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCIVH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:07:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36321 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgCIVH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:07:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so4508382plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Wg7ehxrunSfoR3umIXJG6GeJRSgWVF/eVhTjd0DeUpo=;
        b=czH3TJwKaynTxAvppZyJ015RDYBkBPs2pb5+XLo29ytW+Ib2kKleMNca9WHbclK+ut
         s40C6dyix2Rh5Dng2HUhh6pbw3+n4CtUwPtKc/By8YuLfx/lG4emfrekiHNNKd8R3DFa
         lgt3hjPrRhh7RCQYwjI0Ie4IXv6jEvCuzh0Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wg7ehxrunSfoR3umIXJG6GeJRSgWVF/eVhTjd0DeUpo=;
        b=CI0prWqbN/OEJv7OqPYQu0yXWLbKCVrMia3qlfJvXHm5IR4+pT6Bq0qm8Ktzj1E3qq
         4MlIJq/N9/RFx6abFKK0D0CN39xQmDuz7ZMypNc6MbFe94aHsll+QsIgwyYfhv1gR97u
         ZLyyFxe8RUT97UGyoZfmU9xM0NIl/vG4h1HED+BRevHXGwc91R0eJjl9/Ux3ZOoIlH8I
         5U0UjqGhQOIb6FZxcf9UdzJQ4GsthNxsXi1TIT4A9KCDCIr5/ZjkvIGTA1rQ2LTER+Ne
         Xf9FDji3P7WM5ZE9tFfnlilIu4EjQG5M5XRfW76j6cOmS+oR/7XUJy7QKxWjsfKF3s2i
         0OoA==
X-Gm-Message-State: ANhLgQ3mMyCirOFH1XX7KMseOFsT0P3Lode9l0KP5VjkBPUsITQB4H5z
        QRRBvhzvfnJqTYV51WFPgYqnRg==
X-Google-Smtp-Source: ADFU+vtxrF3SIlgRDL8tah3k0WYVLq8W7zIdoqLKtPNGtefE87yW3fuwxIJr+qp9R7BfS0ylIEkFOw==
X-Received: by 2002:a17:90a:21ce:: with SMTP id q72mr926921pjc.160.1583788075123;
        Mon, 09 Mar 2020 14:07:55 -0700 (PDT)
Received: from dev-psajeepa.dev.purestorage.com ([192.30.188.252])
        by smtp.googlemail.com with ESMTPSA id w206sm2876936pfc.54.2020.03.09.14.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Mar 2020 14:07:54 -0700 (PDT)
From:   Prabhath Sajeepa <psajeepa@purestorage.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     psajeepa@purestorage.com, roland@purestorage.com
Subject: [PATCH] nvme-rdma: Avoid double freeing of async event data
Date:   Mon,  9 Mar 2020 15:07:53 -0600
Message-Id: <1583788073-39681-1-git-send-email-psajeepa@purestorage.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timeout of identify cmd, which is invoked as part of admin queue
creation, can result in freeing of async event data both in
nvme_rdma_timeout handler and error handling path of
nvme_rdma_configure_admin queue thus causing NULL pointer reference.
Call Trace:
 ? nvme_rdma_setup_ctrl+0x223/0x800 [nvme_rdma]
 nvme_rdma_create_ctrl+0x2ba/0x3f7 [nvme_rdma]
 nvmf_dev_write+0xa54/0xcc6 [nvme_fabrics]
 __vfs_write+0x1b/0x40
 vfs_write+0xb2/0x1b0
 ksys_write+0x61/0xd0
 __x64_sys_write+0x1a/0x20
 do_syscall_64+0x60/0x1e0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Prabhath Sajeepa <psajeepa@purestorage.com>
Reviewed-by: Roland Dreier <roland@purestorage.com>
---
 drivers/nvme/host/rdma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3e85c5c..0fe08c4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -850,9 +850,11 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (new)
 		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
 out_free_async_qe:
-	nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
-		sizeof(struct nvme_command), DMA_TO_DEVICE);
-	ctrl->async_event_sqe.data = NULL;
+	if (ctrl->async_event_sqe.data) {
+		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
+			sizeof(struct nvme_command), DMA_TO_DEVICE);
+		ctrl->async_event_sqe.data = NULL;
+	}
 out_free_queue:
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 	return error;
-- 
2.7.4

