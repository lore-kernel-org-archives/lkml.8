Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA1AC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0744D205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGSazxkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgD3UEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgD3UEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:04:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A564C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 13:04:01 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v63so389055pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 13:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3uYu7BNvYOGkc20ha5J/aAEuQ9mqiqPvOhd6B04IV9A=;
        b=tGSazxkG8iYHiUGg9z3/ziD1PrpzsJN0F3Z1dORQ7Lpsim1xwidMONGsRPJ5i6TIa8
         Ro0kGSUn6+g60gIxEx3izxAB8anYPikqtdWH/SBGq9X8ZnrV4u350g2uzSUTwwSaVMZ4
         kq86ccSa6s/5dcVxw1c/KnatDxOlEoiqV5ylkxWYexqCNvOeTZc20y86t+0wpLoxs957
         Kd+bU7HbT77Uz/hYbgM/rHszPt+BO8GZMK2I3sUx9HX14m8lPgTu5ZHY6dzDFGNYugtb
         Yhpj+TDa9LnXngnK52vp1458SlM3EFEtOVFKAORfQRVHNakAzKtJynEFFx8tjNVX5IxR
         N3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3uYu7BNvYOGkc20ha5J/aAEuQ9mqiqPvOhd6B04IV9A=;
        b=KszNxgyhab7vVIFASVG7fJfCEkCiC8GsH313MRk4krgjt6EjhxSrbPxIwC0hX/cbYE
         4FFljRJCxuQhiWxRK03wP1R5bVnt8OnbGdm8gXGkiAG33tkW2GlCyW6H8vHD53aTI3qu
         DP10dZLaOpZTgqvDA2ybcUdJUu90RUwTh+iqtqSMrnttXvPqX2kART5z91R9Bs7mSBJ9
         58pdA5RuX4bkvwepfz7016JfsfTWQYi1ecUolJQnqPlJtsDrZtBUWEBQoJ/nbE262Lng
         sbKKzD4f6AZNS2KHi9q6RTAw2Ne9y6wvddHfTUbYaIYuOUxZKXjjldcKGwO5N6ctahjq
         30Kg==
X-Gm-Message-State: AGi0PubyJHKdVu3NoUsUuMaNOZqSCqg4vlRPj4g4EuJaeaEcqaDkacJX
        xxoh+3R4PI46vz3FDDLdBJcVXEDr170=
X-Google-Smtp-Source: APiQypIf4/p4n46Y+IEjO+M6yY4VM/WoDWLGSGYfUACAiDEVQx5qHNSIGKtwIF+Wzsx+xE4EUoJqVQ==
X-Received: by 2002:a63:eb15:: with SMTP id t21mr599223pgh.279.1588277041057;
        Thu, 30 Apr 2020 13:04:01 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.167.43.171])
        by smtp.gmail.com with ESMTPSA id e5sm528000pfd.64.2020.04.30.13.03.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2020 13:04:00 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] mm/gup.c: Handle error at earliest for incorrect nr_pages value
Date:   Fri,  1 May 2020 01:41:58 +0530
Message-Id: <1588277518-21425-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per documentation, pin_user_pages_fast() & get_user_pages_fast()
will return 0, if nr_pages <= 0. But this can be figure out only after
going inside the internal_get_user_pages_fast().

This can be handled early. Adding a check for the same.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 mm/gup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 50681f0..a13aaa6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2817,6 +2817,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 	 */
 	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
 		return -EINVAL;
+	if (nr_pages <= 0)
+		return 0;
 
 	/*
 	 * The caller may or may not have explicitly set FOLL_GET; either way is
@@ -2854,6 +2856,8 @@ int pin_user_pages_fast(unsigned long start, int nr_pages,
 	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
 	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
 		return -EINVAL;
+	if (nr_pages <= 0)
+		return 0;
 
 	gup_flags |= FOLL_PIN;
 	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
-- 
1.9.1

