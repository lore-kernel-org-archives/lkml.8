Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384DEC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 01:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCAD20774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 01:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuNIE00h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgC0BTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 21:19:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38270 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbgC0BTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 21:19:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id w3so2843567plz.5;
        Thu, 26 Mar 2020 18:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8RzccpdJs/G4g/YI70Cb7EPmR/Et2mXpJnq1PHg6nSk=;
        b=kuNIE00hSfe4Qa8d/4Dkb6zmRsWekGmGOLYtU6xT+ys2w9YxVaylami9atibTZ//6U
         hCo045d/sRdh1jC+pUSbb+cmQb5fXF7VD3WXhfu685urCuH0cvitL7Ebj1D5/VKrmiuB
         J+bQB+ccBhjMj+XtxEeM+anwRAV+T263V5YbLrcTVTQntq5OhC2I5DtjRBxJJi0ObgTD
         asj0Ibr0bRSctoetbGOp3G7HaDaRvbYnP1SDIgllBQAcjws0G45y4eWm+2cG5neWUEMQ
         VAllnvGj4VankHCxYF4F3ZQR87BMH6Q14ThWRZK3C9Q3Ja2m6oN+MWCWiFd17ihbZWH1
         +O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8RzccpdJs/G4g/YI70Cb7EPmR/Et2mXpJnq1PHg6nSk=;
        b=mzGRPrG2ltSm8GKrUx5fH06eYRXent6vrAdDos1kp7Oqh5zYL8Lbw2NwqnL8QXRnNw
         cltWFakfRgxfQcelOYINnXkVPHB0GO3O6CCwrvubq/aF58BHH6xmgH1Hz3MUm5t5xbKq
         nrgSjVlmBZMQJrNZs7FvSi6gO3aojg2PYEoaZDV08aF0+IePDt2i/b+yrnKTaEK/I+i1
         sDoJwfRk5IGbDl7ovfGbdNL1EBZRiPBns/QWKapDVTOXXaizBFSYQiTz6OMuv/txVICp
         vSwTBaa8o31Hkxxa9D7ahZnwLYfbHWYQ0RXQIueL1CqXnCeFWT6bFO+7nPBqmjqE7bPd
         XhZg==
X-Gm-Message-State: ANhLgQ2ZNJXQ58bnd4KQD99/veqlj08Tp3acGlQicE+SUbXa7NhIGe0E
        J9BscE3IkzEJnNMnGQkxezs=
X-Google-Smtp-Source: ADFU+vutGYgWglpq5wY7uxRtBeJgiwazJiQtmeF0fbJ9rqpi474voEdnnWFDmrGj4biq9HgGHe5IIg==
X-Received: by 2002:a17:90a:208:: with SMTP id c8mr3056837pjc.153.1585271958559;
        Thu, 26 Mar 2020 18:19:18 -0700 (PDT)
Received: from localhost ([161.117.239.120])
        by smtp.gmail.com with ESMTPSA id y7sm2701914pfq.159.2020.03.26.18.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 18:19:18 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     marcelo.leitner@gmail.com, davem@davemloft.net
Cc:     vyasevich@gmail.com, nhorman@tuxdriver.com, kuba@kernel.org,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, anenbupt@gmail.com,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH v5] sctp: fix refcount bug in sctp_wfree
Date:   Fri, 27 Mar 2020 09:19:12 +0800
Message-Id: <20200327011912.19040-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should iterate over the datamsgs to modify
all chunks(skbs) to newsk.

The following case cause the bug:
for the trouble SKB, it was in outq->transmitted list

sctp_outq_sack
        sctp_check_transmitted
                SKB was moved to outq->sacked list
        then throw away the sack queue
                SKB was deleted from outq->sacked
(but it was held by datamsg at sctp_datamsg_to_asoc
So, sctp_wfree was not called here)

then migrate happened

        sctp_for_each_tx_datachunk(
        sctp_clear_owner_w);
        sctp_assoc_migrate();
        sctp_for_each_tx_datachunk(
        sctp_set_owner_w);
SKB was not in the outq, and was not changed to newsk

finally

__sctp_outq_teardown
        sctp_chunk_put (for another skb)
                sctp_datamsg_put
                        __kfree_skb(msg->frag_list)
                                sctp_wfree (for SKB)
	SKB->sk was still oldsk (skb->sk != asoc->base.sk).

Reported-and-tested-by:syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 net/sctp/socket.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 1b56fc440606..75acbd5d4597 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -147,29 +147,43 @@ static void sctp_clear_owner_w(struct sctp_chunk *chunk)
 	skb_orphan(chunk->skb);
 }
 
+#define traverse_and_process()	\
+do {				\
+	msg = chunk->msg;	\
+	if (msg == prev_msg)	\
+		continue;	\
+	list_for_each_entry(c, &msg->chunks, frag_list) {	\
+		if ((clear && asoc->base.sk == c->skb->sk) ||	\
+		    (!clear && asoc->base.sk != c->skb->sk))	\
+		    cb(c);	\
+	}			\
+} while (0)
+
 static void sctp_for_each_tx_datachunk(struct sctp_association *asoc,
+				       bool clear,
 				       void (*cb)(struct sctp_chunk *))
 
 {
+	struct sctp_datamsg *msg, *prev_msg = NULL;
 	struct sctp_outq *q = &asoc->outqueue;
+	struct sctp_chunk *chunk, *c;
 	struct sctp_transport *t;
-	struct sctp_chunk *chunk;
 
 	list_for_each_entry(t, &asoc->peer.transport_addr_list, transports)
 		list_for_each_entry(chunk, &t->transmitted, transmitted_list)
-			cb(chunk);
+			traverse_and_process();
 
 	list_for_each_entry(chunk, &q->retransmit, transmitted_list)
-		cb(chunk);
+		traverse_and_process();
 
 	list_for_each_entry(chunk, &q->sacked, transmitted_list)
-		cb(chunk);
+		traverse_and_process();
 
 	list_for_each_entry(chunk, &q->abandoned, transmitted_list)
-		cb(chunk);
+		traverse_and_process();
 
 	list_for_each_entry(chunk, &q->out_chunk_list, list)
-		cb(chunk);
+		traverse_and_process();
 }
 
 static void sctp_for_each_rx_skb(struct sctp_association *asoc, struct sock *sk,
@@ -9574,9 +9588,9 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	 * paths won't try to lock it and then oldsk.
 	 */
 	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
-	sctp_for_each_tx_datachunk(assoc, sctp_clear_owner_w);
+	sctp_for_each_tx_datachunk(assoc, true, sctp_clear_owner_w);
 	sctp_assoc_migrate(assoc, newsk);
-	sctp_for_each_tx_datachunk(assoc, sctp_set_owner_w);
+	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w);
 
 	/* If the association on the newsk is already closed before accept()
 	 * is called, set RCV_SHUTDOWN flag.
-- 
2.17.1

