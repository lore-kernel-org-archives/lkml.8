Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA80C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C2D20716
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222074;
	bh=9VcWLlPOVrBfmsF+gWhJQIvg/rr++BFkrp5PDDrmsMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C6gOYfI3gxiXMNXlxxc8akoKTz4QbtzGEncZw1THIQ+My6YTQvA+58ZPYyN6tbzgN
	 dpGdehKzhM1oaselEind3ITuN+i4oVWyHGb4AY/ORbFaR/BRAaUDev5tdd+e+gEkoM
	 +LF5MMMeZ784mTAA2tUG/y2mbBnvH5+fAZ2nf00I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733201AbgA1Oe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:34:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732472AbgA1OYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:24:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AAE824688;
        Tue, 28 Jan 2020 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221445;
        bh=9VcWLlPOVrBfmsF+gWhJQIvg/rr++BFkrp5PDDrmsMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jq9h+kHBnUglO6VxBodIx8SQ4EquAFS9czoU8iTNlQ7FVkq0zFtwY5S1qpIOHSlo4
         MW8OGfG0nMlq/Mfpgsgl6hCO6id6zub0nSI0XHYnKtq13+5nz+sdRN1G5kmC1XIzN3
         Jna3/iEjeIbRYcZHS6kVdGgZfmFRKKpCtUJsH11A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Iker Perez del Palomar Sustatxa 
        <iker.perez@codethink.co.uk>, Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 190/271] hwmon: (lm75) Fix write operations for negative temperatures
Date:   Tue, 28 Jan 2020 15:05:39 +0100
Message-Id: <20200128135906.719278713@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 7d82fcc9d9e81241778aaa22fda7be753e237d86 ]

Writes into limit registers fail if the temperature written is negative.
The regmap write operation checks the value range, regmap_write accepts
an unsigned int as parameter, and the temperature value passed to
regmap_write is kept in a variable declared as long. Negative values
are converted large unsigned integers, which fails the range check.
Fix by type casting the temperature to u16 when calling regmap_write().

Cc: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>
Fixes: e65365fed87f ("hwmon: (lm75) Convert to use regmap")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/lm75.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index eff3b24d84737..fc31669a86ba8 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -164,7 +164,7 @@ static int lm75_write(struct device *dev, enum hwmon_sensor_types type,
 	temp = DIV_ROUND_CLOSEST(temp  << (resolution - 8),
 				 1000) << (16 - resolution);
 
-	return regmap_write(data->regmap, reg, temp);
+	return regmap_write(data->regmap, reg, (u16)temp);
 }
 
 static umode_t lm75_is_visible(const void *data, enum hwmon_sensor_types type,
-- 
2.20.1



