Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ACEC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166CC20789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="h6M8NnPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgFMWOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 18:14:43 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:58136 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgFMWOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 18:14:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49ksMk5C9Kz9vZTh
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 22:14:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WixmtudMiDQW for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 17:14:42 -0500 (CDT)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49ksMk3G7mz9vZTs
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 17:14:42 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49ksMk3G7mz9vZTs
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49ksMk3G7mz9vZTs
Received: by mail-il1-f199.google.com with SMTP id o12so9220809ilf.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 15:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SHRtdP67z8uDLtvRLzGIraQQT7+sVEzlRnsgaGPcsRo=;
        b=h6M8NnPvqdAqrDAJv6UWcsp49XdeRjFKA086Kh+Zj5T5H7vdS/OUbAfnBzBlt+xPBW
         92Q756u2saHe5LEppISrQkDGW5FTPbK+tDueuVC5/Ln9Jgh0tco5Sl+8FnMOg42unTXg
         ZlxSbndL+7qdBggt3etOABHRhG83U/ki4lM1QhQCDjM5UK60oIXpGYTI9c4KytPV0Y+7
         xI2EFls8R6+1v8aU3DZpD5Y8ECwZtw1phmw3wHv/jQLuHiOfVUxx1Te6tVqigvrN6TOR
         dBl5OkSeEGvN2je4Fy8J6Updm6tvdPtGyGvqhk5nXDJWn064eofS6y7YAhouCK1dVaWz
         S4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SHRtdP67z8uDLtvRLzGIraQQT7+sVEzlRnsgaGPcsRo=;
        b=EOoUt6SW38aMuR8wwIP8ywkK2X5VC4Zmg4nKW3j0eTJ382EbFO8iEu2dlujiPgleef
         YipqhfsHCrW5JrbYE4+kX22fcQJBIe6UyR+YmAy5mx50hon0KXdhwHAs9D0NY3dh0c66
         lhRsOanlLV3w1RgrGBC/XSuMPeO+yuBkmkBbEoqF3yGxjdjHQ1RqvPaH/Xo3tGL9reYV
         PFDmI+bGt/iTXS2Ew1S1csKMXGape3zbBimsIxQLOupHjVs3Vt+6iewuqVlaKUAK9gqM
         I9377PrB1c6EjfS2qU4OO6/W1HCDbspodlAJloX7pNW9aXlZrYvnTLIYzTGXwMdzQZKk
         ysrA==
X-Gm-Message-State: AOAM531OStRMQulGBg9+tME41BEhmDzO1D76x/THpaDV3f5AEwxKiksB
        mLiC7vsv4XluZuDVhmtA4O3peVqZcwV30gZaucHXHhlNG4sBgnYVCc+7Og/kXldDTkwwk5IwNNQ
        mQS1hth5YwifLOvc7oIaAB1ezGs1U
X-Received: by 2002:a6b:2cc5:: with SMTP id s188mr20388955ios.77.1592086482006;
        Sat, 13 Jun 2020 15:14:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0lCYYRh6ocSAycvLPyWnvnC+e63kW8/89jijv8iPJrBReQ48/M8EjuMbfFy66BhIQItXDdw==
X-Received: by 2002:a6b:2cc5:: with SMTP id s188mr20388931ios.77.1592086481669;
        Sat, 13 Jun 2020 15:14:41 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id e8sm5570193ill.25.2020.06.13.15.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 15:14:41 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Wolfram Sang <wsa@kernel.org>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Robert Richter <rrichter@marvell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: busses: Fix reference count leaks.
Date:   Sat, 13 Jun 2020 17:14:34 -0500
Message-Id: <20200613221436.8048-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus call pm_runtime_put_noidle()
if pm_runtime_get_sync() fails.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/i2c/busses/i2c-img-scb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 98a89301ed2a..e13ca862fa97 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1058,8 +1058,10 @@ static int img_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	}
 
 	ret = pm_runtime_get_sync(adap->dev.parent);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(adap->dev.parent);
 		return ret;
+	}
 
 	for (i = 0; i < num; i++) {
 		struct i2c_msg *msg = &msgs[i];
@@ -1159,8 +1161,10 @@ static int img_i2c_init(struct img_i2c *i2c)
 	int ret;
 
 	ret = pm_runtime_get_sync(i2c->adap.dev.parent);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(i2c->adap.dev.parent);
 		return ret;
+	}
 
 	rev = img_i2c_readl(i2c, SCB_CORE_REV_REG);
 	if ((rev & 0x00ffffff) < 0x00020200) {
-- 
2.17.1

