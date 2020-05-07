Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA85C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA47B208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="dkeBq94O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgEGVok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgEGVob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ACFC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:44:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id nv1so5915909ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p3qBa9K9MbgLEfhWUqlAktM7PPXv8tgud53nGFCyYG0=;
        b=dkeBq94OBb3NF7kVoAbkVx2HSO3CU2chuvwHNFGEWXV0yhNdXxm/WFjxCC0MkuBwOQ
         ukTQVmH3uUPgYCweOd1LQwPUAiwXSwuEHHA3DGaAzdHCj7mD6A77knGTR2DbyLLaoMmr
         P9/xT7V4BL2slYRI2haV4GFVTBcxtTPf1JtlHWg9BSOm7kTAMgWRJ5oRuiN5qcHOOlyX
         BNtTA6Fe24s8s4Oa3ZVX5xjq6Kj2yZ8P5YLEXdWpAx+lfEA+3pPnLlKxThXhKsFv5fWe
         zkNndfIoksb9SEG4OkxblR24QSkvS1+qVaCorcEY8RlAtYD1QYFhXRzyfiZlmBPsE72S
         mwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p3qBa9K9MbgLEfhWUqlAktM7PPXv8tgud53nGFCyYG0=;
        b=eMo2coVjEoYI+5epQlBZL2yApjFlF6P+em17TlyHz82JEJL3MyN2AvZZ6a99IaMrX8
         h9/sm1frio9ptsP4HHDIy9NiP0KqKfR1zOOJDmB97kzFCQLC/ixwWOSZz2bcYIsjLUdS
         MbfjNTOLlbWC8FHIdP9wlYf7fX+3Wyqp52k22Ryu4xZdWZa0W8Jb331WZVJ+GxoufoxQ
         kwqR9lQeFXeXyCcHHJcMjf2GCEveP6+S4AsV0EUe/MeqZvPtiFd3uOnI0GuN3L1IrXYK
         /UKc35hoS3kygNrtD8xZia1zp554baC5FyZviYnzdZlpVP1G3xSSQhldQ9hAlKFWyJfN
         Ksxg==
X-Gm-Message-State: AGi0PuaqIUbornj6LiS7t5026uMxOkk2GqA+Ww0yPqDTw1PqRiOe141E
        zrmHJPwctDTHmAOoEVWTiHt/lw==
X-Google-Smtp-Source: APiQypIynmIlSHyf+k65C+y42oKo8PLrA1c4S7WEkoE13fKDpP+OJZwLHdb5GIwza40Y5+tp0xnxFQ==
X-Received: by 2002:a17:906:a857:: with SMTP id dx23mr14469278ejb.52.1588887868069;
        Thu, 07 May 2020 14:44:28 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:27 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [RFC PATCH V3 10/10] mm/migrate.c: call detach_page_private to cleanup code
Date:   Thu,  7 May 2020 23:44:00 +0200
Message-Id: <20200507214400.15785-11-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can cleanup code a little by call detach_page_private here.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
Added since RFC V3.

 mm/migrate.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 7160c1556f79..f214adfb3fa4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -797,10 +797,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
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

