Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DFFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED0D20829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgG1W6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:58:18 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37105 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730034AbgG1W5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id b14so18749891qkn.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qi173Z4bhMQyR0fQT50/DyIWcqMl6dO/gU6zmOPbzuY=;
        b=sHZ7OiaHuv1YvVUsUzzGaQMB783U12goumOZ/85sXn8RjgIbRJn7CX3ktzG+MP3cXK
         xzXgsEYv4xbf/xYlMCHcQ5nC6eBg6DxJ4obRyfFj+qQ7WtYy7sB3Xu/sM67+CoGp2SJG
         Vxx5xB3T7BZdz2xiZKbcX4KtlDbvGcM2Yg+cIISkI0R36Al1gX/n+PIX9G+cUzPM/Is+
         VEtD0lOWaoBCx71XDZbre8OVt+W8zs6av5+qPP7Ul9bO2tapdiEENs42HxLC3MBpVWQH
         rrCZirsIm4L7y5UVz84wYAawzwLNkYchWZhCIA2RfQPkm1Sh6LrBjiqjgj1sBlbV8Egb
         TElg==
X-Gm-Message-State: AOAM532rGSqxVVQoZGDdXrfTGkdvscBabPTx16qAwRKvW3xMXFywBEVf
        iAeTvzh2ZNtxFiTkCIJ37tX8fGD5
X-Google-Smtp-Source: ABdhPJznQ2QOqhPFhb/TCtB5W2vcw4gyYNRQ41ID5w0R7nhgEqPSXTeqV+XpOrvXbVFcPuv5AgVtug==
X-Received: by 2002:a37:b847:: with SMTP id i68mr29531505qkf.126.1595977056552;
        Tue, 28 Jul 2020 15:57:36 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:36 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/21] x86/kaslr: Drop unnecessary alignment in find_random_virt_addr
Date:   Tue, 28 Jul 2020 18:57:17 -0400
Message-Id: <20200728225722.67457-17-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unnecessary alignment of image_size to CONFIG_PHYSICAL_ALIGN in
find_random_virt_addr, it cannot change the result: the largest valid
slot is the largest n that satisfies

  minimum + n * CONFIG_PHYSICAL_ALIGN + image_size <= KERNEL_IMAGE_SIZE

(since minimum is already aligned) and so n is equal to

  (KERNEL_IMAGE_SIZE - minimum - image_size) / CONFIG_PHYSICAL_ALIGN

even if image_size is not aligned to CONFIG_PHYSICAL_ALIGN.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 2f43b0d7051e..4fd60eff048f 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -824,16 +824,12 @@ static unsigned long find_random_virt_addr(unsigned long minimum,
 {
 	unsigned long slots, random_addr;
 
-	/* Align image_size for easy slot calculations. */
-	image_size = ALIGN(image_size, CONFIG_PHYSICAL_ALIGN);
-
 	/*
 	 * There are how many CONFIG_PHYSICAL_ALIGN-sized slots
 	 * that can hold image_size within the range of minimum to
 	 * KERNEL_IMAGE_SIZE?
 	 */
-	slots = (KERNEL_IMAGE_SIZE - minimum - image_size) /
-		 CONFIG_PHYSICAL_ALIGN + 1;
+	slots = 1 + (KERNEL_IMAGE_SIZE - minimum - image_size) / CONFIG_PHYSICAL_ALIGN;
 
 	random_addr = kaslr_get_random_long("Virtual") % slots;
 
-- 
2.26.2

