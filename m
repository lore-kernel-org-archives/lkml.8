Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD02FC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6789D2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Lz6jH6Md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgCYOcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:32:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37449 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgCYOcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:32:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id x3so2723998qki.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TF9iJBiO0AuQd8nd0BlphkST/Pt9KVdxrtvPH4as2h8=;
        b=Lz6jH6Md1qAZCC/5tbCU1I+Dtky/ug5dvJDwjhk6TclPOXVHde1FZwa31s1yiEI6ci
         8jM9Q/9ov0fXa9sA1erX232HFwUXgZgaPhoVuf861MsT44CC0f6DVaElHgtbHEv3EYUJ
         lKlG2H7wcqWdiRwEXKi9+aBBNHmsgfWaJ5E+p4WrBEH3R+4s/FgqnAcIAfdYpH/DqfAf
         7tyj+SlrsRzTJ6mlKtfXpfpbgDZ0Fm/+f3gruIF0EVRqrIfJ9hD7sKEqXFbPg7sHZvKN
         vuhDgTET/1fZX02IlXcA7jSy7EZeNGb4UVctN+3wGxXbNcd7bSZVQI2XhUdiGwg9ROND
         ghRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TF9iJBiO0AuQd8nd0BlphkST/Pt9KVdxrtvPH4as2h8=;
        b=Q9fO+micY7bJ4FxzV2+dBp2DEKC4GM9S4YB9A5FWVFRRZRJoYzgpPFZXou6S3rXgDr
         VCeYzY+wr0JeQ0kWzId1KV/TY3hzXdJfQji/2aokOvTuIv0deOJ8tTtnyxguEkC+Znlt
         nJOLrZh5FjugPhiBAf+Y4FKXNYoogTG+hlMk8dh/R1RAZ5riTmnENQ8uKeL/fFCVvC2F
         nCTGf09E0DHY9XTn6wDbi6u2CidycoTNYCcTh721zxy7rNleRxB1mKgHQr2f1tf3SGWF
         Rt94StLYR9hH6KEbws2Andiua1vrLio7vZ2Fy/qLWfG1x9uW5N7jFk93hgmnhz2Va279
         aiGA==
X-Gm-Message-State: ANhLgQ0hwWdQvjd+ZiqSdDfrTE1Y5ieFMw7RGPvou86wB0WDd157a1sj
        /VH4Ymz+/X+8IFNdiLXNtSBk+A==
X-Google-Smtp-Source: ADFU+vslIu4ym3oWBVgsGOjHnZWCwTiIQHGRt1uueBxGQSZBviKE1ph/j83kf3q1XH4TpTCuWS0u/w==
X-Received: by 2002:a37:a597:: with SMTP id o145mr3175372qke.106.1585146731697;
        Wed, 25 Mar 2020 07:32:11 -0700 (PDT)
Received: from ovpn-66-69.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v76sm342432qka.32.2020.03.25.07.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 07:32:11 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de
Cc:     davem@davemloft.net, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] netfilter/nf_tables: silence a RCU-list warning
Date:   Wed, 25 Mar 2020 10:31:42 -0400
Message-Id: <20200325143142.6955-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is safe to traverse &net->nft.tables with &net->nft.commit_mutex
held using list_for_each_entry_rcu(). Silence the PROVE_RCU_LIST false
positive,

WARNING: suspicious RCU usage
net/netfilter/nf_tables_api.c:523 RCU-list traversed in non-reader section!!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by iptables/1384:
 #0: ffffffff9745c4a8 (&net->nft.commit_mutex){+.+.}, at: nf_tables_valid_genid+0x25/0x60 [nf_tables]

Call Trace:
 dump_stack+0xa1/0xea
 lockdep_rcu_suspicious+0x103/0x10d
 nft_table_lookup.part.0+0x116/0x120 [nf_tables]
 nf_tables_newtable+0x12c/0x7d0 [nf_tables]
 nfnetlink_rcv_batch+0x559/0x1190 [nfnetlink]
 nfnetlink_rcv+0x1da/0x210 [nfnetlink]
 netlink_unicast+0x306/0x460
 netlink_sendmsg+0x44b/0x770
 ____sys_sendmsg+0x46b/0x4a0
 ___sys_sendmsg+0x138/0x1a0
 __sys_sendmsg+0xb6/0x130
 __x64_sys_sendmsg+0x48/0x50
 do_syscall_64+0x69/0xf4
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Signed-off-by: Qian Cai <cai@lca.pw>
---
 net/netfilter/nf_tables_api.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 38c680f28f15..e398d1491057 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -520,7 +520,8 @@ static struct nft_table *nft_table_lookup(const struct net *net,
 	if (nla == NULL)
 		return ERR_PTR(-EINVAL);
 
-	list_for_each_entry_rcu(table, &net->nft.tables, list) {
+	list_for_each_entry_rcu(table, &net->nft.tables, list,
+				lockdep_is_held(&net->nft.commit_mutex)) {
 		if (!nla_strcmp(nla, table->name) &&
 		    table->family == family &&
 		    nft_active_genmask(table, genmask))
-- 
2.21.0 (Apple Git-122.2)

