Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAA9C7C7E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1893E2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="arVADTHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgD0Hmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgD0Hmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:42:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F56C0610D6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 00:42:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so19315867wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 00:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WklQum+x0z5V9R5tHm2+hiPAk8mSt3Evh9Pc0IUIHmE=;
        b=arVADTHpoWcouRgjhe2ruxU3zURDN9Du+CEQ3uvkL+e/yzk8bWfu5JZuOvtahupy+Z
         8vuK68H2XLgMvUUZhwopsrfOgJX2mXCEoxIfDMQketXBXKOXXgUgV5R1RvJZYDWCY1uA
         tCWS4wIePmfaRCnzzQ4iZxcu3tQyS0pydLrasKCdnnlRffNYZFauFEADls78CJvfTadT
         C4ACE26NgonIzFM0LtE2vjET/1mIet+4YB+wtRIE/05eTFrQYYM9HA+wJyrCDHybnnm2
         3wDqJiAG8oYB9ATo4V9C27V1VHEKXvx4VTykGP3TMIIQoQND7zhBVs6v6Yfm6PUB5s3w
         vGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WklQum+x0z5V9R5tHm2+hiPAk8mSt3Evh9Pc0IUIHmE=;
        b=XYeSsYyVzQ5mXjZzqTBZszxgNypTxwVV2ls0zLkdtQHOKERJd3lr0DmPgfRfTgDknx
         SMjiiFgQ1TBhAulG0opyV9sZf4VBdd8F4iAMD2ZQLeeXIGvaAFbw2xXwKQLreXK7ynr2
         OH+Dq9Yd+2TsRjpbQF4grc8FejrhIkhoWWH36//TDf+ST6TKkTyBsbhTe69ABI0yNGnz
         nswilTBhNYGoY0ii18FGrxWNHTjBmcqtLPb27ud4gYeFk15iQLDvbKOWZY8X1KjTgwqZ
         oZVXz34C6Ehpp0zJJiKF7BGhfaOCrZwLeCv72Q7/0ouXk4sGr47R2F46WMC5/fBlkEZm
         AFhw==
X-Gm-Message-State: AGi0PubKPSZTpFlf/SWYQGW7yMVndiF3hsWWEIY3QKWVnpg+d376JlMx
        J3TfAmrxblSDrfBfDcObEeI5Sw==
X-Google-Smtp-Source: APiQypJ83XmOkAsrqagWwyC9NoAKpSuxzYwOYns2jlzw0+6U75xJxgkndNV5WRm/GeYCC+L0SLqcFA==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr23185171wmc.146.1587973355743;
        Mon, 27 Apr 2020 00:42:35 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id x132sm15091658wmg.33.2020.04.27.00.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 00:42:35 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v3 2/9] loop: Factor out setting loop device size
Date:   Mon, 27 Apr 2020 09:42:15 +0200
Message-Id: <20200427074222.65369-3-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200427074222.65369-1-maco@android.com>
References: <20200427074222.65369-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is used repeatedly.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f812f11649d3..4630d098cc54 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -241,12 +241,29 @@ loop_validate_size(loff_t size)
 		return 0;
 }
 
+/**
+ * loop_set_size() - sets device size and notifies userspace
+ * @lo: struct loop_device to set the size for
+ * @size: new size of the loop device
+ *
+ * Callers must validate that the size passed into this function fits into
+ * a sector_t, eg using loop_validate_size()
+ */
+static void loop_set_size(struct loop_device *lo, loff_t size)
+{
+	struct block_device *bdev = lo->lo_device;
+
+	set_capacity(lo->lo_disk, size);
+	bd_set_size(bdev, size << SECTOR_SHIFT);
+	/* let user-space know about the new size */
+	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+}
+
 static int
 figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 {
 	int err;
 	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
-	struct block_device *bdev = lo->lo_device;
 
 	err = loop_validate_size(size);
 	if (err)
@@ -256,10 +273,9 @@ figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 		lo->lo_offset = offset;
 	if (lo->lo_sizelimit != sizelimit)
 		lo->lo_sizelimit = sizelimit;
-	set_capacity(lo->lo_disk, x);
-	bd_set_size(bdev, (loff_t)get_capacity(bdev->bd_disk) << 9);
-	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+
+	loop_set_size(lo, size);
+
 	return 0;
 }
 
@@ -1055,11 +1071,8 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
-	set_capacity(lo->lo_disk, size);
-	bd_set_size(bdev, size << 9);
 	loop_sysfs_init(lo);
-	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+	loop_set_size(lo, size);
 
 	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
 		      block_size(inode->i_bdev) : PAGE_SIZE);
-- 
2.26.2.303.gf8c07b1a785-goog

