Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1604C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751EE20775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yzt02VDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgFZG6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgFZG5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:57:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84618C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so8367591wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V/fY+SKO1Jj5D5YQYaGnVvTrQu75adS3mRb5y+EqAwo=;
        b=yzt02VDu0CzSC/QEDj7E7YM9X1XLw0ISddmZdLk9sScfqkbGp0Xq+20XMr1gslxJS6
         KHFEQG7qy01LuqwWZJr/r+RaQLZDRUFEcVK6uXQzJALuIp1aqt5UN7hJi5Qe7D8QfwvG
         AWZ5I6QeKJWM0ax4C1xMPqrw/6cxvpQej9vui13gMOGceQIt3sjLY79AO9x4lfGSBxLD
         LmETWiL9qaPWmANArrjT1QP6tTgDn6+WtzVetfkCVf/otoyvfRf1A/EER61/b+dqIAbG
         oEen04QTx5EwVGOpsdzhKozLB8ueIJWYYwmXAW1IUiIAuxUVBNlaKjzhbQ20Np54ti8e
         LS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V/fY+SKO1Jj5D5YQYaGnVvTrQu75adS3mRb5y+EqAwo=;
        b=VFVq0qc7TacyTCU72712KZOAc3UvVC9NLANf5ycur+AWYnIIiiklsWzRGVe7TnGbnJ
         iJD5F++c+0JsAjWFd0LDZR2UkO6MtMprZu4eTXk9qgfvm7f82/Gpm6O97PgfsOZl4gU5
         uL+wrCmZAcc8jzfNf0cHdwAgx9CnzQawNEcfUpruS2JUeI22vmf7ip6Lo8zihUpTyQK1
         mfiZLCZmWbxZDyTBnwGbmOGJijs/CGL8K2PoWKSxf9vZjuYBKaphZRG1ASo3xpt8OOsT
         D9LgACVMKPQreYr1aiL+/svA7QrtCDvc+ySuI2/TR8HxRjvecPFxCu0rFHNYA53R32bi
         SqWg==
X-Gm-Message-State: AOAM531dJyQkf98sgSv2mWWYM/wXx6trxIxxZDE+yE72oM8ADuuPGlhm
        tKZgd4V84wjG3CmsL1BtwbBHIQ==
X-Google-Smtp-Source: ABdhPJwCkkYYaOhccmFsNz/Yhg7coOjKTR+t9o30rYzg3GOOoRKpB9DeJhL5Nc6h+vNDcVxJOLd7Lw==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr2245534wrw.16.1593154665319;
        Thu, 25 Jun 2020 23:57:45 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x18sm15355269wmi.35.2020.06.25.23.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:57:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 3/9] regulator: pwm-regulator: Demote kerneldoc header to standard comment
Date:   Fri, 26 Jun 2020 07:57:32 +0100
Message-Id: <20200626065738.93412-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626065738.93412-1-lee.jones@linaro.org>
References: <20200626065738.93412-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This particular comment doesn't have anything to do with documenting
functions or data structures.  Instead it is used as a section header.

Fixes W=1 warning:

 drivers/regulator/pwm-regulator.c:55: warning: Function parameter or member 'rdev' not described in 'pwm_regulator_init_state'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/pwm-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 638329bd0745e..3234b118b53ea 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -48,7 +48,7 @@ struct pwm_voltages {
 	unsigned int dutycycle;
 };
 
-/**
+/*
  * Voltage table call-backs
  */
 static void pwm_regulator_init_state(struct regulator_dev *rdev)
-- 
2.25.1

