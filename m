Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED8DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECF3208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/f7u+I3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgFQQ0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgFQQ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:26:03 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9801C061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:02 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id b8so2313287oic.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OdduJRvvO41BBsXIW4nBk8PEuA6Cgs/J61E0o3z8Q+o=;
        b=u/f7u+I3UHeSeczXb9UjYMNwhihKwe21V1jpUrocCQyys+f5hQuXT8gw9OwfZTxvw4
         Lz8e7l57lrpnlvZrE14E3Hr6mzdFdkKMvC4hHmzRuP0YAm17AidPHY+K8NqzYGHONx0A
         EPOqLRLY5mngZ+3A+CZOt1qvjcEKVvv3fz9rtP5aqYMpBgkfGim3Hw56BezLBIrytxj1
         8qQjrO4oy3GIiLq1aQPiR2kkmiOr5Cacj9R06NU0+7dGxDRPpYYV8TXJEsxB9pTzXNms
         CJRP5KAKLHhtN6cMSLha0dc7rYoMkixPaXYO3Bpv7b0v39pAgZGkp3Td1SAH3n2LutRT
         /hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OdduJRvvO41BBsXIW4nBk8PEuA6Cgs/J61E0o3z8Q+o=;
        b=jRwm7ubWeuhmSNoJj8Q+bzRhh1UM8v4EsItANDpN/tqTg61d0r0QJ6zDxAWvNy3tH8
         HMXgpcR5C2DxL0VDv6C43nGUQ1sXydG4hGrxKVjlzNvk+kDJolq106ZYjGlAmvp52sED
         fJp/oZ4p9whdtJd9yHpXUUDumye2mSvFt3lldjZQXCcTiE0K2Z2jY3tbhxdN7oUj9lFX
         TsGgDyaHbUZYBn3fksjatXjc0aMyOQdh0WChuKNh/ydxck+coAFh6bONjLK7wq8UtxxE
         E6op5zXh66PVdzauZ/UTR0Rfr/+DRLuxH+xY+jPg/lA7s1ET3P1/VVS3N4Hm4M2a91jC
         M0kg==
X-Gm-Message-State: AOAM533pmUdRUI1GV1F+lyKG6f/5iO+g11RhLgEIP3tVPuZI3+yKujaL
        SOhmmB7vy3AwE/abO7nkwGc=
X-Google-Smtp-Source: ABdhPJzM7AC+WA0kgNlxOA0ntITJttE5bUSNXgKseRcySCaFK+MW0Nwm4qfPduAQRmY2GgkIYwpWGg==
X-Received: by 2002:aca:650b:: with SMTP id m11mr8217337oim.158.1592411162010;
        Wed, 17 Jun 2020 09:26:02 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::ae4b])
        by smtp.googlemail.com with ESMTPSA id h7sm95877otk.48.2020.06.17.09.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:26:01 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 03/21] dyndbg: drop obsolete comment on ddebug_proc_open
Date:   Wed, 17 Jun 2020 10:25:16 -0600
Message-Id: <20200617162536.611386-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617162536.611386-1-jim.cromie@gmail.com>
References: <20200617162536.611386-1-jim.cromie@gmail.com>
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

