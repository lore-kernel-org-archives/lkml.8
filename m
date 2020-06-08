Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE48C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48EC20812
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663556;
	bh=jBjbkxP1iiBAvE6/2yxT7Dz+8SrZGpJOC8QuAynfkJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L7u0tHQmjFqQGlfmoL5L53GxXrB0BU1xBAs0BCgNoX1inU9vm+KKYAirJIhzGTVKE
	 bZp9X5jyBJ6jfOLLwkTwP6YPGDla5A2OKLD2Z5mLS4lENxfpHlGIX3DZDJGwZt35qJ
	 KQEB1hQFAWTM8pOkcB5O3nQDkAYJrk0Pk6StXN0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgFHXLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbgFHXKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:10:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 085FD21475;
        Mon,  8 Jun 2020 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657806;
        bh=jBjbkxP1iiBAvE6/2yxT7Dz+8SrZGpJOC8QuAynfkJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJlh3yd5WIbE+DTy8OIJfwMVrSYJl8biQCYJWZyD20KTjGH2NXiBjc9rZ4EYBC9cQ
         lQB/UKzKyZB1ieVanEytud1jIow5c258sIFYgfcVHG/aV8h5h0Fz2Dyppoh1kzxsyM
         jZsYVdALjx97LIW3Ix9hw8o4I5WXGuoeQSI/UvxY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 183/274] nvme-tcp: use bh_lock in data_ready
Date:   Mon,  8 Jun 2020 19:04:36 -0400
Message-Id: <20200608230607.3361041-183-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 386e5e6e1aa90b479fcf0467935922df8524393d ]

data_ready may be invoked from send context or from
softirq, so need bh locking for that.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c15a92163c1f..4862fa962011 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -794,11 +794,11 @@ static void nvme_tcp_data_ready(struct sock *sk)
 {
 	struct nvme_tcp_queue *queue;
 
-	read_lock(&sk->sk_callback_lock);
+	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
 	if (likely(queue && queue->rd_enabled))
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
-	read_unlock(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static void nvme_tcp_write_space(struct sock *sk)
-- 
2.25.1

