Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9A5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 872C1208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHoCnRxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgFQG5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgFQG5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 02:57:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402DFC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 23:57:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ne5so527812pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 23:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6MPJxEon2gYUIC1eBRZV/RlBMiONJCU2XKZGULfkvGk=;
        b=rHoCnRxvnrmgaj4fRk0J1CrA8J4Mo5Qe2GvZDECUAIAb/dJ5HFpgTiXEDdaz10gbnh
         qQ5Z/gLuhIAntuE+LHvNr+x471YNOePTowZIu0TeSRchYXULqbz2sA5b1b1ZvTkx3LxA
         MLDVhWknz8CCuv3dGmXA3sDQxvSexvAoUOzI25yvjkwCjuAqrXQZS6sYEkpWMYdaZEhF
         FWVYgsh1DrdB4BFiGfFx30RBCtcSVvjX+WI97PvXpNS9hwvqluqucVvaYzOw8B4vmNVL
         OJdx3zFGeGqO/UcKH5YyzcG5Gxg39PsPPBFS79H+F9ARxraVkKLzakd2Xay2QDm4EvDe
         qK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6MPJxEon2gYUIC1eBRZV/RlBMiONJCU2XKZGULfkvGk=;
        b=QhsqPm7Y/ATmr8gPGA1VMzrZDEI09XV2TyadzsiFItROvsn+xCfySajv93j3R0FiW5
         YZGqWeD6AtdxvdWVj6T47NHwvVvMUi/JstzG4+JO52WurVe83T5fd6TTwI+L10MPwvn8
         TIQUW+KH7CxbHnu5VpgJm6QFN14AqIsvBBTCcHOd5Y1vFwJVpgBTJnT6tAIqMKLH2S3c
         MsfhggMOxof6rFq+Qo8wRqzCQU4ni1ZHSjZ6FuXXGKUukH8oMiuO/OI2KhePMpHQn4FW
         Gllw6w3fzagJsspj6LvQBONqVpOun7zt0GNWLT2lHNdCfFzfz65g8ci95v1Gv1pF1QrF
         h86w==
X-Gm-Message-State: AOAM531f3oSPPzl0cAUC1wkRptBDhqSuslMlITvL7SdE9/iijEx0gw4G
        v/lg36ldZwgnjoV8yCyPP10nOGKIHfxk4A==
X-Google-Smtp-Source: ABdhPJyRVPdDLYlf95aL0FMxAeW3J9UbAVTBuGtdTo7AGeDrvdDRy8/hJwujfN+ifRR95lmvjw+t6w==
X-Received: by 2002:a17:90a:aa8f:: with SMTP id l15mr6837206pjq.211.1592377032700;
        Tue, 16 Jun 2020 23:57:12 -0700 (PDT)
Received: from localhost.localdomain ([124.123.30.142])
        by smtp.gmail.com with ESMTPSA id x1sm4467625pju.3.2020.06.16.23.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 23:57:11 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     linux-arm-msm@vger.kernel.org, inux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sibis@codeaurora.org, vinod.koul@linaro.org, agross@kernel.org,
        ohad@wizery.com, bjorn.andersson@linaro.org,
        p.zabel@pengutronix.de, Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] remoteproc: qcom: q6v5-mss: Fix kfree build error
Date:   Wed, 17 Jun 2020 12:26:58 +0530
Message-Id: <20200617065658.27567-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds linux/slab.h to fix build error in qcom_q6v5_mss.c

Build error:
 ../drivers/remoteproc/qcom_q6v5_mss.c:
  In function ‘q6v5_mpss_init_image’:
 ../drivers/remoteproc/qcom_q6v5_mss.c:772:3:
  error: implicit declaration of function ‘kfree’;
  did you mean ‘vfree’? [-Werror=implicit-function-declaration]
   772 |   kfree(metadata);
       |   ^~~~~
       |   vfree

Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index feb70283b6a2..903b2bb97e12 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -26,6 +26,7 @@
 #include <linux/reset.h>
 #include <linux/soc/qcom/mdt_loader.h>
 #include <linux/iopoll.h>
+#include <linux/slab.h>
 
 #include "remoteproc_internal.h"
 #include "qcom_common.h"
-- 
2.17.1

