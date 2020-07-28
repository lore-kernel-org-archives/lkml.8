Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98951C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71553207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbgG1W5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:57:38 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45201 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbgG1W53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:29 -0400
Received: by mail-qv1-f67.google.com with SMTP id u8so9949749qvj.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OMnubwGWNkxOlXGZw761HD6boF9d3RNrqDqbu6PUc7U=;
        b=gvk8X077k+xdgwDv3ES1pckyBCx1vT+eOlOhArwtGk5i7QIo52tBnKCUaYd47b1sMV
         hP82HPKEvwDJgc+8Yr4sL8bTcZ16xc8F7V0Y7n9T+OLN9noMI2OIxa8pj/y4gEtfgxb6
         wISgNWidmlVr0c9N6t2Dnt2oKp2f983zz8RIBqG1DkRVFqE/MyAOImNvuUwJPjaWuxzP
         1S8hM+Iz3HNhRTKnzqXCuBCF4zoKSoNPvvyw3t48UxrdEvdZin7FBke+wZN0krrycSXs
         +G8wkWitt3q4gZZBal8/HIBGTi9YZuMrOXwGXhjOLP6Qhc3Y9b2WNaML7E0+VkEdl2dl
         GajA==
X-Gm-Message-State: AOAM533Kw52o3jb8JPJBh2stsZ77VVlqzSeC45PLFv8UPiFFVS3saNZr
        UBkxd6xAgKpeNk24kSyhWolcmhtV
X-Google-Smtp-Source: ABdhPJxLEOSAAlN6S8lri5KBs/pFoSxfcvjieKTuj5HTgD9wboRS/AqpLYuVVIe6weSzYlh/lH/Egw==
X-Received: by 2002:ad4:42ad:: with SMTP id e13mr30316677qvr.89.1595977048325;
        Tue, 28 Jul 2020 15:57:28 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:27 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/21] x86/kaslr: Drop redundant cur_entry from __process_mem_region
Date:   Tue, 28 Jul 2020 18:57:07 -0400
Message-Id: <20200728225722.67457-7-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cur_entry is only used as cur_entry.start + cur_entry.size, which is
always equal to end.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 848346fc0dbb..f2454eef5790 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -624,7 +624,6 @@ static void __process_mem_region(struct mem_vector *entry,
 {
 	struct mem_vector region, overlap;
 	unsigned long start_orig, end;
-	struct mem_vector cur_entry;
 
 	/* Ignore entries entirely below our minimum. */
 	if (entry->start + entry->size < minimum)
@@ -634,11 +633,9 @@ static void __process_mem_region(struct mem_vector *entry,
 	end = min(entry->size + entry->start, mem_limit);
 	if (entry->start >= end)
 		return;
-	cur_entry.start = entry->start;
-	cur_entry.size = end - entry->start;
 
-	region.start = cur_entry.start;
-	region.size = cur_entry.size;
+	region.start = entry->start;
+	region.size = end - entry->start;
 
 	/* Give up if slot area array is full. */
 	while (slot_area_index < MAX_SLOT_AREA) {
@@ -652,7 +649,7 @@ static void __process_mem_region(struct mem_vector *entry,
 		region.start = ALIGN(region.start, CONFIG_PHYSICAL_ALIGN);
 
 		/* Did we raise the address above the passed in memory entry? */
-		if (region.start > cur_entry.start + cur_entry.size)
+		if (region.start > end)
 			return;
 
 		/* Reduce size by any delta from the original address. */
-- 
2.26.2

