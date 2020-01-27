Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E2FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06ACE24682
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kq/LGvpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgA0TgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:36:25 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:43318 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgA0TgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:36:24 -0500
Received: by mail-pl1-f202.google.com with SMTP id n17so4303030plp.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 11:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MBXtYUj1QxYipcDyqZexYNOHIwmMYcL9qVU9w76TqMU=;
        b=kq/LGvpRySXRu0yzwNcC9o5kvB/Lf3EYScRJ6TjobnkWY/KSMsX71QlvFbaUrcvNdo
         4TgexVq0q81r+Xgp3UVJwsvgjPZJZfOT0/i6OVXMNdyBf+0uQWKenONfiKRj1Fss6TUH
         uwDT8piaaknCsIiJbuQsD2ibYnoPwH+ua7g4NIFN+B4RoH3urbqrk11neJCl+cSjEw31
         lDIkR549+4xbzG68w/SuYa2PPrvpKuD4p/tzg5d+h4Ct+2mdRTZlZVpv85a4qOIY5R8F
         VklCupGL8s3FhI9JtzU/r/U/hwb3VjcPY/dG2CCsgHEr2z0BkYH6rjBGituOCbP170LT
         aKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MBXtYUj1QxYipcDyqZexYNOHIwmMYcL9qVU9w76TqMU=;
        b=NEDiBrOFC2zdRMUNXPEs7dSLl/ldryvcBL7PupCJ/Q0EDKlT9L5fa+CQr0OtFvmmQV
         ja0mc8+PFJkUO09OuafrYoSz9xQY3A+ZhFihTmfmDk30fQsmdMYx2v03xGtsPIkTrxDB
         PD6Mm5/2JR+wlV4BDlavbd7eK5QWg8gm2s+ySxCRrdrKekWNYeu54Oy8dd2RaLR7U8Ak
         /CfJlxuJ2rzhGt0tPchid8MwIEDoRjHCDqegXmZ/NoXKwOtyNdHtfOG0kjQtAeF78k88
         vF4BJHFEdHcCdQyYWHrjwMHeUvVnJxGSni/uBM/Ts8+bdFnE6nJlOFihay86QwozYrZS
         JO/A==
X-Gm-Message-State: APjAAAWNhZJMtp8MXwhnk/o+/bDNYJ5KZAspjNBJLSGk93MNewwrromp
        FD716mCmOrc1UEaojqth4PsjOnWOKW6WRLZxXE3wdQ==
X-Google-Smtp-Source: APXvYqzw4bcDZfIlq+zGGc1Fi/VjEsM3ED5HMkJFARpf6yPisIbRpOks2FuWI9Odc+UqXEL26ieYokh9OM7CembMrnve0Q==
X-Received: by 2002:a63:78c:: with SMTP id 134mr20129191pgh.279.1580153784147;
 Mon, 27 Jan 2020 11:36:24 -0800 (PST)
Date:   Mon, 27 Jan 2020 11:35:49 -0800
In-Reply-To: <20200127193549.187419-1-brendanhiggins@google.com>
Message-Id: <20200127193549.187419-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200127193549.187419-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [RFC v1 2/2] arch: um: turn BTF_TYPEINFO support off
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        akpm@linux-foundation.org, changbin.du@intel.com,
        yamada.masahiro@socionext.com, rdunlap@infradead.org,
        keescook@chromium.org, andriy.shevchenko@linux.intel.com
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, heidifahim@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CONFIG_DEBUG_INFO_BTF=y doesn't work on UML:

scripts/link-vmlinux.sh: line 106: 17463 Segmentation fault      LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
objcopy: --change-section-vma .BTF=0x0000000000000000 never used
objcopy: --change-section-lma .BTF=0x0000000000000000 never used
objcopy: error: the input file '.btf.vmlinux.bin' is empty
Failed to generate BTF for vmlinux
Try to disable CONFIG_DEBUG_INFO_BTF
make: *** [Makefile:1078: vmlinux] Error 1

So turn off ARCH_HAS_BTF_TYPEINFO support off for the UM architecture.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/um/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 0917f8443c285..53e13d8b210e0 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -6,6 +6,7 @@ config UML
 	bool
 	default y
 	select ARCH_HAS_KCOV
+	select ARCH_NO_BTF_TYPEINFO
 	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
-- 
2.25.0.341.g760bfbb309-goog

