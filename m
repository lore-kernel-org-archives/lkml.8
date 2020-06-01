Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6D4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B095720734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="atYes5mI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgFAH6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgFAH6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:58:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE01C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 00:58:03 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f185so10357326wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 00:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aHaMG/LcTW8EXYS3SNQHIu43prrk95wtOZmYnSKTFQ4=;
        b=atYes5mIyjlRbVHdvzGM1I/CDl4VxCvjVUBYUFQuy7QLyh/oT3F6m5NtvV+1NNSaYp
         LTBJ9DNCWpdCxP+ec2l2xULkY0WX3W3y8x20ElrWQDQkaHmxg1q46IN5Hs2dX9gwVFTR
         RRfMP6a59XIWzoSQ+JPE1SYZlIMjq65HYW1poQ1JmRXb0s1XDNfHVLQz8i7KHi/LHpWh
         W/KOy81KX57U+5mz0sPCiS3/to9Vl9BW745qVAcBCfBkxoHqwyoralmny312BbgnWtHj
         131G6EaTausCRk2S1nEnxFJq75pphj340oiktMoIO+09ZO8gqsxY4GT92LGZ37NzxSur
         24UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aHaMG/LcTW8EXYS3SNQHIu43prrk95wtOZmYnSKTFQ4=;
        b=WMFhAD6OAyMFYoorLnPEM4XSnWGv6j22CVH0bPl2J2NqTsEXF8yeWgh/WFSmt4KaJ1
         F9SyyTCw8CYRXTYeGPXraovHrSgPJimHolBnnH7JyKEX2YgnawXlZtSxd+DgRtCxOoyq
         bMkeZKYfw+qhUDE/cR9SrYw++gJ6qBw/XKebacD05lMHXPO9bOaYOFzylxOgdUdqvmUJ
         w2f5VtyBrk6oCPa8KNaUN4W+N2MbiwF+cg/o8EtMG2y02cCjMDMPai6Oke1Qt1u//oKI
         jth/LvSjl5jBw3z1vFBzLI+a/6yavve83uSCjix5lJItrEuFIJ0Uuv/UhRg8bubLPd0h
         uGfg==
X-Gm-Message-State: AOAM533I9I8X2vc5y9gENZJYDzBtiVgL01rptnpuom6b/riOWwnQ1l8y
        GR5SGAZE1NCFsSUVISY21E9Flg==
X-Google-Smtp-Source: ABdhPJwBL+9VeNnuy+h5Ha8dHLrquA9kkCjNVD2kimhAgYhU89M29CFzDiuEBvb92pUZeYO4ZwpYVA==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr20783159wmh.93.1590998281769;
        Mon, 01 Jun 2020 00:58:01 -0700 (PDT)
Received: from localhost.localdomain ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id c16sm14141486wrx.4.2020.06.01.00.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 00:58:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gene_chen@richtek.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 1/1] mfd: mt6360: Remove duplicate REGMAP_IRQ_REG_LINE() entry
Date:   Mon,  1 Jun 2020 08:57:54 +0100
Message-Id: <20200601075754.49697-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following build warning:

  >> drivers/mfd/mt6360-core.c:148:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
  REGMAP_IRQ_REG_LINE(MT6360_CHG_TREG_EVT, 8),
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  include/linux/regmap.h:1191:10: note: expanded from macro 'REGMAP_IRQ_REG_LINE'
  [_id] = {                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/mfd/mt6360-core.c:124:2: note: previous initialization is here
  REGMAP_IRQ_REG_LINE(MT6360_CHG_TREG_EVT, 8),
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  include/linux/regmap.h:1191:10: note: expanded from macro 'REGMAP_IRQ_REG_LINE'
  [_id] = {                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  1 warning generated.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 9bb63e0b69e6a..db8cdf5272c1f 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -145,7 +145,6 @@ static const struct regmap_irq mt6360_pmu_irqs[] =  {
 	REGMAP_IRQ_REG_LINE(MT6360_CHG_TERMI, 8),
 	REGMAP_IRQ_REG_LINE(MT6360_CHG_IEOCI, 8),
 	REGMAP_IRQ_REG_LINE(MT6360_PUMPX_DONEI, 8),
-	REGMAP_IRQ_REG_LINE(MT6360_CHG_TREG_EVT, 8),
 	REGMAP_IRQ_REG_LINE(MT6360_BAT_OVP_ADC_EVT, 8),
 	REGMAP_IRQ_REG_LINE(MT6360_TYPEC_OTP_EVT, 8),
 	REGMAP_IRQ_REG_LINE(MT6360_ADC_WAKEUP_EVT, 8),
-- 
2.25.1

