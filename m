Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E90C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034C020708
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865948;
	bh=/nO3Ttx6srVgUV9YENUbndo2PQS8wsJTxorwB71OhYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GiEknqnqFecEW4dYVuuRPxwp+OTsEJdh5Li2brSyKsZe7cosOMj23Kz/D6PnUKOq2
	 abwPAPli8VROm3KyByILkEs0wMwQYQJtFJD2epZzIJbuGF3hTHhHUrCjRgLj5rsF7L
	 h8s9yz+2Rn4alJlVc793NvdxMEhrwDKX/lwaOxUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391331AbgAXL03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:26:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388623AbgAXL0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:26:25 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8960206D4;
        Fri, 24 Jan 2020 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865184;
        bh=/nO3Ttx6srVgUV9YENUbndo2PQS8wsJTxorwB71OhYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0tbC6gQpMYKpffFvGcGsyDbIzsHtCP8BQ1Q8oHIZoWRIYUTb8OAO9rShG14dF0yYb
         Q0NvnjPDpebzPvm47pwvHYbgOzOEffpy8+PBu/mE0WCWbBZiE2S8+ZywdtK6AxszRD
         L5PZStMj0FpHx7Isj6m7utMWNdxMEOug37Q8IAXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Maximets <i.maximets@samsung.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        William Tu <u9012063@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 476/639] xdp: fix possible cq entry leak
Date:   Fri, 24 Jan 2020 10:30:46 +0100
Message-Id: <20200124093147.759308228@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Maximets <i.maximets@samsung.com>

[ Upstream commit 675716400da6f15b9d3db04ef74ee74ca9a00af3 ]

Completion queue address reservation could not be undone.
In case of bad 'queue_id' or skb allocation failure, reserved entry
will be leaked reducing the total capacity of completion queue.

Fix that by moving reservation to the point where failure is not
possible. Additionally, 'queue_id' checking moved out from the loop
since there is no point to check it there.

Fixes: 35fcde7f8deb ("xsk: support for Tx")
Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
Acked-by: Björn Töpel <bjorn.topel@intel.com>
Tested-by: William Tu <u9012063@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 547fc4554b22c..c90854bc3048e 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -218,6 +218,9 @@ static int xsk_generic_xmit(struct sock *sk, struct msghdr *m,
 
 	mutex_lock(&xs->mutex);
 
+	if (xs->queue_id >= xs->dev->real_num_tx_queues)
+		goto out;
+
 	while (xskq_peek_desc(xs->tx, &desc)) {
 		char *buffer;
 		u64 addr;
@@ -228,12 +231,6 @@ static int xsk_generic_xmit(struct sock *sk, struct msghdr *m,
 			goto out;
 		}
 
-		if (xskq_reserve_addr(xs->umem->cq))
-			goto out;
-
-		if (xs->queue_id >= xs->dev->real_num_tx_queues)
-			goto out;
-
 		len = desc.len;
 		skb = sock_alloc_send_skb(sk, len, 1, &err);
 		if (unlikely(!skb)) {
@@ -245,7 +242,7 @@ static int xsk_generic_xmit(struct sock *sk, struct msghdr *m,
 		addr = desc.addr;
 		buffer = xdp_umem_get_data(xs->umem, addr);
 		err = skb_store_bits(skb, 0, buffer, len);
-		if (unlikely(err)) {
+		if (unlikely(err) || xskq_reserve_addr(xs->umem->cq)) {
 			kfree_skb(skb);
 			goto out;
 		}
-- 
2.20.1



