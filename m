Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7262DC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F852082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="FAMz5fbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgD2ODv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727949AbgD2ODs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:03:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA9FC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x17so2683669wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vJRGIxviTVuQOHD/t055S82ZgyhsDZt1HgODzUPBt0I=;
        b=FAMz5fbij9gEL5YFRhS6bp6ikk4ZxQkd0SJVt068YCgnSpGZ954yW+C6oVAAN7r09K
         N3Gij48s/YN3CUvtxoWe5ty7etv4bNix5ZZ4IKp7tJoJw7Ygf6g72NSWw8HRpK4qgZN6
         I+Va9t/Ht2G3JcYkRXcPTvQ2jMbtfrKfQ4hDr+TDtvXg+D9OzIDsTUGlskzgC8Nyyvbf
         fRYsoi2FbDtrEJgb3uAT93DqT7rhARm9+3jl11BSiIQkV0CQ6aB6VYj96/g8BNqdoRkg
         GWmwC4M4+H7ORQyaTi0JH/mQv6sjF4pCaHiSQfgMOYezARbU56ETqPm4dKjQQGkkGQg7
         Hi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vJRGIxviTVuQOHD/t055S82ZgyhsDZt1HgODzUPBt0I=;
        b=oZIIxAt0AI7yTk7zq1phVmSaX2ltWUB2hjX3mzbw3jenKpfx8pk7O0ge26YWkWk3pE
         wlDZhDlVVyXcAVqRaOcXcaZ8oKLnOJzPOav/M4dyQrFqyHqzDUIzGaNCkGHgAaaIrztw
         XR57ZVVK6R033JLOXcSp0ofKgIKUFJZJ+5rVbwcp2XxLH92OtiH7U6s4bLekXtpYP/W+
         n1Di2Wj0fDLzjUoM897fTpjQUHdf6UaMq4cEzknea9a8DJESSy99AQfUcAfkNxWATRA6
         YdJlPJpZlxZVFjh6WNTnjs9IQZqPLUrZbc5D+YDgOchxSS6mphz5WXowrfe9jfzlJ74w
         waWw==
X-Gm-Message-State: AGi0Pua3VsnSJt6PrkhTxRuh64s2KscPluqVU+YQ1jAVNGS636Rx4Kzg
        CSIpwr2eY0MPjc74PSR0BWVcFw==
X-Google-Smtp-Source: APiQypJ76WMHhpA7mLprFkyfvgMFHW0slffzZUtpl3y8w3UqHCST3nm+eX4TJGahw4FXC31y2kjKqw==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr25792895wrq.273.1588169026426;
        Wed, 29 Apr 2020 07:03:46 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id d133sm8887008wmc.27.2020.04.29.07.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:03:45 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v4 01/10] loop: Factor out loop size validation
Date:   Wed, 29 Apr 2020 16:03:32 +0200
Message-Id: <20200429140341.13294-2-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200429140341.13294-1-maco@android.com>
References: <20200429140341.13294-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensuring we don't truncate loff_t when casting to sector_t is done in
multiple places; factor it out.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f1754262fc94..396b8bd4d75c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -228,15 +228,30 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 		blk_mq_unfreeze_queue(lo->lo_queue);
 }
 
+/**
+ * loop_validate_size() - validates that the passed in size fits in a sector_t
+ * @size: size to validate
+ */
+static int
+loop_validate_size(loff_t size)
+{
+	if ((loff_t)(sector_t)size != size)
+		return -EFBIG;
+
+	return 0;
+}
+
 static int
 figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 {
+	int err;
 	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
-	sector_t x = (sector_t)size;
 	struct block_device *bdev = lo->lo_device;
 
-	if (unlikely((loff_t)x != size))
-		return -EFBIG;
+	err = loop_validate_size(size);
+	if (err)
+		return err;
+
 	if (lo->lo_offset != offset)
 		lo->lo_offset = offset;
 	if (lo->lo_sizelimit != sizelimit)
@@ -1003,9 +1018,9 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	    !file->f_op->write_iter)
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
-	error = -EFBIG;
 	size = get_loop_size(lo, file);
-	if ((loff_t)(sector_t)size != size)
+	error = loop_validate_size(size);
+	if (error)
 		goto out_unlock;
 	error = loop_prepare_queue(lo);
 	if (error)
-- 
2.26.2.303.gf8c07b1a785-goog

