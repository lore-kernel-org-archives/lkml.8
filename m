Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81446C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FFF246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R0fDgyKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgB1ABS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:01:18 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:38503 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbgB1ABO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:01:14 -0500
Received: by mail-pf1-f182.google.com with SMTP id x185so706252pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fvhzUd6Qu7cjrcCOJttmYiBqe1hyVQ5v3hyhsFuyKi8=;
        b=R0fDgyKLTHQkfsWhWRkFBROySWE56w7r6inEPzUviguIQfBELPtivu7yY4Ik9lv7t7
         /nOIfMq8t2T13X1qgjHYJJ5cidxN2ymJ2qiAEIYtGpRaD6z6Ni0j6HvemLNDgKpXyqwv
         tyPUm4U3B3hIYcksrbm95hIv5aO+ZSAMYtXnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvhzUd6Qu7cjrcCOJttmYiBqe1hyVQ5v3hyhsFuyKi8=;
        b=NUByVmltX1I1K3zt1On2XlOFQEwKqU8eU5PFIajxIK7YTy5S/o5MGW0p9YkRRFSkwH
         Lcon7pnjealRX05CG0rnQMuN6vu1vLKEuxGIaCPoHya2rZshoBBiPi3D2I0EJxuyQvvl
         csLWVTzAPwdZwybuOAr8TgsJ47M6Gy5I1CpO6MtyZtc5xTxQdSfz2GAWEDeyOYdzYb5+
         N7GuJllUIHwuvT6Z3vWgJ7U/wnzecNAYI9eqg/xTrykQpHyKxCGmE3Gh8qYIfkihqKCg
         tjNszC9EyXbKH5aLfWC5Hx+nBVHDGZRI8s6SSNtqeQA0z+cZVt2pW7RnLalkJ0uikrJE
         UOPA==
X-Gm-Message-State: APjAAAWqS05nGXcwDvvbiPjHctE2hH83h5d9Cz2tqLtzuW6AUoStDlQK
        qxSOiyvrGZivOpmYqC+OqEyAjw==
X-Google-Smtp-Source: APXvYqwThB4LJ42cXGHIwD4VP+n+OceP9p72vw3hubV+kmuIORRSU7xn+cXTMOPaKk/qKAWgjHeHnQ==
X-Received: by 2002:a63:4e22:: with SMTP id c34mr1833461pgb.263.1582848073452;
        Thu, 27 Feb 2020 16:01:13 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:6e62:16fa:a60c:1d24])
        by smtp.gmail.com with ESMTPSA id c18sm7314476pgw.17.2020.02.27.16.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:01:12 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v11 02/11] x86: Add macro to get symbol address for PIE support
Date:   Thu, 27 Feb 2020 16:00:47 -0800
Message-Id: <20200228000105.165012-3-thgarnie@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200228000105.165012-1-thgarnie@chromium.org>
References: <20200228000105.165012-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new _ASM_MOVABS macro to fetch a symbol address. Replace
"_ASM_MOV $<symbol>, %dst" code construct that are not compatible with
PIE.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/include/asm/asm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index cd339b88d5d4..644bdbf149ee 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -32,6 +32,7 @@
 #define _ASM_ALIGN	__ASM_SEL(.balign 4, .balign 8)
 
 #define _ASM_MOV	__ASM_SIZE(mov)
+#define _ASM_MOVABS	__ASM_SEL(movl, movabsq)
 #define _ASM_INC	__ASM_SIZE(inc)
 #define _ASM_DEC	__ASM_SIZE(dec)
 #define _ASM_ADD	__ASM_SIZE(add)
-- 
2.25.1.481.gfbce0eb801-goog

