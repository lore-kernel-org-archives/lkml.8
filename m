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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7059C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB97206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbkXzDYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404167AbgFXPB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404142AbgFXPBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:01:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F67C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:01:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s10so1559284pgm.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FEJYjJlKBMyCMGijANDJfuAtwxDZBaJxFe8PT9k9lOo=;
        b=ZbkXzDYEzJAUOuoSuEPzDu3T3s2ANCIzdd/mnQhx9cIhkexxmXPyqUiKUS0a04gkLc
         ClQ0zVIPoY4JTr7mLz6mRIb8GiZoAVbF9I7BvuHTjg+TlIaSj0diBgyscF9vB0ylPykx
         kwqNGGo2RxBMxs2ql8yN1S/VO248AAynV4rRRkp6mPFiGVsnLhSME7GPaDAgnpzM22Ig
         dxYphPIbWdhtdDe42x2jNvAUP5hAyT9KuNQvqG2pJ8Br08sS0MHuW1mWtUoYg5PfnHS3
         MDa6suSQy8rwoX8axAXr4u5hNRw3Q5EcIkgi6fdkxsfQ1BZCAh6j39GhJSQLsLV+4IaX
         ellA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FEJYjJlKBMyCMGijANDJfuAtwxDZBaJxFe8PT9k9lOo=;
        b=dnQ2E2TcxeV64DwguBwfkTCiBovwCwtsBeeXfFZ5YXvwZPxRiC2fDt5yNrms6iAabE
         4t9gCPoxIRkWea2PybpsTuzQ2dZEesmsmvptca5OcANz9pjpzPz+cLtzkfbUtIKL2EGM
         J54PJQrVDDh6+q0+TiXDW/SQEjWsZV8uoH7eXdGF/pMpIPX2wynShfoG60xzTv06mi15
         Rul1QJqE44C8S1V2NBQ/l4fcqAZDrnDHuZ2l89r49b/F0I7XPgXJLVNnKYp6rZJd1hAP
         DGdOXXbhLb/AlFk8Ycbl4SLGOrgoStg9l0nCsYXEkJfb+Qyb0f9e4UR40eEJp7SV/CBw
         5mDQ==
X-Gm-Message-State: AOAM533tMWQP495V7WGQ/5W6w0O1n1zVDDA8cbpl+bGVHnfgY3lvbBru
        vcpx7vEou8BqKQp7wBCB5g==
X-Google-Smtp-Source: ABdhPJwRW8kdDe1v0yNB7iBTcXkFJNL6srZLU4fAx0l+FGJaNBYFg+WuLETuG1PxD12B9E7UFzlNAA==
X-Received: by 2002:aa7:8147:: with SMTP id d7mr8105744pfn.29.1593010911771;
        Wed, 24 Jun 2020 08:01:51 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:01:51 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/15] mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
Date:   Wed, 24 Jun 2020 15:01:25 +0000
Message-Id: <20200624150137.7052-4-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

The call to get_user_pages_fast is only to get the pointer to a struct
page of a given address, pinning it is memory-poisoning handler's job,
so drop the refcount grabbed by get_user_pages_fast().

Note that the target page is still pinned after this put_page() because
the current process should have refcount from mapping.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/madvise.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/madvise.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/madvise.c
index dd1d43cf026d..275b08edd428 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/madvise.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/madvise.c
@@ -893,16 +893,24 @@ static int madvise_inject_error(int behavior,
 		 */
 		size = page_size(compound_head(page));
 
-		if (PageHWPoison(page)) {
-			put_page(page);
+		/*
+		 * The get_user_pages_fast() is just to get the pfn of the
+		 * given address, and the refcount has nothing to do with
+		 * what we try to test, so it should be released immediately.
+		 * This is racy but it's intended because the real hardware
+		 * errors could happen at any moment and memory error handlers
+		 * must properly handle the race.
+		 */
+		put_page(page);
+
+		if (PageHWPoison(page))
 			continue;
-		}
 
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 					pfn, start);
 
-			ret = soft_offline_page(pfn, MF_COUNT_INCREASED);
+			ret = soft_offline_page(pfn, 0);
 			if (ret)
 				return ret;
 			continue;
@@ -910,14 +918,6 @@ static int madvise_inject_error(int behavior,
 
 		pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				pfn, start);
-
-		/*
-		 * Drop the page reference taken by get_user_pages_fast(). In
-		 * the absence of MF_COUNT_INCREASED the memory_failure()
-		 * routine is responsible for pinning the page to prevent it
-		 * from being released back to the page allocator.
-		 */
-		put_page(page);
 		ret = memory_failure(pfn, 0);
 		if (ret)
 			return ret;
-- 
2.17.1

