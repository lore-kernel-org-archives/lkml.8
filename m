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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D72C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52511206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQ5vFoRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404177AbgFXPCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404156AbgFXPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:01:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB18C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:01:49 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m2so1268279pjv.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=44MI/Xaebogle3byf0K/hbjxI15crYL5kj8QhCCzmQA=;
        b=EQ5vFoRhF+Dxmx9u/l3YuFN2NQ/we8WRaTM7Lbb+HasxiRQIshvNWwzDn2TRo6H5h8
         NJFxR9veJODp4lBLCyrYVN+Cya1oe+8ppdH1N2LYrhOVXuXbQgNH/UIampBwrC1S9jrw
         kbjWyxO0XJ7ocBMiWBt5cFImGcAQYU/yrdeqzbGPidbceWfEdNLUzOPJh9wXOiTTzi/I
         OQ89WCvmCYd9I7AxgSoVLgcBrLyFXjBV0LSD2/M7uyCz3zZa/mrnn7tZPekS5UT2JXU0
         3diAQnd8ZB5E0ZhFmPYz8tDI8Utwg3ZPtvYhtZkcq8Kfu8viHjXwsgai4ic7ZyG4y9xe
         P6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=44MI/Xaebogle3byf0K/hbjxI15crYL5kj8QhCCzmQA=;
        b=TUSIquZtJesi2W3jdC96CQC9Vwq33sCjf1PXF9tBfiyghUb4ACJ0/2MjqSxV7q1vnF
         pzByqCc4NCcaWzSzJV5JdK9qb+aqXBT2Ty/XTDKuqavBewo+CIlYjrkf0JVaaSRyzNOd
         jhQufkSr8okq5XUyh4fpsv8J4P59ifkDE7enDt6/SaSAM7ELGkM+8M+wZBmf2WAS7lrl
         jF6mQ8Ujau4foCSrX8BoORfVG42LSmHhm9+urVRkgRUqrOIbm3QXXd8Jz8CE04jta4Uc
         xHCR8RgPLkAeia3ag1tnogY1nuDulP+rQdKwYtlluAFKOqO9eQZtBg+0lRGbjtF1Z6iM
         57OQ==
X-Gm-Message-State: AOAM530gZJSwoC4FhQCicTtncLOpkHZxsqGaMx4/Uqyhuxyccd6B4m/j
        FIIxoqHPdITe5eq48bNTFQ==
X-Google-Smtp-Source: ABdhPJyHPrGdh1QNyO3qvNQ7njQOvx6xQmbxOT6KvZfUmzZ8Kl5sDHMCYDfiH2fKVFHMhvkmzWiBQA==
X-Received: by 2002:a17:90a:fd90:: with SMTP id cx16mr2508625pjb.42.1593010908500;
        Wed, 24 Jun 2020 08:01:48 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:01:48 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/15] mm, hwpoison: remove recalculating hpage
Date:   Wed, 24 Jun 2020 15:01:24 +0000
Message-Id: <20200624150137.7052-3-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

hpage is never used after try_to_split_thp_page() in memory_failure(),
so we don't have to update hpage.  So let's not recalculate/use hpage.

Suggested-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
index e5d0c14c2332..d2d6010764e7 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
@@ -1342,7 +1342,6 @@ int memory_failure(unsigned long pfn, int flags)
 		}
 		unlock_page(p);
 		VM_BUG_ON_PAGE(!page_count(p), p);
-		hpage = compound_head(p);
 	}
 
 	/*
@@ -1414,11 +1413,8 @@ int memory_failure(unsigned long pfn, int flags)
 	/*
 	 * Now take care of user space mappings.
 	 * Abort on fail: __delete_from_page_cache() assumes unmapped page.
-	 *
-	 * When the raw error page is thp tail page, hpage points to the raw
-	 * page after thp split.
 	 */
-	if (!hwpoison_user_mappings(p, pfn, flags, &hpage)) {
+	if (!hwpoison_user_mappings(p, pfn, flags, &p)) {
 		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 		res = -EBUSY;
 		goto out;
-- 
2.17.1

