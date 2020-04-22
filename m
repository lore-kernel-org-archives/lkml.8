Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84218C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5626B2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549939;
	bh=PbbjQLGK7kVdc1c1pndJ6tVmcwajsjq5vId/JCF4hUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vU8huWMMts7dd5I11fg8XJxUXJh1/mY70FdSjdZPhSst65FHOhTUBYctOVhE1/oYU
	 4E+S6ASMx/9uuUPDmVGmrU3oLsQurgkVPKk9oN0zl4wKF4LIECsXV1D8MBwK5FY6T9
	 FUm4Nb20+n7RC9bevSYAu1EX/kozjjD6n5TFOO38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgDVKFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbgDVKFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:05:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C0B020781;
        Wed, 22 Apr 2020 10:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549935;
        bh=PbbjQLGK7kVdc1c1pndJ6tVmcwajsjq5vId/JCF4hUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUXYIPPy8xrGu97h4IobsjIs3JWA4MuUttApUttEivc1JRJXV9BbOFaAXHzUpsMHj
         Cu1lWsyXptYZewULQ/eQHsr7rxjwv9yJsrcbqiE1gx5whPJAr6HkwugKRGAedie4qb
         Ywwbz4EeyaFie6woWUgQi+HTWj/9kzWdasG4i/eY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Wenhu <wenhu.wang@vivo.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 068/125] net: qrtr: send msgs from local of same id as broadcast
Date:   Wed, 22 Apr 2020 11:56:25 +0200
Message-Id: <20200422095044.267838759@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
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
@@ -621,20 +621,21 @@ static int qrtr_sendmsg(struct socket *s
 
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


