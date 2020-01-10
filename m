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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D901C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E817C20721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+Sa4LDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgAJNZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:25:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36541 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgAJNZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:25:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id x184so1156979pfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 05:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFiZIlIgmkNA3t4b+dQtP70neZja23u9OLrKEBFh9OQ=;
        b=T+Sa4LDOSdvRALNgrgFkTf5iZDS1Jm4fYUVw8rWYiU0HP3HgNchXKGwUMyMzyjboUb
         xI0eAOoHSzDzeUaUeDSWW2VfwfDtEhTaU9+LIqME2jGXd03LCV8OYqv8IrycYHUb0NJf
         1A/B6xh5eYTegzoDUGz+gLlRI/92rrcURlROO9A5519cupAKeCxMGeAH+NvUhVti2t3k
         JEWeBOQ4LJNQSMSlqwpmBeeYVELpLiEWkQREpLJ42bGkdKGQ7e+NnI+OetbpT11nOIuL
         ciYlfS+NXKleg6I/8eE3BmEJmX7LSVF5TfWdzBy4UGgET28TdOYaI6si2cBbDJb/EyVT
         M2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UFiZIlIgmkNA3t4b+dQtP70neZja23u9OLrKEBFh9OQ=;
        b=ZCCFO5f/WJsm4rsCngoWr1UGpN34AfQ644YKLTRMhE3HZhjKWFLZJK/kRz06z69Tj5
         0QtsBdhSZOAHZRuw1JWuiWcZkmi3Oq7n6LvgyPyZpokevuQHlmj52/kuzqb6nC+cD5uS
         5kCMxez7lIIwpNXyfvApym/Yry+CMynDIXqeCuT1TLU2MOZxRVPEJ/f9+vy9PdtMpS/V
         X/3J3TqRqMfVRikPGpaRR9wGpnS6b9XaEBkSkpqPDknzJORdb8p2jOmikwaVyGEpkD3E
         HFsfehV/60TSZP/G/Y5BltAgcPj9SM+kp26de/1XhmizxQBaa7DY6nga/d/vvThyx+VJ
         FnYg==
X-Gm-Message-State: APjAAAWGa3w5rO78e41j1Ip5RpKVDtfuaS1Kom4uo+iP7YyNSnDDM/YT
        3vYe1pcbhMCnc1cDjTJ1Jk0=
X-Google-Smtp-Source: APXvYqxhW94ndLVj5iXTpBpWRfqrS0M7EiNqDD0W2XvB0sPK6eEAA8r1f0ydpuMft0C1J2vg65kx+g==
X-Received: by 2002:a62:e30f:: with SMTP id g15mr4044199pfh.124.1578662711271;
        Fri, 10 Jan 2020 05:25:11 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.220])
        by smtp.googlemail.com with ESMTPSA id l2sm2907749pjt.31.2020.01.10.05.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 05:25:10 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] drivers: nvme: target: core: Pass lockdep expression to RCU lists
Date:   Fri, 10 Jan 2020 18:53:58 +0530
Message-Id: <20200110132356.27110-1-frextrite@gmail.com>
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

Add macro for the corresponding lockdep expression to make the code
clean and concise.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 drivers/nvme/target/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..7caab4ba6a04 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -15,6 +15,9 @@
 
 #include "nvmet.h"
 
+#define subsys_lock_held() \
+	lockdep_is_held(&subsys->lock)
+
 struct workqueue_struct *buffered_io_wq;
 static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
 static DEFINE_IDA(cntlid_ida);
@@ -555,7 +558,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	} else {
 		struct nvmet_ns *old;
 
-		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link) {
+		list_for_each_entry_rcu(old, &subsys->namespaces, dev_link,
+							subsys_lock_held()) {
 			BUG_ON(ns->nsid == old->nsid);
 			if (ns->nsid < old->nsid)
 				break;
@@ -1172,7 +1176,8 @@ static void nvmet_setup_p2p_ns_map(struct nvmet_ctrl *ctrl,
 
 	ctrl->p2p_client = get_device(req->p2p_client);
 
-	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link)
+	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link,
+							subsys_lock_held())
 		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
 }
 
-- 
2.24.1

