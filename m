Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF5FC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039532075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgG0VvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:51:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35009 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgG0Vux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:50:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id 11so16846936qkn.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9T+6TTM2jquV/2xo6rzyYgs+MoQ8msgYOchHxJqCp/Q=;
        b=Z3loWG6KW4RGWDf4uzs1B9sGWN8tCuCnVqN5LYnzHINGICtmxejLHnYHJs4AzE5ePa
         raMkj5wJZCEQJxZZRNxgMKHetFnQUDQr7CEfgQ6+lftn7s4Xjim7s0uvDTERW521J2lg
         eWCUd6CEIWXxrlaCYfH2pKt+aG1zCGoYK/V4/1zw1n0CKWygwORNhHc0FDlDQYHagFsu
         b/MLJjITRrNuXKSudKJhrtgl1fTU86sfklyKhP2p9e4fe+ymQDsNcuIyzF0OvnRAI8Eh
         XaQOjVNyT5K7qWkC1+PkaJO4l1VVhHnco79YmCfkkQY64MtrSl0eeJ1ZmcJw0y0qVN0G
         GpZw==
X-Gm-Message-State: AOAM530URolssWvkbGjfGhHW0Yt9D1RZ9KcNOdTom2OqmGsclJWsLmSa
        QKBInX0b8ucBD602sHdFYYga0v1w
X-Google-Smtp-Source: ABdhPJy2xNWHvfQmp1PbIEJArxugvJ1DIXxY//nerGTV7Iv0yl3q5gj2Nu3AsBOxtj0fRJ8/Ixys1Q==
X-Received: by 2002:a37:9ccf:: with SMTP id f198mr25740900qke.168.1595886652252;
        Mon, 27 Jul 2020 14:50:52 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n90sm15629338qte.21.2020.07.27.14.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:50:51 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] x86/kaslr: Fix process_efi_entries comment
Date:   Mon, 27 Jul 2020 17:50:42 -0400
Message-Id: <20200727215047.3341098-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727215047.3341098-1-nivedita@alum.mit.edu>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit
  0982adc74673 ("x86/boot/KASLR: Work around firmware bugs by excluding EFI_BOOT_SERVICES_* and EFI_LOADER_* from KASLR's choice")
process_efi_entries will return true if we have an EFI memmap, not just
if it contained EFI_MEMORY_MORE_RELIABLE regions.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 21cd9e07f1f6..207fcb7e7b71 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -741,8 +741,8 @@ static bool process_mem_region(struct mem_vector *region,
 
 #ifdef CONFIG_EFI
 /*
- * Returns true if mirror region found (and must have been processed
- * for slots adding)
+ * Returns true if we processed the EFI memmap, which we prefer over the E820
+ * table if it is available.
  */
 static bool
 process_efi_entries(unsigned long minimum, unsigned long image_size)
-- 
2.26.2

