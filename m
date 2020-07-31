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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40C1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4D52087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFV6haNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbgGaMVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733132AbgGaMV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:21:27 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14AFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so7212754pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FBTrDXNWXY7ZPAJHB1q2pmYieIRphOe/mMSwCtpIV18=;
        b=eFV6haNpyacgxwgVMRx4A+6Q956GlMW1U7F59KBLih3bqhXIVzlFiu9zd1ngBoGn59
         FSpJTBx5of8gNKg2jeXzJCOtk5fm0JBehKhs58Jfb0ype651tpwQlSGA+C+j3VPxEX6H
         9+HhzQCApEnKlT6j/BmGlVKIcdRpGvhbFtU/YrujMN1TfXd5OvHdQecRR7MbafIYFb8w
         MxNXuHq/cPqfbUkfPACMgoduQ57Xk/G3pVmHfM3NS+8BnybIdFXcNxBTFZEeJAPy9zab
         G/qVJic/jILbU7XE4GTRIxU/4Hzfsm5zgJpeW85LHyQRRixTGOes/5NCN+lzIYb8sy+Y
         BJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FBTrDXNWXY7ZPAJHB1q2pmYieIRphOe/mMSwCtpIV18=;
        b=k87BqIh/W6KAHgKUFgHbbwKRqwAh1aVT6bF6rnWMFJiCaWUFiRREfzRiK+LYZrXG3l
         ClEzdQakQK+KVi08nOb1tmLHnxKZ4cPHtBM0gqup/y3K4hOKU8okckpO/WfmzfznDCH6
         9E3KVWzdCrFl8fFEJ5uhkQ8B/+wbp9gDSKd8OXwjfsjTX700xv6dU00JhqygQtd1gKU1
         b2TDZ9WPnmJ9m0rERlG3PQEcWku2JPY7quT6n4xYDbFOji1t5K5NDwJNMUYHGaZucfnF
         ApW1F5Vr64MPiAZwzXQHcuEG4GJzO8Z55kLQZjN/RAcTU/okbE4wA480i4QRLjFhssAA
         0NNg==
X-Gm-Message-State: AOAM532b8anmipj1p70IP/xt2k3DgO0g0Na6NPN2hA2vxnqXHFg7tA13
        AFVicuGmpBa1TipzdBqGvQ==
X-Google-Smtp-Source: ABdhPJzOymvP0Ol7udGQa66VemBG2AZqN8jo517Qfd/xao9LvV1ecByGIMNpoi/Bw6kcQS5Ee35p4w==
X-Received: by 2002:a17:90a:c295:: with SMTP id f21mr3813202pjt.208.1596198087313;
        Fri, 31 Jul 2020 05:21:27 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id m19sm3675692pjv.34.2020.07.31.05.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:21:26 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/16] mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
Date:   Fri, 31 Jul 2020 12:20:59 +0000
Message-Id: <20200731122112.11263-4-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731122112.11263-1-nao.horiguchi@gmail.com>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
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
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/madvise.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/madvise.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/madvise.c
index a16dba21cdf6..1fe89a5b8d33 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/madvise.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/madvise.c
@@ -910,16 +910,24 @@ static int madvise_inject_error(int behavior,
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
@@ -927,14 +935,6 @@ static int madvise_inject_error(int behavior,
 
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

