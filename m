Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DEAC433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F57206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R7BCvEhZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dIS0N77F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGXTJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:09:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39900 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgGXTJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:09:04 -0400
Date:   Fri, 24 Jul 2020 19:08:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595617742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQ8e8jqUAqS++bljw+Nq4gsXBAkwr8JtsHqe6o0P36c=;
        b=R7BCvEhZw/eoCVgo746W/SxnxLFpUjmNphM5KM9t38jLpdP4v5vCuLE4GA3/qnW2NIr5Dg
        bQ/pFbAXqiwsr2b8/IXj1HFL8tRnQ/6uicvGRBGyxR6CKqGFiqdiSFjZI7RBgoo0oQB7nf
        FYB5FjzYXIWcrl7D6NSm4/qIgNcr64az0Qtt7GTGYoRgAKnVbSzeSq240wEP8e8jGszqL7
        shpVW1QfItbS/VCrLMnXWqpcAX4I/ea3XGpoFSnQYo0KGZXEUHnURWlVvWU0+Tc6e3jVHV
        osRAc/pz4CDVtHhGbS0+ubShFFd0STxGMvVb8L+PyRKk36rEa2wghT/Zds9wuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595617742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQ8e8jqUAqS++bljw+Nq4gsXBAkwr8JtsHqe6o0P36c=;
        b=dIS0N77Fwh3s8Dy8zkFZFS10K/pL0XguR5BOxcamQSj4RguJAv7mltaMw44QPBbRZS3Tr2
        +RdZSS2j1aW9cvAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] seccomp: Provide stub for __secure_computing()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722220519.404974280@linutronix.de>
References: <20200722220519.404974280@linutronix.de>
MIME-Version: 1.0
Message-ID: <159561773699.4006.1330968938608740876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     6823ecabf03031d610a6c5afe7ed4b4fd659a99f
Gitweb:        https://git.kernel.org/tip/6823ecabf03031d610a6c5afe7ed4b4fd659a99f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 22 Jul 2020 23:59:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 14:59:03 +02:00

seccomp: Provide stub for __secure_computing()

To avoid #ifdeffery in the upcoming generic syscall entry work code provide
a stub for __secure_computing() as this is preferred over
secure_computing() because the TIF flag is already evaluated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200722220519.404974280@linutronix.de


---
 include/linux/seccomp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 4192369..03d28c3 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -61,6 +61,7 @@ struct seccomp_filter { };
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 static inline int secure_computing(void) { return 0; }
+static inline int __secure_computing(void) { return 0; }
 #else
 static inline void secure_computing_strict(int this_syscall) { return; }
 #endif
