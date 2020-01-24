Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB04C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D0520704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860373;
	bh=43SFfzDKcXQY3xAetXDhY24rtTdafTNUogZMzqoNaxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1uIOzE6FTV76vGvYg9/BvzU+9ddcycZJjBdNZtDoGgvt+ZXkkTzbaUYM5WQF7PfuB
	 HecdOlw9wWttyxj7jVNKvyoWcgWBRPoNAk2Iq2B09i3Eo/iJkehfyEmUVaHvTc93ML
	 8qJo0OUOnyNW/BIkZHnj5i0vi0nO0/9PqRBGhx5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbgAXKGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389276AbgAXKGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:06:09 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0487320704;
        Fri, 24 Jan 2020 10:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860368;
        bh=43SFfzDKcXQY3xAetXDhY24rtTdafTNUogZMzqoNaxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ltYkU9g7R/97XVVIMZjIXatSMlXcHiPZLZMYm+YMGCqAohlOjUlQzSPury2IhwW3P
         kfhCSGd/j6GKSjogl7e49Azd9Wp5Urn/btH4x4oKTRHVbw662ZlBhbkIDFzhpikqMC
         gc3yJoUFnScYfIfuy+hwCw+DBUlMZD/cmGpwWJ6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 323/343] net: add {READ|WRITE}_ONCE() annotations on ->rskq_accept_head
Date:   Fri, 24 Jan 2020 10:32:21 +0100
Message-Id: <20200124093002.280644130@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index abd6dbc29ac28..58be15c27b6d6 100644
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
index 23e22054aa60d..04aa2c7d35c4e 100644
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
index f7224c4fc30fe..da55ce62fe50b 100644
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



