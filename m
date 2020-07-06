Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E3AC433E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D96206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ERiKeHam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgGFUSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgGFURe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:17:34 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E34C08C5F3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 13:17:33 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id p1so6500045pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 13:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=miXIw5tlW1kMw3gvoNj0rt2nrDVv5q0ksIbG8jEcgPA=;
        b=ERiKeHamqD13D7iMhoOFZ30HuQH3w4nC4ZdHObpVZKxDE+PFUlDmQIHsKZ4W+5px6Y
         yQ933a3huuc+cXNNWapWLCmjG2kwTad8cwFUgWpT/CryLWTzMMChk+NlRwtzKP86BhZr
         w6Q4Rrq56WYTfoVkcqnQUucNPt+RjpAiK0cow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=miXIw5tlW1kMw3gvoNj0rt2nrDVv5q0ksIbG8jEcgPA=;
        b=YDkvycgcTlSMU2SO6ycTtpz9ArpK97hD8G8WcbY/gy+acUe6gTZWE4w/ei8YMakRVb
         bm4zGljVJTBbN68W3Jq7dq3l7eZLOJp4NW0UoYYp1P1WgOz5bD8rRHcjC3ih1hmS2jlk
         axyghVURFe4MUR13BGfkvVSrJdWF6T1Ykmzv5E4/kCMbDbc06XL1qHYz1zeobgRzqFXL
         F9YOBXx2soKp1os1TTXuvaYgZTIupyeTCon81WrRPoeeZFJa4O9RlGBhUHR8wPKTQigo
         Tqgrk0q03HJ8OCpfIwZXx7fsfZmpUNdj1GWMrt5B6ev44sxPwCpVsVZKccr2lifE6CgH
         Ja9w==
X-Gm-Message-State: AOAM530NUY6Z1OJSyuEnLA1RLjwULp5a5K0JELZ7F0Vntnmm4Xx5MNm3
        BG3+oZDfj0jVS7rIXA+4UoE5Ow==
X-Google-Smtp-Source: ABdhPJzwAOzHVYdk4Dd1Tsm1BHv4WTEImdL0TAdmqz7o1hfTZz1qQHFXOzl5ff5rnBTNrdGfW1qSkg==
X-Received: by 2002:a17:902:b101:: with SMTP id q1mr34450888plr.221.1594066653020;
        Mon, 06 Jul 2020 13:17:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c188sm19973389pfc.143.2020.07.06.13.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:17:31 -0700 (PDT)
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
Subject: [PATCH v6 5/7] fs: Expand __receive_fd() to accept existing fd
Date:   Mon,  6 Jul 2020 13:17:18 -0700
Message-Id: <20200706201720.3482959-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706201720.3482959-1-keescook@chromium.org>
References: <20200706201720.3482959-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand __receive_fd() with support for replace_fd() for the coming seccomp
"addfd" ioctl(). Add new wrapper receive_fd_replace() for the new behavior
and update existing wrappers to retain old behavior.

Thanks to Colin Ian King <colin.king@canonical.com> for pointing out an
uninitialized variable exposure in an earlier version of this patch.

Reviewed-by: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/file.c            | 24 ++++++++++++++++++------
 include/linux/file.h | 10 +++++++---
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 0efdcf413210..11313ff36802 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -937,6 +937,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 /**
  * __receive_fd() - Install received file into file descriptor table
  *
+ * @fd: fd to install into (if negative, a new fd will be allocated)
  * @file: struct file that was received from another process
  * @ufd: __user pointer to write new fd number to
  * @o_flags: the O_* flags to apply to the new fd entry
@@ -950,7 +951,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
  *
  * Returns newly install fd or -ve on error.
  */
-int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
+int __receive_fd(int fd, struct file *file, int __user *ufd, unsigned int o_flags)
 {
 	struct socket *sock;
 	int new_fd;
@@ -960,18 +961,30 @@ int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
 	if (error)
 		return error;
 
-	new_fd = get_unused_fd_flags(o_flags);
-	if (new_fd < 0)
-		return new_fd;
+	if (fd < 0) {
+		new_fd = get_unused_fd_flags(o_flags);
+		if (new_fd < 0)
+			return new_fd;
+	} else
+		new_fd = fd;
 
 	if (ufd) {
 		error = put_user(new_fd, ufd);
 		if (error) {
-			put_unused_fd(new_fd);
+			if (fd < 0)
+				put_unused_fd(new_fd);
 			return error;
 		}
 	}
 
+	if (fd < 0)
+		fd_install(new_fd, get_file(file));
+	else {
+		error = replace_fd(new_fd, file, o_flags);
+		if (error)
+			return error;
+	}
+
 	/*
 	 * Bump the usage count and install the file. The resulting value of
 	 * "error" is ignored here since we only need to take action when
@@ -982,7 +995,6 @@ int __receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
 		sock_update_netprioidx(&sock->sk->sk_cgrp_data);
 		sock_update_classid(&sock->sk->sk_cgrp_data);
 	}
-	fd_install(new_fd, get_file(file));
 	return new_fd;
 }
 
diff --git a/include/linux/file.h b/include/linux/file.h
index d9fee9f5c8da..225982792fa2 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -92,18 +92,22 @@ extern void put_unused_fd(unsigned int fd);
 
 extern void fd_install(unsigned int fd, struct file *file);
 
-extern int __receive_fd(struct file *file, int __user *ufd,
+extern int __receive_fd(int fd, struct file *file, int __user *ufd,
 			unsigned int o_flags);
 static inline int receive_fd_user(struct file *file, int __user *ufd,
 				  unsigned int o_flags)
 {
 	if (ufd == NULL)
 		return -EFAULT;
-	return __receive_fd(file, ufd, o_flags);
+	return __receive_fd(-1, file, ufd, o_flags);
 }
 static inline int receive_fd(struct file *file, unsigned int o_flags)
 {
-	return __receive_fd(file, NULL, o_flags);
+	return __receive_fd(-1, file, NULL, o_flags);
+}
+static inline int receive_fd_replace(int fd, struct file *file, unsigned int o_flags)
+{
+	return __receive_fd(fd, file, NULL, o_flags);
 }
 
 extern void flush_delayed_fput(void);
-- 
2.25.1

