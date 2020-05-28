Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB993C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB559207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzRdGnhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436986AbgE1W13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437193AbgE1WZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:25:17 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5786AC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:25:17 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z206so98150lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U45IbwVeotrZ4OWpZlm/xOgQ9DMhjtz1KtTMQfBvNRQ=;
        b=PzRdGnhq4CSalj3cemkrVuawgIp0SDPG8U3hb8QRmoeml1qcqku32PtmbrjZIoEbuQ
         hnopWcrPvxiLb65ld8qYIihaGWOZUIWCKCyc0ZEyMBaFewRAYPJ4UR6wA+XwTx3LxVhx
         rwrykdRvl4ff2ER3oxF1OCznTYdqVrbsDVzAS7m1klQDqFGXfzRe3CSxQEIBRKclZwSf
         yVViPfn8R0qOzSnM6tpFChsRcK4yTdxiBd84OKNDNvqknoYSiQFivmiS61nuSBFBdbQ2
         bdqOHOvMPYCSoVmb6u+IgEpqRfQNisPTB0jbMzQkdsmjjYVvTO8D1pEbSRFjSqV9/G8+
         RTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U45IbwVeotrZ4OWpZlm/xOgQ9DMhjtz1KtTMQfBvNRQ=;
        b=UF3WUcrOz1V8GgIiOjZq58pmuTZrXxw8QEl6qZ+W/Br9MFuBwK2UIVjs0Bulh8TRo/
         EywwbXpinud3SAWa6z1XZTh3KnHG3xsiQc9yiwd1+bZbRcg0ez2jQIgQeQiSIY7gQRCH
         W/qXT7wnr6xn2klji83qroyhcIC0ujkoqmr6n5oQCpc8MtoKGESv37/PtEy4EdYlsTlW
         4ynZgnkgWX3qGNOK/MKW+pcIMcFWNraKLawUM0AHBtJnvvKwddFv5sBw9KQg1kwmRsem
         AmPEyULUbHaH1Ir4Xpt99ho3Cf8UE70Ss0Djgud05Hd0fGLOF4dMV2AbyMZ6BsJCTOvv
         C0eA==
X-Gm-Message-State: AOAM533FQ6uoAQbcTvqpRekqrIJOAiIQEPjw5EaaESR3Nj7ejDZCMWq6
        UJOr1sz9NzQS9bLckrxi5QU=
X-Google-Smtp-Source: ABdhPJz/b/GogXbdI0eKf+z+rDIqroFDlYigXrikmC7knoKBvuDwXEI1JzvZigVjFwYdDztgJz3t3g==
X-Received: by 2002:ac2:5a07:: with SMTP id q7mr2771451lfn.77.1590704715854;
        Thu, 28 May 2020 15:25:15 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id y11sm1674382lji.52.2020.05.28.15.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:25:15 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] nvme-tcp: constify static struct blk_mq_ops
Date:   Fri, 29 May 2020 00:25:07 +0200
Message-Id: <20200528222507.390172-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvme_tcp_mq_ops and nvme_tcp_admin_mq_ops are never modified and can be
made const to allow the compiler to put them in read-only memory.

Before:
   text    data     bss     dec     hex filename
  53102    6885     576   60563    ec93 drivers/nvme/host/tcp.o

After:
   text    data     bss     dec     hex filename
  53422    6565     576   60563    ec93 drivers/nvme/host/tcp.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/nvme/host/tcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c79e248b9f43..2d6c884afc63 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -131,8 +131,8 @@ struct nvme_tcp_ctrl {
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
 static struct workqueue_struct *nvme_tcp_wq;
-static struct blk_mq_ops nvme_tcp_mq_ops;
-static struct blk_mq_ops nvme_tcp_admin_mq_ops;
+static const struct blk_mq_ops nvme_tcp_mq_ops;
+static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
@@ -2333,7 +2333,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx)
 	return queue->nr_cqe;
 }
 
-static struct blk_mq_ops nvme_tcp_mq_ops = {
+static const struct blk_mq_ops nvme_tcp_mq_ops = {
 	.queue_rq	= nvme_tcp_queue_rq,
 	.complete	= nvme_complete_rq,
 	.init_request	= nvme_tcp_init_request,
@@ -2344,7 +2344,7 @@ static struct blk_mq_ops nvme_tcp_mq_ops = {
 	.poll		= nvme_tcp_poll,
 };
 
-static struct blk_mq_ops nvme_tcp_admin_mq_ops = {
+static const struct blk_mq_ops nvme_tcp_admin_mq_ops = {
 	.queue_rq	= nvme_tcp_queue_rq,
 	.complete	= nvme_complete_rq,
 	.init_request	= nvme_tcp_init_request,
-- 
2.26.2

