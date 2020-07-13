Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0491BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D424C20738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxE70Uh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgGMOtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbgGMOtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71288C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so13431381wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1vzOm+Wxxl66itaxak6yGc68arwrZOiyNRd2hReQUvM=;
        b=bxE70Uh4AXsVWAKo2T/XG7xcyZ+wYk/UE1Oj1K9VheDTBBbntgw6I9aN6Ryi7YN7Hd
         6A/lzM75vKOg0Rg/hp2HH+KfpCdQWtpMbivGS+KZiryf00AIWPO5b4ml+6JbAUxG4YDX
         bKrQytCckcWMV4+BR6JXl8+eE2NhiSSgRXwLROGl0lLVHpbu+AR5OUTFkQlfEKH4lHRL
         ne2dSkONSTP6gT8rCuD6mxOyMe6Vfag456jJXcvCWCSf2EI8wUPnMbKKxGTmvqKCumMj
         a5PJIUWXaAnsLpHnPMb45J+SuCWO8KLCHYkQt5Q+CiIltc44bST5yeme+9ecSrDDB8GY
         zBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vzOm+Wxxl66itaxak6yGc68arwrZOiyNRd2hReQUvM=;
        b=mh5cnj/P8cdMgS0jr9RtcLaNBPJ7aBCplj+FkNK8dZi4F8lFXCsH1tUocHpENDdm+s
         EXELIFgjEz5zch1Ut6JPdnQBJQRl+61XnDiuq4R+jhRouUZpRIElmLT1cxLjeMZSOvk+
         S1aX0si5C1k+GdnV//CSmVb9P18HrlM/Loi4qvUBdbbYYosJKIWnIT0mUa6S4m273oSe
         Qao1mwB4KuU9q5pwJJhWE8VXi6ki6foDxmLRfroore5swQcqhYrejxEzPVhGDx/sFGFh
         p5Ai3URmRLFu71Q/lnaaDFqX3LrUUJQDqvwsHS3MA/XPuxqLHnx1HIzCvpqxEDJJm4uS
         dg4A==
X-Gm-Message-State: AOAM532Zr795744sQjJClPnYFTI471h/MgnvWzzmU5Ol8oHmMHTtPr5V
        0CBKwp35ZspRCR8gP2GK18ZiXw==
X-Google-Smtp-Source: ABdhPJxw1sWGNmpSzrakQy8c0E8EiVET1wI4zlCcDuNthed/Tk9AxB5PCD73LubEHuDLzgs51Mw6zQ==
X-Received: by 2002:a1c:2095:: with SMTP id g143mr267721wmg.113.1594651774136;
        Mon, 13 Jul 2020 07:49:34 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        David Liu <liuwei@actions-semi.com>
Subject: [PATCH 01/25] pinctrl: actions: pinctrl-owl: Supply missing 'struct owl_pinctrl' attribute descriptions
Date:   Mon, 13 Jul 2020 15:49:06 +0100
Message-Id: <20200713144930.1034632-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/actions/pinctrl-owl.c:52: warning: Function parameter or member 'clk' not described in 'owl_pinctrl'
 drivers/pinctrl/actions/pinctrl-owl.c:52: warning: Function parameter or member 'irq_chip' not described in 'owl_pinctrl'
 drivers/pinctrl/actions/pinctrl-owl.c:52: warning: Function parameter or member 'num_irq' not described in 'owl_pinctrl'
 drivers/pinctrl/actions/pinctrl-owl.c:52: warning: Function parameter or member 'irq' not described in 'owl_pinctrl'

Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: David Liu <liuwei@actions-semi.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/actions/pinctrl-owl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
index 5a0c8e87aa7cd..7efdfb4f3e9ba 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.c
+++ b/drivers/pinctrl/actions/pinctrl-owl.c
@@ -35,8 +35,12 @@
  * @pctrldev: pinctrl handle
  * @chip: gpio chip
  * @lock: spinlock to protect registers
+ * @clk: clock control
  * @soc: reference to soc_data
  * @base: pinctrl register base address
+ * @irq_chip: IRQ chip information
+ * @num_irq: number of possible interrupts
+ * @irq: interrupt numbers
  */
 struct owl_pinctrl {
 	struct device *dev;
-- 
2.25.1

