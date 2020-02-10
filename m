Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC76C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6ECF2085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340377;
	bh=kIFTEBfA3dx7yd2p+vy1SVGpsCsAblpfc3uwi/4hlZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sy9assu9Qx74GFZMUeMHAGNDKwuLaDCmkclOM9yzm4E62QDCbecssDqhTYrUz7yQO
	 j/bdO8zbcjfkzUwZgLD/bjzEOFbPZIg42TWoeCNOl23VkkfRxOsi3i00N2NBQFiINd
	 BNMwQaMewHuIB4EiblB0vHho/NKL5oz9CbvvCvZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgBJNM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:12:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbgBJMiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:46 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 140B520838;
        Mon, 10 Feb 2020 12:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338326;
        bh=kIFTEBfA3dx7yd2p+vy1SVGpsCsAblpfc3uwi/4hlZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWuXXOHJtOtd4offod/FghRdKRLpqkPIj4s9qrsGTNJdQ6PBeZUd43czLZgpy9fCH
         aXXCoxr8Cx6W/zXMbLgJ/MaREcsSsPTRR6QNfYy/N29/4c3KMS7kV/CTjoEBBWUR2g
         QHWlMTERozzjOMdq1NKcahvvzTtiVnD5w8Xiatbw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH 5.4 261/309] regulator: core: Add regulator_is_equal() helper
Date:   Mon, 10 Feb 2020 04:33:37 -0800
Message-Id: <20200210122431.731980081@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Vasut <marex@denx.de>

commit b059b7e0ec3208ff1e17cff6387d75a9fbab4e02 upstream.

Add regulator_is_equal() helper to compare whether two regulators are
the same. This is useful for checking whether two separate regulators
in a driver are actually the same supply.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Igor Opaniuk <igor.opaniuk@toradex.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Link: https://lore.kernel.org/r/20191220164450.1395038-1-marex@denx.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/regulator/helpers.c        |   14 ++++++++++++++
 include/linux/regulator/consumer.h |    7 +++++++
 2 files changed, 21 insertions(+)

--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -13,6 +13,8 @@
 #include <linux/regulator/driver.h>
 #include <linux/module.h>
 
+#include "internal.h"
+
 /**
  * regulator_is_enabled_regmap - standard is_enabled() for regmap users
  *
@@ -881,3 +883,15 @@ void regulator_bulk_set_supply_names(str
 		consumers[i].supply = supply_names[i];
 }
 EXPORT_SYMBOL_GPL(regulator_bulk_set_supply_names);
+
+/**
+ * regulator_is_equal - test whether two regulators are the same
+ *
+ * @reg1: first regulator to operate on
+ * @reg2: second regulator to operate on
+ */
+bool regulator_is_equal(struct regulator *reg1, struct regulator *reg2)
+{
+	return reg1->rdev == reg2->rdev;
+}
+EXPORT_SYMBOL_GPL(regulator_is_equal);
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -287,6 +287,8 @@ void regulator_bulk_set_supply_names(str
 				     const char *const *supply_names,
 				     unsigned int num_supplies);
 
+bool regulator_is_equal(struct regulator *reg1, struct regulator *reg2);
+
 #else
 
 /*
@@ -593,6 +595,11 @@ regulator_bulk_set_supply_names(struct r
 {
 }
 
+static inline bool
+regulator_is_equal(struct regulator *reg1, struct regulator *reg2);
+{
+	return false;
+}
 #endif
 
 static inline int regulator_set_voltage_triplet(struct regulator *regulator,


