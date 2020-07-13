Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F27C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 559E5207BC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DbeFOb5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgGMOvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbgGMOtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA035C08C5DE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so16885366wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+J7h3HQX+/joqPOy6WiQHR4eToAn/yJ8zMEtEk80iA=;
        b=DbeFOb5vGhFBYRRXUN3KuTiXpQyQb3lNhA1qOhQUiHC1bngSe4WmjRro0MewmO5SvA
         nU2LN9gEPVX+pqlbP3P/6gx85OWfPOTlSSL5eIOSiqO+xx8m+3sk/8jDl1P5ToG6v4iV
         xzohAIXFSKqEnzj8P8sAjTkMJDk7vXufjDAJNitdG7U7ZqCNMd1cw71tgP5dsF4+neFo
         4QGFwMEkoZgQreEWsEAO1Apoc2zj4HTbRKtE03gaHTRxV/xqxVbhULD+La1zvby6h47N
         q6x3zcpwTLs4SEtqV+P488sD/Q7iBq7XP+vpVTEANGL4+8Bk9dQJGqkYc5Ttqy1ae81V
         zmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+J7h3HQX+/joqPOy6WiQHR4eToAn/yJ8zMEtEk80iA=;
        b=GnVyPOBKMw4+2hhEJg8b7mX6/yzRveKuMapSbLepH1qgKoZA5UR/XqXq+z8oRP0JZ6
         Z24K0D34+1/86VnwmB77SBtt+N/YPdeSAm1NBnQb+ZHsLlGutjvpwaGtYOEMSIrUToXj
         OZ+0t/9Ov8uCrnwUzKtToTcw2tCfCWi3cbYMOVuixAZmM+r33x+D0QyorhV98b+6v9dv
         7XGcIba0SaOH050jm3Fj6da0ylcDhEr3UCY/N/jGkP7LBj3v1FKbGcuVe5exI38VXUY0
         app1KFoHA4J4utUSJavjY+msJw/qZhCMRxChHezpt+oBftaPMHOvJ7tnT6N92x2X/oBL
         GsCA==
X-Gm-Message-State: AOAM532qzQHdgpit3UfTosJg5q0zHqV1MBT3KznbxzXUKtaB7/zYwkQx
        f5PQB0nypbnNqRfujMg7ZT+2Ew==
X-Google-Smtp-Source: ABdhPJynb3r4L6mscx+7FfoIIg3IVDr+bEskwUShaCmWgKsXhKMf81Y2wb/k1/OuQoXOJOxjXBXLpg==
X-Received: by 2002:adf:e3c5:: with SMTP id k5mr80764064wrm.121.1594651780552;
        Mon, 13 Jul 2020 07:49:40 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 07/25] pinctrl: samsung: pinctrl-s3c24xx: Fix formatting issues
Date:   Mon, 13 Jul 2020 15:49:12 +0100
Message-Id: <20200713144930.1034632-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc struct titles must be followed by whitespace.  Also attributes
need to be in the format '@.*: ' else the checker gets confused.

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/samsung/pinctrl-s3c24xx.c:100: warning: cannot understand function prototype: 'struct s3c24xx_eint_domain_data '

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
index 9bd0a3de101dd..5e24838a582f5 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
@@ -80,7 +80,7 @@ static const struct samsung_pin_bank_type bank_type_2bit = {
 	}
 
 /**
- * struct s3c24xx_eint_data: EINT common data
+ * struct s3c24xx_eint_data - EINT common data
  * @drvdata: pin controller driver data
  * @domains: IRQ domains of particular EINT interrupts
  * @parents: mapped parent irqs in the main interrupt controller
@@ -92,10 +92,10 @@ struct s3c24xx_eint_data {
 };
 
 /**
- * struct s3c24xx_eint_domain_data: per irq-domain data
+ * struct s3c24xx_eint_domain_data - per irq-domain data
  * @bank: pin bank related to the domain
  * @eint_data: common data
- * eint0_3_parent_only: live eints 0-3 only in the main intc
+ * @eint0_3_parent_only: live eints 0-3 only in the main intc
  */
 struct s3c24xx_eint_domain_data {
 	struct samsung_pin_bank *bank;
-- 
2.25.1

