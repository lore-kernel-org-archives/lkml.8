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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773ABC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B6A207BB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urfgD943"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgHCMY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbgHCMYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:24:52 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72B6C06174A;
        Mon,  3 Aug 2020 05:24:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so14159253wmi.2;
        Mon, 03 Aug 2020 05:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VR9T7sylAgjDgpJ8EDAbpDnekBXDbki41I/rzJT2SZI=;
        b=urfgD943beDcrGJbLj2FCNbPb9kgqIFJRgJq5QP52pbmhMztzmOVoYKCfFouBt2b6b
         +NCi1wbMfTKTy8rN80qHdIUSXR94UhPQf3K/JegAJHPZRvzIfdgun75wYKGZXM0QwTCH
         ed3Jc4o7OGJS3WIlP3r7St+9w+LAG/nshps+PqAjmBzYVCFER2qM8qfQKuz6BhWOu5HQ
         sxrrO7TWeX8VXQULLBE0o1bnEIGS3dha/URUx4ozePVVKUIBwrhqcUVJJ9FwfmHPJoN4
         MD7zuddkVNQ2h4b5hBfQLykntLyFBcEHrUtb08tb0QJrI2GvFyyN1+vHeCMITguafvGt
         eGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VR9T7sylAgjDgpJ8EDAbpDnekBXDbki41I/rzJT2SZI=;
        b=sG+jFulH6GEG74C35AiG0RIbxRZZxg9WdK6IQDRMyuodab/8YSFtLfrrPkDCvbMvVk
         IYmt6onz21fmVxUKAyWhq9ZCEsNqWciFH5smIN2v01nvYj2UL27Pon96o9LPOxkqx+GE
         nVelTKPPY9UOP59WGKnvIAXZ2Lr4kmFj9MmUbdv8vlnJNHHxJ2sUytOGOcxwjckynzg/
         K3oUDvjqOJtUpk3+em9Jf2HxdtjkgPYiqwVsrbpW7Obp+/faSrqrU50a6pdgh9SJqY6C
         6Hw9DldiLsJIgWV7PrgX3MxHoeNe0A/PnzyETLNWEpjvvmiYV3Iegy/eH9paYR5t9hK6
         uLAg==
X-Gm-Message-State: AOAM533u/G7dZzl4m6ScHcJJOZcSVy+MsJbT9+yfv1ShhPF8R4US8NHd
        Kw/7ArpiASN3y3doz66Lm6ugxutjLQ==
X-Google-Smtp-Source: ABdhPJxOzWCjQaTB+cJQ7jRVCWIutX9Ay2X699z2X8+4vZZyLeOr0PwCMw7b9/0acSQzT7G/3F9djw==
X-Received: by 2002:a1c:9e11:: with SMTP id h17mr3110316wme.106.1596457490306;
        Mon, 03 Aug 2020 05:24:50 -0700 (PDT)
Received: from localhost.lan (host-92-25-238-49.as13285.net. [92.25.238.49])
        by smtp.gmail.com with ESMTPSA id m1sm6559050wmc.28.2020.08.03.05.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 05:24:49 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     inux-kernel@vger.kernel.org
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com (moderated list:AUDIT SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] audit: change unnecessary globals into statics
Date:   Mon,  3 Aug 2020 13:24:29 +0100
Message-Id: <20200803122430.82364-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200803122430.82364-1-jbi.octave@gmail.com>
References: <0/2>
 <20200803122430.82364-1-jbi.octave@gmail.com>
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

