Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2835CC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8492073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6EBDV5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgCZWpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:45:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34938 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZWpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:45:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id u68so3532142pfb.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uXFWCA6HsRoFU7UHbCkibQyhhxiptzgR3ncwTu65yOs=;
        b=b6EBDV5D14KVHV3wD3Ol5xWcqk/VSycmLNDdgJZ9srR1xMjA8/P+83qr06g+dwDBF3
         tpkK0HVrqwYlyhyNs/6Fb9jrYz1YUFN1U7dIz0f2lGUMngq8+meZbD8zi0FnI1x2ZtmN
         1NWQpNJL3NrsmF2m+TgTg8rdjT0TVisGMeu9gwy2G1GFTZHLc7kKDbJT2g0kdR4dBT1K
         G/YP2FpEUoY6ZLU2tq9MsyfKtUB3dyAVMgzesmCp+jCzo7yLR7Vu2OCfOFWCzzioei41
         GEZmdwuTUB+wOIx8RY0OI4BaDASpGUy6JVpuOmO70/NECorFsuLdy/35S5QODhrSfwKD
         o/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uXFWCA6HsRoFU7UHbCkibQyhhxiptzgR3ncwTu65yOs=;
        b=NLybMBUd8OVIQEZFgf2pXesmOlIUvtWSAx0/8UXWhtNUCe3T5ABezkwzU35YgJR5cA
         q8R7ZntFPrbF4PD2/rQXzH4x8eCGc5cHfOtTAPEHeWRRos3eJcdZX6IZG4oKwpia6ajj
         45a3cWDRGyvUjKjzvixNaX5pt53+g6nDngMA4et18/ynINWJ5TwfOJeTmBo8f+WR9fmJ
         1ZiEpUgVpdWXB2zcF8W3T2itZ9JjfwN0edZznbq/NCegrJKDJWH21Xci2M116lUluXP/
         usTREicbRonsF21WhOgTQNIMjBjEPy9YIROlo95V/pvzMk1kjQ3rYjJpiXEiTXmfH4oL
         soPw==
X-Gm-Message-State: ANhLgQ3QDhy+YZVy4Z6ZcdMa/nzJ8mzmMrGc2KxGz4NmXu9N5/zJaw+h
        nBWm16L9WZl9Uj0CEKqAgvTojUAdr+A=
X-Google-Smtp-Source: ADFU+vu9KGqoAE4crBP4wJCZ1UO5CXpzN5sdzapPizXKKa7HM9pL5RtmXtBOe7hYseU2KlJwcR0Mww==
X-Received: by 2002:a63:60d:: with SMTP id 13mr10693526pgg.151.1585262706292;
        Thu, 26 Mar 2020 15:45:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id g10sm2592788pfk.90.2020.03.26.15.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 15:45:05 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 3/3] soc: qcom: rpmhpd: Allow RPMHPD driver to be loaded as a module
Date:   Thu, 26 Mar 2020 22:44:59 +0000
Message-Id: <20200326224459.105170-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326224459.105170-1-john.stultz@linaro.org>
References: <20200326224459.105170-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allow the rpmhpd driver to be loaded as a permenent
module. Meaning it can be loaded from a module, but then cannot
be unloaded.

Ideally, it would include a remove hook and related logic, but
apparently the genpd code isn't able to track usage and cleaning
things up?

So making it a permenent module at least improves things slightly
over requiring it to be a built in driver.

Feedback would be appreciated!

Cc: Todd Kjos <tkjos@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/soc/qcom/Kconfig  | 2 +-
 drivers/soc/qcom/rpmhpd.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index ac91eaf810f7..ffc04285840b 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -114,7 +114,7 @@ config QCOM_RPMH
 	  help apply the aggregated state on the resource.
 
 config QCOM_RPMHPD
-	bool "Qualcomm RPMh Power domain driver"
+	tristate "Qualcomm RPMh Power domain driver"
 	depends on QCOM_RPMH && QCOM_COMMAND_DB
 	help
 	  QCOM RPMh Power domain driver to support power-domains with
diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 4d264d0672c4..0bb12d5870a7 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -4,6 +4,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
@@ -189,6 +190,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sm8150-rpmhpd", .data = &sm8150_desc },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, rpmhpd_match_table);
 
 static int rpmhpd_send_corner(struct rpmhpd *pd, int state,
 			      unsigned int corner, bool sync)
@@ -460,3 +462,6 @@ static int __init rpmhpd_init(void)
 	return platform_driver_register(&rpmhpd_driver);
 }
 core_initcall(rpmhpd_init);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPMh Power Domain Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

