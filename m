Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B30C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7F324125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8H8iHHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgBRTzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:55:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38420 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:55:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so11173437pfc.5;
        Tue, 18 Feb 2020 11:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F9XTBQEKA7h9nJlIjkbqq/1QmtqJ9mXQLAwjuVpHgNc=;
        b=D8H8iHHZgTDIxt5/mW20K3v/qCPJsTLtF9RuM5vGsDyzT/JKAnXlzuJZUm+7V52nFx
         EqroSSLOcBDCQplyVZ4XnQBxz6osyLUN5u/5jQMWkexl4cQ6w407kH6FFllKWumKrfvQ
         FLiyE9Ts+xMsyMkR0aXii5XNHJtQvWdsA7TyJ7EuH0t/XyMR4lmIeJvkxLFeSeVI7QWW
         96kxzE89cWliTgSgWmGjd3UbFQb2FleEOwIbXD3QNCeWDn9D4ldYX/1Nq6FQC+LSzit2
         v8fraGW79Ct5Jav8W6LpJtwu0wUGa2OQao59UQsppEuV5bKYKq80EX3ty50pNDQ4M5Vj
         n6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F9XTBQEKA7h9nJlIjkbqq/1QmtqJ9mXQLAwjuVpHgNc=;
        b=Cgq9viBaavuJh3iXdrnZUY1cWC5dp0tv3CS5CYSh6JJeR3oWOOVbun/OZ26MsZflNW
         Teok7NQaEmLgVOByXkRj8sqNeOgSLRRT+9w0nDaOkLA4pThEiyc8lza5bueZzw+tTgoM
         GC85SQCa+nahaTtLJHc+pxqOmVYxum21Ny2J8HwjGGXUs6cBj0CJ76fOB3q3BoQFM/Di
         6yYZ1GqPWsVszTfdvrUnIvhL75XuuocCkIWnXOiIWbmPC4ggWvE+qj1OhxAdF0jZN7JO
         6aEM5FtfkjX7OdDVMbFyD/p6RSxnPd9JkXqoqWAaXo94kPeue/6ojqw2yAwwtH4seJRP
         oyNw==
X-Gm-Message-State: APjAAAVNou+eI3guAghUqmEKsMYsZWncodZL0AZcRBXZcaEDjFI6JZmb
        NtBCryXFWrQPXdu0u3vCN2olSTg=
X-Google-Smtp-Source: APXvYqxLPpkqj+EubTezkb1SRiSi7vxCmmoRCDX6uzIIzZnMbRsgVsijYBTc5EcrCL5qmND+jVSfJQ==
X-Received: by 2002:a63:da49:: with SMTP id l9mr24419128pgj.125.1582055707764;
        Tue, 18 Feb 2020 11:55:07 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee3:ff08:f869:e1e5:121e:cdbf])
        by smtp.gmail.com with ESMTPSA id b15sm4994454pft.58.2020.02.18.11.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 11:55:07 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     pshelar@ovn.org, davem@davemloft.net
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH 1/4] meter.c: Use built-in RCU list checking
Date:   Wed, 19 Feb 2020 01:24:25 +0530
Message-Id: <20200218195425.1962-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

hlist_for_each_entry_rcu() has built-in RCU and lock checking.

Pass cond argument to list_for_each_entry_rcu() to silence
false lockdep warning when CONFIG_PROVE_RCU_LIST is enabled
by default.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 net/openvswitch/meter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/meter.c b/net/openvswitch/meter.c
index 3323b79ff548..5010d1ddd4bd 100644
--- a/net/openvswitch/meter.c
+++ b/net/openvswitch/meter.c
@@ -61,7 +61,8 @@ static struct dp_meter *lookup_meter(const struct datapath *dp,
 	struct hlist_head *head;
 
 	head = meter_hash_bucket(dp, meter_id);
-	hlist_for_each_entry_rcu(meter, head, dp_hash_node) {
+	hlist_for_each_entry_rcu(meter, head, dp_hash_node,
+				lockdep_ovsl_is_held()) {
 		if (meter->id == meter_id)
 			return meter;
 	}
-- 
2.17.1

