Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFCBC433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 23:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6B7206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 23:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7e0AEcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgHIXMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 19:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgHIXMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 19:12:15 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E132C061756;
        Sun,  9 Aug 2020 16:12:15 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h4so1352196ioe.5;
        Sun, 09 Aug 2020 16:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=alLW1LflvonptwdYTfDyuOKeW8wJ3Z5ZzgiFOBxMxyk=;
        b=X7e0AEcJnUFIDHo7POyVpSf7TOVm4D/eHPFU/cJB/W5t+vZHgZ4uZtakf83tv0AqeL
         0pKL0DAW5WcoTaS93o/nwwdkvLx+/RIoND6TdllMy06dsk4WZ8O+tEtK9Hf/ieIPeabd
         arznZdwbsjXEPq38fU4o4tGShHp7YrhPGdJMNHNbyIM+ms67txYmkNo7lKELoQU0jsZo
         tSF5mgkLuwmXlE/ScSBIe3sO2EcZe0yFBdyKQ2B538eetKfVsGwBGASIpEDR2qpu7QC7
         dJjHycfFPTL2OLfDU69LdQT3oLF0I7+3X4NwwZGjCeuAxPdEWRuqDkshW19xH5iC72rR
         m3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=alLW1LflvonptwdYTfDyuOKeW8wJ3Z5ZzgiFOBxMxyk=;
        b=pnWZf8rWczc82iMWVvwH1Fhqxj4siEHnTMm4kpC3X/tLWXhTuJFoCQdWGWc8iOn3Sx
         9a1Sar2EQAI+g/q3UUkVqT+l+bl7+7+V/AlgRJKJ9Jpshuayd/C6t9wabbfq+lzv1O11
         BfieeQQM4z2gZ9AZjw2DCALvf9ZcKfP9Ig33FaEt2pAA1GVFxdhdIlKCBHFK7oHGLFoO
         92o9AwbcGb2z4EBSjVLld8rOGur21ZOx7GHfXP8CB3Tm2sr6kOroL6GCXnJAVNR9pUS9
         ZurdfNv1Jlr3vPFb6LEvYZ8LWdIO+f5yyYmSldqJ07R+onp/LkxaOPAjzlICmD2v78iS
         CaWw==
X-Gm-Message-State: AOAM531SmURniQSvitj4OlWyffDZj6Sjr6Kfw8jxnKPwAlAIKqQGqxKf
        DQm2C7rZ6c+ImzZ85YP2MOQ=
X-Google-Smtp-Source: ABdhPJxTbP0h5ErtS32xUstdlrrQQtL2dX0QriUiD0MU/qrT2T/EEbDpS+ECoXs/pQTaxfBXJMtMOA==
X-Received: by 2002:a05:6638:27a:: with SMTP id x26mr16766464jaq.43.1597014734889;
        Sun, 09 Aug 2020 16:12:14 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [160.94.145.20])
        by smtp.googlemail.com with ESMTPSA id r6sm10219198iod.7.2020.08.09.16.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 16:12:14 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu
Subject: [PATCH] clk: bcm2835: add missing release if devm_clk_hw_register fails
Date:   Sun,  9 Aug 2020 18:11:58 -0500
Message-Id: <20200809231202.15811-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of bcm2835_register_pll(), the allocated pll is
leaked if devm_clk_hw_register() fails to register hw. Release pll if
devm_clk_hw_register() fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/clk/bcm/clk-bcm2835.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 6bb7efa12037..12b950d50252 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1321,8 +1321,10 @@ static struct clk_hw *bcm2835_register_pll(struct bcm2835_cprman *cprman,
 	pll->hw.init = &init;
 
 	ret = devm_clk_hw_register(cprman->dev, &pll->hw);
-	if (ret)
+	if (ret) {
+		kfree(pll);
 		return NULL;
+	}
 	return &pll->hw;
 }
 
-- 
2.17.1

