Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92061C3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6630B2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IBiQ45Su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgBNWYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:24:34 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:35092 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgBNWYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:24:34 -0500
Received: by mail-pl1-f201.google.com with SMTP id v24so5972045plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 14:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gqPN6rca6tQbB2wbaK3mUEwUJIuY7eBrM+y+4z2O/UE=;
        b=IBiQ45SugGiYgT2pAGmSYKd2rySIEgvA5tF8RFPtcJAYQzPcRnZZQr24PUCzcN/nOy
         fuH+tT2GGPHZ/JMiRmG1u9zClkRghNwblFj7VdyFHxNkqGOW7qmcfVMZSDe0HIS0nK0R
         fk0Ye33LfaW/FfzbJvH+2/9aeoq0Ew1e2MkVST/thn104F3pBTElosxodPQEzWRLm1SW
         T0qx/k/kdqkGZ/0scvEn7yc1YnSSuFmlsfYPk6xlcBLpGJVFHI7EPaMWi01x19xcxP9c
         8Wesjy05hYcLRq6fCWOiqpxwsjtTmDR5fDLTKl2BYzX6v59fF2uCPKJFma+ZaAmJmMj8
         7HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gqPN6rca6tQbB2wbaK3mUEwUJIuY7eBrM+y+4z2O/UE=;
        b=M9WdmLxP3R8wOIgLSOtHKq0V1k0HkDeERBwCvsOofkUJtu2kmeN/eN9fqd4RyQnnBJ
         dNgRBJwIUwM34E22tKos3oQGUuHGfJSRVAT8qmeh/vBVYMEQpsJmVMZznK8dKZp3xPJN
         sQYqYOYNwt1wzkjv2m0P/4lxRJLNj2uX1ulxRyaKIXQW/KJqYQGvS5s3CHqEsEvlN19/
         nAoGPQHX5lh/igeueEloFA/EHy3LqUrMWYBA5vgddeOv6Z+E7Gzp1unSSXv4I9uZ1GXR
         pfEi7WFyHlwrLzs/cwLPbx+L13Sum20IxtHnd0MU46Z5XPop3/zQos3M+VLg5byHlFz1
         iIeg==
X-Gm-Message-State: APjAAAUrCuMJaohUbiBiHfg1piX5cbR04uJC15VwPYGJsz7syo2jrEdW
        jUk30mmjXW4BrpjQs6G8xy6X0Ix21tkIQg==
X-Google-Smtp-Source: APXvYqz1w47plUwAsWnS2MYEj+vEOGzWFxpavAEQRWVDTVZ5Umn3Vx7wAYsP5+JGpIHHx1RiRMb3+syCObAY7w==
X-Received: by 2002:a63:778c:: with SMTP id s134mr5559980pgc.451.1581719071824;
 Fri, 14 Feb 2020 14:24:31 -0800 (PST)
Date:   Fri, 14 Feb 2020 14:24:15 -0800
Message-Id: <20200214222415.181467-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2] cgroup: memcg: net: do not associate sock with unrelated cgroup
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are testing network memory accounting in our setup and noticed
inconsistent network memory usage and often unrelated cgroups network
usage correlates with testing workload. On further inspection, it
seems like mem_cgroup_sk_alloc() and cgroup_sk_alloc() are broken in
irq context specially for cgroup v1.

mem_cgroup_sk_alloc() and cgroup_sk_alloc() can be called in irq context
and kind of assumes that this can only happen from sk_clone_lock()
and the source sock object has already associated cgroup. However in
cgroup v1, where network memory accounting is opt-in, the source sock
can be unassociated with any cgroup and the new cloned sock can get
associated with unrelated interrupted cgroup.

Cgroup v2 can also suffer if the source sock object was created by
process in the root cgroup or if sk_alloc() is called in irq context.
The fix is to just do nothing in interrupt.

Fixes: 2d7580738345 ("mm: memcontrol: consolidate cgroup socket tracking")
Fixes: d979a39d7242 ("cgroup: duplicate cgroup reference when cloning sockets")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---

Changes since v1:
- Fix cgroup_sk_alloc() too.

 kernel/cgroup/cgroup.c | 4 ++++
 mm/memcontrol.c        | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9a8a5ded3c48..46e5f5518fba 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6449,6 +6449,10 @@ void cgroup_sk_alloc(struct sock_cgroup_data *skcd)
 		return;
 	}
 
+	/* Do not associate the sock with unrelated interrupted task's memcg. */
+	if (in_interrupt())
+		return;
+
 	rcu_read_lock();
 
 	while (true) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 63bb6a2aab81..f500da82bfe8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6697,6 +6697,10 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 		return;
 	}
 
+	/* Do not associate the sock with unrelated interrupted task's memcg. */
+	if (in_interrupt())
+		return;
+
 	rcu_read_lock();
 	memcg = mem_cgroup_from_task(current);
 	if (memcg == root_mem_cgroup)
-- 
2.25.0.265.gbab2e86ba0-goog

