Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD5BC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472D0207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 07:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="edQveFVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgANH6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 02:58:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36719 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbgANH57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:57:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id x184so6202309pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 23:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ub9JDyGMUxQof+H4IEJYhc2XianN2EATxXRgJUWENds=;
        b=edQveFVNGBmirFSUcumEYH029TCRAajNzFKT/KzPziTWbIDkCUXYB9yzJaZgYw/4uj
         yxwg6JF698tOKGj+lqOKWp+RJQ2h7YoALN29/Muw1plu6ZbYmzcOnlGI2RSspvswS/Jr
         MTkWIxB+ujwsTChClg36ilwfvAmzGYvvzMW4bEByT0M+oyC0hJt+SZDoFH2AzfhGATFF
         AN52UstsBahraPWXjlDPxxQAvmTvbmry7X50zh3KMGSxmvpzGc5pfneT9navMrmBAqMW
         /iGD0BpXuDtVcxB0tCjCcliVVDOXb6r08uHIUKhRTQxY/H629eycfQNBEpm8eIWbqCoh
         4dKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ub9JDyGMUxQof+H4IEJYhc2XianN2EATxXRgJUWENds=;
        b=GwsES+AW3M9vkCESUgWCj6+7QsQlQpZeYus9aQiaiBfcEsjK0KvRtqnom7x+AK3+mJ
         LLQjx3ChabOnUK54oZ/Ybq8bUidEjC9FrZXAthj6Um6CoyzG2ZxZyxqmJ3VYZ8gQodvX
         f+P1afzkoG3oXHi6U5wPB7D1+BZ+vP8ooXPi91w6Tpo1q/plpe3pRQ8jmLsxgMORkZuG
         PEvaCyMcs1Xn8cV1brBdnfUm5ZBl0g9K8CCFQ3SAex5/tN+kZMeCWJozAjqxBaZ4Eb/R
         PJ4fKVa+GRFdf+z1Ymhhth/9G7DXFp9dO+rV9Up7CRywoqUapY03AUebs0kgODwfHNpE
         fsiA==
X-Gm-Message-State: APjAAAU6llM+7ooM8yC0w140jF7/2eAUjYRJ/AVAlTssBUY+CBjJGeTt
        XDQ5AWGgZ9nC6OoxbjmiHWAf7g==
X-Google-Smtp-Source: APXvYqwPfvh3MFq9kRw0DS1s0ko52noeknCvU4/iqOQN+Ktgm6EgDjVJYUpNyhKEpAdKQm1yj6G2yA==
X-Received: by 2002:a65:4c82:: with SMTP id m2mr24894429pgt.432.1578988678193;
        Mon, 13 Jan 2020 23:57:58 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q63sm17349352pfb.149.2020.01.13.23.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 23:57:57 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 5/5] net: qrtr: Remove receive worker
Date:   Mon, 13 Jan 2020 23:57:03 -0800
Message-Id: <20200114075703.2145718-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200114075703.2145718-1-bjorn.andersson@linaro.org>
References: <20200114075703.2145718-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than enqueuing messages and scheduling a worker to deliver them
to the individual sockets we can now, thanks to the previous work, move
this directly into the endpoint callback.

This saves us a context switch per incoming message and removes the
possibility of an opportunistic suspend to happen between the message is
coming from the endpoint until it ends up in the socket's receive
buffer.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 net/qrtr/qrtr.c | 57 +++++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 40 deletions(-)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index 8ae301132a54..343a94b64f1c 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -119,7 +119,6 @@ static DEFINE_MUTEX(qrtr_port_lock);
  * @qrtr_tx_flow: tree of qrtr_tx_flow, keyed by node << 32 | port
  * @qrtr_tx_lock: lock for qrtr_tx_flow inserts
  * @rx_queue: receive queue
- * @work: scheduled work struct for recv work
  * @item: list item for broadcast list
  */
 struct qrtr_node {
@@ -132,7 +131,6 @@ struct qrtr_node {
 	struct mutex qrtr_tx_lock; /* for qrtr_tx_flow */
 
 	struct sk_buff_head rx_queue;
-	struct work_struct work;
 	struct list_head item;
 };
 
@@ -157,6 +155,8 @@ static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 			      int type, struct sockaddr_qrtr *from,
 			      struct sockaddr_qrtr *to);
+static struct qrtr_sock *qrtr_port_lookup(int port);
+static void qrtr_port_put(struct qrtr_sock *ipc);
 
 /* Release node resources and free the node.
  *
@@ -178,7 +178,6 @@ static void __qrtr_node_release(struct kref *kref)
 	list_del(&node->item);
 	mutex_unlock(&qrtr_node_lock);
 
-	cancel_work_sync(&node->work);
 	skb_queue_purge(&node->rx_queue);
 
 	/* Free tx flow counters */
@@ -422,6 +421,7 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 	struct qrtr_node *node = ep->node;
 	const struct qrtr_hdr_v1 *v1;
 	const struct qrtr_hdr_v2 *v2;
+	struct qrtr_sock *ipc;
 	struct sk_buff *skb;
 	struct qrtr_cb *cb;
 	unsigned int size;
@@ -486,8 +486,20 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 
 	skb_put_data(skb, data + hdrlen, size);
 
-	skb_queue_tail(&node->rx_queue, skb);
-	schedule_work(&node->work);
+	qrtr_node_assign(node, cb->src_node);
+
+	if (cb->type == QRTR_TYPE_RESUME_TX) {
+		qrtr_tx_resume(node, skb);
+	} else {
+		ipc = qrtr_port_lookup(cb->dst_port);
+		if (!ipc)
+			goto err;
+
+		if (sock_queue_rcv_skb(&ipc->sk, skb))
+			goto err;
+
+		qrtr_port_put(ipc);
+	}
 
 	return 0;
 
@@ -522,40 +534,6 @@ static struct sk_buff *qrtr_alloc_ctrl_packet(struct qrtr_ctrl_pkt **pkt)
 	return skb;
 }
 
-static struct qrtr_sock *qrtr_port_lookup(int port);
-static void qrtr_port_put(struct qrtr_sock *ipc);
-
-/* Handle and route a received packet.
- *
- * This will auto-reply with resume-tx packet as necessary.
- */
-static void qrtr_node_rx_work(struct work_struct *work)
-{
-	struct qrtr_node *node = container_of(work, struct qrtr_node, work);
-	struct sk_buff *skb;
-
-	while ((skb = skb_dequeue(&node->rx_queue)) != NULL) {
-		struct qrtr_sock *ipc;
-		struct qrtr_cb *cb = (struct qrtr_cb *)skb->cb;
-
-		qrtr_node_assign(node, cb->src_node);
-
-		if (cb->type == QRTR_TYPE_RESUME_TX) {
-			qrtr_tx_resume(node, skb);
-		} else {
-			ipc = qrtr_port_lookup(cb->dst_port);
-			if (!ipc) {
-				kfree_skb(skb);
-			} else {
-				if (sock_queue_rcv_skb(&ipc->sk, skb))
-					kfree_skb(skb);
-
-				qrtr_port_put(ipc);
-			}
-		}
-	}
-}
-
 /**
  * qrtr_endpoint_register() - register a new endpoint
  * @ep: endpoint to register
@@ -575,7 +553,6 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	if (!node)
 		return -ENOMEM;
 
-	INIT_WORK(&node->work, qrtr_node_rx_work);
 	kref_init(&node->ref);
 	mutex_init(&node->ep_lock);
 	skb_queue_head_init(&node->rx_queue);
-- 
2.24.0

