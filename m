Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31961C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0D22072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbifQFOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgAJIjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:39:16 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52601 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgAJIjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:39:15 -0500
Received: by mail-pj1-f66.google.com with SMTP id a6so674966pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 00:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6ry4F8Ujb3RnXtwuPmBIQ2MsdIausl1cIH2f1B/fCM=;
        b=JbifQFOXzO5WpHVrdEP0ZMvJ2RyD2kFZwFbZlZM/fMu5r8k7eAXK7XcI0ekfRTSIK0
         upHITRoIHnOrRtkkcnNqU1wKDNRHK35k03TRHPzJ6jlbOtMbbk96EIQH368fz26+xIHI
         XyHTYm46bNgMDcGBTgEAFSJl8lfN7QruaXX3rAn4EDEsjYeK/lsyGtTrjHxHYeU52aMw
         4erry3xzDf2CEYIZIiCbvNyt4FTzHOmzvYXWg9G8nki+T/Z9j6RoHrH94eLj2cGL3Fhx
         ywH0lLHgT0FIqIYwnF0fB3sthzZ4I1N4yThJiqvCRCZiz1dstlcIANXXADh0VMg/XHj5
         saww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6ry4F8Ujb3RnXtwuPmBIQ2MsdIausl1cIH2f1B/fCM=;
        b=evsSMugxFEmoNX2EW05fxnO0ZmXk3WbZ3CK7r1qtA34ZU+lbi5AU65ImTPY4MdeyWy
         EBmhkA/K6a6LF0Zw74vZoVh8Ia3Qb4tVCeNTYd+1STunMue550aHO+cE7E4kdOhSkqLy
         ltnAu/gvVw5++IBRqU/rRR0TV70EDApczB+dtuFb5/hvL52oMMAXqm3YXmOOMme6BbAi
         U1DFJfAXntSGPjZriKut6I8t4K2Pybo/iYyIBd4yFN2Th3adGsKsQppngKtwlxROst3N
         2oczXceFpmYNf4p6R9MwG8OoTb1lf3j+JjeVJtX1NT7sRTx9wC/i6XUC7X+RnxFLVdCA
         DrrA==
X-Gm-Message-State: APjAAAX9mrDT7geUwtRNJn0CG/Shd7/bVGDJWgqwRbkrJCD82xVHjnR6
        3HKfR2Sow8IDcxqy+fXAWr4=
X-Google-Smtp-Source: APXvYqxka3+SdODhhjHeXPBNxZ1dUQb5ionUG4XNXAtnzx/X0WUGGC03TMYojDi7bzDQ4AldKQdIvQ==
X-Received: by 2002:a17:90b:309:: with SMTP id ay9mr3219908pjb.22.1578645555025;
        Fri, 10 Jan 2020 00:39:15 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id d21sm1628837pjs.25.2020.01.10.00.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 00:39:14 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
X-Google-Original-From: Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH] tick-common: touch watchdog for every cpus when system resume
Date:   Fri, 10 Jan 2020 16:39:02 +0800
Message-Id: <20200110083902.27276-1-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function tick_unfreeze(), it would resume timekeeping for the
first cpu, and for other cpus it does local tick resume only, not
to touch watchdog which is per-cpu as well.

This probably is not the problem for suspend to ram, but for suspend
to idle is. Since watchdog would be setup for each unplugged cores when
plugging during resume and would be touched in its setup process. But for
suspend to idle the system wouldn't unplug/plug cores, so we should
touch watchdog once resume from s2idle to avoid 'soft lockup' warnings
due to timeout detected by watchdog.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 kernel/time/tick-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 59225b484e4e..7e5d3524e924 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/hrtimer.h>
 #include <linux/interrupt.h>
+#include <linux/nmi.h>
 #include <linux/percpu.h>
 #include <linux/profile.h>
 #include <linux/sched.h>
@@ -558,6 +559,7 @@ void tick_unfreeze(void)
 		trace_suspend_resume(TPS("timekeeping_freeze"),
 				     smp_processor_id(), false);
 	} else {
+		touch_softlockup_watchdog();
 		tick_resume_local();
 	}
 
-- 
2.20.1

