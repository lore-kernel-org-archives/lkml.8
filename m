Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1E2C47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A60120731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="AUo5ie4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgD3Vwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgD3Vwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:52:44 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156B2C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:43 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id k22so5825655eds.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VQtiN0YF68ouYEl0FBCwGef51NS629CikCik/xuB3mA=;
        b=AUo5ie4M5LC6EyVTONtWCWaK6x9Glpt0fKqCXZVKpIls4fS+TQMg9AZVj57+ZKp657
         KxpTHzcmRADvXQhinXFVjaJFVsM9IuKylOT606jy/n3S8NWY7zE2X3rHDq7FW+dv5OL5
         1HMaxuBEfufCr2WCuB4rDNQOV8qEERy8iOyCbgO42UphAQhYWWLT2Kl7Ouklm/t3uF1a
         fBBUzA+7kF8C+npPOk3+v2AgOy9vTvhHtGfHdvNk/1rBbn6A5aQS1qjv/ZBpzIHD8l/5
         RK7vYHRT3JNA6f1tCk3T27BEPLr6hIdu7kSYpHu2/hF36qamf3WGbDphvY/vVIgJThmr
         9n9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VQtiN0YF68ouYEl0FBCwGef51NS629CikCik/xuB3mA=;
        b=dDD9wIpvJfJK4Dlo09oFAPZanMFrldXS/aNAuh8sIGNBO7WJQQURP511wt8Ejgc8oU
         RqTHNuKPU/iWAWy+ZrCFJ3K8CzKdXtm/DfGrcPUYI7Ti4xCgJ7noAfIxn+3KxTXrA3hD
         LltJBq74dN2CGbXJ0pM5XTTzp01SU+lLrBhbgjd0y85eMgJJ/hRyKNjzXE0DNy1Gg03o
         bMXrqWzHdBG6vhGWKwoPszhESAnbDypVEfsDd++ujrTulJX2E8zFaRcz4S9uqjr/nph/
         uqHFf66wO53eu9G97SG0hnfxJl161BVN0Hzj4tnGYgoaSDlEEBIec8iG3WwA8tZGAGjj
         SJ2A==
X-Gm-Message-State: AGi0PuaLTHUqzeywr0hUUBiWY+TaJwzObN+9zV3fEbu4+XPhQAe3XF7/
        0VmDeklkNhLb6ia6Mtl8Ljo/4A==
X-Google-Smtp-Source: APiQypL49Bp/BPGNJL3rW/dArQDsk2UFazjTXaUNS6oloFuEsd404kXblrgA4wta20gl8BWTl2ZM7w==
X-Received: by 2002:a05:6402:286:: with SMTP id l6mr1062803edv.134.1588283561709;
        Thu, 30 Apr 2020 14:52:41 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b82f:dfc:5e2a:e7cc])
        by smtp.gmail.com with ESMTPSA id f13sm92022ejd.2.2020.04.30.14.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:52:40 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [RFC PATCH V2 5/9] f2fs: use attach/clear_page_private
Date:   Thu, 30 Apr 2020 23:44:46 +0200
Message-Id: <20200430214450.10662-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in f2fs.h.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Acked-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.

 fs/f2fs/f2fs.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ba470d5687fe..24d22bd7352d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3051,19 +3051,12 @@ static inline void f2fs_set_page_private(struct page *page,
 	if (PagePrivate(page))
 		return;
 
-	get_page(page);
-	SetPagePrivate(page);
-	set_page_private(page, data);
+	attach_page_private(page, (void *)data);
 }
 
 static inline void f2fs_clear_page_private(struct page *page)
 {
-	if (!PagePrivate(page))
-		return;
-
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
-	f2fs_put_page(page, 0);
+	clear_page_private(page);
 }
 
 /*
-- 
2.17.1

