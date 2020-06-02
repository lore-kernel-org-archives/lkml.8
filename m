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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77051C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BF42085B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMv27LpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgFBF0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgFBF0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:26:10 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C208AC061A0E;
        Mon,  1 Jun 2020 22:26:09 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d7so9546375ioq.5;
        Mon, 01 Jun 2020 22:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eLZuld5pvjUjHTyC9j66F5S+wq2+0vGChjS9TT4ZwMo=;
        b=EMv27LpMIUtFKLVi6M3Rxvn6I4xQRfZl4upqBVY+UXu+dtv4EEGPR0VL7Nk2OqskKy
         phBh+CZXrsqf+kuoTNTp6O41xH+DCyZiDYShq3CCGfKhKs7okGBtMBxpO1JRBCDViUjP
         aGDUHpExpZ2wgQAu8R7E20+tnbYuuKRBGSRM3E2KRDhSfg+UJfXea1TQd3P+7HtbTLKv
         xcsGeDcXljCkBZhjwOP7FhsdVMOF7c0OzDCKysCQ70B/ZyI9gHQ+9hm3PWzKYsyFpVWw
         DNy2vxXCtZ0ZwLwJxY1TYK38OeBn9esfEauXCpWfW2JJKpuahQzHgIJa7iZ81ZzG/Wfl
         m8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eLZuld5pvjUjHTyC9j66F5S+wq2+0vGChjS9TT4ZwMo=;
        b=Ay7fMCzockYfOJnqOp6pRUmTAsjboo1Is9Z7ITYheIIZNTmPGTPgoTinPh5BP3uDNi
         RXXyVGE2UtpdU9XCdR3FIUvMQfosL1zBJkXZ41c89Z7Q2qEQNB2seU3YESt/6VDAE54u
         kXzyrIWxT7x493pairB4q3db50aCUixE1URrei+I3Sr/CYhcsS9u9R4kHuQWErUtl9lo
         HBmgxAh81ZIUb2+ySbSJ1cLXfWGeLpqmQCrRx1w1pthj8Qeh6mK4bmcD9SPgBrd2mlDS
         3x5HO8Il173EahEKs6Di2UGFGD3TaS8hJMzx6fwLXSS9r9OmVN0jR/qSmqtzWxRsGRJe
         SkjQ==
X-Gm-Message-State: AOAM532nmUqKaHOEUwlqjgtmLtTc38ecBbcNJc6VxoLWchtHAWrcoHGV
        rLBVdnEgt4oZK1Z6kfKWHsg=
X-Google-Smtp-Source: ABdhPJwBOGEwnwn8n+mXhBsecMitZVSOH2/twetB8hNZ/aJD7OWvpM+OfsPFJ0CtrHtkLqNx+/+CkA==
X-Received: by 2002:a02:908b:: with SMTP id x11mr23046437jaf.41.1591075569100;
        Mon, 01 Jun 2020 22:26:09 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id d11sm647818iod.11.2020.06.01.22.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 22:26:08 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] spi: tegra20-slink: add missing pm_runtime_put
Date:   Tue,  2 Jun 2020 00:26:02 -0500
Message-Id: <20200602052602.91374-1-navid.emamdoost@gmail.com>
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
index 7f4d932dade7..0675b36d647b 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1192,6 +1192,7 @@ static int tegra_slink_resume(struct device *dev)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "pm runtime failed, e = %d\n", ret);
+		pm_runtime_put(dev);
 		return ret;
 	}
 	tegra_slink_writel(tspi, tspi->command_reg, SLINK_COMMAND);
-- 
2.17.1

