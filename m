Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEBAC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA96208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv5v78Gk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgBVQ6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 11:58:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37587 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgBVQ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 11:58:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id z12so2670493pgl.4;
        Sat, 22 Feb 2020 08:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z3KO4eN5jhFVoFYevJd1WekBeBDLgNl7tb0PRqx3KTw=;
        b=jv5v78GkeLtIpANUBMkMOUQSQsYzG31CXCzESaei3K/C5a0XeuvYwK0FXTxO/sA4ZV
         VFQoadLEu3xYGM+OE8KgOekct8BIyERsI9SlbeLFD2Yfbs0mehB/xSeSnUvuGvOVZ4Dz
         X1tjgXdQIQlzibmkqGYiAEFsm6qV5EnNWLaCdP4HTS+wErYlJ2acBfilGZFtzSEgFOG1
         BXLU1q/64Rw+2oR5XgAiqBq//GmLEnEa8WLJu0QXO/i+afTosVeb3kdKxWQ2awxIrEFp
         D/z2+nUi3N7vxloYtneEgEBNpqvK/fapbLymX74dhA5t7OJHL9Z831TnHc0Mdh7oSMte
         o1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z3KO4eN5jhFVoFYevJd1WekBeBDLgNl7tb0PRqx3KTw=;
        b=KcbtthREp2pc26pzQlUW5wUw36K4X+Z3lWvmw/To/5M8g75fA7dJI5daDZefAqsv3h
         qMIkmJRofhk9Fy06r8qhA5uVLIuag6hVtedKyl7IlY3/vfq8G0ojmEIwPDmx+6xKXbN3
         atr3AWaifPV6Af5qs6NUHogXgrkXL6RHY4isU/njmy78tAYQtvfKdRMmzoau4lh/MLPM
         DbLbCBO8KGOWX53E3Laj9gz0IQCXXtrDaFzLgOzi1Tv9d68d0WkePzCJpEBKHTnF3d0n
         lE31czdNujmk60Tg45c1F3hWiDwug3T1cfl/VJh79hI30PGnxOUqgpOYn/9PhfSubsEG
         7wGA==
X-Gm-Message-State: APjAAAXvRF03F0DPCK6TpzoM5yJZeYn/Xy/8px8Y7lpG1x6neSkoXNPX
        4P/rs2B1uKn4vP/fMet+Soo=
X-Google-Smtp-Source: APXvYqzU/oKjoAjO1ie8MPYCGZVdDNYNMPm7PBDPQCslrrf4LLM3ID6101gQUXy0TcG/QYh3wowZNQ==
X-Received: by 2002:a62:cfc4:: with SMTP id b187mr43233929pfg.155.1582390720405;
        Sat, 22 Feb 2020 08:58:40 -0800 (PST)
Received: from localhost.localdomain ([103.87.57.201])
        by smtp.googlemail.com with ESMTPSA id y9sm6615835pjj.17.2020.02.22.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 08:58:40 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, netdev@vger.kernel.org,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] ip6mr: Fix RCU list debugging warning
Date:   Sat, 22 Feb 2020 22:27:27 +0530
Message-Id: <20200222165726.9330-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ip6mr_for_each_table() macro uses list_for_each_entry_rcu()
for traversing outside an RCU read side critical section
but under the protection of rtnl_mutex. Hence add the
corresponding lockdep expression to silence the following
false-positive warnings:

[    4.319479] =============================
[    4.319480] WARNING: suspicious RCU usage
[    4.319482] 5.5.4-stable #17 Tainted: G            E
[    4.319483] -----------------------------
[    4.319485] net/ipv6/ip6mr.c:1243 RCU-list traversed in non-reader section!!

[    4.456831] =============================
[    4.456832] WARNING: suspicious RCU usage
[    4.456834] 5.5.4-stable #17 Tainted: G            E
[    4.456835] -----------------------------
[    4.456837] net/ipv6/ip6mr.c:1582 RCU-list traversed in non-reader section!!

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 net/ipv6/ip6mr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index bfa49ff70531..d6483926f449 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -97,7 +97,8 @@ static void ipmr_expire_process(struct timer_list *t);
 
 #ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
 #define ip6mr_for_each_table(mrt, net) \
-	list_for_each_entry_rcu(mrt, &net->ipv6.mr6_tables, list)
+	list_for_each_entry_rcu(mrt, &net->ipv6.mr6_tables, list, \
+				lockdep_rtnl_is_held())
 
 static struct mr_table *ip6mr_mr_table_iter(struct net *net,
 					    struct mr_table *mrt)
-- 
2.24.1

