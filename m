Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23A9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04D722B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL8mwKWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733193AbgGaMVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733152AbgGaMVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:21:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2A8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k1so7201785pjt.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C20rXtIxVYuV8kAt9ziq5r9X3XGDWqg/fkrphmJjKRQ=;
        b=mL8mwKWQzTvtX66d+UAyvZYdeQfelYFSjj9rVpvye6Z3Z69SI59FpRf6OxSdCEUyh0
         1uV7DKEXrssFQAvdcBXZ3OPVVqRYmOyac7+wTTDLdr+Qz6hVv7vV6bwx9Cuyl0x+58ya
         Yog37R4NlqRmNjaj4HUv7O+CqxVQpBjIrkrNahCOWRl5Bkw+6rLYCG1SSEn4T8gmHLi2
         T8tRatkzoVK9YvK4I4N2iskRZEB1mJN4IYFco0Zb6M/bc6/XrJ4TGATj2GeX2HykwvaI
         f1aIXZJ82amxGxC9ysOXv/8IUR4OArtjUM6WoKZayh72LgryYTd30z7JqrPLZcpm4X1J
         5Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C20rXtIxVYuV8kAt9ziq5r9X3XGDWqg/fkrphmJjKRQ=;
        b=hrRlSMYUCKO2V89oQFNch8VKlIvGkxq4aNDa+DKHLlR9Qvy2YdOFcyhXkBRaEpEv6W
         XTX7axNE3izpw0wUIQ+ZA0udiQyhzUJTOlu1jEaLDLiArUJC60qXhLmA1Zk0EhsnqmOn
         ph5V2glv4FaO0/i6XcgZXHdZYkPfLzrOv9uvObX50sL7wujh9XBwse6f7o8P5zjVXOCH
         Vl7g0ml0y/cza+Myu7B75B3bkj1sNeqr+xvXTyMExWChzrL7NEP3Equ1TZLSaaQAQZ85
         XcXYXuDHi9KSfC+rKMXKtDXXlOpJdMo/qwee2TvkkxT+KTJ3WQdrAt2mKgKURiCOyRps
         29/w==
X-Gm-Message-State: AOAM530GmP3rHHCn+VziJTyjF+AQLvPhpF8grVylLV658yDQ3p8hjmet
        dBgmcu3pCnIdjuq3v3LDIA==
X-Google-Smtp-Source: ABdhPJxBtp9vGmxG4kThIlaUgtwdMwKwb0g68uZr44relMDFK6s7Qp5rP4w+/RX5BF4lCvffoiwKlA==
X-Received: by 2002:a63:3d06:: with SMTP id k6mr3577330pga.316.1596198090375;
        Fri, 31 Jul 2020 05:21:30 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id m19sm3675692pjv.34.2020.07.31.05.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:21:29 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/16] mm,madvise: Refactor madvise_inject_error
Date:   Fri, 31 Jul 2020 12:21:00 +0000
Message-Id: <20200731122112.11263-5-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731122112.11263-1-nao.horiguchi@gmail.com>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Make a proper if-else condition for {hard,soft}-offline.

Signed-off-by: Oscar Salvador <osalvador@suse.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/madvise.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/madvise.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/madvise.c
index 1fe89a5b8d33..2c50c2c5673b 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/madvise.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/madvise.c
@@ -886,16 +886,15 @@ static long madvise_remove(struct vm_area_struct *vma,
 static int madvise_inject_error(int behavior,
 		unsigned long start, unsigned long end)
 {
-	struct page *page;
 	struct zone *zone;
 	unsigned long size;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-
 	for (; start < end; start += size) {
 		unsigned long pfn;
+		struct page *page;
 		int ret;
 
 		ret = get_user_pages_fast(start, 1, 0, &page);
@@ -925,17 +924,14 @@ static int madvise_inject_error(int behavior,
 
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
-					pfn, start);
-
+				pfn, start);
 			ret = soft_offline_page(pfn, 0);
-			if (ret)
-				return ret;
-			continue;
+		} else {
+			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
+				pfn, start);
+			ret = memory_failure(pfn, 0);
 		}
 
-		pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
-				pfn, start);
-		ret = memory_failure(pfn, 0);
 		if (ret)
 			return ret;
 	}
-- 
2.17.1

