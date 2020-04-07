Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844CEC2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C47D2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255215;
	bh=X5su88Ck+vcA/+euMXd0fYE+MAIfr2mwTk/13mbANOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mcKkHPAP8yE2C+alyDa/6TkE5biaO94Gl8vAX8+U9nkbDnzxla4hL82zdQfd4epRb
	 qJ6oc9AOHgMCzGzKbIClxitutxTeMQ7lA4UplfLV87xz+MFrx7tjKnQy9xXjF5Y7r0
	 FtHaNdr6sEiCJrVgbGGeb84tLz4gADBFzaz/hE/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgDGK0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729231AbgDGK0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:26:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA1B62074B;
        Tue,  7 Apr 2020 10:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255210;
        bh=X5su88Ck+vcA/+euMXd0fYE+MAIfr2mwTk/13mbANOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YxpOmALmX9EO4ddfyWF9FCADLAhXyP+g/KH0fPVaEzPJUVVemfxgfePa1uRw3Z0tm
         5wpoIq6HV3erAFxLtpcRrowPqhBoobIpzwrfydo1phay9DUOOd1EYjC+FXxV9mHFxq
         YtitgZ4G4BTtn60bkXgSBxybTAbM9QqFor3IjstI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com
Subject: [PATCH 5.6 05/29] sctp: fix refcount bug in sctp_wfree
Date:   Tue,  7 Apr 2020 12:22:02 +0200
Message-Id: <20200407101452.619901149@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101452.046058399@linuxfoundation.org>
References: <20200407101452.046058399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

[ Upstream commit 5c3e82fe159622e46e91458c1a6509c321a62820 ]

We should iterate over the datamsgs to move
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

Reported-and-tested-by: syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Acked-by: Marcelo Ricardo Leitner <mleitner@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/socket.c |   31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -147,29 +147,44 @@ static void sctp_clear_owner_w(struct sc
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
+			cb(c);	\
+	}			\
+	prev_msg = msg;		\
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
@@ -9574,9 +9589,9 @@ static int sctp_sock_migrate(struct sock
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


