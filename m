Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4867CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C58F22BED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0jJXT0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgHDQd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbgHDQdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:33:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27699C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 09:33:13 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x6so7363360pgx.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 09:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wr09/zFN7INgSL/hkVohJfKLUB87eURQe5zN5T5ukzo=;
        b=B0jJXT0jtUj2/zo9XBQUyG9Kdu2EmQSJbRxb7duGHAWijyWMOh65XKfOh49n6LjnfG
         uAIZcH9qeltXn/9+qyDOPWmOIvH4Cz1eUrgsqvMvUDBepmPnNGkBUdX9MltM9v9bIOv3
         QBYDTBcY57lOpqriYV8yen5STihrd506+zE8DglgJcu2eR6EijFFGprI99ckzm4Vk5A+
         LLjjDPME987JPYAq1UwvNFA1To3AO5JRA7fSfUcTdsrHzR2KImeLIMYXMK2vrGQ2MJTD
         z6iJKdR450NkyaPy3Aw5RsqP05P+HdtxGXSBe9Jg0CVpBoE0+dc/cw9aOMisknlvHORB
         YTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wr09/zFN7INgSL/hkVohJfKLUB87eURQe5zN5T5ukzo=;
        b=qDuvp13DZ9xwc5Pbu5e6CoZH3BqWydZdYFi9GuTOldVnOIOLQnck0yb+/orJi0GE8b
         qOWaPDBXZAxfHClfKT2es2xT0T+zIpRVz4ZgJAOV08jkiQ1hFULPEXmhDT/IL/DshD6I
         yeEka3T5UM/nL5e9zTBOPHPatTBbgPnvj0qSIUGvr9w9CgokrHEH7OHtK3Ab7tczz6KG
         I/XXhl3vIUJN3fzkdluISl5y2UghQjjbaD98LdZ1WABwSv5DhICO2+3d4pLyRocfpxLT
         D3g++DV3SdtzByXfGX2w0bgQShfjkN9MRwhhBMLwVqyyR6Pniv+LR8Q5gt3hPO/Wg2Jz
         bv8A==
X-Gm-Message-State: AOAM532fweJQkAsq47J3RDidKXt2PbRv/b9542yw2bXF8CcxsseZUdcy
        ICX/1P4e3uhCvGVutkUlCng=
X-Google-Smtp-Source: ABdhPJw1Pi3AXMVkSCaqPv5hExwHd2BxhzyFK6XiKYORGvLW802pSliKRXJSIuMPEv6iHBbTj1zYsg==
X-Received: by 2002:aa7:8514:: with SMTP id v20mr21774599pfn.18.1596558792756;
        Tue, 04 Aug 2020 09:33:12 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.138])
        by smtp.gmail.com with ESMTPSA id m16sm657253pjz.47.2020.08.04.09.33.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 09:33:12 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com, rafael@kernel.org
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH 1/9] mfd: mt6360: Rearrange include file
Date:   Wed,  5 Aug 2020 00:32:53 +0800
Message-Id: <1596558782-3415-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
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

