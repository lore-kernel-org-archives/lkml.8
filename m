Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EFCC43461
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB7D2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LtwsOLQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgGMOvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbgGMOtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B313EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:39 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so13606851wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uHw7vfvkoUl/p+J0u5Wb1MljRc1mmHUiGpf+lUlkzX0=;
        b=LtwsOLQBSd935qDg45xtuJw1DsUvUlXVZjJbx/aESPvqCbQKILkSfnn5RNWUVbgV2x
         VI914y8yiPOmbKi8YiBaEBwt/4cgx33qyJtNA0FA+AWJuy06NSblJBdOG25jj8XCMgFl
         F/wju0wkxqQEpBHCKhEItmEYgl5Tw0Jp235Cu/tKBRc7JFGLMxWWyVWecZqmvJLOE+06
         V/93fvuIbubbN+OFWr/CSjS1Zb+o2UDipa7mbGPRIiAqvZj6rkTDeApLzOii7vFPbJx2
         +SzuCHJiY0n2N2GRz2TmSE2HbUb+I1PORUjdjg5PFrg2MelwSgdJbFkMZfMQcaAT1JGL
         m2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHw7vfvkoUl/p+J0u5Wb1MljRc1mmHUiGpf+lUlkzX0=;
        b=mM+4Xd0Ip9tHpnVhutXzSv+hR36X2BZ9VsMdUWBxb2KTkY/1sWBAFsvDQqwGmsvHma
         eSV6enFzikj6NTk0uaXpxWyMpmqE56eECLIDzPFnGXBxdauVJPbbOAAOjpKJoBvq1gtD
         iq7CYuI/hYWeZgoOkAnEtSu08dYOZ/yCHI00htCtGOauJq6nP4xwrxz1jkVR3ROqKsmp
         uXc9WWj03v9mp+E2qxru1cBJ/je278k6JTJ8JiPMq8TDfxPGkGOEVaiyGkLkRn1B+ZVy
         ybgm1D9IVIaYB5v4q0asJBhGqyg3+bhulNXQfITk9m42lwIwERWUb0IhdcJSGTzgu7ly
         Nr9A==
X-Gm-Message-State: AOAM530JB2SYSSi1/2WF6wYTq+rBlxxyv+2mteiEDCcjsXQeUZ/yfhmK
        ddf+cgBvENFOwX5BueVjUxUJhg==
X-Google-Smtp-Source: ABdhPJzdyzPd8UNr1xBZ1aB/AYvkeJC2J4Kk5V8tjjunLbWbzabpwC0c0v3arMWicoKNSwUlIpJUmw==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr316828wmg.110.1594651778433;
        Mon, 13 Jul 2020 07:49:38 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH 05/25] pinctrl: qcom: pinctrl-msm: Complete 'struct msm_pinctrl' documentation
Date:   Mon, 13 Jul 2020 15:49:10 +0100
Message-Id: <20200713144930.1034632-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing descriptions for attributes and fix 1 formatting issue.

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/qcom/pinctrl-msm.c:75: warning: Function parameter or member 'desc' not described in 'msm_pinctrl'
 drivers/pinctrl/qcom/pinctrl-msm.c:75: warning: Function parameter or member 'irq_chip' not described in 'msm_pinctrl'
 drivers/pinctrl/qcom/pinctrl-msm.c:75: warning: Function parameter or member 'intr_target_use_scm' not described in 'msm_pinctrl'
 drivers/pinctrl/qcom/pinctrl-msm.c:75: warning: Function parameter or member 'soc' not described in 'msm_pinctrl'
 drivers/pinctrl/qcom/pinctrl-msm.c:75: warning: Function parameter or member 'phys_base' not described in 'msm_pinctrl'

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 83b7d64bc4c14..56b36d4b54668 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -40,16 +40,20 @@
  * @dev:            device handle.
  * @pctrl:          pinctrl handle.
  * @chip:           gpiochip handle.
+ * @desc:           pin controller descriptor
  * @restart_nb:     restart notifier block.
+ * @irq_chip:       irq chip information
  * @irq:            parent irq for the TLMM irq_chip.
+ * @intr_target_use_scm: route irq to application cpu using scm calls
  * @lock:           Spinlock to protect register resources as well
  *                  as msm_pinctrl data structures.
  * @enabled_irqs:   Bitmap of currently enabled irqs.
  * @dual_edge_irqs: Bitmap of irqs that need sw emulated dual edge
  *                  detection.
  * @skip_wake_irqs: Skip IRQs that are handled by wakeup interrupt controller
- * @soc;            Reference to soc_data of platform specific data.
+ * @soc:            Reference to soc_data of platform specific data.
  * @regs:           Base addresses for the TLMM tiles.
+ * @phys_base:      Physical base address
  */
 struct msm_pinctrl {
 	struct device *dev;
-- 
2.25.1

