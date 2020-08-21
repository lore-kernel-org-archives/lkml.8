Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401A5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE902076E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i/HEp8a1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgHUToj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgHUToW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:44:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C11C061795
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:44:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so1258081pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KJKUmMIwELFiu+Jhx3PR/flYgx4mAaM57h538oQIMM=;
        b=i/HEp8a1E4h+pDbbs57HZpbPpxh1OsfRH2Yd/8W3bgSphxcIhvxHJMoOUFbJ6b/Lo5
         9aJS4qOv+ZRLhprPhhQyVLMufErKaJZg4b7i1PWzbmYDeM8hm39fYJLK/IT+cxpFTdWz
         TuXn2CWgQSDT0wuxFJZoOlwQ2qTgwxpZ9CNOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KJKUmMIwELFiu+Jhx3PR/flYgx4mAaM57h538oQIMM=;
        b=Cy46xjAY8OAvgrN/4hSanS/N4yfwKvVVsbJZ5bjuxXwJ6Sygy8KqECLqrwZ4UXXLOO
         vcB+EOX532jXxsegbeP7RdPpfhZ+rrtoJMBW1xi4XiXCM9MrtDTmyvcwwAa4tufCy0aQ
         0fli9c6fiQWl3j3chIV65lcgdDcvtIyyRI0YXl8AjgTEIg/YIWKx21bodU+I6flF5NOJ
         Q1lwAWKVp/xIk0kruJ7FeUCa6BtTNAddAmDymUZ+Tdl/NRHXyS5DIXFpBro9Q9AgbOrI
         T8liRgM8kf+I5QOvFQkCBGttrpIidYBH7Orav7f08arHuLkm6NOhfP+UQsmL0fi+X5Tq
         M8nA==
X-Gm-Message-State: AOAM530NUORDPPOZIWS+5z4V8cbOaBw1MfTjGQPL+lWsVcAc3ww1KOw9
        r5BA+6ZogIqee2sYTKMuvmJfpw==
X-Google-Smtp-Source: ABdhPJxhYfHQFi07yXAb+83c2N6Go68l40rd8GM9whIQP8616kjUIICp3ghwUq5gOnKTYPsXxrBOoA==
X-Received: by 2002:a17:90a:4f45:: with SMTP id w5mr3754850pjl.11.1598039062148;
        Fri, 21 Aug 2020 12:44:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b9sm3354866pft.98.2020.08.21.12.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:21 -0700 (PDT)
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
Subject: [PATCH v6 01/29] vmlinux.lds.h: Create COMMON_DISCARDS
Date:   Fri, 21 Aug 2020 12:42:42 -0700
Message-Id: <20200821194310.3089815-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collect the common DISCARD sections for architectures that need more
specialized discard control than what the standard DISCARDS section
provides.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7616ff0b96ec..184b23d62784 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -954,13 +954,16 @@
 	EXIT_DATA
 #endif
 
+#define COMMON_DISCARDS							\
+	*(.discard)							\
+	*(.discard.*)							\
+	*(.modinfo)
+
 #define DISCARDS							\
 	/DISCARD/ : {							\
 	EXIT_DISCARDS							\
 	EXIT_CALL							\
-	*(.discard)							\
-	*(.discard.*)							\
-	*(.modinfo)							\
+	COMMON_DISCARDS							\
 	}
 
 /**
-- 
2.25.1

