Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E03C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F10207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgG1W5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:57:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34081 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729958AbgG1W5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id x12so7727270qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nW2VBq/cRDmniFEJbcbARyqEcq2nkZVSxT1F5MUGWsA=;
        b=R/9bXLNFYXSxT49BSLgUDWsBLVVJB2kkTVI9cfXHATBFUYT9HCylPJHakdAoA9332x
         qK5cGKcpwx0shAnkwy66nLlY2JLWtBentNvAZEk/WzaXOJD1llaQ938PF9CjAeVGuf0i
         AA92xBAUnvGRi76fnMwwlDzST4GCHZA5KOR1DdCiP97oYPZPcXpKBtA/DDFWq3aHeWf7
         iXD+iRhH0pRi8fUMAdWFc8rvQw7WpLspTPUjZZqzG3R0cJnAIqwiMMcQ2HrTRFhgR/1X
         C3TPryEvS9jcDFYXbdL4qzmkuGjHCVeC7LNwM72dmFsvq9cBo1Dieu4EVXuQEX99atzd
         qZGw==
X-Gm-Message-State: AOAM533JdOES61gmAL2+76NiKMfSBotO/0102LOlaNSGDyyS0ISYjsZF
        goOohszWCdXJNvqfukI8D90=
X-Google-Smtp-Source: ABdhPJzyWa62eFDYsRQXofvnI6i1Rqt77uWsU/ZMOLAWOE1gSkKig2aH4aQ4qI0BN1RYOXqpzwZcpA==
X-Received: by 2002:ac8:7454:: with SMTP id h20mr28348878qtr.84.1595977051396;
        Tue, 28 Jul 2020 15:57:31 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:31 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/21] x86/kaslr: Fix off-by-one error in process_gb_huge_pages
Date:   Tue, 28 Jul 2020 18:57:11 -0400
Message-Id: <20200728225722.67457-11-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the remaining size of the region is exactly 1Gb, there is still one
hugepage that can be reserved.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d074986e8061..0df513e3e2ce 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -562,7 +562,7 @@ process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
 		size = region->size - (addr - region->start);
 
 	/* Check how many 1GB huge pages can be filtered out: */
-	while (size > PUD_SIZE && max_gb_huge_pages) {
+	while (size >= PUD_SIZE && max_gb_huge_pages) {
 		size -= PUD_SIZE;
 		max_gb_huge_pages--;
 		i++;
-- 
2.26.2

