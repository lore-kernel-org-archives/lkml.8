Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E706C433E8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08515206E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 10:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X3EV9Ggv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HMsoc9Xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgGKKK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 06:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgGKKJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 06:09:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE39C08C5DE;
        Sat, 11 Jul 2020 03:09:57 -0700 (PDT)
Date:   Sat, 11 Jul 2020 10:09:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594462195;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+YyI4czAkHXKe0alp7zM8EoICAPMSOMyNtMGrUvPUw=;
        b=X3EV9GgviIJ73sJOA9uEz/TrZxa7JLqXETOOQgN6RBne6CnzF0+hN5544r13k0qCoWgSvD
        EKsG1saGd/qS3WGFP+lHRIjKhc1Ds/gGYiQr29RY7NJEkkFoa+NeuvHlmFP3bvVL8KLJ8c
        h32lg5EnQkaBtVayb6oe5l+kCxxsJDWvqrpYSl5/lqMWYbJ2SxgL0HkgvElFgZjeTa/SKI
        tntIwrFnYNhTcYH7BLOGDVjdBvOpd6tBBJ2ozIihw2Kg4HwGou3GQj9U0WwqQx0ydDacOj
        6fKP5maeSoR6vdTtk8JN00StlHbokYqaCZzysn6c5rIgENmjOPLXt/kEYkVRGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594462195;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+YyI4czAkHXKe0alp7zM8EoICAPMSOMyNtMGrUvPUw=;
        b=HMsoc9XindDC3taqoFqnHFt8AZqOkx4rjbpihgsh9hgjPQYjxjHD3vQJxtOEMu7kwhYd2m
        +YsiLE+Hf0nQ/hAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] s390: Break cyclic percpu include
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200623083721.396143816@infradead.org>
References: <20200623083721.396143816@infradead.org>
MIME-Version: 1.0
Message-ID: <159446219491.4006.10096196387412426349.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     28e5bfd81c8de77504703adf24ceff9301e3c7be
Gitweb:        https://git.kernel.org/tip/28e5bfd81c8de77504703adf24ceff9301e3c7be
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 29 May 2020 22:41:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 10 Jul 2020 12:00:02 +02:00

s390: Break cyclic percpu include

In order to use <asm/percpu.h> in irqflags.h, we need to make sure
asm/percpu.h does not itself depend on irqflags.h

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200623083721.396143816@infradead.org
---
 arch/s390/include/asm/smp.h         | 1 +
 arch/s390/include/asm/thread_info.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/smp.h b/arch/s390/include/asm/smp.h
index 7326f11..f48a43b 100644
--- a/arch/s390/include/asm/smp.h
+++ b/arch/s390/include/asm/smp.h
@@ -10,6 +10,7 @@
 
 #include <asm/sigp.h>
 #include <asm/lowcore.h>
+#include <asm/processor.h>
 
 #define raw_smp_processor_id()	(S390_lowcore.cpu_nr)
 
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index e582fbe..13a04fc 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -24,7 +24,6 @@
 #ifndef __ASSEMBLY__
 #include <asm/lowcore.h>
 #include <asm/page.h>
-#include <asm/processor.h>
 
 #define STACK_INIT_OFFSET \
 	(THREAD_SIZE - STACK_FRAME_OVERHEAD - sizeof(struct pt_regs))
