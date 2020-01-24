Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A292CC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7134B206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859611;
	bh=ruJhuPX5YT8xB86h9cdA6e549MQ5UbUT38xZLIPdo6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mRi8hrR/nkg1Ls7FQRx/B0xkt1tVK5VCTMJYqIzu3b4d7u91e0GncMe9KOdEAUHNu
	 af3+dcN9fsJSrvRcYEmG4hy84DO+VXHpAlyngUlv61E6N3wZwT+u3ovphC5/oUEpm4
	 xEPKSeIEsgrE8Bm6B/swnzsjOEdOqVOQtGmonXyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbgAXJxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:53:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731526AbgAXJx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:53:29 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A64B206D5;
        Fri, 24 Jan 2020 09:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859609;
        bh=ruJhuPX5YT8xB86h9cdA6e549MQ5UbUT38xZLIPdo6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8g1iBu2XFyLmkn5XPLpNXdCZX5ofq/EpGBjAOP8qIpYWTy0QrhZvdEG6akFVa8Vm
         Auu4bbH4W9g/c2QHbVpoZJPShoK9lJiKk/xMXslAtIIbec6i6HYxunBM17mDMFq4TX
         dJsEkLEqYO56NDbqrvQkRkUI720ivyUyxH7A6qPg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 132/343] regulator: wm831x-dcdc: Fix list of wm831x_dcdc_ilim from mA to uA
Date:   Fri, 24 Jan 2020 10:29:10 +0100
Message-Id: <20200124092937.351280689@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Lin <axel.lin@ingics.com>

[ Upstream commit c25d47888f0fb3d836d68322d4aea2caf31a75a6 ]

The wm831x_dcdc_ilim entries needs to be uA because it is used to compare
with min_uA and max_uA.
While at it also make the array const and change to use unsigned int.

Fixes: e4ee831f949a ("regulator: Add WM831x DC-DC buck convertor support")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/wm831x-dcdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index 5a5bc4bb08d26..df591435d12a3 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -327,8 +327,8 @@ static int wm831x_buckv_get_voltage_sel(struct regulator_dev *rdev)
 }
 
 /* Current limit options */
-static u16 wm831x_dcdc_ilim[] = {
-	125, 250, 375, 500, 625, 750, 875, 1000
+static const unsigned int wm831x_dcdc_ilim[] = {
+	125000, 250000, 375000, 500000, 625000, 750000, 875000, 1000000
 };
 
 static int wm831x_buckv_set_current_limit(struct regulator_dev *rdev,
-- 
2.20.1



