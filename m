Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEF8C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C4824954
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599580528;
	bh=JIERlWPZq59t8PAI+bTxWU/oU1gNX/FDw8yrp5HCbYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RoQRYig/jaC0KpFfs2UU7V/Io74EktxxBfAQIR5nyKlsqImrlR/mbroLMEgKglatl
	 iEVKewSvjWywJw/pAwV8TPw7Hbx+7odHT0Wlm5b4N8mbTiM3hQ5LItIoA6xqIDlIEL
	 rIVreeIbHp5LxpLdEKqdf27SMZWUmkUJUQBJ+p9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbgIHPwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 11:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730590AbgIHPtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:49:13 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E95224837;
        Tue,  8 Sep 2020 15:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579877;
        bh=JIERlWPZq59t8PAI+bTxWU/oU1gNX/FDw8yrp5HCbYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oMfbUo+rzkUxbmxGy7Yv6fhDuOqE8zSY9oUPhinpShrX74/3l0MmUb5shR0KCw/yP
         nwIlkL0RisR1EwssAmhTtMP7NFsCvu7FOX34c8pFv5h2aX31WqrzkQhsmnFtgYI3pO
         1nr8XnhoaCBvVzdzj/gnpyVEiKGNVca4wQbEzYVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Veera Vegivada <vvegivad@codeaurora.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 069/129] thermal: qcom-spmi-temp-alarm: Dont suppress negative temp
Date:   Tue,  8 Sep 2020 17:25:10 +0200
Message-Id: <20200908152233.148843870@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Veera Vegivada <vvegivad@codeaurora.org>

[ Upstream commit 0ffdab6f2dea9e23ec33230de24e492ff0b186d9 ]

Currently driver is suppressing the negative temperature
readings from the vadc. Consumers of the thermal zones need
to read the negative temperature too. Don't suppress the
readings.

Fixes: c610afaa21d3c6e ("thermal: Add QPNP PMIC temperature alarm driver")
Signed-off-by: Veera Vegivada <vvegivad@codeaurora.org>
Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/944856eb819081268fab783236a916257de120e4.1596040416.git.gurus@codeaurora.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index bf7bae42c141c..6dc879fea9c8a 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2011-2015, 2017, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/bitops.h>
@@ -191,7 +191,7 @@ static int qpnp_tm_get_temp(void *data, int *temp)
 		chip->temp = mili_celsius;
 	}
 
-	*temp = chip->temp < 0 ? 0 : chip->temp;
+	*temp = chip->temp;
 
 	return 0;
 }
-- 
2.25.1



