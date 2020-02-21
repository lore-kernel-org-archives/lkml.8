Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F40C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8896220679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdGu78qA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgBUPYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:24:04 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46352 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbgBUPYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:24:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so964846pll.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/D8p3umAJnu2Rmie5wIDoJw/XtMw5bg4kYLl7SwrZqU=;
        b=pdGu78qAVOal10Sy3Z0B22mZC2QD6KvLq0XrW0D4SXBwjRLWx2x65aL9uy4xbnVU0w
         2yaacYhHhoU0hioia4BuUt1RKp4bj/LgGQsjpefcv9ITHNwI/dIfBK/Is7cnePaxqrfv
         iTNFn6u+XCJTNHLNFOoxyKHDMfsnEUaa/p5DXRlcPvngtraX1n7+rYdosLE7SdTrPQar
         8nYpIoW18oDr/sCviGKKJczzHMJB/jkuyjjNloiOZMFZySqSN9HeNODLnBCFTtaA1IDT
         74OIE0ljfjFznWa1YAFI1nX1Vz0bTjlDCzTwOLqVc8p25Uj4EbWbz5FLuyE0plRi0b/D
         YeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/D8p3umAJnu2Rmie5wIDoJw/XtMw5bg4kYLl7SwrZqU=;
        b=dHTsndevOU4yC46Xrg7Cw4ECDHdNTyqd731tY6GpP0+U1DVwKsEx9jgq/ItkXDi5kO
         +GMtraAgK4Nfc+AYvIWytYqJIXfx52VbEAxPceMyCxvGXcifq+Ingf//rHQHdLBfabjs
         b2AnvppiO8BdVYC0jDPMUTgcHBYH5OXLmqKWFZYcwZJShrorBTDniR6S0+0rm9vLBj3r
         A6AUtepciyjDsXOeyh15E9yivMJocLuoLlmKTgSY1GxbdJXSBNxJujyvTashp5z3H15u
         X5N9YzpCWLL9WSu+3/zJIog4TSyNrqHihYPyy2JhMRVS/PrdcLCx8glxzG0ht4AedbQ9
         K5HQ==
X-Gm-Message-State: APjAAAVQpylLnKnsan0DkmirJMbNdiriBW51wy//w+U0wdAyUPPumW0K
        RDzGpdA9ME9RcDRow9/p4PVPU09aVBM=
X-Google-Smtp-Source: APXvYqzz2U0DluWCLZiEeBReOXghgMu20G6wGfpeQL0V8X5eQAZa1JPH7eSPTdL15MsjFBlcZ/gAJQ==
X-Received: by 2002:a17:90a:d80b:: with SMTP id a11mr3747256pjv.142.1582298641501;
        Fri, 21 Feb 2020 07:24:01 -0800 (PST)
Received: from localhost.localdomain ([103.87.57.170])
        by smtp.googlemail.com with ESMTPSA id w128sm1588394pgb.55.2020.02.21.07.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:24:01 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] tcp: ipv4: Pass lockdep expression to RCU lists
Date:   Fri, 21 Feb 2020 20:51:54 +0530
Message-Id: <20200221152152.16685-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

md5sig->head maybe traversed using hlist_for_each_entry_rcu
outside an RCU read-side critical section but under the protection
of socket lock.

Hence, add corresponding lockdep expression to silence false-positive
warnings, and harden RCU lists.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 net/ipv4/tcp_ipv4.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1c7326e04f9b..6519429f32cd 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1000,7 +1000,8 @@ struct tcp_md5sig_key *__tcp_md5_do_lookup(const struct sock *sk,
 	if (!md5sig)
 		return NULL;
 
-	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
+	hlist_for_each_entry_rcu(key, &md5sig->head, node,
+				 lockdep_sock_is_held(sk)) {
 		if (key->family != family)
 			continue;
 
@@ -1043,7 +1044,8 @@ static struct tcp_md5sig_key *tcp_md5_do_lookup_exact(const struct sock *sk,
 	if (family == AF_INET6)
 		size = sizeof(struct in6_addr);
 #endif
-	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
+	hlist_for_each_entry_rcu(key, &md5sig->head, node,
+				 lockdep_sock_is_held(sk)) {
 		if (key->family != family)
 			continue;
 		if (!memcmp(&key->addr, addr, size) &&
-- 
2.24.1

