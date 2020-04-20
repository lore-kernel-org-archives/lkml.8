Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A15DC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E6F206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386908;
	bh=EZ5yGlrfsdQVCydTecbgzb23GuZa16/DK90Uo8UY/bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kSadnIdmrDxOlFIH+EA7e5r9/7xcJxT+sH/JswmoGe6M0jql1yk26Dmtf6hCI7DvW
	 0/OUG8Ch4MVDPNEhcReMEp7/RadbXHWfD6CFyl+0WA45KwCgygs7SKFaBUzUtUXNvv
	 pvt/Diipr4FH0TYRNjsOtn5Cwsh0UY6vxMoRQwL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgDTMs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbgDTMsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:48:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C87206DD;
        Mon, 20 Apr 2020 12:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386904;
        bh=EZ5yGlrfsdQVCydTecbgzb23GuZa16/DK90Uo8UY/bI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/Q/d7DnbF242zZzYallml1b+3QNEG1SmSVdEqFoxVlbmBY3z1DRXjv3CDeR9+g7u
         RDmE3Ba7fZ1WXj6YTHmLYOfIsVdosxiDNZNvuHYa9QyWHKHA1jlVM1AgbLh5XxOsUa
         /dp4Ts94tGUQQ+TbI330gm2AQVWXolCIru+x063E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Wenhu <wenhu.wang@vivo.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 05/40] net: qrtr: send msgs from local of same id as broadcast
Date:   Mon, 20 Apr 2020 14:39:15 +0200
Message-Id: <20200420121451.945279187@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121444.178150063@linuxfoundation.org>
References: <20200420121444.178150063@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Wenhu <wenhu.wang@vivo.com>

[ Upstream commit 6dbf02acef69b0742c238574583b3068afbd227c ]

If the local node id(qrtr_local_nid) is not modified after its
initialization, it equals to the broadcast node id(QRTR_NODE_BCAST).
So the messages from local node should not be taken as broadcast
and keep the process going to send them out anyway.

The definitions are as follow:
static unsigned int qrtr_local_nid = NUMA_NO_NODE;

Fixes: fdf5fd397566 ("net: qrtr: Broadcast messages only from control port")
Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/qrtr/qrtr.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -769,20 +769,21 @@ static int qrtr_sendmsg(struct socket *s
 
 	node = NULL;
 	if (addr->sq_node == QRTR_NODE_BCAST) {
-		enqueue_fn = qrtr_bcast_enqueue;
-		if (addr->sq_port != QRTR_PORT_CTRL) {
+		if (addr->sq_port != QRTR_PORT_CTRL &&
+		    qrtr_local_nid != QRTR_NODE_BCAST) {
 			release_sock(sk);
 			return -ENOTCONN;
 		}
+		enqueue_fn = qrtr_bcast_enqueue;
 	} else if (addr->sq_node == ipc->us.sq_node) {
 		enqueue_fn = qrtr_local_enqueue;
 	} else {
-		enqueue_fn = qrtr_node_enqueue;
 		node = qrtr_node_lookup(addr->sq_node);
 		if (!node) {
 			release_sock(sk);
 			return -ECONNRESET;
 		}
+		enqueue_fn = qrtr_node_enqueue;
 	}
 
 	plen = (len + 3) & ~3;


