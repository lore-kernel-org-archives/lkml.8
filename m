Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4482C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E09A206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNeqMFnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgFVDKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgFVDK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 23:10:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A8C061794;
        Sun, 21 Jun 2020 20:10:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so3545909wmm.0;
        Sun, 21 Jun 2020 20:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KaJJanZVJWZSvXqCSXtZ01YBvvSbfqMJxJAq4m8RlJ4=;
        b=VNeqMFnCbwSDhvSCFusejCiUhY+v5LZqCDBVNZje9D1IEEtEkcxeteRTy8tVy9l+mx
         vSRdmMpsr3gi37oT2S1aG4EoNGUD3BzIue7rxm9mwxva/939hEnI80BYzJZ9Za701Y1Y
         5tc3Y6TURIOCEG4KTQzvj2d0Qe+hJo4l8fEiKGSKhyZkOJpgetkLOFazmrN/m0NYtTUa
         j/Uc1ICNpneSm8ibtkR5Xwd0xsszxwgegINScmDJAEe2onCrZAwv9M4y914h7kQBUwIq
         RQA5x+uJBccVCu+FwG4ztwbNfIPu0/zowaGIXWSxZH+CpP7jmP4wkkggdUQlCrHASpW8
         i83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KaJJanZVJWZSvXqCSXtZ01YBvvSbfqMJxJAq4m8RlJ4=;
        b=Cn6H+Ly7tNxDF8+TTdAcVfzXoX2o28yv9dDsC5Ymg51d0fIJ7nIiLUwJItVYnBO1Jh
         cSs8/QKfPvsx+ekPhT0aF5tJiO66/fZHJ/joOI3/JEG+DreHp9TxLquameo+I+HHqt5p
         mUo31ZY0Cc/OAF5JtGsIpbnvSgkgsuxqDSYCVRZ4ICugHoAOnMrz9zv4YAN/D8eQ05la
         j7HiLGoRUgNv1R0dwHVmyk30xMp1Syk8EobFZrVKR79Vc3/gxC0t0PrDdiBOf06kKKkp
         xNJrYlI4abs/FmJOSg39/3g0pgBu0zEFOoEEYTORRRmXpaXawZtrkGtxSqb7Yqosv0lp
         qsDg==
X-Gm-Message-State: AOAM5319WhMdk6x4AVeUrqYHSWDDWJeKg6h+kXRxCgHVf+DWsZ8DXQ/u
        o7xx2yarfoHxW5JFQnGFrliunpXw8SI=
X-Google-Smtp-Source: ABdhPJyO/HF2psz8EfCJjptSfq+BtoUhvsimoiOXrkuKyF8rU5I6IzwFBNCoetjrXbGXngkpnnPsNg==
X-Received: by 2002:a1c:8048:: with SMTP id b69mr15645697wmd.169.1592795427324;
        Sun, 21 Jun 2020 20:10:27 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id y196sm10031766wmd.11.2020.06.21.20.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 20:10:26 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     devicetree-compiler@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 2/2] checks: Improve i2c reg property checking
Date:   Mon, 22 Jun 2020 12:40:05 +0930
Message-Id: <20200622031005.1890039-3-joel@jms.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622031005.1890039-1-joel@jms.id.au>
References: <20200622031005.1890039-1-joel@jms.id.au>
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
v2: Mask reg when checking the 10-bit size
v3: Fix test
v4: Add U to define
---
 checks.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/checks.c b/checks.c
index 69b0156c940c..b7955dbd71ca 100644
--- a/checks.c
+++ b/checks.c
@@ -1023,6 +1023,7 @@ static void check_i2c_bus_bridge(struct check *c, struct dt_info *dti, struct no
 WARNING(i2c_bus_bridge, check_i2c_bus_bridge, NULL, &addr_size_cells);
 
 #define I2C_OWN_SLAVE_ADDRESS	(1U << 30)
+#define I2C_TEN_BIT_ADDRESS	(1U << 31)
 
 static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node *node)
 {
@@ -1057,10 +1058,13 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
 		reg = fdt32_to_cpu(*(cells++));
 		/* Ignore I2C_OWN_SLAVE_ADDRESS */
 		reg &= ~I2C_OWN_SLAVE_ADDRESS;
-		if (reg > 0x3ff)
+
+		if ((reg & I2C_TEN_BIT_ADDRESS) && ((reg & ~I2C_TEN_BIT_ADDRESS) > 0x3ff))
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
2.27.0

