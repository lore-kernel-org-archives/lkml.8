Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66FCC83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC6D20730
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UN3MlWNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgD2Cbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 22:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2Cbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:31:38 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A8AC03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 19:31:36 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id h1so1029353qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 19:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WsSQ4el//Y+73KDhxO8BeZ1dCh/HLj2RZlsq36dRgcM=;
        b=UN3MlWNwt95WQYace+eSywTdugcKroUN4Rd4NIhK+DFYyrDN8XkL//M3xB36wTSsv6
         CxaSgj15LnjkemeN+zYX8X989x6bk/g2OIjPhWWm2M28gV94gJklXPGiyptdOYM9EgTm
         8MzkmI90JUtviXhr+Au/1KgR8bR+pp3Xx+3fifJsP/iNaFjalBpc5/Rz1AA3Ym4StixO
         e9O7YpChBZnl+h0Qe6CjS6qzLHuDAegMNWajom+8Z7TPYlEU9sHbnK5iNXL0yOdeEUca
         DplJ4WvwsA074Kv3xkzisUWar4asmsgH5DVpf4KN7Z6mO8xSxAsUV8WmdLTQ/l6snGz3
         E7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WsSQ4el//Y+73KDhxO8BeZ1dCh/HLj2RZlsq36dRgcM=;
        b=qHt8BKSycznpZrXmx+BBbTWPi6jpKKiJZli+nxq28Vdvf4vd/fqFm+bTLqJ+OTJkK0
         QOnBXU79O3vfeGarjyDN1AKY/c8jyX03LMhXRFdq5L/N2NYMMr7cja3vC59JMeUMtxSZ
         VtcL2hbtBuL246lycZ+VQUNzAEzPESpmnlSZ/HmxBtRyIZL4Ez04hR6383SisCNj5hft
         mtsQHmTplSmANEeneTfY9KixkjwVOLSAEopyPcaaK5SezZ37Sh7PXB/7H2/BcJ4N77Gb
         7cC6/uEHGIRRyokOaIZz1X680SZQ1O467mDLC5Q6Cz2B9c55ArK9MXE7+c21bG9pRSwp
         8YFw==
X-Gm-Message-State: AGi0PuYYGDaUjRHjDyBD5wyMALHt1Yr/3wjhAiW0Q+Dhfk8gOgkCsFR3
        b5tUSoBbx1uBQolAMFgx1Ykvl2JGdA==
X-Google-Smtp-Source: APiQypL+uTWlVZWQKpSDFQTh731+sLTLvg0x4UaDIiB+KECbx00T+FVEJZxwGuXSKvn0BGAlyzOjd/5Caw==
X-Received: by 2002:ad4:5a06:: with SMTP id ei6mr23544919qvb.70.1588127495938;
 Tue, 28 Apr 2020 19:31:35 -0700 (PDT)
Date:   Wed, 29 Apr 2020 04:31:04 +0200
Message-Id: <20200429023104.131925-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH] epoll: Fix UAF dentry name access in wakeup source setup
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        NeilBrown <neilb@suse.de>, "Rafael J . Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ep_create_wakeup_source(), epi->ffd.file is some random file we're
watching with epoll, so it might well be renamed concurrently. And when a
file gets renamed, the buffer containing its name may be freed.

This can be reproduced by racing a task that keeps adding and removing
EPOLLWAKEUP epoll entries for a fifo with another task that keeps renaming
the fifo between two long names if you add an mdelay(200) call directly
before wakeup_source_register(); KASAN then complains:

BUG: KASAN: use-after-free in strlen+0xa/0x40
Read of size 1 at addr ffff888065fda990 by task wakemeup/2375
[...]
Call Trace:
[...]
 strlen+0xa/0x40
 kstrdup+0x1a/0x60
 wakeup_source_create+0x43/0xb0
 wakeup_source_register+0x13/0x60
 ep_create_wakeup_source+0x7f/0xf0
 do_epoll_ctl+0x13d0/0x1880
[...]
 __x64_sys_epoll_ctl+0xc3/0x110
[...]
Allocated by task 2376:
[...]
 __d_alloc+0x323/0x3c0
 d_alloc+0x30/0xf0
 __lookup_hash+0x61/0xc0
 do_renameat2+0x3fa/0x6d0
 __x64_sys_rename+0x3a/0x40
[...]
Freed by task 2379:
[...]
 kfree_rcu_work+0x9b/0x5d0
[...]

Backporting note: This patch depends on commit 49d31c2f389a ("dentry name
snapshots"). Maybe that one should also be backported as a dependency for
pre-v4.13? (Sorry, I wasn't sure how to properly express this as a "Fixes:"
tag.)

Cc: stable@vger.kernel.org
Fixes: 4d7e30d98939 ("epoll: Add a flag, EPOLLWAKEUP, to prevent suspend while epoll events are ready")
Signed-off-by: Jann Horn <jannh@google.com>
---
I'm guessing this will go through akpm's tree?

 fs/eventpoll.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8c596641a72b0..5052a41670479 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1450,7 +1450,7 @@ static int reverse_path_check(void)
 
 static int ep_create_wakeup_source(struct epitem *epi)
 {
-	const char *name;
+	struct name_snapshot name;
 	struct wakeup_source *ws;
 
 	if (!epi->ep->ws) {
@@ -1459,8 +1459,9 @@ static int ep_create_wakeup_source(struct epitem *epi)
 			return -ENOMEM;
 	}
 
-	name = epi->ffd.file->f_path.dentry->d_name.name;
-	ws = wakeup_source_register(NULL, name);
+	take_dentry_name_snapshot(&name, epi->ffd.file->f_path.dentry);
+	ws = wakeup_source_register(NULL, name.name.name);
+	release_dentry_name_snapshot(&name);
 
 	if (!ws)
 		return -ENOMEM;

base-commit: 96c9a7802af7d500a582d89a8b864584fe878c1b
-- 
2.26.2.303.gf8c07b1a785-goog

