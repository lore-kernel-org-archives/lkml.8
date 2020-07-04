Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C52C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 08:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D549207CD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 08:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KylZAFNq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Xljf3JY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGDIFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 04:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGDIFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 04:05:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F960C08C5DE;
        Sat,  4 Jul 2020 01:05:33 -0700 (PDT)
Date:   Sat, 04 Jul 2020 08:05:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593849930;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SDcqZbL1aXVwUBb6p8aR2xFjdXXCLwQeF08PTwRTIs=;
        b=KylZAFNqUsfqnVCz3mXsz9vLEdbIa0X1keajzWKiCK62nxQP6zTDGsGYkxmC58ekqRby6r
        eUBl0sWXDMPlGdtTHFci+C6Si1nmfAPx3zB7uB0ygVLRxw017IDNNB6pYUdc6XumxEWDOE
        CGJlMf8iefRCLlAsFmrQm1DZ269cvp3SP6ef4iGn2+8NoP9OZqoOj5fhQspmGH7NHQ+yoN
        aLjQjGdXD7SveMS5ceNUHq2G4j4EjqqDNrufNZKrHyYwa5RmD2x5XRRmiOxOItqgrx/z4v
        xFmDKl4TeOoW3rlTPurW8IK29djmkYfUENdnqoJxecoD3yDRhCTWNtP71Vnc5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593849930;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SDcqZbL1aXVwUBb6p8aR2xFjdXXCLwQeF08PTwRTIs=;
        b=/Xljf3JYhndpr+4c00Mis0HEAMImngFNGxW62LVTeqJImdv7B5XIor1KRTOPMArK1m29yM
        2vrIIyI2T1xWneAw==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] sparc64: Deselect IRQ_PREFLOW_FASTEOI
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anatoly Pugachev <matorola@gmail.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200703155645.29703-2-valentin.schneider@arm.com>
References: <20200703155645.29703-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159384992977.4006.749304579733572105.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     959f53bd90c3ac70e5481199c6159f6314f9f910
Gitweb:        https://git.kernel.org/tip/959f53bd90c3ac70e5481199c6159f6314f9f910
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Fri, 03 Jul 2020 16:56:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 04 Jul 2020 10:02:06 +02:00

sparc64: Deselect IRQ_PREFLOW_FASTEOI

sparc64 hasn't needed to select this since commit:

  ee6a9333fa58 ("sparc64: sparse irq")

which got rid of the calls to __irq_set_preflow_handler() first installed
by commit:

  fcd8d4f49869 ("sparc: Use the new genirq functionality")

Deselect this option.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Anatoly Pugachev <matorola@gmail.com> 
Link: https://lkml.kernel.org/r/20200703155645.29703-2-valentin.schneider@arm.com

---
 arch/sparc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 5bf2dc1..76f4078 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -80,7 +80,6 @@ config SPARC64
 	select RTC_DRV_STARFIRE
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
-	select IRQ_PREFLOW_FASTEOI
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_ARCH_AUDITSYSCALL
