Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC56C433F2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44280207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZynLCgVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbgGVKIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731874AbgGVKIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:08:20 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D220C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so1420617wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IPqVkhoPQMGtJz5QnInc3kyvwMHoALnTgv8DPA8SEPA=;
        b=ZynLCgVShjLt4ArByw5I7KjT7c79vyiAc/nH0pmOKK9JjjnXHOQ3/GvsmaAr+oivgf
         44EIHxLAJCF6fZ1wOJPI6Q3uNRA+godDY8yIR+dOezqDv/z3hY5aQgYsVB6Ng5FjwwiG
         h9IInPRrjeVR+8/R1lAO0m7a3FGYhrZhe1+ripUORtvx3mm8SExK3R3+QbDus8lj8ZbY
         usWdKZI6vLUBXl/W1m07TefDqITe8OIzcPxdjM5Hli8MZupGhKiyEaNJgXnq+2KJyv3G
         PtO4ifoec0YfomfeoFPWN5AcIOzgTgDde8UE9TvneKblgIpUbfJtkRYY/DYGceFSrYn3
         0+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IPqVkhoPQMGtJz5QnInc3kyvwMHoALnTgv8DPA8SEPA=;
        b=pOiIkj+Xr5RGjeRsUXuvp63vkiMLJmCSZ83U1ExjVgaMwnFYe+XSJh79O44THKW6BN
         Ok/Lu8A0bjlpSErnvyvQsiC6/GIAADS4BGlK4l0uLiueLXxQhpY0bQjfoG9vXFREpzHw
         gQ2EspW0iX7Z0Xhrx+qdj2Gn2ELuVaJb+6PccJvMPpqEDm0ckCSLjdsLEVzH0zjsQemO
         LjqZz9Be0IqJzMvr01skkTe1EOvq/SJACnaVEiIdM+svHB3/2ETUILR2PvglnY3TXVi4
         qxv/IT6geAVFlMjXTMbSs4Z5w2uM3ZF57aICz93q1O6bvu0yiCXjJnWOJH3dWGWikK+h
         ZTRg==
X-Gm-Message-State: AOAM531KKm9P7fiAGEZ9XJ4tziGSDmq85w1wINznRPjNcXOSNk6UsoH0
        tNCOlYypSW5GxRqA/nvTI0PYIw==
X-Google-Smtp-Source: ABdhPJyxouP5sUGkwCmSxKsZGINPP2IMG8Qw9hwSgCyNGQeoUKB1ENOO7Js546unG0PRg3fYvsLWQw==
X-Received: by 2002:a1c:449:: with SMTP id 70mr7485506wme.149.1595412499230;
        Wed, 22 Jul 2020 03:08:19 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t13sm17098623wru.65.2020.07.22.03.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:08:18 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 08/14] nvmem: qfprom: use NVMEM_DEVID_AUTO for multiple instances
Date:   Wed, 22 Jul 2020 11:06:59 +0100
Message-Id: <20200722100705.7772-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
References: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
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

[    1.682731] sysfs: cannot create duplicate filename /bus/nvmem/devices/qfprom0
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

