Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974FAC433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3192065D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqlhOZ4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgGQPX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgGQPXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:23:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D49C0619D2;
        Fri, 17 Jul 2020 08:23:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so15452437wme.0;
        Fri, 17 Jul 2020 08:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g3oukpog0b62v9lI3IDsLLWPvqIlVmXh8YL5j5paae4=;
        b=EqlhOZ4m3OmocVg1SNRRZNHzzjLw43ObsG1DyWI7NNKGZWspM1cNk5ZMRreQ9pexv9
         Ur2oqkU8glJnJqgLkYuzR32G8TCdLdWEgtKHBsA4qQj1z7TQKiHiVMRjaoXtZqLdb9OS
         AW30WDLGT3w1wqARm/QlFmOJ3GTaar3eFm6ur/rURz6XlVykx/eENUCaFUI/YfQSzWx7
         HSK46Qd01DaasZKgeymroXPuxOLGk8y70Yij0/cyzFJCR85SjG3/xv+ml28AFsdZHg5S
         8+4RgVOzagZWkgJXEvee4DuvPDGbzkLjbdnYANjRlagSJIVK3i8qrCF2iYZ0Mq33iRch
         CRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g3oukpog0b62v9lI3IDsLLWPvqIlVmXh8YL5j5paae4=;
        b=mxiNotig+3BdOIMPzGHPBAV1tKo+vvRE/sYhiiKwHGsZB81MmqQ+7p1lIUUbNthH+e
         fPzNY//wU27t8DOcXLR+cQfRWZwLljD8iLHQhXtiQXqn1TVLk2hhlnNK4sx8z9sWU1xB
         D+Mk6MMJmwYuaVVoqlN5tf4AWHdI8HZtcxBIADw4/ZXbBM/WW2ezUsOzOJz+Kz6FrbXf
         0N9kNEO7dCmBjsqgR3wF7TxndcoGaZS94I5zPNehuu1pINbfMYTfi8DIUpfo2Q3xZV19
         MKUloaU5e+EEKRNLgkkNXfnQ5xvSV4ayBR1CYd7yBgJ+EFi9ogumQgJBJyBWXJSoBYeT
         ffPQ==
X-Gm-Message-State: AOAM533wl8Bz1XJ/HR6f5IsodNex7BibBRtMDxYrBxRcEwcDG2K832gF
        xM7EGZIViLgJLvxfsd13A/2Eyxiu
X-Google-Smtp-Source: ABdhPJy0DmNu1GMmYuVEG04cBF6AH4N8Y91Cb8in/00+EnFCi0OlDMfUJ2ylxyaFGbl16ctS9MWXzw==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr9945788wml.33.1594999432223;
        Fri, 17 Jul 2020 08:23:52 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id a22sm13431051wmb.4.2020.07.17.08.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 08:23:51 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Danesh Petigara <danesh.petigara@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH 6/7] usb: bdc: Halt controller on suspend
Date:   Fri, 17 Jul 2020 11:23:06 -0400
Message-Id: <20200717152307.36705-7-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717152307.36705-1-alcooperx@gmail.com>
References: <20200717152307.36705-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danesh Petigara <danesh.petigara@broadcom.com>

GISB bus error kernel panics have been observed during S2 transition
tests on the 7271t platform. The errors are a result of the BDC
interrupt handler trying to access BDC register space after the
system's suspend callbacks have completed.

Adding a suspend hook to the BDC driver that halts the controller before
S2 entry thus preventing unwanted access to the BDC register space during
this transition.

Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 47bcc9f6afbd..ac989adefe9d 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -607,9 +607,14 @@ static int bdc_remove(struct platform_device *pdev)
 static int bdc_suspend(struct device *dev)
 {
 	struct bdc *bdc = dev_get_drvdata(dev);
+	int ret;
 
-	clk_disable_unprepare(bdc->clk);
-	return 0;
+	/* Halt the controller */
+	ret = bdc_stop(bdc);
+	if (!ret)
+		clk_disable_unprepare(bdc->clk);
+
+	return ret;
 }
 
 static int bdc_resume(struct device *dev)
-- 
2.17.1

