Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E46C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6861F2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCFEaDv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgANBhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 20:37:08 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47042 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbgANBhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:37:03 -0500
Received: by mail-lj1-f196.google.com with SMTP id m26so12341588ljc.13;
        Mon, 13 Jan 2020 17:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j37XV7ANVgjgiPiKALeBvbZ2E7R44griMSfBNJCXDRY=;
        b=RCFEaDv8eLqR+dkAJPPi0US3XDGA7lGYfGyiNSdZ/b04EuE3c5BRa8MTn3uueqALZO
         Oz2XAJIDlgG4i0ctRSkXV+n3Oynu9wm63ZFzTxJaOC9a7j+7mk3XBc/Lu53nwnp4LvS1
         VuROMTtyenY4w4m7hzUtkLTJ3lrOAat6avIXEE2CxjSo3QToCoGetyHH6/LZwMU6o8to
         ZN1D4qOG4IxV9MjVkHD5Nf5MF++BAQ7sXIwfpqLWLo3C3Ci5ITnqnsTOm6dVfjXmPjdd
         h+ib++Ef9kPqhF5ee99x5c7yCYfJS8yR2CJbUyx6FcJZMCMxkziSYZeB/rqtdjKoiPk+
         Sm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j37XV7ANVgjgiPiKALeBvbZ2E7R44griMSfBNJCXDRY=;
        b=PjBmef9kegOQ7swggIAaK2+qUPR1BXJtd98YXRACadK6jq6w0gEYYYVCn6SxMt0rzD
         XIjjHG7BZgsOLYNBw5fKOZ6ni0X5hvfNz4wIQtyYvD4lssrvmziX1A03fEyAdb9zKib6
         ff5w0Pla5aqNld0qtGaJb74O2HZzwJ5loO5nQnHCXordhRFe2Ta4Zqo18Z2Tt8gXVM5h
         DfwZNHGEjkKAw5Ab6Rol4qHuhGMHsP6oYFFNkKkeLEQhnlO4uETMYAE3m8cX6jK7De8G
         i74+yMdGAXT7cZcuH0CgToYWGX+hkID3C26AuVGPI2eoIAwz3RksiKMCvClKdHv/YFri
         InJA==
X-Gm-Message-State: APjAAAWXATUmRuXLMwQTI8JspSlP0L6aA1An0xpxpvShl1kRsGJldFBi
        KIr3MIMa3/FWihq3Yncfcl8=
X-Google-Smtp-Source: APXvYqx0y/x6x92NL4UcrV/reFxNS83Q8lDCSR0DLz0ROr//QRUrSXG1Ne8tEimzmk2ExsPcWkx8qQ==
X-Received: by 2002:a2e:9e4c:: with SMTP id g12mr12627755ljk.15.1578965820944;
        Mon, 13 Jan 2020 17:37:00 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m189sm6427627lfd.92.2020.01.13.17.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 17:37:00 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 8/8] i2c: tegra: Check DMA completion status in addition to left time
Date:   Tue, 14 Jan 2020 04:34:42 +0300
Message-Id: <20200114013442.28448-9-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200114013442.28448-1-digetx@gmail.com>
References: <20200114013442.28448-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is more robust to check completion status in addition to the left time
in a case of DMA transfer because transfer's completion happens in two
phases [one is ISR, other is tasklet] and thus it is possible that DMA is
completed while I2C completion awaiting times out because of the deferred
notification done by the DMA driver. The DMA completion status becomes
100% actual after DMA synchronization. This fixes spurious DMA timeouts
when system is under load.

Tested-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/i2c/busses/i2c-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 3c7c86d4b0e4..cbc2ad49043e 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1224,7 +1224,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 					 i2c_dev->rx_dma_chan :
 					 i2c_dev->tx_dma_chan);
 
-		if (time_left == 0) {
+		if (!time_left && !completion_done(&i2c_dev->dma_complete)) {
 			dev_err(i2c_dev->dev, "DMA transfer timeout\n");
 			tegra_i2c_init(i2c_dev, true);
 			return -ETIMEDOUT;
-- 
2.24.0

