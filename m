Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED79CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92BD721556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ef6JEEgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIJTox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731301AbgIJPcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:32:39 -0400
Received: from mail-oi1-x264.google.com (mail-oi1-x264.google.com [IPv6:2607:f8b0:4864:20::264])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21F1C06136C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:26:11 -0700 (PDT)
Received: by mail-oi1-x264.google.com with SMTP id t76so6268128oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TAjjOvVAHuYufOKkxDIWgneZqY7sSReSHXxF69LgeUk=;
        b=ef6JEEgmO8Bbat620fzmhEP4DAAoGctxfoKgC48sZJe39cxAsZKKJ+6SKqXP+FLZbr
         6VesQPojPH6t+Y8emVnJ+O9gvwAIpHWp2cbREdVKsNw31R/o6Kizo9YKh8caSPcxE86Q
         vtEqoR4k0yyR8PAsyaafhDNsbFUE+lRE+/gZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TAjjOvVAHuYufOKkxDIWgneZqY7sSReSHXxF69LgeUk=;
        b=i4S2JvbBg1kp28rIN98dz0QOAZVm0Ymb0f5mq7wyE9fMZ637nJ0g875rdQT5nR4QT5
         ENFJcU3ldPM0i+HaPfxnS7tVMY51KTxm3HkhShX4La70uAH3MMn/9UGbjs3xppfT85T/
         Uu184lO+uROOgh94OI9Xd0pzX4/SGMZ+2jUoDMZCOb68jVKZ38JoYq4M6VOyWz7TZtq6
         5y3bE5kkWykCMjVVDHBQVWbNUm97Kt0VyYWmnNOGwmNNx6N2WlZ7guZ7p9Gkia9hjIx6
         G040hYDIPzS0TGZF2nqX7WR032Z322+INz3iwWimSb+LaSzmYWWNnN3mPsRsQJpoIrAn
         k4Fw==
X-Gm-Message-State: AOAM5335DXCMtO9n6Fi/16boqsJ5mSOiB5PSDuAmWM9y05bkgzmImTRr
        Y3O/MNmmEbjcJipqtUB6zOV38tfnbrqpleY578kJr2JVqNiD
X-Google-Smtp-Source: ABdhPJxKUzw42D+XPlJKJWoGyUjU8x+sICTg8mVg0T3jhhHLXIY9y81C+5EjNBZp41/FYbR5CqPx15pRIPht
X-Received: by 2002:a54:4086:: with SMTP id i6mr361723oii.66.1599751570606;
        Thu, 10 Sep 2020 08:26:10 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id h4sm943004oom.19.2020.09.10.08.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:26:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Ray Jui <ray.jui@broadcom.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 2/4] spi: bcm-qspi: Add compatible string for BRCMSTB 7445 SoCs
Date:   Thu, 10 Sep 2020 08:25:37 -0700
Message-Id: <20200910152539.45584-2-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910152539.45584-1-ray.jui@broadcom.com>
References: <20200910152539.45584-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for BRCMSTB 7445 SoCs and indicate it has MSPI rev
support.

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/spi/spi-bcm-qspi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 681d09085175..c5209b42b0d2 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1293,6 +1293,11 @@ static const struct of_device_id bcm_qspi_of_match[] = {
 		.compatible = "brcm,spi-bcm7435-qspi",
 		.data = &bcm_qspi_no_rev_data,
 	},
+	{
+		.compatible = "brcm,spi-bcm7445-qspi",
+		.data = &bcm_qspi_rev_data,
+
+	},
 	{
 		.compatible = "brcm,spi-bcm-qspi",
 		.data = &bcm_qspi_rev_data,
-- 
2.17.1

