Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE9CC433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C213207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgETOYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:24:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33190 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbgETOW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:22:28 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jbPby-00036r-6U; Wed, 20 May 2020 15:22:22 +0100
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jbPbx-007DW3-I0; Wed, 20 May 2020 15:22:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Eric Dumazet" <edumazet@google.com>,
        "SeongJae Park" <sjpark@amazon.de>
Date:   Wed, 20 May 2020 15:14:57 +0100
Message-ID: <lsq.1589984009.234028458@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 89/99] tcp: clear tp->total_retrans in tcp_disconnect()
In-Reply-To: <lsq.1589984008.673931885@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.84-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit c13c48c00a6bc1febc73902505bdec0967bd7095 upstream.

total_retrans needs to be cleared in tcp_disconnect().

tcp_disconnect() is rarely used, but it is worth fixing it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/tcp.c | 1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2363,6 +2363,7 @@ int tcp_disconnect(struct sock *sk, int
 	tp->window_clamp = 0;
 	tcp_set_ca_state(sk, TCP_CA_Open);
 	tcp_clear_retrans(tp);
+	tp->total_retrans = 0;
 	inet_csk_delack_init(sk);
 	/* Initialize rcv_mss to TCP_MIN_MSS to avoid division by 0
 	 * issue in __tcp_select_window()

