Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81DEC55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D43920672
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f27tU2CW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgDYRxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726392AbgDYRxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 13:53:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90D1C09B04D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 10:53:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o15so6284024pgi.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FrSh0eY3IS/4QrOJLBtSTCw9OHLmyvJKPIU4beyGV4Q=;
        b=f27tU2CWV1WQDXaifhB0T/PwLb1JNY9J89+fk68X3qCxAdXClxrZDnDRRfrHKe7T9Y
         7980ywDC/b870iFjnznfyBbXDe0nWvo89wUuNNA/JzHsF9bKnglB8NKz/q3RjtwHwf6D
         JCzPqU3357Nvj0JxYM+uZzqObwKwWMVUroebQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FrSh0eY3IS/4QrOJLBtSTCw9OHLmyvJKPIU4beyGV4Q=;
        b=MgdYZPx8pHU/VjtLLbAG7JuRG8ae+EuHOGjDFfSqPQ76qmILf3TYjhm+V3im3yBB//
         Bgc1rmxz2Cs3OvvB3fE5IvW51zLud9qU7NEY8oHla7GxrxZhg8yfts157wTzIRTR8ags
         6YiIVZof3j2W+p4wEORslpHc+UhvLlSOOaToC0+F9bOe1nZG7Cz/b1dP6RW0vDa58ApQ
         wjIW8up4mQVlXThaMQkl1P7D73s2CxSE6wFRJ45MwW4YanUIcL9s06b7keonY8DjFUsv
         8PJsQvpqKk+BkHksz4KMns1aiiWH4/07pPN4JlzCRohOT2ZbOc2Ofir++0C8tKqn5Fiv
         HV6w==
X-Gm-Message-State: AGi0Puaa+PbNIgzDOIPQWsV2FOGltfMJcyvICHQR6vqJ1GcZgRWrlV8/
        Mpo0YgZhtDzNEDHth8OvmQzYgg==
X-Google-Smtp-Source: APiQypL5MG+Vfwqb8wBO8IiaFFMITLB4Am2vvtE3JEkGU334jEY/6jpIt9LWokuQ57EOJCrtkJTTDw==
X-Received: by 2002:a63:48a:: with SMTP id 132mr5268581pge.380.1587837197259;
        Sat, 25 Apr 2020 10:53:17 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v127sm8342148pfv.77.2020.04.25.10.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 10:53:16 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 3/3] soc: qcom: rpmh-rsc: Fold WARN_ON() into if condition
Date:   Sat, 25 Apr 2020 10:53:12 -0700
Message-Id: <20200425175312.124892-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200425175312.124892-1-swboyd@chromium.org>
References: <20200425175312.124892-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the WARN_ON() into the if condition so the compiler can see that
the branch is unlikely() and possibly optimize it better.

Cc: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 28121a32a434..4accfeb191de 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -373,10 +373,8 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 
 	for_each_set_bit(i, &irq_status, BITS_PER_TYPE(u32)) {
 		req = get_req_from_tcs(drv, i);
-		if (!req) {
-			WARN_ON(1);
+		if (WARN_ON(!req))
 			goto skip;
-		}
 
 		err = 0;
 		for (j = 0; j < req->num_cmds; j++) {
-- 
Sent by a computer, using git, on the internet

