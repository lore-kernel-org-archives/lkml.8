Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CBBC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9324020857
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="x0yHw6L/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390777AbgDCL3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:29:44 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:45974 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDCL3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:29:37 -0400
Received: by mail-lf1-f49.google.com with SMTP id f8so4118104lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 04:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mAGZx/EGSI/RDjikjycvglo1xEb2tWim3LCqQGVnzJI=;
        b=x0yHw6L/NgJHQg6clxAQ3NicETBimmrGkxc5bhLtUTHIZZ6gdjrI89zcBBRayGoUir
         7ufdkT4qvJVe+kOZvQbza2ILOMRGvZLR8jyJ1EKVJVN5VePrJVVG9hKMEjkhfUj+6p30
         cm6cVLDe1QxBjGcUYoMnxWjf3bfLuxj/jPNPguI1Akb5WzqU3t+fnrXihgwP/ppUph4A
         CT3L4rtI5GFKkmcmzxY7uLbnZDFQfWFqto6O/7V/qNfsjFmHmj+ow7Eikvk0jTBposlE
         HYt7MTTbT/vjnMgOVp6OtXYFrpQClrjVosE22wjvOGPykQyxB03RFBVO3UNwtMK4WO/z
         GT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mAGZx/EGSI/RDjikjycvglo1xEb2tWim3LCqQGVnzJI=;
        b=aMNCZLMjqUo42UQyHEVrqijtR+frOueFBS57NkBAkscmOUcGKIhvo8LSNZ9o/R6+nG
         P+92P59QHGSDR090uVhWjz9S6z8LNVpHCwi94TBekoQmeyKqSb7EHrWqyKseEnJ6ou8u
         9jp8444QivZWuLasWEuxjqNAkwI7dqjICOk1AXXh8vMd7T2rk+UhcR3yPRdhA7xZ1rep
         /j7uSbOKWZ7RjeN9ALCdl6hPe+cBkm9lQHu6elYSatUOQaUz1dEE72Q1EpkqcsyTHwA8
         8TLovovRNN/6N5R3dy8o1tmRVkmAduNOQ3WErWDqcLJZkSgNjob9HIrAnQDjy7DmbUD4
         6gUg==
X-Gm-Message-State: AGi0PubaFQFIC0is460cgEaKYAkNyVG5v39h+bTo+Sw2EbFWMZGUQvbm
        m3SGP1EQnqvSX2lItqhqkNEPBA==
X-Google-Smtp-Source: APiQypJP33b4u4UTOhlDU6gSnxe16ao8dSUMHIdTs8YvwSZz48wsEnm0lTloLTHHu7PruzVkkB7nSQ==
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr688758lfo.152.1585913374487;
        Fri, 03 Apr 2020 04:29:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p14sm3202760lfe.87.2020.04.03.04.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 04:29:33 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 78D6B101332; Fri,  3 Apr 2020 14:29:31 +0300 (+03)
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 4/8] khugepaged: Drain LRU add pagevec after swapin
Date:   Fri,  3 Apr 2020 14:29:24 +0300
Message-Id: <20200403112928.19742-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__collapse_huge_page_isolate() may fail due to extra pin in the LRU add
pagevec. It's petty common for swapin case: we swap in pages just to
fail due to the extra pin.

Drain LRU add pagevec on sucessfull swapin.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/khugepaged.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index fdc10ffde1ca..57ff287caf6b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -940,6 +940,11 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 	}
 	vmf.pte--;
 	pte_unmap(vmf.pte);
+
+	/* Drain LRU add pagevec to remove extra pin on the swapped in pages */
+	if (swapped_in)
+		lru_add_drain();
+
 	trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 1);
 	return true;
 }
-- 
2.26.0

