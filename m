Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E761C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B5B2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="luZVTy7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgGPGPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgGPGPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:15:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2C3C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:15:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q17so3403800pls.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 23:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BkeEqRQbglHLv2yxtofvkyD/OehHy6oNANtsGj9riwQ=;
        b=luZVTy7UjWQeqvJTyQGhjEn7z95XImQrZqU+iNnwWxokUMRDYtwSemTMD7y5bkSP3g
         9qIO3hSZgW++89aBuG0RY3pc6ulqiWbUnYXFn/+nYIKsEC2ymEA1dqC82Qd3K+MdV+wY
         oR9SvqfHkyb6483Y1zQ4d7BY/EA4MqueqUkUK+Qpncc4CrIK3w5YlNMCPWtSJGzH5UyT
         rKV0OEJ7FXiiFUFcJ8oG5P8LSQf6uUpUlPm68p5cbztEs+yXN2aM8L2kIJeumrxOj2ok
         nnklSfRT3W9z9K3qY1oAkZNVYLow16oMb0C05DStCNGV/bV2AJC5edYO7j4uYKiViol9
         AL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BkeEqRQbglHLv2yxtofvkyD/OehHy6oNANtsGj9riwQ=;
        b=WFBc4O/94rdMqO+aEf995KOGkobD7dbqABEfBy3WLeOm70HQciXLCSvrcBfJ8/Kmkk
         qhQ+PB8qRJtjCZqGr4xxRBknS0H4O1O2WHP+sWKQgXwqR/ObPsik+6i2gdRYkP2idHTv
         dQ+v05WblUHODI3lH4//OJTfHylvCqf+FbBl09CiA6Z8EtZmZYE5NiagyOnV/Gy9SlAn
         IGRjiLRKLw9nHylwkWTPxsNWoiz+DCrAcxnLQk60iIKB1nkEPGalKpzAWIaQH7qTgBF8
         elDVnWzS7YblGWE4nY30j7N1z4NYeirGxlURRulpmeWMduL9kpjHemVFsn/ePi9tdNLk
         lEEg==
X-Gm-Message-State: AOAM532Ukl72Ak3GtY5CMkv8HQikeggai4laXS/IhVF1CzpWEOmESaHK
        F+OZ8ojwKiQ8p1sO67q1usevNw==
X-Google-Smtp-Source: ABdhPJyKpNHfOYu/JRAbP7dA11y+/AgGv5AEB0bowEr6EgODGQJV1nGoMa3mH6q5PKhBIgOBd7WSJA==
X-Received: by 2002:a17:90b:33cc:: with SMTP id lk12mr3446170pjb.194.1594880135171;
        Wed, 15 Jul 2020 23:15:35 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id w20sm3669904pfn.44.2020.07.15.23.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 23:15:34 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/2] riscv: fix build warning of mm/pageattr
Date:   Thu, 16 Jul 2020 14:15:27 +0800
Message-Id: <28365b581b04d0237e127363a63c1ad72dbea683.1594880014.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594880014.git.zong.li@sifive.com>
References: <cover.1594880014.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hearder for missing prototype. Also, static keyword should be at
beginning of declaration.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/mm/pageattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 289a9a5ea5b5..19fecb362d81 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -7,6 +7,7 @@
 #include <linux/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/bitops.h>
+#include <asm/set_memory.h>
 
 struct pageattr_masks {
 	pgprot_t set_mask;
@@ -94,7 +95,7 @@ static int pageattr_pte_hole(unsigned long addr, unsigned long next,
 	return 0;
 }
 
-const static struct mm_walk_ops pageattr_ops = {
+static const struct mm_walk_ops pageattr_ops = {
 	.pgd_entry = pageattr_pgd_entry,
 	.p4d_entry = pageattr_p4d_entry,
 	.pud_entry = pageattr_pud_entry,
-- 
2.27.0

