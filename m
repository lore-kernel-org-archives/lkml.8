Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0FFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799A420792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9kaS29q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgFKSiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgFKSiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:38:54 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7B0C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:38:54 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id d12so269476qvn.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zcAd0OCwL+LW19ejS0uHvwjKngjOVPuSl1ychbjKfWA=;
        b=d9kaS29qTa6CMR7K6/UAq62vdgIm7KjJ1p8JDmI82D+4nk6IlJ3WOcLkwEsrRhuPgQ
         F00P+tc/G3oqDH9WBY/RGphjMiIJbVWWLA7S7vJACm7U7P9HGYMgEGHUBtnO8bJ0KFsj
         fMOgenLNy2rToXZIKX+1cHxMZR/+f/xwraGLWrAelXvROW1ijFNFtOsIE3wQ/bVky3XN
         1Snm5L28bF/ovmTJZ5wzdnr7gdtFicFh5CJ1XPkiMjSVQckpYvZTW0ri+X8++pWahx2m
         OVd1njIPsPUKGSRto5ImDJ5pA03+ctiHcGYf9CzeCHQYphk1e0Utqe1+wUkQd6kZIIma
         FIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zcAd0OCwL+LW19ejS0uHvwjKngjOVPuSl1ychbjKfWA=;
        b=VK0m+ziNVTDycaVtPL0bNaOlDO0CIusr9PM2GLsCuEnXZEYgNHr0VhMR1dSdp6Bn3/
         /ZFRYGOHgWJkebqiq3gSrG1kY18UoS2V5oKAzG6VUEGTHS10jaokkvGjqZdzsWbGdY4t
         IcmwXV13PHpsf6jN+qm1FUjlA7Mzhw4ubxJj8pCj31pnfddwitcSZtsK+x+oMBBvgcZw
         o87Ufgoz89Q9q3rFiB789GVGED11AGr0c2ofFLv/Pme9h1yI3nzRkMeR6Pkj+EEN17Yn
         WIbYBz5pDtqWUF4z3azn4M6M9OTxAPqN4BPWBs9UmBKnY4TYwprqRJNwZxNrLznVExSA
         L8zw==
X-Gm-Message-State: AOAM530Swa6IXkC6UOHQ/n7Q0f77HdXSsb3rkKHsfwuVBdCLcDxQZfZm
        zoVo4yia9abRiQ4icLncCQ==
X-Google-Smtp-Source: ABdhPJwErSdg1RuK+kLXh29/tjcF893DQNxl0XGREP2qGDPkanfxZUH1IBri+KvbvGhv9o3JjbV6lA==
X-Received: by 2002:ad4:4f23:: with SMTP id fc3mr9366299qvb.25.1591900733445;
        Thu, 11 Jun 2020 11:38:53 -0700 (PDT)
Received: from localhost.localdomain ([142.118.26.59])
        by smtp.googlemail.com with ESMTPSA id s70sm2772593qke.80.2020.06.11.11.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 11:38:53 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Keyur Patel <iamkeyur96@gmail.com>
Subject: [PATCH] memory: emif: Avoid double error messaging when IRQ absent
Date:   Thu, 11 Jun 2020 14:38:37 -0400
Message-Id: <20200611183837.170408-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 7723f4c ("driver core: platform: Add an error message
to platform_get_irq*()") platform_get_irq() started issuing an error message.
Thus, there is no need to have the same in the driver.

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 drivers/memory/emif.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 9d9127bf2a59..3ac9f355ddb8 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1563,11 +1563,8 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
 		goto error;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(emif->dev, "%s: error getting IRQ resource - %d\n",
-			__func__, irq);
+	if (irq < 0)
 		goto error;
-	}
 
 	emif_onetime_settings(emif);
 	emif_debugfs_init(emif);
-- 
2.26.2

