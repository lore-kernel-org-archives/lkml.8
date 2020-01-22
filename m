Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F142AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73ED24692
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699366;
	bh=WIPgcYVel5Lu2LNj4yXGRvKdS6d4CZSmTNWXIeratHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GpbP4jurxPVOm91cz7+zBFb3la04KATu4csh2cEkgQQcIuC/ev+ckRZ5SZ1moZrAv
	 Bfsa9y2qoBTwTju46zkQ9/gBdGh+BamdHXhQR2nH5+Xv+e3PWm9XfvM2gqh5Y9FyS7
	 F/A/8Uila3/wBaZ3vyRrw63SMHaD+gnX8cPyQ42Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgAVNWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:22:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729425AbgAVNWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:22:44 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 943092468C;
        Wed, 22 Jan 2020 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699364;
        bh=WIPgcYVel5Lu2LNj4yXGRvKdS6d4CZSmTNWXIeratHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B6udAx1c0Xe3M8ypDmxf+kJhzXvqLkpMhxvhuBQjcRj7RdQqLO63AnD+aJOYplWtT
         eo4MsIC4vdd+m/erxTFR5a/apK+ZHKs0eWgkHDU73hvJGFAXya8F0sNDGGUuBDoQZx
         4QtCe+tc2qOidY5wYmyZUzV48pdMiHdfoVZGKjTc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arika Chen <eaglesora@gmail.com>,
        Lingpeng Chen <forrest0579@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 5.4 122/222] bpf/sockmap: Read psock ingress_msg before sk_receive_queue
Date:   Wed, 22 Jan 2020 10:28:28 +0100
Message-Id: <20200122092842.486164236@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lingpeng Chen <forrest0579@gmail.com>

commit e7a5f1f1cd0008e5ad379270a8657e121eedb669 upstream.

Right now in tcp_bpf_recvmsg, sock read data first from sk_receive_queue
if not empty than psock->ingress_msg otherwise. If a FIN packet arrives
and there's also some data in psock->ingress_msg, the data in
psock->ingress_msg will be purged. It is always happen when request to a
HTTP1.0 server like python SimpleHTTPServer since the server send FIN
packet after data is sent out.

Fixes: 604326b41a6fb ("bpf, sockmap: convert to generic sk_msg interface")
Reported-by: Arika Chen <eaglesora@gmail.com>
Suggested-by: Arika Chen <eaglesora@gmail.com>
Signed-off-by: Lingpeng Chen <forrest0579@gmail.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Song Liu <songliubraving@fb.com>
Link: https://lore.kernel.org/bpf/20200109014833.18951-1-forrest0579@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/tcp_bpf.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -121,14 +121,14 @@ int tcp_bpf_recvmsg(struct sock *sk, str
 	struct sk_psock *psock;
 	int copied, ret;
 
-	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len, addr_len);
-	if (!skb_queue_empty(&sk->sk_receive_queue))
-		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
-
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
 		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return inet_recv_error(sk, msg, len, addr_len);
+	if (!skb_queue_empty(&sk->sk_receive_queue) &&
+	    sk_psock_queue_empty(psock))
+		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
 	lock_sock(sk);
 msg_bytes_ready:
 	copied = __tcp_bpf_recvmsg(sk, psock, msg, len, flags);
@@ -139,7 +139,7 @@ msg_bytes_ready:
 		timeo = sock_rcvtimeo(sk, nonblock);
 		data = tcp_bpf_wait_data(sk, psock, flags, timeo, &err);
 		if (data) {
-			if (skb_queue_empty(&sk->sk_receive_queue))
+			if (!sk_psock_queue_empty(psock))
 				goto msg_bytes_ready;
 			release_sock(sk);
 			sk_psock_put(sk, psock);


