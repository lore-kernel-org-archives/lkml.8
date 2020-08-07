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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF8FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF90214F1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwP2TF51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHGUKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgHGUKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:10:33 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D8DC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 13:10:33 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a65so2533904otc.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 13:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0CPJ8TX97O10k1WA8Nz1yzDJbecwdHeNRDb3T87/dhc=;
        b=rwP2TF51TdVM6KM7FvBbzn6N+2xMsWCSAsVEeY/3g0sF8fh+N2XuPS9wws4islxelQ
         4hew9G5ONEcACADFvPNiFzLtT0EeFSN/9lq/egiEKfPN3y7CDW//zoTuj0y3KUTltXUC
         e/a6HbEK2gJrblulTNvIpelalM5JVar6q4Rm4RpEZWFHRkMi0L+ds8r601ufH+w4Rr8h
         W9PMxXMknVZHnDLFlPPdZ5ncTce5q/ueENprxqzDwvkC4VE0zTO+JKiEsrimeXJFo51F
         3I3yVuJ1lxLEYmW2XbxxVY0tLiwtPKVnzBHp8GAtfuvPJ2cls3S/Fd/b0U0qt2CGUhJ7
         7xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0CPJ8TX97O10k1WA8Nz1yzDJbecwdHeNRDb3T87/dhc=;
        b=KO1JNNUB7+ZJ8rhIc/BxwJlmIHjtKM4l1fT04Nyli0x/4+V3yOitW8361IdKKYhk2+
         h60L61a6MBBThwzyOz9xYu3Yu3CdB4N0xHXfhW7EEO5SBDBCZ1dFVGn+uZFVpIidNNhh
         hh1T7g+ynOnPHhgASqwPUfn0QNSP7CFsI1jFdE/OSPNAk2Q4Xa0ZRw9ZpCObsCKgFtyf
         tCJ8JP6EcLyxZoV2Q+Zq/b50NxaprgNf4TzIl2bKsKfwvsrzXJZZCIBpxsEMGSazJdgk
         UwENqscmDUIZfiiIn1zIaCUN+6poVey7wPogMvDNn/q6DFB52oOkhOEXixfYuGOIWyqj
         D1fQ==
X-Gm-Message-State: AOAM53078g4ePy21lgyPODKvIW1Gf2BfUVts9RyYCU7Xk9tZJ/xf1e5l
        X01/kLnUQJc1erHHCoSjjYg=
X-Google-Smtp-Source: ABdhPJyu60B90i33U1ZZDCkiDwHpAsMMj4v2uPYHrKxOB/qbmXa4CoU0GkEgEgDSpSN/IsVohmGu6A==
X-Received: by 2002:a9d:6e6:: with SMTP id 93mr13473271otx.370.1596831033097;
        Fri, 07 Aug 2020 13:10:33 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::af38])
        by smtp.googlemail.com with ESMTPSA id s6sm1835794otq.75.2020.08.07.13.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 13:10:32 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 8/8] dyndbg: add locking around zpool-add loop in zpool-init
Date:   Fri,  7 Aug 2020 14:09:56 -0600
Message-Id: <20200807200957.1269454-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807200957.1269454-1-jim.cromie@gmail.com>
References: <20200807200957.1269454-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

summary: no fix here.

Locking review:

ddebug_zpool_init(), like other *_init() routines, does not run under
a lock (that we control).  Unlike them, it runs later, at late_init.
I dont know whether this is pertinent to the kernel panic.

ddebug_callsite_get/put() are called as a pair under mutex-lock for
all 3 callsite users; dynamic_emit_prefix() does its own ABBA-ish LGPU
(Lock-Get-Put-Unlock), as does ddebug_change().

ddebug_proc_show() does GP, ddebug_proc_start|stop() wrap it with LU.

ddebug_add_module() does LU to protect list_add(), HEAD~x added
ddebug_zpool_add() inside that protection.

This commit adds locking to ddebug_zpool_init(), around the loop of
ddebug_zpool_add(), to match the locking in ddebug_add_module().

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9c51f24a9c66..716231a98910 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1187,8 +1187,10 @@ static void __init ddebug_zpool_init(void)
 	}
 
 	/* add-module normally does this, but not in time for builtins */
+	mutex_lock(&ddebug_lock);
 	for (iter = __start___dyndbg; iter < __stop___dyndbg; iter++)
 		ddebug_zpool_add(iter);
+	mutex_unlock(&ddebug_lock);
 
 	v2pr_info("total pages: %lu compaction: %lu\n",
 		  zs_get_total_pages(dd_callsite_zpool),
@@ -1285,4 +1287,3 @@ early_initcall(dynamic_debug_init);
 
 /* Debugfs setup must be done later */
 fs_initcall(dynamic_debug_init_control);
-
-- 
2.26.2

