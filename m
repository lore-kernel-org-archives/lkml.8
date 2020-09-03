Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07E2C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A91A2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwZHjocM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgICOvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729235AbgICOvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599144652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=1FPRhJoWjqG8+gQHE9bU9UzjjoLvgSrA9NVzRzJ0CRg=;
        b=bwZHjocMavLi9635e/4H2ZjfWApHbYtQf11fLMJFXBO3Y9pNHihcq1wPxdRp5lQfUjsjXs
        VjH+RQMSjGkL6sx7IcJFh2rA3bWl4LfIbiV+3ah67WBDGldlv5ssxgcnoliYkK2aT2rcSB
        sxD733l5Vbym583cJJ/V6LLOOnruFPE=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-2RS48A1dNlSrJRLMPFoWYg-1; Thu, 03 Sep 2020 10:50:48 -0400
X-MC-Unique: 2RS48A1dNlSrJRLMPFoWYg-1
Received: by mail-il1-f198.google.com with SMTP id f132so2466820ilh.16
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 07:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1FPRhJoWjqG8+gQHE9bU9UzjjoLvgSrA9NVzRzJ0CRg=;
        b=fjZ8FF1Pw0ud1QImOyi5vuM4X/jpJUsMr6vqt5oYaTbb9iPWroX7qT4pYVF0r6nXOY
         BbPOAec58vZhD5YpxxXnU63DBcKEDl+INtx7aCHyJ0/+FW5qZ+b78jIotT6KXFoFg+HU
         cfSWQB/zPJxk8qcxtRH9SzPMJoLLdcARS9L7JEaBXe7o0eAmcFescvY0dVijXVOJPTer
         pI9CgGUAbARqQE+gUNTdrgHcZ9eRF10Fx0zGbvnUXPUU74OFalGtAfEBu5srHaWu5/Oi
         +eKgpw/NyyufLw/gy9L0O3QjSxrKdiMxHr+zmM4LwPMJbPZ/em4VxI/3RCY14E0JvPUd
         IaIA==
X-Gm-Message-State: AOAM531BNCCMCLJM7cPfhlGbWig2VYMdxkfUbEKeg/G2etmyB3+kJlEx
        x/HsJb/AF45G22uioZywJJzvJZWAy3PfRJ/sVqVI309DXWDub2BWzlphprRxvMyAlUqy/amkjCt
        DYi2o8CxhkOi2v1+Uv3sZSAkL
X-Received: by 2002:a5d:8042:: with SMTP id b2mr3475470ior.60.1599144648123;
        Thu, 03 Sep 2020 07:50:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+uZWD7pr5mF1kBXgGw1mBpqel5ly9hQlNTFP+qQtdH6x+qIPuwZN8Jg8WqaLHCyom8VtKoQ==
X-Received: by 2002:a5d:8042:: with SMTP id b2mr3475460ior.60.1599144647939;
        Thu, 03 Sep 2020 07:50:47 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c7sm1515541ilk.49.2020.09.03.07.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 07:50:47 -0700 (PDT)
From:   trix@redhat.com
To:     mchehab@kernel.org, natechancellor@gmail.com,
        ndesaulniers@google.com, brad@nextdimension.cc, mkrufky@linuxtv.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Tom Rix <trix@redhat.com>
Subject: [PATCH] media: em28xx: fix function pointer check
Date:   Thu,  3 Sep 2020 07:50:38 -0700
Message-Id: <20200903145038.20076-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analyzer reports this problem

em28xx-core.c:1162:4: warning: Called function pointer
  is null (null dereference)
        ops->suspend(dev->dev_next);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~

This is the problem block

	if (ops->suspend)
		ops->suspend(dev);
	if (dev->dev_next)
		ops->suspend(dev->dev_next);

The check for ops->suspend only covers one statement.
So fix the check consistent with other similar in
the file.

Change a similar check in em28xx_resume_extension()
to use consistent logic as its siblings.

Fixes: be7fd3c3a8c5 ("media: em28xx: Hauppauge DualHD second tuner functionality")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/usb/em28xx/em28xx-core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-core.c b/drivers/media/usb/em28xx/em28xx-core.c
index e6088b5d1b80..d60f4c2a661d 100644
--- a/drivers/media/usb/em28xx/em28xx-core.c
+++ b/drivers/media/usb/em28xx/em28xx-core.c
@@ -1156,10 +1156,11 @@ int em28xx_suspend_extension(struct em28xx *dev)
 	dev_info(&dev->intf->dev, "Suspending extensions\n");
 	mutex_lock(&em28xx_devlist_mutex);
 	list_for_each_entry(ops, &em28xx_extension_devlist, next) {
-		if (ops->suspend)
+		if (ops->suspend) {
 			ops->suspend(dev);
-		if (dev->dev_next)
-			ops->suspend(dev->dev_next);
+			if (dev->dev_next)
+				ops->suspend(dev->dev_next);
+		}
 	}
 	mutex_unlock(&em28xx_devlist_mutex);
 	return 0;
@@ -1172,11 +1173,11 @@ int em28xx_resume_extension(struct em28xx *dev)
 	dev_info(&dev->intf->dev, "Resuming extensions\n");
 	mutex_lock(&em28xx_devlist_mutex);
 	list_for_each_entry(ops, &em28xx_extension_devlist, next) {
-		if (!ops->resume)
-			continue;
-		ops->resume(dev);
-		if (dev->dev_next)
-			ops->resume(dev->dev_next);
+		if (ops->resume) {
+			ops->resume(dev);
+			if (dev->dev_next)
+				ops->resume(dev->dev_next);
+		}
 	}
 	mutex_unlock(&em28xx_devlist_mutex);
 	return 0;
-- 
2.18.1

