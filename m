Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E3BC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE9920663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443783;
	bh=3f+xAsZglAs3nw2pTn20rB9JZ3gYLL6Fy0LGgfxbCME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2F0HJVGPpCHfgRGEqdrPXUq6qHsneHcXBNdzvfNoEnWm2KP+29krlMimzL4hM2Z/d
	 /2nnFORW3/v8ur5AVCA1fLgFC34ZVY2+2Dqcumrv40VHw7D5sdpMdWAE0ObvufpoCc
	 hqzcEQ1EmQizqdeuR/KKxOavXAyrez0naQZwm4Ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgCQLJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbgCQLJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:09:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F440205ED;
        Tue, 17 Mar 2020 11:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443389;
        bh=3f+xAsZglAs3nw2pTn20rB9JZ3gYLL6Fy0LGgfxbCME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yBXOIu4g5ri2N0aW9y9rrXFcmJ3s09ahWjfn2tgecZQAXIx+pNbEm2RIurLTqO111
         hs14xKhkpd/83t2bCoMFj8PZiAoAi/e5QD91ohj2DWuPIKaXzPgU8oMTXzC0erCPU+
         VUFQlz2GCLx3Bo5quLsdql6z1UU4MrP9HI9IEiGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 068/151] s390/qeth: handle error when backing RX buffer
Date:   Tue, 17 Mar 2020 11:54:38 +0100
Message-Id: <20200317103331.335479893@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 17413852804d7e86e6f0576cca32c1541817800e ]

qeth_init_qdio_queues() fills the RX ring with an initial set of
RX buffers. If qeth_init_input_buffer() fails to back one of the RX
buffers with memory, we need to bail out and report the error.

Fixes: 4a71df50047f ("qeth: new qeth device driver")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/qeth_core_main.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2633,12 +2633,12 @@ static int qeth_init_input_buffer(struct
 		buf->rx_skb = netdev_alloc_skb(card->dev,
 					       QETH_RX_PULL_LEN + ETH_HLEN);
 		if (!buf->rx_skb)
-			return 1;
+			return -ENOMEM;
 	}
 
 	pool_entry = qeth_find_free_buffer_pool_entry(card);
 	if (!pool_entry)
-		return 1;
+		return -ENOBUFS;
 
 	/*
 	 * since the buffer is accessed only from the input_tasklet
@@ -2682,10 +2682,15 @@ int qeth_init_qdio_queues(struct qeth_ca
 	/* inbound queue */
 	qdio_reset_buffers(card->qdio.in_q->qdio_bufs, QDIO_MAX_BUFFERS_PER_Q);
 	memset(&card->rx, 0, sizeof(struct qeth_rx));
+
 	qeth_initialize_working_pool_list(card);
 	/*give only as many buffers to hardware as we have buffer pool entries*/
-	for (i = 0; i < card->qdio.in_buf_pool.buf_count - 1; ++i)
-		qeth_init_input_buffer(card, &card->qdio.in_q->bufs[i]);
+	for (i = 0; i < card->qdio.in_buf_pool.buf_count - 1; i++) {
+		rc = qeth_init_input_buffer(card, &card->qdio.in_q->bufs[i]);
+		if (rc)
+			return rc;
+	}
+
 	card->qdio.in_q->next_buf_to_init =
 		card->qdio.in_buf_pool.buf_count - 1;
 	rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 0, 0,


