Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FE9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F72D206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wO+FIfxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgENIZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgENIZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:25:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD45C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:25:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id v12so2662621wrp.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZbgmSmFGHrTn1PgWbNozA+/Dhn/9LaUmkwFWI+wUR/I=;
        b=wO+FIfxEhhg0FIndKHw5mC+KR9nIXPmVUmFr2o2AT90th3322mJsYGDc1GHqdR3wRM
         E+4l8zjkhAWR5GPOxqEhB8oL1MWbe6eSkASr0dNjKZnYCH1PgGdG7qtIfmm049ekRJv8
         AYDH42N3eHwKyuwo/GZLQkOHG1KFXCto4mVVLNts7bpJHjUQhA9vXwidawYgBCeVQzQR
         b+Te5bSfQMmVnBj6z9+2tg1kmWg+bKOEle5xugMRZ5ubVI8G98jORAuwo2lqpR8HHMMH
         Eqk2se46TEeIAHzg0WD1p9c9uWi/3Ne7Twp7F8sfmTERRvOqj5Clw+ung56SMPs9tCrq
         mA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZbgmSmFGHrTn1PgWbNozA+/Dhn/9LaUmkwFWI+wUR/I=;
        b=JFzTRUjRNgHANdI5R8IZtNVooRZK2SFhQFIe3vYqGli/GX6r2xQ9TqAzFMAAHmA4qy
         5c1T5oCQvEiWjJO3NY0xZlpJYif3Q5moCt4AGZYosgDMQBTXMD3sW3PKnW+nyFfKctNG
         42M5Aux/jQqpcxf6LuyoUTtBYx+W8Q6HtaJb3RmrGFs9ORRYFY2u45YYTGQqQkbBYHEi
         sGKasYTwgNDFXmJkw7XSeKRL+TS5PTzSEpxWOhQjukwuK1UymrIBtYF6l7gTj4NTen2G
         a5Z33bzYNXqP6/wIQhtrSE5+Jum8nyphZ0il5epmx4NwS4tDPS5t6ymPZC1NO+d2Toed
         WXlQ==
X-Gm-Message-State: AOAM531Fh29bEEmHL/3Ud77Zg3DNJy6/4Rgpn9tzA48R4eifyrRPOOSf
        aRSCEr04Hk6VdWULdc+5FbSyXdOvEapXqw==
X-Google-Smtp-Source: ABdhPJzxyGw1QivQbkc+cA1lizk0D/rln2dXXvS9C0IXtdTX5Z+I4vGLO+GUrVb89lJquwnukUo1jQ==
X-Received: by 2002:a05:6000:1c5:: with SMTP id t5mr4344696wrx.229.1589444725034;
        Thu, 14 May 2020 01:25:25 -0700 (PDT)
Received: from lmecxl0524.lme.st.com (2a01cb058702ff00bc4b798f4f30d41e.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:bc4b:798f:4f30:d41e])
        by smtp.gmail.com with ESMTPSA id w15sm13739673wmi.35.2020.05.14.01.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 01:25:24 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com,
        etienne.carriere@linaro.org
Subject: [PATCH] firmware: arm_scmi: fix SMCCC_RET_NOT_SUPPORTED management
Date:   Thu, 14 May 2020 10:24:28 +0200
Message-Id: <20200514082428.27864-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix management of argument a0 output value of arm_smccc_1_1_invoke() that
should consider only SMCCC_RET_NOT_SUPPORTED as reporting an unsupported
function ID as correctly stated in the inline comment.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/arm_scmi/smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 49bc4b0e8428..637ad439545f 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -115,7 +115,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
 	mutex_unlock(&scmi_info->shmem_lock);
 
 	/* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
-	if (res.a0)
+	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
 		return -EOPNOTSUPP;
 	return 0;
 }
-- 
2.17.1

