Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B457C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EC421548
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AssCNT+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgFQWDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgFQWDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:03:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14184C061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:03:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh7so1548618plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 15:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7bw5q/TJxpqMicrHyIFon0t9gt+svhVPDuc7AUFnrI=;
        b=AssCNT+fl7FZXIZEydCky+FoEabK9WHSRC/Cz7t+GsLm7aO2UJ/YytOxHd1B0j1e+l
         XnLm1Rt+qfp2EUmGG/yFhjq91D26f7ku2eo0bUwGuEdGWnmwt6HPJOj85Snm44Eef3sC
         VVnAeX1Tp5FyYfkxWhsd8A7EzPvh9OS4GeLdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7bw5q/TJxpqMicrHyIFon0t9gt+svhVPDuc7AUFnrI=;
        b=tg1SOTQgmWgFJ4ZgUoDH/27c7KIffzIGDCTBkjv3P1XPaA3ojckeaHWmuwdnxVA8mv
         vU0QJvXU2y9pT1gfugGBrxzx3g7IQbUd7vgI2FkXqKstP0/1lG0e5ZsgXHwlXqrjHf/p
         XK5Kq9jU7BeWDEi75gWt9/QaJXpGanZgjGzrR7sUsNCUVXlXwRyhD9+Zy1v0MBol6SB6
         LHR6dj6LlUhSt36RAHl/5iGhFtzDojKdRTmYIWgXawBCsmNBqRcQKT6UstFpu5/dLm9u
         5pgslDahyaNhAIki1IyfgPKWZNczb9/Vmpr5yxPmfRFvce04MZgkxBrWO3+u5hjmkJl4
         IRfg==
X-Gm-Message-State: AOAM533x6o5ufpUMkoPD5Ckqgk4TaqKgu/4JT3lDfHunSO701W8M/qvF
        ettOeAfjeMnoAWSRmD3ff8Q2iA==
X-Google-Smtp-Source: ABdhPJy8S/6IprS//E4loSZ1ZgKk4AjU+iw9QdwwDUrpFc38iJU+1J4kMZ7xNS+1rFNTzrhm1LjJ3w==
X-Received: by 2002:a17:90a:f3c4:: with SMTP id ha4mr1155509pjb.18.1592431411577;
        Wed, 17 Jun 2020 15:03:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n24sm461968pjt.47.2020.06.17.15.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:03:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v5 4/7] pidfd: Replace open-coded partial fd_install_received()
Date:   Wed, 17 Jun 2020 15:03:24 -0700
Message-Id: <20200617220327.3731559-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617220327.3731559-1-keescook@chromium.org>
References: <20200617220327.3731559-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sock counting (sock_update_netprioidx() and sock_update_classid()) was
missing from pidfd's implementation of received fd installation. Replace
the open-coded version with a call to the new fd_install_received()
helper.

Fixes: 8649c322f75c ("pid: Implement pidfd_getfd syscall")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/pid.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index f1496b757162..24924ec5df0e 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -635,18 +635,9 @@ static int pidfd_getfd(struct pid *pid, int fd)
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = security_file_receive(file);
-	if (ret) {
-		fput(file);
-		return ret;
-	}
-
-	ret = get_unused_fd_flags(O_CLOEXEC);
+	ret = fd_install_received(file, O_CLOEXEC);
 	if (ret < 0)
 		fput(file);
-	else
-		fd_install(ret, file);
-
 	return ret;
 }
 
-- 
2.25.1

