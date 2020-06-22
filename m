Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA11C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 835582073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d59awIr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgFVU6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgFVU6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:58:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CDCC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:58:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x207so8965009pfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NMAZshRZgRqtOcF48FwBwSDWqy/EeeOlwf50Pbmu5Nk=;
        b=d59awIr4ey2GlJF/nDZanKh5lasAZo0gqNs/Sj2FIbT3dV7+NE4F8QpEjKuFoUgbUB
         uNSVKl5PXzhurvRvd7umfMa951SJmZaHGs+OHDW7cINgEp28wHsTCyqp2DgG9k6wOO/q
         CKRpJktmKcbV+N0XIDIfQpCT8fpjSnYxg1JYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NMAZshRZgRqtOcF48FwBwSDWqy/EeeOlwf50Pbmu5Nk=;
        b=bJ885okM9LpzbDwXVg3rtrhMyD/akIuqeUvdvDCDkTwybikjA3QiMCQN0AIMRN9gNz
         Cwo7fkrR6Xr7yJ4kSDIPF83aOEbXph8Fp3eU/G3VwPVN57971wIS3XsalICYMO+2i0EF
         2j1Ny/rVvCi+IyEJ+82Us8Y7NzsDUV/a1cVNE24sfxhTEXyc9RcPVJm5ALFhp8ZQK9ea
         3BjYEhuoC0DlyDnjYPP3sS6tJmJucL1SudwCi2XknN7qbY1ibHyy/jd8VZUwZxfHV+UH
         ylkpsG3Hc+o71bEAH5YiAGwqbZeWl+GgZjO99/V5WWzU3kaVniBWF82SlrzkPJFhfPOh
         uk0g==
X-Gm-Message-State: AOAM530Iu+V7BCyrJ23rkdXK1f9qbeVI8lkIgYke6bFbcwgrK8NRUOzY
        cxxvVLnHb05gmaakZ4YhSVd3vw==
X-Google-Smtp-Source: ABdhPJzCXskTt3PimftTRWl/F2Ox5bixevxXdmAFf+vVuL+pxDEUYcX6Bsehddn5WdAfEWSHkb44cw==
X-Received: by 2002:aa7:8f1c:: with SMTP id x28mr4466138pfr.19.1592859498597;
        Mon, 22 Jun 2020 13:58:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c194sm14351376pfc.212.2020.06.22.13.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 13:58:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64/build: Use common DISCARDS in linker script
Date:   Mon, 22 Jun 2020 13:58:14 -0700
Message-Id: <20200622205815.2988115-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622205815.2988115-1-keescook@chromium.org>
References: <20200622205815.2988115-1-keescook@chromium.org>
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
index 6827da7f3aa5..5427f502c3a6 100644
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

