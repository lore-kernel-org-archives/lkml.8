Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22F7C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C57206F8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mush7+yE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgCWPAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:00:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44119 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCWPAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:00:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id m17so8507160wrw.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CrKKQrPGfQFRg7O+vdgKrrd0BOZAZev2MLFiaSgyZ1I=;
        b=mush7+yERMiuascXsIXpZhs1VjJ3P5orEU9x7LRqxsOOAENQAgwnXVOuH0uwWF+h3r
         ObsJNkt/dB5e3/nsoUNwrdgzcD+XWPyc6OQNWfgtfZebqDP89RVarAxkoFBompcWbZDU
         rxXlbxRH7ppUbWrszbz6GUZgvv/5q3Ra8nZIiw585XBaxer2C4Zl8lukVMMUvEqnGLZR
         ceQMTmCMlBnSulHRKNHd/9xgaMBM8vRkwvFr/C1OaQzf5cVgpJVf7Bs0GYJVSfS8pewE
         uKJfhteGatNkV6Gxnq7I2dRih+wmjezFLdejfqSPJvr1uB5dAbjZO8Cs4quZ5rfU7dtW
         sOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CrKKQrPGfQFRg7O+vdgKrrd0BOZAZev2MLFiaSgyZ1I=;
        b=bL6GFD7gwgm/lJxX8wnS21OAji7+lFQiygubvlDfJJRFOGLOh1ejY3/ZTcMaXxGPdW
         JHvYnJOHlzRoy21D43I0yI9mzVAUZcxYcx6qgiaA+c56n+SI+iwNXGGLJz+uECE0PKpF
         tVTG7jbpDcOHd31iISLjXt8lQnuhiX0AvNrIkclzdKgkhkORUnMjcUDOeDrfVI+3/gps
         +gTzTsRB31a51YhNDDIZ0hxuP5iYLlCVG9royJbmG/DlIaPD0G6jdWQA5DKxnLSEPP0Y
         oQgE7H35ueWNScFOR6XWPd/KpRKIwMYWQ4DfjLm0L4n0qIN4gE3M+rKsE4HOw141buaM
         LfkQ==
X-Gm-Message-State: ANhLgQ2kCIg0h7iq3LWlZcU4+53us1ZtoKd4yJlYGNF7Yst0wVgnQGXi
        EwDgE0PzZemITzZ/GivpHYA8nQ==
X-Google-Smtp-Source: ADFU+vsvlgw+lN3GNp1q2MMLQUFtUgqb+HGeDjdPszXkA2zzYG2n8/KXS9d51QVzASfGXcFEA3OXbg==
X-Received: by 2002:adf:e448:: with SMTP id t8mr8335390wrm.257.1584975621735;
        Mon, 23 Mar 2020 08:00:21 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id k15sm1084196wrm.55.2020.03.23.08.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 08:00:21 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Freeman Liu <freeman.liu@unisoc.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/5] nvmem: sprd: Fix the block lock operation
Date:   Mon, 23 Mar 2020 15:00:03 +0000
Message-Id: <20200323150007.7487-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Freeman Liu <freeman.liu@unisoc.com>

According to the Spreadtrum eFuse specification, we should write 0 to
the block to trigger the lock operation.

Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sprd-efuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 2f1e0fbd1901..7a189ef52333 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -239,7 +239,7 @@ static int sprd_efuse_raw_prog(struct sprd_efuse *efuse, u32 blk, bool doub,
 		ret = -EBUSY;
 	} else {
 		sprd_efuse_set_prog_lock(efuse, lock);
-		writel(*data, efuse->base + SPRD_EFUSE_MEM(blk));
+		writel(0, efuse->base + SPRD_EFUSE_MEM(blk));
 		sprd_efuse_set_prog_lock(efuse, false);
 	}
 
-- 
2.21.0

