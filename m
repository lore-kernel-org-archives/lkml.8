Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62C8C35670
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 01:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6D3206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 01:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ymt8dFnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBVBFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 20:05:15 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:33116 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgBVBFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 20:05:15 -0500
Received: by mail-pf1-f202.google.com with SMTP id c72so2315406pfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 17:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/3yl8VhgDmjkXmLfWG6CmIalz2F0UKze8er/2PUvhvg=;
        b=Ymt8dFnWLKbA5tN9IDfmujvOxbWEG48HlhlzvroTZMjYPzSWjt8utQxlTL3bXJPDYx
         3+TiA/F/b9pYowmG3T3VbN/DGLEOC2bKTeD5ayJ2A5UsPgaDnjvvNH9PposF/IfzuLNU
         qPiH1MUNmwrRUgprTKTn+LoFP4wLI9l538CvuVVlgYb0B5bgOpORGGZ5hL6/+iBY5dTl
         GGDZy85UVPb6XXZEBAg8tDB2ikz64+InMXYMGnjlQIl+q5P81K6yA3IIrP0cxI7g2DiY
         45WmsE4Hy/XwAldUMG09+sOyAdKtSqw1bGbN4rfRiDpOgO3mSN3xbiRp9ddpm4e2Mq6M
         7rZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/3yl8VhgDmjkXmLfWG6CmIalz2F0UKze8er/2PUvhvg=;
        b=EJ/2CYbMSs40y9ckHQktKavMjb1Qp1WztvR2ZdNsYyJKn00uoGFxqdbCih9ZWYJCl0
         5cZugKf6i6z05EzffhXtBWuV9eqKPwk95T1kyzFlZF4rjY25V8OPDQ8kwdLCk3efKmwH
         70Zb/8HXh+m9EliA5tm5+kU2o5TZlJTNfNKRz3XFDgzyphEtl6aIHhoHa1T0NvxL4CAf
         CUdYU1Ib86ogpwl3xxxFk2xfZIKxxUjCW+ywTtGKD5a680azaPTZzBbRp0n3eOQ2A7YX
         1K3+95f+ZsFsROVXKmgM9hJkbRNnr+MBJMRNze9BeQcx3nicQU0HPtiO5y2NlhOcyF55
         6/6Q==
X-Gm-Message-State: APjAAAV8FsyUcqy0BuHC7kJEay/vxhcRhDTlqA3xqLB/O23Mfq7I7Ed1
        uRRlQkcqbQb/d8/dmTUZep+3v1E17359Tg==
X-Google-Smtp-Source: APXvYqySyYWuzpx0yLr88ZPOnTJL5Aj9ggpD223mgI5KwnpI3NXOrlQ8OJZIxV17ZZyymsTdktXl89KbgD69Wg==
X-Received: by 2002:a63:d710:: with SMTP id d16mr40563177pgg.393.1582333512913;
 Fri, 21 Feb 2020 17:05:12 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:04:56 -0800
Message-Id: <20200222010456.40635-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] net: memcg: late association of sock to memcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Eric Dumazet <edumazet@google.com>, Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        netdev@vger.kernel.org,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a TCP socket is allocated in IRQ context or cloned from unassociated
(i.e. not associated to a memcg) in IRQ context then it will remain
unassociated for its whole life. Almost half of the TCPs created on the
system are created in IRQ context, so, memory used by suck sockets will
not be accounted by the memcg.

This issue is more widespread in cgroup v1 where network memory
accounting is opt-in but it can happen in cgroup v2 if the source socket
for the cloning was created in root memcg.

To fix the issue, just do the late association of the unassociated
sockets at accept() time in the process context and then force charge
the memory buffer already reserved by the socket.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 net/ipv4/inet_connection_sock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index a4db79b1b643..df9c8ef024a2 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -482,6 +482,13 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
 		}
 		spin_unlock_bh(&queue->fastopenq.lock);
 	}
+
+	if (mem_cgroup_sockets_enabled && !newsk->sk_memcg) {
+		mem_cgroup_sk_alloc(newsk);
+		if (newsk->sk_memcg)
+			mem_cgroup_charge_skmem(newsk->sk_memcg,
+					sk_mem_pages(newsk->sk_forward_alloc));
+	}
 out:
 	release_sock(sk);
 	if (req)
-- 
2.25.0.265.gbab2e86ba0-goog

