Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BC0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C43206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YFyChil3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgC3Cea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:34:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39241 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbgC3Cdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id f20so13936368qtq.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 19:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y9juYIZdTD4S3/RhfF4ZU+wi+6D+Bwupgtb3fIEkI74=;
        b=YFyChil3lVYm7zhnne5lGhwbXXlq2EDvxsIxZFa2dtN2ItcId/sHvPqThGAh1BwFZl
         YWaCpA7Lt+GVmGROOWIIkfAFa//fAZAdJmSr8bHVwVDtlP8Ncb6wNX3k7OmivGSl7CnM
         qCJmFAVk90alncCE3ob/Cy9tUBPO6k+bzjjzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9juYIZdTD4S3/RhfF4ZU+wi+6D+Bwupgtb3fIEkI74=;
        b=Pkg1hCbbaXUY2iMon0hyKpjTLtoLaWI70zxe17aXm1QBzJRcaJccH+qegh87A/lvKk
         odeR1YdmZ3tIUUyS722/OnuH5CV63S44AQy0csp+lSabmc2IofP6KonH38PKfiL68LXl
         Tart3pX+czR+EUhvMUyNEF3IxabYC0Ruo+Hp2U1y12GwDuq4Lx0cZn7B4N/iCZlQMtLt
         ZvC8AoBzkl6kRewqWD2OmiiAnUAAnvkNda4ZtigyP85AGIGG+dKkvQjusV59uDG1C7Hb
         kSe/JHzC0pOldzIy5slKAcvU/FrNQUVHfbw96IRXNI+jhynFTUuKvRj4QBz8CHeC0BPf
         evSw==
X-Gm-Message-State: ANhLgQ1lHqMmdUdtul7AUT5LRFh6B3slDhaE0jjd+mGE58/gTy5Cs/BS
        N+RucMgXi0jB6PBIF9nzTofTP3HN9HM=
X-Google-Smtp-Source: ADFU+vscGt7vUJpfCtGgJZKczUSOnNkYu/OpdYETeb8x0PKQDoRTASn4p6B5qpZSy87hhDabIXEibQ==
X-Received: by 2002:ac8:6d19:: with SMTP id o25mr10223186qtt.303.1585535617018;
        Sun, 29 Mar 2020 19:33:37 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:36 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 06/18] mm/list_lru.c: Remove kvfree_rcu_local() function
Date:   Sun, 29 Mar 2020 22:32:36 -0400
Message-Id: <20200330023248.164994-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Since there is newly introduced kvfree_rcu() API, there is no need in
queuing and using call_rcu() to kvfree() an object after the GP.

Remove kvfree_rcu_local() function and replace call_rcu() by new
kvfree_rcu() API that does the same but in more efficient way.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/list_lru.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 386424688f805..69becdb224080 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/memcontrol.h>
+#include <linux/rcupdate.h>
 #include "slab.h"
 
 #ifdef CONFIG_MEMCG_KMEM
@@ -383,21 +384,13 @@ static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
 	struct list_lru_memcg *memcg_lrus;
 	/*
 	 * This is called when shrinker has already been unregistered,
-	 * and nobody can use it. So, there is no need to use kvfree_rcu_local().
+	 * and nobody can use it. So, there is no need to use kvfree_rcu().
 	 */
 	memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
 	__memcg_destroy_list_lru_node(memcg_lrus, 0, memcg_nr_cache_ids);
 	kvfree(memcg_lrus);
 }
 
-static void kvfree_rcu_local(struct rcu_head *head)
-{
-	struct list_lru_memcg *mlru;
-
-	mlru = container_of(head, struct list_lru_memcg, rcu);
-	kvfree(mlru);
-}
-
 static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 				      int old_size, int new_size)
 {
@@ -429,7 +422,7 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 	rcu_assign_pointer(nlru->memcg_lrus, new);
 	spin_unlock_irq(&nlru->lock);
 
-	call_rcu(&old->rcu, kvfree_rcu_local);
+	kvfree_rcu(old, rcu);
 	return 0;
 }
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

