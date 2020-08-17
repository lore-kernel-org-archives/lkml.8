Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65C0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53032078D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtvONkuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHQKtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgHQKsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:48:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21799C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:48:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s15so7927816pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wr09/zFN7INgSL/hkVohJfKLUB87eURQe5zN5T5ukzo=;
        b=OtvONkuDX/JtzqrfZY+TxOmI8lyI6PDeI7k0FZY4qhEoncR0+soBHQhZtFjF+usPRr
         1ze3nfbc20Yp138T4zZo9DT0pewwaoxDysUNteVuUtIDF2hujacA6Q3psOT5Z5fIRUvA
         7AA2UQAqLT8wzZRDIUyIs926/HYiA6IESW69ySeDrPIHSLiNuP3N2VZDxNBeWESNDs2v
         A44H2aMiCroqhnMQ+PFB3M9db6eSphx7/EQYSPUcryYwFurEIX+Asq8+61bSQFLg12Ap
         ca15SA0pY/9Q3rQ5DeTExsJxb0163NuzzVEQ1fZFn92QDJmHQzAZwVP3Ilban7ZtCZV7
         f9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wr09/zFN7INgSL/hkVohJfKLUB87eURQe5zN5T5ukzo=;
        b=bENQG2Avi9F4UnKKdfh4EtAC4RAl4sTBRwnIX3oZE3uvCZ2JBPLuD1RC0OaCqt2xl6
         +9ETaq9DTMWQ/G5dYrofYiEtE1MEzqCeECPeZsx+cfIbxNniW0eSwm1A19Lxj0nyJp5O
         0f0forNjwk1PC4LlFz+Vv/Tfj8udf/hKV6gFI0PPmVuKJ0NUrWAEj6HgGQRW/F7ehaAt
         27TjvCCCyqaBYV1NaXwGAiO6okik+o5DQ2lOt+42TJFAC47+3y3ovFOnK3Ilb42ylG/+
         SdwOq1doqLac/kexEqz6sgLbzuRS1ZvT0pG/rUvH8eBH3VOXfr3qdcG9iDBUszCyVHLh
         tOmA==
X-Gm-Message-State: AOAM531D/3+HRF1OjQcb5io3sh0Vfv8YGMC4aH/K8gT6HJhs2niuN9rV
        8u2n2VlQjZgdMhZMFlUB57oweXa4to0=
X-Google-Smtp-Source: ABdhPJypfnuZ3OolRwpPhckjGq08CPfzsBhlNMD0yOvzvwP6FwnpGP6tL5N7eubwyT2d0PQIaARwGQ==
X-Received: by 2002:a62:26c2:: with SMTP id m185mr11042846pfm.115.1597661322750;
        Mon, 17 Aug 2020 03:48:42 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:c217:67e6:a40c:a3bf:1945])
        by smtp.gmail.com with ESMTPSA id k12sm16976528pjp.38.2020.08.17.03.48.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 03:48:42 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v4 1/9] mfd: mt6360: Rearrange include file
Date:   Mon, 17 Aug 2020 18:47:49 +0800
Message-Id: <1597661277-27862-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Rearrange include file without sorting by alphabet.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index e9cacc2..c7a955f 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -5,15 +5,14 @@
  * Author: Gene Chen <gene_chen@richtek.com>
  */
 
+#include <linux/crc8.h>
 #include <linux/i2c.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
-#include <linux/version.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
 
 #include <linux/mfd/mt6360.h>
 
-- 
2.7.4

