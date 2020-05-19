Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF255C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25D320C09
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="dMU1FC1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgESVl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgESVl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:41:26 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F27C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:41:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s3so752416eji.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8pHDt6TZphRZyh659OaqVb1mgoicXJZH6YOE21j5ScM=;
        b=dMU1FC1+X+LgzrzDd8puroJ2VjoLl1b7VWx3Oxtyt5RbuHUQTWTuQLJk4KiUdb4hch
         BOhMOsMa+J+rREOLJwUsj56zTOlxXC2WesxpqG32wtYHMXotR7Bxv6jTxRKbk8j03ZXt
         fUBFDifGQEMkYvtRxGSYJDBgtvJyWBw656MILr0ozZkvxB3NbFT+XkVBtn3nY+mpTsDH
         fkg3DmX9UVMYxBNBAT6Z5gxKSD2ZDXbMfEfN1B0N2FgeXBawY7+lPjO1Aqk6iJfuzwzM
         W55AKS+fNrxcGfJI+ritFN9TMTQ8FvEJPoGMPSkPKYNauuL6Yx4M9XmccEbkC26jlWNw
         RFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8pHDt6TZphRZyh659OaqVb1mgoicXJZH6YOE21j5ScM=;
        b=oNyXh3+nCaPV6DHptDz6akwASS0wPNnqV8gmk8t7aZtgd6AHSCBkU+KcdWoS2JWDyK
         c2Ag/YkNMa1eSVKu+KL5Yz34ZmEBI+zNin5kQ63mp7hFkP1wBg1soOlOFCq0ndHXYuc8
         aodQKqsApIR1oZPURcyoBJ8wCylnDcOn3G2tDYRCn4OUDPjlxDKUGkSKVx/4BqFISfQx
         1JG03l8lxfdwb1xFQwFK8LKe16alaMejcTOxFv5SLH3utvw8n2PthihjxicSU010GF1Z
         p3TAHTRLWeOcH8TJLXvq6+EJ509edZ1DJS5ADs0+1a+nLood9jBHxLTdWFGa4jmumjF+
         R2TA==
X-Gm-Message-State: AOAM530uGQFxhnaXdYsZDVOP++a/0OnJYxHOlZoKzzaxsNg1VdH5+CQI
        XA2phVITwSljUFO/oQMvEXKQkQ==
X-Google-Smtp-Source: ABdhPJzwziXIgJV3keA3OENqJBxwLFq+cjMJNMlZTNY3H5m85XcQYW/VSr4fcseQdwsGI40fWd9+NQ==
X-Received: by 2002:a17:906:f53:: with SMTP id h19mr1065446ejj.343.1589924484583;
        Tue, 19 May 2020 14:41:24 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:61fc:84a0:6c2a:7c97])
        by smtp.gmail.com with ESMTPSA id j17sm337728ejs.108.2020.05.19.14.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 14:41:24 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [UPDATE PATCH 10/10] mm/migrate.c: call detach_page_private to cleanup code
Date:   Tue, 19 May 2020 23:40:49 +0200
Message-Id: <20200519214049.15179-1-guoqing.jiang@cloud.ionos.com>
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
Add the cast to fix type mismatch warning, sorry for the mistake.

 mm/migrate.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 7160c1556f79..44546d407e40 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -797,10 +797,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
 	if (rc != MIGRATEPAGE_SUCCESS)
 		goto unlock_buffers;
 
-	ClearPagePrivate(page);
-	set_page_private(newpage, page_private(page));
-	set_page_private(page, 0);
-	put_page(page);
+	set_page_private(newpage, (unsigned long)detach_page_private(page));
 	get_page(newpage);
 
 	bh = head;
-- 
2.17.1

