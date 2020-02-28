Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C49C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C139246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GXN2TwlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgB1ABX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:01:23 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34407 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbgB1ABU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:01:20 -0500
Received: by mail-pj1-f68.google.com with SMTP id f2so3724596pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UhZ7upFOZbJwSu3t6sj7kyMuepSiW+0wthtVyYvfUW8=;
        b=GXN2TwlTYNwiK+ybctcNCG0N1o4mmEfgJ3tnGih4vm5ywp9y4TrkN7Ufd9T3240JQy
         E16DACTSaDDNdfolSmZkf2EnIwxAkoDtU4kGsVdvLeQnFGFncVNe6tE644aMszLX9q3B
         X299mdovMzxD4NedWt/1mwa1YRvXp1azy1t/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UhZ7upFOZbJwSu3t6sj7kyMuepSiW+0wthtVyYvfUW8=;
        b=qQPC4yeo15WmcvVhmgUxVUXeEpaVC+tssrteEIoNZ9h3EaLAendSKL7IQEtCKD05Uw
         9MiwqjPWFoDGq0m86/DvSAT1/E6tH0h2O1qE0eJpuSRMUFRHlaE5JY0cPQ2iJOdyEI3n
         bFCm22/+qXySayR30C9mQx+MraWHH6y6/zsOsllo4+Q2AHb9SpSsbBfYfvW6mA5jxPIW
         8wXTEd2RUDpIyF/2SGEJcwn4sdgPRpqD7V694VBCYrf1QtcAKb1XjHhcC8AHtVkSjWHZ
         H8Iptv5LfxHKZ7BoLbtrgX27r58+o9KeCMczTZp85HI9636fWAfxR+uT680jDbJsc0QA
         68Zg==
X-Gm-Message-State: APjAAAVQJeYwYbkidw+y8Hs1mtVDbKrDUEjSY1iDF5qPWudhktwDZI18
        PxYjRPrM9LNLERUAEuJaY00wAA==
X-Google-Smtp-Source: APXvYqxiJCqNV8OEfXmb1fBc5jiE7n4/3DOvj4v7SG/Rln8ytNDHgILInJ8gkTkQ+TEqyjFoPLN0cw==
X-Received: by 2002:a17:90a:d80b:: with SMTP id a11mr1588095pjv.142.1582848079067;
        Thu, 27 Feb 2020 16:01:19 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:6e62:16fa:a60c:1d24])
        by smtp.gmail.com with ESMTPSA id c18sm7314476pgw.17.2020.02.27.16.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:01:18 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 05/11] x86: pm-trace - Adapt assembly for PIE support
Date:   Thu, 27 Feb 2020 16:00:50 -0800
Message-Id: <20200228000105.165012-6-thgarnie@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200228000105.165012-1-thgarnie@chromium.org>
References: <20200228000105.165012-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change assembly to use the new _ASM_MOVABS macro instead of _ASM_MOV for
the assembly to be PIE compatible.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/pm-trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pm-trace.h b/arch/x86/include/asm/pm-trace.h
index bfa32aa428e5..972070806ce9 100644
--- a/arch/x86/include/asm/pm-trace.h
+++ b/arch/x86/include/asm/pm-trace.h
@@ -8,7 +8,7 @@
 do {								\
 	if (pm_trace_enabled) {					\
 		const void *tracedata;				\
-		asm volatile(_ASM_MOV " $1f,%0\n"		\
+		asm volatile(_ASM_MOVABS " $1f,%0\n"		\
 			     ".section .tracedata,\"a\"\n"	\
 			     "1:\t.word %c1\n\t"		\
 			     _ASM_PTR " %c2\n"			\
-- 
2.25.1.481.gfbce0eb801-goog

