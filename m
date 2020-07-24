Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D95C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3B1206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mLAtcyR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGXVdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGXVdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:33:36 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40F2C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:33:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f9so114745pju.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t+wfLK+jRzoEaeSZTF77nah9ZjAJpOiCxA+PzRL9qxM=;
        b=mLAtcyR784TRkCRrR4IRTfb9vao7peH9X39dm44ROVmmofcdArlmKq+mEqSE9Toqlu
         rFH5miGAzdjGBa6uyLOedKw0s2DtQUHv5JkAiJd4nRonuVF23gIs1TWlF8f/N2e9DJVb
         wX8lR7GF8D3mrPp09mzRussGWnCrLxEj2wZJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t+wfLK+jRzoEaeSZTF77nah9ZjAJpOiCxA+PzRL9qxM=;
        b=D3L3LwcY9GV1jh8N5Ml5NZ350sy8Rpm7JqHw+Tqa35JnbRxW9yVQuIHkafQiqU/ZwR
         upuuntqyjjqriFudy++KdUO6wxl9r4q3trkyMWR53nxRItABvJ14/Rvj7hGMkw/S8RS1
         xrhoDzKLEwUewz0xKDtHHtQ+aCln2wKz0BVGmWxQLs1wJYs00dx8UX2h9JASQDXWyO+P
         63l8IM2LhYbQkoSwgto+Vtiic9RMHbbG9fD1+V/XjLS9aHi6vuVqgdeIP/s5WMXSaJV8
         CVL/wMUqYA+DT7izYfvXAILCpQPjXszijM/H3xkB+3iuQwiKTS0RfMWjmKZEmoIkgLFa
         AMVg==
X-Gm-Message-State: AOAM532OcyUzAlW4mjU1Ry4ZTkEIIO9c35AuOyOmvyZfg0zj2rjU4hfy
        5P+o2qQ8TMZYF5G1dsvfPXlmgg==
X-Google-Smtp-Source: ABdhPJy2o1jAadrqyaeCklg07hrfg6+Ljmtjv6KrP4itXpLPvSILQJifpHbNx3f1AdtA4pBtOSdvew==
X-Received: by 2002:a17:90b:289:: with SMTP id az9mr7771380pjb.122.1595626415525;
        Fri, 24 Jul 2020 14:33:35 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z6sm7312919pfn.173.2020.07.24.14.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:33:35 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 4/5] iio: sx9310: Drop channel_users[]
Date:   Fri, 24 Jul 2020 14:33:28 -0700
Message-Id: <20200724213329.899216-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200724213329.899216-1-swboyd@chromium.org>
References: <20200724213329.899216-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This struct member isn't used. Drop it.

Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Daniel Campello <campello@chromium.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index fca871ad82ba..1e1f6bba50f6 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -142,8 +142,8 @@ struct sx9310_data {
 	/* Remember enabled channels and sample rate during suspend. */
 	unsigned int suspend_ctrl0;
 	struct completion completion;
-	unsigned int chan_read, chan_event;
-	int channel_users[SX9310_NUM_CHANNELS];
+	unsigned int chan_read;
+	unsigned int chan_event;
 	unsigned int whoami;
 };
 
-- 
Sent by a computer, using git, on the internet

