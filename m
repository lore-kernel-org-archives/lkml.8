Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D4DC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AC5206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580378880;
	bh=v88UUG9QzOisU/84NO8qyKuzzpmCTlEb8OBRld6h6ec=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wSql4IyFyHJQrtCZfRTmqxCe7ElBHWC9L0k+Jtzxq2ht5lGG9KY3jZznbClUH5bS2
	 xvfiViHrut01N/6f5BZXajxYUA+P3Mg06BGIADRG2Q9ClGOnC8krkPP9i9MYcMYS24
	 PR/HGL3Y9eepUEsB4Z1oVF1vy7s7GI09uD2YK9gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgA3KIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:08:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37380 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:07:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id v17so2673887ljg.4;
        Thu, 30 Jan 2020 02:07:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TRXV/R/FJjlldRcej4nDJXC0nf1bwm0Dx6qU6xuluz8=;
        b=jEqeZZtgvc5Go758UJAUgzYXRDftsyDh09xIxKNizpgYy0kJW24y0bnRPB3Wba+xMS
         YQdRzYYpOmTDWkqhPb7uBIf4529L0NXIUXKWE7W/NUX8oHEZJrokDfJQzPe1D4TUSXZd
         dtZzEdEl9TDeDypLtqYYk8o/6z6YD8OmvqB2lUH4keyY553CANetcJhcdMqDWTmWlxEk
         3fUZFP+u1UyKl2O1PAVbRFCvByAbtBwjkBuScwNIDr+C9VXTqW9PtG6/+GrHr+qQmZII
         Hn+2aVEeuXNXTSWPsHmzn5YC8uQ4rhfgMWF0+1nLH16INiM9kqZdi9vfgwsfGvr/3ePr
         oJIA==
X-Gm-Message-State: APjAAAXkyMARLRchSC8kN6Kf7f+i/5NB/Ax8DCxbu0ZGySp3jeuyd75a
        dPnM6kQLmC+g0sx0YckE/qrNUJd2
X-Google-Smtp-Source: APXvYqyZX0txkc7CTZ6KZgmtq3Tuka+XSMLsxaFc3ZaPtExrTA0sR8R4zzN9hyC74fU/7JFNUzsE9g==
X-Received: by 2002:a2e:7818:: with SMTP id t24mr2244584ljc.195.1580378877292;
        Thu, 30 Jan 2020 02:07:57 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id l8sm2561503ljh.65.2020.01.30.02.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 02:07:56 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1ix6jw-0000C3-UZ; Thu, 30 Jan 2020 11:08:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] USB: serial: relax unthrottle memory barrier
Date:   Thu, 30 Jan 2020 11:06:58 +0100
Message-Id: <20200130100658.683-1-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a8d78d9f3856 ("USB: serial: clean up throttle handling")
converted the throttle handling to use atomic bitops. This means that we
can relax the smp_mb() in unthrottle() to smp_mb__after_atomic(), which
for example is a no-op on architectures like x86 that provide fully
ordered atomics.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index 1be8bea372a2..546a1c2ce2f2 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -417,7 +417,7 @@ void usb_serial_generic_read_bulk_callback(struct urb *urb)
 	/*
 	 * Make sure URB is marked as free before checking the throttled flag
 	 * to avoid racing with unthrottle() on another CPU. Matches the
-	 * smp_mb() in unthrottle().
+	 * smp_mb__after_atomic() in unthrottle().
 	 */
 	smp_mb__after_atomic();
 
@@ -489,7 +489,7 @@ void usb_serial_generic_unthrottle(struct tty_struct *tty)
 	 * Matches the smp_mb__after_atomic() in
 	 * usb_serial_generic_read_bulk_callback().
 	 */
-	smp_mb();
+	smp_mb__after_atomic();
 
 	usb_serial_generic_submit_read_urbs(port, GFP_KERNEL);
 }
-- 
2.24.1

