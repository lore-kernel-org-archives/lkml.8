Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E0FC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C8E2192A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198169;
	bh=0JFl9aWLKC71Gk5dPOObiZY7H/47oVRdIQLA7yf0cs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W8Fx7sBUld/1LBbrivzzz9GgkEbU3Y+0lyxQ6oQ+CjEMB0Bb4RthbVUifg8+kjZNZ
	 dN3sGrmqvgtRF6S+QZVdbCzPUWHOCjofo2acmySK79o54vRnRmUTn6Y99GGjtLqBzX
	 8nwX9x7tldh3TNDUFiUMHcXoBxfEmSk2jwAtlv0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404997AbgAPRiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:38:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393207AbgAPRhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:37:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E905246DC;
        Thu, 16 Jan 2020 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196267;
        bh=0JFl9aWLKC71Gk5dPOObiZY7H/47oVRdIQLA7yf0cs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3km5Y5OAfwX7PhZ0QvUTvjQTV+DLTPa6+jYqGFjlnJdK4Ox5ggh4A9xc8TA+si0P
         JK8puC2/Ikq4tokEz0TkoKaUB1nfAkQKMzxlG/mBKMjOO6m/cfXckhfiQpGaVUtcZW
         I1sqgWl9kQ8WjIBr4c6WhpxiIZh030UroRyDz+yY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Axel Lin <axel.lin@ingics.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com
Subject: [PATCH AUTOSEL 4.9 090/251] regulator: wm831x-dcdc: Fix list of wm831x_dcdc_ilim from mA to uA
Date:   Thu, 16 Jan 2020 12:33:59 -0500
Message-Id: <20200116173641.22137-50-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 5a5bc4bb08d2..df591435d12a 100644
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

