Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEB8C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17806207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgG1W5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:57:35 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44397 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729908AbgG1W51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:27 -0400
Received: by mail-qk1-f193.google.com with SMTP id j187so20411594qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxsgcjV2U6R0bAkATN4y2iNIyTG55u4DxFZJ6Ep0G0I=;
        b=fiB4F64Vudygx8z9EeDsxZPuyIu4EQcFtnI/7XIABQKOEjeKMUTkGLW4ZUUEt4RSRX
         +Ww5gsjZ3lR8y07EGs3Y3FsjgQ+UnlBw6zNJlzU9kzgujwuEOqSfn92uotueNNEb3Kce
         Ifg+PRA1iy5FHuGw/IZocadAdaxsNCjI+RPM6v3UtrgS5MCF5H/2znKwygpJ485e5L8B
         zSEpOuMsq/qdfR1HesdB+EV1PbKE+Vx52kaNODo8VrQi8tw9k/O9nfepQXPRosh/Nd9t
         g13wxmpjTQt8P4GXqclHSAgm8Z6gEIpaZIZCuO+yyxt4JUMdc/qx6YHGkaoceTnSC9+O
         nvGA==
X-Gm-Message-State: AOAM533onholKI/vMNCRSI5FbThslQLUVKPtpb1UmKcVLgpG0RSLYAlm
        lzN1/Hx+F4p+GFF+0LndT+M=
X-Google-Smtp-Source: ABdhPJwZAoG5g63snvvMzoTJt4YRIDqEyjejSSUxUg/5xMDLJe8pjP9sUxfMu2SX+p4aR9+Z2aRl3w==
X-Received: by 2002:ae9:e506:: with SMTP id w6mr28784037qkf.376.1595977046074;
        Tue, 28 Jul 2020 15:57:26 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:25 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/21] x86/kaslr: Fix process_efi_entries comment
Date:   Tue, 28 Jul 2020 18:57:04 -0400
Message-Id: <20200728225722.67457-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
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
index c31f3a5ab9e4..1ab67a84a781 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -742,8 +742,8 @@ static bool process_mem_region(struct mem_vector *region,
 
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

