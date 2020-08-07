Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1B1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A708214F1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIblyCcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHGUKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgHGUK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:10:26 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37ABC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 13:10:26 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id b22so3003367oic.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lvIDYiUK7gDXV/zoUhxO0yQ8O7iWJyBFcYJ5t8V1huk=;
        b=RIblyCcWm3XMmObGEHwf+cJaXejinI6o+2m1Xnq/xVsONJsnLbjyUK3//3a8N3AOPC
         ccq5fS9tCG/gB4jqyjgPBEWzUXIa6/WbiwKAFgP/6Ecv++fH0C7TRMSVTScMzde5wZXa
         bK3FoUFve7YXfkZOzHPVgmO+EeTkf8wOATCO5qEShac+Mw4adFGlTw2J39bQnPpcsz7O
         3pF6g3RU+5beqzac78h/7296kopR0Eyssc3P36+pmn96qvnVBdbG5OpOkEWqHQBdJh9D
         zGWMPoGqPJ2yROufR898f9SU7fKYpYaS0jVZM5GujYQxbJrbnh8BQwEpZ87qLcNKYxoB
         stdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lvIDYiUK7gDXV/zoUhxO0yQ8O7iWJyBFcYJ5t8V1huk=;
        b=kWzfpFHfypRSDcYjcJkkYwgs3vrhFoHD5ir6hfMRPpo/Dy5s9CAFZ9AzMQbgye2zCN
         yw9uDeKKS/w/S//zYBupTTiYgWVkBwAi1w9jy8unXhf0vnmto78s6ZJ1l0kZCJ5yEJ2i
         Px/Wv/9D8HhXZ3SebCUfQm3GNJbAk+04x7X+Pa5+5Ks6V+HXRrp343UaTGdRWkrcnTk7
         Ref8dKHg6dUhF7g++cHdHx4PkGv0gnpq9vi334a1ARyX/qkfRgPkhuWtazcYYECIVcgS
         FJIEzpPVHzza3wK+CEUGyFkOIeGX3wDk2JF88MtG/HeJZNSZrsxeW73eOBfgGlPYfirq
         WBhA==
X-Gm-Message-State: AOAM531zRFHVgMwgqlwli5ZigosnqLDRC7/afP3uJuw2Ukp+96fmhQ2L
        vmFiKK7ENIkHCQyDwkvjGno=
X-Google-Smtp-Source: ABdhPJwtzIVsGnKBN1nBTxbJZnx4CqFfYtGaOdSzgidjW9M3RpjbUZUs7YmoVYnN+2svBegF2lHf8w==
X-Received: by 2002:a05:6808:117:: with SMTP id b23mr12749205oie.100.1596831026211;
        Fri, 07 Aug 2020 13:10:26 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::af38])
        by smtp.googlemail.com with ESMTPSA id s6sm1835794otq.75.2020.08.07.13.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:10:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 6/8] dyndbg: ddebug_zpool_remove
Date:   Fri,  7 Aug 2020 14:09:54 -0600
Message-Id: <20200807200957.1269454-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807200957.1269454-1-jim.cromie@gmail.com>
References: <20200807200957.1269454-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add ddebug_zpool_remove() to undo ddebug_zpool_add(), and call it from
ddebug_remove_module().

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 049299027fb3..102f47b2a439 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1007,6 +1007,18 @@ static void ddebug_zpool_add(struct _ddebug *dp)
 	zs_unmap_object(dd_callsite_zpool, handle);
 }
 
+static void ddebug_zpool_remove(struct _ddebug *dp)
+{
+	if (dp->site) {
+		pr_warn("zhandle shouldnt be mapped now\n");
+		zs_unmap_object(dd_callsite_zpool, dp->zhandle);
+	}
+	if (!dp->zhandle)
+		pr_err("zhandle already cleared !\n");
+	else
+		zs_free(dd_callsite_zpool, dp->zhandle);
+}
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -1104,6 +1116,13 @@ int ddebug_remove_module(const char *mod_name)
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
 		if (dt->mod_name == mod_name) {
+
+			unsigned int n = dt->num_ddebugs;
+			struct _ddebug *dp = dt->ddebugs;
+
+			for (; n; n--, dp++)
+				ddebug_zpool_remove(dp);
+
 			ddebug_table_free(dt);
 			ret = 0;
 			break;
-- 
2.26.2

