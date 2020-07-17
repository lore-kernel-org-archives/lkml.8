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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C0EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2511C2076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0JS/OC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgGQPX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgGQPX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:23:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BB5C0619D2;
        Fri, 17 Jul 2020 08:23:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so11549927wrl.8;
        Fri, 17 Jul 2020 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=39DVA3zqy37IA1tKd3smKZZk/q+1H0Y80MNeTQy6wDg=;
        b=q0JS/OC1B255AdaCCWqQNQayVvqv5EUvuPT8M+lfPx36BqKJqgvYV872My5IIL+DUK
         LjL2zlx5tLK/LAvwMguh9vqy4Ez9gZ8U0/MuEUvVY6Zk6yYF9I288OyGNO45HrW/90ro
         UvQsfg2DSShKfuUR5iknLsvfL/D7w1jhtr7WMdY6xmU19sm3gv1Bc3Bz+/IFOkB/lkVU
         7DHa6nqh4Bpg2KzK1E4pBrss2T9V1QNAVQhw24Z+oWwE6HlM5L2ac1injmC0kv5F4K35
         1xBTwWTHB3Qp0kya1kP65sBDWxunJUyd4awg8Ik0RT2Z3GOU5NLZZRwC8MQRUqC3QZQO
         49eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=39DVA3zqy37IA1tKd3smKZZk/q+1H0Y80MNeTQy6wDg=;
        b=I4xxxvZr1xAITL9noG6ERnugHihdy6WGSSJ0aBZeDQn2rGEghJxdAng9h4L/yvLJRR
         El6C06mwKINKD77Pul/d+NT1cHmoWSxWCwSGFLHDvFmRPZOuH0I5YHxQxC9+ckIlDda/
         NAs/v43cPIceASrwvESQluPehL3e6dp/7E7BaE8h29q/o4SN/zTO4KrQaVs4JdsYXbd7
         V/rgT0f75hp8OL9eMMfVnfYG4XDGGxaOpxZS/9P8/tvmmOUafZQ+/P4VMZcLUXOUfpFd
         N4Zi1PRULh3/iJroEXgVBV1M5ymKUWFt7EvJRcQ2hczcuwrhymZSGuwfR5gxmmierWBF
         g4JQ==
X-Gm-Message-State: AOAM531ruGKuJ8d7nNh3Pe6oPgsfbpBzd3bXSKkyTeYtxTr2G+YX+LCj
        6oqKOFmtG+vNUPNTk8EaEejb829U
X-Google-Smtp-Source: ABdhPJyDn/SGGx7/ByOEJUVhCesU8Opuj9JlfNcuFNT0Mi1OfvwomuMRL+gAepJHsnl3MtWV4FN12w==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr10698179wrj.336.1594999434093;
        Fri, 17 Jul 2020 08:23:54 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id a22sm13431051wmb.4.2020.07.17.08.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 08:23:53 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH 7/7] usb: bdc: Use devm_clk_get_optional()
Date:   Fri, 17 Jul 2020 11:23:07 -0400
Message-Id: <20200717152307.36705-8-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717152307.36705-1-alcooperx@gmail.com>
References: <20200717152307.36705-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <florian.fainelli@broadcom.com>

The BDC clock is optional and we may get an -EPROBE_DEFER error code
which would not be propagated correctly, fix this by using
devm_clk_get_optional().

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index ac989adefe9d..5d8bd9129365 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -497,11 +497,9 @@ static int bdc_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "%s()\n", __func__);
 
-	clk = devm_clk_get(dev, "sw_usbd");
-	if (IS_ERR(clk)) {
-		dev_info(dev, "Clock not found in Device Tree\n");
-		clk = NULL;
-	}
+	clk = devm_clk_get_optional(dev, "sw_usbd");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-- 
2.17.1

