Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DF6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B9A2100A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RC848NE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbgFXBtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388316AbgFXBts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:49:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8A4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:49:48 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j4so339829plk.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O2Y9k0Aoe2PsZ9fBDANRxjQwY2H7eXTSzLJBeV/fV9o=;
        b=RC848NE0i/SynoMx88lxwIqaEnktRv/S08z+yAGNh98QRc3g4glJaSAeh83V0/+vPO
         sjMdPL0uY1PkRniwXJCNB+xOulhCOQhUnpKwy+H221ODhthgAsjRcLSarVWaiOiWz7xt
         Cc8BPSg3mJr7EYRRdfSeZSgwISEHMenzA02OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2Y9k0Aoe2PsZ9fBDANRxjQwY2H7eXTSzLJBeV/fV9o=;
        b=ktEyzFoIawx9wXktB7wYxD8gGR8GSiy5YUo9f2trnT3ldTiLwisil/SXHdoNKLC3lK
         3VPIWF7VNXyRaqSZ2rOb5X3my7pXbYj1IsqucC2/i2JMrZxvJerPuYab3hcNDz8absl+
         APM+QTCqPjjA3vh2NGEg6+zk2abytAX20aA5yrdspwGlMxPMjGOLf9tokL6+vrNh8B23
         dv5tGhFn7vtT09pow6Ft3PvivqckBuECpJTuKaz3nQM5RpDWqSS32GgRtH/eoc1XAPN7
         wg7jvtPSnYLEVjzVcZjctYbgjAV0G/b80XgY2Y1S6T+9Xbu4+L5D0x6akkKQKk1sL5ao
         /2vg==
X-Gm-Message-State: AOAM533PMG0txVbpJCHZpSHELXlxDGAHQe6q5+VOs/l7iQm7obCrzVkM
        4n7cPwTv2IUodZGdWwgWAg2lMA==
X-Google-Smtp-Source: ABdhPJwbPwuYwHHFtJvDEYHOAcax4lPh//ndXHRqaZjT6O+W3S86MG1guQT1J9/rY7vF5ODXFge+OA==
X-Received: by 2002:a17:902:26f:: with SMTP id 102mr25557096plc.226.1592963387558;
        Tue, 23 Jun 2020 18:49:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mp15sm3524928pjb.45.2020.06.23.18.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 18:49:46 -0700 (PDT)
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
Subject: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
Date:   Tue, 23 Jun 2020 18:49:34 -0700
Message-Id: <20200624014940.1204448-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624014940.1204448-1-keescook@chromium.org>
References: <20200624014940.1204448-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding --orphan-handling=warn to more architectures,
make sure unwanted sections don't end up appearing under the .init
section prefix that libstub adds to itself during objcopy.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/efi/libstub/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 75daaf20374e..9d2d2e784bca 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -66,6 +66,9 @@ lib-$(CONFIG_X86)		+= x86-stub.o
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
+# Remove unwanted sections first.
+STUBCOPY_FLAGS-y		+= --remove-section=.note.gnu.property
+
 #
 # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
 # .bss section, so the .bss section of the EFI stub needs to be included in the
-- 
2.25.1

