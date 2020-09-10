Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B62C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9842208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="WgG0SFGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgIJVfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730923AbgIJNt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:49:28 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93059C061796
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:48:26 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id x15so2254276wrm.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=CKC4riJvJK5v9Z9Ok50HMBgYPff3aChRh0QJLVpJjvg=;
        b=WgG0SFGnDfGbjr63kBibCRJ2m30nMFyLODKO7uNWW8B11XC1UwmPIs+QtSGJ9LWSsg
         9u74K8ShTi8lfKM8fOFrrE3iPMvEPHrLBNqAtSHRKL8hTEwoyHZSZV837a92ZZexxqyR
         DGBHW1zi/gx6uKdESbNPxmI3gIK+PrbZU483OVXEelYoY+UBrFa3gypGemNz1jC+7L4B
         osZ1fQVDztT3Z7ZbUlUHHmdprHw3yV3cWhSiSDcDwhf9wy4UHlPpMa0t0Y4SDteGyM8M
         Wsw1dGDSsoexSvilfwqdewaJXBRgiDyytB2ffdovKX7/xDlDk1RcSslRxR332JpOwrDs
         wLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=CKC4riJvJK5v9Z9Ok50HMBgYPff3aChRh0QJLVpJjvg=;
        b=jxKua5Rsn4hl4d/yxmpGh0vF7zzvAO6zW0wdFnfBFCGDWTb5sLhCaHn5d6XlQvkQij
         qRF8ehndxrbhzeuFaG4cuv9Q55mQZFBM5veZzYRGxy53JNxLakN0ARxMi6t6e23eQwlZ
         /dtKTXqpGEc129RoeJJ2wFh9jDu5R8VJqsW7RX3LY/r3r7LLKHe6zEn0Ilv8e/dUL0Mv
         d8edccbSVFDsQo4tWK366HAh4PCgmPDsYOKefD8UIwl6ugiiz0U5MAHmXlFlQAXSd83x
         52VqLhTulGzwYJyzGH2HpZoOeHIsOjlptbJPEPNneXlOJOvciQkCL7XJbGMOvXtyJXU1
         JCwg==
X-Gm-Message-State: AOAM531oC+AyYYy6YdEz0r2xyxX6Dw8YYklgNMcAS3i/58O7wdzBYwuo
        jeWYsZ997zjbQcCHWBaKnPBZFtEIuo64
X-Google-Smtp-Source: ABdhPJzXGzHqMjZogwlFUVQYV32E/MmMQjyUoqvNm+QW2oFEVjVBfHVxiQC+Yt6DXR0L9wrVPmfbdeimv9tD
X-Received: from lenaptr.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:29c9])
 (user=lenaptr job=sendgmr) by 2002:a5d:44cc:: with SMTP id
 z12mr9413494wrr.189.1599745699562; Thu, 10 Sep 2020 06:48:19 -0700 (PDT)
Date:   Thu, 10 Sep 2020 14:48:02 +0100
Message-Id: <20200910134802.3160311-1-lenaptr@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH] sched.h: drop in_ubsan field when UBSAN is in trap mode
From:   Elena Petrova <lenaptr@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Elena Petrova <lenaptr@google.com>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in_ubsan field of task_struct is only used in lib/ubsan.c, which in its
turn is used only `ifneq ($(CONFIG_UBSAN_TRAP),y)`.

Removing unnecessary field from a task_struct will help preserve the
ABI between vanilla and CONFIG_UBSAN_TRAP'ed kernels. In particular,
this will help enabling bounds sanitizer transparently for Android's
GKI.

Signed-off-by: Elena Petrova <lenaptr@google.com>
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index afe01e232935..5c7b8dec236e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1008,7 +1008,7 @@ struct task_struct {
 	struct held_lock		held_locks[MAX_LOCK_DEPTH];
 #endif
 
-#ifdef CONFIG_UBSAN
+#if defined(CONFIG_UBSAN) && !defined(CONFIG_UBSAN_TRAP)
 	unsigned int			in_ubsan;
 #endif
 
-- 
2.28.0.526.ge36021eeef-goog

