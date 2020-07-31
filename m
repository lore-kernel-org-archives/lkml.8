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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CB8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B74C121744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH9dCgiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbgGaMV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733122AbgGaMVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:21:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925A5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so7211118pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qrNOopevZrXOPbrUYdqc/luUXjhR4msmU2SD/x7wn8s=;
        b=WH9dCgiO5HBSnguxla+ODFX+58yP55FDN85r1k7Xc0tjEBA7/8Y7Ch2O85TIWJU5Zj
         od7uQJV/H6YraW6Rm48YMoGsmqjiwFaS3jQ8BpARANZ5MKWhWodJvPLk0Qy4h8ufVJY4
         ZVjQFAuRWkEPboJX16lJwqsNOknYnqAB8kjdyL3ugGNcH+pnASg/Td4s0zXFQtsSMSqF
         BNYJp2L+kSBJn3OXXfNamLP2Podb6Ow0fekn3qQhte4yzJzwU1Y6jKAB6py+fh/THd8y
         S9Pm3Dx8YfAHd87lMiB2UatTv52EzEmzwgoHEWQlEzZVS+O5AyGwnHESLsUoymdc5U+4
         wmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qrNOopevZrXOPbrUYdqc/luUXjhR4msmU2SD/x7wn8s=;
        b=pYL1Zi07aczzDUaZmzPC6/MhqCpWlPQcysI/vrsErMwlLVEnLNoehI+VkUdTsxyo57
         kculmSs9gm+w9AvAb5T/vlVQDseYenMxLuqdPrf9uBtcltQwjrvxn9od1XFF0nzfNMYT
         6aYYhatnS8sUMt4vUDK24K5a6H8M94FZZq4wZlxc+sZ9e8BS5TVvohOxL44/Pom0ZApY
         JjbBxK5Or05uC2FKLRa9SNG2ZOfSyaNV6Rnp9mYuzg1fUYw07TppBqSpIgb70VYwSBvP
         q/y0Xze5+l6kEwx0i/Zulnyq9gv/d+NPJi/CDqTPTCdI1uW7f22Ufo7qPWpAGczgorQW
         EdkA==
X-Gm-Message-State: AOAM530yC5NW2RNONB9YNuxVuJK4PDI+0UTk2lDz448hE7pI7Asg8e6u
        lEpJW/JYLJDXAeSyz8Sdyg==
X-Google-Smtp-Source: ABdhPJx8PolYkpiawKpv9KQGOzCfR/2h6vcz2gh903lD7zOol4BIdtxScC5xzPjV0Nvs/PYmFUz4ow==
X-Received: by 2002:a63:3c41:: with SMTP id i1mr3580839pgn.349.1596198084144;
        Fri, 31 Jul 2020 05:21:24 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id m19sm3675692pjv.34.2020.07.31.05.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:21:23 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/16] mm, hwpoison: remove recalculating hpage
Date:   Fri, 31 Jul 2020 12:20:58 +0000
Message-Id: <20200731122112.11263-3-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731122112.11263-1-nao.horiguchi@gmail.com>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

hpage is never used after try_to_split_thp_page() in memory_failure(),
so we don't have to update hpage.  So let's not recalculate/use hpage.

Suggested-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/memory-failure.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index 3d2d61f1c6e9..f8d200417e0f 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
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

