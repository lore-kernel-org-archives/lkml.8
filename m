Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8A9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3778F2224D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV2AEwHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgHFSuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbgHFSuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:50:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FC3C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:50:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f9so7137704pju.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wKkzBXT0A10RMCbmB0sW63A088296XpG9JqckPfziyY=;
        b=cV2AEwHEAACGSXDXztNlukjitDsQ3Yhfl3T+j5IzNo3aIvL1oYcU54iT2oEJquFGYV
         EFBO96h6xam0Fho+vRGKCvi0UApaak6sY21ukTsnFDNxC5n163cegZEZtIlGZt9ADWXY
         x1jx3cmHjERpUV5jKT49VqwepH2d0nTzLPqNH9EiMw3XHNodLfouk0OdFcm4lJ2q0vxx
         P4mlUuHFaaESzW4bzE/plwmxA60SXFWaxC6KM+q+ogLtrWlrUOD4ArcGvQLSWrfCdBRs
         1xyTzT/988nMi1UtYJTeMMyIKYy2ty5ssvT/mHrA8FJm+ndItPFfGIkv16Je8NCHXJDf
         88iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wKkzBXT0A10RMCbmB0sW63A088296XpG9JqckPfziyY=;
        b=Toug2bp22f/5BOfeVyayUYkwt3FQAjss0sIwqPCzIy+ZFmZmWVPpQetmAhKKbUbEAX
         vAZgQgizJTzOo8KLPcO6AwLCk8QuYAMtycm9uInLLv4FONBqcQvv1+YUvqxT2q9WDM9H
         5RF16POCvxhk3APLqK4NvLr9v7KqNXCGmftv3SHK9ct1f3n8DyKfjQyujM9Iu7W7zUao
         5Gwl5stqz/IYgSQs57zsgx3NQA4ey+kw+VLFwa+xi1qfFR5D9IQzYCGvgN/Dn09H+qlc
         w8dH+9Ao1Q644JS64qmytLhFZVhsg8xlhXJC7Ma0i6/H/urO/8F6rtl4VJeDZb9iUbWD
         keFA==
X-Gm-Message-State: AOAM5300XI+TPQt8cvXsHKU9IIBuakYr5VisIMlyjv99+2yNvCezvA5u
        SLdmPLJBfL//QJh0BIrDwQ==
X-Google-Smtp-Source: ABdhPJwRcKOgv9ZvObyRfMqP+tKa5UG/Urcd5pPbv+ymwa+u3QTNFnkHaQoxC5Mx95UOdPkgbcas5A==
X-Received: by 2002:a17:90b:684:: with SMTP id m4mr9827210pjz.4.1596739803868;
        Thu, 06 Aug 2020 11:50:03 -0700 (PDT)
Received: from ip-172-31-41-194.ap-northeast-1.compute.internal (ec2-52-199-21-241.ap-northeast-1.compute.amazonaws.com. [52.199.21.241])
        by smtp.gmail.com with ESMTPSA id u24sm9096730pfm.20.2020.08.06.11.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 11:50:03 -0700 (PDT)
From:   nao.horiguchi@gmail.com
To:     linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, osalvador@suse.de, tony.luck@intel.com,
        david@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
        zeil@yandex-team.ru, cai@lca.pw, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/12] mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
Date:   Thu,  6 Aug 2020 18:49:22 +0000
Message-Id: <20200806184923.7007-12-nao.horiguchi@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806184923.7007-1-nao.horiguchi@gmail.com>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
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
index 371970dfffc4..442921a004a2 100644
--- v5.8-rc7-mmotm-2020-07-27-18-18/include/linux/mm.h
+++ v5.8-rc7-mmotm-2020-07-27-18-18_patched/include/linux/mm.h
@@ -3024,6 +3024,7 @@ enum mf_action_page_type {
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
index 61e20b7dd81c..bed4b6aac9a0 100644
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

