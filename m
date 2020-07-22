Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C966C433FB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C51207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4T9yBfN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbgGVRIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgGVRIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:08:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8D4C0619DC;
        Wed, 22 Jul 2020 10:08:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so2626675wrl.4;
        Wed, 22 Jul 2020 10:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KBryyAOXlIEM72mjj0Ie/wtlsW0303YjImjOaYxqFM8=;
        b=U4T9yBfN/KiRrtZOD5RskdJoL/IGZtn1OvZEOq3koDtpOobOycG1IXWQaDfZXdi6su
         QOuiucxfmK0PYDZLlgaNXlhJpZ783tRGRGNhPKgffGw0srR6uaLOeCUbnqJx+3mgkDhK
         jcxpFYtEjJoSMKQDISeVOLEsL56sSTmEZqEjcCSfo22kLtc4KjksPc3jzoG2cA3UEfhh
         p0bdNWTS//HDqst/j3vnbS86idF3NiI9uN63czNaOpk8Fi4qp2ZsZlctRKT5/m3RkYFy
         bAlWTf3zwjhXJix7VRvvi68WHYUuZEbtmVeD64uHRkLPVPm0mXj96GFm1tZoVYB1nwUb
         a6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KBryyAOXlIEM72mjj0Ie/wtlsW0303YjImjOaYxqFM8=;
        b=t0RZwTHRpNLQK5D4vqRTAF6ntF3C9SG9D2GA7lbup68VZTafE/LKgf9YXLRq951swG
         b9sUzWSlmEUH9tFSkG+h86e2r2S5jEW1Fhi8x+wS/vjl/rr1lVWgB3QMVCA8U6VFdcNX
         yb7AC6phApzaO3/LmUL1UbbzwutOc8kyaH6J8fZRw0ucZFdL5Z3ilFqvZCKjanvJH0j3
         SNPKBCcgxmw4Co0ImF+0Qj9TqmqjWEOl8MXVCxKqjGY7ZCCyUdk3yGKdNa6iBd6Fv9Xb
         PV0jzoVxgc48O2cXlilZ6fN9Oq781PFZfDFILO9TYzr+jYyz8qIOTLi61vR9JOjgRPlW
         NmIA==
X-Gm-Message-State: AOAM533MXZPz5/t9Vb+GAgYfQ+tfihurHxDfFr59y8oNm53WARbroZSA
        9wF/Gr5JjCW/vqvPlYTrEaoI/6CC
X-Google-Smtp-Source: ABdhPJza494HfVbClB6Vrv/wo9nx4caRRfzl3QhiCCUkTA+6OJCw83nMMaBdr46d3fLnoqaIkKrX0g==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr497954wrs.228.1595437691173;
        Wed, 22 Jul 2020 10:08:11 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 133sm392960wme.5.2020.07.22.10.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:08:10 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Danesh Petigara <danesh.petigara@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH v3 6/7] usb: bdc: Halt controller on suspend
Date:   Wed, 22 Jul 2020 13:07:45 -0400
Message-Id: <20200722170746.5222-7-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722170746.5222-1-alcooperx@gmail.com>
References: <20200722170746.5222-1-alcooperx@gmail.com>
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 2c2f7aef7ba7..c1650247ea39 100644
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

