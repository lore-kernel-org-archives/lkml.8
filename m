Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049AAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2FB2206D8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PRIjpcg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgHDUcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgHDUcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:32:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6CBC061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 13:32:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b127so36432190ybh.21
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 13:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TE39gsqa8qAtAr57skK2bIVW3cJaqxb5kdkpRE6BXx4=;
        b=PRIjpcg+RHpob503zkgZ/kH0zrL/dFq+o15VbDIE+7fG//gkTUyv+BUYuFJGk77mXH
         J7o0LRArbZY03nboYkobXyq5Mclw1iNcylfxM3oqjztUXa4b16oc9VAe8xlPpDq3VbNL
         HI7knhb8Bd2R6LXwLc4T7PdFbknrVoH3KQ1n0BjGHFivqbIbJQfRFJ1y0AwH6+9NVr43
         HUWdRLf+B2SEM4ZF4dJMT3G/MR6QGRE36f/gVO+YIJZKdCGAn9ByjwNRcb+g7GrstnU4
         +4PcVun0xBJKIGgBUNUyn3FwtjVmpVdQelavHxqvU9qFVlEhe7P2/E9kh/EoaHxvU/jH
         Rtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TE39gsqa8qAtAr57skK2bIVW3cJaqxb5kdkpRE6BXx4=;
        b=P8gTITJndzLv43xCd/2ExeZyEvV6TAcF+0X1glPKROTeh4QOlhecj9ppicRZXF0CKI
         QYbiVQWKp7tztonBzbdRwAHiUB+J9DLiusOfK45AYXW2z+WvJP92DmX3Vumh+Amkdxkx
         CZDJnA3V4icYFRb1krfN5s1aq3fXmCOitMrzHrvuAoAqz8zToFaeDeie9WjP8i8jn+9Y
         IYAcGNuD7DTddco/v8SR9ytOMnZYkIQYWY9uoaVVuUvmjOAq0LKlaTZpxGaqWO+lW6yR
         wVVsEmCuL5Sqrnfw61p1kpABHlO9aRNBY8Tg5gKYgKQ0BWWomT1ReFYatES6HekICIqQ
         pz3g==
X-Gm-Message-State: AOAM531zTFSpf3IUxLXb8G0Bi7mo9+YxK4cL+vsLPV2pdJYEknCUackj
        +lpczs51c4q5X5C1bCThA9+2JCcrz6of3Rcbzg==
X-Google-Smtp-Source: ABdhPJwoK3L7KaN/vfgdTz0aHbC7HLz0oYVW6btJ16u62KFo8LdFftIZhnnFvgmftUX1Ybc35y0qD4s/OLoD5NuXFg==
X-Received: by 2002:a25:d946:: with SMTP id q67mr33939817ybg.423.1596573126838;
 Tue, 04 Aug 2020 13:32:06 -0700 (PDT)
Date:   Tue,  4 Aug 2020 13:31:55 -0700
Message-Id: <20200804203155.2181099-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH] Userfaultfd: Avoid double free of userfault_ctx and remove O_CLOEXEC
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     viro@zeniv.linux.org.uk, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, jmorris@namei.org
Cc:     kaleshsingh@google.com, dancol@dancol.org, surenb@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nnk@google.com, jeffv@google.com, calin@google.com,
        kernel-team@android.com, yanfei.xu@windriver.com,
        Lokesh Gidra <lokeshgidra@google.com>,
        syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when get_unused_fd_flags returns error, ctx will be freed by
userfaultfd's release function, which is indirectly called by fput().
Also, if anon_inode_getfile_secure() returns an error, then
userfaultfd_ctx_put() is called, which calls mmdrop() and frees ctx.

Also, the O_CLOEXEC was inadvertently added to the call to
get_unused_fd_flags() [1].

Adding Al Viro's suggested-by, based on [2].

[1] https://lore.kernel.org/lkml/1f69c0ab-5791-974f-8bc0-3997ab1d61ea@dancol.org/
[2] https://lore.kernel.org/lkml/20200719165746.GJ2786714@ZenIV.linux.org.uk/

Fixes: d08ac70b1e0d (Wire UFFD up to SELinux)
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 fs/userfaultfd.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index ae859161908f..e15eb8fdc083 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2042,24 +2042,18 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 		O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
 		NULL);
 	if (IS_ERR(file)) {
-		fd = PTR_ERR(file);
-		goto out;
+		userfaultfd_ctx_put(ctx);
+		return PTR_ERR(file);
 	}
 
-	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
+	fd = get_unused_fd_flags(O_RDONLY);
 	if (fd < 0) {
 		fput(file);
-		goto out;
+		return fd;
 	}
 
 	ctx->owner = file_inode(file);
 	fd_install(fd, file);
-
-out:
-	if (fd < 0) {
-		mmdrop(ctx->mm);
-		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-	}
 	return fd;
 }
 
-- 
2.28.0.163.g6104cc2f0b6-goog

