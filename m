Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C82C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B1620838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596097293;
	bh=h4SF7kQes2fUNdh+Gfq4IwRkqtMDHZN0FI7W4r8XtDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e0hOueGSWnlQA++T+x+G5sYcJKnwi+0b8LOekQF8wU33G3acX1s9nRtJ1ZZLEHufL
	 5rALpimgd8bPXf5SisZbB5M4ecG/3L9LH3wteHkoBmEWf8Kg6BWXQ5fZKbPhYLMCwA
	 ++HWt7QSmp8yQ/oN8ANINoxBsvkLuW4f4y8p2nX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgG3IVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbgG3IE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:04:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E062074B;
        Thu, 30 Jul 2020 08:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096297;
        bh=h4SF7kQes2fUNdh+Gfq4IwRkqtMDHZN0FI7W4r8XtDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guH++SBTru1JnOHlbN3UmVCb6rr/V9OZ7/Hk+uQLq5sFmUCAW/Aavxoh3roOWfd13
         fqxPR08wNEvP9yoTo2wn7QO1o2Z5Si6TnP0HlN9nehzKG8dsNQc+WnshIYDWoZILx7
         4WM6H48yzwrb5lu/U2NadaG9rRMTgkPYfSM8QrAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 16/20] udp: Copy has_conns in reuseport_grow().
Date:   Thu, 30 Jul 2020 10:04:06 +0200
Message-Id: <20200730074421.291324106@linuxfoundation.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.co.jp>

[ Upstream commit f2b2c55e512879a05456eaf5de4d1ed2f7757509 ]

If an unconnected socket in a UDP reuseport group connect()s, has_conns is
set to 1. Then, when a packet is received, udp[46]_lib_lookup2() scans all
sockets in udp_hslot looking for the connected socket with the highest
score.

However, when the number of sockets bound to the port exceeds max_socks,
reuseport_grow() resets has_conns to 0. It can cause udp[46]_lib_lookup2()
to return without scanning all sockets, resulting in that packets sent to
connected sockets may be distributed to unconnected sockets.

Therefore, reuseport_grow() should copy has_conns.

Fixes: acdcecc61285 ("udp: correct reuseport selection with connected sockets")
CC: Willem de Bruijn <willemb@google.com>
Reviewed-by: Benjamin Herrenschmidt <benh@amazon.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/sock_reuseport.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -101,6 +101,7 @@ static struct sock_reuseport *reuseport_
 	more_reuse->prog = reuse->prog;
 	more_reuse->reuseport_id = reuse->reuseport_id;
 	more_reuse->bind_inany = reuse->bind_inany;
+	more_reuse->has_conns = reuse->has_conns;
 
 	memcpy(more_reuse->socks, reuse->socks,
 	       reuse->num_socks * sizeof(struct sock *));


