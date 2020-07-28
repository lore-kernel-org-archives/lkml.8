Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E91C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C8B207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgG1W6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:58:22 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33774 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbgG1W5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:36 -0400
Received: by mail-qk1-f196.google.com with SMTP id l23so20499736qkk.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOrXDcIpu0+Rojg4/uOteaJXevmZGAY4mWywC4YjIo8=;
        b=kX0lGGarpP3Jv3fkxaG+3St/l2VSWLG3gFHAqWdjvoLzHjVCriA/aOtYlqsXpjbeXg
         i94JdO85yBY2VxlxleEqceWWRxtzoIEGBU2DtfiTT/VrFhlNKwcYdQa/PpA7SrW90N5+
         SClLF9r+UHgeZhGXbqtiyHo6XX1M8lKbzNMWZcU0VtTxVYH8D0XUU891wrWFYeirXHxb
         RwCU7vpQrXaunOc7Hsoc92PwYg/0/OUC68WnSPZpGpyhL8NmFjRemOySLmPezquTY/cH
         +nKHuM9yfEb8Ye+EvuEd1NhfnVz42luQH92DlFoc1H16yTI9GnmO6pufwAhFhsgA5YFY
         Qa1Q==
X-Gm-Message-State: AOAM53088kyvbLuJ2DhJCjRVnWtmIdpxP6de69nqmIN7Bcysl/R9H9a3
        JjoCPQ4WVlDCpjKM2YVzZ8c=
X-Google-Smtp-Source: ABdhPJyxwsk2u0HOikw/58Mq/rgUkDYCvmYE3cDdqa3UIz1SiD81ewnyGKaqZall0ZdihlcG4BnDtg==
X-Received: by 2002:a37:9f48:: with SMTP id i69mr29693057qke.267.1595977055722;
        Tue, 28 Jul 2020 15:57:35 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:35 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/21] x86/kaslr: Drop redundant check in store_slot_info
Date:   Tue, 28 Jul 2020 18:57:16 -0400
Message-Id: <20200728225722.67457-16-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unnecessary check that number of slots is not zero in
store_slot_info, it's guaranteed to be at least 1 by the calculation.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index a87800aa6eda..2f43b0d7051e 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -525,13 +525,10 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
 		return;
 
 	slot_area.addr = region->start;
-	slot_area.num = (region->size - image_size) /
-			CONFIG_PHYSICAL_ALIGN + 1;
+	slot_area.num = 1 + (region->size - image_size) / CONFIG_PHYSICAL_ALIGN;
 
-	if (slot_area.num > 0) {
-		slot_areas[slot_area_index++] = slot_area;
-		slot_max += slot_area.num;
-	}
+	slot_areas[slot_area_index++] = slot_area;
+	slot_max += slot_area.num;
 }
 
 /*
-- 
2.26.2

