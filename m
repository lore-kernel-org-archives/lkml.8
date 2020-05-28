Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23A9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E3C2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTfXy5NB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgE1I5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgE1I5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:57:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871B3C05BD1E;
        Thu, 28 May 2020 01:57:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d3so11324207pln.1;
        Thu, 28 May 2020 01:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MQKunO301mb0ILEr+NPZgO7bp9n1H6FfQ2srvINBCOE=;
        b=MTfXy5NBwQf8yerkXWtrjRQ9rtCeEuzfrwW1PRLGWA4DyhwPipNMeAR+vlYDJE/1y2
         QDrg1Juau4oKkjsTjPkdG2pahwMG0lsvCagY+HTuA+/6abq4Un+n7NvNwsBeL4goY8tz
         vCf/e/RXXyAFbFAZyYgOuo2iqqV0wDnpNl9a6y3kINwVCXYzUWoY8Cyk08TdPW982szN
         bTUX2SArTO8QtmBG2bCo2JJpxIjvpQ27e5XQZorTqRdvxmKf3vie4b3Fh+3OPrUETkFi
         HAxGLgIk7yPlD520GBnC0//VFasCTGpM40S/lTWANmLqGrveFS7oBeYMxp4GRVJ7D636
         Gpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MQKunO301mb0ILEr+NPZgO7bp9n1H6FfQ2srvINBCOE=;
        b=WiqdR5UbXC9ubN4s3g7J1rxwMn//B2WkINArpJWW/PVNkQwcM6E0qeGqsd0zcb9BFf
         PbE3U2DM9oe/5DCeNb2Y3V2MYXd1+uH2541wrx43zOZU1Zq2rcAH3xselL3K6UkfJsjU
         u/SffgJEKh7TTmHAbIA38FYPiofWvpIBdkofuScQ5+1IIUZ74NT2FeKbwufRbDw4Aiqf
         s7fCjuUtizz13rLQDEBHs/AbaztNwZ3Va2FqYa72mmfneVMjuYIhOyW3vpUJHZsFsfzz
         +9lOTi7hFRkhdj02c1vkwOZvB7QFEBajUl8ITiGaM7P4LedugNMotB+jJRTsreown0ng
         zA2w==
X-Gm-Message-State: AOAM531Kh+nzJcKh+03U4Zo+NQOXJfwuKEyhj2lURvZ+ad73fGBu+ynw
        kaPCbI82hqxiDPNMfFGXLau88gPE
X-Google-Smtp-Source: ABdhPJyZVmiLaj3ggDkKHfGr5te7RaB5qK/pMGlxzj/xvCGEEeYYfsaLwe+z2WhAHaaiuIzUOzeMJA==
X-Received: by 2002:a17:90a:2ac2:: with SMTP id i2mr2627115pjg.80.1590656227534;
        Thu, 28 May 2020 01:57:07 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id b4sm4066413pfo.140.2020.05.28.01.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 01:57:06 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     devicetree-compiler@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 2/2] checks: Improve i2c reg property checking
Date:   Thu, 28 May 2020 18:26:50 +0930
Message-Id: <20200528085650.1417942-3-joel@jms.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528085650.1417942-1-joel@jms.id.au>
References: <20200528085650.1417942-1-joel@jms.id.au>
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
---
 checks.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/checks.c b/checks.c
index feb1721f2603..3fe979a63290 100644
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
2.26.2

