Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E86BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB04206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592585056;
	bh=jIWMJy0Y8klCuejhD7uNt/cCKtnlVzy7LJ0nZ60RZzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gBFrehuvlmSTHvkxfUbsgp0o/iaMWJwFCAsM6Lx87Rh/WLTomEB942Hafpe4jd11W
	 SJxYyKRUca8iJFZhX54LaHrmmZgbt01ewuZPTQUPri2arpoLhd3XI9Lc3RGsw+RW5V
	 /Ts6OOBCyiprMnhs5i6lvqaJZ7RxfOFli9/C/rGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbgFSQoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388469AbgFSOnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:43:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C20CE20CC7;
        Fri, 19 Jun 2020 14:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577800;
        bh=jIWMJy0Y8klCuejhD7uNt/cCKtnlVzy7LJ0nZ60RZzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DiANZbh9KEBk1ecpjj1LIWt3ualLyzs9Pw2Jd5RQ1Xceo3eoKHOtZ3u+RShltpUtK
         bg0kZURHMnevMsAD3eWQhxBSQDvVD5jeG+J9Tv/jFcLUAfr6+I4yI45mF4zX7Fn996
         QlIymtvk57+3o4Ysa/vLMBOmaYlDEETvsUx8ZFrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 055/128] media: si2157: Better check for running tuner in init
Date:   Fri, 19 Jun 2020 16:32:29 +0200
Message-Id: <20200619141623.108911162@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 57b250847cd3..72a47da0db2a 100644
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



