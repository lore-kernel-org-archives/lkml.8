Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC73C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236622082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="xpJQ2n7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgBLORN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:17:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33388 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgBLORN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:17:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id m10so4806624wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 06:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LwGwjsE161QKaZxxfEh4p9giXbnfmZYI+gQ4RyZqzRM=;
        b=xpJQ2n7iz3OLop+srmqVp2xSid1hQiWJDRkGordH3NJI4gVP8vUI2quU2a6zuNQSYa
         t4Z1/XOYIoSsMaBXCv2IijvHQUQJPKZ9kVXYnT9XLAUMP35zDq4hg3782+qQ0/CawA6/
         p4GQxTXeGQ2+A8PSpFLlQEvjvaHxCwj3gRbSvcGSEAmQALt3RduFAYJA8Y+wJS4Bl4qp
         ipvNXtNbEw0f5/VQsmyE5rcooarTlpfk0RCLk283wzNsOTX+wis4pkhoWL6YLLuxc5ro
         HxA7GVpdisDLuGREK0xGlPhrhq+l3+4wdvsy4acQTHRyvg29vO2vRiq2HswKiKS3AAKw
         UYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LwGwjsE161QKaZxxfEh4p9giXbnfmZYI+gQ4RyZqzRM=;
        b=qz+Yp8uLD9g/cg9SrdipcDGcISpZIU/Tjt9YTw2BhbwujHXoClsYqaPfThW//XQFFJ
         rNaSUNo3aLeNjhz0XNyVmvEwrycf7n5Y9XXx2H3mn/bdGkIK62AzRmMvUjIcdmcBgytD
         JJR9i5FmPFjoLkOwZ8Zu0JSQSrAECxpVs7hRkphLNHD40Bq0t+iNugJDqmyVZ3Cc94db
         LEzT3pfsV2iw0zekGmJQ4k3l3b26RHzuHc4uo+UkIvtgKPTBP+Amy8azy8njByuk3A3G
         4n3gs+/1I2hHak+NCzEXUKndhw3zfQEhNuqIRQv+9jEBeoyWCck9NIJQV41ejg8qbBt7
         5C0w==
X-Gm-Message-State: APjAAAWSP8nqMhGIr2gKLZP/Xh8QoHN4TgsAXkdTCf4GQmunh5owqeU6
        7FYEZZ0IST0UUrijYzEizaCVhamX57CVeGIl
X-Google-Smtp-Source: APXvYqy5MQ0xJFtURF5infE1DyoAcLJYC9xHBVxAmBgueHqbGr4Q/KMtujLl9eu7440cf5BIeiY7qg==
X-Received: by 2002:a1c:1d13:: with SMTP id d19mr6708371wmd.163.1581517030745;
        Wed, 12 Feb 2020 06:17:10 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id h2sm826355wrt.45.2020.02.12.06.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 06:17:09 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org
Subject: [PATCH] fpga: zynq: Remove clk_get error message for probe defer
Date:   Wed, 12 Feb 2020 15:17:08 +0100
Message-Id: <0060e55f0b8d3a57e129d7eb096267cc96eae846.1581517026.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

In probe, the driver checks for devm_clk_get return and print error
message in the failing case. However for -EPROBE_DEFER this message is
confusing so avoid it.

The similar change was done also by commit 28910cee898c
("fpga: xilinx-pr-decoupler: Remove clk_get error message for probe defer")

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/fpga/zynq-fpga.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index ee7765049607..07fa8d9ec675 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -583,7 +583,8 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 
 	priv->clk = devm_clk_get(dev, "ref_clk");
 	if (IS_ERR(priv->clk)) {
-		dev_err(dev, "input clock not found\n");
+		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
+			dev_err(dev, "input clock not found\n");
 		return PTR_ERR(priv->clk);
 	}
 
-- 
2.25.0

