Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B51C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6332070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096314;
	bh=CvreL867oDybKJwEPyjWq70BJqhep70v0ZFbCNbvhdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gb0NDKu9RJ4iep0V866S7INf7+Nw7iSqrj+WagBqWp+4V912cIsQjF690oYekf4+Z
	 fxk53qxAOYBLyUTIgDdH0G7bX9FRYJxbqrEjH3CxCC2p9qMT6NPv8utFIS4JupjNrw
	 vCw+E0lylCTRdlGiaZFKXfXYcqSLPGpPTIWYzyPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgG3IFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729086AbgG3IFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:05:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7082D20809;
        Thu, 30 Jul 2020 08:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096303;
        bh=CvreL867oDybKJwEPyjWq70BJqhep70v0ZFbCNbvhdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C9+kjOge9nx9MzBqQbwlqvwlpSQr4XO8yL4xAqbUIRMqR+jb1oMBLCUFzBuatcMQP
         BzXQM3dMtmZ6VbV3/TOECdD+P9+mzxr8Hq5bp7kTUnYMz9ufDRsNB9zVOjz3BH+QSd
         7tQhi/Jmj8X1hgWoKGoM882PO9A1SM+oPxscylPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
        Tung Nguyen <tung.q.nguyen@dektech.com.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 18/20] tipc: allow to build NACK message in link timeout function
Date:   Thu, 30 Jul 2020 10:04:08 +0200
Message-Id: <20200730074421.391265865@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074420.533211699@linuxfoundation.org>
References: <20200730074420.533211699@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tung Nguyen <tung.q.nguyen@dektech.com.au>

[ Upstream commit 6ef9dcb78046b346b5508ca1659848b136a343c2 ]

Commit 02288248b051 ("tipc: eliminate gap indicator from ACK messages")
eliminated sending of the 'gap' indicator in regular ACK messages and
only allowed to build NACK message with enabled probe/probe_reply.
However, necessary correction for building NACK message was missed
in tipc_link_timeout() function. This leads to significant delay and
link reset (due to retransmission failure) in lossy environment.

This commit fixes it by setting the 'probe' flag to 'true' when
the receive deferred queue is not empty. As a result, NACK message
will be built to send back to another peer.

Fixes: 02288248b051 ("tipc: eliminate gap indicator from ACK messages")
Acked-by: Jon Maloy <jmaloy@redhat.com>
Signed-off-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/link.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -813,11 +813,11 @@ int tipc_link_timeout(struct tipc_link *
 		state |= l->bc_rcvlink->rcv_unacked;
 		state |= l->rcv_unacked;
 		state |= !skb_queue_empty(&l->transmq);
-		state |= !skb_queue_empty(&l->deferdq);
 		probe = mstate->probing;
 		probe |= l->silent_intv_cnt;
 		if (probe || mstate->monitoring)
 			l->silent_intv_cnt++;
+		probe |= !skb_queue_empty(&l->deferdq);
 		if (l->snd_nxt == l->checkpoint) {
 			tipc_link_update_cwin(l, 0, 0);
 			probe = true;


