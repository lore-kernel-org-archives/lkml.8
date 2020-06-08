Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9E1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B824420814
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658908;
	bh=exxlbFL3ah7u9FldBxgwESWLtDWZgTnmtFalUav9Rco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y5GDaZzqESMog6Crqxp1go90NEM6nneM2uKTc9WXL3Tl5PgLmsZiYacOc6wlye3VK
	 T9dmva8KbFCqAdY54G8mbJHV8YX8u8CCE2RJQ/CIlCqoLjNneh8/UYlOzZHSAJ3l2S
	 YVPYeZ/UGV50XY+ElTJSht9x0gEMegUc+KF3z8vM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbgFHX21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731363AbgFHXWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:22:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26A3020872;
        Mon,  8 Jun 2020 23:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658564;
        bh=exxlbFL3ah7u9FldBxgwESWLtDWZgTnmtFalUav9Rco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISUdS9QjeYxG6ZR3n0+zg8qjMVF8mwbhGaMC42uE0vEKkP0xZ9zsBGWPHtHMktM0H
         nvCVDctaH6mLy2yhG/CTLmblWjD7QhK8mYyEWhiRUJVqtnkmzUVBGRAupT7vdvum2F
         Ed5oyHbUxu4crn9zHIAFHBxPdqOGTdgqalMmJB3g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brad Love <brad@nextdimension.cc>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 005/106] media: si2157: Better check for running tuner in init
Date:   Mon,  8 Jun 2020 19:20:57 -0400
Message-Id: <20200608232238.3368589-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232238.3368589-1-sashal@kernel.org>
References: <20200608232238.3368589-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit e955f959ac52e145f27ff2be9078b646d0352af0 ]

Getting the Xtal trim property to check if running is less error prone.
Reset if_frequency if state is unknown.

Replaces the previous "garbage check".

Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/tuners/si2157.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index a08d8fe2bb1b..13770b038048 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -84,24 +84,23 @@ static int si2157_init(struct dvb_frontend *fe)
 	struct si2157_cmd cmd;
 	const struct firmware *fw;
 	const char *fw_name;
-	unsigned int uitmp, chip_id;
+	unsigned int chip_id, xtal_trim;
 
 	dev_dbg(&client->dev, "\n");
 
-	/* Returned IF frequency is garbage when firmware is not running */
-	memcpy(cmd.args, "\x15\x00\x06\x07", 4);
+	/* Try to get Xtal trim property, to verify tuner still running */
+	memcpy(cmd.args, "\x15\x00\x04\x02", 4);
 	cmd.wlen = 4;
 	cmd.rlen = 4;
 	ret = si2157_cmd_execute(client, &cmd);
-	if (ret)
-		goto err;
 
-	uitmp = cmd.args[2] << 0 | cmd.args[3] << 8;
-	dev_dbg(&client->dev, "if_frequency kHz=%u\n", uitmp);
+	xtal_trim = cmd.args[2] | (cmd.args[3] << 8);
 
-	if (uitmp == dev->if_frequency / 1000)
+	if (ret == 0 && xtal_trim < 16)
 		goto warm;
 
+	dev->if_frequency = 0; /* we no longer know current tuner state */
+
 	/* power up */
 	if (dev->chiptype == SI2157_CHIPTYPE_SI2146) {
 		memcpy(cmd.args, "\xc0\x05\x01\x00\x00\x0b\x00\x00\x01", 9);
-- 
2.25.1

