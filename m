Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE34AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08DA2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864516;
	bh=JbTHv1bjqueWQjmlgoqvwMnFVoVmYp0qaCRSP/2mFAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JE+BrIOodZYIJAkLb2H3OHeyZORIp1Ok5C4Z0ZRAMzXK+Gvy5ygxBM2s0dsh2NIjd
	 20B91J2OV6amXgKP4wewhTvJj9urV0JmC9NAHraZiJ3XQR/xqk6CIrRZX7hFhYsh3H
	 xpde9XzyuWoBlsfbQ3QvJ6V7519ootEXbUEn5vz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390253AbgAXLPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:15:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731323AbgAXLPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:15:08 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A07820708;
        Fri, 24 Jan 2020 11:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864507;
        bh=JbTHv1bjqueWQjmlgoqvwMnFVoVmYp0qaCRSP/2mFAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0lT4/+efz2t8V3TXYShc/lOEsIPSyxRnPPYgT7zAnHfTJybOjpSNUIhfQnL45xUBa
         gwaeIZSHaZtSX2n7CvnXwHonvSQcwYYG3q8ITdvCHnAo9JS9UkE5rJchVtkxsYDGLI
         6brnuRJ8HZVFHDeX+l8YfPkYyk+9okxiAiOpom8g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 271/639] tipc: tipc clang warning
Date:   Fri, 24 Jan 2020 10:27:21 +0100
Message-Id: <20200124093120.651508263@linuxfoundation.org>
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

From: Jon Maloy <jon.maloy@ericsson.com>

[ Upstream commit 737889efe9713a0f20a75fd0de952841d9275e6b ]

When checking the code with clang -Wsometimes-uninitialized we get the
following warning:

if (!tipc_link_is_establishing(l)) {
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/tipc/node.c:847:46: note: uninitialized use occurs here
      tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);

net/tipc/node.c:831:2: note: remove the 'if' if its condition is always
true
if (!tipc_link_is_establishing(l)) {
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/tipc/node.c:821:31: note: initialize the variable 'maddr' to silence
this warning
struct tipc_media_addr *maddr;

We fix this by initializing 'maddr' to NULL. For the matter of clarity,
we also test if 'xmitq' is non-empty before we use it and 'maddr'
further down in the  function. It will never happen that 'xmitq' is non-
empty at the same time as 'maddr' is NULL, so this is a sufficient test.

Fixes: 598411d70f85 ("tipc: make resetting of links non-atomic")
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/node.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 32556f480a606..e67ffd1949272 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -810,10 +810,10 @@ static void __tipc_node_link_down(struct tipc_node *n, int *bearer_id,
 static void tipc_node_link_down(struct tipc_node *n, int bearer_id, bool delete)
 {
 	struct tipc_link_entry *le = &n->links[bearer_id];
+	struct tipc_media_addr *maddr = NULL;
 	struct tipc_link *l = le->link;
-	struct tipc_media_addr *maddr;
-	struct sk_buff_head xmitq;
 	int old_bearer_id = bearer_id;
+	struct sk_buff_head xmitq;
 
 	if (!l)
 		return;
@@ -835,7 +835,8 @@ static void tipc_node_link_down(struct tipc_node *n, int bearer_id, bool delete)
 	tipc_node_write_unlock(n);
 	if (delete)
 		tipc_mon_remove_peer(n->net, n->addr, old_bearer_id);
-	tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
+	if (!skb_queue_empty(&xmitq))
+		tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
 	tipc_sk_rcv(n->net, &le->inputq);
 }
 
-- 
2.20.1



