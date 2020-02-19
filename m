Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00294C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB37422B48
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MxFF3Jv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgBSAIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:08:42 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:44131 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgBSAIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:08:40 -0500
Received: by mail-ua1-f73.google.com with SMTP id 108so4386129uad.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 16:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l6scMayGLTv8i90n5kl1qjpFIVxp1ij4wxIMmOxT7WY=;
        b=MxFF3Jv/EWuhcxvZl8W5ImYcIiftihQ17JrQuHbGUe20LeBqGWlX0Vs6EqB8LFvumk
         b4ZoyiHXFOiODzyJoXD5yx1cna013lW8Pi2WUil5kfKJ4aedq1jjXZg4P8fML2UAyTyQ
         /uNIUrr21WgVaMdydYT05C0JnLFxVqjKAJsDDyn+vQuSScdem6mYvmOJiF6hb0qLTEw0
         Smd2xgO77Gu1gxaZmS0EyOZN3oetuc1I+tCOXl2LodF41Ek5dZApBYffEvCiAu/ywSMJ
         +XuBMpKej6buzdbjJGHsVoEc5I0LNkBH4XpX2SCaya8u2R9u8a9PAO1CbeaL1bxUo0gF
         FQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l6scMayGLTv8i90n5kl1qjpFIVxp1ij4wxIMmOxT7WY=;
        b=Nm9dGyGMfPaDMjQqKgfjUGBKtRwEhd12RGyDdl7I5O85Lli/iLW48kQE/JcdOzfyKO
         AfWABFanU5h3qGUmuFvCX6ZeXskkcwQ8lDruSI2YwMHskD9BC40HxxNH/2eKoMNL090C
         3mAIfKUzXHZWGAlggNDddXemyK+JBg2QCnvg+1P+m9jv8xKil0PpsajDNTC2qyC0zlVQ
         FUAUl1Nb7lIEkoOvMaJ/0qM4a2RjWdwF9bLKZIWTDNGNUz1wYy7LwC0+42Co3gFFyCJ5
         W2r8CE5EfNuJAX1eynr++sz5isIYU0FRh1i6BZ4k6zLeA7t73SwQayV8xkcnqwALPuGV
         K+DQ==
X-Gm-Message-State: APjAAAXrBBNOHeqTeDYhwE416bogOOxEg1LmITfqYQ8RYzIC59b64a1r
        4e9jW7n4vNh/1oDm0Ja/eg3LCpt6OMz1iwi4OyY=
X-Google-Smtp-Source: APXvYqy3zHVo0z8Du/q8/Or94E/PkF5YNEjibMIbCyb79vcUFl2W+utvk9qo3cjFU6si1C3cTLmny5LfSy/puV4ifSs=
X-Received: by 2002:a67:f144:: with SMTP id t4mr12321250vsm.36.1582070919665;
 Tue, 18 Feb 2020 16:08:39 -0800 (PST)
Date:   Tue, 18 Feb 2020 16:08:09 -0800
In-Reply-To: <20200219000817.195049-1-samitolvanen@google.com>
Message-Id: <20200219000817.195049-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20200219000817.195049-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 04/12] scs: disable when function graph tracing is enabled
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The graph tracer hooks returns by modifying frame records on the
(regular) stack, but with SCS the return address is taken from the
shadow stack, and the value in the frame record has no effect. As we
don't currently have a mechanism to determine the corresponding slot
on the shadow stack (and to pass this through the ftrace
infrastructure), for now let's disable SCS when the graph tracer is
enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 66b34fd0df54..4102b8e0eea9 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -535,6 +535,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
 
 config SHADOW_CALL_STACK
 	bool "Clang Shadow Call Stack"
+	depends on !FUNCTION_GRAPH_TRACER
 	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
 	help
 	  This option enables Clang's Shadow Call Stack, which uses a
-- 
2.25.0.265.gbab2e86ba0-goog

