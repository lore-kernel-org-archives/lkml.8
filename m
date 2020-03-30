Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA275C2D0E7
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD79206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vate42J2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgC3CeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:34:19 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42046 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbgC3Cdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:41 -0400
Received: by mail-qk1-f195.google.com with SMTP id 139so7648210qkd.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 19:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1STg3B4NFmryGFsVQ39Fqcyyw2zeIxUup+slIF9OxYI=;
        b=vate42J2T1d4IR+p4SKAXzO/ZNqN9vu8zAMaADAJJq3jsp+Q3qXkRYHGB9gcbDfR5X
         yby/F2W/Z8EsSL7vC7Y/dMjfPVzClbZ7BbzFi3Jo2sSZZhn4N2rwuGJ3JSjqGl3MUieF
         p1dapi543VOjfTBXmPigUXE+aC4dPwbPpTuwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1STg3B4NFmryGFsVQ39Fqcyyw2zeIxUup+slIF9OxYI=;
        b=KMhy7q4kCBVHOSlA15pDuFHecLd2vPWtW9joLKCVGN7c7C4cHfGYJ0e2SRPGUFVmn1
         wmS+APpx3Mp5tlI7GpvF5yiS63QL63KS7inSnUknsPhtFWcFQrn98zo+XAMGTkjftBI9
         gbiZbi8Q7uXpl5GIsfjxzQG+rgLNaOuiLrz1ZqYD6TyeUSwo//AN5xH4WGz9IPXnmjtT
         NfptIop6je1LwOAK3RD3MZztBAbq+e9lkngIHDXYxKLER1UuvxGx1976a9cVdsn/ZBOm
         icL4KafzhsFP6ZNoznaP2TFGs4MlLoBHBnOofGOyM9koV6k50dg6Vv13yi0u3c34YypY
         e/Wg==
X-Gm-Message-State: ANhLgQ20BUtS7q7qCXOrhknkisHMRJpv/Ro5V5LBIT93FLoiFlkKVOHn
        YbhAabmC9npD+LiAjYF2TWdj0p2RrHc=
X-Google-Smtp-Source: ADFU+vsb7u7onAWM6SNZg0kNXedSUyJKJP7iWxDcLoGW/pjia1x5QLz+6JZM6GIVlbH8uur2r+xlOA==
X-Received: by 2002:a37:6357:: with SMTP id x84mr10162791qkb.490.1585535619962;
        Sun, 29 Mar 2020 19:33:39 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:39 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 09/18] rcu/tree: Simplify KFREE_BULK_MAX_ENTR macro
Date:   Sun, 29 Mar 2020 22:32:39 -0400
Message-Id: <20200330023248.164994-10-joel@joelfernandes.org>
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

We can simplify KFREE_BULK_MAX_ENTR macro and get rid of
magic numbers which were used to make the structure to be
exactly one page.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8dfa4b32e4d00..cfe456e68c644 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2807,13 +2807,6 @@ EXPORT_SYMBOL_GPL(call_rcu);
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
 #define KFREE_N_BATCHES 2
 
-/*
- * This macro defines how many entries the "records" array
- * will contain. It is based on the fact that the size of
- * kfree_rcu_bulk_data structure becomes exactly one page.
- */
-#define KFREE_BULK_MAX_ENTR ((PAGE_SIZE / sizeof(void *)) - 3)
-
 /**
  * struct kfree_rcu_bulk_data - single block to store kfree_rcu() pointers
  * @nr_records: Number of active pointers in the array
@@ -2827,6 +2820,14 @@ struct kfree_rcu_bulk_data {
 	struct kfree_rcu_bulk_data *next;
 };
 
+/*
+ * This macro defines how many entries the "records" array
+ * will contain. It is based on the fact that the size of
+ * kfree_rcu_bulk_data structure becomes exactly one page.
+ */
+#define KFREE_BULK_MAX_ENTR \
+	((PAGE_SIZE - sizeof(struct kfree_rcu_bulk_data)) / sizeof(void *))
+
 /**
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
-- 
2.26.0.rc2.310.g2932bb562d-goog

