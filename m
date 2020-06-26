Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9BFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C91C620836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMN+5SES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgFZG5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbgFZG5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:57:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4397C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so8361177wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y9hN7NO0rdQRJARX8qa7eYKYz3O3kVESkS3PoJ7SKiY=;
        b=oMN+5SESRViJGi4oMdoYffiAIfTV0HTw712Nu4lIwJpvz3ph6VHskhTuPqAub7zRL1
         BAHisNhPGZdpQe+zfCmznmkwfxUPe7KErp4/mTy+EGkED1oAvKKb4P7Yilw1CkWtsmr4
         pyanrIHcJ/dwK+IBBHBKGdCgFPOr46YkenbRq+nAdBC74VVOJINtEEVCGRI9yNxx4WDy
         Ubr1PSc7g8MlWhEYIkfNBKICDjb7tVLvgQDVz57Vs6VvhNJ1nojyIXvKv2ZbAa2wu1Bu
         L+p17Rtqd4X1tEwjktgKojLmmbeKxn21eBdfeZensHH0xSrtfQdEQ4C4aKJ8NavBdcji
         hAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y9hN7NO0rdQRJARX8qa7eYKYz3O3kVESkS3PoJ7SKiY=;
        b=ncDW7MdJ3HjMNwtzba6NmVveUYr1KXMk1d6foAtBrmkBezXsIgGpzAlDei5oOh9H+n
         1G0k0eEgEo8aS/OmmbxehOOrAzzmsul6exxXVDLu75OLMh4xMjRhVPsFotw3NcnrtdJE
         me+ERcNvnByJ1vfnO3cYKKpkYDfMGwBsnH8ruf2brtyp1cx4+who3hoxBDdMkAznHpue
         j+Ic9dTBW1ynzM5TvYQ8xav+rO58WBYCnftx78PzB5tMAi5jGtIXwdcgD+FHdIQ4tWeD
         fJzul127BBXrwMP8wXXHExGkRdnmM05ow33breOsB+/KjaRHrTYYD5NMhXLBXYhgqeWR
         G6XA==
X-Gm-Message-State: AOAM533lATZbnfx3Yr0H57+qe/jZtZTorzhYKeyTUy3i2vBIWnQfLE0z
        w3NFpoqBvOl7mzrjPpz02+Oxcg==
X-Google-Smtp-Source: ABdhPJzCrrAiKXmS/P3/z8bW+Zozzihsle1ZeNtAdmBePwrKgRx2OeGMoZCsXgJ2BWVeEnC+h/bs6A==
X-Received: by 2002:adf:828b:: with SMTP id 11mr2309054wrc.58.1593154666455;
        Thu, 25 Jun 2020 23:57:46 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x18sm15355269wmi.35.2020.06.25.23.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:57:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Pascal Paillet <p.paillet@st.com>
Subject: [PATCH 4/9] regulator: stpmic1_regulator: Properly document 'struct stpmic1_regulator_cfg'
Date:   Fri, 26 Jun 2020 07:57:33 +0100
Message-Id: <20200626065738.93412-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626065738.93412-1-lee.jones@linaro.org>
References: <20200626065738.93412-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kerneldoc format, data structures have to start with 'struct'
else the kerneldoc tooling/parsers/validators get confused.

Fixes the following W=1 kernel build warning:

 drivers/regulator/stpmic1_regulator.c:25: warning: cannot understand function prototype: 'struct stpmic1_regulator_cfg '

Cc: Pascal Paillet <p.paillet@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/stpmic1_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index adc9973d1b2f7..73e0ab2baeaa6 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -15,7 +15,7 @@
 #include <dt-bindings/mfd/st,stpmic1.h>
 
 /**
- * stpmic1 regulator description: this structure is used as driver data
+ * struct stpmic1 regulator description: this structure is used as driver data
  * @desc: regulator framework description
  * @mask_reset_reg: mask reset register address
  * @mask_reset_mask: mask rank and mask reset register mask
-- 
2.25.1

