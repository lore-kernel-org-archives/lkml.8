Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E71FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 05:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C462074A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 05:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyO1iWxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgE3FA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 01:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgE3FAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 01:00:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC885C08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 22:00:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fs4so2333053pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 22:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CqN3oVyXjjT3O+AzOV+W1hL/jpMpA64VfLBpp7jewBM=;
        b=XyO1iWxd+lHaCQTNycMCSLayEEw6GkRgUnT7CXsdZGcg1+UEmIUz7pgj3N6yFSpXrB
         KrXauexbq5SyNk98sSOova4erjJsnjmkL1AIWVvh3V06zqzrg2fVWVsH6MMY6f4cYAQ/
         RJCwNNsH9thiPSk3601KANzSDpi1U9ye2IK2XnUifdqqQdNrFfCAdAqvZWlK14dzgaYk
         K+JK66eGI84dzRLvP0JGk/WWrzXtB35qCycCHDM4nLS0yysVIOdaReAg7m3h7I/3t7eT
         dRmtxDcELtCbiiVw40GlQDvENlSlx7bQnM2KyK0hKn6TDFCDS4Vdosw4AW6ZZN/WKXgJ
         Ak4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=CqN3oVyXjjT3O+AzOV+W1hL/jpMpA64VfLBpp7jewBM=;
        b=NRJYIrOzCUHIfLbEk6hPUQi6X4VAF/RNg+/W4g8jWMQSq01DaLrgV0X73d1KwriXRe
         iqWWrV81mPD056TiGVUvtPmbJb4a14FtNKkL8oyGCC7a50Do0WRaW2vDWQpIrb5yZOI7
         IelP7Ogt/+cwEMFKfdIZvWxbS1AMh23/dtMAbjlwj5uCP/BAFo9m8+NekrFELQpVzXM8
         8ufidHeMJe0bnLGHxfnOVuHjgbwEqGvb7N/7QxTH3+vw7f18UCdh1UIx+0RbRbXuyvls
         Lq85y26ygJlUovzRAuCu0ZB+pWoCMbY7uiiNfToydMF8oK9nA75MzapGoKD4AR1/pcYO
         j1Eg==
X-Gm-Message-State: AOAM5309NnJjycrWic7sBl4z3aVxwbxyv4NHWBhTnoQJDjsXqaOwN/Ql
        +qb/2ng94aRcZunO6LWpQZw=
X-Google-Smtp-Source: ABdhPJw5IijGspW8wlQ5aGY8GM4Nzght7s9jvdb970V9TwZRK7bEx5/psWcG3UMB7yiux5cEF2V+Cg==
X-Received: by 2002:a17:902:aa4a:: with SMTP id c10mr12098817plr.0.1590814855124;
        Fri, 29 May 2020 22:00:55 -0700 (PDT)
Received: from sultan-box.localdomain (static-198-54-129-68.cust.tzulo.com. [198.54.129.68])
        by smtp.gmail.com with ESMTPSA id j13sm8654628pfe.48.2020.05.29.22.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 22:00:54 -0700 (PDT)
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Marc Zyngier <maz@kernel.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] locking/Kconfig: Don't forcefully uninline spin_unlock for PREEMPT
Date:   Fri, 29 May 2020 22:00:51 -0700
Message-Id: <20200530050051.141204-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

This change was originally done in 2005 without any justification in
commit bda98685b855 ("[PATCH] x86: inline spin_unlock if
!CONFIG_DEBUG_SPINLOCK and !CONFIG_PREEMPT"). Perhaps the reasoning at
the time was that PREEMPT was still considered unstable and needed extra
debugging; however, this is no longer the case, so remove the artificial
limitation.

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 kernel/Kconfig.preempt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bf82259cff96..5a9e0409c844 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -39,7 +39,6 @@ config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
 	select PREEMPTION
-	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
-- 
2.26.2

