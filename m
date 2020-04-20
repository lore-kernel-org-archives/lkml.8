Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ACBC54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A1920B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 23:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IG13ZSrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgDTXQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727787AbgDTXQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 19:16:05 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E0FC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 16:16:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h69so5851288pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 16:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KASPutP8+Wt/2CivAD5BVxDPcY0aTKQ2tUjRHF1fuqg=;
        b=IG13ZSrTS4xSdhY/QebJdMqrM/vT/5xW3to2DDrjBlMngXoczlq2XfhiQFBBCmotlF
         Gyu7pZbJejO+Jr8yqmUwxTBj0EG6HOEU7mHsGotvbNYroOHdXzZt3dIEabZS6mjMDhdt
         gUEL/Ek5qwWEoMwrV8rE3GuVb04skEngiDYAvdUg39+Lbxy2Z9A6lXkyHCmyZEdk7Fuo
         aum/OwPdMFsI8TD/TnqdhJBdvrgRHZc+zHhSWI1MVb8k0M49nOC3ZgMmc4cRvXNVYEeZ
         I6P8ZfkyIe+PaEQy3rMf92IvgclRCaaaTtAxHGNDmbCAE4XwrxfG1SMqlsO/nI/yKZQG
         in9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KASPutP8+Wt/2CivAD5BVxDPcY0aTKQ2tUjRHF1fuqg=;
        b=LlFQbKVFw9VyfV7bWBlbzmyD2q1JikceSkB8oGL3+OXROhu40IhQi/qnFmkaKUsL70
         rnEZnnj3Axu7IPYsYbW6fYgq0FDD2VvDOEUZ5SxUxuoYJN90bnHd++trAjRA5IK+leSo
         lQNQ9MZluML7WDKNP2cvVQAKty3XvWAtZSZeYiE9F1l+3tLwK3yVjLfjpQZM6/ATMazw
         Jec574XMswhs7g2CHV228wsNHILx518OpvzHXrTb/5SI6IldH2T2s5be+pP3caNpo3m4
         PSDfA6lunKugz2yo2/R1fVpwCz+ld9zOM9auWdukszOLJWBTpvR5YzpEYm9uq5kUHNA/
         VDTA==
X-Gm-Message-State: AGi0Pua432L1u17qC1ZIT9owrV2WTkWKnJl8n1MWf8TOmwBPb8n/9And
        1W0xHHpquPwVozxltMFZ9sl/7p8xJ1Y=
X-Google-Smtp-Source: APiQypJqbaUChBQV737Tz6wMqMVNrF6DfwFKPYnIC0lHRs1zJCJKHciybyFNgByZKuGHiZgmUHPmMg==
X-Received: by 2002:a62:ea06:: with SMTP id t6mr19109437pfh.298.1587424565358;
        Mon, 20 Apr 2020 16:16:05 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l15sm435354pgk.59.2020.04.20.16.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 16:16:04 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     elder@linaro.org, s-anna@ti.com, Markus.Elfring@web.de,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] remoteproc: Restructure firmware name allocation
Date:   Mon, 20 Apr 2020 17:15:59 -0600
Message-Id: <20200420231601.16781-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420231601.16781-1-mathieu.poirier@linaro.org>
References: <20200420231601.16781-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the readability of function rproc_alloc_firmware() by using
a non-negated condition and moving the comment out of the conditional
block

Suggested-by: Alex Elder <elder@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index db8a15fc1e4a..45529d40342f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2011,14 +2011,14 @@ static int rproc_alloc_firmware(struct rproc *rproc,
 {
 	const char *p;
 
-	if (!firmware)
-		/*
-		 * If the caller didn't pass in a firmware name then
-		 * construct a default name.
-		 */
-		p = kasprintf(GFP_KERNEL, "rproc-%s-fw", name);
-	else
+	/*
+	 * Allocate a firmware name if the caller gave us one to work
+	 * with.  Otherwise construct a new one using a default pattern.
+	 */
+	if (firmware)
 		p = kstrdup_const(firmware, GFP_KERNEL);
+	else
+		p = kasprintf(GFP_KERNEL, "rproc-%s-fw", name);
 
 	if (!p)
 		return -ENOMEM;
-- 
2.20.1

