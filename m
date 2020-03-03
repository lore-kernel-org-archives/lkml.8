Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A68CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E751208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imDFsfyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbgCCVZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:25:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42782 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732154AbgCCVZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:25:20 -0500
Received: by mail-lf1-f66.google.com with SMTP id t21so2996808lfe.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 13:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y/mHnKHxMngQ3UbmJHGG+3zqknoqqhwXbg+9IAp9krw=;
        b=imDFsfyXnC+Tum42eQ9p8jRhYNO36ZmhVxbMzID0Mc6EH3eq+RfKjxORb32uTysKND
         TCLajF/0XG6yiCK5uOaDZHoig3LLFimmpPUjiW8S4hOty1j2+rCpNPjsk6z/R9s9kF9W
         +/KiTCAl+7UWmnJRMolDLoaRNRSH8tGGs/MSPvw0p+73G0cNOI2U9vhZneqO+RA0JP5B
         WyyCdHH9/0IQLk8DcvSvtrQGEBB59touKRmL0aef4OfgJFg378mZmNREqjcLpFzsuyiX
         e7YpU+FYX9KbRndcg1SGb1Ej1HhPJfg9fcR+ku0sfbP/TL9jRVluGSCfSjeWKFxcYEbZ
         lyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y/mHnKHxMngQ3UbmJHGG+3zqknoqqhwXbg+9IAp9krw=;
        b=rnCK1wiqcL1a9MIusSQtMs/A3Emcc6aGfDHFwgJ8WHDvbzWEcqZt9DBlr3Co3KWLzp
         FfskT9io5pqyPW68nAvN+wRgl1saacXiWfUGJmmGpIzsPX/DkWZ6agKs78vLzbSFOH4v
         YRmbZ3F/tav9KKwCKIhiGdP/8XXZrkq/lAHYoodNuWQBYGPb5oK+6pbVCqCZU9HOBzOg
         zqqYL93O0Pea2KLgwVzaD1GgF9vkamh3EfZB9R3MHWHlr0Xls6RZx5cJOPztTNtqzRIT
         6esp5+6icW1pWEqWFXBmyKn/Q4auojzX7MipeVkTxcXwXx5NBq12SG/xqW8ei6i1+ccN
         ZJwA==
X-Gm-Message-State: ANhLgQ0EQ2I0CgMBaDpDh4HjpxUGkoTduJRO4guBdD7PX4cg35iIhJ7P
        zC1AsAZfaEqabGGUJg67R60=
X-Google-Smtp-Source: ADFU+vvJcZ0nOuIIo7rfQ+8aoq0mPntge5gXUsZf3YOBmSycbcDu7/gs2ARiFrH6jgFdk3ED3/AcDw==
X-Received: by 2002:a19:8982:: with SMTP id l124mr3955286lfd.151.1583270718382;
        Tue, 03 Mar 2020 13:25:18 -0800 (PST)
Received: from localhost.localdomain (188.146.98.66.nat.umts.dynamic.t-mobile.pl. [188.146.98.66])
        by smtp.gmail.com with ESMTPSA id l16sm11200531lja.59.2020.03.03.13.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 13:25:17 -0800 (PST)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org
Subject: [PATCH] mm/hugetlb.c: Clean code by removing unnecessary initialization
Date:   Tue,  3 Mar 2020 22:23:54 +0100
Message-Id: <20200303212354.25226-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously variable 'check_addr' was initialized,
but was not read later before reassigning.
So the initialization can be removed.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e4116385a4e1..7fb31750e670 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5021,7 +5021,7 @@ static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end)
 {
-	unsigned long check_addr = *start;
+	unsigned long check_addr;
 
 	if (!(vma->vm_flags & VM_MAYSHARE))
 		return;
-- 
2.17.1

