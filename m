Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F8DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4122409B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 18:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t42S1hKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgFTSIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 14:08:09 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:42426 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgFTSIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:08:04 -0400
Received: by mail-oo1-f68.google.com with SMTP id 127so2543325ooc.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OdduJRvvO41BBsXIW4nBk8PEuA6Cgs/J61E0o3z8Q+o=;
        b=t42S1hKqx1uPIa5i/PCqezgaJiae2kZhx1XF+7nlwDDSqyenwp5utdNDXj9zi1cEYi
         HdzK+aV9UrOsh6ijoscRVA663sV9O+0TPZCYMvhrWYVmA1/6dnEtpTQUtUkrloRaLfD0
         cDup18W1HcVeMyXNxS1z8sAgU23OGCjaWptTZwrZwXhtjjoXuU2P3rYLMSz25IfeZRKk
         8ieFU/n9XdgCN1LF3ok1ztxt5GO4lyTI8WjuATO9/D46FFDQ5Va00xDT+9BN81TGxlym
         BIAJ+toPt8Ee8XJrhTW8ijbnbeuhrtAU4xnR7qVjZM16q3nrQvEg4s4HX864DXsB3oxF
         uaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OdduJRvvO41BBsXIW4nBk8PEuA6Cgs/J61E0o3z8Q+o=;
        b=mrvCBG6vyh1PgaymWXJap0ysp99NSIUFXwd6nn2R9NzCyR2P8FY8yeC6mOV7K5oTI+
         QPNOrYo/6hC7A9oDIZ/bNy1NJ012ly8Mbrk7OOj4tQ5V1E/msRTLdTaamBA0FGXXy/e/
         BQFafZ3UbUHcKvBljNjRdYAfmUNeAo1yYXyurE5SUWzRzkNsRmc6xmv2lfVk0g217Lmd
         UT1jGQmGP3fzl3ck83pOPEUHjgRqYI7JTks/i3EX19bZtYnSiPr0vXsz/DC0yFUgX5YT
         cdXlnMqN7IKDOQmVE9V8/4Ld0tdvM+TgjbDQegHf0qfartGwcWMzhGuaL68F+vRRT856
         wvew==
X-Gm-Message-State: AOAM531UpEyGSzc8rM1UhHyXfW2Z6ZAZEE5vdp2LxAQ8vKQFn9kcl5Aq
        FLQ/a1Y+iQkK8LrFQ+UnW0U=
X-Google-Smtp-Source: ABdhPJyi5wv+RJKT0xcCCA84f80ZzcQfjXPjrBIIT0grg/KuJdAn1b1FV/6liBcSiS0LNM23olaMTQ==
X-Received: by 2002:a4a:9528:: with SMTP id m37mr8242878ooi.85.1592676423569;
        Sat, 20 Jun 2020 11:07:03 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y31sm2077901otb.41.2020.06.20.11.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 11:07:03 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 03/17] dyndbg: drop obsolete comment on ddebug_proc_open
Date:   Sat, 20 Jun 2020 12:06:29 -0600
Message-Id: <20200620180643.887546-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620180643.887546-1-jim.cromie@gmail.com>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
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

