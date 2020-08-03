Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0C5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE8A2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUwi+i5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgHCMhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgHCMfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:35:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEF8C061757
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 05:35:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 3so15276744wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 05:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VR9T7sylAgjDgpJ8EDAbpDnekBXDbki41I/rzJT2SZI=;
        b=KUwi+i5VLXUKosdvnGmvdKM+cD3OI92FRGBdjhEiSryN4bPtow6nFoSlGnK/CkIGkX
         CcCbRKUaBZAAQY6pf/MhoG6pbM30rbTHmDIQB/SaJ1+yq6iuXksQrFng7Ubtj3YpVcQP
         ft0sU1mmvmvkdXaqFrwjfYM4R7q5W7rvlqq66sD79PNtRBgc+Rm4xGOeRfJ2X8XG1H2+
         cRY814/KhSJP/vydezresSMJCxRbJPkVzMMe8nSGAkjnNQY7uASCWM913dgYLnhL13F9
         hfxfR57imbnKl3I9cJYrkFkeLYEh6umlfNl6PiEiWIOcjXoocQf/OQCAoSJ2H9b7E0Bl
         DqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VR9T7sylAgjDgpJ8EDAbpDnekBXDbki41I/rzJT2SZI=;
        b=rhTxjM2oZEnT4qePqXMvvJO1pPovY0LZcFjL6N5mZy5jEPdFAaBk3OvxvAGtYNNkwV
         MK5k8Jdn1Bv17LtZy3ubvhINyfxAfY6idzPhkdShuPN3KhpAULcMyu5k8wtMLbtJxWbj
         H3WeD6eftBs9aTqSbc/0JFjS3tI8nEJf1Zl4rVsIH16avkeUigQd6I95D9PmFffWF5vQ
         fJ7vFqsHqyZ95EOU4e8VNWSYeqnGZLp02uZQFPvSCaoRXwa2l7UpDZEWF8ev2Hc2lPLf
         igjkspqD41aB+xLPrqsVyWJXJUdpdc2lqsGAYow/RS9OmNpVC+rF0jrB8QPHEjuw3n8R
         Etow==
X-Gm-Message-State: AOAM530NF+6pgQ0aI7AgebcXbCsARJKEILOYOHO5PT8VhMAhNK5bt2WF
        F7BaeGp3hEf/fSJKtV1vDX7czXJRPw==
X-Google-Smtp-Source: ABdhPJwJYJ1EoIWwc5DnS8UDx5TQ7vHTekDqKRD22JWPrMP6ZJ5JeQs2FFY9GFnHQzJzQsP4WI6gUQ==
X-Received: by 2002:a05:600c:21cd:: with SMTP id x13mr16832676wmj.155.1596458109433;
        Mon, 03 Aug 2020 05:35:09 -0700 (PDT)
Received: from localhost.lan (host-92-25-238-49.as13285.net. [92.25.238.49])
        by smtp.gmail.com with ESMTPSA id u66sm24201133wmu.37.2020.08.03.05.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 05:35:09 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com (moderated list:AUDIT SUBSYSTEM)
Subject: [RESEND PATCH 1/2] audit: change unnecessary globals into statics
Date:   Mon,  3 Aug 2020 13:34:38 +0100
Message-Id: <20200803123439.83400-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200803123439.83400-1-jbi.octave@gmail.com>
References: <0/2>
 <20200803123439.83400-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables sig_pid, audit_sig_uid and audit_sig_sid
are only used in the audit.c file across the kernel
Hence it appears no reason for declaring them as globals
This patch removes their global declarations from the .h file
and change them into static in the .c file.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/audit.c | 6 +++---
 kernel/audit.h | 4 ----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index b2301bdc9773..afd7827cf6e8 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -123,9 +123,9 @@ static u32	audit_backlog_limit = 64;
 static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 
 /* The identity of the user shutting down the audit system. */
-kuid_t		audit_sig_uid = INVALID_UID;
-pid_t		audit_sig_pid = -1;
-u32		audit_sig_sid = 0;
+static kuid_t		audit_sig_uid = INVALID_UID;
+static pid_t		audit_sig_pid = -1;
+static u32		audit_sig_sid = 0;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
diff --git a/kernel/audit.h b/kernel/audit.h
index ddc22878433d..3b9c0945225a 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -327,10 +327,6 @@ static inline int audit_signal_info_syscall(struct task_struct *t)
 
 extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
 
-extern pid_t audit_sig_pid;
-extern kuid_t audit_sig_uid;
-extern u32 audit_sig_sid;
-
 extern int audit_filter(int msgtype, unsigned int listtype);
 
 extern void audit_ctl_lock(void);
-- 
2.26.2

