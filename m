Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E077C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6D520709
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OiWEO8cm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gI2wYoRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgGULIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:08:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37340 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgGULIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:08:37 -0400
Message-Id: <20200721110808.348199175@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595329715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=TYlK47Qp3PMG02GI6MwKMpJXQyCAbHFBFk8idNOPcBo=;
        b=OiWEO8cmytmWaDZikXjFg8QQUVuKKkFiaNJ3f4EuvuHC6sTkm8GHVWcSWByRIZIuontxfY
        TITrqRWo1E7ekAVG6sN1SjsHZ2BdJxU3kbiZYDmLW+q5rY/d4s2UosNIZehs2j3Vl0v0MI
        jMoN1HZEpWjeE5xsHiU02EZeuAq4DNDXmCwdU+726ZonmoleNmcUCrlkkEbksSlK8+s7yZ
        kmXz6k/KlvVGD3AyRSa2mqBhyMm7mYbiXNHm7ImmhfnWG41y+F19Evv9G/bYZFzbEGJ4ca
        vVp+uIakZd8S16IZRdq2KiY0yNLC405IY6Mc6pqOyQyxc4ARcq6T+MDzZjmIfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595329715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=TYlK47Qp3PMG02GI6MwKMpJXQyCAbHFBFk8idNOPcBo=;
        b=gI2wYoRArtCglw/JgOpwVZNFI0vQ0eSe2W5jKMcH4jTfnKulI3V/EqjNmbN/e0ef6INeAM
        lQb7a86qjiRoQUBA==
Date:   Tue, 21 Jul 2020 12:57:07 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [patch V4 01/15] seccomp: Provide stub for __secure_computing()
References: <20200721105706.030914876@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid #ifdeffery in the upcoming generic syscall entry work code provide
a stub for __secure_computing() as this is preferred over
secure_computing() because the TIF flag is already evaluated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: New patch
---
 include/linux/seccomp.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -61,6 +61,7 @@ struct seccomp_filter { };
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 static inline int secure_computing(void) { return 0; }
+static inline int __secure_computing(void) { return 0; }
 #else
 static inline void secure_computing_strict(int this_syscall) { return; }
 #endif

