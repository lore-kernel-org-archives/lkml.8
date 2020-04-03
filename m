Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42467C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1420620857
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="K/3jDpUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390785AbgDCL3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:29:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42097 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgDCL3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:29:38 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so6512191ljp.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 04:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5yEswaSUA2DH71ZsH03UY5693O0nZ/nvg6oBTomxklk=;
        b=K/3jDpUjVVBeQnEhKWwM3gy5Gru8BoX47Ll9axoy1+xsPYklIrCBMX+fynu8VQkirs
         c7IdaWFPcUAldS81Lgl8ts8UDyFmKK3wuwf482yQ5bwzcLTPPeeEmvb5bjZbaEtS5n1J
         980tEnkeEIMw580fqyrxQAJGlI8ZBc5u0zbNRGkxjEdap7yl1DDi31Sve1b1iRjJtidt
         K8hYew8M8h7Y4uEk48knMl1An7JC3fl1k9m7z60tTErq8ZJXAOHVNOwOCMj5aGJsNKBT
         INczse/l8Bw4CLc8ed/WJp0e/iooX+2Y+2EaKM3rsCunrr9NUn1zbLDKNy1WRvbv8m7S
         GWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5yEswaSUA2DH71ZsH03UY5693O0nZ/nvg6oBTomxklk=;
        b=C88z3cFHKYsp1q42HHXJ8Y2RdXAo6DKPiSoGErfq4f/tm7UvDCtccCRRoWXncgLR5n
         PyI6UrzKSIpPNXMNq6WNaaMWobU/5AjZkClFLsBqo1yIiEQTSuDvqBn1aGcRIOMDbPuu
         q7yJJq9ZWH6wLxrymY4XY5CxWQaRtdubXN2MZYx+ShY9omi7vdhkDsYiVeEOsgZr1Uhe
         4koYw+EvPDpHlb3NpCbq9M95/qPUHGQhfO2+DYtckgOzWSOA513j4ESdL/AvGDncpP9W
         kFpvbCB2WcCBk6HbQ8sup2ZEW8ZM3ADj59XRuCy0jd2HOJYh4wfJoSYz1FyGp5hxBkF2
         GVCA==
X-Gm-Message-State: AGi0Puammcf4Y+QUtVmlidPqU2VfhIZx5Ov1WbPOMQrCyAgksFLmnlbs
        6m69UvcJ1u+Ts8en9IEPuEnpzQ==
X-Google-Smtp-Source: APiQypKvudeHPoFOkTLttn1XgRDx3Ffmfb4xTNZsju3O5Jb2cdvCtz/BcvwoJutkC4kvL/iz3qhYPw==
X-Received: by 2002:a2e:9718:: with SMTP id r24mr4294536lji.287.1585913374778;
        Fri, 03 Apr 2020 04:29:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j2sm5765073lfh.70.2020.04.03.04.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 04:29:33 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 6B64E101330; Fri,  3 Apr 2020 14:29:31 +0300 (+03)
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 2/8] khugepaged: Do not stop collapse if less than half PTEs are referenced
Date:   Fri,  3 Apr 2020 14:29:22 +0300
Message-Id: <20200403112928.19742-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__collapse_huge_page_swapin() check number of referenced PTE to decide
if the memory range is hot enough to justify swapin.

The problem is that it stops collapse altogether if there's not enough
referenced pages, not only swappingin.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 0db501f7a34c ("mm, thp: convert from optimistic swapin collapsing to conservative")
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 mm/khugepaged.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 99bab7e4d05b..14d7afc90786 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -905,7 +905,8 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 	/* we only decide to swapin, if there is enough young ptes */
 	if (referenced < HPAGE_PMD_NR/2) {
 		trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
-		return false;
+		/* Do not block collapse, only skip swapping in */
+		return true;
 	}
 	vmf.pte = pte_offset_map(pmd, address);
 	for (; vmf.address < address + HPAGE_PMD_NR*PAGE_SIZE;
-- 
2.26.0

