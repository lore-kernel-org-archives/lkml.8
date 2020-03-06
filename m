Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74EAC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD112084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UIreHpWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCFQRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:17:31 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:50733 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgCFQRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:17:31 -0500
Received: by mail-yw1-f74.google.com with SMTP id w197so3972404ywd.17
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 08:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qIlBFT3Kt2tcWYPKabCBDwELz8TNxUv98gWkjXaoCOk=;
        b=UIreHpWH6UQJs0j9K14EpJ0gqWwjNSF+b7PrYmigUOlohSwOL0kex8Xz7exblAYi2G
         xcaFZnkuEQJ7jJ2SLpI1mfvF84qTbBbOghDHJhukDjLA8mg1ejNE6vWoROyFLkpC5D0O
         GTx5M7VPnQgYxHocDwt6xCabK3Hv5uYXJVLv9hhqRKWlvvn3UTQm6JOqArgs4HSaYSRp
         O6MGIV1MaE5xDhMiTX6xUF+5wYwF9MJNoe7nGW/srPKExRduR1QBwdQnEIzUbRPSTuLK
         O2D46RZ2EVBZ2oEzSYna61xXhUVX2Ix2zzXCpuNB+xC/rennRT2M7F8Gn2hpFlJHL89Y
         u8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qIlBFT3Kt2tcWYPKabCBDwELz8TNxUv98gWkjXaoCOk=;
        b=t324EtD7u6s/k1/JPv4UjWtY4waMh9Z8Pu4RU6wPca9eTRDdgJyySVVgIP9WZasmG/
         iBPR2yGWJbxSAI9CfR8R6sAKDcnkr1O3kMjhlcuw9uNDCvxcUZWOHH88OCszM/RHifDL
         NmHmoVn2Netmsfcx5E0OS50Fwl2ZNCt5ypJUHJ23bUrLK++oBRIrKz3Cqj0qtuVhY/X8
         Fo6o5f8K5ddcEmfGvGF3H0vuHPYHMbo1h2ShJMns0e9RuJ6KD6WUuzPu8ankdKRzKcjF
         2kKk6PZY3esaZkoF43OeSCRHmM2jxw2GDjxWb1WTIGfyZ4JtHSQbwj7deNM9c1y+mbj/
         PiEQ==
X-Gm-Message-State: ANhLgQ2f669gZmn4RumwV6KYSF7Y5rZwUhziYTU2IIyI8JEVpwhwyLxU
        NRMMi5MlgVi0k9emZn+hGcb6wDuT0w==
X-Google-Smtp-Source: ADFU+vs6IS/KZfvFYayoFc3jA/lDIYq1RFJQe6OJepWFF6PKB2MkSFTognNkdS4kUdogR9vaeTPad1QfiA==
X-Received: by 2002:a25:3dc4:: with SMTP id k187mr4535109yba.82.1583511448778;
 Fri, 06 Mar 2020 08:17:28 -0800 (PST)
Date:   Fri,  6 Mar 2020 17:17:18 +0100
Message-Id: <20200306161718.50702-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] afs: Use kfree_rcu() instead of casting kfree() to rcu_callback_t
From:   Jann Horn <jannh@google.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

afs_put_addrlist() casts kfree() to rcu_callback_t. Apart from being wrong
in theory, this might also blow up when people start enforcing function
types via compiler instrumentation, and it means the rcu_head has to be
first in struct afs_addr_list.

Use kfree_rcu() instead, it's simpler and more correct.

Signed-off-by: Jann Horn <jannh@google.com>
---
compile-tested only

 fs/afs/addr_list.c | 2 +-
 fs/afs/internal.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index df415c05939e..de1ae0bead3b 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -19,7 +19,7 @@
 void afs_put_addrlist(struct afs_addr_list *alist)
 {
 	if (alist && refcount_dec_and_test(&alist->usage))
-		call_rcu(&alist->rcu, (rcu_callback_t)kfree);
+		kfree_rcu(alist, rcu);
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 1d81fc4c3058..35f951ac296f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -81,7 +81,7 @@ enum afs_call_state {
  * List of server addresses.
  */
 struct afs_addr_list {
-	struct rcu_head		rcu;		/* Must be first */
+	struct rcu_head		rcu;
 	refcount_t		usage;
 	u32			version;	/* Version */
 	unsigned char		max_addrs;

base-commit: aeb542a1b5c507ea117d21c3e3e012ba16f065ac
-- 
2.25.0.265.gbab2e86ba0-goog

