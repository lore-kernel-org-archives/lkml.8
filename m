Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D5BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7832020782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpqMEgML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHYRd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgHYRdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:33:47 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3DFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:33:47 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id t7so11073635otp.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5taqwMO9fu02Eq/oSradLpdwhpBHOZ6HATVQFj48PwQ=;
        b=MpqMEgMLEnoxqDL8uKjES9VCpReXbTw2wlsudnSBtEacpiBd7POKEbWC/GQrA7gb4k
         pAT9VhoN49kguMBMc/Dfrn/RjPxQtEv/EKAxPB+laCe99rvWQPJ+SJmh77rIc0rA84ox
         VhI8MjXg6EJL+xnOXeWeGrpqOj+EBYXgvcOVXzDgLZu+8GXmGtHrCSUDsQC885jbCwtl
         0s532CyEXezwlms0I0Agu8/5Z7NT8GdgD0gqvdvXFktmU4/bcpvEy+KKOYOyczsMaath
         K+XG2jR11B5KlJO1+D5q9OXztcPjWWcqlK+/A7F79BAiyCxHImoDOcW1k6gIHRLJrrrN
         weAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5taqwMO9fu02Eq/oSradLpdwhpBHOZ6HATVQFj48PwQ=;
        b=NpvafiVpJfFFdNpJSso9kVFoP5luzUFmCuCCSuBq9w9C4YTfCiw1dMUusSCTJBtq9I
         I6az7oOwjW8Ta3fRuJv8bPLvZRnHCXcrAt0tYlOS24YFQmvSRIZ0ri0c9Ez3Vjoj89i4
         uiYxl/Z4jvgD3KxXb7CagB2F3F3zsDlPfd+6L9I55i76c2vcQvO+VSLqWWUaTczKp6n3
         0hbOnNxmFy8VlLH0uTOMpYWKQNR2mT7f1GjKiYEs9yMHzgJzXSESWal9PQzWpyQBTEu6
         alv5yIF377YHWeeeH0qkbKGmAbknuirtbsDEvUAgULqmDO6R2cIbVhriIlFOTqkct34m
         IotA==
X-Gm-Message-State: AOAM530p7F8wgO0ykPZSCPccrjX70Si8g10Sd9XpnCaHi1W0WckUbdq6
        D1gh6mpfeFtKq+ER2aD2Rds=
X-Google-Smtp-Source: ABdhPJzf/v9FLdLkQ8Qqn4ayvXLeRhSeZPKx0KiiV/zsZHcibRVzYsbltsUW7u9/74VxE7+m+bDWjA==
X-Received: by 2002:a9d:5506:: with SMTP id l6mr7756973oth.311.1598376826622;
        Tue, 25 Aug 2020 10:33:46 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::c4c])
        by smtp.googlemail.com with ESMTPSA id x11sm3214168oot.0.2020.08.25.10.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 10:33:45 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 1/3] dyndbg: give %3u width in pr-format, cosmetic only
Date:   Tue, 25 Aug 2020 11:33:37 -0600
Message-Id: <20200825173339.2082585-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825173339.2082585-1-jim.cromie@gmail.com>
References: <20200825173339.2082585-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the print-width so log entries line up nicely.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1d012e597cc3..01b7d0210412 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -947,7 +947,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	v2pr_info("%u debug prints in module %s\n", n, dt->mod_name);
+	v2pr_info("%3u debug prints in module %s\n", n, dt->mod_name);
 	return 0;
 }
 
-- 
2.26.2

