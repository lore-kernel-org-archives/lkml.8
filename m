Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F27C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA1620719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxm4Du0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgCZTGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:06:32 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46273 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbgCZTGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:06:31 -0400
Received: by mail-oi1-f193.google.com with SMTP id q204so6503275oia.13;
        Thu, 26 Mar 2020 12:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YILw0WnEbaGR/H+Uju7JRNfDS8c3EZXLZHqmGXa7a9k=;
        b=bxm4Du0Ku+qTJOtOK7Fbfq9wbsoEugHiC1iDUwU0+vhsUasZMAlVEQUzsekw7OBtJl
         nYCb1wExnB0qMBbUNI5P1aZmp0azlKLy8rLGK76eLPcv3zSPhVpqjLr2krZWhTXgIEvt
         MYVLazVUCwjREVVF//JvkogdX8yRKvH1nMUlABfZWMFW6q/UgjEsEgT2/9PoiZ3E8EBd
         c8f1+oYIgYjGCQTsEh3zHIixWMcxfmkmP6xcXG0tMue9L3YF9Z0peDIq6l7fgGfNZdeq
         9cMF+ASlwsqjsrnAYHnnMG5u+qvZJJwKDPNuoGAj56gffYqh49qPfssxtupRpjxm/6ZZ
         9oAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YILw0WnEbaGR/H+Uju7JRNfDS8c3EZXLZHqmGXa7a9k=;
        b=IGCML26v+KVaZFWU+SKIXkPk9vjZW2ZoJkBJJ+Lte5ndDQ90QzkCmHx/kgtwI61i9e
         IUjvnsMvn8vkCxdsypMxLGzIaAa/HlocPBAJOwbxBXIH50hYpYktlmivfjwP3KWJ2IXS
         10ZZB9QOYkfJv4e1pfA0fUTXF40YxURnIA8aVL6cfF6/o7QKA1QyqJ7pT89u62kWK8/U
         qa1Gm0TzNZHMX/JrGjZrJv2dEt/f40mwZNfJsTcfy1D3c1J8EXmNKMeOH2TcjinADpUc
         0NpGPRzJW3DShDJW5Zcn1x5xPO5asKoIy5UBIxsV99PUAQq20cZbU1eH8aVXjTX8xqwk
         9gqQ==
X-Gm-Message-State: ANhLgQ0CQaoNUatkldRiNI7cEqBi755mD3VQ6SGhAo7WT8nHusq940LA
        OFCE4HULlWB6xyoNHD2cBMo=
X-Google-Smtp-Source: ADFU+vu3geWzhd07vWAN5lzC7Ui7pnNBV1hZd+gVUKe22LG3DPBYFbJPjh8Khz6HE2S1xqKGCYezng==
X-Received: by 2002:aca:170c:: with SMTP id j12mr1281904oii.50.1585249590751;
        Thu, 26 Mar 2020 12:06:30 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id j90sm818321otc.21.2020.03.26.12.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:06:30 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH -next] s390/ism: Remove PM support
Date:   Thu, 26 Mar 2020 12:05:49 -0700
Message-Id: <20200326190549.24565-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/s390/net/ism_drv.c:570:12: warning: unused function
'ism_suspend' [-Wunused-function]
static int ism_suspend(struct device *dev)
           ^
drivers/s390/net/ism_drv.c:578:12: warning: unused function 'ism_resume'
[-Wunused-function]
static int ism_resume(struct device *dev)
           ^
2 warnings generated.

When CONFIG_PM is unset, SIMPLE_DEV_PM_OPS does not use the suspend or
resume functions. Power management was recently ripped out of s390 so
CONFIG_PM will never be set and these functions will always be unused.

Remove them so that there is no more warning.

Link: https://github.com/ClangBuiltLinux/linux/950
Fixes: 394216275c7d ("s390: remove broken hibernate / power management support")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/s390/net/ism_drv.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 4fc2056bd227..c75112ee7b97 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -567,31 +567,11 @@ static void ism_remove(struct pci_dev *pdev)
 	kfree(ism);
 }
 
-static int ism_suspend(struct device *dev)
-{
-	struct ism_dev *ism = dev_get_drvdata(dev);
-
-	ism_dev_exit(ism);
-	return 0;
-}
-
-static int ism_resume(struct device *dev)
-{
-	struct ism_dev *ism = dev_get_drvdata(dev);
-
-	return ism_dev_init(ism);
-}
-
-static SIMPLE_DEV_PM_OPS(ism_pm_ops, ism_suspend, ism_resume);
-
 static struct pci_driver ism_driver = {
 	.name	  = DRV_NAME,
 	.id_table = ism_device_table,
 	.probe	  = ism_probe,
 	.remove	  = ism_remove,
-	.driver	  = {
-		.pm = &ism_pm_ops,
-	},
 };
 
 static int __init ism_init(void)
-- 
2.26.0

