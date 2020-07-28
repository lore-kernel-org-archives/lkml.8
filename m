Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5C8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 644E6207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgG1W6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:58:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38107 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbgG1W5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id e5so2217521qth.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/0Hv8egtXRA3ZfKQLWZwrjHsDw+rPLpy2TWbxUcFE4=;
        b=Pb7EJ8/cXrtZICd/7VwSyxSa0mD6ThmcXvrs0BEyWF2DfViXLNYrsByAR3ngYy+qPG
         D4FYF6oc/F+MRmUdIl5iX3ssfjbtmh1XCMdAgYKG8Pt7ZsqViyNCSq5O9BgwDAUVs8nh
         WPM4Kx6V2STxSqTXLERz0SztTYhnVxQbomk7zHLvvOtnUs6INN8AYdrf1q+7wGYCftYC
         uFCkpnN31et535kQXv3yG4OD7iYRGanlUCBPfnomCtFuvcyl5uuu/VEJoEo8Cttr+G8b
         LV944yBO4jmFa5cVbeaI+0ya0zEK2BpKSXJVh4x0Jix2voab/rXPTQpNx0hsf5DqmVmz
         FmYA==
X-Gm-Message-State: AOAM530RHKWwTqJ3xeK6Y+6ok3igoe0UvQSmhN9QYsvmK0+twehGJb7a
        cNkg1eRzoQobQiaf0HMrCKgQv3jD
X-Google-Smtp-Source: ABdhPJwXddcqfBErVmabYAWErKRchWfnGb1mA4Hve9Hz0Jby7VczYVKw+drpuBsidyLeY+nQc15bSg==
X-Received: by 2002:ac8:454f:: with SMTP id z15mr9908929qtn.351.1595977061350;
        Tue, 28 Jul 2020 15:57:41 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:40 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/21] x86/kaslr: Add a check that the random address is in range
Date:   Tue, 28 Jul 2020 18:57:22 -0400
Message-Id: <20200728225722.67457-22-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check in find_random_phys_addr that the chosen address is inside the
range that was required.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 38ecbf2e61c5..903ccdca0551 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -802,6 +802,8 @@ static void process_e820_entries(unsigned long minimum,
 static unsigned long find_random_phys_addr(unsigned long minimum,
 					   unsigned long image_size)
 {
+	u64 phys_addr;
+
 	/* Bail out early if it's impossible to succeed. */
 	if (minimum + image_size > mem_limit)
 		return 0;
@@ -815,7 +817,15 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
 	if (!process_efi_entries(minimum, image_size))
 		process_e820_entries(minimum, image_size);
 
-	return slots_fetch_random();
+	phys_addr = slots_fetch_random();
+
+	/* Perform a final check to make sure the address is in range. */
+	if (phys_addr < minimum || phys_addr + image_size > mem_limit) {
+		warn("Invalid physical address chosen!\n");
+		return 0;
+	}
+
+	return (unsigned long)phys_addr;
 }
 
 static unsigned long find_random_virt_addr(unsigned long minimum,
-- 
2.26.2

