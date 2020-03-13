Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A935C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5343020716
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUk4dt+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgCMCDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 22:03:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43557 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgCMCDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 22:03:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id u12so4029605pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 19:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oWGBLFEvBP29kAKar8TGkNLxRw+YhQWclY3OJnhykbY=;
        b=KUk4dt+fWPxx8Oh+GaRAhOUdiXBX//j/exJEGf67ZCb1zFi6VlKfIlLy78wtTPScwG
         X4on+PrTcOPwdyoe2x/NteUXfX2yJ9FFuSxlc7/0n05qWBGyYVhi3F4VR2LNNV0ZOI0T
         dsCeS5aSJgMcfmCpnsMB+jKMKlpBtDbxwYlLiN0npglR19lDfAd5uljPUkk9xq1rlZ1g
         Y2MgFdC3Aiotyah2xBltzy9eLHYye3Vwt0GdC7i7rg4/9XsHDgyvKbTPKfchRgWelp7e
         zfOcKvEvX7ap5Zs5RrDD4N6jpRd8jfTgUjDVeDp6UW4nP4dRA7e//lpn/Y6lYd2p0Mq7
         nHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oWGBLFEvBP29kAKar8TGkNLxRw+YhQWclY3OJnhykbY=;
        b=sH3V9N+KRQpvA3QCHiwYd4t8t2Aps5VJiC53zoof1/fMqjde5IZWwLgZsbn9wub7uL
         1uNiICfyKSoPxPXiD6x8JhOAOfROADI3X4UjoBEOag43ox51l0toDfKRip1W2kTV123q
         hQR7iMkpCIcimDQUGJKKGoRM4BVF+xrtCNWe83AG7Hl2DOSB4COoju44ddmdd384/S3p
         nFjoH9JnI2A4k8IHQm4gfc2oHRb1UMjwhvNvXtsVLrHwyfAolvCjP3ln9CqSR0OzF7x6
         2K5VGkRE+6/tgiV8rzbeO/GlV0OHVyIFyk0qpi9VO6jwjvJLrT/olxXrS/2lm2mP3m5T
         MIAA==
X-Gm-Message-State: ANhLgQ1yR8jIEOGrKqDHKx1dlWkVdfq/czCyZksN+HPx/ScPLfkBnd2e
        IuzAXuXf3v7OSJMSYHqUGePcGKaN
X-Google-Smtp-Source: ADFU+vvBMHhj+xpDDXHjZFiXHssTFRBWLjy5b1wBqzLMxJCB4wK7b1dHhDgpm+970UaUC9CiASYRqA==
X-Received: by 2002:a63:fc52:: with SMTP id r18mr10252608pgk.96.1584065019752;
        Thu, 12 Mar 2020 19:03:39 -0700 (PDT)
Received: from localhost.localdomain ([1.39.142.76])
        by smtp.gmail.com with ESMTPSA id v123sm31515803pfv.146.2020.03.12.19.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Mar 2020 19:03:38 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     jglisse@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] mm/hmm.c : Remove additional check for lockdep_assert_held()
Date:   Fri, 13 Mar 2020 07:41:00 +0530
Message-Id: <1584065460-22205-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

walk_page_range() already has a check for lockdep_assert_held().
So additional check for lockdep_assert_held() can be removed from
hmm_range_fault().

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 mm/hmm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 72e5a6d..b201e1e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -681,7 +681,6 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 	struct mm_struct *mm = range->notifier->mm;
 	int ret;
 
-	lockdep_assert_held(&mm->mmap_sem);
 
 	do {
 		/* If range is no longer valid force retry. */
-- 
1.9.1

