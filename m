Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23A5C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB3F2469E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273239;
	bh=2vMDVmLuOR6BkAhzKPJBoLjsBQUyJrJMaKfCRoB8+CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IXpx3v+BZ80Ubdc0GcwUuTCz5eh2jKCFV4blesjAnBqW5/tNgCki5xX9zbMmUKBS9
	 HWFdcAqxolHZ6DM1chpR8q4Xnw5dwpEwcsfbtumCPEievP98Gz9F49Km3uGVNghOrD
	 9HIpJmmm/QNsk65JEV79nASXwvs8Su3y+9w1bcXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbgBUIUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:20:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388156AbgBUIUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:20:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3ECC24696;
        Fri, 21 Feb 2020 08:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273224;
        bh=2vMDVmLuOR6BkAhzKPJBoLjsBQUyJrJMaKfCRoB8+CI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qxLy3Up77IHCIgiR4DGcB4/0gIHg4G5Yn18lSjteSkVou84lrcMIkSovn60nbIlnJ
         PP6+iLkhjKLqmr2hzaJJi6E5ijO5sNoXVNACpuHddCpMUTRqpj1KWWAoLWeQGXsFvx
         XKTltpCh9q+O8Tq13w6qXgmmgtklsFfz6qORl9DE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 053/191] regulator: rk808: Lower log level on optional GPIOs being not available
Date:   Fri, 21 Feb 2020 08:40:26 +0100
Message-Id: <20200221072257.920312710@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit b8a039d37792067c1a380dc710361905724b9b2f ]

RK808 can leverage a couple of GPIOs to tweak the ramp rate during DVS
(Dynamic Voltage Scaling). These GPIOs are entirely optional but a
dev_warn() appeared when cleaning this driver to use a more up-to-date
gpiod API. At least reduce the log level to 'info' as it is totally
fine to not populate these GPIO on a hardware design.

This change is trivial but it is worth not polluting the logs during
bringup phase by having real warnings and errors sorted out
correctly.

Fixes: a13eaf02e2d6 ("regulator: rk808: make better use of the gpiod API")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20191203164709.11127-1-miquel.raynal@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/rk808-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 213b68743cc89..92498ac503035 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -714,7 +714,7 @@ static int rk808_regulator_dt_parse_pdata(struct device *dev,
 		}
 
 		if (!pdata->dvs_gpio[i]) {
-			dev_warn(dev, "there is no dvs%d gpio\n", i);
+			dev_info(dev, "there is no dvs%d gpio\n", i);
 			continue;
 		}
 
-- 
2.20.1



