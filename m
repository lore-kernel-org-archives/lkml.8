Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD24C2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A87F208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XUiCBZdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgIGI6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:58:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55120 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbgIGI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:58:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0878wFpR122267;
        Mon, 7 Sep 2020 03:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599469095;
        bh=mkBlsttN8I/uiakWZQcmlDLR+tTKZ4sSOgOZd+MCekE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XUiCBZdpUbgxp/E84jhH9myZI4SHiNYKhezZLH3IUIzXrl0Bm43ejUtn2ZLekptv6
         eCJdv9TLKqBa8gy/qXQM9+vvZlL/XDdZFlVmlEixiBWE8BcbdgxWB4cWy/WOWjOh10
         8q8mGl0VTMjDmHBm7P7CDPlP20IeTEXu3NF0rj2k=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0878wFEg128275
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 03:58:15 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 03:58:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 03:58:15 -0500
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0878wBas040828;
        Mon, 7 Sep 2020 03:58:13 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <linux-clk@vger.kernel.org>, <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sboyd@kernel.org>, <mturquette@baylibre.com>
Subject: [PATCH 1/3] clk: keystone: sci-clk: fix parsing assigned-clock data during probe
Date:   Mon, 7 Sep 2020 11:57:38 +0300
Message-ID: <20200907085740.1083-2-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907085740.1083-1-t-kristo@ti.com>
References: <20200907085740.1083-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT clock probe loop incorrectly terminates after processing "clocks"
only, fix this by re-starting the loop when all entries for current
DT property have been parsed.

Fixes: 8e48b33f9def ("clk: keystone: sci-clk: probe clocks from DT instead of firmware")
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/keystone/sci-clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index 2ad26cb927fd..f126b6045afa 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -522,7 +522,7 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
 		np = of_find_node_with_property(np, *clk_name);
 		if (!np) {
 			clk_name++;
-			break;
+			continue;
 		}
 
 		if (!of_device_is_available(np))
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
