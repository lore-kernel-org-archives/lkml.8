Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E435C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E685E20714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i/kVRB9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgC0Gsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 02:48:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35963 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgC0Gsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:48:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2so3113269plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 23:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ziE3u+JHVGjUbo7zvAcqmvTGnTDwDeNLGHtkAuW1SE=;
        b=i/kVRB9h49fSIU/SXBBd76YRq+m2dKmO90EFoN2azRXHRsGFnN8fQwX1bWQShxfMO3
         fsJCr1ApPfPLWPyVmqTHbvnE0/TQ+9Ft1N7AnyEv2Obi+yKqae7pHIiFGbj+dcCs3Qth
         hx/8AA5HN+FRYM8rSleK8Ggvfe0bb3ThM++NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ziE3u+JHVGjUbo7zvAcqmvTGnTDwDeNLGHtkAuW1SE=;
        b=oJKL+v3MnXs5m8uWSBvxYn1VpqKaOGvgKLmX8q0FVS1aYOy1b+p/evyeAyFneyS/pB
         wNb50Evj9tgbRGFKmG1MKDeUH3EMnssZnKPaVh07qQ36J/I1arHeKBnkJKQ3OdDsSMr4
         ki8Z+Kgfb9MHag7ziD3LBFdg7pagYCgMFV4s+Yo3g359QTSNpBuDk0X5yepZFbjKTs3T
         YH5siiWb81nCQcLWRTbQr2asQSkZnkEIQmgHSClZ4uLAtiaBqOxiIWjJJRXTDrirdphC
         B5Yff72NJUAiMGaTV9oPfcU+9DtqAKW4889kwFT8Seg8v4b4WeNJOmNM0CRURWjRw4TZ
         iwVg==
X-Gm-Message-State: ANhLgQ3LHvBi8jSBf9v2sq4u/QIGDjLqAscXF4bvKCwqGVTOyW+z0q+8
        +mBpI6I0dCM1aPulq7p657XhMA==
X-Google-Smtp-Source: ADFU+vvGmOrrIs+Qj5TkNUJrkUU3G9n3+Tfo2n/9fFwWG4WT0SaqW8ECI8HTyCrm6d42Hjl+wwoUXQ==
X-Received: by 2002:a17:90a:b395:: with SMTP id e21mr4362227pjr.33.1585291708788;
        Thu, 26 Mar 2020 23:48:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e184sm3275892pfh.219.2020.03.26.23.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 23:48:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/6] arm64, elf: Disable automatic READ_IMPLIES_EXEC for 64-bit address spaces
Date:   Thu, 26 Mar 2020 23:48:20 -0700
Message-Id: <20200327064820.12602-7-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327064820.12602-1-keescook@chromium.org>
References: <20200327064820.12602-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With arm64 64-bit environments, there should never be a need for automatic
READ_IMPLIES_EXEC, as the architecture has always been execute-bit aware
(as in, the default memory protection should be NX unless a region
explicitly requests to be executable).

Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/elf.h | 4 ++--
 fs/compat_binfmt_elf.c       | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 0074e9fd6431..0e7df6f1eb7a 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -105,7 +105,7 @@
  *                CPU*: | arm32      | arm64      |
  * ELF:                 |            |            |
  * ---------------------|------------|------------|
- * missing PT_GNU_STACK | exec-all   | exec-all   |
+ * missing PT_GNU_STACK | exec-all   | exec-none  |
  * PT_GNU_STACK == RWX  | exec-stack | exec-stack |
  * PT_GNU_STACK == RW   | exec-none  | exec-none  |
  *
@@ -117,7 +117,7 @@
  *  *all arm64 CPUs support NX, so there is no "lacks NX" column.
  *
  */
-#define elf_read_implies_exec(ex, stk)	(stk == EXSTACK_DEFAULT)
+#define compat_elf_read_implies_exec(ex, stk)	(stk == EXSTACK_DEFAULT)
 
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index aaad4ca1217e..3068d57436b3 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -113,6 +113,11 @@
 #define	arch_setup_additional_pages compat_arch_setup_additional_pages
 #endif
 
+#ifdef	compat_elf_read_implies_exec
+#undef	elf_read_implies_exec
+#define	elf_read_implies_exec compat_elf_read_implies_exec
+#endif
+
 /*
  * Rename a few of the symbols that binfmt_elf.c will define.
  * These are all local so the names don't really matter, but it
-- 
2.20.1

