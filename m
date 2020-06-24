Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC056C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD4B206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPAONOoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404278AbgFXPCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404249AbgFXPC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:02:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1346AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jz3so1280171pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J0Xeovjt/xfdRY3CY7rSgO7sQOzE+w1RTWn+OXKgogk=;
        b=mPAONOoOMCz3IzPvpOtPAvFkSpNOWWK64tYeTcGp6deJ7CGiQdTIbJCV2Oq5KqScuO
         ADRvQ4+VVqQBfUd0xqxLtL5HOjaJKhJGpU/WYe8APPid8XYqspwYo1OuZqTS7Nm22CiQ
         dmociYAaoYOUH0EqVKScWSV8fzliM2Gt2mSfUAFL8rSsvHv1vAxPpTXX6XhyMO0wgIz0
         2QmyCW3M3bAByYly33meuPj7eq64fO2j+tSP7MDEmaZ76LbcUiEIDIcU4llqohRiD/QA
         O54Zk7e6ZJyVtnWggGSBqR1lqlmXON+xERUiXIGJU73FIak4foWAfIvj0FdlrHopRmji
         Z0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J0Xeovjt/xfdRY3CY7rSgO7sQOzE+w1RTWn+OXKgogk=;
        b=f+/Hxni5UC826jt/WwT1s4tV9k+gq6E5/05OV0rcqRznxDoi7TjLbJPLr9yIRQ9Vol
         gOMte74wSNFSFLnILH/UeAdTqIbgLSWCSDqMszoflQsQPmumtO3ImoEkSzJPL5JfPYcc
         nubrzdjwFUbPAAWmjMo/d1ImWhaC8TD4x+PtkUHpm/CbNVwgbnFtgibShjYN0/R+EH5d
         AmwHJr1KABT3jIKyoT1tQLketbOHw7S+uDFGo/Z1NHu5PYel5nleLX7/FMMCN7ZUBj51
         NX5WZzGJ+bXJXGJDbdormk4FQIRTPWIgJTujf4cFwZwKYqWg5OTCOLzMUi1C6UCBzqXO
         UNDg==
X-Gm-Message-State: AOAM533IgeW+KW58pbLcwvjq64NYRGNLA1dOsqpn+9ZqNJyE1AwrVv4O
        bKekvHP4dMKULKPsRY9cxg==
X-Google-Smtp-Source: ABdhPJw6MfmyFpw8wUaLuJ/Vb231TF9GIf25hqGNAuaS+lTOsKaFPSQMkwSVd0NnleNPPJ4y5vKcQg==
X-Received: by 2002:a17:90a:e801:: with SMTP id i1mr28012066pjy.79.1593010945548;
        Wed, 24 Jun 2020 08:02:25 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id i125sm17013705pgd.21.2020.06.24.08.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:02:25 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/15] mm,hwpoison: Return 0 if the page is already poisoned in soft-offline
Date:   Wed, 24 Jun 2020 15:01:36 +0000
Message-Id: <20200624150137.7052-15-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
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

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/madvise.c        | 3 ---
 mm/memory-failure.c | 4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/madvise.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/madvise.c
index 2b5080253406..b59bbd6c9982 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/madvise.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/madvise.c
@@ -902,9 +902,6 @@ static int madvise_inject_error(int behavior,
 		 */
 		put_page(page);
 
-		if (PageHWPoison(page))
-			continue;
-
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 				pfn, start);
diff --git v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
index 22c904f6d17a..9ad3198a3954 100644
--- v5.8-rc1-mmots-2020-06-20-21-44/mm/memory-failure.c
+++ v5.8-rc1-mmots-2020-06-20-21-44_patched/mm/memory-failure.c
@@ -1800,7 +1800,7 @@ static int __soft_offline_page(struct page *page)
 		unlock_page(page);
 		put_page(page);
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-		return -EBUSY;
+		return 0;
 	}
 
 	if (!PageHuge(page))
@@ -1901,7 +1901,7 @@ int soft_offline_page(unsigned long pfn)
 
 	if (PageHWPoison(page)) {
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-		return -EBUSY;
+		return 0;
 	}
 
 	get_online_mems();
-- 
2.17.1

