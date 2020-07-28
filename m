Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391B1C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15327207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgG1W55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:57:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34945 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbgG1W5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:36 -0400
Received: by mail-qk1-f193.google.com with SMTP id 11so20492660qkn.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dNSYx7QuqbdceKBdwhN6fCKRHjxwvqPZcsL5ENuSalc=;
        b=Z7HpIf0bho1u+/4M9dDMWl7ayjKRYSUgcngLRP1y28MmpKbS2wxAhgey6CoUr99O8B
         L/o1Tb1cuARqeQB4GgqsfVgBf1b6Bkcj+1zpncutNdQuAhFCWoaqpxGQAhit4PxxTZ95
         CJuJcMM3wIqkA7Yg84ziEWX5MqEa3tesmSmgN/tKlpbWVlMBd70kInquSIBdHh3k9PEn
         rG8hJcvdXwGIbXssOLzCAO0w+cOpewYWM1G2KzWIuVQt8j5OBMZgCay8n/goWJLZjiev
         vP1vjV7etsnBmV/z+H8+vkbaoCR39/QJVvwfPUOlefwh8tAe9w1OvbcIFb6FA9QkBwpA
         7sCw==
X-Gm-Message-State: AOAM533Jx/SmXxFimrOqyPagFtrJ3/rZa371JYbl1NE31WjQSNzil4nC
        Zi8fQ+7/iAFo0HDvOpL4T6w=
X-Google-Smtp-Source: ABdhPJywZoX2TD1Hzfe3N0Gmo1AOqQFiJfglZN52iaR9G0ny6Kfzd1SqZkB61i2rhf1WL6ydJWW4fQ==
X-Received: by 2002:a37:9b15:: with SMTP id d21mr29433068qke.87.1595977054884;
        Tue, 28 Jul 2020 15:57:34 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:34 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/21] x86/kaslr: Make the type of number of slots/slot areas consistent
Date:   Tue, 28 Jul 2020 18:57:15 -0400
Message-Id: <20200728225722.67457-15-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of slots can be unsigned int, since on 64-bit, the maximum
amount of memory is 2^52, the minimum alignment is 2^21, so the slot
number cannot be greater than 2^31. But in case future processors have
more than 52 physical address bits, make it unsigned long.

The slot areas are limited by MAX_SLOT_AREA, currently 100. It is
indexed by an int, but the number of areas is stored as unsigned long.
Change both to unsigned int for consistency.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 7c69fc10a782..a87800aa6eda 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -508,17 +508,15 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 
 struct slot_area {
 	unsigned long addr;
-	int num;
+	unsigned long num;
 };
 
 #define MAX_SLOT_AREA 100
 
 static struct slot_area slot_areas[MAX_SLOT_AREA];
-
+static unsigned int slot_area_index;
 static unsigned long slot_max;
 
-static unsigned long slot_area_index;
-
 static void store_slot_info(struct mem_vector *region, unsigned long image_size)
 {
 	struct slot_area slot_area;
@@ -587,7 +585,7 @@ process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
 static unsigned long slots_fetch_random(void)
 {
 	unsigned long slot;
-	int i;
+	unsigned int i;
 
 	/* Handle case of no slots stored. */
 	if (slot_max == 0)
-- 
2.26.2

