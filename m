Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDABC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3009D208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgCIRWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:22:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34115 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgCIRWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:22:43 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jBM6z-0000ke-0a
        for linux-kernel@vger.kernel.org; Mon, 09 Mar 2020 17:22:41 +0000
Received: by mail-wr1-f71.google.com with SMTP id n7so5509964wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 10:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=RpSrK82GO+XpUM86Hc84ckqih+54BcF5pmkDsAsQd94=;
        b=tM7EK9CwULG7xZEdqBODzT6JU+ALJp7DCbPpQyQrj60BEJYSWeTCA2JEtSDq9JGgL0
         e2u7HR9IOZcwQAQFHBsqTpVBMfWAEjFV33OHD/Gbfv8pZeV9fojBUnridhR1XLFc9ILr
         2QCbdBPjBlz0qgZEOXA6EuAC4KQGGJyOylimrLt1Fj2nGslaXYFFg5jkxSV9D7ep5Mxf
         vqNovIdeqbH6Y7sGUuHYovZ8sUilfLe58NALdcvllY3/fqBKpy42Rxy8rRBGEg21a1Qo
         KUvNXBO9hHcBiGjI5Qf6D45GVWl9ar9pTaApbdPEpKw31r3pNljnIrZCaB8jTSJ8lTMG
         o8xQ==
X-Gm-Message-State: ANhLgQ1Dg+Qgt+zx3YFUofBWJdCmjmABDf2WaYm3a2EAwcWu+pzGYH63
        wHCp1q9JZvufNfZFsHFMcCH7H2BNmSZnGbgZiwgn0xPnSM3yS16qwzU9KG+rR59hoCYmiztsZA3
        ZbHc3CfYf0PFHwdhYj7rqngnMioNKwpuy1dBEe1Y1zg==
X-Received: by 2002:a05:6000:120e:: with SMTP id e14mr1259387wrx.182.1583774560365;
        Mon, 09 Mar 2020 10:22:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv8sQL3WWVTi+4BELgM2W/7njbFPyjSiHW1ToTXk7sW2lk01O+Ey4fXnfe0i9+DFCXBS6PtsA==
X-Received: by 2002:a05:6000:120e:: with SMTP id e14mr1259366wrx.182.1583774560108;
        Mon, 09 Mar 2020 10:22:40 -0700 (PDT)
Received: from localhost (host96-127-dynamic.32-79-r.retail.telecomitalia.it. [79.32.127.96])
        by smtp.gmail.com with ESMTPSA id y189sm286063wmb.26.2020.03.09.10.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 10:22:39 -0700 (PDT)
Date:   Mon, 9 Mar 2020 18:22:38 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Richard Cochran <richardcochran@gmail.com>,
        Vladis Dronov <vdronov@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ptp: free ptp clock properly
Message-ID: <20200309172238.GJ267906@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in ptp_clock_unregister() where pps_unregister_source()
can free up resources needed by posix_clock_unregister() to properly
destroy a related sysfs device.

Fix this by calling pps_unregister_source() in ptp_clock_release().

See also:
commit 75718584cb3c ("ptp: free ptp device pin descriptors properly").

BugLink: https://bugs.launchpad.net/bugs/1864754
Fixes: a33121e5487b ("ptp: fix the race between the release of ptp_clock and cdev")
Tested-by: Piotr Morgwai Kotarbiński <foss@morgwai.pl>
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---

v2: move pps_unregister_source() to ptp_clock_release(), instead of
    posix_clock_unregister(), that would just introduce a resource leak

 drivers/ptp/ptp_clock.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index ac1f2bf9e888..468286ef61ad 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -170,6 +170,9 @@ static void ptp_clock_release(struct device *dev)
 {
 	struct ptp_clock *ptp = container_of(dev, struct ptp_clock, dev);
 
+	/* Release the clock's resources. */
+	if (ptp->pps_source)
+		pps_unregister_source(ptp->pps_source);
 	ptp_cleanup_pin_groups(ptp);
 	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
@@ -298,11 +301,6 @@ int ptp_clock_unregister(struct ptp_clock *ptp)
 		kthread_cancel_delayed_work_sync(&ptp->aux_work);
 		kthread_destroy_worker(ptp->kworker);
 	}
-
-	/* Release the clock's resources. */
-	if (ptp->pps_source)
-		pps_unregister_source(ptp->pps_source);
-
 	posix_clock_unregister(&ptp->clock);
 
 	return 0;
-- 
2.25.0

