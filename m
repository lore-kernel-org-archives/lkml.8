Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789A0C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5452E208DB
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="C+aZyE0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgEGVo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgEGVoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:25 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B03C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:44:23 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id re23so5883425ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iMtexH+KHYg8WWtN7UTgX6eHTynYLEIBFReri4mWFCc=;
        b=C+aZyE0ItmHGIBdvm5jWSFvyCmt2e6ZkOwlIWvu8b0H63W29ve2rOZlf8y+8y+gmld
         ZjG9Y4WWIGb+goXnokiWHdrsMqES5X7JaSrEV/fhpzmey1WTqsjlyk0dSmog8gabW9mV
         UifUcMmnYPlLhVxtwEmS61HoE/D4xiiq4QlqcisbD0nY3ghcTLtx9KUsW/ApbVwG1XCL
         ujtW37cAyL8CrSDZL+CIJvPXUHwNEt+up9VJjMd9AVr3Bfbx7+OXhE/qvfAsmb6BvPFi
         5D+Cv0iQNc/unewS64ruKoLL/NcwnOkWm8MpSRK5TxKVUIEp9V/+mR5uDMaRX7qMEtU2
         Xnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iMtexH+KHYg8WWtN7UTgX6eHTynYLEIBFReri4mWFCc=;
        b=I9+t8lBxm4LnZgBXjz6uzO4mD1+f+7S/Au+d1zpgZ2sT1TNVfYmrWFQ66l3Cp8Xg4w
         KNN7Ae56vek8tYTF3mIQVaxHtTBkfWmX1SQp/k63PgLa/DjUwSkrZ8S33FzR+jL3y4y+
         zaY5nJTd2/z+4TinEXUzmiNE5aCsOaLS7VLKvomjwDdb+jsNM7mh5LFgwgJnX/wSs0VX
         P6R0rNJd3nEozrXofL0LbDwk97TxLo4zOCYAFz1LHfnanQg9o5G5ab/C06OPOE/wH7Su
         NK+VaJSo7bCwnuPFu8+tIEVXSnJbCU1XvTuKITPf0aFE7RpXQ/AzAmIK5uMWCCa/nfdE
         P0Yw==
X-Gm-Message-State: AGi0PuYg6E1YmwgYzaTHX10x7saHMeUPs1FbndarwB45nvyt5HRNTiEN
        kSaEopmZf8NBA9y/1ZDxdoTEow==
X-Google-Smtp-Source: APiQypIlXXZdUeLWAD5u56J3xlbgzi0w5YqlZnrUpLQfikzSZE7i3StNg5L+SIQQChqhUCbofsEzFg==
X-Received: by 2002:a17:906:5608:: with SMTP id f8mr14610196ejq.190.1588887862357;
        Thu, 07 May 2020 14:44:22 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:21 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [RFC PATCH V3 05/10] f2fs: use attach/detach_page_private
Date:   Thu,  7 May 2020 23:43:55 +0200
Message-Id: <20200507214400.15785-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in f2fs.h.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Acked-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC V2 -> RFC V3
1. rename clear_page_private to detach_page_private.

RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.

 fs/f2fs/f2fs.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ba470d5687fe..6920d1a88289 100644
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
+	detach_page_private(page);
 }
 
 /*
-- 
2.17.1

