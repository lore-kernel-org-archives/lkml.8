Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA69C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA620206DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cchpNxvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgFEQAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgFEQAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:00:22 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4194C08C5C6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:00:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 185so5287601pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4Jp8V2vtmdrR38aosyp2kD5AbuF6V2trCHVRLUeDwY=;
        b=cchpNxvA0xpONzd85G+E8YLPZFoR4zksHHRMe5aWZarAbGKpKyu6dDRimBMHgmGA7N
         JoC40b06lY4/jw+eY7MTR3eraaJeX/iiwPO0uRofyRj0Hz0kLJzN89MMa+F2YEaA43wS
         DXo3Q1tzAkc/6asUeayOWa6gy7wC4YQ4nIoTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4Jp8V2vtmdrR38aosyp2kD5AbuF6V2trCHVRLUeDwY=;
        b=npg8x9LGt8xIwUuJqX3owu1RQbUSc2/2vJJmHLQFmRw5xK6lpvJTwmALHT31aV5a5b
         h7RhWEhW/n+Vd7JxdVV7v7jkMfCyY8UZhubmpSGHnLRtXhr1m20iAJnWxDv2ewOd4WGM
         ITO8Psue5hOBvxw3B2NcKPJRZRiaYmj5y733YQG1xgO6xjitZbdo+jhZT4VG70quxevj
         7mDcB3dOvWm6uemWmIMViWHrD6b9N+ywz+iyoN4/vlXjxjqEx8GcHpF2s8frFJ3jLAq/
         5onbRfxxqRwT4WyY4OYX1OK/0jp+XP0vMDbgIocLRBxKmBX1wk3drpid8NgkoWwE1kjO
         34NA==
X-Gm-Message-State: AOAM533kM7HIDfgPXxbeeB4F4YrGnyb19KmovpbtNLHwHV8zvvTBH+pG
        VWq9lELOEY0sOQDoHJ5lKz5e2A==
X-Google-Smtp-Source: ABdhPJyrCE0Gd+IXLs5lZzWREE1ngpf/UpYSzyLYFpEtLKYX9E+q8pV6MVGqlhkbEGEB+mlSw7i9hg==
X-Received: by 2002:a62:2944:: with SMTP id p65mr10482809pfp.280.1591372821201;
        Fri, 05 Jun 2020 09:00:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3sm8058888pjk.10.2020.06.05.09.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:00:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] exec: Change uselib(2) IS_SREG() failure to EACCES
Date:   Fri,  5 Jun 2020 09:00:11 -0700
Message-Id: <20200605160013.3954297-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605160013.3954297-1-keescook@chromium.org>
References: <20200605160013.3954297-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change uselib(2)' S_ISREG() error return to EACCES instead of EINVAL so
the behavior matches execve(2), and the seemingly documented value.
The "not a regular file" failure mode of execve(2) is explicitly
documented[1], but it is not mentioned in uselib(2)[2] which does,
however, say that open(2) and mmap(2) errors may apply. The documentation
for open(2) does not include a "not a regular file" error[3], but mmap(2)
does[4], and it is EACCES.

[1] http://man7.org/linux/man-pages/man2/execve.2.html#ERRORS
[2] http://man7.org/linux/man-pages/man2/uselib.2.html#ERRORS
[3] http://man7.org/linux/man-pages/man2/open.2.html#ERRORS
[4] http://man7.org/linux/man-pages/man2/mmap.2.html#ERRORS

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/exec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d..30735ce1dc0e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -139,11 +139,10 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 	if (IS_ERR(file))
 		goto out;
 
-	error = -EINVAL;
+	error = -EACCES;
 	if (!S_ISREG(file_inode(file)->i_mode))
 		goto exit;
 
-	error = -EACCES;
 	if (path_noexec(&file->f_path))
 		goto exit;
 
-- 
2.25.1

