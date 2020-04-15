Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EE1C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE32206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cQu4bNLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410600AbgDORA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410586AbgDORAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:00:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57364C061A10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:00:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nu11so106622pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wjox1MgPvdJXUGATfEXxAcxxbZg3uJFLLwCAqSjIesE=;
        b=cQu4bNLsv8clRV7vbm6yX8Vcr0WT6P2ddMJwlbMXwObS0A0xmm0ittvqdSO5Yf1bOr
         sFasgytkTHpQGqOStpC1iFZ4uUdX+5l5cXqSrhw5KghlbYt4eKDVLyAWc/PmCwYfaDlN
         td4R3YoyzOKkRacu2dOnBGm5KU+bqlK4dPVDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wjox1MgPvdJXUGATfEXxAcxxbZg3uJFLLwCAqSjIesE=;
        b=YI2bHjAbVbwodjv5hoBfHyrL9xXuihk2M+SrBeWlkcU8bV+pXxNfBWXnDOfkLJmih7
         /j6VG9EQKBPaUGLLhjjDl85S8u/gT7jxqG9HtKSeJXZYjbs538eWE+CjonITyyaOb9rm
         pYpEzddYLSwfo8QtGuTDO6tdqtSfNISYjOr5FM7NLIAgNIeSw7RgOFvxNpRMEdV9UbpI
         Qm8pKR14sQQiPrBFv0gvEUlZSBfBX7MiLGl/d30eP8Lv8SUk9Qm0xGLGhpUerYRuqyON
         0FTLVYqSWRupcbYMCvC7B3d8kfPY40u/nm9AABbP9CtmIochjwGiAw2m3EhAnr5R6zUs
         S0LQ==
X-Gm-Message-State: AGi0PubQioPwSMM9XwLRKcxVfb+ykGp+S7hf2di/kshrz5e9I79KxZtG
        ANLOB4YK+D7hm0UzoIYi6SML10Q0uYXUtg==
X-Google-Smtp-Source: APiQypIDdUZs+k3p3rTEJpAVtzMK9wPZX2UvdbCzePjqh/cIER11MPgatnADAqs9QL2vDdNfzuL1Pw==
X-Received: by 2002:a17:902:6945:: with SMTP id k5mr5717586plt.8.1586970051536;
        Wed, 15 Apr 2020 10:00:51 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id i187sm14203509pfg.33.2020.04.15.10.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 10:00:51 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mkshah@codeaurora.org, mka@chromium.org, joe@perches.com,
        swboyd@chromium.org, evgreen@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] soc: qcom: rpmh-rsc: Timeout after 1 second in write_tcs_reg_sync()
Date:   Wed, 15 Apr 2020 10:00:28 -0700
Message-Id: <20200415095953.v3.2.I8550512081c89ec7a545018a7d2d9418a27c1a7a@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200415095953.v3.1.Ic70288f256ff0be65cac6a600367212dfe39f6c9@changeid>
References: <20200415095953.v3.1.Ic70288f256ff0be65cac6a600367212dfe39f6c9@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If our data still isn't there after 1 second, shout and give up.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v3:
- The register should be hex.

Changes in v2:
- Patch ("Timeout after 1 second") new for v2.

 drivers/soc/qcom/rpmh-rsc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index ce39d8399312..e09d1ada0cd2 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -175,12 +176,13 @@ static void write_tcs_reg(const struct rsc_drv *drv, int reg, int tcs_id,
 static void write_tcs_reg_sync(const struct rsc_drv *drv, int reg, int tcs_id,
 			       u32 data)
 {
+	u32 new_data;
+
 	writel(data, tcs_reg_addr(drv, reg, tcs_id));
-	for (;;) {
-		if (data == readl(tcs_reg_addr(drv, reg, tcs_id)))
-			break;
-		udelay(1);
-	}
+	if (readl_poll_timeout_atomic(tcs_reg_addr(drv, reg, tcs_id), new_data,
+				      new_data == data, 1, USEC_PER_SEC))
+		pr_err("%s: error writing %#x to %d:%#x\n", drv->name,
+		       data, tcs_id, reg);
 }
 
 /**
-- 
2.26.0.110.g2183baf09c-goog

