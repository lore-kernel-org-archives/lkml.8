Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C72CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EFD24676
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHewCuWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgCBNEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:04:52 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:50571 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgCBNEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:04:51 -0500
Received: by mail-wr1-f74.google.com with SMTP id p5so5729500wrj.17
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 05:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j3aDuvHmNNb8lZp62OUl5ijcLNjosW5sWfAg0aQm8tI=;
        b=vHewCuWK7XwWw+VRmDWzRLkq61RHy9RnkX3i1kaJ8fw0M0PseejKlj/CZ68p864I5Y
         N9SGMmkirAc/jgX9ro369d5IupRgP9uXpmgTu6qWv8iSKdgEsMlJCz2VRmtvOWTC/16r
         grP1CWYBHUL0E9jvxhIWnmwDxoKIWwJkXclff8CBxM+bx6bGzs+trjRunmDlTB2f/ISR
         4gaf0upeQTTq1XGdTweSwITQOJ96unRsDb0Lq9uWCv3/Qh1ver1HInXxiCT1JaF/IrcZ
         6+l3xZm5rOWOQFpx9N2kSsUuQHMUqx615nH6Ov9dq4D2fJQYRKhTRasXzzX8hyCASUJc
         Yr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j3aDuvHmNNb8lZp62OUl5ijcLNjosW5sWfAg0aQm8tI=;
        b=nFZ0cDXnqB5nQoc5LKL0v7JMnkP6vwIDe5JqpkDysSg79s7nIepBtO8yvOyX0x9Bk5
         5hRjC4dAjOuMI9TvtO9L5Eo2ScDL2g4htJxpALk1UmvW3uQDMH5V4qSEv8nw0qFMchG5
         xFFsLiOQyaiOyzeehJOUktLE9zEiwmbdPTqf/12wQFwhU9CGqMZcIxzXuShbeR5e2WEw
         R4nDP7FEPKGcBvkJS8ZqvHIK9A8Jw4GdgsYcXd2RnnvYma45+Aei84jWBRAxTIbmyRGx
         9gjRjUuD70kuTaee12t0zE22shTI9YCxmvuPI2LSVCPzhiEbiqOx3DcqEt0jD9GpDNvG
         VNCg==
X-Gm-Message-State: ANhLgQ31DRkJ5gwGHvkOgr/mgVncBQ2kdEqexGFl+g6zgzguLEen//3N
        Ry3hRy78k41TJ2Jh25DmZC2YK1sWuoo=
X-Google-Smtp-Source: ADFU+vvhEHHYZJ73Yy0CimVvZXBOlQbztjelV2mMGDGzouPCkzbXetIp+8NAtW54Y5Fi1/JwnKRZO766kE8=
X-Received: by 2002:adf:ce12:: with SMTP id p18mr5676203wrn.88.1583154287784;
 Mon, 02 Mar 2020 05:04:47 -0800 (PST)
Date:   Mon,  2 Mar 2020 14:04:30 +0100
In-Reply-To: <20200302130430.201037-1-glider@google.com>
Message-Id: <20200302130430.201037-3-glider@google.com>
Mime-Version: 1.0
References: <20200302130430.201037-1-glider@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 3/3] sched/wait: avoid double initialization in ___wait_event()
From:   glider@google.com
To:     tkjos@google.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, arve@android.com, mingo@redhat.com
Cc:     dvyukov@google.com, jannh@google.com, devel@driverdev.osuosl.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_INIT_STACK_ALL enabled, the local __wq_entry is initialized
twice. Because Clang is currently unable to optimize the automatic
initialization away (init_wait_entry() is defined in another translation
unit), remove it with the __no_initialize annotation.

Cc: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alexander Potapenko <glider@google.com>

---
 v2:
  - changed __do_not_initialize to __no_initialize as requested by Kees
    Cook
---
 drivers/android/binder.c | 4 ++--
 include/linux/wait.h     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index a59871532ff6b..66984e7c33094 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4827,7 +4827,7 @@ static int binder_ioctl_write_read(struct file *filp,
 	struct binder_proc *proc = filp->private_data;
 	unsigned int size = _IOC_SIZE(cmd);
 	void __user *ubuf = (void __user *)arg;
-	struct binder_write_read bwr __no_initialize;
+	struct binder_write_read bwr;
 
 	if (size != sizeof(struct binder_write_read)) {
 		ret = -EINVAL;
@@ -5026,7 +5026,7 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			goto err;
 		break;
 	case BINDER_SET_MAX_THREADS: {
-		int max_threads;
+		int max_threads __no_initialize;
 
 		if (copy_from_user(&max_threads, ubuf,
 				   sizeof(max_threads))) {
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3283c8d021377..b52a9bb2c7727 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -262,7 +262,8 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 #define ___wait_event(wq_head, condition, state, exclusive, ret, cmd)		\
 ({										\
 	__label__ __out;							\
-	struct wait_queue_entry __wq_entry;					\
+	/* Unconditionally initialized by init_wait_entry(). */			\
+	struct wait_queue_entry __wq_entry __no_initialize;			\
 	long __ret = ret;	/* explicit shadow */				\
 										\
 	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
-- 
2.25.0.265.gbab2e86ba0-goog

