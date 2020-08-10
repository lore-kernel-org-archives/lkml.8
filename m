Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A726C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02AAC2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv4OmYeR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgHJSgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgHJSga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:36:30 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690F1C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 11:36:30 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l204so9851666oib.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=C7EkLyQE7IrT7P5j05a64SHNONieTyjSv8sYRL7WbRw=;
        b=iv4OmYeRBLuu6sYIlmALa4HC3h+9+IanjNE4f1oBWJ55Au5COjHk/wpIfHhG5GcFIu
         160pli3LPMkpVGWssVc3VjuxwafCqGRz0SDJ3slGthoZ9ydAxqjDRwsL0jKRPrxyvLCF
         iuxFs0m0yGX8WJCpq4R08gv48Mjn6jsbjGxRZDU4ugytAQeA+GMIlkjlNz7j4GSlcHHJ
         rxkFhzVgNnCricnOfRrc8YYW47rvtGdDK7/3qMQU6cjEfQyIDJYbgmHkWc0T6Xmd4DLi
         SDZHfGIIDddJKrJz7SyvfZS3q8SOu0FLZdeClMRNQ1yYse+6CIaR9lHuv9QgVhWzdR26
         0Tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=C7EkLyQE7IrT7P5j05a64SHNONieTyjSv8sYRL7WbRw=;
        b=beyus9uCyej4hna/+q4c4ItCdmkJCScyKkB4NV4kj6VsHaaPU978yBHa8bfVNTcObp
         MphagAiQKaqC7WghpXcymjA0Dv+5078SsWNvARjbdtCCTF9BzU0A5U8b29Fc1ocbSsGt
         vpnqXw7b305vQwwl8I6K4cH8MecDCUjKKImmFfJlpsi5sx5F0evd8gFhrEK4tn/dOST+
         1RAObC46PxRCEuFDxMP3d1nEZ61+1cOIqvnKoW3hYpMBqQ+0FELFBqYCMeMgvLeiXi8T
         CT6nPcYczqyPvh8YqFyHxAqtdh9QEFAIN0PuzfKCHVZX4MN2KRr/V0BNC6eI0ATDD2Zm
         07oQ==
X-Gm-Message-State: AOAM532H1ROML8xiuSRWIbDjZRoo0H475oRGI6gir2geDQLYCW7HizHq
        kMF+jgjS9YqhHyTfIgUpxa0tmcO58j0=
X-Google-Smtp-Source: ABdhPJyngLr36rh0bspCWgiPo/s5CZWudkeT5rQr9dhEaD6a6oKOCeJluThEcXmUpEJQ/qCpg1vddg==
X-Received: by 2002:aca:fc52:: with SMTP id a79mr431413oii.109.1597084589910;
        Mon, 10 Aug 2020 11:36:29 -0700 (PDT)
Received: from raspberrypi ([2600:1700:90:4c80::23])
        by smtp.gmail.com with ESMTPSA id e194sm3789239oib.41.2020.08.10.11.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 11:36:29 -0700 (PDT)
Date:   Mon, 10 Aug 2020 13:36:27 -0500
From:   Grant Peltier <grantpeltier93@gmail.com>
To:     linux@roeck-us.net
Cc:     grant.peltier.jg@renesas.com, linux-kernel@vger.kernel.org,
        adam.vaughn.xh@renesas.com
Subject: [PATCH] hwmon: (pmbus/isl68137) remove READ_TEMPERATURE_1 telemetry
 for RAA228228
Message-ID: <20200810183627.GA5457@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the RAA228228 datasheet, READ_TEMPERATURE_1 is not a supported PMBus
command.

Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>
---
 drivers/hwmon/pmbus/isl68137.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
index 0c622711ef7e..58aa95a3c010 100644
--- a/drivers/hwmon/pmbus/isl68137.c
+++ b/drivers/hwmon/pmbus/isl68137.c
@@ -67,6 +67,7 @@ enum variants {
 	raa_dmpvr1_2rail,
 	raa_dmpvr2_1rail,
 	raa_dmpvr2_2rail,
+	raa_dmpvr2_2rail_nontc,
 	raa_dmpvr2_3rail,
 	raa_dmpvr2_hv,
 };
@@ -241,6 +242,10 @@ static int isl68137_probe(struct i2c_client *client,
 		info->pages = 1;
 		info->read_word_data = raa_dmpvr2_read_word_data;
 		break;
+	case raa_dmpvr2_2rail_nontc:
+		info->func[0] &= ~PMBUS_HAVE_TEMP;
+		info->func[1] &= ~PMBUS_HAVE_TEMP;
+		fallthrough;
 	case raa_dmpvr2_2rail:
 		info->pages = 2;
 		info->read_word_data = raa_dmpvr2_read_word_data;
@@ -304,7 +309,7 @@ static const struct i2c_device_id raa_dmpvr_id[] = {
 	{"raa228000", raa_dmpvr2_hv},
 	{"raa228004", raa_dmpvr2_hv},
 	{"raa228006", raa_dmpvr2_hv},
-	{"raa228228", raa_dmpvr2_2rail},
+	{"raa228228", raa_dmpvr2_2rail_nontc},
 	{"raa229001", raa_dmpvr2_2rail},
 	{"raa229004", raa_dmpvr2_2rail},
 	{}
-- 
2.20.1

