Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D9CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE9220768
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SPivvXbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbgF2VFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbgF2TMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB07C08EAFD
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c1so307000pja.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sx4qtxhnzkaAUuvKla0BBnxBLtInQMeed/tdFBRnaf0=;
        b=SPivvXbhkz1HNs4hv3hB3lAGf7mxY7QzuyuiHLUvE2NTzUDgKcMtvoCr5OvTnpEGNI
         BKEe727LLu354Czz0UrLwsb8Oq9z1awx0ZhcCb/nUDxWPW65pd8mBz8whR+nh3hBfift
         6e7dxeB4Nqxb9mSsbs5XD4usOXZc+u6wbNETc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sx4qtxhnzkaAUuvKla0BBnxBLtInQMeed/tdFBRnaf0=;
        b=Oc2YsfW7kFA6zDPAXcIEc/ot5VTskJjDHV9MaAzXF1V6tJSku6NyNwP2+AVH7Es0RU
         VpsUy6kojZSgIXRH93DsMPS2rtrKGf4xC1om0TXLvIYvRrs/gPVxCcpjCBp+RLb4K6Ns
         /Dh2s64RsjgiOtES1Ed+NpSxKaqWsZixUzNtMJJVvaZZT1CUfgsNoUdI/9SmwsbGKvZr
         i+JWZIw+asZ5Q4R7w8N9VL6CRmz/vz6XRpjWyusFCjwml4DUr0NwJC6UMgaFendvrQ/V
         P5xkr+FgfP0GqhTirbb9FCy4o4yN5lHkJL5Fxo6xSdWKVOPNm7E/lUr36+ZDOU6uZwOE
         MFkg==
X-Gm-Message-State: AOAM531tXXao//rE4Piq24p/2hKkgLpHi2xPXHqR8/HP1/tYdNcgxhs5
        YAc+QoDO8MQpMFS9zrwE0nQGeQ==
X-Google-Smtp-Source: ABdhPJwNi3xJzPNT7Gdq2Pw3b3VdTrLvNjNwn9RzBwTGL5D87SEILQ2r1+XLJOB0Z/PotUqW7oYIyg==
X-Received: by 2002:a17:902:6945:: with SMTP id k5mr11956092plt.336.1593411529540;
        Sun, 28 Jun 2020 23:18:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n65sm32225037pfn.17.2020.06.28.23.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>, linux-efi@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/17] efi/libstub: Disable -mbranch-protection
Date:   Sun, 28 Jun 2020 23:18:29 -0700
Message-Id: <20200629061840.4065483-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding --orphan-handling=warn to more architectures,
this disables -mbranch-protection, as EFI does not yet support it[1].
This was noticed due to it producing unwanted .note.gnu.property sections
(prefixed with .init due to the objcopy build step).

[1] https://lore.kernel.org/lkml/CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: linux-efi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 75daaf20374e..10fa342ef40c 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -18,7 +18,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
 cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
-				   -fpie $(DISABLE_STACKLEAK_PLUGIN)
+				   -fpie $(DISABLE_STACKLEAK_PLUGIN) \
+				   $(call cc-option,-mbranch-protection=none)
 cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
-- 
2.25.1

