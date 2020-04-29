Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E0EC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5FBC2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="SlWtdLeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgD2OD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728081AbgD2ODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:03:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F33BC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:53 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b11so2679838wrs.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TIeVXquln7tlIswAu85f97R17dJ4bzbZ9XV/+MshL8g=;
        b=SlWtdLeYzYPtXagrnKtjgKGpFduQsopIMSr3rFtGr5NKZQnx6pvIqJ1bzghFJinboF
         d9mc05RTxXBRZrTDUFfr5cJmb6DM7qhDviLAXWGUdR30Un0HTiJIw398GNmtcrNIHWzC
         5E7qrwv2trXInl3YWdhWJvPYAtWUgC2vQ+p61aOxPJBSZhe53Q5hgZS7+PdKVEYj/pE1
         6oQrISeDHDRVIO0QdQmk7HJUjbcxYEXNMhq+mNuaMcXzdh3F0tLFt50fK8IAjJCCdxl/
         K0t4ZK/YBANLr9llB9W1a5GEW+tshtgWOqyh0F5XjXz8jrMuMtOZv5gegVmVeMlIG8Fb
         SP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TIeVXquln7tlIswAu85f97R17dJ4bzbZ9XV/+MshL8g=;
        b=K0KXU48R4dX0yibavIeFaBiWU/vHy7EnCJFprRq9kVa4IHPZExBjcobYTrIYAiT1aT
         N7LtsaiWVnTDMInwnm3S0MKIWkoOrUA/wFYGX2sgQiXu/SFL+wx/JugsCbve+AS7gY6/
         7Ypvhh9oXDyskf9upwSY682l2Xmbg8++8xCHnhLekCp2iWhEPkfer+TkIDsiiIBogHI4
         oqgBzS7auP6RW6qu09LjeKcdUEZEAPl9URv6O+aArQkqR4in5LjyFgT9Z3IzSXvhBjgf
         a9n+2YD4317B7BxUcLdDYHNpgbFcJBCQ8e3QiTaE0W/dh2FqBxdAwyjvURlRQURaiKN+
         V2ew==
X-Gm-Message-State: AGi0PuZIz9t6wsosTHChMsKECDrSiRuC14O40fKp8OQ21IEbt1jccNc3
        0PjmuoBFT+cx0vdP9vQs/qpAHw==
X-Google-Smtp-Source: APiQypJzPpeiQf7KPXZBFO4DRN+xbvSitwNF/2b2JhPozw2wP25rWwFUGnyFMDbuGAGQ6oHAJ5rUow==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr39219978wrv.314.1588169031853;
        Wed, 29 Apr 2020 07:03:51 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id d133sm8887008wmc.27.2020.04.29.07.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:03:51 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v4 05/10] loop: Remove figure_loop_size()
Date:   Wed, 29 Apr 2020 16:03:36 +0200
Message-Id: <20200429140341.13294-6-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200429140341.13294-1-maco@android.com>
References: <20200429140341.13294-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function was now only used by loop_set_capacity(). Just open code
the remaining code in the caller instead.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9f5913879921..32755e874326 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -258,21 +258,6 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 	set_capacity_revalidate_and_notify(lo->lo_disk, size, false);
 }
 
-static int
-figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
-{
-	int err;
-	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
-
-	err = loop_validate_size(size);
-	if (err)
-		return err;
-
-	loop_set_size(lo, size);
-
-	return 0;
-}
-
 static inline int
 lo_do_transfer(struct loop_device *lo, int cmd,
 	       struct page *rpage, unsigned roffs,
@@ -1560,10 +1545,21 @@ loop_get_status64(struct loop_device *lo, struct loop_info64 __user *arg) {
 
 static int loop_set_capacity(struct loop_device *lo)
 {
+	int err;
+	loff_t size;
+
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
 
-	return figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit);
+	size = get_loop_size(lo, lo->lo_backing_file);
+
+	err = loop_validate_size(size);
+	if (err)
+		return err;
+
+	loop_set_size(lo, size);
+
+	return 0;
 }
 
 static int loop_set_dio(struct loop_device *lo, unsigned long arg)
-- 
2.26.2.303.gf8c07b1a785-goog

