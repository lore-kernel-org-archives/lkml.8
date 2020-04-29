Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086E8C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD31D2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="sxIzaHkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgD2ODw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728007AbgD2ODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:03:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3FDC035493
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b11so2679616wrs.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GVQ6PJVYJ1ywRYR59x9OnKcPE1BH9cVkm73W4+2Zo6k=;
        b=sxIzaHkm4DJewXcHHF7Lc2rxcr6U2EwKWQsb+VKVC6R4KesLhY2vD/na6H4tlmOK9/
         HxcXJwT29QU1jNUghkYucNmUY2JiggMgdeLUhyQSMqNk0lXMWefTquFcCzio0ljO05QS
         VbyRilWCdf3See6S1xwAgB0MuNwVQANodbrBSL/Vioj89L/zmYBBXAtjYsJfaW+TAMM6
         sL9WVolxXpeRl9RlBoMR40192Y1xqH8jxANH73uCWshGc1+QJfMO+3OzWTYQldI1ZhU/
         dbKHj3/iG9wHVlrZpJQeaGTZcQjx2bpBE4w4Xe70DOYT7pV6Kwpy3e3AJS7pCqtC50xm
         +Nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GVQ6PJVYJ1ywRYR59x9OnKcPE1BH9cVkm73W4+2Zo6k=;
        b=UbGtdxgcwg6PlxEO6t3aEiFLanVn4Vq3N5QS2kRTZHvZyvzaS7Hu0UvCj7Gi6gFnuT
         rUjRm8DaajdC/sDBQbciOKofbYRN6D7IWFIHxWExhkEdp2veQHP8mI10qx1CJftnswkR
         56MdIL0wMrLb6M+DIAuKPKM1f7nehEIjhmCZ86p+cr4XZ60CKgwZeOGJ8o+w2Nxkx2cE
         LEh9hSfbk9470+8LGI2AfvJo+oYcieLFnj5nPHpayLEJwlpwR33FvAa23Oj2ZAR1e7HS
         peN24Yfuw4XE6sn17zp2RW7YAwXkQ4o7cUfEY0MuUYQXaLyEjPEOytEZVU8LHl3DJosM
         ue9Q==
X-Gm-Message-State: AGi0Pua7FAfqmqZ7TOlyzpPijIoVAEWZZhXi9zvMKuVhsIB6T2llwIRY
        b4LRltjhWFtBYxXMA6xpbJ0c+g==
X-Google-Smtp-Source: APiQypLMl/5GOABd24RbSC64VM+meR4NKVn0FFgfHYJQTI/1/27Ydb0VqQiSLlmjgVmI1tyZTO4GKQ==
X-Received: by 2002:a5d:498b:: with SMTP id r11mr39222128wrq.368.1588169028956;
        Wed, 29 Apr 2020 07:03:48 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id d133sm8887008wmc.27.2020.04.29.07.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:03:48 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v4 03/10] loop: Switch to set_capacity_revalidate_and_notify()
Date:   Wed, 29 Apr 2020 16:03:34 +0200
Message-Id: <20200429140341.13294-4-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200429140341.13294-1-maco@android.com>
References: <20200429140341.13294-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was recently added to block/genhd.c, and takes care of both
updating the capacity and notifying userspace of the new size.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6643e48ad71c..8f3194c2b8aa 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -253,10 +253,9 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 {
 	struct block_device *bdev = lo->lo_device;
 
-	set_capacity(lo->lo_disk, size);
 	bd_set_size(bdev, size << SECTOR_SHIFT);
-	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+
+	set_capacity_revalidate_and_notify(lo->lo_disk, size, false);
 }
 
 static int
-- 
2.26.2.303.gf8c07b1a785-goog

