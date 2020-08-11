Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E86C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFC620768
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FaYh00uP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgHKKfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgHKKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:35:10 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEFCC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 03:35:10 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id df16so8666962edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 03:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uRwIOipcItrxEdvc73BAciFxrjXyyFnJHwCmi01GD6k=;
        b=FaYh00uPA0inU6V6X2XtdZN53s+We0TQUPc9IhKJ3DbWywQJQ+i0UAQxlILma4ALQo
         IyOcKDSGziasn+GtzETnNfBUyQdbmIgZmGVvuf0HFrvQdgW/zE+hYMYiMGZAJsF+ThPs
         siOxI+L5Ibaa8SCuUr4vQXMPPziiyCHH+YPXyRsN4inm8UUENDKzhOlRPiSTymjY3SQ2
         VDdyS9wWP7/pBtZRewKvOJ69hnPNpzC6MkhXVjeZvW9NWZeguZjak6jl/vpwlXRa8Y8w
         irs1XnmomSkDKmr88V1QU74osUol2sTOfAgb21IMXAGgjc251BsYZPdpb9Puc2jGEvPm
         XwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uRwIOipcItrxEdvc73BAciFxrjXyyFnJHwCmi01GD6k=;
        b=c/M9e8yxO+koakhqF1+8CqZePzfqp0BEaTEi7VPBJDOsCiVk0ErZ3jgz1cLkHw9D6v
         9VjXG42vIEWXAYHEpd8WxSvf5qs6oEC0HZq1sgwWmdQg0Ug5s/5VxzfrXkNy/HJjx9c+
         IVUDao8Leklnu9JslfTO1tEygqqYmNHmix3oeYygLlFV58Jj59a8vVSH9eLAF+V7RCdr
         HeYEPmEwMbzAi3+tHeYE9DGnIObfRy5ZV8FMnEMj9M1Yusi48vmDBQlehqUmLTzXz3jy
         Mq95n6hqQ7nM7t5zZ+exykPXyRbMqzRGm/eDw1lDU7g0yYQUEOyKp2fZMZ5Uhpi2t4Ek
         2eTg==
X-Gm-Message-State: AOAM5311nNJe+UP01Ug4GkgCPu+6xgjoGZALO0UnzyUtvDhSUlsZXKUA
        9mz41j3PCxcVwV4yiMHUDeJGMQ==
X-Google-Smtp-Source: ABdhPJy8ApjorAKEGaNyUAsmOZgPX5uvHrh5fbCJQl0ALsJMNqZQ4GtLfP/Z4GNVsouofKCKA2PxnA==
X-Received: by 2002:a50:fc0e:: with SMTP id i14mr24919687edr.346.1597142108347;
        Tue, 11 Aug 2020 03:35:08 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q2sm14639997edb.82.2020.08.11.03.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 03:35:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        john.stultz@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: msm8916-wcd-analog: fix register Interrupt offset
Date:   Tue, 11 Aug 2020 11:34:52 +0100
Message-Id: <20200811103452.20448-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason interrupt set and clear register offsets are
not set correctly.
This patch corrects them!

Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 4428c62e25cf..3ddd822240e3 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -19,8 +19,8 @@
 
 #define CDC_D_REVISION1			(0xf000)
 #define CDC_D_PERPH_SUBTYPE		(0xf005)
-#define CDC_D_INT_EN_SET		(0x015)
-#define CDC_D_INT_EN_CLR		(0x016)
+#define CDC_D_INT_EN_SET		(0xf015)
+#define CDC_D_INT_EN_CLR		(0xf016)
 #define MBHC_SWITCH_INT			BIT(7)
 #define MBHC_MIC_ELECTRICAL_INS_REM_DET	BIT(6)
 #define MBHC_BUTTON_PRESS_DET		BIT(5)
-- 
2.21.0

