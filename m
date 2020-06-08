Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF99C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EDAA206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXKeks0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgFHJiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbgFHJiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:38:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E4BC08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 02:38:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 10so2431389pfx.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 02:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8nFZFr9b1fII+6D0rKTzWsSJAU76ASsrlWrZljZL5Jk=;
        b=UXKeks0pXHxRBTysC/Dt0BNmLfmM0klkVdz12QpU0BFeAKumvbD71rgnaTd4tuoz7l
         Mrwz9oSPeQvdDqY2l2O4dnubnH/EJpYUaE9ZXglhOwOzcOIL+/gQvq2ZzjKntDGy8TLp
         Zir9ueSk4XHrtIHm5ALzLQJMYVuMRg4Ofo2tSo1NGrOVMugSB+1PdI+zZ5wvbCj0KrYT
         WS2KTs+JOusH1Q9nHP2Tpf/mjJ6Tn0pykUpuiqcQeosoK9HKVFvk/7XvMlKcm5ODPujo
         6e+KbK+RGT6gfHgYvtA2aHtMBpt239ZmMQvp1ue7ugYh0sRyyJ4dzc4sNxKaLivakaFu
         Bn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8nFZFr9b1fII+6D0rKTzWsSJAU76ASsrlWrZljZL5Jk=;
        b=rhAAXbnNDDozX53Mgr5tGEorXH2Qpcz1piJDgPEfuVKNgN/H8lmrQ127CHWQcIgkgK
         FFRDhLNfy1B6DI5H+PYvjCVkbMvaViVtwM57ZBsEK2gnngAnNnx4dofD/xpS6tMiuHHl
         Gp3qpS1vzgfHwywZn4h64RW8HgA0DVSuBk+nY5aTiERnXpkLRrfCE/VRa0fnHiY1HfNH
         MIdKgIVH99+Ya+81j8LeFZpY2to3L9eVgvXoel+RgCSmVWL5DiAeywObwZ/YAo7BvkdA
         cdn88Bgv7vMbZnvgvvrYGPIyBCCi2T/lnloDlH17NcvmFPu9xjVc2IqrFdTWj3FcXtBW
         Xkog==
X-Gm-Message-State: AOAM533fJvTZOEZb2JxIJOtsstcsiW2c5f4rCOEG31dtybtuPzMvmWR1
        o3yOlJRaOq34RwjsmJ3V124=
X-Google-Smtp-Source: ABdhPJwbUtaqyDj7BTPatpRYTufbUH1GbiGng6XdEOmxI8JEukNzBV+RjIAaS5544ZUrmOPqjBijzQ==
X-Received: by 2002:a63:b904:: with SMTP id z4mr20109401pge.25.1591609133685;
        Mon, 08 Jun 2020 02:38:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:4dc:9812:acc3:6aae:21fa:62f8])
        by smtp.gmail.com with ESMTPSA id 3sm6608971pfe.85.2020.06.08.02.38.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 02:38:53 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH] mfd: mt6360: Fix register driver NULL pointer by add driver name
Date:   Mon,  8 Jun 2020 17:38:45 +0800
Message-Id: <1591609125-3761-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

accidentally remove driver name when
replace probe by probe_new in add mt6360 mfd driver patch v4

[  121.243012] EAX: c2a8bc64 EBX: 00000000 ECX: 00000000 EDX: 00000000
[  121.243012] ESI: c2a8bc79 EDI: 00000000 EBP: e54bdea8 ESP: e54bdea0
[  121.243012] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010286
[  121.243012] CR0: 80050033 CR2: 00000000 CR3: 02ec3000 CR4: 000006b0
[  121.243012] Call Trace:
[  121.243012]  kset_find_obj+0x3d/0xc0
[  121.243012]  driver_find+0x16/0x40
[  121.243012]  driver_register+0x49/0x100
[  121.243012]  ? i2c_for_each_dev+0x39/0x50
[  121.243012]  ? __process_new_adapter+0x20/0x20
[  121.243012]  ? cht_wc_driver_init+0x11/0x11
[  121.243012]  i2c_register_driver+0x30/0x80
[  121.243012]  ? intel_lpss_pci_driver_init+0x16/0x16
[  121.243012]  mt6360_pmu_driver_init+0xf/0x11
[  121.243012]  do_one_initcall+0x33/0x1a0
[  121.243012]  ? parse_args+0x1eb/0x3d0
[  121.243012]  ? __might_sleep+0x31/0x90
[  121.243012]  ? kernel_init_freeable+0x10a/0x17f
[  121.243012]  kernel_init_freeable+0x12c/0x17f
[  121.243012]  ? rest_init+0x110/0x110
[  121.243012]  kernel_init+0xb/0x100
[  121.243012]  ? schedule_tail_wrapper+0x9/0xc
[  121.243012]  ret_from_fork+0x19/0x24
[  121.243012] Modules linked in:
[  121.243012] CR2: 0000000000000000
[  121.243012] random: get_random_bytes called from init_oops_id+0x3a/0x40 with crng_init=0
[  121.243012] ---[ end trace 38a803400f1a2bee ]---
[  121.243012] EIP: strcmp+0x11/0x30

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index db8cdf5..e9cacc2 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -412,6 +412,7 @@ MODULE_DEVICE_TABLE(of, mt6360_pmu_of_id);
 
 static struct i2c_driver mt6360_pmu_driver = {
 	.driver = {
+		.name = "mt6360_pmu",
 		.pm = &mt6360_pmu_pm_ops,
 		.of_match_table = of_match_ptr(mt6360_pmu_of_id),
 	},
-- 
2.7.4

