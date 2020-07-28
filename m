Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873ABC433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B2A207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgG1W6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:58:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37110 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbgG1W5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id b14so18749954qkn.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O1hWqNrLHKFZNuDvjce4/jLBMOMAYAvW4jfBzbGx2O8=;
        b=jo2i2e3nRbsIX3s4gjgCzhrdlJc5SHJKTveVPFvcwFuKsrXPu70g7toarRUvIUir4D
         P2FaJoYD/3jCDMwBvXw2vYIgieeW0eKnGXVNCQyDsK6bB0nQi0XAfmZiHWXPm48tgMfT
         8fkRrzNnsLrb+/0ytG+sTKIPi0uUqneH1ujrznxwU6zSoPQF8/1u4GNItvjE7q8ZxRIG
         cFJdDF1fqlyKflM+aL+jkC7M7TldXprufvUEWHgVrgnoU+JEu1yxTDKeYgDB9LjD70hx
         RcNg1qB98nEfy705VZMtKcdamWR5EthC6nJOXYJlA44fTslDDmyUJjE8tKY/8t3jGF29
         U1OQ==
X-Gm-Message-State: AOAM531+I+o2yCg2Z5qQRtseeHpQDa99xjwFVOIL1clmbQaf4wMo+mk9
        oQFVNHslui6Q/D8EjnUnkIA=
X-Google-Smtp-Source: ABdhPJwvpitgXf5RpWXfnkNO4WovC7TF/H8vQieNPQvRHjA0keS7CLU+rpA9xwXy1EMDska8T6SYqA==
X-Received: by 2002:a05:620a:676:: with SMTP id a22mr10632438qkh.8.1595977058169;
        Tue, 28 Jul 2020 15:57:38 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:37 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 18/21] x86/kaslr: Make minimum/image_size unsigned long
Date:   Tue, 28 Jul 2020 18:57:19 -0400
Message-Id: <20200728225722.67457-19-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change type of minimum/image_size arguments in process_mem_region to
unsigned long. These actually can never be above 4G (even on x86_64),
and they're unsigned long in every other function except this one.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 0e103d4d452e..b6ef77b644bd 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -648,8 +648,8 @@ static void __process_mem_region(struct mem_vector *entry,
 }
 
 static bool process_mem_region(struct mem_vector *region,
-			       unsigned long long minimum,
-			       unsigned long long image_size)
+			       unsigned long minimum,
+			       unsigned long image_size)
 {
 	int i;
 	/*
-- 
2.26.2

