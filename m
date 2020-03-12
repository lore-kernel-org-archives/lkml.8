Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C1EC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4E120724
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584046490;
	bh=x3eE8XCJh8LFHAtuc5qe2vePqwZ5NcJ02SRu5GET8pk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Jy5OURepO4WZghPtWRTq8OXKdwkeWrZf2Yz1GeFj60R99L59CK/+hxUf/+i8xAK+8
	 cltvmYIZT5N+HDakUYfBi7CIIKuOV8FTn47IJb6SALNs6eEqvHTnF2fcD2F2NkqelT
	 Shq75Ib/eXhu2+Ld+u1nazyNHywuo0/gWECj02Ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgCLUyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:54:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37646 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgCLUys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:54:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id l20so5642499qtp.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 13:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Zr17asMqdK6cIxhKtMqoEc5/q0cnA28t59nqf1Cq7h4=;
        b=gk/Jru10PLdNEoR6E2QrOBmWxlA0YLmTiWO3aUSaj16lN1CVaI6F1C0VPBkXmFoAt+
         NDM/220sFZXU9jIOiDh5O7eCQquBHiK08m0bvSINYtavQY3xS/BWlmItIc2GzDQuROWN
         Iy/EjBZ+VMRvz1hu0vGcDIJJjiVAoM5xXNdmdRtEdw0YSGShnD+6XVijot/W1mAyxLTr
         ViD8CdjxN5UmsVMDVxOwrTsNlwxKTtn1oAql5+uETde0bGqKqxo0G90k6PIoU5BirQkQ
         oBxi8wQH/f7uXUoma4kWmHU5wfYjzEeC12Wkg48L+HFY37E6giE/2lwHLvFrPUstUYvU
         EmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Zr17asMqdK6cIxhKtMqoEc5/q0cnA28t59nqf1Cq7h4=;
        b=hLfuwglSBlb4a8M7ZAIz070OlfYIfl8gVJz9wmEOVkOemQRLmKOg1MWEIsSzyODPda
         jPyPARVuevbtsipbitjrmd5HvlEXzdFVAz3+gyzFg6yXF6m1Ek+N+E1nujc+Yi4v7JvY
         mxn9UtrJCZ0wFLdYikq4BQ1BzDtDZzsE6E7XFIKeEO9LVkdereCAOKXx482G9yInNcl4
         J36190fR2JDOM5nJwWx4VB9X7V+df7Al4RYQOzSVFw7i2RtKpdZEV+LZod5BgV5wfXGj
         Ai4PyyrrskLUoBZ8/rp2EfuAiuJUlD2v7Hjtl3/NBUcpZ75tazgXCJHVO4J28RgRFxdw
         Tokw==
X-Gm-Message-State: ANhLgQ3Maq+P2Zw/TvT7Xla3SEojXMeBlQp3+/RvGsunNdJxsriMDn99
        aPf1t6uzpvw41iapo78d31k=
X-Google-Smtp-Source: ADFU+vvpFRILqRpSUYYx+PXTYAoKKo0jW/5CjZ/ss2sZgTXB+jw13/pqOlRXBVzHIhkuKbtsAJQ2bg==
X-Received: by 2002:ac8:7508:: with SMTP id u8mr9487772qtq.163.1584046487704;
        Thu, 12 Mar 2020 13:54:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::25ed])
        by smtp.gmail.com with ESMTPSA id w13sm21271786qtn.83.2020.03.12.13.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 13:54:46 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:54:45 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH cgroup/for-5.7] cgroup: Restructure release_agent_path
 handling
Message-ID: <20200312205445.GJ79873@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From e7b20d97967c2995700041f0348ea33047e5c942 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 12 Mar 2020 16:44:35 -0400

cgrp->root->release_agent_path is protected by both cgroup_mutex and
release_agent_path_lock and readers can hold either one. The
dual-locking scheme was introduced while breaking a locking dependency
issue around cgroup_mutex but doesn't make sense anymore given that
the only remaining reader which uses cgroup_mutex is
cgroup1_releaes_agent().

This patch updates cgroup1_release_agent() to use
release_agent_path_lock so that release_agent_path is always protected
only by release_agent_path_lock.

While at it, convert strlen() based empty string checks to direct
tests on the first character as suggested by Linus.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
Applying to cgroup/for-5.7. Please holler for any objections.

Thanks.

 kernel/cgroup/cgroup-v1.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index f2d7cea86ffe..191c329e482a 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -38,10 +38,7 @@ static bool cgroup_no_v1_named;
  */
 static struct workqueue_struct *cgroup_pidlist_destroy_wq;
 
-/*
- * Protects cgroup_subsys->release_agent_path.  Modifying it also requires
- * cgroup_mutex.  Reading requires either cgroup_mutex or this spinlock.
- */
+/* protects cgroup_subsys->release_agent_path */
 static DEFINE_SPINLOCK(release_agent_path_lock);
 
 bool cgroup1_ssid_disabled(int ssid)
@@ -775,22 +772,29 @@ void cgroup1_release_agent(struct work_struct *work)
 {
 	struct cgroup *cgrp =
 		container_of(work, struct cgroup, release_agent_work);
-	char *pathbuf = NULL, *agentbuf = NULL;
+	char *pathbuf, *agentbuf;
 	char *argv[3], *envp[3];
 	int ret;
 
-	mutex_lock(&cgroup_mutex);
+	/* snoop agent path and exit early if empty */
+	if (!cgrp->root->release_agent_path[0])
+		return;
 
+	/* prepare argument buffers */
 	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
-	agentbuf = kstrdup(cgrp->root->release_agent_path, GFP_KERNEL);
-	if (!pathbuf || !agentbuf || !strlen(agentbuf))
-		goto out;
+	agentbuf = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!pathbuf || !agentbuf)
+		goto out_free;
 
-	spin_lock_irq(&css_set_lock);
-	ret = cgroup_path_ns_locked(cgrp, pathbuf, PATH_MAX, &init_cgroup_ns);
-	spin_unlock_irq(&css_set_lock);
+	spin_lock(&release_agent_path_lock);
+	strlcpy(agentbuf, cgrp->root->release_agent_path, PATH_MAX);
+	spin_unlock(&release_agent_path_lock);
+	if (!agentbuf[0])
+		goto out_free;
+
+	ret = cgroup_path_ns(cgrp, pathbuf, PATH_MAX, &init_cgroup_ns);
 	if (ret < 0 || ret >= PATH_MAX)
-		goto out;
+		goto out_free;
 
 	argv[0] = agentbuf;
 	argv[1] = pathbuf;
@@ -801,11 +805,7 @@ void cgroup1_release_agent(struct work_struct *work)
 	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
 	envp[2] = NULL;
 
-	mutex_unlock(&cgroup_mutex);
 	call_usermodehelper(argv[0], argv, envp, UMH_WAIT_EXEC);
-	goto out_free;
-out:
-	mutex_unlock(&cgroup_mutex);
 out_free:
 	kfree(agentbuf);
 	kfree(pathbuf);
-- 
2.24.1

