Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB3BC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F67B22314
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B/hRhLia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBDTMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:12:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46021 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgBDTML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:12:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so7644538pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 11:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xc1csrmVcPuEVt2PAifWxduqj+YIIKakyr3kx9F6p00=;
        b=B/hRhLiaHuieS5xJ77K+C4XCpjmDk++ViufmB3kvnhyhKRSTYc0165hivyIGXG2T2y
         C/aS8KWDZ3tOiI97W6OadHaSYBUC2EcReJPsg945mnKkgKA0colSwguHVwIDK8zWJ4lb
         cqM0Vxc6O2DAZrtrn1jH/9FG3pi7Kg45jwDlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xc1csrmVcPuEVt2PAifWxduqj+YIIKakyr3kx9F6p00=;
        b=q9SJgOIKXgxQyh/lU3oO46lOSQy3cB52dNEoYuGU5xb8qPKEn7iKaf7PcM77hr33DG
         o46QrXCfDNVIzChgIoiSanMFfEFpzCQHNH+7s8veldUoVPqvWzWG/IoXXg1mOS8qKc4B
         OHYWSz1rv55MCWlL/ckD+lPg2t5vrOCx4L5GwPxZU69YiM1YyGbfZ6BLaUowvKFITkkP
         u6RxBkEIRT9mtvXlfpNtc8WWIJtF1zgyeFivcFqBdy1lFjuJdj2pltZ9lqs73UGbYxKP
         PEPjfV3ypSYvHr84cj906l0bH9mZVIJsbCDV7jhqk+YjyGwJCXSxLfcCuqpnd1rhyruQ
         94KA==
X-Gm-Message-State: APjAAAVCUjhSRlADuuMXvJadZmVT0YxeVh6anfBJ3QMWh7oD1CHT+NmZ
        GWWMpfV17MciOTlx1LkNNscbIg==
X-Google-Smtp-Source: APXvYqznRQtEozvABrrskgOoSNlwz8X5BXkNLyiUljKcwE0uLg1b1RdAf31ZFJiLvrBZzxOcxa7yyQ==
X-Received: by 2002:a17:90a:804a:: with SMTP id e10mr724655pjw.41.1580843530757;
        Tue, 04 Feb 2020 11:12:10 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c19sm26303229pfc.144.2020.02.04.11.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 11:12:10 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-spi@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 3/3] spi: spi-geni-qcom: Drop of.h include
Date:   Tue,  4 Feb 2020 11:12:06 -0800
Message-Id: <20200204191206.97036-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200204191206.97036-1-swboyd@chromium.org>
References: <20200204191206.97036-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver doesn't call any DT functions like of_get_property(). Remove
the of.h include as it isn't used.

Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Dilip Kota <dkota@codeaurora.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index f0ca7f5ae714..c3972424af71 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -6,7 +6,6 @@
 #include <linux/io.h>
 #include <linux/log2.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/qcom-geni-se.h>
-- 
Sent by a computer, using git, on the internet

