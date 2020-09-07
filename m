Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A73C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252F4208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k7Tw9jr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgIGI6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:58:39 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40996 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgIGI6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:58:24 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0878wIkg058766;
        Mon, 7 Sep 2020 03:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599469098;
        bh=NPu83n18eUWOYpHbYTl7Ayra0VWy1PJnb+/c14e0kJU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=k7Tw9jr7NzsQrTJ1MZ04dyzaJ2WUrc9Lbjw3JZU1TljcQx4ZbF8edBsYQg4qIeWQi
         YBONgxTyVV/cJ9TRYoMPxTgwoGMcpdlOcjaH6uj6e/B/bnrx3vXmznJsO0ZRl1ly/w
         nyicv8BVmS0yjqSFMyqDSsaAGqcxHdoqDWb0VrzA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0878wIYc095061
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 03:58:18 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 03:58:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 03:58:18 -0500
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0878wBau040828;
        Mon, 7 Sep 2020 03:58:17 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <linux-clk@vger.kernel.org>, <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sboyd@kernel.org>, <mturquette@baylibre.com>
Subject: [PATCH 3/3] clk: keystone: sci-clk: add 10% slack to set_rate
Date:   Mon, 7 Sep 2020 11:57:40 +0300
Message-ID: <20200907085740.1083-4-t-kristo@ti.com>
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

Currently, we request exact clock rates from the firmware to be set with
set_rate. Due to some rounding errors and internal functionality of the
firmware itself, this can fail. Thus, add some slack to the set_rate
functionality so that we are always guaranteed to pass. The firmware
always attempts to use frequency as close to the target freq as
possible despite the slack given here.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/keystone/sci-clk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index b6477b08af04..aaf31abe1c8f 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -221,7 +221,8 @@ static int sci_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct sci_clk *clk = to_sci_clk(hw);
 
 	return clk->provider->ops->set_freq(clk->provider->sci, clk->dev_id,
-					    clk->clk_id, rate, rate, rate);
+					    clk->clk_id, rate / 10 * 9, rate,
+					    rate / 10 * 11);
 }
 
 /**
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
