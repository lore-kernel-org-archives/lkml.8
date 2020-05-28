Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46187C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17ECF207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhR+1zWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgE1HVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1HVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:21:00 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C532AC05BD1E;
        Thu, 28 May 2020 00:21:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z26so13041191pfk.12;
        Thu, 28 May 2020 00:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ryuz+C4ZtidMwm5FjjGM01dAMBffdLgppU31KEJ6Tc0=;
        b=lhR+1zWhr9a8uhd0kNSmfm5wFT3E29IBnJy9nksaZzikQN7kzi+hYduYBFLKbod/tU
         5UaW5Ki44BJjTvl86HCDOoiZQ9t6b2NavbyuhdL1WuN0kqX4mX3spYyy4MgaNHJ6VsfF
         gaUxfwZrt4kWXLmP0TJDIvjs8sT2tdDZQXDHbN9yQuj+BTba4EWYb2E4o/7KOd1pcswf
         WzOkIBHy4kmkC6iF/K7wswXX5VLbrdlPtoVDSAlkEWqypBSDjexgs1pxG+tZ+k5qg+JA
         p1Oe0F9DZDCRb4pgJ89fzKW81Ck/bb+0wAmosm7diBz+fdHnyMcCvPpaS18BDlEyTaYu
         2y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ryuz+C4ZtidMwm5FjjGM01dAMBffdLgppU31KEJ6Tc0=;
        b=UOiobhZ6AaZWoVQRrkSJ/yFQq3e53IYfPqDguSu5mI2ROJQ8FNB2U1pWBUhMS8cwCa
         Q9PUp+cuBHm9eALiFSCo9aW07iWWTYu9VM7TdsujyNnADfGHLGbyYY1unO/VNQGQcIMt
         oKxxMH4qkhNgIRGOw+qjOgpQJDIyAc9r/pEmNEDmaW4OZjDQhLwYPJ5od+NAIK58TfLd
         bH68tpubCrKodyT7J0XAZGawmu7qmdWvevgSdK008gRbp2FT+U83pbCbVkyLidcQwNwt
         7MvzVoNlsazhbEE8xTnkGdCeNdy7WrmWXpnpv0ECG87Jw+xZAfH1XO2sRwVjijutJtii
         5uuw==
X-Gm-Message-State: AOAM531rgg1YQDKETr3pTNXH464cCCXnjj6ef/xk6A14ncVln8Dopck4
        JXeAIZHeavExIGwHVdqEWuybDXVC
X-Google-Smtp-Source: ABdhPJw57hac0E7QovXAlNzQiPLTnsK6Xfr4uXeW57alkV1TYKy7uk5HyF/y4HGhfZuaLEJVpfoCfA==
X-Received: by 2002:a63:205e:: with SMTP id r30mr1604745pgm.385.1590650459790;
        Thu, 28 May 2020 00:20:59 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id k2sm4090628pfd.108.2020.05.28.00.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 00:20:59 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     devicetree-compiler@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 2/2] checks: Improve i2c reg property checking
Date:   Thu, 28 May 2020 16:50:37 +0930
Message-Id: <20200528072037.1402346-3-joel@jms.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528072037.1402346-1-joel@jms.id.au>
References: <20200528072037.1402346-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c bindings in the kernel tree describe support for 10 bit
addressing, which must be indicated with the I2C_TEN_BIT_ADDRESS flag.
When this is set the address can be up to 10 bits. When it is not set
the address is a maximum of 7 bits.

See Documentation/devicetree/bindings/i2c/i2c.txt.

Take into account this flag when checking the address is valid.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 checks.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/checks.c b/checks.c
index feb1721f2603..2d98a468f878 100644
--- a/checks.c
+++ b/checks.c
@@ -1023,6 +1023,7 @@ static void check_i2c_bus_bridge(struct check *c, struct dt_info *dti, struct no
 WARNING(i2c_bus_bridge, check_i2c_bus_bridge, NULL, &addr_size_cells);
 
 #define I2C_OWN_SLAVE_ADDRESS	(1 << 30)
+#define I2C_TEN_BIT_ADDRESS	(1 << 31)
 
 static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node *node)
 {
@@ -1057,10 +1058,13 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
 		reg = fdt32_to_cpu(*(cells++));
 		/* Ignore I2C_OWN_SLAVE_ADDRESS */
 		reg &= ~I2C_OWN_SLAVE_ADDRESS;
-		if (reg > 0x3ff)
+
+		if ((reg & I2C_TEN_BIT_ADDRESS) && reg > 0x3ff)
 			FAIL_PROP(c, dti, node, prop, "I2C address must be less than 10-bits, got \"0x%x\"",
 				  reg);
-
+		else if (reg > 0x7f)
+			FAIL_PROP(c, dti, node, prop, "I2C address must be less than 7-bits, got \"0x%x\". Set I2C_TEN_BIT_ADDRESS for 10 bit addresses or fix the property",
+				  reg);
 	}
 }
 WARNING(i2c_bus_reg, check_i2c_bus_reg, NULL, &reg_format, &i2c_bus_bridge);
-- 
2.26.2

