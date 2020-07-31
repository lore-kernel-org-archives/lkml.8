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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ACEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB102177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH0YS43k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733277AbgGaMWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733266AbgGaMWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:22:04 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6CFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:22:04 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q17so17210727pls.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DeQp8qeoPbySHXWwwb0orjOK+38VoyYyRVxT40RVsgA=;
        b=JH0YS43kMG6lFBe3wbbXVA15iWByJHoFD+/phhTMfrNmROe8y/ANMlG9BW6mVewofq
         19uCSvVxVUC1JOxMvD6nCVqHq/J0GeqfsQ0jTvtv2mBHRmck4fseevfjtTnBn2OTVqi2
         jehg04UOdaFl7OBA8YPi0UadKkF112L0v/p6TypyL4MG+P9928qmJxa1t+wbs5iWZP8K
         DuXNuvXkG0pwHYtkhD6kak4x8nsBXiS3ly9eX1E2r5gZmI4i28R0hSOmjkB6wTRZkl7i
         6lBgPKg+a53bdGyt0FmFZ7ZTHzDpkYIgZwEfx2dTqJxgqFDFVjsb9K3rFEe9pZEclSRt
         F2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DeQp8qeoPbySHXWwwb0orjOK+38VoyYyRVxT40RVsgA=;
        b=ZG92VocHYnLOoBmrxzWRnO9h8sp4uZ95xtJRKt5nAFYV2Vp8owzBsFhd9v6B9WySXK
         J9OqUqBvGQzCDN2uNWEBqlXDv9RKXMawObBYrABKz5r1jSsTbxP7Vqq4QlF0N+iLso+f
         8f5YUadKB9GzvoO3mZwSWLoJzkNh9LYLRjV1lZoKAltHDMG44gR2GXJDSJ4L75WcWimu
         nmtnvkR3eEbYgV1OyWzg5pXE8wDSju0T9cR62EoMggv0VD4ejZQjiCDmxeJSDKGlOhbV
         idOUhsyrnEY4pr8dgUL5/C3m594Ke50Xe5SPIUGrJgGtbCQcI9Rz1cpmIhXjXdNnSZ9Y
         jTyQ==
X-Gm-Message-State: AOAM531Euh+SJHtsuPZ1xq1nMafH5XpkeDil7/oDZOFzjCy/5gw4buQX
        CvW7gAmeYEYx/qyINBm9Bg==
X-Google-Smtp-Source: ABdhPJxCuhOPlrzcVhXzPFCZw2q0er+jAX8DvkrMnB02bNmSP9JC8tnUAqk7NPyCj/LrVkCYpYd0VQ==
X-Received: by 2002:a17:90a:3fc7:: with SMTP id u7mr3784062pjm.231.1596198124242;
        Fri, 31 Jul 2020 05:22:04 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id m19sm3675692pjv.34.2020.07.31.05.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 05:22:03 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 15/16] mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
Date:   Fri, 31 Jul 2020 12:21:11 +0000
Message-Id: <20200731122112.11263-16-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731122112.11263-1-nao.horiguchi@gmail.com>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

memory_failure() is supposed to call action_result() when it handles
a memory error event, but there's one missing case. So let's add it.

I find that include/ras/ras_event.h has some other MF_MSG_* undefined,
so this patch also adds them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.com>
---
 include/linux/mm.h      | 1 +
 include/ras/ras_event.h | 3 +++
 mm/memory-failure.c     | 5 ++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git v5.8-rc7-mmotm-2020-07-27-18-18/include/linux/mm.h v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/linux/mm.h
index ecb3c7191fb7..4f12b2465e80 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/include/linux/mm.h
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/linux/mm.h
@@ -3023,6 +3023,7 @@ enum mf_action_page_type {
 	MF_MSG_BUDDY,
 	MF_MSG_BUDDY_2ND,
 	MF_MSG_DAX,
+	MF_MSG_UNSPLIT_THP,
 	MF_MSG_UNKNOWN,
 };
 
diff --git v5.8-rc7-mmotm-2020-07-27-18-18/include/ras/ras_event.h v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/ras/ras_event.h
index 36c5c5e38c1d..0bdbc0d17d2f 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/include/ras/ras_event.h
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/ras/ras_event.h
@@ -361,6 +361,7 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_POISONED_HUGE, "huge page already hardware poisoned" )	\
 	EM ( MF_MSG_HUGE, "huge page" )					\
 	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
+	EM ( MF_MSG_NON_PMD_HUGE, "non-pmd-sized huge page" )		\
 	EM ( MF_MSG_UNMAP_FAILED, "unmapping failed page" )		\
 	EM ( MF_MSG_DIRTY_SWAPCACHE, "dirty swapcache page" )		\
 	EM ( MF_MSG_CLEAN_SWAPCACHE, "clean swapcache page" )		\
@@ -373,6 +374,8 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_TRUNCATED_LRU, "already truncated LRU page" )	\
 	EM ( MF_MSG_BUDDY, "free buddy page" )				\
 	EM ( MF_MSG_BUDDY_2ND, "free buddy page (2nd try)" )		\
+	EM ( MF_MSG_DAX, "dax page" )					\
+	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
 	EMe ( MF_MSG_UNKNOWN, "unknown page" )
 
 /*
diff --git v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
index bd63f1f2e44e..6f242a194c64 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/mm/memory-failure.c
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/mm/memory-failure.c
@@ -583,6 +583,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_BUDDY]			= "free buddy page",
 	[MF_MSG_BUDDY_2ND]		= "free buddy page (2nd try)",
 	[MF_MSG_DAX]			= "dax page",
+	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
 	[MF_MSG_UNKNOWN]		= "unknown page",
 };
 
@@ -1373,8 +1374,10 @@ int memory_failure(unsigned long pfn, int flags)
 	}
 
 	if (PageTransHuge(hpage)) {
-		if (try_to_split_thp_page(p, "Memory Failure") < 0)
+		if (try_to_split_thp_page(p, "Memory Failure") < 0) {
+			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
 			return -EBUSY;
+		}
 		VM_BUG_ON_PAGE(!page_count(p), p);
 	}
 
-- 
2.17.1

