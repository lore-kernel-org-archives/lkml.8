Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561C3C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACDE20679
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRvkV/ta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389288AbgAQDI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 22:08:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32868 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387758AbgAQDI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:08:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id z16so11251469pfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 19:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q6AVNeT1pWMrAlaKMB6tlkj93n7Ldpl+VE+2EqQtieY=;
        b=tRvkV/taoExE6C8ByO7Owr7eXI6Dei+/H/fsmdc6eD9c2K+CLJ6MCSUVXJd3UvhZ7d
         bKCpViiqvFmWan4uH/0A6gK80Uw8cB70I8Hc4xSmrd10IUI7a48Iezd97tVqUYJOZzqk
         8M5UEMZ+8H9mSEx35scsj+jdlC7+EOF7lxJDP4RaDfwFBNY178zAth18DPdTujmAZT7X
         DgZfGYH0zxVTLHU+C0DsNQnPcVNuRUjAhvd4TGTYUDjy4s6fdhM+2xReGRUkD8rnMZNj
         gv3AIc7HnPs5SQ7zWBlmDw/oYiu29FCwQHJtIUwTToX3My6/QdK7xhdB9Bbl9XrLVbdE
         jGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q6AVNeT1pWMrAlaKMB6tlkj93n7Ldpl+VE+2EqQtieY=;
        b=E6WEV80hxr5+MTky5rX4P8XSR+GvUNt16gPVqeVIkqzZww9JdbydxUc64b6OqfjURD
         2uENmBd5FD6Jk/iDTXj23pqNlghxaGKdOKmFA7kcwpaxhkdTSZsnKyWzH9JYBOPkWfsQ
         NoEyx08u/sRD9HXWBA9fJrpr1STV6wZxqZnZ9/cgKWVc6CZ6yPDfC1WAnSlIhg2wual3
         VFwtWLgGsVbR57IQuRt9pAtgFRaaEsjQgJprHKTPfO/bwWKvEWaBhB09hgxQpxf+CPqU
         v4EzxZsRzop079QM4dXCWTCsSTHeeoNklh15mf7MdHdBhVb7Ym4Tb0+qZh8yhU15vI2o
         Pb1g==
X-Gm-Message-State: APjAAAWmf//C71hQMKM8IN/pPSet2CZtVqimLhtWf7lTOUd76dRnhlkZ
        B693WSY2QJhK1VfSUH/wd9k=
X-Google-Smtp-Source: APXvYqwZoWGPrcyKK1AOWc2AmJCdWiaPb/hXQ47FyUHVdZFuRQyo73LfRyQdGUZN93DToWdmOIgcBQ==
X-Received: by 2002:a62:64d6:: with SMTP id y205mr802682pfb.41.1579230508172;
        Thu, 16 Jan 2020 19:08:28 -0800 (PST)
Received: from BJ08491PCU01.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id v10sm26175168pgk.24.2020.01.16.19.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Jan 2020 19:08:27 -0800 (PST)
From:   Li Guanglei <guangleix.li@gmail.com>
To:     peterz@infradead.org, qais.yousef@arm.com
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        guangleix.li@gmail.com, guanglei.li@unisoc.com
Subject: [PATCH v2] sched/core: Fix size of rq::uclamp initialization
Date:   Fri, 17 Jan 2020 11:06:52 +0800
Message-Id: <1579230412-10476-1-git-send-email-guangleix.li@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Guanglei <guanglei.li@unisoc.com>

rq::uclamp_rq is an array of struct uclamp_rq, make sure we clear the
whole thing.

Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcountinga")
Signed-off-by: Li Guanglei <guanglei.li@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Link:https://lkml.kernel.org/r/1577259844-12677-1-git-send-email-guangleix.li@gmail.com
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 44123b4..05f870b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1252,7 +1252,8 @@ static void __init init_uclamp(void)
 	mutex_init(&uclamp_mutex);
 
 	for_each_possible_cpu(cpu) {
-		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
+		memset(&cpu_rq(cpu)->uclamp, 0,
+				sizeof(struct uclamp_rq)*UCLAMP_CNT);
 		cpu_rq(cpu)->uclamp_flags = 0;
 	}
 
-- 
2.7.4

