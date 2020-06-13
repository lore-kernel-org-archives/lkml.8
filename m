Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F235EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFFBB2080D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="S0Ducmr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgFMXYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 19:24:07 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:32814 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgFMXYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 19:24:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49ktvm31cBz9vCJJ
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:24:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QjLt2aBzaL-0 for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 18:24:04 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49ktvm1Fryz9vCGw
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 18:24:04 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49ktvm1Fryz9vCGw
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49ktvm1Fryz9vCGw
Received: by mail-io1-f72.google.com with SMTP id c17so8756264ioi.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 16:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=i5/KgdrnjG3t15ZDOTj2WSH86OaHAOkZMrDvjRQElOk=;
        b=S0Ducmr01U4pjsVKx54X6hu/xzj+mukTSBvMLjy30tLcEvx2CPstvGqoTgLUSo/zs/
         UiS2bDEzixns6azcpvFUHDyKTsgV30bjzpDQfEfnnW8wxxgk78Is51IkWqet7eAtt9FA
         2vkpClFtD9aazychqlsolk35lUgh9U5i+YB762M3UqsC+uFCO3G1ai8JEyBXgohFaKVL
         44/JjwEVyUoJ1J69VATljk0j/9Vkr/9wdggBnBmN/RDmsYS4JxhSPZ1VcDh5Jqup+YQo
         e+/KBExO7NZCjsoJ1sI8p73A/N8L8V9JG8EHvK6qBg+8ivnHh2LBXjRnfmX4obExqp8K
         Iyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i5/KgdrnjG3t15ZDOTj2WSH86OaHAOkZMrDvjRQElOk=;
        b=GH+cIl1vEDmRSk+8POeLc6BGye7m8IXbcsXrnUH13a1ru2CoBfTvRAa0zKPd6Yyekm
         mg1y4RfZT0Omhw6u01F5pbwfDLiIiQQLL4lrXF97dmir0dRFm+j4B23bBLJZH2US7h0g
         /HJxgYgTyV23y+fugAttuuRPXyP1E/SlPXDMJCzudjToChGv54Q5WjKaN80+wj4a3vj5
         SNlXtOEHxMssk/R0tbqA8ug3+gkKaxPZgNcBZLYAagWuEbC8VeiXvn5YTpQFux9wvWAV
         oKukoaoM4ETmdvdXrdU1XhvbY2wMmqen3gVuRqdwn0Ki5cEWhBRyAQzdwPvFb2XiwLJ6
         GnLw==
X-Gm-Message-State: AOAM532ewQ0lePcaYmbFILyBFOTe/oUSnlo/fEBbCZQQRS7Lm1g3sbsN
        j51vhDY/qeRuyF8o4WxETI+2n6ZwrSUdafWUPcOalBOK2I2pWv0xDwjr0MjixaeGBoz+o22gKNq
        W2RQlLgAoZ4pzQOiUfcBrVrIfq8DE
X-Received: by 2002:a05:6e02:12b4:: with SMTP id f20mr19757647ilr.243.1592090643749;
        Sat, 13 Jun 2020 16:24:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFHZzsouHl0dV7YvSYM6/V0yenJjNsujtVpHuL7Bs24nylmCfdXnmTp6zh9++Ezrn3m4+iNg==
X-Received: by 2002:a05:6e02:12b4:: with SMTP id f20mr19757624ilr.243.1592090643451;
        Sat, 13 Jun 2020 16:24:03 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id x15sm5375267ilj.78.2020.06.13.16.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 16:24:02 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: vsp1: Fix a reference count leak.
Date:   Sat, 13 Jun 2020 18:23:57 -0500
Message-Id: <20200613232357.18155-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code, causing incorrect ref count if
pm_runtime_put_noidle() is not called in error handling paths.
Thus call pm_runtime_put_noidle() if pm_runtime_get_sync() fails.

Fixes: 1e6af546ee66 ("[media] v4l: vsp1: Implement runtime PM support")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/media/platform/vsp1/vsp1_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index c650e45bb0ad..222c9e1261a0 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -846,8 +846,10 @@ static int vsp1_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
 		goto done;
+	}
 
 	vsp1->version = vsp1_read(vsp1, VI6_IP_VERSION);
 	pm_runtime_put_sync(&pdev->dev);
-- 
2.17.1

