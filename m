Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE79C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFDC20789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="E+lWkEXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgFMWMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 18:12:25 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:54860 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFMWMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 18:12:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49ksK22Zjkz9vYk6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 22:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zyPvSMUedhG1 for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 17:12:22 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49ksK20xVfz9vYj5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 17:12:22 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49ksK20xVfz9vYj5
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49ksK20xVfz9vYj5
Received: by mail-io1-f72.google.com with SMTP id h65so8693477ioa.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 15:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FdXdjmHedAXj/hlk7x8D2COLWhxBtrcFuL19bnCoiAA=;
        b=E+lWkEXd4WicprOc2RqreVpZnplmVN2LIbRmnw0No49QtjaK96rI3bD/sfAfaYS4m/
         KVTt1ccYZ2tDof2dsHIgQ5BCKtyzmllzHExtOb5KeuxHWDtFW5xI69p/wxVKJ3CJr+mU
         2d621AZC8T2S4HD+mCdQY8pl2gjCz1IlEdF5I7AQDld3NcfscE1ALkezWGTW/1Q74EM4
         3Cf+L+L2arREVxDsHWURivEC/qCHCPVw8yiPHf1Uczs7sbgrXHh+6zDAM7LoXgjoRDo5
         W1ofsXjPal3aVEOCaDn5D6+BmbZBFdyEbOXOPgRVnRrzMxaiRM0+HYk+m7N6/yMzef87
         u2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FdXdjmHedAXj/hlk7x8D2COLWhxBtrcFuL19bnCoiAA=;
        b=EwLvUSFcMCtYjqgXhYzTOQUvaOYDjzEVeWaC+a9bcyuYAGbigXeyATBEn2+U0eBeg8
         r5QmqGp8LlljMhpxX7ZVXU/e0At3Cdn2RnS9O2S7s4bObVHEaVSAPzjtmNYEGXPD9lSN
         ZNlrQ84Pm9D7MrGNTit/6n0ZCJlZThzp/Kwx0+veeqezFPHVCCF/YiCS8lXXeHxAS63H
         xPhJtQEmivZLbhvUNmON7GHPMk08Bq4BEmUVDWeMnhbn33UHBjYQoRS3XgwD7lGv0G+M
         12bkdNyPVI+J6LTXpndlFVAiRcC3K3PdLkitCSsqzXBeKwFzN24u6845B7cOa3wj1hN6
         3YLA==
X-Gm-Message-State: AOAM532+FhpGVGCPbuY3USUk/CaLvQ85+E2LVwadt23PHdr5yW+wEFBD
        wgK0No7aIIWJe5sdVsqu0x+7I6WGpwWxjjxU48PP9pC3/+FYMD2nwvjBTAVyMQbPbi4qV1hSiKH
        j/BhBfDqbPbgsGHEgUZba+/6IHvvH
X-Received: by 2002:a92:7704:: with SMTP id s4mr19994856ilc.290.1592086341099;
        Sat, 13 Jun 2020 15:12:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+//kWNb9V2Ow5xh8TBnmfbyli85orS09mQYbNbn0QSH892okmXW7q54bX3ExekcIPhamNng==
X-Received: by 2002:a92:7704:: with SMTP id s4mr19994833ilc.290.1592086340807;
        Sat, 13 Jun 2020 15:12:20 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id z12sm5285868iol.15.2020.06.13.15.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 15:12:19 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Wolfram Sang <wsa@kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: busses: Fix a reference count leak.
Date:   Sat, 13 Jun 2020 17:12:13 -0500
Message-Id: <20200613221213.6679-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus call pm_runtime_put_noidle()
if pm_runtime_get_sync() fails.

Fixes: 13d6eb20fc79 ("i2c: imx-lpi2c: add runtime pm support")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 9db6ccded5e9..85b9c1fc7681 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -260,8 +260,10 @@ static int lpi2c_imx_master_enable(struct lpi2c_imx_struct *lpi2c_imx)
 	int ret;
 
 	ret = pm_runtime_get_sync(lpi2c_imx->adapter.dev.parent);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(lpi2c_imx->adapter.dev.parent);
 		return ret;
+	}
 
 	temp = MCR_RST;
 	writel(temp, lpi2c_imx->base + LPI2C_MCR);
-- 
2.17.1

