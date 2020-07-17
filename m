Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C822AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A193B20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+pYvH00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgGQLEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgGQLD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:03:59 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB5C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:03:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x72so5230798pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uLnTrj9P8ZHZAzkf1IzOOcrWyS/jGLTEfao1cVRtEdE=;
        b=A+pYvH00sdE1ibSY+vP5JFqrguLkdBxvKvodLpBZxBCcli+9COyYP6p7FbsYi9Ewo2
         R97d/XPocErCumfzCNmXA1cKNVS10cIhr2rz1ElpVeLld9fcF6UCf6V3qAOnODb4ojRv
         kvuaf2k1rxK9suIDJ+sOHrGlBGr0n87CYRF1WCKxKiINsAFt96MsDzKuh4k/BTwYgsQt
         W0d28uCOsw/NpoXMQbCbG976Mbb3zjZlIlJMx8faFoREbjVbfFVo0B68gL0kOmpytDwC
         ElzDhEhiYwsxcw9DF9k37a/07DVIFo0mF/IZUGW/Lx1FTs7PdIifTcsGIbpEOdbSCrXN
         F9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uLnTrj9P8ZHZAzkf1IzOOcrWyS/jGLTEfao1cVRtEdE=;
        b=d+tAg8JRYhQTDhY9bNgrjlqz+mj/NmQxQSYDO3H1PjORf4tQxlz729D+dxFeXVFxr5
         JFlqSjvGJuF9dgB58DaVHRThgiNRHL569vcArfGignoqu8hwXKXO0lQG0f8ipiD8WrWh
         SGHAZdShD1KcBu8v8/zWOVC0azZGHXTA+Hprye3U6W59ye7TMMzVyh9IPwhLwORhnqXD
         R2Xt8MPPsmTUK4XuHBkDlTNWEppbp4OzBCjOiI7d7HJy1kqqS64XDkf/xVjLR+tDwUrf
         MR968kpZaawAM6QrH74oNi7m558zdMb1hFV5ICLu0u6SNEmgiBIGL1ktnutM8eI6zL3D
         6aRw==
X-Gm-Message-State: AOAM532gkm14FsBUH5jaQTFKtdpfDwCiyjTdRaUA/+B5Xebit6E/S+8J
        f9M9BKOeMaWFA0v3Jdj3lp4=
X-Google-Smtp-Source: ABdhPJwev9PnQ2nCdUA13HuXVgbCleepBZAem5ZBQEAhDn5vE46ccVov8UwEEHpoBIvvR5SSAjn9dw==
X-Received: by 2002:a62:1646:: with SMTP id 67mr7497949pfw.281.1594983838788;
        Fri, 17 Jul 2020 04:03:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:469:ae36:984e:c073:9d0b:7c09])
        by smtp.gmail.com with ESMTPSA id o26sm7619183pfp.219.2020.07.17.04.03.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 04:03:58 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v2 1/9] mfd: mt6360: Rearrange include file
Date:   Fri, 17 Jul 2020 19:03:23 +0800
Message-Id: <1594983811-25908-2-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Rearrange include file without sorting by alphabet.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index e9cacc2..df4506f 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -5,15 +5,14 @@
  * Author: Gene Chen <gene_chen@richtek.com>
  */
 
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/i2c.h>
-#include <linux/init.h>
+#include <linux/crc8.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
 #include <linux/mfd/core.h>
-#include <linux/module.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
-#include <linux/version.h>
 
 #include <linux/mfd/mt6360.h>
 
-- 
2.7.4

