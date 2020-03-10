Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40DAC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82E421D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgCJPPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:15:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44121 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgCJPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:15:12 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jBgb6-0006FP-UG
        for linux-kernel@vger.kernel.org; Tue, 10 Mar 2020 15:15:09 +0000
Received: by mail-wm1-f71.google.com with SMTP id p4so440335wmp.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 08:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SX7toKZWodKfwjLUNVU3mZINSd3WdGinFSx6G9WeLDk=;
        b=YFUqnfQkTGawzHADm/SqlcrnNotxxDSur/gXsIrRu447Kp9gDeWqYOBlTsjEy57xeI
         +AVJ8p2Ze3ZilWu+SIswldS0PAfoo2vCdBEm60xTkS15Pa+7/6eMki/jHdPIlE+SkfDE
         tXH2ONnFwtH7G5LNZY89hawYWIobfS3mlHZ4v4BHVWYY8SYYMZ2C/10PyiGLCD9zKr0I
         y5WKcz3pgviQ3Yk6AKYkEzIXu7nNux58NOdwYQwe5Qage5m9pRfX3CpsfmruQOW4bUDL
         yFvir5zC3tPX2AVpg/s4+Mo69JG5TXdSygtie+Dk/4olfpGEGMcmFa9O2f8nH9o0/pcr
         JXcA==
X-Gm-Message-State: ANhLgQ3cGdigqPulEiu0Gni/hHhmZnf/Kn/qflGFwVqcLzifcxFA66/L
        jjI57GuYTQBVZXlh2PZ/RWRt6uoSHdy1R64vQ4xJQL3mJWC6n5cENg+mlXEg11qyKW9ZBXAmMb2
        jxagTQVKw/A16BqTywtF6krgb/kxe0lsKJtV9Xhsn5A==
X-Received: by 2002:adf:ef44:: with SMTP id c4mr12995063wrp.404.1583853308616;
        Tue, 10 Mar 2020 08:15:08 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtSJ6usylxaeEgKGV13gLvCQGlN13i7Aktoi9ePJtqB/19xsQe+qjKKiMWcO7JVdMeLevXEuQ==
X-Received: by 2002:adf:ef44:: with SMTP id c4mr12995038wrp.404.1583853308339;
        Tue, 10 Mar 2020 08:15:08 -0700 (PDT)
Received: from localhost (189-47-87-73.dsl.telesp.net.br. [189.47.87.73])
        by smtp.gmail.com with ESMTPSA id f9sm15143586wrc.71.2020.03.10.08.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 08:15:07 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org, swood@redhat.com,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        mingo@kernel.org, gpiccoli@canonical.com, kernel@gpiccoli.net
Subject: [PATCH] Documentation: Better document the softlockup_panic sysctl
Date:   Tue, 10 Mar 2020 12:15:03 -0300
Message-Id: <20200310151503.11589-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9c44bc03fff4 ("softlockup: allow panic on lockup") added the
softlockup_panic sysctl, but didn't add information about it to the file
Documentation/admin-guide/sysctl/kernel.rst (which in that time certainly
wasn't rst and had other name!).

This patch just adds the respective documentation and references it from
the corresponding entry in Documentation/admin-guide/kernel-parameters.txt.

This patch was strongly based on Scott Wood's commit d22881dc13b6
("Documentation: Better document the hardlockup_panic sysctl").

Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 +++---
 Documentation/admin-guide/sysctl/kernel.rst     | 13 +++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d230bc..adf77ead02c3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4515,9 +4515,9 @@
 
 			A nonzero value instructs the soft-lockup detector
 			to panic the machine when a soft-lockup occurs. This
-			is also controlled by CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC
-			which is the respective build-time switch to that
-			functionality.
+			is also controlled by kernel.softlockup_panic sysctl
+			and CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC, which is the
+			respective build-time switch to that functionality.
 
 	softlockup_all_cpu_backtrace=
 			[KNL] Should the soft-lockup detector generate
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index def074807cee..95b2f3256323 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -95,6 +95,7 @@ show up in /proc/sys/kernel:
 - shmmax                      [ sysv ipc ]
 - shmmni
 - softlockup_all_cpu_backtrace
+- softlockup_panic
 - soft_watchdog
 - stack_erasing
 - stop-a                      [ SPARC only ]
@@ -1029,6 +1030,18 @@ NMI.
 1: on detection capture more debug information.
 
 
+softlockup_panic:
+=================
+
+This parameter can be used to control whether the kernel panics when
+a soft lockup is detected.
+
+0: don't panic on soft lockup
+1: panic on soft lockup
+
+This can also be set using the softlockup_panic kernel parameter.
+
+
 soft_watchdog:
 ==============
 
-- 
2.24.1

