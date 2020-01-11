Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF73C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 07:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3324620848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 07:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRq3uXnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgAKHj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 02:39:56 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39652 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbgAKHjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 02:39:55 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so1750015plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 23:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sj2E8hbf+1n1JQewsDgj2Fs29eg9VqanuSP3luTlahg=;
        b=BRq3uXnfOC/WIjl9+DbaxslikTOCbxvw6S5ZzMoh4VEfmtZlzzVlFRaHOrgci0WAyE
         DVwlYZ/G1nx8+Y+ZCNlj/3oY8GUL2ALOuiYPxwJEykRMfQAmi3LDX1vsEy4rYKWeMEP9
         9wXW7dXUK3CkxPh6L70MMH9ULPtXUIo6H6bJRU49x77fPNzY6G/H/HaQ7mpnd4yMgRWx
         Ujqwg0XQgfw02W2MFxuW8EePWRt5AhXTOIegnlKtxPP+w7QIupOKFWBngtU7XMb3cFRh
         uvPRzR9VOsY/PxEC8sZagAbNn4J2tlzh2kMr4GEPgrF8uMOjGqDoHStkZlIyY9XRsUmP
         uLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sj2E8hbf+1n1JQewsDgj2Fs29eg9VqanuSP3luTlahg=;
        b=q+buk/TiXUgHRU6suX7PpGr1ZmiPAeRwOdmHQktdM+v+VrEvxe8csdxPAoYGVWs5mX
         y4+ZKGKZcyfjv94vyOMOWGfESIACm1FR2UYXgL9/tE9f8XxI8XjSnzx1HiQxht9G9Ha2
         exvRwSKR9UB1y+1he6ZpAThOzYLnPtpcJbDt7yICgTvrd3GNFuPcFqXpfb+wiOm6cj/L
         Jzp6ounSDzQ5yXk9oYvNTSpQdJ1X18kaFSYSS71Jf/HSYYB768KvNx442oBSE5/sfM/g
         JeSUXG6My1QLTRx2Oy+4XYgQETmk6AWWlXB2OFfy7DkGuSKHn6wgoKg99cIdxUfrR/oO
         W38A==
X-Gm-Message-State: APjAAAV+7LR32kx2tj9sQujbf3ECJdRGezv6oaiuLSsmCyBF1QjRPJPd
        PEQnq+nWgY8C1RRfIvzykmk=
X-Google-Smtp-Source: APXvYqzQun+14sGBUPw6UTkEDD50gGQAL0YWb8/xCo0l7Y8qM6mXd12JR0SEd2bwgk3cOVE3zuf3UQ==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr3257670pla.17.1578728394863;
        Fri, 10 Jan 2020 23:39:54 -0800 (PST)
Received: from localhost.localdomain ([146.196.37.13])
        by smtp.googlemail.com with ESMTPSA id z4sm5437450pfn.42.2020.01.10.23.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 23:39:54 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v3] drivers: nvme: target: core: Pass lockdep expression to RCU lists
Date:   Sat, 11 Jan 2020 13:08:16 +0530
Message-Id: <20200111073815.7659-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ctrl->subsys->namespaces and subsys->namespaces are traversed with
list_for_each_entry_rcu outside an RCU read-side critical section
but under the protection of ctrl->subsys->lock and subsys->lock
respectively.

Hence, add the corresponding lockdep expression to the list traversal
primitive to silence false-positive lockdep warnings, and
harden RCU lists.

Reported-by: kbuild test robot <lkp@intel.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Amol Grover <frextrite@gmail.com>
---
v3:
- Fix error reported by kbuild test robot

v2:
- Fix sparse error
  CHECK: Alignment should match open parenthesis
- Remove global macro and use local lockdep expressions

 drivers/nvme/target/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..35810a0a8d21 100644
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
+				lockdep_is_held(&ctrl->subsys->lock))
 		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
 }
 
-- 
2.24.1

