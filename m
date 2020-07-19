Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D25FC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 383E521744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxzm9I4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGSXL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgGSXLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:24 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23D9C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:24 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 5so10772698oty.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OdduJRvvO41BBsXIW4nBk8PEuA6Cgs/J61E0o3z8Q+o=;
        b=Qxzm9I4s44cGLSqsfTIsJC+fPSglQdk2B16vQkKCWqjvm1sCV+ZYzUyz7VgmAebkTr
         md97As9FZw0Ps6kaSJZD5mIKRGOL56NzuzcH266k1/ajLgX7nNNGjPW9sOyx4tRE5T9I
         IFSXuwClxkZiWudtbMtgX3puqlb9vWkHgJYYUSIIbti+RAwYjJ1R84vGYHzmaJ0fcoiY
         5sGMjVcLnrqE7y2/05tGR6a89AJnGWuKOAYBcjV5StUAU4gd30SdccVRd12YG6zU0A8A
         Nu+TjO6z1rVqu571vY1/TQAg4HTfcO0IS1XGvMgRxriAgSQbuUdt7FnvHpGoDTYRvinF
         oKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OdduJRvvO41BBsXIW4nBk8PEuA6Cgs/J61E0o3z8Q+o=;
        b=e8ofIkYBiX/79zfmXadFLUQl8flHyG43/jWmiGq/gJTzMc0KUlK/w9jeSoI1sVb9YE
         j59FmBaZYq3lL5icSpUwicJMG4BsDrx93vUWfC9eBsEs5ssyJmYmhwAYZAWzVpeIZa3M
         eQEFehV89qMbdr6j4KMVskJiMvx4nGKPoSHJOgmOxl56HMdMo3RFpJ6ws5wLwU8n0WF8
         s1lKO8pkU7Gn7nJhGEK1GJdiXl3vYt0wfAT4z1vuz14nfLHmDYxRMFxMnRt9fIDu90xn
         H3Y1/u7jGmZ2IOOkdVs3Wkt8xFKxr6GyCI3vtcqMyzgmedYiGxNVCU7esGs0vKFF+37j
         /1wA==
X-Gm-Message-State: AOAM530rvTAk3s5M0VwitHXSKusCyF9llkRJjskYvSZUxavewiCaftdd
        8lCjq0Py0KbaicjR8AtoxDvejqrfhTE=
X-Google-Smtp-Source: ABdhPJxeMYavsSkyg4nQCUc6xX8uMG8axiPAKWcOfN00LVs26/Y2lLO4rsf/HvUDCLzNsoLLpoK8HQ==
X-Received: by 2002:a9d:424:: with SMTP id 33mr17070162otc.76.1595200284143;
        Sun, 19 Jul 2020 16:11:24 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:23 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 03/18] dyndbg: drop obsolete comment on ddebug_proc_open
Date:   Sun, 19 Jul 2020 17:10:43 -0600
Message-Id: <20200719231058.1586423-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4bad78c55002 ("lib/dynamic_debug.c: use seq_open_private() instead of seq_open()")'

The commit was one of a tree-wide set which replaced open-coded
boilerplate with a single tail-call.  It therefore obsoleted the
comment about that boilerplate, clean that up now.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 321437bbf87d..2989a590ce9a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -853,13 +853,6 @@ static const struct seq_operations ddebug_proc_seqops = {
 	.stop = ddebug_proc_stop
 };
 
-/*
- * File_ops->open method for <debugfs>/dynamic_debug/control.  Does
- * the seq_file setup dance, and also creates an iterator to walk the
- * _ddebugs.  Note that we create a seq_file always, even for O_WRONLY
- * files where it's not needed, as doing so simplifies the ->release
- * method.
- */
 static int ddebug_proc_open(struct inode *inode, struct file *file)
 {
 	vpr_info("called\n");
-- 
2.26.2

