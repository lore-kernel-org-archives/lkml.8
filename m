Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BF3C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A8620801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCEPFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:05:06 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38155 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgCEPFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:05:06 -0500
Received: by mail-qk1-f193.google.com with SMTP id j7so5311740qkd.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 07:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHZpwYtph4e4XvTwzjYe/dYk7V3T2U6hQ2PR81bE1+A=;
        b=SRElkZs6CD4wwqY7M+gUfpoPCqVVlDi7XhTe8FvuhyAt/x3GsxiSD+cgKS3KX7um8L
         WBu+i3kRQsqDpiCt+fFogzLAx+8w1lHJQCOW2kV7hNAy+DV5ZTePsWIj3247Hr7cNUQ7
         t/vj5d5XHaK4jwtBIoNouu8rF1lIXpwzme7uszyGnEOJ8bHq9nKzvELwjYY2Bsquas6h
         W4AWcfj6k8u3gghny3W3+Il6o7Kwt0kME/zXaRvMqT4/lzAksNfJb7mVdSA5r+ykvGwR
         xsZT1pONrpVCpsKAt13pmsYZOlpRkAJZYyPpS7MZ263/B0lhnKbdnWg+AvlQwm/79siz
         yuFg==
X-Gm-Message-State: ANhLgQ0sHWRFydI2G66ydIaGz5SE6RnvvpFmaAeZg81FRa7jJzR2PnNg
        AmbNrMoTeegUo7kLpoDrSK0=
X-Google-Smtp-Source: ADFU+vt9ZG47mHHNYOu4QgHGpZhfHLFcRTrsrZsiQHYCTpmwtRGsWnJknkOV5avRh+fAPtBGjB7vXA==
X-Received: by 2002:a37:aa92:: with SMTP id t140mr3685762qke.119.1583420705705;
        Thu, 05 Mar 2020 07:05:05 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 65sm16096932qtf.95.2020.03.05.07.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:05:04 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>,
        kernel-hardening@lists.openwall.com,
        Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org
Subject: [PATCH] microblaze: Stop printing the virtual memory layout
Date:   Thu,  5 Mar 2020 10:05:03 -0500
Message-Id: <20200305150503.833172-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <202003021038.8F0369D907@keescook>
References: <202003021038.8F0369D907@keescook>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For security, don't display the kernel's virtual memory layout.

Kees Cook points out:
"These have been entirely removed on other architectures, so let's
just do the same for ia32 and remove it unconditionally."

071929dbdd86 ("arm64: Stop printing the virtual memory layout")
1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
adb1fe9ae2ee ("mm/page_alloc: Remove kernel address exposure in free_reserved_area()")

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/microblaze/mm/init.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 1056f1674065..8323651bf7ec 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -201,18 +201,6 @@ void __init mem_init(void)
 #endif
 
 	mem_init_print_info(NULL);
-#ifdef CONFIG_MMU
-	pr_info("Kernel virtual memory layout:\n");
-	pr_info("  * 0x%08lx..0x%08lx  : fixmap\n", FIXADDR_START, FIXADDR_TOP);
-#ifdef CONFIG_HIGHMEM
-	pr_info("  * 0x%08lx..0x%08lx  : highmem PTEs\n",
-		PKMAP_BASE, PKMAP_ADDR(LAST_PKMAP));
-#endif /* CONFIG_HIGHMEM */
-	pr_info("  * 0x%08lx..0x%08lx  : early ioremap\n",
-		ioremap_bot, ioremap_base);
-	pr_info("  * 0x%08lx..0x%08lx  : vmalloc & ioremap\n",
-		(unsigned long)VMALLOC_START, VMALLOC_END);
-#endif
 	mem_init_done = 1;
 }
 
-- 
2.24.1

