Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A9DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221162074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CggemrQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgFEQ17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgFEQ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:27:47 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B9CC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:27:47 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id b18so8077202oti.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M4Zj1NyIo3A3+P7k3my4X+Y2SafDKAk7x+LNWA9+5Sk=;
        b=CggemrQbWUkbHidqgNu3yAuE+Q8XAe4PHdBIxXUMHCMtVUtXVt9WhsZmugXWSXjI2N
         QIVjnS/hSqVQ8UQjhfKZVCYyh8GGun7YMFm85pWqC/mQ+PxpVESdL8dNccX+hNif28oE
         eFpQqWRDAvPDb1vdJVdEVJqE2kazftxboi7t3Yk4+aiaOGeIARVxe4AGI390j3NIqIuz
         rKEkydCTJUbVCojJ0TOr9M37owECUYiVaTZIahA3SMBi/G/45MvjqMSY7cptGlo7Se2u
         Qo4GD4xdS3nnFxIEYvaQsN7A/NP3bUf0WFkyXaJ0ONTZbiofK9Hp6bHyYyfZYyyyLWiY
         qiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4Zj1NyIo3A3+P7k3my4X+Y2SafDKAk7x+LNWA9+5Sk=;
        b=S/CFwxT1oUUKd1nvX8L1HFwtwV/AOfS2+yvPfSxYY7x0HRf9YBC+SMYGCY3oOwCMB2
         gu9cb3N3IC/iZh9PM4lRuH5vp4tnhzjMebAqAfMEsbKvMdH6RN+kyi6gdcIXO1NanASa
         LD06qbqBgHk5lN4BxHQXe31pQX0cJhwTheKlj7spfLJ53CrBHICyJxNjxHh5ifQGuV0J
         058Ak5oJIEC0Ygsn3KqweZL7rXcKRQVlD4/qRDQfUnvD1YENJutYgQdLw6pLsultgXoA
         EEGFFtzgajTw0o+wSlf2K/Ul3AsNDWjCFXLUc3fjIP9N67C3vGvHOF/ZBTpCKKWcT065
         CuaQ==
X-Gm-Message-State: AOAM530JPc48065mo9mE9i3dIykkIJOq4T084+1CeNpPMHi9zFFiI5GA
        XrkTgm2DyNS2hMw3girEo3/kdvnt
X-Google-Smtp-Source: ABdhPJwJChPsKSNetPGGrTSI9HjAMM6B+REkcSkDtID8k8omSqNyzlkmWseXndmSwXUD3GeuA/jGmQ==
X-Received: by 2002:a9d:459c:: with SMTP id x28mr8431621ote.18.1591374466545;
        Fri, 05 Jun 2020 09:27:46 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:27:45 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 07/16] dyndbg: make ddebug_tables list LIFO for add/remove_module
Date:   Fri,  5 Jun 2020 10:26:36 -0600
Message-Id: <20200605162645.289174-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loadable modules are the last in on this list, and are the only
modules that could be removed.  ddebug_remove_module() searches from
head, but ddebug_add_module() uses list_add_tail().  Change it to
list_add() for a micro-optimization.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 08b8c9c04a17..494856c04fa7 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -896,7 +896,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	dt->ddebugs = tab;
 
 	mutex_lock(&ddebug_lock);
-	list_add_tail(&dt->link, &ddebug_tables);
+	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
 	v2pr_info("%u debug prints in module %s\n", n, dt->mod_name);
-- 
2.26.2

