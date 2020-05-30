Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2F4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 05:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB95E2073B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 05:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzBm4SNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgE3FJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 01:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgE3FJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 01:09:51 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FCDC08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 22:09:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p30so853966pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 22:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FMJlCAcsAodijnoOnsPB3f6nqU5i/WhcTdQMz89YxzI=;
        b=uzBm4SNeOMAvQaeOZn6BljjYDgwnZ1MvR2O/Jc3d+OEAg2J/KY2ZEL/gcqIsqOVR9Q
         PAOuh3Rw+EXW1SaB6+LgsgHlGgM8pPd0FnhNe4rDXsP47H9mhuUz6EgwzI+mZXqXt6Kj
         qqEocnCiMOLR/heFwavmeb+RvxOYlGu5caagTDRn122hIdEX7X4SRC61gby2uwIa0Apv
         SeXL/jTOnOlreypHehiTRzQbuJnidzyBKUPGG05Hd0zdJ/5I4Ru49hYf19Vsjx03jF+9
         JzzKrT8SZAnqwlT6sZVroYMrr+k9uk/h9sFmLpWP6EZ0LZJfgzSSez61AL3kJfiQqvpo
         JUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FMJlCAcsAodijnoOnsPB3f6nqU5i/WhcTdQMz89YxzI=;
        b=SImAxjqq+LAPhrAFiNWX+mgdS4dROWfpOTnxa/Flujzl9uY1DYgg/wM5/TtsA3WW/k
         1+zKfRwlv/O1W69hMJKXYO/QzVaYocYW2VjJUEolcYbifZ3UQQH0W0lLp/waAm3GnmaL
         fb7sKDT+V7azyKrz8NXVUdl7AO3RdibQpWuFueQbo1QZREQnqoXGqQZi0iuj3iYarCFP
         uluPcdJwlzMeVN2sQa2aLg/d9Oq7SJ0DloBLHr9TBeQrp+n5RRZerXBEjToGwBdtWRJ/
         L5SFtGVeghT6WOaKENAx4lH2D7FRg6xky13P24q9NrSeLKvLd+9tQmDtGSITX5595VLC
         ZJ4g==
X-Gm-Message-State: AOAM532UX2bB6CDxZYQY18g8p+Dj/n7DqTnQvZthvsQKpLB2KZLXkh1A
        SrWZjUJkKzU6g1Y7ByGL23k=
X-Google-Smtp-Source: ABdhPJzDiBczQdlTJ9Pk8K9O2YhmaQdOdQA7GJlmg827mHC+DVZXX09uqmvwk2d4BwflcgH4sgKNuQ==
X-Received: by 2002:a62:834a:: with SMTP id h71mr11625239pfe.147.1590815390161;
        Fri, 29 May 2020 22:09:50 -0700 (PDT)
Received: from sultan-box.localdomain (static-198-54-129-68.cust.tzulo.com. [198.54.129.68])
        by smtp.gmail.com with ESMTPSA id p7sm8788667pfq.184.2020.05.29.22.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 22:09:49 -0700 (PDT)
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     sultan@kerneltoast.com, bristot@redhat.com, julia@ni.com,
        linux-kernel@vger.kernel.org, maz@kernel.org, mingo@redhat.com,
        srivatsa@csail.mit.edu, tglx@linutronix.de
Subject: [PATCH v2] locking/Kconfig: Don't forcefully uninline spin_unlock for PREEMPT
Date:   Fri, 29 May 2020 22:09:43 -0700
Message-Id: <20200530050943.142128-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200530050051.141204-1-sultan@kerneltoast.com>
References: <20200530050051.141204-1-sultan@kerneltoast.com>
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
 kernel/Kconfig.locks   | 10 +++++-----
 kernel/Kconfig.preempt |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 3de8fd11873b..2d992f5c6ec3 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -139,7 +139,7 @@ config INLINE_SPIN_UNLOCK_BH
 
 config INLINE_SPIN_UNLOCK_IRQ
 	def_bool y
-	depends on !PREEMPTION || ARCH_INLINE_SPIN_UNLOCK_IRQ
+	depends on ARCH_INLINE_SPIN_UNLOCK_IRQ
 
 config INLINE_SPIN_UNLOCK_IRQRESTORE
 	def_bool y
@@ -168,7 +168,7 @@ config INLINE_READ_LOCK_IRQSAVE
 
 config INLINE_READ_UNLOCK
 	def_bool y
-	depends on !PREEMPTION || ARCH_INLINE_READ_UNLOCK
+	depends on ARCH_INLINE_READ_UNLOCK
 
 config INLINE_READ_UNLOCK_BH
 	def_bool y
@@ -176,7 +176,7 @@ config INLINE_READ_UNLOCK_BH
 
 config INLINE_READ_UNLOCK_IRQ
 	def_bool y
-	depends on !PREEMPTION || ARCH_INLINE_READ_UNLOCK_IRQ
+	depends on ARCH_INLINE_READ_UNLOCK_IRQ
 
 config INLINE_READ_UNLOCK_IRQRESTORE
 	def_bool y
@@ -205,7 +205,7 @@ config INLINE_WRITE_LOCK_IRQSAVE
 
 config INLINE_WRITE_UNLOCK
 	def_bool y
-	depends on !PREEMPTION || ARCH_INLINE_WRITE_UNLOCK
+	depends on ARCH_INLINE_WRITE_UNLOCK
 
 config INLINE_WRITE_UNLOCK_BH
 	def_bool y
@@ -213,7 +213,7 @@ config INLINE_WRITE_UNLOCK_BH
 
 config INLINE_WRITE_UNLOCK_IRQ
 	def_bool y
-	depends on !PREEMPTION || ARCH_INLINE_WRITE_UNLOCK_IRQ
+	depends on ARCH_INLINE_WRITE_UNLOCK_IRQ
 
 config INLINE_WRITE_UNLOCK_IRQRESTORE
 	def_bool y
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

