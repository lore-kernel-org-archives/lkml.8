Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62723C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E64206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgFHPB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:01:29 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:40567 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbgFHPBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:01:24 -0400
Received: by mail-lj1-f173.google.com with SMTP id n23so20896949ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gS/VQWLqdTR1WnMRT1E0dWszp6HUI8fnasX0aZv1mo8=;
        b=sTdfHVsZfmK5p92kMsz8lkx2oghi58+GhaSV7HLjHAJSSCAJdAlFqQVpF6iDf6zRzR
         QiLgVlaluy/2lVdAFWe8s+u8t3Wr9869HVuhGNWRalaVGr5nLcizoefz5OeG3MhDSRIq
         2u5BEm9Tk7vYw9gxLP84FHyzOLV0Bxi/DRTxbKDelRCPjkW4jB57OpXCsI1sOJk9swOS
         PsufIpYtCcp5Ls6EH/Fsw2twHTIYAuqYY12utVLvLDnrqSjHLJM1ngEdYzSJNAoWiFog
         EtqB77HK8Z5ZnMiTUo83Qx3byra2SDlyDBy5Xl4WCpGAXMNk8uBHJ8Toan9UK3bGow39
         x73A==
X-Gm-Message-State: AOAM532bvUtUYZXxci97UlZp0XOotEzl+RqX4hkV/Xvlen94nr2fsHIS
        XYJTvIt6bTCE15kIXZUV8eBvRcb5qLI=
X-Google-Smtp-Source: ABdhPJzLKQbTG+B2awlUCbuilSYITMINPGNFWm2gSFfpcpQ8UoH6L5e6cbQTFICgqgLzZ6kTX9ZppQ==
X-Received: by 2002:a2e:9081:: with SMTP id l1mr12154029ljg.81.1591628482141;
        Mon, 08 Jun 2020 08:01:22 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.116])
        by smtp.googlemail.com with ESMTPSA id r16sm279228ljn.106.2020.06.08.08.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:01:21 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: [PATCH v2 3/4] coccinelle: api: filter out memdup_user definitions
Date:   Mon,  8 Jun 2020 18:00:37 +0300
Message-Id: <20200608150038.223747-4-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200608150038.223747-1-efremov@linux.com>
References: <20200608150038.223747-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't match original implementations.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/memdup_user.cocci | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index d15c061a34ab..8621bd98be1e 100644
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
 		(size,\(GFP_KERNEL\|GFP_USER\|
 		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
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

