Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D8DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DC68208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597882076;
	bh=cl6pCi7Kvd90yBpkRdLa9gsjAZiENQRRie7QpCBE7YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lTY18QxLRk5NlanZ6XTdc5zEh6erM8xnH1A1S96HJ/2kAhrCNFkz5qhbGhgoQyesK
	 M7ZCnG0Roc0QIms9KLRYcRzJpeltJJ0i8q60IQF0u77FYryrBXWKX8s63FuWAhhbKW
	 KVoA8cTE6EOh2E2PNoK5YgrrrlxGDNVqxCdLYNAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgHTAHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbgHTADN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:03:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E2DC20FC3;
        Thu, 20 Aug 2020 00:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881793;
        bh=cl6pCi7Kvd90yBpkRdLa9gsjAZiENQRRie7QpCBE7YI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tu3zNMks04jR61XX7UzBKKwehlatSNNSqCNWc+yn/wi+U6kzHxLVU2+xyyVccoSYx
         UfyXv4YfZRmWzufStNSp+oO137mKUXBzdmFeeDxh4+staQx6pU7eKMxcPcWlEs5fe8
         YLuEbXTbj+fzSuJN8QYN9RKWHrNe8LWag2kt8aXo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/18] svcrdma: Fix another Receive buffer leak
Date:   Wed, 19 Aug 2020 20:02:51 -0400
Message-Id: <20200820000302.215560-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000302.215560-1-sashal@kernel.org>
References: <20200820000302.215560-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 64d26422516b2e347b32e6d9b1d40b3c19a62aae ]

During a connection tear down, the Receive queue is flushed before
the device resources are freed. Typically, all the Receives flush
with IB_WR_FLUSH_ERR.

However, any pending successful Receives flush with IB_WR_SUCCESS,
and the server automatically posts a fresh Receive to replace the
completing one. This happens even after the connection has closed
and the RQ is drained. Receives that are posted after the RQ is
drained appear never to complete, causing a Receive resource leak.
The leaked Receive buffer is left DMA-mapped.

To prevent these late-posted recv_ctxt's from leaking, block new
Receive posting after XPT_CLOSE is set.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 16c8174658fd1..252495ff9010d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -268,6 +268,8 @@ static int svc_rdma_post_recv(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_recv_ctxt *ctxt;
 
+	if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
+		return 0;
 	ctxt = svc_rdma_recv_ctxt_get(rdma);
 	if (!ctxt)
 		return -ENOMEM;
-- 
2.25.1

