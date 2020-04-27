Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EF8C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358582168B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="qiWr5IRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgD0Hmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgD0Hmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:42:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333D8C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 00:42:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v8so15256904wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 00:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xcqA+A5T/eSVdFtVfWGXjYGiqSe96zXgzrOUnJqE+k=;
        b=qiWr5IRyG5B4RKrJoDDtT8SjaYb8O6m4vlG/UDbEJ+kzh9zuT8Kr48zBapp3HkOhdt
         c/b7+BF3iGfc6P/0+/VJSbLn1rBPNWxkB1Mt92wUX/UR4JSxKE0g2SjorK89CNnzZuqe
         xeGdXtKQ4IjckhaETkRgjTP4x2Xf0qutb2DD6Ha81BDA2YynHDUQpauF4So5yeP1uKng
         7/ZaauHsfmDsK9Skv1adaZEg6pN7W00u/ftK1FybB5FymVSnUyTfhQC2TbtH3/G26gxw
         0V+WKXeEoUijb53PjRyjSH5fBlR0/nrD/hw2PVJAmiz4veXYrbEPNLgbvS016EpWgMET
         F5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xcqA+A5T/eSVdFtVfWGXjYGiqSe96zXgzrOUnJqE+k=;
        b=rLCn1bMawTeFcH2D1Jr3nAU32YX4+BKZDO9mQvCpRl+1pLzSu0pHQjqF5vZbrUCM32
         lUcirXfn8ip4N4+IFprbXt82ovzZ61lSviaQQ0OXihp6x6Ss8j8DT4cDBpUSkd8zrRYv
         QGMvxQr4cUUrr/x4kHYf9VC+J4xjBe40AQ+exFNfwu3oStmmNFqVCXYZdtHTENL3oUcO
         Ier1BD+njfyoBpDW3YiB3FiyHYMK6l2hwbPI+0vsZP8hYalsCrWuJe3K1Tq9xfHX8OG9
         DqVervWETT4Qxlvp6iYw33FC27hnLK0gETQbAGKFUSR5cvL3V2Ywq4el5+A/XJkFpNVZ
         SUxg==
X-Gm-Message-State: AGi0PubUZG+AtbmsuAarIkoX9RK0rpIccV4mdFEvg0SAkALaFvwM8Gng
        SdaMM6PcBkFk18QWhG19TfRFeQ==
X-Google-Smtp-Source: APiQypIah0sHrAJ/x6WbRfPBVzVuW7jH0seRoMM3/pJfodEWhuoSFpkQDKte+QdQW/Q4yzWxxZyiBg==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr24440234wma.122.1587973357000;
        Mon, 27 Apr 2020 00:42:37 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id x132sm15091658wmg.33.2020.04.27.00.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 00:42:36 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v3 3/9] loop: Switch to set_capacity_revalidate_and_notify()
Date:   Mon, 27 Apr 2020 09:42:16 +0200
Message-Id: <20200427074222.65369-4-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200427074222.65369-1-maco@android.com>
References: <20200427074222.65369-1-maco@android.com>
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
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 4630d098cc54..2e2874318393 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -253,10 +253,10 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 {
 	struct block_device *bdev = lo->lo_device;
 
-	set_capacity(lo->lo_disk, size);
 	bd_set_size(bdev, size << SECTOR_SHIFT);
+
 	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+	set_capacity_revalidate_and_notify(lo->lo_disk, size, false);
 }
 
 static int
-- 
2.26.2.303.gf8c07b1a785-goog

