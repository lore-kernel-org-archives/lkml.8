Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2260BC433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1FFB2078E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ed/5En/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgG1PNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730738AbgG1PNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:13:19 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D10C0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:13:19 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y18so8041421ilp.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Arxg0V8+xHLDJQOE3XC6XEI2D610eTDQSgAgiHWic2E=;
        b=ed/5En/huJmkV7H3sr4JUDjl4+6DT7yd+2en/sv+vhamRLo2GMIG/zccn5VTenFrLp
         VDrRuPQQ8+Bd7hE7AUGPlnxQZUKbA9Smb+Qj/5k56WU4GxeioqOPgqxYoN9CxcaxIr2b
         4HYQATKa8y0w1jXw8qa8Hh/1P2XA7VjDwEDx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Arxg0V8+xHLDJQOE3XC6XEI2D610eTDQSgAgiHWic2E=;
        b=rWKcLYDEPgGv+x1ZXsrgQE4plR9Irvj3HI6pgPsbTdtcCoXYHOvY38lAhneMfqlL4G
         iQDvu2uJaWdVYiSs8qWfWomw4Froveu2hnJ+1KzzZyi9KG37G0eJaaICK+HiEAi1Y5Ry
         koitpFG86bM3sr6L3130WStUADp3hJRPSrdOiFxuvKQiyryldy6Jvanj9zkDiotWu9u1
         yaNXakgIqnTXH8cxUT3aUqntsA03XYF2/7jWsnL0V9J3TkpxpS7ZZ1AvFyDf10WPVsF6
         V9Y87gJ/J28zmezmbXmqFvj6VpE7f3w1AeV9h7LEhha1Wm5S0I7DzYzhngE0FldMuZSY
         01gg==
X-Gm-Message-State: AOAM532gBx8LCYMyOdNAgfpMHHXq4ob2ohK0l4qHRKESzGUoamVSs6eN
        YwY9EoDD1NqszSnTz+aKy8+E9w==
X-Google-Smtp-Source: ABdhPJzItrrOk/abLny4EURhjo3V8tqNGWdD2HMPltz32026rUJgZvwpqAZHJ4OpQQ3cbVuaKiK+tg==
X-Received: by 2002:a92:ce42:: with SMTP id a2mr26094617ilr.37.1595949198545;
        Tue, 28 Jul 2020 08:13:18 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id q70sm6399781ili.49.2020.07.28.08.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:13:18 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH 06/15] iio: sx9310: Align memory
Date:   Tue, 28 Jul 2020 09:12:49 -0600
Message-Id: <20200728091057.6.I27a5605d9cb3ff643ef040c4ef932a30df9a8fac@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728151258.1222876-1-campello@chromium.org>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __aligned(8) to ensure that the timestamp is correctly aligned
when we call push_to_buffers

Signed-off-by: Daniel Campello <campello@chromium.org>
---

 drivers/iio/proximity/sx9310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index de52afd7c13333..fb5c16f2aa6b1a 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -131,8 +131,8 @@ struct sx9310_data {
 	 */
 	bool prox_stat[SX9310_NUM_CHANNELS];
 	bool trigger_enabled;
-	__be16 buffer[SX9310_NUM_CHANNELS +
-		      4]; /* 64-bit data + 64-bit timestamp */
+	/* 64-bit data + 64-bit timestamp buffer */
+	__be16 buffer[SX9310_NUM_CHANNELS + 4] __aligned(8);
 	/* Remember enabled channels and sample rate during suspend. */
 	unsigned int suspend_ctrl0;
 	struct completion completion;
@@ -339,7 +339,7 @@ static int sx9310_read_prox_data(struct sx9310_data *data,
 	if (ret < 0)
 		return ret;
 
-	return regmap_bulk_read(data->regmap, chan->address, val, 2);
+	return regmap_bulk_read(data->regmap, chan->address, val, sizeof(*val));
 }
 
 /*
-- 
2.28.0.rc0.142.g3c755180ce-goog

