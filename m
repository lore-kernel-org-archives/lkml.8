Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0452AC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BD82072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgCSTSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:18:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48391 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgCSTSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:18:13 -0400
Received: from mail-qk1-f200.google.com ([209.85.222.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jF0gE-0005Ze-PN
        for linux-kernel@vger.kernel.org; Thu, 19 Mar 2020 19:18:10 +0000
Received: by mail-qk1-f200.google.com with SMTP id k16so3351839qkk.16
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 12:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SX7toKZWodKfwjLUNVU3mZINSd3WdGinFSx6G9WeLDk=;
        b=rYtVGnNnssVPXFdsCcpoMnOvnMTX9mhXB/d6Ud3PWRGJ1ZtqCW95llRUk/C0CGfGec
         nyEfjt0gMzaN6Vo7Uf5WGToDLWUkeo6B5eTeLA25gLDm3jy7iVwe9vgKpamtEaZaFaZ8
         37ETuTAp+D4/doTb3gtszURV+pFZxHDL5rR9AP5LlyaGnH6uJD3fWypwcbMF0RFwkVKf
         OfoeV53BPxp9QzlBJKTDcDTydqs1hlCexwxG9lHA4j4b8oRyfrZ5CLeXb9K26patW8NG
         Fj0UBL/Ec9Uq6iYhvszAfsHuxFsq48NJs6gPsKwaIDDyZv+ye4Yr/JbvTGf3Ku4vCf59
         ocNQ==
X-Gm-Message-State: ANhLgQ1VHC3hTh0s/paM+htilxsAZf9+SkjjfVyLUQi5dHb3jZLv0wmA
        gbPTHAFvz3wj6qbYHJIgYo5gc9RYwd7qpEVTQLH3fOxJWa1mUQ6P8atGNpEPQf2noPW9/WQHek/
        3buH6VzsHXZK9sNdU+YKSyWrjq772NxqlXOdTOmL5pA==
X-Received: by 2002:a0c:9104:: with SMTP id q4mr4690612qvq.61.1584645489878;
        Thu, 19 Mar 2020 12:18:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuSwnj3+tnGuSZlOdxomBJxoWwMUMMpVRd1vQywR/Ot4Jz0Yn/5uAxPW/i+EZ5gJwiAhjv49g==
X-Received: by 2002:a0c:9104:: with SMTP id q4mr4690573qvq.61.1584645489574;
        Thu, 19 Mar 2020 12:18:09 -0700 (PDT)
Received: from localhost (189-47-87-73.dsl.telesp.net.br. [189.47.87.73])
        by smtp.gmail.com with ESMTPSA id s36sm2364603qtb.28.2020.03.19.12.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 12:18:08 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org, swood@redhat.com,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        gpiccoli@canonical.com, kernel@gpiccoli.net
Subject: [PATCH] Documentation: Better document the softlockup_panic sysctl
Date:   Thu, 19 Mar 2020 16:18:06 -0300
Message-Id: <20200319191806.11453-1-gpiccoli@canonical.com>
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

