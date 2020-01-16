Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4144CC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152A821582
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193312;
	bh=vgC9iH93nTAnNujPe1o9T7AfHqz44O7EgJ8sMDXmJR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CH6yCjMrmzCElNh1qUru0PyNkqcQym9iWIgs2lZQmw8Lfxx/UBelfbuWaiUoJCHsl
	 gw1b1OrbzcOAd9CEsC1CFn0kvrnaOtozUIg131mwUrkF4eryaYfTGZUeUcA3bUYPLp
	 saML44fxun7Yzxmg0fZItOH+ZfF59Xj9UviT/5io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgAPQsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:48:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbgAPQs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:48:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84C04207FF;
        Thu, 16 Jan 2020 16:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193308;
        bh=vgC9iH93nTAnNujPe1o9T7AfHqz44O7EgJ8sMDXmJR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TaTGDLjg8IACBbWlYGGmZ77reDQLTkgjOlaJaKBfXH4o8yiBc3i8Enta47pYTDw5z
         pJLfsoHpgjnWSN4ezQv4Mr+HALmqbrWWeONgHZ9NqNm4gXus97W4lCzykP90PODP4E
         iszJGKeOisxAA/f7t5Wmq0vuN6I0LkgUxDJB7BF0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 071/205] firmware: imx: Remove call to devm_of_platform_populate
Date:   Thu, 16 Jan 2020 11:40:46 -0500
Message-Id: <20200116164300.6705-71-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

[ Upstream commit 0e4e8cc30a2940c57448af1376e40d3c0996fb29 ]

IMX DSP device is created by SOF layer. The current call to
devm_of_platform_populate is not needed and it doesn't produce
any effects.

Fixes: ffbf23d50353915d ("firmware: imx: Add DSP IPC protocol interface)
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/imx/imx-dsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
index a43d2db5cbdb..4265e9dbed84 100644
--- a/drivers/firmware/imx/imx-dsp.c
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -114,7 +114,7 @@ static int imx_dsp_probe(struct platform_device *pdev)
 
 	dev_info(dev, "NXP i.MX DSP IPC initialized\n");
 
-	return devm_of_platform_populate(dev);
+	return 0;
 out:
 	kfree(chan_name);
 	for (j = 0; j < i; j++) {
-- 
2.20.1

