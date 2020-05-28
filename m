Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA432C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901592088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDqXkI65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgE1I5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgE1I5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:57:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9786C05BD1E;
        Thu, 28 May 2020 01:57:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id z15so1949973pjb.0;
        Thu, 28 May 2020 01:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FiQqSNUhCv6yJ3YkfxLNYN6qXN3BR0Yb2SyZoRmzP9o=;
        b=EDqXkI65SLQMoAOITz86Yxcoph6Sm2WTA+w9n1plLRKoNfQplFbko+wAKfzLEPcL+2
         VwVZzEPeDJO7FRDtfcJITX/uSWxdlmNw8trGKewhNATvhFqF5BzTDhw5LTnI1C4A2xhJ
         G+7I2gbkt3f7g/e78L9K0UsyxkorrqOgyi/Ct1pS4sabqXEBk1LaKxrb4KtbLgkiBx7B
         J/kz4kJFl/UdBHkQW6C+m8UmthCmbN7tlpDt3IxhOZDgaXv673aLWxx0JpG/cAEWweTA
         zdU77WZsTx0NQrffd+slKGdsuiDCzX1S+e0HXPcyWCdbeOnRnecaGKTdoahP5IbIDFe8
         BwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FiQqSNUhCv6yJ3YkfxLNYN6qXN3BR0Yb2SyZoRmzP9o=;
        b=m9+7Q32zQESCfsEXCCTmryzYlpfNEP0iCJe/3jFD1dJGQPehwPvjrAJ+GiB8nT4e3j
         UmsaMkvT2WxzypZsvsqV9QF3RlyVGtrb7rlBaGGh7dBVS1H6p/kMtz/BXlMS20jMCF/s
         XGIfoMHyQ6IaZtuJdt/2NR46+g6Gu5hOFLWEjfE5Vst2LtxBhZRy8vFuCkAn9eyFXvB7
         KZN//vxFptNf+AdAYDxotF/R75ZkQzzh9MgsybzEcJhb/qMxS/x9smIJ7c7fWqvTJB0/
         xtgTxPoRuA3+RV3lA/V3tTM/njGq10TepX13I48AuUwZvmJ79K850VrgnKaiDiUwJKyW
         4o0g==
X-Gm-Message-State: AOAM531xK7hwfrMjaRIGqFdXkT3plKgPHozNQLGBHy9y9qybpDHir9Tf
        6nithCJmtAdU8ZWghM6EpxTFeLBO
X-Google-Smtp-Source: ABdhPJw3zrOIlvkKzixIB9bi2VMQRaBmBRGelcUiVliXzZOlNm79TbSqXAwvCvjmJvjdU7UJa4fK5w==
X-Received: by 2002:a17:90a:30ef:: with SMTP id h102mr2694518pjb.110.1590656223693;
        Thu, 28 May 2020 01:57:03 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id b4sm4066413pfo.140.2020.05.28.01.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 01:57:02 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     devicetree-compiler@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 1/2] checks: Remove warning for I2C_OWN_SLAVE_ADDRESS
Date:   Thu, 28 May 2020 18:26:49 +0930
Message-Id: <20200528085650.1417942-2-joel@jms.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528085650.1417942-1-joel@jms.id.au>
References: <20200528085650.1417942-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtc does a sanity check on reg properties that they are within the 10
bit address range for i2c slave addresses. In the case of multi-master
buses or devices that act as a slave, the binding may describe an
address that the bus will listen on as a device. Do not warn when this
flag is set.

See Documentation/devicetree/bindings/i2c/i2c.txt.

This fixes the following build warnings reported by Stephen and by Arnd:

arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:126.11-130.4:
  Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@80/ipmb1@10:
    I2C bus unit address format error, expected "40000010"
arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts:128.3-30:
  Warning (i2c_bus_reg): /ahb/apb/bus@1e78a000/i2c-bus@80/ipmb1@10:reg:
    I2C address must be less than 10-bits, got "0x40000010"

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Fix typo
---
 checks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/checks.c b/checks.c
index a8213c0e13a8..feb1721f2603 100644
--- a/checks.c
+++ b/checks.c
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
+	/* Ignore I2C_OWN_SLAVE_ADDRESS */
+	reg &= ~I2C_OWN_SLAVE_ADDRESS;
 	snprintf(unit_addr, sizeof(unit_addr), "%x", reg);
 	if (!streq(unitname, unit_addr))
 		FAIL(c, dti, node, "I2C bus unit address format error, expected \"%s\"",
@@ -1051,6 +1055,8 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
 
 	for (len = prop->val.len; len > 0; len -= 4) {
 		reg = fdt32_to_cpu(*(cells++));
+		/* Ignore I2C_OWN_SLAVE_ADDRESS */
+		reg &= ~I2C_OWN_SLAVE_ADDRESS;
 		if (reg > 0x3ff)
 			FAIL_PROP(c, dti, node, prop, "I2C address must be less than 10-bits, got \"0x%x\"",
 				  reg);
-- 
2.26.2

