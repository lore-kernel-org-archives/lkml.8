Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D20C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C8A206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467685;
	bh=7GUbe3H6bGsgLR7A+WgWytyJG14XwkQ1TsxdR+n07kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cn5w4QHZVXyRtlVoGPgauvYoM+pTgPPTY4fDILbDSKy2s42Pzs6X3Hrlr7bN1EKqu
	 FYnj6t2KWqVhJAMdW79iqXtkjEQ0GHPbMYRapbZO0UnfnmZq9atyTdW2uPsR5x8IAZ
	 mRXfryvI4U/IBB3YwUTJ5lFoXFH6geWK/+/KTzRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404390AbgF2Vym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgF2Sfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0094C246D0;
        Mon, 29 Jun 2020 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444023;
        bh=7GUbe3H6bGsgLR7A+WgWytyJG14XwkQ1TsxdR+n07kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZWT9pIsc+kSKgJB5WNlp+Fw0diRhYu1UlhNe0HRIIF0rtTWNt1ivdDesw7DRIejVB
         tXvvzOwTI1QO0bEhSyRyFQWBwOgprjlRnwJa0DH0clatIWwCDvnsg5AhXIXp37QhHC
         9RclHrl1PV8Fh8xvzez05rX+kba658vxYK2fgKWc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 130/265] rxrpc: Fix handling of rwind from an ACK packet
Date:   Mon, 29 Jun 2020 11:16:03 -0400
Message-Id: <20200629151818.2493727-131-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit a2ad7c21ad8cf1ce4ad65e13df1c2a1c29b38ac5 ]

The handling of the receive window size (rwind) from a received ACK packet
is not correct.  The rxrpc_input_ackinfo() function currently checks the
current Tx window size against the rwind from the ACK to see if it has
changed, but then limits the rwind size before storing it in the tx_winsize
member and, if it increased, wake up the transmitting process.  This means
that if rwind > RXRPC_RXTX_BUFF_SIZE - 1, this path will always be
followed.

Fix this by limiting rwind before we compare it to tx_winsize.

The effect of this can be seen by enabling the rxrpc_rx_rwind_change
tracepoint.

Fixes: 702f2ac87a9a ("rxrpc: Wake up the transmitter if Rx window size increases on the peer")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/input.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 3be4177baf707..22dec6049e1bb 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -723,13 +723,12 @@ static void rxrpc_input_ackinfo(struct rxrpc_call *call, struct sk_buff *skb,
 	       ntohl(ackinfo->rxMTU), ntohl(ackinfo->maxMTU),
 	       rwind, ntohl(ackinfo->jumbo_max));
 
+	if (rwind > RXRPC_RXTX_BUFF_SIZE - 1)
+		rwind = RXRPC_RXTX_BUFF_SIZE - 1;
 	if (call->tx_winsize != rwind) {
-		if (rwind > RXRPC_RXTX_BUFF_SIZE - 1)
-			rwind = RXRPC_RXTX_BUFF_SIZE - 1;
 		if (rwind > call->tx_winsize)
 			wake = true;
-		trace_rxrpc_rx_rwind_change(call, sp->hdr.serial,
-					    ntohl(ackinfo->rwind), wake);
+		trace_rxrpc_rx_rwind_change(call, sp->hdr.serial, rwind, wake);
 		call->tx_winsize = rwind;
 	}
 
-- 
2.25.1

