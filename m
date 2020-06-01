Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6701C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D4C2158C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034902;
	bh=hu3+Cu1mobOMU0osGTqGMIyMafxT7FTy0kESiJ1M/lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eDup6e/SO8JG2baeSpRclu2gl9m8PPbkGg5PlvPZtrL6wcC4D1S0kWMhHPERyhBdX
	 f3vrPYtyPDgbCgBKeTheFVKZccYYQo4CVrnpuWp2LFNA9sIzkpRqL9PfdzyzaK+G6E
	 RgOmRApowSSyhrM4VGumhOvc17j4bJkECS5meySI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgFASIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:08:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730241AbgFASIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:08:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B3BA207D0;
        Mon,  1 Jun 2020 18:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034894;
        bh=hu3+Cu1mobOMU0osGTqGMIyMafxT7FTy0kESiJ1M/lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHvPhv8LQc1JnRZdSmvCzPDFJsDhbZ6Tijf3cY7WrckPgyZUR+UcfubNoKUHziQZn
         gypFLxwzJlR+5rkf8QMGj5ADRMELRy6y5ep8iupzKmrwGkpt0pKy1BL4Pm0wNM61Y+
         Od3aBOBSu/4VwfvH7Dwc5jKBMCNw9+Tv6boUkI/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amy Shih <amy.shih@advantech.com.tw>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 058/142] hwmon: (nct7904) Fix incorrect range of temperature limit registers
Date:   Mon,  1 Jun 2020 19:53:36 +0200
Message-Id: <20200601174043.933164252@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amy Shih <amy.shih@advantech.com.tw>

[ Upstream commit 7b2fd270af27edaf02acb41a7babe805a9441914 ]

The format of temperature limitation registers are 8-bit 2's complement
and the range is -128~127.
Converts the reading value to signed char to fix the incorrect range
of temperature limitation registers.

Signed-off-by: Amy Shih <amy.shih@advantech.com.tw>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct7904.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 281c81edabc6..dfb122b5e1b7 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -356,6 +356,7 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
 	struct nct7904_data *data = dev_get_drvdata(dev);
 	int ret, temp;
 	unsigned int reg1, reg2, reg3;
+	s8 temps;
 
 	switch (attr) {
 	case hwmon_temp_input:
@@ -461,7 +462,8 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
 
 	if (ret < 0)
 		return ret;
-	*val = ret * 1000;
+	temps = ret;
+	*val = temps * 1000;
 	return 0;
 }
 
-- 
2.25.1



