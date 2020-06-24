Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D9CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED78206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwaotPoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404157AbgFXPBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404142AbgFXPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:01:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A1EC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:01:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s14so1157298plq.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lCfhSpDjLg0oQm41kWMqoMza5V2vl2PVe0Cy2zdpUs4=;
        b=UwaotPoi71Q37vlpe0idrCVUeedFZnNJi7hm4BN/zg+fqUR/nfv8+x/cMKGbRswW6K
         nDRh8yun2BNbgOmjhg2BmgGXGsFf5M2ZAr4Kl9dTIAVodNCsqmTIEXtEURu/4SURPh14
         vqVq7YW5Ctj0JIxt6FtaNcx5DQp9AmkIHpEXWmAX7iZZ9fxUbVkfo9ptpLZS1+zqe5z0
         FUvFEpMYMtvuni7uuKF2E7BLXluQ8BAoYlp02MLUDRykv138y8b9a+Q234TNYXVq20NG
         n7utb0dCNuvTssYtKNY2gC5CCPvqqsCksE3B0/Lj80ocPbu+XsGOH/sWKJ7rrlim8cFS
         62Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lCfhSpDjLg0oQm41kWMqoMza5V2vl2PVe0Cy2zdpUs4=;
        b=Gu2Lky/D3iHA2PvryO8lQgaPhJwizm80cSTK6FFlYK4DKyLPJ79WbZvhr9/NdF2ST3
         NEa2T0xXLMSG0mM/L4NmcKTZy+y+jQCvGpAStm5QjpekXxrz88YHlj1RHfqz0o29tNUV
         5jeIg16w5LU+ctfKBjYCLYmtpDvO3dnwM20PLhEiuZ+RyBKUy67wi5YByL92WQw6KlqX
         beJqyTwKII0KjtnqrGhmirNAX8Vfl5irM97zLsfaHzVRIJPu/70NqvRILINc728O0QI4
         CRyIjsbSR174gEBfhh8srR5i3a0qS729MDB7HlRq9yDjk1biktl5TE0N+oKycxwRjG0r
         yFyg==
X-Gm-Message-State: AOAM532yhOiA4VtZtqQG1wUDCTtanydkbCDrPuDhZ/vV4rVRpEstH1my
        wI0tCoUPb01ha5j9vWhNxw==
X-Google-Smtp-Source: ABdhPJw1QP92/ouJDzFZIrN4onjqHXS1nPeUFAid6e2y7e70YPrRcwv0Aq6U4DIjcbRurGP8vn/3eA==
X-Received: by 2002:a17:902:d207:: with SMTP id t7mr12891961ply.251.1593010905510;
        Wed, 24 Jun 2020 08:01:45 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:01:45 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/15] mm,hwpoison: cleanup unused PageHuge() check
Date:   Wed, 24 Jun 2020 15:01:23 +0000
Message-Id: <20200624150137.7052-2-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Drop the PageHuge check, which is dead code since memory_failure() forks
into memory_failure_hugetlb() for hugetlb pages.

memory_failure() and memory_failure_hugetlb() shares some functions like
hwpoison_user_mappings() and identify_page_state(), so they should properly
handle 4kB page, thp, and hugetlb.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
changelog v2 -> v3:
- add description about shared logic b/w hugetlb and non-hugetlb path.
---
 mm/memory-failure.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
index 47b8ccb1fb9b..e5d0c14c2332 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
@@ -1382,10 +1382,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * page_remove_rmap() in try_to_unmap_one(). So to determine page status
 	 * correctly, we save a copy of the page flags at this time.
 	 */
-	if (PageHuge(p))
-		page_flags = hpage->flags;
-	else
-		page_flags = p->flags;
+	page_flags = p->flags;
 
 	/*
 	 * unpoison always clear PG_hwpoison inside page lock
-- 
2.17.1

