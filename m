Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7909EC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE152467B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VtSVDyFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgBTKAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:00:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44122 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgBTKAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:00:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id y5so1661740pfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7CDJ0apex4QxluZnYsaSydajm/N1xC0JoUSC9Tebgog=;
        b=VtSVDyFQk8K+na1Mx/+MuHGMnxoAbxdw194HeaR/OqncDj0USEBa1bqwVIdTAH5hGs
         at0iU5yGjvh0Qmf8lVm86hC1yqmDh1HrRjtYDKz1ohIsTZWFFL2mqkDFDnygFvBdac+b
         OMChxI3R0BPyzYrYYc5R7SLTcDHR6E3myuB5apA8I5HSBhy1lsd9HI0PSBQRobZGIhDJ
         TUVpJ8uUysemqveexZAhvglYPFSawyb/2u33e8Adr8M3scoUaJAkQdh5k2kM0zOGR5QP
         jxoYwQ2aFd9CWmTQ9J9BJo8yvHaKsOHmoLekw/ZyhhCTxg5mVxh+tcCTRWju9OUmxgcw
         XKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7CDJ0apex4QxluZnYsaSydajm/N1xC0JoUSC9Tebgog=;
        b=DE1Ow1Ca+grYCEQIh4Hsw6GTQjiv7e6SkfAiz7Anlfnih1pjJNsV1yEt3sTRn3lc/5
         LwXb4Exc0D5HbmcEc5DtzWLde6T3AkvHXUA29Y+fHiIXSyiN07WjEzubogkSF1SIplVm
         Y4a/3fShO+sxdNzVfc/8k2t6fz/gRECVfno7v0F76YcMifSyb0k7Ypmk65gVohWwzZB7
         WCC24Zlk1lmGGVAwIeHKxfjiEFOaD8GNklrQp127qnsKbkfCBxjRontE5kiWppv0MFT8
         hfQedC+DBMjZvQkA+YBREImLeY/NhESYNJnz/RhNbTlqnMRhgjcckN9jzMbUDLWNxoMC
         5dcw==
X-Gm-Message-State: APjAAAUTAwEVvFNm4cMdsnaIBTSIyH+gsypIUsuctvbJT2HITB1p5TOV
        NhAqnp0J4bAkvmoPpCrRQFdN
X-Google-Smtp-Source: APXvYqwO7+EPqgn+bXaMevuAy00OhTTCUFaHYmBhbIF6zEUPkuHV+3YliwX1sR0l6LugM66VYOwndw==
X-Received: by 2002:a63:7b5a:: with SMTP id k26mr29171656pgn.406.1582192831672;
        Thu, 20 Feb 2020 02:00:31 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:315:9501:edda:4222:88ae:442f])
        by smtp.gmail.com with ESMTPSA id b3sm2678644pjo.30.2020.02.20.02.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 02:00:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH v3 16/16] soc: qcom: Do not depend on ARCH_QCOM for QMI helpers
Date:   Thu, 20 Feb 2020 15:28:54 +0530
Message-Id: <20200220095854.4804-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220095854.4804-1-manivannan.sadhasivam@linaro.org>
References: <20200220095854.4804-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QMI helpers are not always used by Qualcomm platforms. One of the
exceptions is the external modems available in near future. As a
side effect of removing the dependency, it is also going to loose
COMPILE_TEST build coverage.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/soc/qcom/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index d0a73e76d563..80aa8b6c56e0 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -88,7 +88,6 @@ config QCOM_PM
 
 config QCOM_QMI_HELPERS
 	tristate
-	depends on ARCH_QCOM || COMPILE_TEST
 	depends on NET
 
 config QCOM_RMTFS_MEM
-- 
2.17.1

