Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EF0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D54A2065D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135382;
	bh=G6FFFYTDNCTwUdbAjyx5dcVHoIVHA2U+0o5krRR/nes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v1OMIr8uJaRko/katVkMzLJyjHDk3mQWaHzL0saWFFiZ44FAbFcy+Q1QxsSKjA8ib
	 BfcW7pK3p6bE4N6EybB9+qS+cQgkHC5eJciGS7nREwgxZ2b6bWZVALCRvJUNNugVk7
	 j2BAWtk04CUfDZsHCAANGFUzjTsxuCVX6vkSMCeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbgGGPXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgGGPWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:22:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 031B72065D;
        Tue,  7 Jul 2020 15:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135372;
        bh=G6FFFYTDNCTwUdbAjyx5dcVHoIVHA2U+0o5krRR/nes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/J49EMu60KRVwev+LG/uQ6HhVazM3Uxk8n8rescgJ6Kk8LAiPLHUm75n0q1cAuM7
         7bLFPkOwtTK2dxrwp3jpDYdqzry3sDAnQ/aqp1sRLdt9AsyehWX2JV/wOqF4iL8QMg
         hQfWy4A10UdNTrQnnPSR9JRprpqqkOMDnWmul+OQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+8eac6d030e7807c21d32@syzkaller.appspotmail.com,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 015/112] tipc: Fix NULL pointer dereference in __tipc_sendstream()
Date:   Tue,  7 Jul 2020 17:16:20 +0200
Message-Id: <20200707145801.721076283@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145800.925304888@linuxfoundation.org>
References: <20200707145800.925304888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 4c21daae3dbc9f8536cc18e6e53627821fa2c90c ]

tipc_sendstream() may send zero length packet, then tipc_msg_append()
do not alloc skb, skb_peek_tail() will get NULL, msg_set_ack_required
will trigger NULL pointer dereference.

Reported-by: syzbot+8eac6d030e7807c21d32@syzkaller.appspotmail.com
Fixes: 0a3e060f340d ("tipc: add test for Nagle algorithm effectiveness")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/socket.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 62fc871a8d673..f02f2abf6e3c0 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1589,8 +1589,12 @@ static int __tipc_sendstream(struct socket *sock, struct msghdr *m, size_t dlen)
 				tsk->pkt_cnt += skb_queue_len(txq);
 			} else {
 				skb = skb_peek_tail(txq);
-				msg_set_ack_required(buf_msg(skb));
-				tsk->expect_ack = true;
+				if (skb) {
+					msg_set_ack_required(buf_msg(skb));
+					tsk->expect_ack = true;
+				} else {
+					tsk->expect_ack = false;
+				}
 				tsk->msg_acc = 0;
 				tsk->pkt_cnt = 0;
 			}
-- 
2.25.1



