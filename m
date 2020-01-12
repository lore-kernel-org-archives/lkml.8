Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49687C33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 17:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139DD22314
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 17:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn/tXtmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbgALRSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 12:18:01 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33296 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgALRRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 12:17:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so7464778lji.0;
        Sun, 12 Jan 2020 09:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tl7vtSi+PnhU8zv8cy8MKZTZZyU72nU5B2eEjZlckoM=;
        b=Yn/tXtmmMJTK8+Rxd6IEgmXiuq4E9u7oY1tTnOaWi/kSD798c6lxhXjzhs82AS7TkY
         TBI6kWeNGAVhW779G/ThurMif0Uej6T4V2OaQywiQG7UGTiqCfZh5Kfhq+RZf1KnLNu4
         jsNxdjH7U4ZwvWFPTfuGNBIXU2P1OfyNOIbH9LhZwumKzVNBr4dIEsyQihnEC0i5JIdH
         AVkIraHPW9fEj1aaJcLzTgmK6PhnTzgZHVfazYlHAiJ9j0s7KZKO+ZTjzWj3PrTzMcCt
         xmHYKZzvYFZ93ipnTfRkUKxaYR0KEBW8/iyI4i7dLb/8vk2HO9hRj813NQdkWSEh5LIR
         NWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tl7vtSi+PnhU8zv8cy8MKZTZZyU72nU5B2eEjZlckoM=;
        b=c6LC6pl2LhJYpUN4WV1KNvu8CWm0Xd5SNzoQ35VSbqkBEgwrMe64gebFz6hviGMGuy
         cQgxbMu0Uf7kuZmO9d7xHiq2XT01Xew0tE6K42Iu3m5QnQFhJ4AKVGEQvjl0f4hsjADu
         A2STtqGlPpeQ7RlXkR04jFpy8GjNFCXV4kc6u1EgWnLqDKCHirz5BEuDcQi3zyY9r2xA
         1MlerzVCiPQo9/Z/d0qJe16xOHL4hERgpIyvmDFyWdnXUGt1RVICwDtCuv0cRU1Ba6uO
         eSiDeLbzOQEluggJDHUXQ68p9Ns2NaUvRkjaqxkLyWSA/0iFbmLoIRLlDb31mmq8WIFC
         kOQw==
X-Gm-Message-State: APjAAAVjm6j+McRUn45J6lqNPqeU6+vb8UvocWWSSUG4d+QqNN8cj8/v
        00amOC/4US9wjufYpGSk8BY=
X-Google-Smtp-Source: APXvYqyDe1TAZMZOFFQ6SB63yPrRAxKWCtlEAsi9FJwH6NlIwsIR3ssNw8luZGikz/OoeA8Q3ZmRPg==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr8129689ljk.220.1578849465609;
        Sun, 12 Jan 2020 09:17:45 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id i13sm4506628ljg.89.2020.01.12.09.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:17:45 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] i2c: tegra: Always terminate DMA transfer
Date:   Sun, 12 Jan 2020 20:14:29 +0300
Message-Id: <20200112171430.27219-8-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112171430.27219-1-digetx@gmail.com>
References: <20200112171430.27219-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that I2C could error out in the middle of DMA transfer and
in this case DMA channel needs to be reset, otherwise a follow up transfer
will fail because DMA channel stays blocked.

Tested-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/i2c/busses/i2c-tegra.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 1a390e1bff72..3c7c86d4b0e4 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1220,11 +1220,12 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		time_left = tegra_i2c_wait_completion_timeout(
 				i2c_dev, &i2c_dev->dma_complete, xfer_time);
 
+		dmaengine_terminate_sync(i2c_dev->msg_read ?
+					 i2c_dev->rx_dma_chan :
+					 i2c_dev->tx_dma_chan);
+
 		if (time_left == 0) {
 			dev_err(i2c_dev->dev, "DMA transfer timeout\n");
-			dmaengine_terminate_sync(i2c_dev->msg_read ?
-						 i2c_dev->rx_dma_chan :
-						 i2c_dev->tx_dma_chan);
 			tegra_i2c_init(i2c_dev, true);
 			return -ETIMEDOUT;
 		}
@@ -1237,11 +1238,6 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 			memcpy(i2c_dev->msg_buf, i2c_dev->dma_buf,
 			       msg->len);
 		}
-
-		if (i2c_dev->msg_err != I2C_ERR_NONE)
-			dmaengine_synchronize(i2c_dev->msg_read ?
-					      i2c_dev->rx_dma_chan :
-					      i2c_dev->tx_dma_chan);
 	}
 
 	time_left = tegra_i2c_wait_completion_timeout(
-- 
2.24.0

