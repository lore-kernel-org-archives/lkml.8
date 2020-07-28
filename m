Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0A2C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B016C207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgG1W5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:57:42 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45945 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbgG1W5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:31 -0400
Received: by mail-qk1-f195.google.com with SMTP id u64so20414227qka.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WjLPXpYPdYtXDDTE3El4LanUu/hXqncSApiFUMGDGnw=;
        b=HXzTvstUzRvwe0JH3sO2ZfoIBlIO6XzyGQwXjkgUwCvYtz4l5NGOVMzHKX//m5zh5c
         X0G5ThFgoanIxwAWEnt+k5e1HsjIOiEMSDp693JjIUliJn9JEdis4xYpIFd7aDkkGE9R
         124qj2TNB/TWOQj33hh+fvdusga/iq3mWmVyoTwnQSYK5tog6nqfP/9gvVf/EdwJjj4u
         Fze19gJQjKbDXaTqPQY7VoaGakTqvwt1onUQJR9uHKaHkw5b1QM7sJXcrZYATSklG6xM
         cUVa70gdq8wibQioV/e4zjwYbZ6mLwJz5JXElHZenfyg/86t77sM7i0g8WjsJqBx+aON
         NSUA==
X-Gm-Message-State: AOAM530cVlUzcq/chi4F3XNh75MZQBsxU2DSpR0s9E/JAZDHASxsQD+J
        bUVn5ERXYSIP3nLrTaAbMM8=
X-Google-Smtp-Source: ABdhPJwa79pX3uJWhG+NAeME7TFagqmiAu1TAkdmKnHpXWSgrk1KmA1nHEHwaN48BHbaYoKOEqL4wA==
X-Received: by 2002:ae9:ef01:: with SMTP id d1mr29281552qkg.64.1595977050013;
        Tue, 28 Jul 2020 15:57:30 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:29 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/21] x86/kaslr: Drop redundant variable in __process_mem_region
Date:   Tue, 28 Jul 2020 18:57:09 -0400
Message-Id: <20200728225722.67457-9-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

region.size can be trimmed to store the portion of the region before the
overlap, instead of a separate mem_vector variable.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index e978c3508814..8cc47faea56d 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -664,11 +664,8 @@ static void __process_mem_region(struct mem_vector *entry,
 
 		/* Store beginning of region if holds at least image_size. */
 		if (overlap.start >= region.start + image_size) {
-			struct mem_vector beginning;
-
-			beginning.start = region.start;
-			beginning.size = overlap.start - region.start;
-			process_gb_huge_pages(&beginning, image_size);
+			region.size = overlap.start - region.start;
+			process_gb_huge_pages(&region, image_size);
 		}
 
 		/* Return if overlap extends to or past end of region. */
-- 
2.26.2

