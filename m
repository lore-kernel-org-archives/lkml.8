Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AF2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE98120708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RoM8+KMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgHNR3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbgHNR20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:26 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54698C061386
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:26 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id m13so7432471qth.16
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PrZ8Xx7ZOES69PjxJ7W+uco2MTpU8K38pV5r5s6HLuc=;
        b=RoM8+KMI2h2GGKlzWuBgOR8Py0rNY7TZMU06j0CyrdWaNMgFm+s8aVx1SJGX4Gx0Yu
         7iL0jYVGq/ZpqBnKxoozCPmzSxL5lsRQMy2MGg2ljRc0JK9qid+eJ2ca8kYM11IVazPU
         5D7wAuSxLeuNoPDkQezSRD7cNU5Z09U4lP7ujCWlF7UV9xrPSIT3wWXn4AmlrwKCmmZ6
         MvANSRo5c7D+PDmzdXHvWcV6sxBbvbluV5BCCH721wPS6ssCiOTdk5t/CEy4TJHFjQzX
         YS8XRg4nwVZIqyKJ+wlb4D/ziTqK/qXt72NUwCDuxOh4M1MUX8qf3kZgQYHweBxv5nTr
         VPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PrZ8Xx7ZOES69PjxJ7W+uco2MTpU8K38pV5r5s6HLuc=;
        b=XlSsZkrEgwq758SP3ENb0E0fgzj3DvAwreaez0jeZ2Yr2XswAWoK5s08bbkUOaLrVQ
         KDlFdAnQ0wZOw7UuGk9Z89mS3/jG+KQ5jQLwdXyNFJ8q77r3yiBYWc0+piZWMBJTh5o6
         l131PQJT7nVlZ735h2falKODlhWrQG7W8ev+ITx7ZFM02ZJuErCEleSwKL5A39ErbAIM
         6+DfyuRj9tLoTzGBPvmIOxLvuletQH+s1IxwB2AdOFP7HBaA48WutWCE3WcmrzLt62NG
         SZjY1mxTClZjrjggWVqBtugAo6MZysmv2BWAamRWezFnXxvX4OAQ9qqBCeJfHhBEjSTS
         CyHg==
X-Gm-Message-State: AOAM530oB4kBJFq0zpjPYPS2YuzvZC6iV4hY3iVg69Eq7hTvH+8RIxRB
        VA9aFp3omy8snb7c3fWry9V0pe27U6hjH0AQ
X-Google-Smtp-Source: ABdhPJyLILHteR8XQv6ASUjnKzzYpuETsrstUrOhCFHCsdKqZXOKezDHAwecoNC7DdH7utKm4OIpglyx7bKUIliq
X-Received: by 2002:a0c:99c8:: with SMTP id y8mr3624054qve.57.1597426105434;
 Fri, 14 Aug 2020 10:28:25 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:27:08 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <518da1e5169a4e343caa3c37feed5ad551b77a34.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 26/35] kasan, arm64: Enable TBI EL1
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

Hardware tag-based KASAN relies on Memory Tagging Extension (MTE) that is
built on top of the Top Byte Ignore (TBI) feature.

Enable in-kernel TBI when CONFIG_KASAN_HW_TAGS is turned on by enabling
the TCR_TBI1 bit in proc.S.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/mm/proc.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 152d74f2cc9c..6880ddaa5144 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -38,7 +38,7 @@
 /* PTWs cacheable, inner/outer WBWA */
 #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
 
-#ifdef CONFIG_KASAN_SW_TAGS
+#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
 #define TCR_KASAN_FLAGS TCR_TBI1
 #else
 #define TCR_KASAN_FLAGS 0
-- 
2.28.0.220.ged08abb693-goog

