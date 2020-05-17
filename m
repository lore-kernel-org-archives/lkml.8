Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B69FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE54D207E8
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="a/T5o12+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgEQVrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 17:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgEQVrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 17:47:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB71C05BD0A
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:47:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z72so8211685wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lR1LCvSA9ocOsPLtqrXXi3mTOw1gLUQvTrYWGpkyxaw=;
        b=a/T5o12+72KN0Xmgv+tDC1icraJLfq7GrNfFH121SZeKS9A3+wf4wtGCgZWkT/rJKc
         RxRihgg6z+CxcgAT4l6LjZyLWnodM/GunE3LJZjXezzHprpr73yGBvtE7TAAzOQGaNS9
         FJDsbE3fdNpXWDphsiZ5aNH1//IYzOUmprBzXC05lju4U38+cePkX44Rd+fo/EP93xVW
         jaCywtCdeVJ2/fC6O3ZQZd3FPJk3/Ehiu7VYHFWGxpsjZUELLSO1QKRleugK0R7l1Bg+
         SxW6yGrKeaMMxuDLGiRJkvGYKYj9Yzi8spEJ/TSdeJ6hlbPbewj2ry5Wu9pY4K0zQBzw
         NhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lR1LCvSA9ocOsPLtqrXXi3mTOw1gLUQvTrYWGpkyxaw=;
        b=dTJsgd/xy9eBg8QIzW7O8yIsZM/22LZZQ/XS6TLyrMUTTHn9Rp7Gcwikws3227LJ7l
         fO1buHRFxKzbqNUDGzU+6LULgWYNgnPkZNxNag6OIVSqWjK8Bh4lrEO1ON5mfECd0BF1
         y0RwcR/Wuw/AP655b4TJ50J99YiDTFN9x842kLX1KjimzUnPUBwqhmV1g9mlYL+aAysv
         yDi5S8O58m8CTNvpq4MxknjJJdgbngjDiT+CiuGxfHF2C2izL/QkM+fV3GMm8uoyxkuT
         5z/zV00oGEq8ccdvD/Ob+zIdM2veB8BLhTvO10F0VLK4zWcIoAenlyyvzmr9VoXPsILr
         VOtA==
X-Gm-Message-State: AOAM5326aJy8Ic5KQikdJPRySCMMZ5I//eYgzRj4kewyf3DevIhHwEIl
        DsbN1QSqxQvyss/tmArBnuff9A==
X-Google-Smtp-Source: ABdhPJw3NLqm+FD5LnZosOiR2OArkmy/YSCBZFg1G1IO3rkHSBH0goV/RgPLqGdUiTAM+eJ0QrVADA==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr15910191wme.139.1589752053782;
        Sun, 17 May 2020 14:47:33 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:bc3e:92a1:7010:2763])
        by smtp.gmail.com with ESMTPSA id v126sm14441244wmb.4.2020.05.17.14.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 14:47:33 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup code
Date:   Sun, 17 May 2020 23:47:18 +0200
Message-Id: <20200517214718.468-11-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can cleanup code a little by call detach_page_private here.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
No change since RFC V3.

 mm/migrate.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 5fed0305d2ec..f99502bc113c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -804,10 +804,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
 	if (rc != MIGRATEPAGE_SUCCESS)
 		goto unlock_buffers;
 
-	ClearPagePrivate(page);
-	set_page_private(newpage, page_private(page));
-	set_page_private(page, 0);
-	put_page(page);
+	set_page_private(newpage, detach_page_private(page));
 	get_page(newpage);
 
 	bh = head;
-- 
2.17.1

