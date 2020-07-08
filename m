Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6002DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFB520786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RT6HwlFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgGHMsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgGHMsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:48:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE2AC08E6DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:48:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so2945181wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o1XJQv3xdST2ri9dQSPRqTi+utLoroqVOFsqThWptWg=;
        b=RT6HwlFYr4ATtzyplTz3ecHnKF+erqwnZUNLZQZdEu/dVprNwcMkCbg9Fq/3s9wQb/
         7Emf8QpvufktmyvgGZM2hu199L1XHd4aCfVjNbL1oRoCpeLmcKSyc0hd6CT9M1b4SZlV
         fi3iKyJkHg8CdTOdOVa33mn+Bnjd+nTFnwzuzWXrghnVfVc2LWYrU4NMYyYqgHO83SVZ
         ukyuqLpPps/nOGm/67PYId/8LxD5ilCOGV+gkYQpx7zHS8IHcyWp1Vn6ImWAt4t0X8CG
         9C3WqjgJ10sp5OllYq0leIuRXlowVtZX+eRvdxHgxsRs6mSlhewZ9NwUNGyTx5ndUFID
         QMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o1XJQv3xdST2ri9dQSPRqTi+utLoroqVOFsqThWptWg=;
        b=suyDU8p2E+JhQ+G0H/7D6qRF010F7TfzQZzrXGqXjAt4BsHzqU92q/3hIf4ITzSXmT
         Cr1xFYumVOYzhJ+U+fSTNB543cY6XE3HbHuJ7N1MG28MpBr1iL6xyM+R6auCdQo6OkEo
         kPb6V2xw2B4HbjyAqq5G+0wS5XLrBr+CXPndVNHlDXEdr0j+Z8eibd0f7buSa7rlboH0
         SuKkfCnxpWw7JmWOrRhfHg87CApLMtVn92arCwFlVMbfFAIo7N7BVI2YyctWF4KNFNOs
         eXnr26hiKRh7x+OFOdNnnjoVQw692u6jMARnU10SXbVJm06+k7cOZ/Um/FfHIP6RclLE
         rCCA==
X-Gm-Message-State: AOAM532t6Dpw5ger0SPCOiUGtMouFMBpPtsJ+1CWDxTpduK9LOw7p+Fm
        fa6XfBDs35azb9aLizg/Z3hJgw==
X-Google-Smtp-Source: ABdhPJxP6rjgvePi9wgeO94PbV2bISKPtgtf7NCWwcg3MI9Ht84VL5lFZ2MdKSN5nKXVahS/Y205nA==
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr9094480wmh.176.1594212516411;
        Wed, 08 Jul 2020 05:48:36 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id x1sm5745408wrp.10.2020.07.08.05.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:48:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/3] regulator: devres: Fix issues with kerneldoc headers
Date:   Wed,  8 Jul 2020 13:48:30 +0100
Message-Id: <20200708124832.3441649-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708124832.3441649-1-lee.jones@linaro.org>
References: <20200708124832.3441649-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide descriptions for some missing function args and
rename others to match the names used.

Fixes the following W=1 warning(s):

 drivers/regulator/devres.c:187: warning: Function parameter or member 'dev' not described in 'devm_regulator_register'
 drivers/regulator/devres.c:226: warning: Function parameter or member 'dev' not described in 'devm_regulator_unregister'
 drivers/regulator/devres.c:226: warning: Function parameter or member 'rdev' not described in 'devm_regulator_unregister'
 drivers/regulator/devres.c:226: warning: Excess function parameter 'regulator' description in 'devm_regulator_unregister'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/devres.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 3ea1c170f8402..3f73ce8590007 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -173,6 +173,7 @@ static void devm_rdev_release(struct device *dev, void *res)
 
 /**
  * devm_regulator_register - Resource managed regulator_register()
+ * @dev:  device to supply
  * @regulator_desc: regulator to register
  * @config: runtime configuration for regulator
  *
@@ -216,7 +217,8 @@ static int devm_rdev_match(struct device *dev, void *res, void *data)
 
 /**
  * devm_regulator_unregister - Resource managed regulator_unregister()
- * @regulator: regulator to free
+ * @dev:  device to supply
+ * @rdev: regulator to free
  *
  * Unregister a regulator registered with devm_regulator_register().
  * Normally this function will not need to be called and the resource
-- 
2.25.1

