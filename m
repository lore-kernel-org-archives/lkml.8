Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00154C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C29FF20738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AozOV1Jv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgEVKDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgEVKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:03:17 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FBAC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 03:03:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 145so4982786pfw.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 03:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/Ly0FZ1XMvk/0WTHXshwlxj04l0m432nKVvBo4F3A6Q=;
        b=AozOV1JvUkbhSli/GuwvCZa+TcZ2IVZW1h1ssIA+PsgfpglluQQOZyPjlOzzguMWyt
         qKjOTrvJSjIwuwc53yi0bU83bMhGeDPTu7OPi5IUa/mZcOZDWLRi72u0U7Why35oq8Of
         gznlIWX0Poi4kVv1LZCO1+hbV+fGb+u6aDIpxk4ZwpBHFo3mBigaw8CtlHIInY5eXCzt
         +H2DhMWFVifQoptuWS4EPdDZS6kGG494BoEqxi+G9uFr5gH+FbAnCE1f5Id0SGmuArl4
         gAKuPyvy4IJr526ZgQmSGvo+Ywa25xEooqiPJFdQWwF0xmds3OYo5MU2Hhot5/t6FJ4C
         anxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Ly0FZ1XMvk/0WTHXshwlxj04l0m432nKVvBo4F3A6Q=;
        b=cDebtD0XVNn+WrE4sIGzrguQO8BO4om2nNkV1KKnDCXI3zL4FddB4cMf8NAShyw3m7
         EgoY5PQt35/TDIn+yhTAmpGFkNMoXKIwgfQF58gk1oQd7CMSNzEiwpNt8CRjSrI4Z1Q8
         bPjX+yhzA0Ruw0hsfWahLDq/cQcLmz7QcRgFLKoPpUw4wfIkySgm1K4hDHmpeLWLo8EA
         p/uYhRRSKwzDrcLcAbJ1p8DIfXYEB1guvhlIf4f7MHgnNdhp2wKjW1IsS38KlbJ8FKbM
         YCHiQf+wbftoF6Y9F4me0bnkHnCCWRVC7hVrXeDb3qIzes0odrFXmIxzglIf6orqdqeY
         Oyog==
X-Gm-Message-State: AOAM533qd+D0On6OH00EMpamGqSAQsfv6trnT5dSMepSaIkSZDCUceak
        MJJSWvXSi+bTXF6+YqqE9hsuuA==
X-Google-Smtp-Source: ABdhPJwWr2TfnrurtMH4xVDrw2CfDB32Bc5E8x2mOS8SX+3DgkeMHiuUcbAQx3t3cBf4wEFfwnvuug==
X-Received: by 2002:aa7:9297:: with SMTP id j23mr3099183pfa.15.1590141796773;
        Fri, 22 May 2020 03:03:16 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.136])
        by smtp.gmail.com with ESMTPSA id c24sm6477633pfp.186.2020.05.22.03.03.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2020 03:03:15 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] kdb: Make kdb_printf robust to run in NMI context
Date:   Fri, 22 May 2020 15:32:26 +0530
Message-Id: <1590141746-23559-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While rounding up CPUs via NMIs, its possible that a rounded up CPU
maybe holding a console port lock leading to kgdb master CPU stuck in
a deadlock during invocation of console write operations. So in order
to avoid such a deadlock, invoke bust_spinlocks() prior to invocation
of console handlers.

Also, add a check for console port to be enabled prior to invocation of
corresponding handler.

Suggested-by: Petr Mladek <pmladek@suse.com>
Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 924bc92..e32ece6 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -699,7 +699,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 			}
 		}
 		for_each_console(c) {
+			if (!(c->flags & CON_ENABLED))
+				continue;
+			bust_spinlocks(1);
 			c->write(c, cp, retlen - (cp - kdb_buffer));
+			bust_spinlocks(0);
 			touch_nmi_watchdog();
 		}
 	}
@@ -761,7 +765,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
 			}
 		}
 		for_each_console(c) {
+			if (!(c->flags & CON_ENABLED))
+				continue;
+			bust_spinlocks(1);
 			c->write(c, moreprompt, strlen(moreprompt));
+			bust_spinlocks(0);
 			touch_nmi_watchdog();
 		}
 
-- 
2.7.4

