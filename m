Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EECC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 21:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D668D217A0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 21:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nashi-us.20150623.gappssmtp.com header.i=@nashi-us.20150623.gappssmtp.com header.b="191p3RrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgFSVT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 17:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgFSVTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 17:19:25 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C335C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 14:19:25 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c194so9687020oig.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 14:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nashi-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6PMYmnS0au6f2ZudqVNcNpzyuIOP0hMWlCKxgUPu5e8=;
        b=191p3RrEW2w7zTEZMS+oLA/R6O2xxFmaul9V2RO8oQxv5+heizkovgEcnIG+W2OaMQ
         GW+D4AyhAWDTZ9Rjnhu5NhjJIxXvUWaeIiteSbJgRUJbX4ARrSv9/stI2MVfgtg2Bhsg
         j9g95yucKothMQc3+u+dZ1aWEF/JFcgFe4pv9sfWnHkdR8axxdfKgpBFreH9FljW46Iu
         6xsnY4ut8q+H+KzVb3wIPfxUCh1qdX0tmr+pDEoxUGaN3Vw9nJ0eGKv6F+XTFBuJL9/m
         ZaLkxbIljt9m6eRegDynnraA8vareqDVllDOTDsG2iDXgi3ksSUGmC9K5Vce+PRJw8k+
         bC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6PMYmnS0au6f2ZudqVNcNpzyuIOP0hMWlCKxgUPu5e8=;
        b=qXa7JbC1P0dz8mNoHhWFPLoYNpaFpjZfuX9ge2X3DbHBDHQ6Drs2l0hesGZMGdpNVq
         FKn9iZPey1ofM3REDz2agjtiY1gXQ/D0iFsu5PcYdXND0s6SnoP1KjgUltSV1fuQI4bx
         G13DqwkGPw1YrpMIC0gDur5UbnSGJNAzpa2A0O4IaTpySJotDEQVRQ2jC1wzTrymoO/R
         C+d5T54n2KczNq1B4GhsUK4lXSPSXtHPmHb+YtPoDN4xHoVGImD+QhgybwFLLhKgfukb
         T8weVDHpclFUxuJDqNPexFpGeVFW1vMRFB0/mGvARsFYKMV8H5pWtVen8js2wJDINJrB
         HCkw==
X-Gm-Message-State: AOAM530l6BIME2TvaEUCm0sofaoL2fK3P7fCxucpo90i2o+WKVMBhXhn
        UTfb0s7leoqEsWJsXU9hWa4KnQ==
X-Google-Smtp-Source: ABdhPJwDQyB7pBLX/4L8hQFseKnJUKu6B3UdUT/tZuF+RMUyShRWBlqC/9UzwzPrHQgBa1tryqIAUg==
X-Received: by 2002:a05:6808:48d:: with SMTP id z13mr4645967oid.22.1592601564556;
        Fri, 19 Jun 2020 14:19:24 -0700 (PDT)
Received: from localhost ([104.189.146.210])
        by smtp.gmail.com with ESMTPSA id j71sm1524813otj.6.2020.06.19.14.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 14:19:23 -0700 (PDT)
From:   Sudhip Nashi <sudhip@nashi.us>
To:     axboe@kernel.dk
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Petr Mladek <pmladek@suse.com>, Sudhip Nashi <sudhip@nashi.us>,
        Adam Williamson <awilliam@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gdrom: Block comments use a trailing */ on a separate line
Date:   Fri, 19 Jun 2020 16:18:21 -0500
Message-Id: <20200619211819.50910-1-sudhip@nashi.us>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix code style to conform with linux coding standards

Signed-off-by: Sudhip Nashi <sudhip@nashi.us>
---
 drivers/cdrom/gdrom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 09b0cd292720..9707f04b54a3 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -692,13 +692,15 @@ static int gdrom_init_dma_mode(void)
 	__raw_writeb(0xEF, GDROM_STATUSCOMMAND_REG);
 	if (!gdrom_wait_busy_sleeps())
 		return -EBUSY;
-	/* Memory protection setting for GDROM DMA
+       /*
+	* Memory protection setting for GDROM DMA
 	* Bits 31 - 16 security: 0x8843
 	* Bits 15 and 7 reserved (0)
 	* Bits 14 - 8 start of transfer range in 1 MB blocks OR'ed with 0x80
 	* Bits 6 - 0 end of transfer range in 1 MB blocks OR'ed with 0x80
 	* (0x40 | 0x80) = start range at 0x0C000000
-	* (0x7F | 0x80) = end range at 0x0FFFFFFF */
+	* (0x7F | 0x80) = end range at 0x0FFFFFFF
+	*/
 	__raw_writel(0x8843407F, GDROM_DMA_ACCESS_CTRL_REG);
 	__raw_writel(9, GDROM_DMA_WAIT_REG); /* DMA word setting */
 	return 0;
-- 
2.27.0

