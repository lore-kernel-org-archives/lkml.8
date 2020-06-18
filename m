Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212EDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA73A214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447607;
	bh=lTf3psMkvzYLlXoW5mhe7q+SLED4DuOEqoOrFxakpfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wGzLm7fQNFMuSEqdz0OX56+hq5V8wwJXKWrzjb2LtvHWZdVzNDXzImollr3lBGYVZ
	 0oPKMw5So0CP5zs8RKdS8hV43yy2EBKkLFF6nac/Xd79Lv9zeGArpBVkUqFasksYhC
	 T8yki3O2G0/aQIiAE8KPW0oe+mAPXvvfXvmPBk8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbgFRCdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:33:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729372AbgFRBOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:14:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4A9E20EDD;
        Thu, 18 Jun 2020 01:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442889;
        bh=lTf3psMkvzYLlXoW5mhe7q+SLED4DuOEqoOrFxakpfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mi+X8g9KwtoUf5wEK9Kdb9mU95tYdk+THgFZBo59VDO+C1xpYB47GZF9DXsb7A8tF
         9SljUfqYp8Sb6jM1cD5/QR+AaBRQZjkmUfdoR6Oj4U99l0eGh3eJdKFjzpFfXQxtVv
         V6jPAvqYqAtJD6aS9U/+N69+2UzyFqgiDTWWYcUI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 312/388] rxrpc: Adjust /proc/net/rxrpc/calls to display call->debug_id not user_ID
Date:   Wed, 17 Jun 2020 21:06:49 -0400
Message-Id: <20200618010805.600873-312-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 32f71aa497cfb23d37149c2ef16ad71fce2e45e2 ]

The user ID value isn't actually much use - and leaks a kernel pointer or a
userspace value - so replace it with the call debug ID, which appears in trace
points.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/proc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 8b179e3c802a..543afd9bd664 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -68,7 +68,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 			 "Proto Local                                          "
 			 " Remote                                         "
 			 " SvID ConnID   CallID   End Use State    Abort   "
-			 " UserID           TxSeq    TW RxSeq    RW RxSerial RxTimo\n");
+			 " DebugId  TxSeq    TW RxSeq    RW RxSerial RxTimo\n");
 		return 0;
 	}
 
@@ -100,7 +100,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 	rx_hard_ack = READ_ONCE(call->rx_hard_ack);
 	seq_printf(seq,
 		   "UDP   %-47.47s %-47.47s %4x %08x %08x %s %3u"
-		   " %-8.8s %08x %lx %08x %02x %08x %02x %08x %06lx\n",
+		   " %-8.8s %08x %08x %08x %02x %08x %02x %08x %06lx\n",
 		   lbuff,
 		   rbuff,
 		   call->service_id,
@@ -110,7 +110,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
 		   atomic_read(&call->usage),
 		   rxrpc_call_states[call->state],
 		   call->abort_code,
-		   call->user_call_ID,
+		   call->debug_id,
 		   tx_hard_ack, READ_ONCE(call->tx_top) - tx_hard_ack,
 		   rx_hard_ack, READ_ONCE(call->rx_top) - rx_hard_ack,
 		   call->rx_serial,
-- 
2.25.1

