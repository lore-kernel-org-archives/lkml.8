Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA64C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D1A2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xMAoHVNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgFPGNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgFPGNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:13:48 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84BEC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k6so2960524pll.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 23:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tafn8tgvook2kdsU5HvJlEK8LMOFG+C0LcPeZd052n0=;
        b=xMAoHVNpffLY2lyTJD9QbeN8KTyRSaCCjkC1E0u2VIy0nIWcP5sclAiUAnyOV5gxo7
         oUZ5I8XHEKUPI5HHxhiuB3+rhaj6tORHBTO43Z+tK6rGQ9KB52CJoor8yhS92yQgrJE5
         UsjsHN6CB7p6Wvnm/t05rV2XL0Eo3w/Gkepsz9Lk2uCVqEdP/Onw398cCpRDh4z/aPsk
         5kwkQUlYMQYiuf9ijlJaEIfoKmdY1YHHs4x+UsDUtjNA4biCYzwLJRQYBD8q1MHKJKT7
         XGf7sL+4v7hVAdKG6ictgI5vbmId+R5Vnm1ZlDViPyMrg6hBsc/jbJsngf/Sj51SRZS+
         AcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tafn8tgvook2kdsU5HvJlEK8LMOFG+C0LcPeZd052n0=;
        b=ptEP5+yZTgU/rzOUlJ+QagX0brCpF7JJwF071DncLY0SadfLGDOLL/x2Kig6gGBI/8
         mXReZ0ttmtHeGG7ogPiFJrZIVEvSGEjyqJmMptv8QRRgPAbTnBFuYY3F17W8h7VoFgzU
         Rrfr4sNLQSOmXLGfwZk/6AzdTT9kss8K2I/hjeAV6Sz+0izFp2uhom4DFF7O2jjAezRD
         f0paJ2UqpH+OlS5H3dKHdTGTt2kQIsLZn1GLUKPwj9OP52xU8VkLapJSJ6f0dECByjk2
         llRGSrr7Fn5TrfWHno509NX2/F78zSZaAy4EunwzhDYNAF0NVEBJo4MyBUTEFcaow5Yv
         Q5/Q==
X-Gm-Message-State: AOAM531xkqFBeRibVQzCOFSDgjcKvxzyQjxE7ctlYOS8duS/d/UT/bnm
        Wiic/f74v/iu0//tW0XUpo7cPOqX4B8=
X-Google-Smtp-Source: ABdhPJwzpEnEW8XPSBOBq1A7hYTb2UNoutUZvIjQpKbpwqGbOmCOIwyYxiTOyT5TfnOfy6VyShAGtg==
X-Received: by 2002:a17:902:8f98:: with SMTP id z24mr796330plo.123.1592288027157;
        Mon, 15 Jun 2020 23:13:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id i26sm15642032pfo.0.2020.06.15.23.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 23:13:46 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-gpio@vger.kernel.org
Subject: [RFC][PATCH 4/5] pinctrl: qcom: Allow pinctrl-msm code to be loadable as a module
Date:   Tue, 16 Jun 2020 06:13:37 +0000
Message-Id: <20200616061338.109499-5-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616061338.109499-1-john.stultz@linaro.org>
References: <20200616061338.109499-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tweaks to allow pinctrl-msm code to be loadable as a module.
This is needed in order to support having the qcom-scm driver,
which pinctrl-msm calls into, configured as a module.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig       | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index ff1ee159dca2..5a7e1bc621e6 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -2,7 +2,7 @@
 if (ARCH_QCOM || COMPILE_TEST)
 
 config PINCTRL_MSM
-	bool
+	tristate
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 83b7d64bc4c1..54a226f682e9 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1355,3 +1355,6 @@ int msm_pinctrl_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL(msm_pinctrl_remove);
 
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. pinctrl-msm driver");
+MODULE_LICENSE("GPL v2");
+
-- 
2.17.1

