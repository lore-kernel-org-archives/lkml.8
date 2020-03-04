Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C03C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45FD21775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgCDRxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:53:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37704 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbgCDRxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:53:55 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1j9YDR-0005BK-Dm
        for linux-kernel@vger.kernel.org; Wed, 04 Mar 2020 17:53:53 +0000
Received: by mail-wr1-f69.google.com with SMTP id p5so1139499wrj.17
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tgXnocXG+jZrTeViaEPQZMOPzJF0dDDQTUKioSbPZLw=;
        b=IHCOuPvr5oQmjiFcEmt16j93HMkH2LXlXI7YpANmPZHnP9AzX/4JpBdh5sA5TJtd28
         AN5ouh3oDAGXBfuzeX/yGnk6sB7wlziXn1P4EnjfV4nnLW3GfE5dUELVaPYIyO2K2Nk+
         P51i+Kyx7gE3ezOJYdoaFJCQZq1jjKwATWyAqKSL+XGza+IzqQL63d3Y+vWndpa/tVAf
         rOjrPGME2cwuLOgkpH/UfiuWwd11Pz+WtKnu4/9Y+8GXu2Mdu5qk+cnMOur1gR5cJH3V
         wCk7OngyMcqZDYmKh55xFm7wsL+LiT4qQrvOVCZCCI/aGNUiMS25ZFU7ftud+wHA9/+v
         YM6w==
X-Gm-Message-State: ANhLgQ3UJCZo4rmnI2V9gQQda/nHD5E8k7ZdDSDmu2i32Zzx8eP45Va9
        JXE4zULxxvT5DZWXhcT0HgrEdfkvc3r092vmm5mtJ4G7c9n7bBfadZrMXPnKgd/Bljkj4z0I0gH
        SWM8KJtJ3jkSuDjwELxQRbNzdtZL4Q+phAFmACcsEPw==
X-Received: by 2002:a05:600c:4151:: with SMTP id h17mr4964392wmm.189.1583344433066;
        Wed, 04 Mar 2020 09:53:53 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuL6fP8UzU9Yr2dI0/WuSEUIxMfCycwldfogtODqrI3DPCrLXBqrb8HQ1spg4nDeYKW00haZQ==
X-Received: by 2002:a05:600c:4151:: with SMTP id h17mr4964377wmm.189.1583344432781;
        Wed, 04 Mar 2020 09:53:52 -0800 (PST)
Received: from localhost (host96-127-dynamic.32-79-r.retail.telecomitalia.it. [79.32.127.96])
        by smtp.gmail.com with ESMTPSA id b10sm5469093wmh.48.2020.03.04.09.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:53:52 -0800 (PST)
Date:   Wed, 4 Mar 2020 18:53:50 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Vladis Dronov <vdronov@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ptp: free ptp clock properly
Message-ID: <20200304175350.GB267906@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in ptp_clock_unregister() where ptp_clock_release() can
free up resources needed by posix_clock_unregister() to properly destroy
a related sysfs device.

Fix this by calling posix_clock_unregister() in ptp_clock_release().

See also:
commit 75718584cb3c ("ptp: free ptp device pin descriptors properly").

BugLink: https://bugs.launchpad.net/bugs/1864754
Fixes: a33121e5487b ("ptp: fix the race between the release of ptp_clock and cdev")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 drivers/ptp/ptp_clock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index ac1f2bf9e888..12951023d0c6 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -171,6 +171,7 @@ static void ptp_clock_release(struct device *dev)
 	struct ptp_clock *ptp = container_of(dev, struct ptp_clock, dev);
 
 	ptp_cleanup_pin_groups(ptp);
+	posix_clock_unregister(&ptp->clock);
 	mutex_destroy(&ptp->tsevq_mux);
 	mutex_destroy(&ptp->pincfg_mux);
 	ida_simple_remove(&ptp_clocks_map, ptp->index);
@@ -303,8 +304,6 @@ int ptp_clock_unregister(struct ptp_clock *ptp)
 	if (ptp->pps_source)
 		pps_unregister_source(ptp->pps_source);
 
-	posix_clock_unregister(&ptp->clock);
-
 	return 0;
 }
 EXPORT_SYMBOL(ptp_clock_unregister);
-- 
2.25.0

