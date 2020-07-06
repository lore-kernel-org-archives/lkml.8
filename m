Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444CBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E02D20737
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="TIfYnbWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgGFC7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 22:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbgGFC7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 22:59:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3FBC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 19:59:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p1so5493157pls.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 19:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DGAUzjy/XhmI74RBjvCLCFYywNRTd6tVl+Zu7OWC5SI=;
        b=TIfYnbWcNnjcprjJouqUCmxuohAPvGPCE9Tgmy5A/vCTOwSTLwL5gJFFHSQweCb/jL
         2GkNyo5jChOwHUL5mSRyH08Gf21EIUWNx0LvRAQ/MeO4pniVUNdQHqDiMbREPGEiiiKb
         /3ALD88wvPderiGgatDu3bd0Zm8cYIdOQ+35dGWsWjOuwYODLxl0biosSOfM5+NCVvRR
         qx8Pg56oF0F38Qb3G4kePP69GsjFu7qTU5BQcFGi4N5lU+8afOGeVvyeNLs2/CyJHrLu
         qEd/lBKy3+K7tA0A3RsBKjJb3SMFjbDEC+7SGay9yly7nj7mkEjqOPWOuZKjhcGj3yFY
         K8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DGAUzjy/XhmI74RBjvCLCFYywNRTd6tVl+Zu7OWC5SI=;
        b=FhOvqgiELUTn5PPzbWUgr2GKgXMuohlpwc8xtNGjMwFvmCzYFR6RILuIZOegukMRpL
         888U/0p3FDW6v29d0E2UbDjCi0fMgcG9Oyt94KXT8d4CFW8IBC1tVZ0lDjQIhjhjQMvl
         CLXnnthV8//niBh+YNaVadRAB7erPwa+5/pf7zg8dC6kLO7jJziluz19+fp60IVfn0SG
         7Y6ctHL4ZkECsgemyboblEcKSItXBYD7k27LsoADHhfOnuYoSskqmiwJCoOWL1vRipCK
         uSFklsfvod4Sq+W23fsfzp2FMeCFBDesuU5nLdopoCxA8lFZcpsFbHZf014k9oGEQQOl
         7OGw==
X-Gm-Message-State: AOAM531nlw0/rraW3xH2q3+7ltrQg3tzfjHkTIFfbqoJUhx30ANgTm1k
        EYctyTDqmMcPeCveLhjCO9/imw==
X-Google-Smtp-Source: ABdhPJwK+09JRKTiaglUg2rIl55+RRz//tPhPpYbiuiUeQmqdPVMLlGkF1Kr+4L5VjytGMFqBCHQrw==
X-Received: by 2002:a17:90a:fd03:: with SMTP id cv3mr48786206pjb.111.1594004378800;
        Sun, 05 Jul 2020 19:59:38 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.69])
        by smtp.gmail.com with ESMTPSA id q1sm18491594pfk.132.2020.07.05.19.59.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jul 2020 19:59:38 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, david@redhat.com, penberg@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm/page_alloc: skip setting nodemask when we are in interrupt
Date:   Mon,  6 Jul 2020 10:59:21 +0800
Message-Id: <20200706025921.53683-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we are in the interrupt context, it is irrelevant to the
current task context. If we use current task's mems_allowed, we
can fair to alloc pages in the fast path and fall back to slow
path memory allocation when the current node(which is the current
task mems_allowed) does not have enough memory to allocate. In
this case, it slows down the memory allocation speed of interrupt
context. So we can skip setting the nodemask to allow any node
to allocate memory, so that fast path allocation can success.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---

changelog in v2:
 1) rework the code suggested by Pekka Enberg
 2) add a comment

 mm/page_alloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9808339a6e93b..6678c4c1c3087 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4799,7 +4799,11 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 
 	if (cpusets_enabled()) {
 		*alloc_mask |= __GFP_HARDWALL;
-		if (!ac->nodemask)
+		/*
+		 * When we are in the interrupt context, it is irrelevant
+		 * to the current task context. It means that any node ok.
+		 */
+		if (!in_interrupt() && !ac->nodemask)
 			ac->nodemask = &cpuset_current_mems_allowed;
 		else
 			*alloc_flags |= ALLOC_CPUSET;
-- 
2.11.0

