Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8B9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CD6B20809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uekz1hDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgG2OuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2OuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:50:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFB9C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:50:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mt12so1967837pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XgDzWs5LYt7Mkx0UdbPr7BFgEZ8N/ZoZ6ADwKcHkW84=;
        b=Uekz1hDHFE/A9esJhBdVFwm8ohWCgO/OY+8PRW1Bp2rQOpEMNN1vlmW+8ay2DT91cC
         7eD39VYxARUX7FoPwiGCEGuKIqd7uzQ0yuRdRsUhVuy+XVqUoytulRJDXGOkjnpk4WIQ
         /F5R0wumaXINUq/XwS3HWxK+YZttG/FXg/eyuOPSQXavDsp4DE6hVWijJQRb/+g8uEm+
         L8z4RGzDZwAonZa3lTaSb5tla73JNC4esECyEUnIvyakAruIZnKlTUP1hUtcwhuosDWz
         7kVUbvMUh33slesyNHfEwPykMehktJmKvc8qgzggibg4jyM5K4SDzXd5fhQXDd+zKHKL
         MG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XgDzWs5LYt7Mkx0UdbPr7BFgEZ8N/ZoZ6ADwKcHkW84=;
        b=hMalOlnqSm1AGmuo+n9JI+BuoxRH99aSqtIZfduslftazpdWoRSfRcZrTepg3LpRXy
         vVs5z/ScXOKxGMiJxc6uoOJOdaz/1fE8ZFeZv0VrrlOyrmLi4I/MlFQnYRX3glKXbMQW
         igz1q+OA7LNcnvQ23ynYsS7OsO5OH96oNSd07pAZbiE5QXmcHKl09fkGiWi12eEL2UkZ
         uV37ZaSUEPDVw7/mx0YJ1dkbK94St3rkhY8PSN0+sFZjh/h0bO81OR58V2XXnTn6ishS
         ajpbzoq7Zu4H6G2DjuWlv/p4f0r5nYZo90unK7tnbRdtpg94ZJXq/13GMegio81Tuc94
         UYEA==
X-Gm-Message-State: AOAM532p+9enxRPWQtif86vbQFvyv5DU9aFpyyJD18dOaX+fimnpofyL
        5My1tbK5mYks8NOJAOXjhW0=
X-Google-Smtp-Source: ABdhPJxsckiyS9HZ6KWrI4D+jRealIDAmq6K3fsnqkoDoBrRPnfto+1PgdXkVPNlSwxO859eW7X4jQ==
X-Received: by 2002:a17:902:d303:: with SMTP id b3mr13162508plc.101.1596034220591;
        Wed, 29 Jul 2020 07:50:20 -0700 (PDT)
Received: from builder-PowerEdge-R730xd.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id o190sm1251827pfd.194.2020.07.29.07.50.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 07:50:20 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, zhaoqianli@xiaomi.com
Subject: [PATCH] mm: slab: Avoid the use of one-element array and use struct_size() helper
Date:   Wed, 29 Jul 2020 22:50:14 +0800
Message-Id: <1596034214-15010-1-git-send-email-zhaoqianligood@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qianli Zhao <zhaoqianli@xiaomi.com>

There is a regular need in the kernel to provide a way to declare having a
dynamically sized set of trailing elements in a structure. Kernel code should
always use “flexible array members”[1] for these cases. The older style of
one-element or zero-length arrays should no longer be used[2].

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://github.com/KSPP/linux/issues/21

Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
---
 mm/slab.h        | 2 +-
 mm/slab_common.c | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 74f7e09..c12fb65 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -34,7 +34,7 @@ struct kmem_cache {
 
 struct memcg_cache_array {
 	struct rcu_head rcu;
-	struct kmem_cache *entries[0];
+	struct kmem_cache *entries[];
 };
 
 /*
diff --git a/mm/slab_common.c b/mm/slab_common.c
index fe8b684..56f4818 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -166,9 +166,7 @@ static int init_memcg_params(struct kmem_cache *s,
 	if (!memcg_nr_cache_ids)
 		return 0;
 
-	arr = kvzalloc(sizeof(struct memcg_cache_array) +
-		       memcg_nr_cache_ids * sizeof(void *),
-		       GFP_KERNEL);
+	arr = kvzalloc(struct_size(arr, entries, memcg_nr_cache_ids), GFP_KERNEL);
 	if (!arr)
 		return -ENOMEM;
 
@@ -199,8 +197,7 @@ static int update_memcg_params(struct kmem_cache *s, int new_array_size)
 {
 	struct memcg_cache_array *old, *new;
 
-	new = kvzalloc(sizeof(struct memcg_cache_array) +
-		       new_array_size * sizeof(void *), GFP_KERNEL);
+	new = kvzalloc(struct_size(new, entries, new_array_size), GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 
-- 
2.7.4

