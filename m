Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74318C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E8B20759
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGeuCgIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGQNzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgGQNyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:54:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82264C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so17159268wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ptPnW5Wq5Xlmw660UEVJ/FMLrebEARvPD+hr3BMDl5Y=;
        b=vGeuCgIuXoltl82e88QMAD4qKZTTplcAZ8PaNDib7nkd+uoYiTXZeVJpFP9WyGWZ6I
         PfM3Ca8M089A3y7Gbs8ILX0PuKbmPBeDvzF6ZG9V3ukEAc/yw0+f71JUSMyM5Ffokyx7
         IdXYIamPS9sSWW3ciq7IBJGGjzRIMC8rDnqUysc+Ej2OPnL/1OMIB5dxfe/+A6fARcQK
         auUqYqUQhiAleVyWBH7QyFrx3GSYVVrxi6lr2CkcDRTPu0ZBZ+RQRF8oG/t+LG7RvNwm
         iVL5K/MEY+S9e2wv2tSgOE+UWEyObkfBCvxhkCv/36sDGFg6YatUyXNMRuzC8OaDQxDT
         93+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ptPnW5Wq5Xlmw660UEVJ/FMLrebEARvPD+hr3BMDl5Y=;
        b=SZ8SAhF586jEXVQAhkon6o9uvhodx7CyEEJV9Wlp8rCp0cUbNcnWFDtsZBKvDs/bdh
         wHZAGs+U3JxSd5x+N4HzNKJS8gavtICjtqyAa9/AtwxlgnwrJxbf3fCeFr/SoEN7WO3L
         xD0Am8sY73LDITiT0coocb97GUW/Ow8xBvSFeh/ruu0Fdb3nYmlIVn2+gVvVndQ5cBJZ
         Ob6ADOSIknOEakt/J/ed7eZjH5KORiGRMMwF7wUSkAxEdbyQIX4W4P7ZThdrspXnUzvF
         6i7TxKn+CBO+DjQY+VC1J0PuWkE/+VZI6SiRFNvjFbWEjGX/u0AYT5634eqzUDeoQFvh
         Eg3w==
X-Gm-Message-State: AOAM5318FRywqvERlvvezOfGRh2IAjVv374YPGWrYAYkQ6avbDhWf0eV
        7msx2tOrgMa9IAimFfJMp74/GA==
X-Google-Smtp-Source: ABdhPJyZRQNbnf+BDafZphHh3/FOeuAD/mogS711QlQ7nFrzO3XXgtccwF7VUm3xUyVC5f35oFt8Lw==
X-Received: by 2002:a05:600c:2949:: with SMTP id n9mr8765745wmd.69.1594994077227;
        Fri, 17 Jul 2020 06:54:37 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 10/14] spi: spi-zynqmp-gqspi: Correct a couple of misspellings in kerneldoc
Date:   Fri, 17 Jul 2020 14:54:20 +0100
Message-Id: <20200717135424.2442271-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Function parameter or member 'slavecs' not described in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Function parameter or member 'slavebus' not described in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Excess function parameter 'flashcs' description in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:205: warning: Excess function parameter 'flashbus' description in 'zynqmp_gqspi_selectslave'
 drivers/spi/spi-zynqmp-gqspi.c:902: warning: Function parameter or member 'dev' not described in 'zynqmp_qspi_suspend'
 drivers/spi/spi-zynqmp-gqspi.c:902: warning: Excess function parameter '_dev' description in 'zynqmp_qspi_suspend'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 811c97a7c8589..e17a201252557 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -197,8 +197,8 @@ static inline void zynqmp_gqspi_write(struct zynqmp_qspi *xqspi, u32 offset,
 /**
  * zynqmp_gqspi_selectslave:	For selection of slave device
  * @instanceptr:	Pointer to the zynqmp_qspi structure
- * @flashcs:	For chip select
- * @flashbus:	To check which bus is selected- upper or lower
+ * @slavecs:	For chip select
+ * @slavebus:	To check which bus is selected- upper or lower
  */
 static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
 				     u8 slavecs, u8 slavebus)
@@ -892,7 +892,7 @@ static int zynqmp_qspi_start_transfer(struct spi_master *master,
 
 /**
  * zynqmp_qspi_suspend:	Suspend method for the QSPI driver
- * @_dev:	Address of the platform_device structure
+ * @dev:	Address of the platform_device structure
  *
  * This function stops the QSPI driver queue and disables the QSPI controller
  *
-- 
2.25.1

