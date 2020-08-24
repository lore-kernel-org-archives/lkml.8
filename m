Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA586C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA7520706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHXM7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:59:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46206 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHXM7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:59:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id v12so4213274lfo.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W5HL+cgbyd5hlbjzKpKxBvA+k++FA2lfyWsBbCMnFKc=;
        b=Hm2zGjlV4rynFwEFXH08691PXEOeTE2tUmy49PbifcMXEunStutA5EqQMM8TWTa0UF
         8MJ/D/HVNzEdtuc+aVKtcQX3hX06N1dYIJ1a4agMwvLUjX2uiRMSFW5s5m7e0lu+7UY7
         40dlMfecHaVFof33NLJ24eNH3NqkoUKK67KvhjJ6dXNVlYGuB/ygZKVNobcAhW2EjbcS
         Ww0lJqfPn7JPDfQA8KMMrLeiay5U0QbgqOumQYfRJhWpPwccqoLWYZsXC5P3o+ljRGej
         8R47uDvPDrb4yJGQxZV+D3I+8U5xvKZB74fQBU4qap+iERCGobw6nN3OhS4NN+WcAfj4
         MNgw==
X-Gm-Message-State: AOAM533dwdkIEsPgvfKUdduxez5w2RTqI5j4zOhhfi4rMkrKbTn8ZT43
        7+jKUOzYLjTpWXQ8juXPNCkaD35MwL0=
X-Google-Smtp-Source: ABdhPJwz0y4ts8QHbiQ78bY5sR+pcbAxdFPd3ar83UiCUVXzAMXS0vd/1YucUOKPSPnPif0G23rEag==
X-Received: by 2002:a19:4801:: with SMTP id v1mr2284639lfa.56.1598273968875;
        Mon, 24 Aug 2020 05:59:28 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id j1sm2183392ljb.35.2020.08.24.05.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 05:59:28 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] seccomp: Use current_pt_regs()
Date:   Mon, 24 Aug 2020 15:59:21 +0300
Message-Id: <20200824125921.488311-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify seccomp_do_user_notification(), __seccomp_filter(),
__secure_computing() to use current_pt_regs().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 kernel/seccomp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 3ee59ce0a323..dc4eaa1d6002 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -910,7 +910,7 @@ static int seccomp_do_user_notification(int this_syscall,
 	if (flags & SECCOMP_USER_NOTIF_FLAG_CONTINUE)
 		return 0;
 
-	syscall_set_return_value(current, task_pt_regs(current),
+	syscall_set_return_value(current, current_pt_regs(),
 				 err, ret);
 	return -1;
 }
@@ -943,13 +943,13 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 		/* Set low-order bits as an errno, capped at MAX_ERRNO. */
 		if (data > MAX_ERRNO)
 			data = MAX_ERRNO;
-		syscall_set_return_value(current, task_pt_regs(current),
+		syscall_set_return_value(current, current_pt_regs(),
 					 -data, 0);
 		goto skip;
 
 	case SECCOMP_RET_TRAP:
 		/* Show the handler the original registers. */
-		syscall_rollback(current, task_pt_regs(current));
+		syscall_rollback(current, current_pt_regs());
 		/* Let the filter pass back 16 bits of data. */
 		seccomp_send_sigsys(this_syscall, data);
 		goto skip;
@@ -962,7 +962,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 		/* ENOSYS these calls if there is no tracer attached. */
 		if (!ptrace_event_enabled(current, PTRACE_EVENT_SECCOMP)) {
 			syscall_set_return_value(current,
-						 task_pt_regs(current),
+						 current_pt_regs(),
 						 -ENOSYS, 0);
 			goto skip;
 		}
@@ -982,7 +982,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 		if (fatal_signal_pending(current))
 			goto skip;
 		/* Check if the tracer forced the syscall to be skipped. */
-		this_syscall = syscall_get_nr(current, task_pt_regs(current));
+		this_syscall = syscall_get_nr(current, current_pt_regs());
 		if (this_syscall < 0)
 			goto skip;
 
@@ -1025,7 +1025,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 			kernel_siginfo_t info;
 
 			/* Show the original registers in the dump. */
-			syscall_rollback(current, task_pt_regs(current));
+			syscall_rollback(current, current_pt_regs());
 			/* Trigger a manual coredump since do_exit skips it. */
 			seccomp_init_siginfo(&info, this_syscall, data);
 			do_coredump(&info);
@@ -1060,7 +1060,7 @@ int __secure_computing(const struct seccomp_data *sd)
 		return 0;
 
 	this_syscall = sd ? sd->nr :
-		syscall_get_nr(current, task_pt_regs(current));
+		syscall_get_nr(current, current_pt_regs());
 
 	switch (mode) {
 	case SECCOMP_MODE_STRICT:
-- 
2.26.2

