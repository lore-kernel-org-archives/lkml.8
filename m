Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB68C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D567C20801
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586218005;
	bh=P4mihfxv14d3mYrlZSFYDB506Er2e2jwCb818HK4qwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vg3hAzWR+ThI4/dYJUFk6/IzIjVqH/fyr5fPjK8DN+/d8+WO9dxfV7qytNU70yCS+
	 6xXixPnowM7J/OJiOcTCqq62jwc7r3jMGna1F7kZW8PWpKFhi3Cn2xQ8zWvtxlYdl2
	 mPPrDfR94HV2odjpgRMoszn4ZHG6thUqI/D6/cqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgDGACL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgDGACH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:02:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8249F20842;
        Tue,  7 Apr 2020 00:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586217727;
        bh=P4mihfxv14d3mYrlZSFYDB506Er2e2jwCb818HK4qwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WrEP7ELDc/BeedJIbrZXPFFQ3AFffLMtgi/NqhyAJUvGjo0THR/q1kqqZ5aN2Q+bC
         f4Vd6W4zHIj+5u7Y6rMFyOkx6Dia4QQes4jS5wgYDvZZvO/n2vYzeEyRH8+3q6dymO
         s1G1KCJg1m1Jds6GNIc9swSA7wrhVBwTUh+C/On4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 12/32] rxrpc: Abstract out the calculation of whether there's Tx space
Date:   Mon,  6 Apr 2020 20:01:30 -0400
Message-Id: <20200407000151.16768-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407000151.16768-1-sashal@kernel.org>
References: <20200407000151.16768-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 158fe6665389964a1de212818b4a5c52b7f7aff4 ]

Abstract out the calculation of there being sufficient Tx buffer space.
This is reproduced several times in the rxrpc sendmsg code.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/sendmsg.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 813fd68881429..a13051d380973 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -17,6 +17,21 @@
 #include <net/af_rxrpc.h>
 #include "ar-internal.h"
 
+/*
+ * Return true if there's sufficient Tx queue space.
+ */
+static bool rxrpc_check_tx_space(struct rxrpc_call *call, rxrpc_seq_t *_tx_win)
+{
+	unsigned int win_size =
+		min_t(unsigned int, call->tx_winsize,
+		      call->cong_cwnd + call->cong_extra);
+	rxrpc_seq_t tx_win = READ_ONCE(call->tx_hard_ack);
+
+	if (_tx_win)
+		*_tx_win = tx_win;
+	return call->tx_top - tx_win < win_size;
+}
+
 /*
  * Wait for space to appear in the Tx queue or a signal to occur.
  */
@@ -26,9 +41,7 @@ static int rxrpc_wait_for_tx_window_intr(struct rxrpc_sock *rx,
 {
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (call->tx_top - call->tx_hard_ack <
-		    min_t(unsigned int, call->tx_winsize,
-			  call->cong_cwnd + call->cong_extra))
+		if (rxrpc_check_tx_space(call, NULL))
 			return 0;
 
 		if (call->state >= RXRPC_CALL_COMPLETE)
@@ -68,9 +81,7 @@ static int rxrpc_wait_for_tx_window_nonintr(struct rxrpc_sock *rx,
 		set_current_state(TASK_UNINTERRUPTIBLE);
 
 		tx_win = READ_ONCE(call->tx_hard_ack);
-		if (call->tx_top - tx_win <
-		    min_t(unsigned int, call->tx_winsize,
-			  call->cong_cwnd + call->cong_extra))
+		if (rxrpc_check_tx_space(call, &tx_win))
 			return 0;
 
 		if (call->state >= RXRPC_CALL_COMPLETE)
@@ -302,9 +313,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 			_debug("alloc");
 
-			if (call->tx_top - call->tx_hard_ack >=
-			    min_t(unsigned int, call->tx_winsize,
-				  call->cong_cwnd + call->cong_extra)) {
+			if (!rxrpc_check_tx_space(call, NULL)) {
 				ret = -EAGAIN;
 				if (msg->msg_flags & MSG_DONTWAIT)
 					goto maybe_error;
-- 
2.20.1

