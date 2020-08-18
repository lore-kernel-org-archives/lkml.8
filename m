Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10F6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844A72067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTziVxCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgHRLCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRLCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:02:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2461EC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 04:02:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z18so17815311wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5V8irRRRxRnwftdg2ujt2Pfnni+sPye5ForxfSVU5CI=;
        b=lTziVxCtCNaxClvjURD4ZAxeMl9SLrTRlo3tg9crwli+r+Ce+zS9oaxdHt3NdqfTdI
         5Fa86ptTQwsxUkO9bE4EJHhH7nFgmxcQtRPOtU0SkOeqHJEOYhhX0YrrKOkhCGWsoRWa
         QKLpz1YxCI5P9F3dR1VL8yg0zvKFYE2imoLJba7ljEc/eaDsx9MtuMlQ6Vu3k7XPobXH
         K5MO/spovlbi4X6oyPMcjijkDLT5/Y3C/XeU8q9UBIaXMScrHr98IzaxDssaZNSgb74h
         pr21KG9upxRA892xblwe9bkCDcobrcUbshJgg2vA3e91W4CTOL4/2sHH7XdwqD+bwjfE
         LTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5V8irRRRxRnwftdg2ujt2Pfnni+sPye5ForxfSVU5CI=;
        b=Acu1yomptHJJXHmey4x9f/CsCOTtWG4yd9g3gjjn6Xhv9xTCyt8mI7GUknCur4vINW
         BF1WMHtP3YCffYticwGFR5CWbwLqRDClLokzItyrggMS1CpW//fBdDLd41bGXSv/FdiF
         BSn+ITRm0EVpkwEOk4JArF36/FFiyHtPi+dLanPLuPVlBk1FzZbrcJDaHMUDA361Ag2M
         J7Mnl4i7UHBKTCmW6GXoheHzMpaD6P3cA965AHNxT8qU/MCoZzL5uvO835kYXjQqSQgN
         mOZxvlzydbczAmMGgW4ucCmtkCuZwFbLdUYIVoPi/FXZwUnAU93bfdmKzN3l7EKiM/N6
         ISRg==
X-Gm-Message-State: AOAM533tzLlmJieC4xYkyNyTBaZVTxRoNJtbBa8NRezRPC6MiCrsi5Hp
        yoNNp25cGttRxDMbk/L02tI=
X-Google-Smtp-Source: ABdhPJy8DXY4Vbv4PUXnsXfID1NxwZhTns7dkyJ8QzPTWi/bfGBErLVDBAM8XlBbATD4ev3Ku+l+yQ==
X-Received: by 2002:adf:97d3:: with SMTP id t19mr18635202wrb.138.1597748538730;
        Tue, 18 Aug 2020 04:02:18 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id k13sm32825220wmj.14.2020.08.18.04.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 04:02:10 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alex Dewar <alex.dewar90@gmail.com>
Subject: [PATCH] memory: brcmstb_dpfe: Fix memory leak
Date:   Tue, 18 Aug 2020 12:02:01 +0100
Message-Id: <20200818110201.69933-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In brcmstb_dpfe_download_firmware(), memory is allocated to variable fw by
firmware_request_nowarn(), but never released. Fix up to release fw on
all return paths.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/memory/brcmstb_dpfe.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 60e8633b1175..f24a9dc65f3c 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -616,7 +616,7 @@ static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
 	const u32 *dmem, *imem;
 	struct init_data init;
 	const void *fw_blob;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * Skip downloading the firmware if the DCPU is already running and
@@ -647,8 +647,10 @@ static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
 		return (ret == -ENOENT) ? -EPROBE_DEFER : ret;
 
 	ret = __verify_firmware(&init, fw);
-	if (ret)
-		return -EFAULT;
+	if (ret) {
+		ret = -EFAULT;
+		goto release_fw;
+	}
 
 	__disable_dcpu(priv);
 
@@ -667,18 +669,20 @@ static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
 
 	ret = __write_firmware(priv->dmem, dmem, dmem_size, is_big_endian);
 	if (ret)
-		return ret;
+		goto release_fw;
 	ret = __write_firmware(priv->imem, imem, imem_size, is_big_endian);
 	if (ret)
-		return ret;
+		goto release_fw;
 
 	ret = __verify_fw_checksum(&init, priv, header, init.chksum);
 	if (ret)
-		return ret;
+		goto release_fw;
 
 	__enable_dcpu(priv);
 
-	return 0;
+release_fw:
+	release_firmware(fw);
+	return ret;
 }
 
 static ssize_t generic_show(unsigned int command, u32 response[],
-- 
2.28.0

