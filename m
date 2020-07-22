Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9109C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 897D720825
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V+1Ckav1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EeJ7V0TR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733090AbgGVWL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733042AbgGVWL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:11:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEA2C0619E1;
        Wed, 22 Jul 2020 15:11:26 -0700 (PDT)
Message-Id: <20200722220519.404974280@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595455883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=V20TjmN1n9jq0pcYjqfVM1GUS2Jje/9aKzst9S90g0M=;
        b=V+1Ckav1bl2n3nhw2Dy7IetRojALQ0RML0iVbCWHR5tqcRMvDVODaR65R6XVMVggrYvYam
        4Z8es+jLyY58pTfgGe0usp5pEHmmbOzU9TAPnXR5doNaNITE+rWxaXerA5LSLnhMbHdiyc
        TGCX7Mstx88deWvr7MI9hNuQWC9pPheUfkOzAQRyQKHVvmxVMF2lV0c2A+hpO2+AZKrVMT
        3HgPU/z1oQaolmTtTzOxWdTiFMS/Sjpbr247ifjjHetYVnP7daOkUCz9ditlpu+ahsQoo8
        od5Wv0XrJ/LQ/XZJ8TM+nXqzqEizGV4xebVfXJuH/4qQlKxZ4og6p7a3pyGBGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595455883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=V20TjmN1n9jq0pcYjqfVM1GUS2Jje/9aKzst9S90g0M=;
        b=EeJ7V0TRXQTAq7HVtVDVgfGUCl9yNBv3qi+SMW0zk4jgVi6oI+bzn9f2JIrYs5xrk80gBl
        yRX2cEV3WGpTSuCg==
Date:   Wed, 22 Jul 2020 23:59:55 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V5 01/15] seccomp: Provide stub for __secure_computing()
References: <20200722215954.464281930@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

To avoid #ifdeffery in the upcoming generic syscall entry work code provide
a stub for __secure_computing() as this is preferred over
secure_computing() because the TIF flag is already evaluated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kees Cook <keescook@chromium.org>

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


