Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A3BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246ED246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ej0qYQRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgB1ABe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:01:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46017 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbgB1ABa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:01:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so457379pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oz6De1dIYEgjxhRabTRk4CB78qRzDNYlR7Nzf0r7zm8=;
        b=Ej0qYQRkax6vt9VbEqKCxSCRfVTpbF6R6yfkIQH8hH+HCk4aampkSCQAJSBx/l3Eul
         QYdGcYFrpkp7QbTQ9dqQZFDOh3Tk90FzGpRVXkXIXRjJeG0HLpM37JMU0ecBnf624Z4b
         p9gSB349m5UGPUQTt7tNnLStSo1C536+EubDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oz6De1dIYEgjxhRabTRk4CB78qRzDNYlR7Nzf0r7zm8=;
        b=mmDkEWlwj2JqVTzSnt4fC2o30QOp3Gj9FSAzi2py2tnilQLHwZDG+vNDhYl4WYlJdh
         HuUSaYOcDUEIZX25V23/Y6hdmU9zwD61mHCBo5AP0mlgOm4/ztuB0GNvXXOn6pGCTxD4
         kxyvyEgDr12igtSaJKD1Pnj1ER2jJJVvlx4Pmo0b0iJK4Z9OPYQtWgso+8h5UUYjmKIN
         eo+KKPyeB+Qrbi3hSyTNI2+HemroJFew1oYNzYLT6pdRkbGkVVCgIdj4pUMJEDRCf43N
         /M5r09oQZdgyAAZA3R5n2hRSDTT4uNR/xlhwX/nkoVI7XUucsJuk/Ft+4uG0DVVd6drz
         0Bzw==
X-Gm-Message-State: APjAAAUQM16sU9dWlX3u+bXvpJsKDlEyRGh7nDwMp4n4yXsP1DlyxOqF
        BvhKE9sOOUa6ucWkyoFlxRxu3A==
X-Google-Smtp-Source: APXvYqyeGsdTWhXYKAUlxHWjZxN7BX3EeYNWjLkfclN9Kp12cCBJnK2qIKd/H/GKqRV9XMIxr86Wng==
X-Received: by 2002:a17:90a:868b:: with SMTP id p11mr1609353pjn.60.1582848088646;
        Thu, 27 Feb 2020 16:01:28 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:6e62:16fa:a60c:1d24])
        by smtp.gmail.com with ESMTPSA id c18sm7314476pgw.17.2020.02.27.16.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:01:28 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 11/11] x86/alternatives: Adapt assembly for PIE support
Date:   Thu, 27 Feb 2020 16:00:56 -0800
Message-Id: <20200228000105.165012-12-thgarnie@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200228000105.165012-1-thgarnie@chromium.org>
References: <20200228000105.165012-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly options to work with pointers instead of integers.
The generated code is the same PIE just ensures input is a pointer.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/include/asm/alternative.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 13adca37c99a..43a148042656 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -243,7 +243,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 /* Like alternative_io, but for replacing a direct call with another one. */
 #define alternative_call(oldfunc, newfunc, feature, output, input...)	\
 	asm_inline volatile (ALTERNATIVE("call %P[old]", "call %P[new]", feature) \
-		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
+		: output : [old] "X" (oldfunc), [new] "X" (newfunc), ## input)
 
 /*
  * Like alternative_call, but there are two features and respective functions.
@@ -256,8 +256,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm_inline volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", feature1,\
 		"call %P[new2]", feature2)				      \
 		: output, ASM_CALL_CONSTRAINT				      \
-		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
-		  [new2] "i" (newfunc2), ## input)
+		: [old] "X" (oldfunc), [new1] "X" (newfunc1),		      \
+		  [new2] "X" (newfunc2), ## input)
 
 /*
  * use this macro(s) if you need more than one output parameter
-- 
2.25.1.481.gfbce0eb801-goog

