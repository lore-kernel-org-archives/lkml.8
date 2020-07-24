Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F38C433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD78D2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YI+6Na2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgGXVdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgGXVdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:33:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABA4C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:33:35 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so6150950pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4A/xN+mXAd0EqJ9PitQzyrnaHXwvg7/Xc99KzMDWZ6w=;
        b=YI+6Na2cEfWiYpn8cueJuwa/rEh9Eh3xNHKi83BjmkgAVNk0CTuHUwQIzIcKDuIcZr
         l9QFMLcnYrtI+Mumkp9boy+k+7iZYRqGbxw1hnJl36JZ2D9d5q1UPjSu/qw5SnjL/4xg
         xLwzDzDjh3Xy3P1lk019ShKO/cGDie18gz0/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4A/xN+mXAd0EqJ9PitQzyrnaHXwvg7/Xc99KzMDWZ6w=;
        b=NeIfrwlyX98CAnLRQO82z2azkx6ooORGlTyrjFw2nhsuO0wtCUZ4skSRWj1rlNJ3VO
         GjYs24m9wrZaLzlXgydhSjemuXN3SCdnl2KopibwozMrS3zHOKuVNxNHR9EQxazn2oZs
         Ty/bg7OTr4byR1uE2lq3mzyT3lqkbzQ3yCt7AJIUmAN78p28fAkLWCuITCqdp0SAQBXh
         stvUbhxbPrZgGCWx1M6zJZKD78cyCfgDcH4NrmBaHIwNOwGdo3b/11cbazzt1kGdOSIf
         Qixxm4BTWFM83gIEEVrUKIirsltFnskVj/AGL8V+f/UwSDpGH3N7Uoia/FwSVAw1RiU0
         X6RA==
X-Gm-Message-State: AOAM533HG/TIHN/WobjsuoIdXyAvwwHdttC414crk5JnTvr/xt+gfDcT
        CfU2nsE70wRv3OCZG2cxQNJx8hdxwzc=
X-Google-Smtp-Source: ABdhPJwKephH8VtzFk07GkM8Dq9QzB0TSBf214Np+Lq3nSPVJM/VWnFzsOJl2E3Uv9tD+GrMv5xSCA==
X-Received: by 2002:a62:79cd:: with SMTP id u196mr10322543pfc.152.1595626414664;
        Fri, 24 Jul 2020 14:33:34 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z6sm7312919pfn.173.2020.07.24.14.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:33:34 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 3/5] iio: sx9310: whoami is unsigned
Date:   Fri, 24 Jul 2020 14:33:27 -0700
Message-Id: <20200724213329.899216-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200724213329.899216-1-swboyd@chromium.org>
References: <20200724213329.899216-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an unsigned value, actually it's a u8 but regmap doesn't handle
that easily. Let's make it unsigned throughout so that we don't need to
worry about signed vs. unsigned comparison behavior.

Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Daniel Campello <campello@chromium.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 84c3c9ae80dc..fca871ad82ba 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -144,7 +144,7 @@ struct sx9310_data {
 	struct completion completion;
 	unsigned int chan_read, chan_event;
 	int channel_users[SX9310_NUM_CHANNELS];
-	int whoami;
+	unsigned int whoami;
 };
 
 static const struct iio_event_spec sx9310_events[] = {
@@ -864,7 +864,8 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
 
 static int sx9310_set_indio_dev_name(struct device *dev,
 				     struct iio_dev *indio_dev,
-				     const struct i2c_device_id *id, int whoami)
+				     const struct i2c_device_id *id,
+				     unsigned int whoami)
 {
 	const struct acpi_device_id *acpi_id;
 
-- 
Sent by a computer, using git, on the internet

