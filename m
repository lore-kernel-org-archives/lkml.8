Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE10C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 19:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC81B206F6
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 19:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxuZejlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgFGTab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 15:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgFGTaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 15:30:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE456C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 12:30:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so5775072pld.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 12:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2YHHUyrDfMTslhHwnsFPD53TwnSHuoF/R4V+ZRJ0yw8=;
        b=uxuZejlKRA4CVE+E+jTvxIs3SiHIy7mAwhd91TYk560WxhhlGakrV6rfiPr/R3j37+
         +14E1dk3+8NmNbc2+BGQ8/ayrFe/pLDUBJFotkqGXJ9LTIbgtORwPRUZ7yHilAD3GabV
         F4UNYa+j413vtwH2OSmu3cvegZGU6F6y7gy+wWM+5swLZhJOy+WO+QxMMhXHExvwIvrx
         r8msBuTPkL0t1S1aWC9BVF00odrPTj5v59C/xxP6kWJRbiqjZdFCTClrHgP8d7Xk3qT5
         w6nHgEo3h7xq5foIVBsnxWR6Va1al4jOWeOpj3ZuxYy2saOU+terrDdckEDeVBqOdFHk
         U5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2YHHUyrDfMTslhHwnsFPD53TwnSHuoF/R4V+ZRJ0yw8=;
        b=NdlZOu8EHAyw1v883XT2VmD7sLFF0/i5W+i+1zkenGQV0CaKwfGuTTZ5dD9Fi4vZ6k
         nHLJCs6wpDSnydS5VPOlMF9pchNAtoO3Qg+Ir0mKkAg+YIy4RcSy8ivuIsQJh2RYho3U
         PIT34SrJMb1axj6NXjGXaAC3SarB1J6lOSMLFyduQfwLbg/G0x15Wa1iFEq3EHSdoRr0
         PuC1O76owGyabSQ1LONvHE37z4Ev23TDZmoMqZbtpyaINMDdAQS1cNsWxNoKmhZv2gBC
         Cyx3v7UcVMf+zwI32sIIjy9X4XsQjcWd0CVxXADL4Vk+FCvR8sUVc3s9dqF/0/4Z8X6K
         z/TA==
X-Gm-Message-State: AOAM533izhI7qMfFhvN7g7zJRmKN7ofFecv0b5TiSHSiCtc7DC2Cx+rN
        +B2a+pFLa0udeKvSrh6C2dmZwr89
X-Google-Smtp-Source: ABdhPJxICKMh6o53PbWBQbO2RlBmzm99R16l4kJiZG2zbVBcy5deBCAj/hUwC7QBjnzQmvRIk7+z6A==
X-Received: by 2002:a17:902:9885:: with SMTP id s5mr17343111plp.204.1591558229238;
        Sun, 07 Jun 2020 12:30:29 -0700 (PDT)
Received: from localhost.localdomain (S0106d80d17472dbd.wp.shawcable.net. [24.79.253.190])
        by smtp.gmail.com with ESMTPSA id m9sm5032758pfo.200.2020.06.07.12.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 12:30:28 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     sudeep.holla@arm.com, viresh.kumar@linaro.org, robh@kernel.org,
        frowand.list@gmail.com, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, arnd@arndb.de,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH] firmware: arm_scmi: fix timeout value for send_message
Date:   Sun,  7 Jun 2020 14:30:23 -0500
Message-Id: <20200607193023.52344-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

Currently scmi_do_xfer() submits a message to mailbox api and waits
for an apparently very short time. This works if there are not many
messages in the queue already. However, if many clients share a
channel and/or each client submits many messages in a row, the
timeout value becomes too short and returns error even if the mailbox
is working fine according to the load. The timeout occurs when the
message is still in the api/queue awaiting its turn to ride the bus.

 Fix this by increasing the timeout value enough (500ms?) so that it
fails only if there is an actual problem in the transmission (like a
lockup or crash).

  [If we want to capture a situation when the remote didn't
respond within expected latency, then the timeout should not
start here, but from tx_prepare callback ... just before the
message physically gets on the channel]

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/firmware/arm_scmi/driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index dbec767222e9..46ddafe7ffc0 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -303,7 +303,7 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	}
 
 	if (xfer->hdr.poll_completion) {
-		ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
+		ktime_t stop = ktime_add_ns(ktime_get(), 500 * 1000 * NSEC_PER_USEC);
 
 		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
 
@@ -313,7 +313,7 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 			ret = -ETIMEDOUT;
 	} else {
 		/* And we wait for the response. */
-		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
+		timeout = msecs_to_jiffies(500);
 		if (!wait_for_completion_timeout(&xfer->done, timeout)) {
 			dev_err(dev, "timed out in resp(caller: %pS)\n",
 				(void *)_RET_IP_);
-- 
2.25.1

