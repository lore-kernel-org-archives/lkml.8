Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08808C3404C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03AA24654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKq416MA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgBTFKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:10:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41974 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgBTFKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:10:24 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so2494652otc.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h5u7Xp7U99NSUOO/E2a/GBuGs/jUCGPtflsLAzfdTyw=;
        b=AKq416MATIx767hbDafYSr2qGlA9d0kCZsKOTXysmdA4ZjamVtWxIESFgy81gdC/MM
         Osi0AV7tsnCCF44AW7O6HxRA9IwLWKT/yUa1kcN3W+9s9oOp/IWW5WE/ogU6ZL4+Uzfe
         ultzURxzO6w5kriTkIcy3B8CoSzb9C8d3/lExJH9S9erU70cFoAY5rrngi/SEmrKBPBR
         8axvuyg5iRLHKzKbbt6WmSdFb3qUHeWwSo/uDqQXITnYI28C+V2+0ZxqU/eaXOViv/us
         l/Fq2SpjU3OiamLvN/8sP8YlUXCPtkWoJ4Ce7m+lq0Cae7LbdYdCsGtqoaZh3UtNQJLM
         TZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h5u7Xp7U99NSUOO/E2a/GBuGs/jUCGPtflsLAzfdTyw=;
        b=uKycKxq5fOkjJILKeU7+txKangzl/bqePhsdOZD79xE6ZHsKn6FbVw2h4ZAt7MvYsL
         PCOBSC707OW1a1R9UAPWI3EH7qcXbP5CG7PJvhkg+ob+AxSz3+SG0yOMAgIubmyhU9Nj
         H9JVPRKUAx96/Ev6zU1B2Cp+ZN8p1826H2rD/B5aF+0M0hLk9879nNqbBo8mmIPHeMG7
         ezpzCH/zTfORQMBtgb9a/uzRAUY9k5/Ty1UotjRyYZx7RvLT77DTRQ4VI4QbMFQ8uz6i
         2CC23znUymbTm/GnRoocKDDfYR5arETnihj5diWrsNnug4lmxx4AkTSqBsm7UFK29idt
         38AQ==
X-Gm-Message-State: APjAAAW0NKdckDlmucWTY+hAVLHMXiqs9FAFYy9Qkrs7vHOjiTDaN8f8
        9cwnYTaRap3StuqoddiSMvM=
X-Google-Smtp-Source: APXvYqwg2Rjx8/JioE8aCnNVyEz+BeBgyp748izDXcZLNZaJYsRCg/6662zxTKvULPHKD0JHWTK9Ew==
X-Received: by 2002:a9d:6290:: with SMTP id x16mr21296090otk.343.1582175423669;
        Wed, 19 Feb 2020 21:10:23 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id g8sm745303otq.19.2020.02.19.21.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:10:23 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] tracing: Use address-of operator on section symbols
Date:   Wed, 19 Feb 2020 22:10:12 -0700
Message-Id: <20200220051011.26113-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../kernel/trace/trace.c:9335:33: warning: array comparison always
evaluates to true [-Wtautological-compare]
        if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
                                       ^
1 warning generated.

These are not true arrays, they are linker defined symbols, which are
just addresses. Using the address of operator silences the warning and
does not change the runtime result of the check (tested with some print
statements compiled in with clang + ld.lld and gcc + ld.bfd in QEMU).

Link: https://github.com/ClangBuiltLinux/linux/issues/893
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2: https://lore.kernel.org/lkml/20200219045423.54190-4-natechancellor@gmail.com/

* No longer a series because there is no prerequisite patch.
* Use address-of operator instead of casting to unsigned long.

NOTE: The code generation does seem to change, unlike every other call
site that I did this change to but the result of the check remains the
same as noted in the commit message and I cannot really understand what
has changed in the assembly. Please let me know if there is something
catastrophically wrong.

 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c797a15a1fc7..78727dd9a6f5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9332,7 +9332,7 @@ __init static int tracer_alloc_buffers(void)
 		goto out_free_buffer_mask;
 
 	/* Only allocate trace_printk buffers if a trace_printk exists */
-	if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
+	if (&__stop___trace_bprintk_fmt != &__start___trace_bprintk_fmt)
 		/* Must be called before global_trace.buffer is allocated */
 		trace_printk_init_buffers();
 
-- 
2.25.1

