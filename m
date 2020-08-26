Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1091C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995D121741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453353;
	bh=Dex4kuQ58Jrk7YN8qvgLtcRhN0dw9B7yef9ma5nqLPg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hEY+E6Fu788GK5P3bqm/OmKA1Ub7MJIqINT3GvNxSY8fLEIrwsjTPqXCtuf0BfdDE
	 cbVzLOOntHGClfh2C7PzabwMjKMTrVRSuPnq/wd7eDlBQCKOBoZicf/zfi8OJJNwiw
	 VD4Gldu1ADzGmMIcMujHO5m3oFNXA4LtESv133I4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHZOtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:32938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbgHZOtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:49:07 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AC482078D;
        Wed, 26 Aug 2020 14:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453347;
        bh=Dex4kuQ58Jrk7YN8qvgLtcRhN0dw9B7yef9ma5nqLPg=;
        h=From:To:Cc:Subject:Date:From;
        b=q3vz0znEM8dpxcfWXaoMSaWqBR/gJEeZvmy//WjI3XX4R8K2M/zxvzaKEERdpQ6Pq
         MSaxW/cqaAy3NCYGV2iYl/hwjqxdqmWij3jDa2/U4e2x1//C5BNTNfG2BSyNFR5MGu
         gI48cF07qqtQZn3IoupQZmFE+ESjyOQoEI3A7nmQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        David Lechner <david@lechnology.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/5] power: supply: bq27xxx: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:48:54 +0200
Message-Id: <20200826144858.9584-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index a123f6e21f08..617689084ded 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1992,13 +1992,9 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	psy_desc->external_power_changed = bq27xxx_external_power_changed;
 
 	di->bat = power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
-	if (IS_ERR(di->bat)) {
-		if (PTR_ERR(di->bat) == -EPROBE_DEFER)
-			dev_dbg(di->dev, "failed to register battery, deferring probe\n");
-		else
-			dev_err(di->dev, "failed to register battery\n");
-		return PTR_ERR(di->bat);
-	}
+	if (IS_ERR(di->bat))
+		return dev_err_probe(di->dev, PTR_ERR(di->bat),
+				     "failed to register battery\n");
 
 	bq27xxx_battery_settings(di);
 	bq27xxx_battery_update(di);
-- 
2.17.1

