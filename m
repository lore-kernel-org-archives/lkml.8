Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B892C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C18520872
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMf4Qo+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgFBFWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgFBFWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:22:22 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54249C061A0E;
        Mon,  1 Jun 2020 22:22:22 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j3so11666821ilk.11;
        Mon, 01 Jun 2020 22:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bdi8UCxzSUssDbqXRbMhEpMSoLUVUX0I64qbc+enCng=;
        b=PMf4Qo+klgt9z98ZwFoWhrygsY96yIov8PY2EYQcy/JQCLK8g7LaPPXPxmifFeVyew
         i624s6dxJlycoo9Q+1O4FSHsesmJx0yKT8q+n9fRC3ibyoIjHD8KQ4I6AOtGYydyBpFD
         E/MtZ/X4pbiDKdvhz9/BYnp1RZmrFKevikN8/mpL4f9mVjVsD0syhm/+iq2Ho8/UwYtR
         /WPfgwMADhKRsV1UXJxeK9k6QIcYcaUbLr16Eh1h+TSU3wHH+HxeO01YBvbQs+4S+wnG
         YSwNRMTfR/fwAXyQhzu6ujdcHa/PRWNc862CXEsy7cFkwTQrJOYMndi4t/3A8AnXO2Gw
         gLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bdi8UCxzSUssDbqXRbMhEpMSoLUVUX0I64qbc+enCng=;
        b=pNZjFczUG0abhHHCPyr/Ll/Zqp8FM1wKajnU0Am+GxZaoFVqeod0OZ7L5G2gI4qh2P
         tSS0g9o8Igy1s56W1g4PRRWOe52LJNPXdbrnMbhfm0k3Uv7ftTla+XFa3KONOsdw9RnK
         KWGvrBAvutHgljZMrx2etVqOri0wluiu/3dz9lzMN9pt9lSN5vvRQirbB5BvPwEukMwC
         11EBfC3qnGHpXYd5FOn3LrvtAPhm5HBVuH2zB0MUy8EZRxf2BpTB0vm7EcOVq1IPZI0r
         cGFPnPzpYIKoWL7MZSd74DlWdUHD2qB+BI1mCTuwxuXEH4ktpuxlezpL66/+VE4GGG1Y
         WEBA==
X-Gm-Message-State: AOAM533vkuxkm3Y5Tu2Mo5I1Dlnf2RfFtAlf+LcM40SkLpbgr4116e1T
        7RAa60wN78ygIPVwKXkJVk8=
X-Google-Smtp-Source: ABdhPJzIPhF7M2SLkww+dPFA4q73JAbLCOHxsWs90o2kFQEfS2CRQNbAtAMLHxRpOS00dp/q1/vQ7Q==
X-Received: by 2002:a92:af11:: with SMTP id n17mr10807388ili.156.1591075341676;
        Mon, 01 Jun 2020 22:22:21 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id l6sm652039ioh.32.2020.06.01.22.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 22:22:21 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] spi: tegra20-slink: call pm_runtime_put if pm_runtime_get_sync fails
Date:   Tue,  2 Jun 2020 00:22:14 -0500
Message-Id: <20200602052214.70015-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call to pm_runtime_get_sync increments counter even in case of
failure leading to incorrect ref count.
Call pm_runtime_put if pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/spi/spi-tegra20-slink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 7f4d932dade7..15361db00982 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1118,6 +1118,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
+		pm_runtime_put(&pdev->dev);
 		goto exit_pm_disable;
 	}
 	tspi->def_command_reg  = SLINK_M_S;
-- 
2.17.1

