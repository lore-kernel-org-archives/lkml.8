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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B626C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D79AD2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCcvCqps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733269AbgGaMWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733250AbgGaMWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:22:01 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9166DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:22:01 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w19so4243202plq.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WtOEWqIWk9JjcgYbtTh/VY54dSMQGk3haQqeS7NhWEU=;
        b=kCcvCqpsvoDrNqbbF1qDxUJ0N2OqrNTvt1A+Pumffkxof23yXR2h2++hDtJO8v3+MO
         EI6ZHkh5XbtZezFwk1btqfeBTj8LFSQo2lA/BHPGJbH1tcKIOTje9nV4zXLHOCM3sPoO
         WKzKq/lB3CQ4ExGLRfTQp9Xt7ARE4dZqkszoVq6WvFqeO5CldcZWfaA409/I98IaBJvI
         zPaGvjwR+uIW8Rge+vf8QYP6GpD7zRnLVD+AIIvGxBg0rqGC0DJ+JrR/0o3gRIqaxDsz
         +0c8k1q86E2N5X8jmk7kDleDuI7dmKKPjlJ7yjk+TojGEPbGT1hURQsNRgPUEANbxSZX
         B8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WtOEWqIWk9JjcgYbtTh/VY54dSMQGk3haQqeS7NhWEU=;
        b=iB/AElqM56I1JkdpPY5NCunlSn00da6Gj79tpkNtJKxX10kcSFKobt9OMtnNSuU5oY
         XVkrCLMPAwicQHEfUVMfWU39DTiBUWvKElG+Kq1dBmyNT2Wh97PbIWGtSpDlcW0PlT2Q
         mHq+3XhWEK+8IsQ4B06EBRGcRCRFXU8Abw3LQppPd2uBc/HCjI5Nb1DLROsqpfDXC8BT
         9O/Cfyb3z8j6GjDtxpCoOWu6c6tfg+GbRxBaa2d5idARAnQtMaVupy+4+On+5+pdqEGJ
         NTpbJ4KGKcuX4tIicoHDMoK+OKNGgBJldbLdfZu93K/Rw9is/xmRoyIuIB/3+JRyJCep
         NX7w==
X-Gm-Message-State: AOAM531TPvA4AMezPyb90S5hvPyLgvDHMQ7oiNZJNo/1/Z5TbUJGYynJ
        8FbEoY4ELg+G8xj4unHMAA==
X-Google-Smtp-Source: ABdhPJx5uVsf47BpfzXr8xTEgB/mU5aV20nGmkRnVlJdXZhe6/OTqDHY+RruvzRyJLF6G3+IkBf3Gw==
X-Received: by 2002:a65:6650:: with SMTP id z16mr3667397pgv.161.1596198121188;
        Fri, 31 Jul 2020 05:22:01 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id m19sm3675692pjv.34.2020.07.31.05.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:22:00 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/16] mm,hwpoison: Return 0 if the page is already poisoned in soft-offline
Date:   Fri, 31 Jul 2020 12:21:10 +0000
Message-Id: <20200731122112.11263-15-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731122112.11263-1-nao.horiguchi@gmail.com>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

Currently, there is an inconsistency when calling soft-offline from
different paths on a page that is already poisoned.

1) madvise:

        madvise_inject_error skips any poisoned page and continues
        the loop.
        If that was the only page to madvise, it returns 0.

2) /sys/devices/system/memory/:

        When calling soft_offline_page_store()->soft_offline_page(),
        we return -EBUSY in case the page is already poisoned.
        This is inconsistent with a) the above example and b)
        memory_failure, where we return 0 if the page was poisoned.

Fix this by dropping the PageHWPoison() check in madvise_inject_error,
and let soft_offline_page return 0 if it finds the page already poisoned.

Please, note that this represents a user-api change, since now the
return error when calling soft_offline_page_store()->soft_offline_page()
will be different.

Signed-off-by: Oscar Salvador <osalvador@suse.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/madvise.c        | 3 ---
 mm/memory-failure.c | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/madvise.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/madvise.c
index 3eee78abdbec..843f6fad3b89 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/madvise.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/madvise.c
@@ -919,9 +919,6 @@ static int madvise_inject_error(int behavior,
 		 */
 		put_page(page);
 
-		if (PageHWPoison(page))
-			continue;
-
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 				pfn, start);
diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index 904dec64da6b..bd63f1f2e44e 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
@@ -1794,7 +1794,7 @@ static int __soft_offline_page(struct page *page)
 		unlock_page(page);
 		put_page(page);
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-		return -EBUSY;
+		return 0;
 	}
 
 	if (!PageHuge(page))
@@ -1895,7 +1895,7 @@ int soft_offline_page(unsigned long pfn)
 
 	if (PageHWPoison(page)) {
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-		return -EBUSY;
+		return 0;
 	}
 
 	get_online_mems();
-- 
2.17.1

