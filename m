Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E73C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34CA20709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858880;
	bh=rUwxjvtbWwBnXS3uNzwhcjEps4KTjM+2fMu3o/FFLug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iuS7NrOuoDWGc6h55htFSrm1PI8Nz/qxvo1/fyGggnu1HWd9DW+Fr0CcGfafUL4BH
	 iC02jVkWAiGSbBBvxC2zfh5wbiT/tYg4TX/sJJmdSF9AI3HTDx+K4XzWKl5OBPXTsO
	 F5dD+zeC+Hf0JWU9cvrTBM00dP8JyQ4Ib4f8Ur9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbgAXJlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:41:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732762AbgAXJlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:41:16 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C557D2070A;
        Fri, 24 Jan 2020 09:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858875;
        bh=rUwxjvtbWwBnXS3uNzwhcjEps4KTjM+2fMu3o/FFLug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p68scjIhsICdzcfiIgwOjwyG6v8QxR/YXI9ucCxvxFQn8BQR0l1GSkG0jWWZwzSVw
         JReJbnTLd7r0SWA/wUGe995Muxbm8jF1bKFkNHXenyrzr4evKGxNr0YkiE4NvrMQxP
         G/nuSgX097iKaLoMZ6SVHQnSfllhtsdYQ55ZE2+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 066/102] firmware: imx: Remove call to devm_of_platform_populate
Date:   Fri, 24 Jan 2020 10:31:07 +0100
Message-Id: <20200124092816.370985666@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index a43d2db5cbdb4..4265e9dbed84f 100644
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



