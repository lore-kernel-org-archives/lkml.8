Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4119C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92BA620774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPVVbN21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbgF3Nxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732065AbgF3Nx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:53:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CB2C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:53:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so20224009wrj.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gcm+kDhSJ6u8OVS5n11LXDypiCDxXMx3LOAGKVgWeSk=;
        b=tPVVbN21/FClc9ttBCeAMHvi4rEogJGwnQtBCXn8fRCqcMniGUfFJwYflENJQsw5Dr
         ngXLdKxSi9LnXCQYzFwmmOZj8Sy//OWOCB3COeKA5Xe4QdQIRfFseX1y6o3uGTzxNeWu
         RCPo88Y3ydMQyt/KWBRm2GtE9dyVKqaKvt5Ay84RSJ12gs5e8VqmE+A8/abdpn8iVE6j
         YfMpocKpRdIs6vjYvmMn+t5XMCOTkVuHThJYNIAJzRJPT8xihOWcnRRZTDGozE33fLza
         5AR0Z70ll9lb/2QVZH4bunVxU/pGvCmqyXE4k6IA3pVpeMN+uGIw9Lw2t8E7cTnfN2LP
         QWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gcm+kDhSJ6u8OVS5n11LXDypiCDxXMx3LOAGKVgWeSk=;
        b=t5D5DF3kqfnKEQxXMwKiGvLoVYB/Q2fX7R9e3Xe+LEcSkalwMH31idTkrsW2OV64Sc
         yu6A9TLBm3nPqAA0obySoN+zrnW3tlrL7i+djNoRv8l8zdFNH81KI7DFpjZpvs9Tc+Ps
         ohFgB/uoWBhYahNGW3+3kMuwuUWwL8EvUqZaOOr5lRoJcoz3Ue7zXbcN7zfq1gmdYRpC
         /oX/rWUVv769pwx8uYdNIJLDEL1jdZYfQtXfc3G9LVs3y827MgeLliHgFM2p2T+pdktX
         Gy/UKSllFDiSzZ4OLhxnXMNgDOMs3CN4YrreAUQ4hjaAZQ3b50JxkC3OlcjxTKtl4J4u
         93CQ==
X-Gm-Message-State: AOAM530EEYTiA6GQEPb3jBhEhXDHG6asn1XKl7SMy7HMxBceGx550K+T
        0V0MVn0dMX638QiJsyJ5/yb0Ow==
X-Google-Smtp-Source: ABdhPJySFbRD87k4w8jljS1VA1sxoWd47EVQfdBxEGrLlEi4IiAyx8VktA0dRnSh2JsdUmp/V9DXPQ==
X-Received: by 2002:adf:8067:: with SMTP id 94mr21000661wrk.427.1593525204084;
        Tue, 30 Jun 2020 06:53:24 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id 92sm3972007wrr.96.2020.06.30.06.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:53:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org
Cc:     linux-kernel@vger.kernel.org, shawn.guo@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] nvmem: qfprom: use NVMEM_DEVID_AUTO for multiple instances
Date:   Tue, 30 Jun 2020 14:53:17 +0100
Message-Id: <20200630135317.23163-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200630135317.23163-1-srinivas.kandagatla@linaro.org>
References: <20200630135317.23163-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be multiple qfprom devices on some SoCs.  For example, on
MSM8939, qfprom@58000 holds efuse bits for Core Power Reduction (CPR),
and qfprom@5c000 holds bits for TSENS.  Registering multiple nvmem
devices with the same id results in the following failure on the second
device.

[    1.682731] sysfs: cannot create duplicate filename '/bus/nvmem/devices/qfprom0'
[    1.685889] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.107-00567-g11c887ce2838-dirty #334
[    1.693191] Hardware name: Square, Inc. T2 Devkit (DT)
[    1.701610] Call trace:
[    1.706673]  dump_backtrace+0x0/0x158
[    1.708987]  show_stack+0x14/0x20
[    1.712810]  dump_stack+0x98/0xbc
[    1.716114]  sysfs_warn_dup+0x60/0x78
[    1.719401]  sysfs_do_create_link_sd.isra.0+0xdc/0xe8
[    1.723047]  sysfs_create_link+0x20/0x40
[    1.728088]  bus_add_device+0x68/0x130
[    1.732083]  device_add+0x3f8/0x628
[    1.735639]  nvmem_register.part.4+0x150/0x348
[    1.739018]  devm_nvmem_register+0x4c/0xa8
[    1.743532]  qfprom_probe+0x94/0xb8
[    1.747615]  platform_drv_probe+0x50/0xa0
[    1.750998]  really_probe+0x1b8/0x298
[    1.755164]  driver_probe_device+0x58/0x100
[    1.758810]  __driver_attach+0xe0/0xe8
[    1.762802]  bus_for_each_dev+0x74/0xc8
[    1.766622]  driver_attach+0x20/0x28
[    1.770354]  bus_add_driver+0x1ac/0x218
[    1.774175]  driver_register+0x60/0x110
[    1.777734]  __platform_driver_register+0x40/0x48
[    1.781570]  qfprom_driver_init+0x18/0x20
[    1.786416]  do_one_initcall+0x5c/0x178
[    1.790418]  kernel_init_freeable+0x198/0x244
[    1.794062]  kernel_init+0x10/0x108
[    1.798567]  ret_from_fork+0x10/0x18
[    1.802084] qcom,qfprom: probe of 5c000.qfprom failed with error -17

Fix this issue by using NVMEM_DEVID_AUTO.

Reported-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/nvmem/qfprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 8a91717600be..8b425f8d847d 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -31,6 +31,7 @@ static struct nvmem_config econfig = {
 	.name = "qfprom",
 	.stride = 1,
 	.word_size = 1,
+	.id = NVMEM_DEVID_AUTO,
 	.reg_read = qfprom_reg_read,
 };
 
-- 
2.21.0

