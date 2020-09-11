Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806ACC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205FC2076C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599837710;
	bh=cQtmOpOnoutgoobVVbzdL9HIMhuV7J7M5jnbYHFYGus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yoWe+w5Xuo0HTaz+e9hq2LVwcP6/idtldskcLVMLlPl9BhiW+uWkZzFz/d2F144Te
	 VW0hETsBQTG6/efyVXZWt/2xryNa+H/PtgPHsJVvvoNFLI4AfsLl+NIbq6dgqjOMSa
	 whLKX7BfWyRXAqnptm6DA+rTPlor05TCma/1g6nY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgIKPVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgIKPPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:15:37 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9703F2220E;
        Fri, 11 Sep 2020 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599829191;
        bh=cQtmOpOnoutgoobVVbzdL9HIMhuV7J7M5jnbYHFYGus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z9q6Kea61bu+b3P+IYnrTOUtynVrwve/Vh9RD9EJ4lc8iGITWsl9dXY+iAeMRLi1v
         iMnBXPQ0aC/zrylit0Kq6HVcKpdCycTwVL0nUo62sVrT3vvtuyJIsWL5nZiIlnsbVZ
         95xno4AvUemBi5L/Py6sLW7Q6BJHTC6na3bp/Ogk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 03/16] RDMA/cma: Simplify DEVICE_REMOVAL for internal_id
Date:   Fri, 11 Sep 2020 14:47:20 +0200
Message-Id: <20200911122459.754211677@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911122459.585735377@linuxfoundation.org>
References: <20200911122459.585735377@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit d54f23c09ec62670901f1a2a4712a5218522ca2b ]

cma_process_remove() triggers an unconditional rdma_destroy_id() for
internal_id's and skips the event deliver and transition through
RDMA_CM_DEVICE_REMOVAL.

This is confusing and unnecessary. internal_id always has
cma_listen_handler() as the handler, have it catch the
RDMA_CM_DEVICE_REMOVAL event and directly consume it and signal removal.

This way the FSM sequence never skips the DEVICE_REMOVAL case and the
logic in this hard to test area is simplified.

Link: https://lore.kernel.org/r/20200723070707.1771101-2-leon@kernel.org
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/cma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index c30cf5307ce3e..537eeebde5f4d 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2482,6 +2482,10 @@ static int cma_listen_handler(struct rdma_cm_id *id,
 {
 	struct rdma_id_private *id_priv = id->context;
 
+	/* Listening IDs are always destroyed on removal */
+	if (event->event == RDMA_CM_EVENT_DEVICE_REMOVAL)
+		return -1;
+
 	id->context = id_priv->id.context;
 	id->event_handler = id_priv->id.event_handler;
 	trace_cm_event_handler(id_priv, event);
@@ -4829,7 +4833,7 @@ static void cma_process_remove(struct cma_device *cma_dev)
 		cma_id_get(id_priv);
 		mutex_unlock(&lock);
 
-		ret = id_priv->internal_id ? 1 : cma_remove_id_dev(id_priv);
+		ret = cma_remove_id_dev(id_priv);
 		cma_id_put(id_priv);
 		if (ret)
 			rdma_destroy_id(&id_priv->id);
-- 
2.25.1



