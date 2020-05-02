Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B678C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 20:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E9920775
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 20:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="NACOQcAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgEBU3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 16:29:05 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:36742 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbgEBU3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 16:29:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49F11C5Y0Bz9vCGW
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 20:29:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hEJ2JKLOCcz9 for <linux-kernel@vger.kernel.org>;
        Sat,  2 May 2020 15:29:03 -0500 (CDT)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49F11C4Rsxz9vCGT
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 15:29:03 -0500 (CDT)
Received: by mail-qt1-f200.google.com with SMTP id z3so15585506qtb.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XhfKgI9d6Gl57N2Xx+fFhl6LTDCxp0mSoTy+rfsye04=;
        b=NACOQcAGJGH5sXKDxAh57PTNyXO4NzVhdP3BU6XhZ8epwS8RJ2Gqems+ZANNqkshZd
         uPmytVOkdjETi8P8i2eKnEHpqKFYxRjRz4DLDAUKX1yFEso52g+05AeYgtl3lQbo9jtP
         41rPj+JygDd+3H9lSBqf3YICiBsKsXCb6Un+deoHXK5b3fqpLFSec/bXI80jNkd390eQ
         F/THkSvUvEafMhaTHgCDfWWBlUXwvFKDSjrdUpNw2vrkz66/z9v4iT1KQy5PuQRZ28ij
         Oq1zZAT4pKxi6OBksgnXzISTvdEsOoyEuSBdpSQPSmkRQGsa/pW3SvHc4+jVGklQxCOg
         ddGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XhfKgI9d6Gl57N2Xx+fFhl6LTDCxp0mSoTy+rfsye04=;
        b=EXzzeYf6YMoue7RQcSsxnP0BfM863pvDI1ugZGRbd3dyGEEZOVUONkmMEd6evDIH88
         4kndZdNqWg75aVFPzENzQzZ3KEZG81rxZjXDOgyAal837y5fvu2lYDrKxNGVow0J51lg
         QGeb/jvZlcq+LgyAZPkjpY04QZy/vW8EMPgzf9FNWf5DLGrqrKcwrt1QXzqKwLdRVf4w
         MWyCepc2JO1SwkCtza6xkoApLx0xSvbheNvY1PdgLL74V7lX9XHP0qHF2/s6p+g4MU74
         faDG80pVXVe8QA5AaSSPeOhnT+zMUHQMyMK7iRe9BSulDxgFMid39pnKyLFANdhiQ/yN
         kojw==
X-Gm-Message-State: AGi0PuZ5vB02nvqAdxgcc0+q9BtTyMEYHuxK4eRcwvWB92xdXMVMQ55F
        /4z1XJ8TASX4SWJr4DrzqKJlayS8DhOzxQ+zaHxf18lrOQwWK63FL7RPxM3cZMAQFjfmAp2Vh3a
        joNAVgTmqbgKbA/j44jeN9gzwYZLr
X-Received: by 2002:a37:ac14:: with SMTP id e20mr8576895qkm.23.1588451342942;
        Sat, 02 May 2020 13:29:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypLnqqSKaOgG4dqiXXVM5Q4flAZk4SPm0seeBmN6KTYxyCVHWkAQKRlXcl69Z44LbuBMXv4Xkw==
X-Received: by 2002:a37:ac14:: with SMTP id e20mr8576878qkm.23.1588451342498;
        Sat, 02 May 2020 13:29:02 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id b10sm6023306qtj.30.2020.05.02.13.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 13:29:01 -0700 (PDT)
From:   wu000273@umn.edu
To:     a.zummo@towertech.it
Cc:     alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] rtc: mc13xxx: fix a double-unlock issue
Date:   Sat,  2 May 2020 15:28:52 -0500
Message-Id: <20200502202852.13731-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function mc13xxx_rtc_probe, the mc13xxx_unlock() is called
before rtc_register_device(). But in the error path of
rtc_register_device(), the mc13xxx_unlock() is called again,
which causes a double-unlock problem. To fix this problem, we
need to call mc13xxx_lock() again in this error path.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/rtc/rtc-mc13xxx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mc13xxx.c b/drivers/rtc/rtc-mc13xxx.c
index afce2c0b4bd6..d6802e6191cb 100644
--- a/drivers/rtc/rtc-mc13xxx.c
+++ b/drivers/rtc/rtc-mc13xxx.c
@@ -308,8 +308,10 @@ static int __init mc13xxx_rtc_probe(struct platform_device *pdev)
 	mc13xxx_unlock(mc13xxx);
 
 	ret = rtc_register_device(priv->rtc);
-	if (ret)
+	if (ret) {
+		mc13xxx_lock(mc13xxx);
 		goto err_irq_request;
+	}
 
 	return 0;
 
-- 
2.17.1

