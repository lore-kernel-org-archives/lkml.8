Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CA1C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 11:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6211720658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 11:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBCLAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:00:42 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:55002 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727236AbgBCLAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 06:00:42 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iyZT4-0007AG-5Y; Mon, 03 Feb 2020 12:00:38 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from roc (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id 013B0bp5009295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Feb 2020 12:00:37 +0100
From:   Markus Reichl <m.reichl@fivetechno.de>
To:     linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     heiko@sntech.de, Markus Reichl <m.reichl@fivetechno.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: mp8859: add supply entry
Date:   Mon,  3 Feb 2020 12:00:33 +0100
Message-Id: <20200203110034.1448-1-m.reichl@fivetechno.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichll@fivetechno.de;1580727641;335fe488;
X-HE-SMSGID: 1iyZT4-0007AG-5Y
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vin_supply to the regulator description to support a nice
regulator tree.

Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
---
 drivers/regulator/mp8859.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
index 1d26b506ee5b..6ed987648188 100644
--- a/drivers/regulator/mp8859.c
+++ b/drivers/regulator/mp8859.c
@@ -95,6 +95,7 @@ static const struct regulator_desc mp8859_regulators[] = {
 		.id = 0,
 		.type = REGULATOR_VOLTAGE,
 		.name = "mp8859_dcdc",
+		.supply_name = "vin",
 		.of_match = of_match_ptr("mp8859_dcdc"),
 		.n_voltages = VOL_MAX_IDX + 1,
 		.linear_ranges = mp8859_dcdc_ranges,
-- 
2.24.1

