Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2173DC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E778A20732
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DiLLZ921"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgCEUzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:55:37 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:50755 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgCEUzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:55:36 -0500
Received: by mail-pl1-f201.google.com with SMTP id g5so77765plq.17
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 12:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mljG1c45tyBHCNvH//AiEZZTlDTTk3P0kV7UDMwCvTs=;
        b=DiLLZ921cvStv9VpgT9chw1u+67yb+Jf1wZHKgKeRrtR6Vd+VVjzBFoE3075eabKkB
         vL9Q1THdoudDtlzUB2SlXnPecVbbuAg124mgQ8cq9H95q1YMiqQXbrNKd7dT2fAnUn3n
         dPRVeotMzxE6Byy9sl8GMe1jbOn5REl2Dx/4Jw3dbu3R5Z0VldYTbblzUPZ/nq/hvU5m
         UW41Z7wBfxhTTlXQkI1TtX3zZrz8D1ZvUtgjIr8/MH5OdVN/TMfeA6uQ38HLwN+syvBs
         NSC1Z9sBv8MySgOXqKr3+c5YO5Dh9yruYybkpx5dtHt7G3kaEndhLvrvjxgKLh+C3qkQ
         DSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mljG1c45tyBHCNvH//AiEZZTlDTTk3P0kV7UDMwCvTs=;
        b=nFCi0irMW3RxLmnioahoCixHRfwl4f/RU9/7qSNtybwq1LqoiyBFLDjZMAfpvUBcJC
         g14ThA4vuiEgx1/CooT5tpmAcBI2bUNaoL5IgCw+YiznITaFp2Y3+Mw70ozLsok5khYP
         jZ9Xfu9uV7AHkgRVnxhOUJNUUgyUYRwUnEO/aZHk4rX+FJLckw+sutjlG0N73kAX2miY
         NjYuAnOsXhlDBTYEho1UPGcRUJyZDoQAoQL17mlzZiIgTYRfzAkBIAOhApNqLFON2+g1
         pww8ZctAXmEPy1zdvYHir+TJKZdqffct3CySP2EeT6LlzJRMvPHOLynFBF98T6EA+EwG
         6grw==
X-Gm-Message-State: ANhLgQ0DCSfs0IsWCdDXIqc3vuWhy4O48y5RRdLeKh/y749a8lBvKLVw
        IhtKJvkXCbEWy9QhY01A5sSrpm2r1IE0FA==
X-Google-Smtp-Source: ADFU+vtVGz7DVOErF5e2OURgUg2ecxIgD7Eb6KdrmeesDbmcr0yLA+SUXXXVg19kGdyFzvBxzDpSLTmT/w31sA==
X-Received: by 2002:a63:74b:: with SMTP id 72mr19359pgh.320.1583441733885;
 Thu, 05 Mar 2020 12:55:33 -0800 (PST)
Date:   Thu,  5 Mar 2020 12:55:25 -0800
Message-Id: <20200305205525.245058-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3] net: memcg: late association of sock to memcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Eric Dumazet <edumazet@google.com>, Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a TCP socket is allocated in IRQ context or cloned from unassociated
(i.e. not associated to a memcg) in IRQ context then it will remain
unassociated for its whole life. Almost half of the TCPs created on the
system are created in IRQ context, so, memory used by such sockets will
not be accounted by the memcg.

This issue is more widespread in cgroup v1 where network memory
accounting is opt-in but it can happen in cgroup v2 if the source socket
for the cloning was created in root memcg.

To fix the issue, just do the late association of the unassociated
sockets at accept() time in the process context and then force charge
the memory buffer already reserved by the socket.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v2:
- Additional check for charging.
- Release the sock after charging.

Changes since v1:
- added sk->sk_rmem_alloc to initial charging.
- added synchronization to get memory usage and set sk_memcg race-free.

 net/ipv4/inet_connection_sock.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index a4db79b1b643..5face55cf818 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -482,6 +482,26 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
 		}
 		spin_unlock_bh(&queue->fastopenq.lock);
 	}
+
+	if (mem_cgroup_sockets_enabled && !newsk->sk_memcg) {
+		int amt;
+
+		/* atomically get the memory usage, set and charge the
+		 * sk->sk_memcg.
+		 */
+		lock_sock(newsk);
+
+		/* The sk has not been accepted yet, no need to look at
+		 * sk->sk_wmem_queued.
+		 */
+		amt = sk_mem_pages(newsk->sk_forward_alloc +
+				   atomic_read(&sk->sk_rmem_alloc));
+		mem_cgroup_sk_alloc(newsk);
+		if (newsk->sk_memcg && amt)
+			mem_cgroup_charge_skmem(newsk->sk_memcg, amt);
+
+		release_sock(newsk);
+	}
 out:
 	release_sock(sk);
 	if (req)
-- 
2.25.0.265.gbab2e86ba0-goog

