Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8D9C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3022084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z7KaXVwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBDTcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:32:02 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37040 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgBDTb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:31:57 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so1833952pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 11:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZS1QaVzaL6lAdBtnF8TiXHFpeIBpZHSsvKjHWm+HbIg=;
        b=Z7KaXVwTDC2U9AnpnBw8pkuAdK2Vw3+CP+Ef5xTQKKmDI8AvHhl/vLU1bbq+YOIZNV
         Pcnb6D6+57sVHrMt8DDd+Z4vblrE5E0/t4P8AiDsOehQRoM9MQGtl40M8V4e5YwQiO1y
         /hWkftP8Jk2ht7YfQqUIcfS+vD0dS5AJSZp2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZS1QaVzaL6lAdBtnF8TiXHFpeIBpZHSsvKjHWm+HbIg=;
        b=AgKik28XXOwU2DjnFBURxV2xRIa6gDGfJJ7DjKvkpAeMTRp1wofoLW4d5Udlwc3ISF
         /ioEyo8KhWUlmiTpFKxMVY52H8d173avn/n9dYpNs3mTZ28iHvLLB/CIMaiTQuL4hGqv
         3MmstrXH9NwKkEEB6qJKYXU8HUeRCkHzI3ax7aMjJM3WrfbR2aYWz/vAFTlS+FRqXGBd
         o+3N0T29dHa2qXqEXYp3hMBRmOe+WuvYEQNdIgNODSFoe0YM5vz7Uc8J8tpbzJQBjmI/
         imUIXenBJfNFK27fhZoxEafpRi7XB7PV13tJcPwIPvOJ8OfM0kvdTNXygTSuxNucPGBH
         QvkQ==
X-Gm-Message-State: APjAAAW7BGQjzpp6+XkoSJ6PSR80GaDb2gxHecCyR84AqmUBii3TvxEU
        yrf0OBcA3L0UZLmf9BrgAw5nLw==
X-Google-Smtp-Source: APXvYqx2iAESMw7/Six55EXTjJijW5Oc8a+eFWhBfTpqIYQo4lKZL5esJqIgY96smpydAy6yWm2duA==
X-Received: by 2002:a17:902:bc88:: with SMTP id bb8mr26260899plb.274.1580844716920;
        Tue, 04 Feb 2020 11:31:56 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g18sm24956626pfi.80.2020.02.04.11.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 11:31:56 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 3/3] i2c: qcom-geni: Drop of_platform.h include
Date:   Tue,  4 Feb 2020 11:31:52 -0800
Message-Id: <20200204193152.124980-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200204193152.124980-1-swboyd@chromium.org>
References: <20200204193152.124980-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver doesn't call any DT platform functions like of_platform_*().
Remove the include as it isn't used.

Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Dilip Kota <dkota@codeaurora.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 192a8f622f3d..4378eb7b6633 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -10,7 +10,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/qcom-geni-se.h>
-- 
Sent by a computer, using git, on the internet

