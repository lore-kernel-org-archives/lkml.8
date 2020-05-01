Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F43EC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0512208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340445;
	bh=7ZQPgD1vN6rg/lz6fp4Tt3s+4GGNgfJfgi2+4DuHIU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x+baXNgk8a5j4k/5TQRcssnt1sJO0qyBty7PSnA2nSnfVVs6vzfBzTRGNk4L4o5H+
	 xR2xlQ7GVlcTBESPX0R78BWVbZg5mUDxyr8vzEqTX7byzZk4a4azXvJwAYfXqUHvU1
	 YTFiCROHluLUpur7rCF41fyZAgNR8N5PeKY6T5Qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbgEANkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:40:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731021AbgEANkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:40:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A045E2495F;
        Fri,  1 May 2020 13:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340440;
        bh=7ZQPgD1vN6rg/lz6fp4Tt3s+4GGNgfJfgi2+4DuHIU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2mWhovxOwIPKEgqfsKeV6qNtw7YZZzWN7zF8r3b2TyzfoeDS4sUSSNHoIxStGgu8+
         UIX8+HNDck7Ugubu8gPFvqF3ZqMP8YZcdgcChFuA6aZs+19HLR/YQwA422Vna+wgoR
         Ub5Q2/T7Pe6dW+Md/mnXSZ21ZfOkiaVVU6XMIOBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 79/83] net: use indirect call wrappers for skb_copy_datagram_iter()
Date:   Fri,  1 May 2020 15:23:58 +0200
Message-Id: <20200501131542.761532213@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131524.004332640@linuxfoundation.org>
References: <20200501131524.004332640@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

commit 29f3490ba9d2399d3d1b20c4aa74592d92bd4e11 upstream.

TCP recvmsg() calls skb_copy_datagram_iter(), which
calls an indirect function (cb pointing to simple_copy_to_iter())
for every MSS (fragment) present in the skb.

CONFIG_RETPOLINE=y forces a very expensive operation
that we can avoid thanks to indirect call wrappers.

This patch gives a 13% increase of performance on
a single flow, if the bottleneck is the thread reading
the TCP socket.

Fixes: 950fcaecd5cc ("datagram: consolidate datagram copy to iter helpers")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/datagram.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -51,6 +51,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/uio.h>
+#include <linux/indirect_call_wrapper.h>
 
 #include <net/protocol.h>
 #include <linux/skbuff.h>
@@ -407,6 +408,11 @@ int skb_kill_datagram(struct sock *sk, s
 }
 EXPORT_SYMBOL(skb_kill_datagram);
 
+INDIRECT_CALLABLE_DECLARE(static size_t simple_copy_to_iter(const void *addr,
+						size_t bytes,
+						void *data __always_unused,
+						struct iov_iter *i));
+
 static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 			       struct iov_iter *to, int len, bool fault_short,
 			       size_t (*cb)(const void *, size_t, void *,
@@ -420,7 +426,8 @@ static int __skb_datagram_iter(const str
 	if (copy > 0) {
 		if (copy > len)
 			copy = len;
-		n = cb(skb->data + offset, copy, data, to);
+		n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
+				    skb->data + offset, copy, data, to);
 		offset += n;
 		if (n != copy)
 			goto short_copy;
@@ -442,8 +449,9 @@ static int __skb_datagram_iter(const str
 
 			if (copy > len)
 				copy = len;
-			n = cb(vaddr + skb_frag_off(frag) + offset - start,
-			       copy, data, to);
+			n = INDIRECT_CALL_1(cb, simple_copy_to_iter,
+					vaddr + skb_frag_off(frag) + offset - start,
+					copy, data, to);
 			kunmap(page);
 			offset += n;
 			if (n != copy)


