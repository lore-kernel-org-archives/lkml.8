Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3E6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A892072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8+hpTbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgFBFUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgFBFUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:20:07 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1492CC061A0E;
        Mon,  1 Jun 2020 22:20:07 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 18so11665388iln.9;
        Mon, 01 Jun 2020 22:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F4Tq/P229PMR7ICasmIK23jJ97RLivCGIKmExPog8G8=;
        b=T8+hpTbnuvSHhwogA66y50kRHFMgbqBWsImhpLCQOsec2eMLbMFYMHQKbpbFo7W8h/
         ROG3G+Z0+ElDX9XEMFtxd4xvH0wAgnn/u58FKPq3e9sq1q67YGHzWIUe7dtbHqbcELEX
         Yy0WVPyxMbgD9/9FYjHDryYFJv3dNRK9bhN9gkUYzXIHL9bCO6Eku0t2t9ORyAVhSaJR
         aXiUdn9GHjH1+hql2azDyb9KqcfYnVReFIj3PBiYdr96OuOx1xcbvz+O9xbGZnmXHIu3
         eBHS38waTgPZHclVFlsAKP45hcH7KVJzx6xTnpALE0ov4+RllVphkCUqbD42iTguy3mB
         sXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F4Tq/P229PMR7ICasmIK23jJ97RLivCGIKmExPog8G8=;
        b=SKzgK/iDN4woiDk7PxE+lOyAS9w0x9SSRZSLAl2b/YqFfSWmZRZCo7dlbqpO+Wp7Y5
         f/aO4zkWHUarNB+DJRwfrBx4M43tpBWKcdV9mDF7saP2r9IkeKwzie2fH3ENNY4dXLNW
         ZFOURRLzd3hJR234BoZ05UsiCKTT/W5Qll2JmeRKqj8uie3R3NaDvlhJd51pvHQfdZXs
         Gur67CZqPec+HHZjGzYqrF4AtC7Uzs1A/f99QdvOgTmuegNsV252hcqYhSH0RkE37FtG
         7xwpn3d1BjSBJegakhX5LkXH1Fyypgh2LToV8twP6TewHDcc9bEzNu/VyuS8KluAEiz5
         VHFA==
X-Gm-Message-State: AOAM532Z/7PFUyuzHmbqRd0fckZ54edp2VsaKR9wa+mGGfgRMqyQkjfO
        A6ndT3e3Q+dvAIcBYyzYeuo=
X-Google-Smtp-Source: ABdhPJzUazyo0TJpuKZkv18/Tw+D6W2sYn1tKNDm+4aU2MrQuDNRiA/icg1ZUZBND1Exdk97TNhp8A==
X-Received: by 2002:a92:8b0a:: with SMTP id i10mr23343495ild.245.1591075205568;
        Mon, 01 Jun 2020 22:20:05 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id z4sm882199ilm.72.2020.06.01.22.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 22:20:05 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] spi: sprd: call pm_runtime_put if pm_runtime_get_sync fails
Date:   Tue,  2 Jun 2020 00:19:58 -0500
Message-Id: <20200602051959.60440-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call to pm_runtime_get_sync increments counter even in case of
failure leading to incorrect ref count.
Call pm_runtime_put_noidle if pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/spi/spi-sprd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 6678f1cbc566..860032af4b98 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -1018,6 +1018,7 @@ static int sprd_spi_remove(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(ss->dev);
 	if (ret < 0) {
 		dev_err(ss->dev, "failed to resume SPI controller\n");
+		pm_runtime_put_noidle(&pdev->dev);
 		return ret;
 	}
 
-- 
2.17.1

