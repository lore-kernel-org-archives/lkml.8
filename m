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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CA2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3127A21D95
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox0RjpA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbgGaMVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732985AbgGaMVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:21:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0C3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b9so17222225plx.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D4Ndr3lMfGWryT8BpcCBWbkT9Sd7Lw+5S6mzuxOjqm0=;
        b=Ox0RjpA12PJQHDITrdph5pOPcuN2GYXZFDP64O1Jg7Q9hHYJqG0b6qkA1DyLT1HCYA
         yAIAN9doa8ZzugIrAzEWwuyFfOELJ5kmOooR2FsMap3TbEF94piK1e/wcwC4z7k40eXD
         clWp0mC2ZCqtXIDvB1CzQ0PHfEixXvYcXb39QIxCU0XAIWo9nRhM6b8rAVWVSt4pdr1p
         CCpQPW7LRf5H85Yp258fUIC3WPDfZKKHL5AXw/yegUQzvD/xA1eFx09vK7HleoosgXCo
         DNp1KFajA6j0Re9O7hiQ0JAZ2xSIezel7P48RxdqtF86SMVg/VzFTdJLd/KqtpLARV4y
         RM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D4Ndr3lMfGWryT8BpcCBWbkT9Sd7Lw+5S6mzuxOjqm0=;
        b=lhlXENb0XMsLFLDHxEGI6QD8MhYfrvLaqWMDWlZTE1WwO5Sem4fVqh4ivjCvWwsC8d
         srir6g1LRAV6KDanfBrIfCo5r5cwrI70EXMBTsfFwJgeKnaGatNxu3DOW3Owv9wedu3v
         jUoSi6YNm8Teyo3mKAXaaWdWR1e8h45uGTmVlpMffNYjOoGpdTMEe2CMbjjfM7rCZphw
         1a/xOYgbTUWw95FWu1uRuamrU4ggv4LUDPTtuTcdQqxM3rgFAP3CX/VX/e8SsovfMMv5
         CHmCo4V2ZvEts45mDWqmCBrvkveh066VdBTCVGC1ejEteQOqBOzm+l0ckv/juvxNh5sB
         Z+oA==
X-Gm-Message-State: AOAM531TyXmJ290/FrnKG3iKa3V1CUXorjqIdXwtVoOjg9Dga7PYxDjs
        +dzUp5B872LCFSr9PpuoUA==
X-Google-Smtp-Source: ABdhPJxsym233zotubkKtsT7WOGGC9czTkxCbghBK6umjx1A55M6pXrzAXib/Mcqh7ouG2Jv74/uoQ==
X-Received: by 2002:a63:df03:: with SMTP id u3mr3359540pgg.84.1596198093503;
        Fri, 31 Jul 2020 05:21:33 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id m19sm3675692pjv.34.2020.07.31.05.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:21:33 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/16] mm,hwpoison-inject: don't pin for hwpoison_filter
Date:   Fri, 31 Jul 2020 12:21:01 +0000
Message-Id: <20200731122112.11263-6-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731122112.11263-1-nao.horiguchi@gmail.com>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
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

