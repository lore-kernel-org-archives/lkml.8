Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F851C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BAE52065D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmCpEbSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390996AbgFYTRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390701AbgFYTRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:17:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3814AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j4so4566808wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j4djQhcgSgTg/9mtm4BHCd5MDCRCq+1jmLB+caUyB0M=;
        b=tmCpEbSO5A63g/ncvKbOwmY8ndQGqysFj9YM7YJH9vcFA1KQbqIHeegdH4VZq2Sfzg
         1nO++r+wXM140SabSVtpFxRLswNTuUsjqQtyAN006BO9tYL+i2dFGpOaF+8aGSmddfwN
         oDVjX1ZE6aX+Alb9sEJo5Br2x47SYFxxIqHxUVWywWMbDeVeEZbU8szbVjRRUqW+Piyo
         TbvuDf+7UoMFVYcfhqOpPVKDCg2cVqsPjxvEBI+zrgTresjCjMBgoXwiH8pv0s6yok1v
         qflrl21jKsf3H2N+5P7wTPXGDnUxTh/TDx75VTRMwjzJsmrxr3Hh3+XnITkjaGmBg4v1
         RoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j4djQhcgSgTg/9mtm4BHCd5MDCRCq+1jmLB+caUyB0M=;
        b=ndqxaPnCVXvGab/n9Eg0y1FhkGAUEeOtduyQkRMmbJF4LoBoZ56U7AIeYnd/q4STAe
         9ed+rZBrLyrf/9MU4bdoDR1CKE1SKmUOy9irkMTfwTpPGkYD2QUnb3rjVSw5oKyuC9HK
         bsf0oyUof/ReBENqAhWZ10pkX0TZ3aqWggwEMw0RQyt2TzwhcZVK+8r2d/O+584jd/eD
         ANnZht0zm0lerDM1hFyz6FPRjVDpHZp2hgRi7RNuiGx9CfzYJAwiadqsU99GG0pRpQuQ
         /iuL4+lxiWGoqw+5GGuqbWfyFYa1xbWppmGftUAKrzDuQHlzwD2xRayHcn3EhwLaefn9
         43Ug==
X-Gm-Message-State: AOAM533NCWjBdlfcIp5Lc1nmfznRYqehRnMl8GP6muSsBv8Vap1/WHYy
        gtp8qWydiG7IicveHSVbaNovFA==
X-Google-Smtp-Source: ABdhPJxfrQVQDk1A0hJljlXTR/40r15qonzvIABkQ+QNdsonSUnyTjpbtsbUomDnBDW4ZUxRsTCUBg==
X-Received: by 2002:a05:6000:ca:: with SMTP id q10mr19640747wrx.135.1593112639977;
        Thu, 25 Jun 2020 12:17:19 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p13sm22693983wrn.0.2020.06.25.12.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:17:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RESEND 05/10] regulator: ab8500: Remove unused embedded struct expand_register
Date:   Thu, 25 Jun 2020 20:17:03 +0100
Message-Id: <20200625191708.4014533-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625191708.4014533-1-lee.jones@linaro.org>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used primarily for the AB8540 which lost support in early 2018.
It is now deemed safe to remove this legacy data structure.

Also fixes W=1 issue:

  drivers/regulator/ab8500.c:88: warning: Function parameter or member 'expand_register' not described in 'ab8500_regulator_info'

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/ab8500.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 716ca5bb178e7..47b8b6f7b5715 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -59,6 +59,7 @@ struct ab8500_shared_mode {
  * @voltage_bank: bank to control regulator voltage
  * @voltage_reg: register to control regulator voltage
  * @voltage_mask: mask to control regulator voltage
+ * @expand_register: 
  */
 struct ab8500_regulator_info {
 	struct device		*dev;
@@ -79,12 +80,6 @@ struct ab8500_regulator_info {
 	u8 voltage_bank;
 	u8 voltage_reg;
 	u8 voltage_mask;
-	struct {
-		u8 voltage_limit;
-		u8 voltage_bank;
-		u8 voltage_reg;
-		u8 voltage_mask;
-	} expand_register;
 };
 
 /* voltage tables for the vauxn/vintcore supplies */
-- 
2.25.1

