Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85173C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552CA2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DE1fTl6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgGGJD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGJD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:03:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC440C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 02:03:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k6so44330237wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 02:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xwb7Hcke9Nx5o8FCnqrp67esi5SW8u2PZFlfYio7RYs=;
        b=DE1fTl6fpP6OAcT/jwSdUK+T2twJx+t0TNzpVaXPuSjNxZQupmpqDa+GncvEa+mS/o
         nVBHUgOVzz2TJ0i73ppmeqoNz9fz+GUYfRYBI/J96UBIlBanfbd4M8Lte3u1yClgowKr
         zHoJWwVUT7G1v54sZlMe++vyPnlk4Q69P4MeekEn6WFkGC6kRcnQkkmoFMII2Rv4JNVC
         xxoSRi2JuuC/lNfXyOHK3ZSWiUxNTH3NwSWyypH5dHdC9Z7M4koyq5lyO5H5Z7Y6Jua/
         Xwnj0yMV10RUA8s+2d6vubuKY9RRzSMhmRVOX6p4zeeOQnWXH06s4pMV7JQfLp7iHD2p
         6TSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=xwb7Hcke9Nx5o8FCnqrp67esi5SW8u2PZFlfYio7RYs=;
        b=ZEzujWpR1pHl6WYcOnI1Aa89EwLslvFPkIaOjeSl49Ewkb+WkrCQMofHfMJ9aKaLLp
         t763OC6tPpV+lqxblsmsBQ3sgB9UW8iLpSJ7FBMHXi+uqQjTJp3hl4sjimMpjSwZdeE1
         uUEEwhFlKAWhHd8J52RcEp7p/HdbJm1aqHzumg2NjdQO2tdS5IiNpcc5R3KqqZPa5B6f
         C8PpsOw/wpCcbR2gA64OrGBgCqthQ+cKWjdhGOmMzKyvBZ0R+dlhhyeT95HTf7TAjJC7
         4LyroASeGgAjPeMZrFvzgcoO8UeECjM3pobXbIw5OUrJHarxcyI06M3lfnfbsGva85i2
         2bhQ==
X-Gm-Message-State: AOAM530CFk/YzP91JqNrhV46dNpFckIb3m5poWRWcf1NYoLH+Fm7/g4G
        By9glvCgjk43jQJXBlOyr6o=
X-Google-Smtp-Source: ABdhPJwmObKqeMSTQBuAPNDf4Bh5od9kb8fgTeytbNfKI2U/rjRHdQq0s7qJTZRzp9oSSiIVt2I6Lw==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr52699860wrw.19.1594112604694;
        Tue, 07 Jul 2020 02:03:24 -0700 (PDT)
Received: from ?IPv6:2a02:8070:bb9:bc00::fc? ([2a02:8070:bb9:bc00::fc])
        by smtp.gmail.com with ESMTPSA id g82sm174900wma.37.2020.07.07.02.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 02:03:24 -0700 (PDT)
Message-ID: <da3aece9abd23b12837e9abf908ee67f0c2c988c.camel@googlemail.com>
Subject: [PATCH] regulator: fan53880: fix Kconfig dependency
From:   Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        kernel test robot <lkp@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 07 Jul 2020 11:03:23 +0200
In-Reply-To: <202007071433.Z3bmcgjU%lkp@intel.com>
References: <202007071433.Z3bmcgjU%lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the fan53880 regulator driver needs a device tree to get
probed, this patch provides the necessary dependency.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index d47055db999d..76ef4b2de2e7 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -338,7 +338,7 @@ config REGULATOR_FAN53555
 
 config REGULATOR_FAN53880
 	tristate "Fairchild FAN53880 Regulator"
-	depends on I2C
+	depends on I2C && OF
 	select REGMAP_I2C
 	help
 	  This driver supports Fairchild (ON Semiconductor) FAN53880
-- 
2.20.1


