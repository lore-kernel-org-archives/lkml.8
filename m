Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536BBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9442622C9F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii2xA4EL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgHFStm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgHFStj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:49:39 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDCEC061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:49:38 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h12so806357pgm.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D4Ndr3lMfGWryT8BpcCBWbkT9Sd7Lw+5S6mzuxOjqm0=;
        b=ii2xA4EL8TIMLWF54Dp2D3VhPKG3XgrAie0iACmR72fXffFW1cOxQX92MCI/lEdir7
         aiWKHf1TWBOK6nX9AwY9weAMVgtlamS0j8rv0lEEpCYk8Sx9DtVaF04m+ex66WOfpLOW
         w+6j1GENJtWtRVPUlYXMuFjA5H93/0mYaVWDByZoRBN2uY/Ovzxc+qOzkh62Qgo5wTJZ
         9RQF56vRmATSiMczuxW5M1A+M/jVjIBCavXVLmXSSu/L/45HZqZgDfj5CNuZdSz4sQ8X
         XMEBwWr+27vlQGN1mX3SakuCPv/Xv5RTbd6Weohxn5Fgksuq1k+mBNr6vnr7YwsN38MR
         M19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D4Ndr3lMfGWryT8BpcCBWbkT9Sd7Lw+5S6mzuxOjqm0=;
        b=Km7PMwOKrYkS9xSkwx5j76LH9L7kM+wSN6U8+mp8/8a6JK0VJa4TNVYeeNk6BljqJV
         uj0yuvY6iD5HAyOHfETnX3ugz5lgwnXEbJGBqKMnxM2evL9zNiFz9H8tX/pUC7kt9Wq0
         0uNzmH6QpEfp9ORIf3DI0pAmsrKtSMGTlZ9/Ve/Gr4cX8c9OE/Qkat6LAU0yslU31lrQ
         AkcdnvTOFr2yboOXpwEtD0w88UrdOnyL8pxO5OW5U3SHWtpfCM/WCFf0Uq2X4Dh/0GIO
         tFyalWNI4Mf6hggUEjsdpGTh+OeRyG3wmp+J0AJVfgDPSMU/OGYgN41E6TAZluSrW1af
         WKFA==
X-Gm-Message-State: AOAM532mkRlFNkKI2i9rBPWxda39L8qU01ZAlz/sT4Zi1bRUzXiegSnE
        N1WWJnzS1DeBxWPBjythEQ==
X-Google-Smtp-Source: ABdhPJxXtfyq9aAepqkzQN6GNB2RBi2ndAap+zkgx75ukc39JHhcIPD5iEbccXFxp9BhTTjZ+9wlLw==
X-Received: by 2002:a63:7746:: with SMTP id s67mr8471318pgc.159.1596739778407;
        Thu, 06 Aug 2020 11:49:38 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id u24sm9096730pfm.20.2020.08.06.11.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 11:49:37 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/12] mm,hwpoison-inject: don't pin for hwpoison_filter
Date:   Thu,  6 Aug 2020 18:49:14 +0000
Message-Id: <20200806184923.7007-4-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806184923.7007-1-nao.horiguchi@gmail.com>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Another memory error injection interface debugfs:hwpoison/corrupt-pfn
also takes bogus refcount for hwpoison_filter(). It's justified
because this does a coarse filter, expecting that memory_failure()
redoes the check for sure.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.com>
---
 mm/hwpoison-inject.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/hwpoison-inject.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/hwpoison-inject.c
index e488876b168a..1ae1ebc2b9b1 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/hwpoison-inject.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/hwpoison-inject.c
@@ -26,11 +26,6 @@ static int hwpoison_inject(void *data, u64 val)
 
 	p = pfn_to_page(pfn);
 	hpage = compound_head(p);
-	/*
-	 * This implies unable to support free buddy pages.
-	 */
-	if (!get_hwpoison_page(p))
-		return 0;
 
 	if (!hwpoison_filter_enable)
 		goto inject;
@@ -40,23 +35,20 @@ static int hwpoison_inject(void *data, u64 val)
 	 * This implies unable to support non-LRU pages.
 	 */
 	if (!PageLRU(hpage) && !PageHuge(p))
-		goto put_out;
+		return 0;
 
 	/*
-	 * do a racy check with elevated page count, to make sure PG_hwpoison
-	 * will only be set for the targeted owner (or on a free page).
+	 * do a racy check to make sure PG_hwpoison will only be set for
+	 * the targeted owner (or on a free page).
 	 * memory_failure() will redo the check reliably inside page lock.
 	 */
 	err = hwpoison_filter(hpage);
 	if (err)
-		goto put_out;
+		return 0;
 
 inject:
 	pr_info("Injecting memory failure at pfn %#lx\n", pfn);
-	return memory_failure(pfn, MF_COUNT_INCREASED);
-put_out:
-	put_hwpoison_page(p);
-	return 0;
+	return memory_failure(pfn, 0);
 }
 
 static int hwpoison_unpoison(void *data, u64 val)
-- 
2.17.1

