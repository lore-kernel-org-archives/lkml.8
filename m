Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467EAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A7620772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgFDMhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:37:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34131 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFDMhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:37:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id b6so7090635ljj.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 05:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=187fRi3wAGXdsWJGdJdYxiJeP7RT5ffi4VOBDvE3vkA=;
        b=p5rYNXaVmrpdqAY4WcBUinTVzDBUwEKzCinjbnG8lFGB446iLTePVzCaAnZTznj8JW
         9SOHHRGsAmG4L1gDu8oKbxw03u2VJ6BXAEyeD0sZLUEjC7MOtTFnR1Ybck3W3/Qm8Guw
         FI8mL8UPoenyBUNPotpsVWdGwsl0Y252c6DXvmSa95Z1gb72aK6Op1z/nrr4UjdBx2Vf
         II5RLz+B+XwCqfQMhqerxgVR4Ot4ZeoNJO3c1waoJc0KijKP1c/wuefdOMMXrGoqTYY/
         y3DLUnaWHkNWHORG572JFiGqHdKotiKQvOYJ5y5MDYSdG0tYgGz8481zF7m0NgORrG0n
         yLhg==
X-Gm-Message-State: AOAM531IG7Aku7BW/nlAtjdQJVQdPvvdmBeoq1yFG7HnuKoG9MzJM+SH
        QIKYGgN4oNbMOeDHEgIhM4uwxUeM
X-Google-Smtp-Source: ABdhPJwzuPhkc8BG3wHPWrXHjUZMF/zoqEJHIwPIOx3lb7BjY9OrlhBokKqh/KwK4rJpea2dTekN3g==
X-Received: by 2002:a2e:9b4b:: with SMTP id o11mr2030133ljj.407.1591274236199;
        Thu, 04 Jun 2020 05:37:16 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id 15sm1167175ljw.46.2020.06.04.05.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 05:37:15 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Denis Efremov <efremov@linux.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: fsl_pamu: use kzfree() in fsl_pamu_probe()
Date:   Thu,  4 Jun 2020 15:37:09 +0300
Message-Id: <20200604123709.96561-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzfree() instead of opencoded memset with 0 followed by kfree().
Null check is not required since kzfree() checks for NULL internally.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/iommu/fsl_pamu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index cde281b97afa..099a11a35fb9 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -1174,10 +1174,7 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	if (irq != NO_IRQ)
 		free_irq(irq, data);
 
-	if (data) {
-		memset(data, 0, sizeof(struct pamu_isr_data));
-		kfree(data);
-	}
+	kzfree(data);
 
 	if (pamu_regs)
 		iounmap(pamu_regs);
-- 
2.26.2

