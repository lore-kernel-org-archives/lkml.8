Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAFFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DE620675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645937;
	bh=Nbdn0VnjUKHM3PD1djuyTMlXEK3OXqVI5YgI5qyri6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R4d3Mbkqy4fS0GCAR0j8OOwjWEx9CSYYtQH0Ur8AR08yR9s4v89lOYP1Ft64CHHlx
	 QQ45pMmFpoFzcSBxf0TRDYzyCdnoOU1EUiQVy3W37zbeoN0Loi7a0NcfIfSv4mmt++
	 HGO/GWLgoZsImrHD3C+zuiFQFllUSNtOunWej4FI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbgCaJMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731743AbgCaJMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:12:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EEAA20675;
        Tue, 31 Mar 2020 09:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645932;
        bh=Nbdn0VnjUKHM3PD1djuyTMlXEK3OXqVI5YgI5qyri6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YGyBbJGuFGYIbmjkcAK43gAThoDCKc9ze994JCljfIIaheSLrs0W9br9OAdAOiI5D
         y3iUwg554nAVOn50hzcJCwBsyP6kqpFTP6TCjNoG6hQuv4WMHMVJIPsia1kgBrFYLi
         FashgeSbptZYcEsEi28CgsdhysEcnxvmY43JzaR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 037/155] tcp: repair: fix TCP_QUEUE_SEQ implementation
Date:   Tue, 31 Mar 2020 10:57:57 +0200
Message-Id: <20200331085422.558902141@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 6cd6cbf593bfa3ae6fc3ed34ac21da4d35045425 ]

When application uses TCP_QUEUE_SEQ socket option to
change tp->rcv_next, we must also update tp->copied_seq.

Otherwise, stuff relying on tcp_inq() being precise can
eventually be confused.

For example, tcp_zerocopy_receive() might crash because
it does not expect tcp_recv_skb() to return NULL.

We could add tests in various places to fix the issue,
or simply make sure tcp_inq() wont return a random value,
and leave fast path as it is.

Note that this fixes ioctl(fd, SIOCINQ, &val) at the same
time.

Fixes: ee9952831cfd ("tcp: Initial repair mode")
Fixes: 05255b823a61 ("tcp: add TCP_ZEROCOPY_RECEIVE support for zerocopy receive")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2943,8 +2943,10 @@ static int do_tcp_setsockopt(struct sock
 			err = -EPERM;
 		else if (tp->repair_queue == TCP_SEND_QUEUE)
 			WRITE_ONCE(tp->write_seq, val);
-		else if (tp->repair_queue == TCP_RECV_QUEUE)
+		else if (tp->repair_queue == TCP_RECV_QUEUE) {
 			WRITE_ONCE(tp->rcv_nxt, val);
+			WRITE_ONCE(tp->copied_seq, val);
+		}
 		else
 			err = -EINVAL;
 		break;


