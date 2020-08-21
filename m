Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE02EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9991F20724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TOCS9QXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHUTyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgHUTyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:54:01 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0916C061575
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:54:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so1355961plp.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLGrXrQrOnwocgl0d2lDlCmyCMk0LzJNzAhGu1QupvY=;
        b=TOCS9QXFvi2sKYKTRr7ee6kse0TEhswUvVuKqMoKi3tljAuSEAQbpwLZo0K9qaprrb
         0bsJpMg221HwjQsJw+E3oqeYuH95C/KSW+y5f5cGNHh1HZGSHWEcRCqDGVat33dSK1xj
         BvjA1iJ703xzao5ihIUvP0L+zcmeoM7uEoJQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLGrXrQrOnwocgl0d2lDlCmyCMk0LzJNzAhGu1QupvY=;
        b=CbCl7MEsp0sVDOy+FVKpwOCemy53CcabRZldmUpe9L0ULgXQOfnLGH8+Yma9xozgkk
         vAINFrT0ZgWm+niuCCR9BLsr+NA5CIRIQTOYkYME9bgv5x46d6l9y7wgft7iYGVLBn4n
         D/E+SeMzA0v+K20TTUuRPdzsDBL4U01ZO0gxSd5cTFF7g7BSD6ULEs9oxelL7Hx4IUhd
         dSdDzYLSiXmbpQrfEbiLSsNNFxR7IaII1cleNiDDSsB8kyZLDRoFkm+2euLSmPqRMcDA
         KXUw4vPyy7MKJOOU3fA8DzM8vBw37UPfRfQfhud8dG0fJ44lSjaE7dauRa20VfewDRcm
         BVow==
X-Gm-Message-State: AOAM531j5nlp2SDU2UlhUxexjXkHE9/WsvHQR1wFyjaXE7vr+XlddEhg
        g3eSu+VchA8VeLqUNc/3jpkbrg==
X-Google-Smtp-Source: ABdhPJxQwlh39B9Zs+13fgS+Mj5RyeBXBYwZUtq7yzKxm2wrKQBpH/KK+GuDxakqY9UBFLOVsfmNSw==
X-Received: by 2002:a17:902:c211:: with SMTP id 17mr2292148pll.343.1598039640054;
        Fri, 21 Aug 2020 12:54:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x26sm3139562pfn.218.2020.08.21.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:53:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 28/29] x86/boot/compressed: Add missing debugging sections to output
Date:   Fri, 21 Aug 2020 12:43:09 -0700
Message-Id: <20200821194310.3089815-29-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the missing DWARF and STABS sections in the compressed image,
when they are present.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/vmlinux.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 02f6feb0e55b..112b2375d021 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -69,6 +69,8 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
 
+	STABS_DEBUG
+	DWARF_DEBUG
 	ELF_DETAILS
 
 	DISCARDS
-- 
2.25.1

