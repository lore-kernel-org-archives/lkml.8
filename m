Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26B9C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B2721974
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqH4kh2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgEHGjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727071AbgEHGjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:39:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2111FC05BD43;
        Thu,  7 May 2020 23:39:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so442677pfn.5;
        Thu, 07 May 2020 23:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4aQlSgO0Elh0LQFz4EdrUrM6btXVzv3njgKIJHFMY3A=;
        b=fqH4kh2pc7Zm5xI9ma42CYbrngTvtTiiEy7mkfbS9jsJuLN24ngPBYnA4FxKtssdUW
         04aV6fyqzFV3FCS2lKkaiSxuSbqNDH5L/LWkWrN74qgPVOoyZHs1YDDKuz1SPr6E9J4m
         JK/uuJauH90bvJ/8hSHIo72eOfy08MIe8WRALTsnYCBipNK+wPGgByJ/j0sSGDF7lvMz
         59klzb/Uuc2JPl0wMIoCLnWaH9goX3g1MYsq3jWA+2h3CY5MuMIVhhNC3ohL5M9uGsRm
         NB5al4LOsWgZolzFGhfKzqeN/OMYKun0J3ByMF/hAfIEsD0QCwI5sSHWFruWlngdRIWd
         snKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=4aQlSgO0Elh0LQFz4EdrUrM6btXVzv3njgKIJHFMY3A=;
        b=RyLbrveKnK2QLOYMFAqwJrqXV4fKgWAHNcPw/M/dxLMY0ll5sKhvggv+nHjnOzX5uG
         et0hkq1Z+gbDkjRmTOjGafQ/A0MsQ/QjFuOPJJwAv3H4KhxY5xyMBgpjd9Iu0hu9UP49
         WWO901tRQrzc3ZG78mmEB0hotkD94fqNXWdrIZazlLrJw8tWHVW82vzg5tMZIYBRm3Aq
         hraUjU6m2PIuOk15SAgfMhlct0ZkRKBYFTdtZtNjSbWxikVE4WdNzh+O2PEMquxOQ2uD
         sFALzD3+vy1z4fq9+0DYqjps7sGb3jAGYv/wElwgNw++DhFo2o9HSfggmnw0+1k2uSzR
         bzyQ==
X-Gm-Message-State: AGi0PubqRQ5gwUD9zuPFiHxzA+V5Qjtmh08cpj4kKF349zKhB5wh9ygR
        FeaNQhJCft0ueyey+sBZ/wCnft5G
X-Google-Smtp-Source: APiQypLQfREFkfCiTZTKfTnNytxjyVvXbyfxeaa0IMd44kGxgxvh/rgY7LDEjnXYez0t65A8tLeNjw==
X-Received: by 2002:a63:a505:: with SMTP id n5mr897719pgf.173.1588919956500;
        Thu, 07 May 2020 23:39:16 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id k24sm712913pfk.134.2020.05.07.23.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 23:39:15 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH] dtc: Remove warning for I2C_OWN_SLAVE_ADDRESS
Date:   Fri,  8 May 2020 16:09:04 +0930
Message-Id: <20200508063904.60162-1-joel@jms.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtc does a sanity check on reg properties that they are within the 10
bit address range for i2c slave addresses. In the case of multi-master
buses the binding may describe an address that the bus will listen on as
a device. Do not warn when this flag is set.

This fixes the following build warnings reported by Stephen:

arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:126.11-130.4:
  Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@80/ipmb1@10:
    I2C bus unit address format error, expected "40000010"
arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:128.3-30:
  Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@80/ipmb1@10:reg:
    I2C address must be less than 10-bits, got "0x40000010"

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 scripts/dtc/checks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index 4b3c486f1399..986754f858cf 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -1022,6 +1022,8 @@ static void check_i2c_bus_bridge(struct check *c, struct dt_info *dti, struct no
 }
 WARNING(i2c_bus_bridge, check_i2c_bus_bridge, NULL, &addr_size_cells);
 
+#define I2C_OWN_SLAVE_ADDRESS	(1 << 30)
+
 static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node *node)
 {
 	struct property *prop;
@@ -1044,6 +1046,8 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
 	}
 
 	reg = fdt32_to_cpu(*cells);
+	/* Ingore I2C_OWN_SLAVE_ADDRESS */
+	reg &= ~I2C_OWN_SLAVE_ADDRESS;
 	snprintf(unit_addr, sizeof(unit_addr), "%x", reg);
 	if (!streq(unitname, unit_addr))
 		FAIL(c, dti, node, "I2C bus unit address format error, expected \"%s\"",
@@ -1051,6 +1055,8 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
 
 	for (len = prop->val.len; len > 0; len -= 4) {
 		reg = fdt32_to_cpu(*(cells++));
+		/* Ingore I2C_OWN_SLAVE_ADDRESS */
+		reg &= ~I2C_OWN_SLAVE_ADDRESS;
 		if (reg > 0x3ff)
 			FAIL_PROP(c, dti, node, prop, "I2C address must be less than 10-bits, got \"0x%x\"",
 				  reg);
-- 
2.26.2

