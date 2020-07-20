Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BB3C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D462070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388727AbgGTQXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:23:12 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:35384 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbgGTQXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:23:08 -0400
Received: by mail-lf1-f47.google.com with SMTP id u12so10032008lff.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N8ZQ1z1Y9J3lklmnyIL1eg+foE3QYmPpQxCfPP1w6Ms=;
        b=rdKWVaYpc45vWah6ZYTSHlJlE9oU72q5NaV0Lry3tLzENi9T9W77KxjhEsBV8Dwj+8
         4DEzSlZsGhyoVkE+91T3yllIrwdZm6d9Yj4i6IEL6ZVWmkO1bXQVjOozYSnzJGBffTz6
         qIKzBZVQf7U8D8V3PGQNVIaEkSe13rogz5Y2qyo8CCrWeKF62jbrkzWJs0SYsSPHHZeO
         mus/4nD5Ks8Df7b31wA1xMpCprCUxnCp93h31L9jQTipkLd2bMbJEi8aQy0rhO96YglK
         vAKM5RJKIuLooNEOKsOOiRlyupuAgTTMtRpZ5qdBHwAe7kb4qX+7d4DOY8Ca1EnNhAAX
         ERNg==
X-Gm-Message-State: AOAM531AYJdMPirMy5TVWYoy+tzSfNWCBctXKqiSjER5cZ+dG0tLiohQ
        xgPSOczlVL/rHdkTlJNL7g0=
X-Google-Smtp-Source: ABdhPJwPSiI6maUDjNW5LdNyJ1oYyUWzFvLT4Ry+qkJRlqg+yd+gK6S7BJiIulAIF30jbdq+2o9JNA==
X-Received: by 2002:ac2:5a01:: with SMTP id q1mr11219181lfn.182.1595262185871;
        Mon, 20 Jul 2020 09:23:05 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id a19sm925855lff.25.2020.07.20.09.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 09:23:05 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] coccinelle: api: filter out memdup_user definitions
Date:   Mon, 20 Jul 2020 19:22:16 +0300
Message-Id: <20200720162216.13248-4-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200720162216.13248-1-efremov@linux.com>
References: <20200720162216.13248-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't match memdup_user/vmemdup_user.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/memdup_user.cocci | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index 60027e21c5e6..e01e95108405 100644
--- a/scripts/coccinelle/api/memdup_user.cocci
+++ b/scripts/coccinelle/api/memdup_user.cocci
@@ -15,12 +15,20 @@ virtual context
 virtual org
 virtual report
 
+@initialize:python@
+@@
+filter = frozenset(['memdup_user', 'vmemdup_user'])
+
+def relevant(p):
+    return not (filter & {el.current_element for el in p})
+
 @depends on patch@
 expression from,to,size;
 identifier l1,l2;
+position p : script:python() { relevant(p) };
 @@
 
--  to = \(kmalloc\|kzalloc\)
+-  to = \(kmalloc@p\|kzalloc@p\)
 -		(size,\(GFP_KERNEL\|GFP_USER\|
 -		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
 +  to = memdup_user(from,size);
@@ -42,9 +50,10 @@ identifier l1,l2;
 @depends on patch@
 expression from,to,size;
 identifier l1,l2;
+position p : script:python() { relevant(p) };
 @@
 
--  to = \(kvmalloc\|kvzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
+-  to = \(kvmalloc@p\|kvzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
 +  to = vmemdup_user(from,size);
    if (
 -      to==NULL
@@ -63,7 +72,7 @@ identifier l1,l2;
 
 @r depends on !patch@
 expression from,to,size;
-position p;
+position p : script:python() { relevant(p) };
 statement S1,S2;
 @@
 
@@ -76,7 +85,7 @@ statement S1,S2;
 
 @rv depends on !patch@
 expression from,to,size;
-position p;
+position p : script:python() { relevant(p) };
 statement S1,S2;
 @@
 
-- 
2.26.2

