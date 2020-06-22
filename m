Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8652C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 874DB20679
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGdnrq/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbgFVDK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgFVDKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 23:10:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BE5C061794;
        Sun, 21 Jun 2020 20:10:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so15111957wru.0;
        Sun, 21 Jun 2020 20:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c949isyo7HKGnW1Ad1cAo7HT25ekL/Ae8OWsa7R3Ws0=;
        b=PGdnrq/Yi5lFlYXeausei2Zw5XttyDz2AR2Mk7PlmENHhi74J8zaU5B0BHk/J6AeDs
         7gp53pLzw3Eq3iZTn8VO3iaZ5FI5149iZCuKuYauOBg8tyQplM4ezGXc2zC6oWmJiwkW
         KVdG/nA+dATz2WirwgPA86cynecvGh2ONVNbVa7m3LUOYQT9/U/zE5DHCTU6/8h0zuUa
         Ndtfl/UfDnF8bsqCN1HRZu8HD0rAJjPTyHEyr/gv/ulplWW+y4anJUNRwdBdNJ6x2LA3
         Y3yPLS6q50RQYTEx1J9jpDbAyaVFWH+5ZZ/OunJ4cDitmaVwFBgtRymHUVtOYAur9gF3
         NAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=c949isyo7HKGnW1Ad1cAo7HT25ekL/Ae8OWsa7R3Ws0=;
        b=aZ7wjPuSSHsHdqAm9VegImM5ueEsS/bhz0qxslzZgyF8JO0WI+n8CwyoiiZmotrUQM
         Gpglt2i3joi6hz/XsSqNWCPUv6W3fwaSSwI9H4RSBQH/dZePiysUDuW9nZpXBAD8a6ht
         c3N23FqZTVyjnDaLtZB6XEF7Z9EzfOSHIMkqLCGJOlm05eNcujJncVn5TpLbN9Hs0p/d
         RvXLRhfzewKxyIZB57b6W++D1N1Z+g3glGqGzwM1ghgHkjllXGJPkcpyhpHlQzLP9Tkx
         MAtJEH1TKUD3UQNj42Ok04Xit9wY2tx1plKd3PExbokCP+8MQGaZw1rM6e9LcuzfI1zU
         Xc5g==
X-Gm-Message-State: AOAM531aETjVYEQ6e47WhRjJOzVMzczYF96ao8+x8hU7xMby0p/LjRLy
        DNN8wkpJ6dB3/305oyEPeu2cLnIcH6U=
X-Google-Smtp-Source: ABdhPJyPgBd+Mb1rCFM/kw76zYWZOtvB3xDCUIlQQklWWUnGVrYV480lUAgbP09Fq2ekZUTkQLcOag==
X-Received: by 2002:a5d:4bc8:: with SMTP id l8mr1241890wrt.159.1592795423922;
        Sun, 21 Jun 2020 20:10:23 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id y196sm10031766wmd.11.2020.06.21.20.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 20:10:23 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     devicetree-compiler@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 1/2] checks: Remove warning for I2C_OWN_SLAVE_ADDRESS
Date:   Mon, 22 Jun 2020 12:40:04 +0930
Message-Id: <20200622031005.1890039-2-joel@jms.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622031005.1890039-1-joel@jms.id.au>
References: <20200622031005.1890039-1-joel@jms.id.au>
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
v4: Add U to define
---
 checks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/checks.c b/checks.c
index a8213c0e13a8..69b0156c940c 100644
--- a/checks.c
+++ b/checks.c
@@ -1022,6 +1022,8 @@ static void check_i2c_bus_bridge(struct check *c, struct dt_info *dti, struct no
 }
 WARNING(i2c_bus_bridge, check_i2c_bus_bridge, NULL, &addr_size_cells);
 
+#define I2C_OWN_SLAVE_ADDRESS	(1U << 30)
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
2.27.0

