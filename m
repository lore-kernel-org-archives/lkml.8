Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178A8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D227F20775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a68o20Gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgFZG5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgFZG5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:57:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA63C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so8367524wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/E1PdVn/9jzzc34D3D+WNExjRWlGVi1N3dWKjpxsWKE=;
        b=a68o20Gmmh0AyVgl/PpKk+tsY9DfLFWxKbSXt+qf+QeHv9ryx9N2GLgLxgdpcME+oz
         n5CBJu8CJXJt6rWJBLxQ5rt2eGIOlPfgo+mLNsgXG9GfZLRbjdBgOz6oGuH++cBqasbF
         je/seh5XPcrMsHgXv1ANElfefrnnY6nPilIuMB4Tjk0++4C0Dwf2iBnNTr9pvI2DtdNv
         FYKKhpUxGrDfAOjuIkTfWcgJRArbRgC5fugLbAEwoDNWN1bCvH6cdkWnopB4uEyTKcR0
         /osZUZ2sKKtLEVnIU4he/yg07D0715OWbL2KosASZvI/k/lGiD5JTUi7q6XmeV4ft1kH
         HQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/E1PdVn/9jzzc34D3D+WNExjRWlGVi1N3dWKjpxsWKE=;
        b=YY8eXqeZTIkWXOJW1jYzD/WMkwpfCJL9ABLHiWLXd2c8CZcyzcHlPESQYiZ1mV1NTt
         35kUQe2iSybfxUPFgxOGpBjVXFZ6rj3QN9F/GarwEMH6XasI2oUHDXJristelbkboOup
         XJaoSv0ce8XZ1EgFZByy4Wf7c4ClfWHhky2E6ySZFZpW8XwbPDO8/SSjXdCLKVL3yzEi
         81OZx6gS7y5rO50hGBLewym0p6z8IQ5toJUol9pI7WtHhAT7dDQXMZBEE1VyhnjRGsTz
         GULQvBa37xYBFIZaKtQiG2ZXOIxueYBGXRXwBMLOVm8we1ZLri6MMtyw8/T8koaPe/bY
         Js6A==
X-Gm-Message-State: AOAM532B3y6k99nFcr3BHbP7toze/p6cbuj4A/MLhuiGIgzAvWWv8lmw
        WCNZkrVfVNs2StqiPcXUxifBiA==
X-Google-Smtp-Source: ABdhPJzlrUVwS/s+z+kPaLN7mMZ6TH290vDO8qERoSmz8o7Sm04wV5mFHDvFboop/xRMB+UYBri1Yw==
X-Received: by 2002:adf:f504:: with SMTP id q4mr2075095wro.163.1593154663208;
        Thu, 25 Jun 2020 23:57:43 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x18sm15355269wmi.35.2020.06.25.23.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:57:42 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/9] regulator: max8998: Staticify internal function max8998_get_current_limit()
Date:   Fri, 26 Jun 2020 07:57:30 +0100
Message-Id: <20200626065738.93412-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626065738.93412-1-lee.jones@linaro.org>
References: <20200626065738.93412-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max8998_get_current_limit() is only used via the .get_current_limit,
so it doesn't need to be publicly supported, or to have its own
external prototype.  Instead, we'll make it static.

Fixes the following W=1 warning:

 drivers/regulator/max8998.c:418:5: warning: no previous prototype for ‘max8998_get_current_limit’ [-Wmissing-prototypes]
 418 | int max8998_get_current_limit(struct regulator_dev *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/max8998.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 340413bba0c5f..ac69bdd398cb3 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -415,7 +415,7 @@ static int max8998_set_current_limit(struct regulator_dev *rdev,
 				  sel, rdev->desc->csel_mask);
 }
 
-int max8998_get_current_limit(struct regulator_dev *rdev)
+static int max8998_get_current_limit(struct regulator_dev *rdev)
 {
 	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
 	struct i2c_client *i2c = max8998->iodev->i2c;
-- 
2.25.1

