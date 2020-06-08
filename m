Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F295BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C719D2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgFHPBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:01:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41133 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbgFHPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:01:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id 9so20896041ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vbJ+Z5OJLPEUwZaiWYpSggd91RUgnOqEf/ZiRyDdXKM=;
        b=Gs1lhqSM6Z1ctvkxJZatUKUr2GW3HCgI+wrQ+Q5CmvYYlEsHOB9paC6HoqWs8TUYm6
         E+qhDPZwaCJbxHuN3oLr9Kp9TjyrXa3YNsZqpumVDnr0ncQjOAsIZLyd94ooMi1pBPlZ
         wxkVS+CqJd5Q1dk+tvQKxkPossFk+qvfx2Rk3EsacwGwgOM/xZtRKJIQ5yv3l+ZTZJPb
         XtQOjzU0rq5w4hrS5f9M9qfQvAAWi/FNKcDV8YccMmmd1aZwgdipWAJkSp884Qagop4F
         /OKL8Yv1SaBgwgj2xFtO8Yq4i2CZJxIQb1mHYqUdLxHEow5JwWKS0xtUcDffqSYGnJoy
         Omag==
X-Gm-Message-State: AOAM533oyT7GSFfBxzYOavQwxySLCja2ZDOstthy8zk2UMJmgXS4CmGl
        se4dcHBeI61duO2ubVo+LwQ=
X-Google-Smtp-Source: ABdhPJzfzOMQjNBSsSPjaGFOHCOPEONcFWMdYszGjD9HW0FH6aBQCKJXjWPfKgO/l/Mw0S1rvulsug==
X-Received: by 2002:a2e:978a:: with SMTP id y10mr9281752lji.115.1591628474737;
        Mon, 08 Jun 2020 08:01:14 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.116])
        by smtp.googlemail.com with ESMTPSA id r16sm279228ljn.106.2020.06.08.08.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:01:14 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [PATCH v2 1/4] coccinelle: api: extend memdup_user transformation with GFP_USER
Date:   Mon,  8 Jun 2020 18:00:35 +0300
Message-Id: <20200608150038.223747-2-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200608150038.223747-1-efremov@linux.com>
References: <20200608150038.223747-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match GFP_USER and optional __GFP_NOWARN allocations with
memdup_user.cocci rule.
Commit 6c2c97a24f09 ("memdup_user(): switch to GFP_USER") switched
memdup_user() from GFP_KERNEL to GFP_USER. In almost all cases it
is still a good idea to recommend memdup_user() for GFP_KERNEL
allocations. The motivation behind altering memdup_user() to GFP_USER:
https://lkml.org/lkml/2018/1/6/333

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/memdup_user.cocci | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index c809ab10bbce..cadcc2e87881 100644
--- a/scripts/coccinelle/api/memdup_user.cocci
+++ b/scripts/coccinelle/api/memdup_user.cocci
@@ -20,7 +20,9 @@ expression from,to,size;
 identifier l1,l2;
 @@
 
--  to = \(kmalloc\|kzalloc\)(size,GFP_KERNEL);
+-  to = \(kmalloc\|kzalloc\)
+		(size,\(GFP_KERNEL\|GFP_USER\|
+		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
 +  to = memdup_user(from,size);
    if (
 -      to==NULL
@@ -43,7 +45,9 @@ position p;
 statement S1,S2;
 @@
 
-*  to = \(kmalloc@p\|kzalloc@p\)(size,GFP_KERNEL);
+*  to = \(kmalloc@p\|kzalloc@p\)
+		(size,\(GFP_KERNEL\|GFP_USER\|
+		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
    if (to==NULL || ...) S1
    if (copy_from_user(to, from, size) != 0)
    S2
-- 
2.26.2

