Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922CAC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63408206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="paSD109o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgCLP73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:59:29 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:48671 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgCLP72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:59:28 -0400
Received: by mail-ua1-f74.google.com with SMTP id m2so1027153ual.15
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OuMVG+rAcmfDAvofKjPIQX+VmSUPtt76BOeSoyVp0P0=;
        b=paSD109ofywT5exuwClXg1CpSkd67fvla0fLoNnI4B3XWrXO1LZuDc5ckHUaHkQbgW
         l47wGBvbLvyQrQ6YYYCIxFUyJlInvlCh+aUQlzbO1UW5IFkgkfal8cQ4Qw9n9u4Gnxoh
         eoF++guRlwiHbzd40JXsZOIhaUsXUnhBek/ux7DqflkZ3AxlGfHIwXhZlhOS+M7KFX6q
         Dfqvl1cqacnRW59uNGU6Du41IKysk6tl+6pLqEfFOztMPn+/3KmWHlPdVbaVY7jClPbh
         CDlSvMVEOr/1jfjPMh09yr9uHZfo+g0bmrWNasbg56KJiGAECyck83ntiZGShDqfF7OF
         5pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OuMVG+rAcmfDAvofKjPIQX+VmSUPtt76BOeSoyVp0P0=;
        b=abo9a1XACOIE9YGa7WjvMHlEC2uo5HoYYj4DRTwkZCza2idTIUHQs3BfsIqWrjbv5E
         ki1lBWUkl/sO4703LUVzLv8vSAiORd65Qxtl50t6emuWkVpkVYmUFCFDV5iVA53tvPh2
         VbsUPUhLxNYrkIKJocgRnmJ7tDlKMhKZ6lEUWgChhrvntq0ob5lblbHwodH6BgvxVy6Y
         itXs34c5KT5cMauZYA4RH8RMWyRXyxkDNwmF7HIA3UmPrO4X7r4HZbBy7275BY7PZ96I
         p+z6bKkHyPvJNejgGyelV5wne85YaVaMRz/ntTA8facMXj/gyC/fgPJ6UfvU+XOsUH8A
         j3zA==
X-Gm-Message-State: ANhLgQ2qXuOr5shz0ewvx/qMPF5nF0HJ8/7tc+FOCPTpja29aH0JrsQ9
        1flR+6FzudEXQ07hqfnhYSYzkFoDnRA=
X-Google-Smtp-Source: ADFU+vuX7lmrwStgO00QF2whBWVzujCp6g4AqJSb1iqI9dt6fK6BzDUAqsvOBASiE2eLCEGcMWhMcNAeQrU=
X-Received: by 2002:a1f:2c08:: with SMTP id s8mr5746912vks.53.1584028767311;
 Thu, 12 Mar 2020 08:59:27 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:59:20 +0100
Message-Id: <20200312155920.50067-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] arm64: define __alloc_zeroed_user_highpage
From:   glider@google.com
To:     catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running the kernel with init_on_alloc=1, calling the default
implementation of __alloc_zeroed_user_highpage() from include/linux/highmem.h
leads to double-initialization of the allocated page (first by the page
allocator, then by clear_user_page().
Calling alloc_page_vma() with __GFP_ZERO, similarly to e.g. x86, seems
to be enough to ensure the user page is zeroed only once.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/arm64/include/asm/page.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index d39ddb258a049..75d6cd23a6790 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -21,6 +21,10 @@ extern void __cpu_copy_user_page(void *to, const void *from,
 extern void copy_page(void *to, const void *from);
 extern void clear_page(void *to);
 
+#define __alloc_zeroed_user_highpage(movableflags, vma, vaddr) \
+	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vaddr)
+#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
+
 #define clear_user_page(addr,vaddr,pg)  __cpu_clear_user_page(addr, vaddr)
 #define copy_user_page(to,from,vaddr,pg) __cpu_copy_user_page(to, from, vaddr)
 
-- 
2.25.1.481.gfbce0eb801-goog

