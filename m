Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4E0C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C73222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/KjJzEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgBNHM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:12:59 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:56866 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgBNHM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:12:59 -0500
Received: by mail-pg1-f201.google.com with SMTP id 71so4685163pgg.23
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 23:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GUW2iSWVcQnIpjOPNE/ThNp+Hs+3dImvwMIhxUppeuc=;
        b=X/KjJzEFSqSYWdSfML7JzS6n8HILLSQQiXHtsSRI37f+n9WVM5YZMoHTy7mrHn4gGG
         hiPLZs7adC6g14eb5Li+tsysiLOlk8Tm2QXpXorPLvcipOR2ey7hQGzHi/U4dnqIMYqe
         znIerMU7p8tjZjFbH0Zc0oTlRND+PiTNe3d94aV6gKKoRrlRGnwcmXmydkAf852PDJcU
         wDUPiEnhJ7CO/mAQ39rQ+aGDyE0+Nwcqt9EtBy2NyB7VfJIBImkoe3Xcq668JvykU6aJ
         QuJrqgKAcgR/YnrcmcwLhj9TFG9UrPEwL70sB3KLjiV9T3OsyGpnREhIXRMROfT7Q7A3
         yvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GUW2iSWVcQnIpjOPNE/ThNp+Hs+3dImvwMIhxUppeuc=;
        b=JxHY6aOkkuQhNppWUxXEhAUX4JId+RlzvnBIJb/bpGL6IRYSEKcy1rwqfE6Mn5DFOi
         TPXD8APd2UwYs4w7ypJGQ0E/gstrHIL42kQ12jQohf3CXnWljpdF+X2mpiH/hiCXXYnn
         GjX0sGUkSN4n2zzYvs0hkagBmMWp/lGVw2vkBe00GO8EA5GQZ5Dor/SiO5Z4m7lOoAxP
         DWEV5S39k+W1Kj1jv+4PqvOMrdCp3M1itKZHiRu48Hqrgik+DlvsKQR03+OeaX4rOX4t
         5JFWpmEBYkQUiJXQVvCQOG1xcM7SKSElpk/Zj5lmI8+tHUflElG8503VssjGXaOKVqDn
         EYAA==
X-Gm-Message-State: APjAAAW+hO7L7HzHXQ6GJGab6jSZWTmUdX9PCnOrZnjS8G6oCsJQW2n2
        g+wY5IlhwYP18IN9v3xVssqVTcTit3DY4A==
X-Google-Smtp-Source: APXvYqwI3Y/jbP9VtSLYI93+92eWNZSPA3hRBkyh1+IdbC3I0JAFFYLTnNgS9Bb7M2Rhd12CMf5e5s0E8x8kmQ==
X-Received: by 2002:a63:451b:: with SMTP id s27mr1904601pga.233.1581664378417;
 Thu, 13 Feb 2020 23:12:58 -0800 (PST)
Date:   Thu, 13 Feb 2020 23:12:33 -0800
Message-Id: <20200214071233.100682-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] memcg: net: do not associate sock with unrelated memcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     Greg Thelen <gthelen@google.com>, Michal Hocko <mhocko@kernel.org>,
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
inconsistent network memory usage and often unrelated memcgs network
usage correlates with testing workload. On further inspection, it seems
like mem_cgroup_sk_alloc() is broken in irq context specially for
cgroup v1.

mem_cgroup_sk_alloc() can be called in irq context and kind
of assumes that it can only happen from sk_clone_lock() and the source
sock object has already associated memcg. However in cgroup v1, where
network memory accounting is opt-in, the source sock can be not
associated with any memcg and the new cloned sock can get associated
with unrelated interrupted memcg.

Cgroup v2 can also suffer if the source sock object was created by
process in the root memcg or if sk_alloc() is called in irq context.
The fix is to just do nothing in interrupt.

Fixes: 2d7580738345 ("mm: memcontrol: consolidate cgroup socket tracking")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 4 ++++
 1 file changed, 4 insertions(+)

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

