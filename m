Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF4FC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937B924739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195813;
	bh=GqT+VFCz0fjwLD0nspadbZFk3K0CQrDFdoHxecWoKJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GePdKyS3zDXy/B+6H5LOrkADirbk50qXgq41+LYD8EmbikA9rY04KtH/gBtU/LwI5
	 olwpohcoVrdCorP7mZCcEdb+qvuFm2q1Bqok7eE9sOxbuZis/NYrH7NTzFGrVWcp/d
	 zlHCzN6sufqq/kjRiJbZGcwHdQz//LHbmeujpzkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404332AbgAPRaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:30:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392960AbgAPRaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:30:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D303324721;
        Thu, 16 Jan 2020 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195805;
        bh=GqT+VFCz0fjwLD0nspadbZFk3K0CQrDFdoHxecWoKJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeIDTAum8YvyOGvNSCbuMlKUy5AFa40ICcUYOI67uU4Q84F0BEKzwXfbq9iJoX1jM
         +Rg78qkTTtdpyKDSG/yy0DL+lJFwR8pdH3f7F40GHXUo4vQgt0DzwDQu/0vk87cQ8S
         Ob1AtOQcePEfcsb0fc2blqrN8moiXuigs+XD6BGE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 319/371] net: add {READ|WRITE}_ONCE() annotations on ->rskq_accept_head
Date:   Thu, 16 Jan 2020 12:23:11 -0500
Message-Id: <20200116172403.18149-262-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 60b173ca3d1cd1782bd0096dc17298ec242f6fb1 ]

reqsk_queue_empty() is called from inet_csk_listen_poll() while
other cpus might write ->rskq_accept_head value.

Use {READ|WRITE}_ONCE() to avoid compiler tricks
and potential KCSAN splats.

Fixes: fff1f3001cc5 ("tcp: add a spinlock to protect struct request_sock_queue")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pvcalls-back.c      | 2 +-
 include/net/request_sock.h      | 4 ++--
 net/ipv4/inet_connection_sock.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index abd6dbc29ac2..58be15c27b6d 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -792,7 +792,7 @@ static int pvcalls_back_poll(struct xenbus_device *dev,
 	mappass->reqcopy = *req;
 	icsk = inet_csk(mappass->sock->sk);
 	queue = &icsk->icsk_accept_queue;
-	data = queue->rskq_accept_head != NULL;
+	data = READ_ONCE(queue->rskq_accept_head) != NULL;
 	if (data) {
 		mappass->reqcopy.cmd = 0;
 		ret = 0;
diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 23e22054aa60..04aa2c7d35c4 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -181,7 +181,7 @@ void reqsk_fastopen_remove(struct sock *sk, struct request_sock *req,
 
 static inline bool reqsk_queue_empty(const struct request_sock_queue *queue)
 {
-	return queue->rskq_accept_head == NULL;
+	return READ_ONCE(queue->rskq_accept_head) == NULL;
 }
 
 static inline struct request_sock *reqsk_queue_remove(struct request_sock_queue *queue,
@@ -193,7 +193,7 @@ static inline struct request_sock *reqsk_queue_remove(struct request_sock_queue
 	req = queue->rskq_accept_head;
 	if (req) {
 		sk_acceptq_removed(parent);
-		queue->rskq_accept_head = req->dl_next;
+		WRITE_ONCE(queue->rskq_accept_head, req->dl_next);
 		if (queue->rskq_accept_head == NULL)
 			queue->rskq_accept_tail = NULL;
 	}
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index f7224c4fc30f..da55ce62fe50 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -936,7 +936,7 @@ struct sock *inet_csk_reqsk_queue_add(struct sock *sk,
 		req->sk = child;
 		req->dl_next = NULL;
 		if (queue->rskq_accept_head == NULL)
-			queue->rskq_accept_head = req;
+			WRITE_ONCE(queue->rskq_accept_head, req);
 		else
 			queue->rskq_accept_tail->dl_next = req;
 		queue->rskq_accept_tail = req;
-- 
2.20.1

