Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDE0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4CE206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M9ZSb4qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389731AbgF2Upp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731566AbgF2TN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:57 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E894C08EB01
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id q17so7445824pfu.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g0c7XOOnQF00ZfjeTQGIw9PaJthVip/aX3zS1dRtJoE=;
        b=M9ZSb4qoWIq549nkDC9nITi2Y+iOVB3dYWRDDV3WRmfzVjtQks65kDEF7l1+ij9SlB
         Ohi65fuChmNNYze5qrvJVk6IOjVJ/rxa8jvdv0qO+qmBCzMBaCbtUOo4//H/OjguzP5R
         T/UGeSUbVaM1bo/CG0rdGvwUKCmIM2bIikow4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g0c7XOOnQF00ZfjeTQGIw9PaJthVip/aX3zS1dRtJoE=;
        b=daR3UDIJ7K/RJpApQ8DwUWSM1bzWt2R3+hEHK3chSwwTRNPbwULKJ/wZQUJzxZgLvj
         Y2bvHHotB47XtygRQ2HvknKCYexle1VCKphe58Agj3Qv2PTZMwRw5sIZ+aFmPor2cj2A
         MO6a0FbG5maZ0Pz9+4e4nPy69wZqERyGEwrxZof6oLekZO3NWVa87O+tyJbu4nnz1QKh
         7bnolxI7FhYx0SYqQ7mHkrvSMQqMO+vw7cJNkWYA37z3zP2wKsBPzzYazCliEVO4Lgqp
         k6fSul9C1Gx2C+k8jmqHadreDHJKrxZ0nscSWPE54VTx3CGUBjwy2QM2SjyhJp5DUeKh
         DMAQ==
X-Gm-Message-State: AOAM530Vyq62UeWWzpfbidr4dTKCs5CWMs2KiAXvNlElXzXTvjIsKoRv
        aU0rl/3V+ZOSOxGnYkWwXDv/Pg==
X-Google-Smtp-Source: ABdhPJw58QIF5f/Yv5c9CUFM9Nx42xHsS2ePKHv+mXeT2M6dXWhB9Q/p3SvpYavVwb4WSrkztjUiRQ==
X-Received: by 2002:a63:4419:: with SMTP id r25mr2949678pga.198.1593411530134;
        Sun, 28 Jun 2020 23:18:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q10sm34391423pfk.86.2020.06.28.23.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/17] arm64/build: Use common DISCARDS in linker script
Date:   Sun, 28 Jun 2020 23:18:30 -0700
Message-Id: <20200629061840.4065483-8-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the common DISCARDS rule for the linker script in an effort to
regularize the linker script to prepare for warning on orphaned
sections. Additionally clean up left-over no-op macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 55ae731b6368..b5a94ec1eada 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
  */
 
 #define RO_EXCEPTION_TABLE_ALIGN	8
+#define RUNTIME_DISCARD_EXIT
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
@@ -89,10 +90,8 @@ SECTIONS
 	 * matching the same input section name.  There is no documented
 	 * order of matching.
 	 */
+	DISCARDS
 	/DISCARD/ : {
-		EXIT_CALL
-		*(.discard)
-		*(.discard.*)
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
 		*(.eh_frame)
-- 
2.25.1

