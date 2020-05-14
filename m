Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB37C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7B92070A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbR7AVcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgENOL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgENOL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:11:28 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ADEC061A0C;
        Thu, 14 May 2020 07:11:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m7so1213810plt.5;
        Thu, 14 May 2020 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9WpGSPoI+CaYLKju7AwRIRk8OIbNYCd/+/YJHSbNpOw=;
        b=EbR7AVcXsaozLj7tYQCz02xkMCbDe6iWsvhY14V/zIw8mgbtc3fsVigmdPvreyeQQL
         7OASbEDo3NVeQPLycHuj2fsOYAChdj28ujYw8974+Lb4kRV9Nmqh4U98lK5aVW+q/6xc
         35+WmG2qmDLJ++bljGsKsWvA4Pv84AVjX+1eHP7gC4s8Qmbb0pgNn7xTE02i8VHGSTY+
         ZST/3G+DEhEmaYeDYAtjZpIZ5csGr8e5LugkxpoJCZa47s6/PeVmdhSVct6zVD6YPkmX
         biUm7mdLoEWHfQXzN7gZOWwDVjsHlO6PBR2xdw6j8nojL4A43bzVdWyY/ZDTm7c1yuu6
         9/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9WpGSPoI+CaYLKju7AwRIRk8OIbNYCd/+/YJHSbNpOw=;
        b=cQ5Gs5mBofAi+qf0GewEKNwqA6q+eJkQrvW6l+ASbzr1BRgVxJVF072U6o7YFoa4Q1
         AGEoErLOW9LQpvyi+xa4p7LXAbW80P4TEVCtp4qia6mqsiUynU1dLy5X7OEwtmTppSpM
         GMaALdlHqpH0saalyY3zwZNrXa/3EDHal5CzM2aSdWBSvmTEcF2m+puUycuSIGFtedL1
         vj53plp9W0OqmY9E95fHGk78OPfUOcEs0UrLXkxtYvt4RqkUaD8Yxxf9LHVkD50nYnYH
         ilVJd51466mgcWgl2j7BOEmfbIluGEJb3dEjByiU9+RQL2n2+UD42KTlMjjwM+MtN08P
         9KXQ==
X-Gm-Message-State: AGi0PuYN3t67aZEJBILjdgnXgi8JofcuJjFFHuwz+gsJoAMb0McupYsc
        M3IstZiy87JvWDz4I9gvtZAVoOA=
X-Google-Smtp-Source: APiQypJba4rvPYcZMB5bjHxjCOHP4bQTDy8ndqeOJCD1/oVUci4rZDpgjFymsosidebilO9skNKYAA==
X-Received: by 2002:a17:90a:d504:: with SMTP id t4mr40533533pju.123.1589465487474;
        Thu, 14 May 2020 07:11:27 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:13bf:a95e:89fb:f860:f992:54ab])
        by smtp.gmail.com with ESMTPSA id z21sm613941pfr.77.2020.05.14.07.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 07:11:26 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     davem@davemloft.net, allison@lohutok.net, tglx@linutronix.de,
        ap420073@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        cai@lca.pw, joel@joelfernandes.org, frextrite@gmail.com,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH net] drivers: net: hamradio: Fix suspicious RCU usage warning in bpqether.c
Date:   Thu, 14 May 2020 19:41:15 +0530
Message-Id: <20200514141115.16074-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch fixes the following warning:
=============================
WARNING: suspicious RCU usage
5.7.0-rc5-next-20200514-syzkaller #0 Not tainted
-----------------------------
drivers/net/hamradio/bpqether.c:149 RCU-list traversed in non-reader section!!

Since rtnl lock is held, pass this cond in list_for_each_entry_rcu().

Reported-by: syzbot+bb82cafc737c002d11ca@syzkaller.appspotmail.com
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 drivers/net/hamradio/bpqether.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
index fbea6f232819..e2ad3c2e8df5 100644
--- a/drivers/net/hamradio/bpqether.c
+++ b/drivers/net/hamradio/bpqether.c
@@ -127,7 +127,8 @@ static inline struct net_device *bpq_get_ax25_dev(struct net_device *dev)
 {
 	struct bpqdev *bpq;
 
-	list_for_each_entry_rcu(bpq, &bpq_devices, bpq_list) {
+	list_for_each_entry_rcu(bpq, &bpq_devices, bpq_list,
+				lockdep_rtnl_is_held()) {
 		if (bpq->ethdev == dev)
 			return bpq->axdev;
 	}
-- 
2.17.1

