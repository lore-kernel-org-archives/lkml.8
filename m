Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D71C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7232089D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8Vp/tCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406200AbgFYQg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406105AbgFYQg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:36:27 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBE7C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so6191560wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wrbO6xK7EoIeO1VHH2AGpfAcceEYBEVVEFHtZyqDA5M=;
        b=U8Vp/tCRNrGE22Ur+Ex5s8u+LHfRLDxuxHW3gcrrdE8Jv+nrHRuUKAALGt5OLlttHH
         DPDgx7URr2b94n8Z26kcbCUEEISXHVx5Jtn6hs1GPjx02z5LrKGoPkAs0lFmL5b/9ZbL
         PL+/PHQU5LVXGL7q5yP3338Bb4AfDabXM6Tptehd6Udb5DL8b1Rl4HCE8F9dWfOrn71E
         l+2j7aOUVBV+vI1YZn2CSRM5bLopbMyRjHejF8l8yam53WXpcRvfa47NDTJQp2zlqPyw
         UTGRzS5ZHi5r0ReifVYTij7pRDXVphYFOpXWHj2KnqGwtxK0+opyS9ly+BVnfv1KXP+N
         Ilcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wrbO6xK7EoIeO1VHH2AGpfAcceEYBEVVEFHtZyqDA5M=;
        b=C0o4veC4DxA5LZOmSdgvwhodlB4PVi2KBqu6h2A2+eEcWXlNecAwVHkXyMVdJdg775
         YOVOueJB0ej13rAizCRvdJY/zRX15ZNUsJXgr7mOENwZc2YKj18JH6MXYIhUEzV5Hc9U
         z+XY5k+/zaQMVs7ufaGinKpgfJfPjLE555YEQyNZwPoHrh4oleXfKy2whtpu7LfCBvcj
         4B8v3a6BT382imLSSmjqg13CS3mJ7YIG2/i5pYPr5aa0J+5vjQg7iyHH/CZs7fzp4tzo
         hOuw2/wxfHF258/9Nu7oELuGP8zA2Vd3u9jMNYmGZYPjEKcs6f70ORoFqBnwFpvaAkR+
         W6dQ==
X-Gm-Message-State: AOAM5303DaWXXQ7q2icrOqMHFDZCuSVejmD2Puri8Ax266fHWjJU2uL2
        U0efs639s53BmUzeucf31r87NQ==
X-Google-Smtp-Source: ABdhPJxD4VwwV7Ih+k7y/dG2h+HNygvu6V2v3Ta2fHsyVCBjxkCJcMJuTTKrkF/oSmDZGfw5o2P2Bw==
X-Received: by 2002:a1c:c908:: with SMTP id f8mr4307260wmb.150.1593102985745;
        Thu, 25 Jun 2020 09:36:25 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id a15sm36729089wrh.54.2020.06.25.09.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:36:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 02/10] regulator: devres: Fix issues with kerneldoc headers
Date:   Thu, 25 Jun 2020 17:36:06 +0100
Message-Id: <20200625163614.4001403-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163614.4001403-1-lee.jones@linaro.org>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
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
index 3ea1c170f8402..d59009d07a57e 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -173,6 +173,7 @@ static void devm_rdev_release(struct device *dev, void *res)
 
 /**
  * devm_regulator_register - Resource managed regulator_register()
+ * @dev: device for regulator "consumer"
  * @regulator_desc: regulator to register
  * @config: runtime configuration for regulator
  *
@@ -216,7 +217,8 @@ static int devm_rdev_match(struct device *dev, void *res, void *data)
 
 /**
  * devm_regulator_unregister - Resource managed regulator_unregister()
- * @regulator: regulator to free
+ * @dev: device for regulator "consumer"
+ * @rdev: regulator to free
  *
  * Unregister a regulator registered with devm_regulator_register().
  * Normally this function will not need to be called and the resource
-- 
2.25.1

