Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E7BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B7B205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AurlFm8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgICIa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgICIaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:30:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B742C061244;
        Thu,  3 Sep 2020 01:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3MgBkKtO18c1EGgyVlxbiG0QwjmCjivVqUDJFotKWhw=; b=AurlFm8EevE2HbHY/aFA76ArzX
        ZBwOIqNTzMC5qmJ7aoNTXabOe03S3PpLbHwsFeYcJEyfsRR4CuUPOAIeYECk2gJFdQWoVBD3erlJd
        5fO2fh/liMAOffe79oXQ8i0+tRjMgEsygbC7Nb88FFmnspv7TUSVC/t0kCinBA/adAzi5pSfSnZA3
        N7tK6PuMVpWBg0+FkW3uTJ8oRS/YCXuKgau2xHeOWeIg/FnZlxOXj8xPXTjce/Pi8DxUU+wEoO6n8
        NL/BlxTZv5tjmH8R7WY7f1xERYuNTDMdmSUPqrSjDlg/FeyHg23ymRGqa04hgK+b8qdavg6BjG3Zs
        t0p4y8Wg==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDkdP-0000yv-Df; Thu, 03 Sep 2020 08:30:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     sth@linux.ibm.com, hoeppner@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dasd: remove the unused dasd_enable_device export
Date:   Thu,  3 Sep 2020 10:30:18 +0200
Message-Id: <20200903083018.507894-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dasd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index eb17fea8075c6f..6ab992b3eed004 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -683,7 +683,6 @@ void dasd_enable_device(struct dasd_device *device)
 	if (device->discipline->kick_validate)
 		device->discipline->kick_validate(device);
 }
-EXPORT_SYMBOL(dasd_enable_device);
 
 /*
  * SECTION: device operation (interrupt handler, start i/o, term i/o ...)
-- 
2.28.0

