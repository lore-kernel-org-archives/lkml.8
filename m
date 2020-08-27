Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A79C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8A22177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgH0Pnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:43:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46865 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgH0Pno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:43:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id h19so6943563ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a1axoXprReWaPScASLIzL4aItcgQogrVYwx/CXLgqrE=;
        b=jXn6nmBYqAGwg81kx0+qPCrWQgstj6F+PtIVyp9xXceH+x51aR3acIrRPRrUHxaYor
         ooFE7qDeAl/1GeT4epk/zbprDDmuKHvDCE+2WmAt30jh3gUfHqQpYgIKpsTRSgbOBl6z
         170+2gmRrnTSnfyLbNqDJE4qmsFh/ga8UThazMxJ2xmB1SP+JnqXC7OE7mdmTH7kyvtr
         rSMh76kEmL5cwC01CdNgD7Zwmvt+EdUsXiO6fZpjYtMadBtmy/HS02sDvb6Kjclj0FCm
         aR2dfS0PPpsJr4QKiXYyT29Jzb0GIA0K8FAiCir0JOdQ0X9ahyJ8E50G7lAwO2hqw0Ba
         KCjA==
X-Gm-Message-State: AOAM532jK6U8Lg/7t6QYHzgl5C2RJuF25sGqUXgJjXv88kN0VhlJvQZu
        nA0YDJ/gOdD9hYg/ulqqQYM=
X-Google-Smtp-Source: ABdhPJw81uRyj24zCh763+6zJC7YkxjUK4+aqtS7HyG2wlPVtSBqHqeGdr2FUiKyUQKYCxUXJtJv3A==
X-Received: by 2002:a2e:7315:: with SMTP id o21mr3229772ljc.120.1598543022146;
        Thu, 27 Aug 2020 08:43:42 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id u6sm548595ljg.105.2020.08.27.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:43:41 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Denis Efremov <efremov@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2] ARM/dma-mapping: use kvzalloc() in __iommu_alloc_buffer()
Date:   Thu, 27 Aug 2020 18:43:32 +0300
Message-Id: <20200827154332.41571-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827151541.39662-1-efremov@linux.com>
References: <20200827151541.39662-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvzalloc() in __iommu_alloc_buffer() instead of open-coding it.
Size computation wrapped in array_size() macro to prevent potential
integer overflows.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - array_size() added

 arch/arm/mm/dma-mapping.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8a8949174b1c..c1f864ff7b84 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1199,14 +1199,10 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 {
 	struct page **pages;
 	int count = size >> PAGE_SHIFT;
-	int array_size = count * sizeof(struct page *);
 	int i = 0;
 	int order_idx = 0;
 
-	if (array_size <= PAGE_SIZE)
-		pages = kzalloc(array_size, GFP_KERNEL);
-	else
-		pages = vzalloc(array_size);
+	pages = kvzalloc(array_size(sizeof(*pages), count), GFP_KERNEL);
 	if (!pages)
 		return NULL;
 
-- 
2.26.2

