Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513C5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BB024696
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220764;
	bh=BAuGnV6ApDLBskZlToVXtsrcdU/YeZu3hnzsSO+iKSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bwa7JJ2arlTnMnkcwxA5Q0sltZMRQNoArE+alZP4SSn+kn6/iHqqYvsR69YkPuGcX
	 nZM5oE0cTFpAxpaJDqqALuX79FWp9BRcp46Oai8UaCGhHg4GhLpG28WbA+2eiFvQ4Q
	 ytCRwc/aXT6GdxGA4BBKv1fNaOfvEp3Bo1y8Hot4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgA1OMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:12:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbgA1OMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:12:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8039F2468A;
        Tue, 28 Jan 2020 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220761;
        bh=BAuGnV6ApDLBskZlToVXtsrcdU/YeZu3hnzsSO+iKSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTNkn6LSKCBtmb/l9Cp43a77F7zAyi0XGs3KIEUl/ykQb+qinsoiQUPj0s+r8ql1m
         ro6TQI7uxFN279KkIMhLtHrWD0nprNSTO2pz94dCVwHv4lENfflGXIFNQ8mfmitUl7
         5WgGd6S51GBXlIAPL+XEoh/gzu503tbholCUad3k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 136/183] hwmon: (shtc1) fix shtc1 and shtw1 id mask
Date:   Tue, 28 Jan 2020 15:05:55 +0100
Message-Id: <20200128135843.348731806@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Robertson <dan@dlrobertson.com>

[ Upstream commit fdc7d8e829ec755c5cfb2f5a8d8c0cdfb664f895 ]

Fix an error in the bitmaskfor the shtc1 and shtw1 bitmask used to
retrieve the chip ID from the ID register. See section 5.7 of the shtw1
or shtc1 datasheet for details.

Fixes: 1a539d372edd9832444e7a3daa710c444c014dc9 ("hwmon: add support for Sensirion SHTC1 sensor")
Signed-off-by: Dan Robertson <dan@dlrobertson.com>
Link: https://lore.kernel.org/r/20190905014554.21658-3-dan@dlrobertson.com
[groeck: Reordered to be first in series and adjusted accordingly]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/shtc1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
index decd7df995abf..2a18539591eaf 100644
--- a/drivers/hwmon/shtc1.c
+++ b/drivers/hwmon/shtc1.c
@@ -38,7 +38,7 @@ static const unsigned char shtc1_cmd_read_id_reg[]	       = { 0xef, 0xc8 };
 
 /* constants for reading the ID register */
 #define SHTC1_ID	  0x07
-#define SHTC1_ID_REG_MASK 0x1f
+#define SHTC1_ID_REG_MASK 0x3f
 
 /* delays for non-blocking i2c commands, both in us */
 #define SHTC1_NONBLOCKING_WAIT_TIME_HPM  14400
-- 
2.20.1



