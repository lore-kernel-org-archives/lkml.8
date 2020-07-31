Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CC5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD45720672
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mhl2cYQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgGaXSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgGaXSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:18:13 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102CCC06179E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:18:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id lx9so8528820pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OztuNRy+U3SEjaM8AjX3NHKuvNzCSaFSb4g4nlKxjN8=;
        b=mhl2cYQ2YEfGFzqu0lUm7PTEdf3xYEpybnJ2cfLPuY6LR4v/YBY5dJ0ivTK2K5UAQM
         0k9arXuQB4cv1bpNG0r3VncPs3HFypojskLqEB3mHI/LVxckqJONf2cBzIIP4It97oIL
         ccOz8l1eiz5ARWhIbuGZYnApCYc1UDxK86u0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OztuNRy+U3SEjaM8AjX3NHKuvNzCSaFSb4g4nlKxjN8=;
        b=SGRieyauZMQonZVl+C1HBQoykkE6gINAmRMse0oz6gb0ZE8Q0+Hn7sEjxLgYWMD6f2
         67iShsjRmnkef2AEVJfUQqdRdTOXbx1LOW40y1ntUJ40XKwrBK7EBW5Ruy8tBKGTkI8G
         fqo5INkfOV0JwIDs2kBqvkc7jkvBCeONf3/kb11SEauP42628z8sA7wH6CIhNIyjrG6D
         3Jbt1cqlgKN+aL60Lic5NNBj5jD2SvuTTyISIYfcPQHsKvZ9TEWOXVkxGSaL6MtVVwyu
         r/12F6EDHAyEQEPfVn3OJ8V9wDP6SMD7tdDDQL8+qODLAebsUW7IBh6vmhB9V/tjSWw6
         6spQ==
X-Gm-Message-State: AOAM531NeoIRskH4g4T4MRkN+DUDOGhaBaAaPaoCdhFJEtg60ZTZt9Rn
        dMMAvjKx/uT8TxuuJfyQ0MSqMw==
X-Google-Smtp-Source: ABdhPJy7boJ2rVpqxGdhrmjmUcJo5jNiV0bmJoTaMG0L5+Tg8lheY4n/pMplx9rYVCtqWI1ZntGMZg==
X-Received: by 2002:a17:90a:6c97:: with SMTP id y23mr6284010pjj.28.1596237492647;
        Fri, 31 Jul 2020 16:18:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9sm11932082pgh.94.2020.07.31.16.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:18:11 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
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
Subject: [PATCH v5 19/36] arm64/build: Add missing DWARF sections
Date:   Fri, 31 Jul 2020 16:08:03 -0700
Message-Id: <20200731230820.1742553-20-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly include DWARF sections when they're present in the build.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5c1960406b08..4cf825301c3a 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -240,6 +240,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 	ELF_DETAILS
 
 	HEAD_SYMBOLS
-- 
2.25.1

