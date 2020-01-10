Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857C6C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5762F2080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0P6lIkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgAJR3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:29:52 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35843 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgAJR3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:29:51 -0500
Received: by mail-pj1-f66.google.com with SMTP id n59so1278092pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=if4RAkhreXdypvivvkzUzoNLQmdHtvLSynu8xvJL9L0=;
        b=P0P6lIkO0vEXevJyCi0Ve6nTaWGmPr9DQ9iU9vm86zyegmAuPFirXAbtYuTbzz3vkX
         IwYPqghnfSK4u10G0ECYGMKyJNdS7dH7F0qOWU1LKQiE9fdExxHqQ76dxjgxGrkSGBWD
         b5/sRrmV9CfAIEL7nUH2bj2hPGDnrM9VcBEwjPOyYzL6h49AmjZeWsuVinNCId28pAio
         sOAq8PD1HwwIvlTtUJG8cdfc3LQmrxFQKqn1t2TVKKnbqRrS+I8Zy5+rld+yTe4ACTcA
         kNaaR7Ar2b7FVQ2UoIyG4ivhwcahOq5BR0mV4fY0Em64olkCNL6Wh3hEVEV/FlxbNYla
         gUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=if4RAkhreXdypvivvkzUzoNLQmdHtvLSynu8xvJL9L0=;
        b=gGtecnFyU/TJYgU0dWCUEfLupkK9bSJZ5ho4gUZBKgqhOx87tk05VlGuY1olJMzy0f
         wv2i3P8iqDxOKzelH2B15bUgzZVaVjlI8fXTl71ILYaF1kAUbUJTXVn4XAc2f3iuboxo
         Be7oX1gRQaomLmb98XZJqXKV+tMvME/rfELwFjbHFk2qIHsfRykh4TteiH+HmmLwgJIa
         cbNqIhq7gLLtDib7+iJSCOozYe0dlh/vvPv8Y/vj3LYnmDZvQv13isdyQNZjg4k0WnRm
         aHKGnCiLwb+rEKvjF24NHOBzU/IrdOklz0P7CGe/mjPKl8adGGGAUtlVzsOr5ZDOi8IS
         f6jw==
X-Gm-Message-State: APjAAAVMFnMosbHJWy+efhs02hFogwS5pRWqXuov0WebrGh3SVgkt5A3
        ns5ePMj0E+4Dsug45po6IqM=
X-Google-Smtp-Source: APXvYqyRCM49T218y2zPfZg/Q1kMxItt+bAymfNhW/HR5muuMaPgLbxwUDSNLZMQCHjcIKtBirsL/A==
X-Received: by 2002:a17:90a:ead3:: with SMTP id ev19mr6168728pjb.80.1578677390808;
        Fri, 10 Jan 2020 09:29:50 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.220])
        by smtp.googlemail.com with ESMTPSA id p28sm3513553pgb.93.2020.01.10.09.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 09:29:50 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH v2] drivers: nvme: target: core: Pass lockdep expression to RCU lists
Date:   Fri, 10 Jan 2020 22:53:46 +0530
Message-Id: <20200110172343.17796-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ctrl->subsys->namespaces and subsys->namespaces are traversed with
hlist_for_each_entry_rcu outside an RCU read-side critical section
but under the protection of subsys->lock.

Hence, add the corresponding lockdep expression to the list traversal
primitive to silence false-positive lockdep warnings, and
harden RCU lists.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Amol Grover <frextrite@gmail.com>
---
v2:
- Fix sparse error
  CHECK: Alignment should match open parenthesis
- Remove global macro and use local lockdep expressions

 drivers/nvme/target/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..c2d6c2dd53fa 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -555,7 +555,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	} else {
 		struct nvmet_ns *old;
 
-		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link) {
+		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link,
+					lockdep_is_held(&subsys->lock)) {
 			BUG_ON(ns->nsid == old->nsid);
 			if (ns->nsid < old->nsid)
 				break;
@@ -1172,7 +1173,8 @@ static void nvmet_setup_p2p_ns_map(struct nvmet_ctrl *ctrl,
 
 	ctrl->p2p_client = get_device(req->p2p_client);
 
-	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link)
+	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link,
+				lockdep_is_held(&subsys->lock))
 		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
 }
 
-- 
2.24.1

