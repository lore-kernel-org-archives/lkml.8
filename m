Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238EBC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E3F2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgDWOKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:10:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41255 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgDWOK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:10:29 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jRcYS-00087B-Rm; Thu, 23 Apr 2020 14:10:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Walle <michael@walle.cc>,
        Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: phy: bcm54140: fix less than zero comparison on an unsigned
Date:   Thu, 23 Apr 2020 15:10:16 +0100
Message-Id: <20200423141016.19666-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the unsigned variable tmp is being checked for an negative
error return from the call to bcm_phy_read_rdb and this can never
be true since tmp is unsigned.  Fix this by making tmp a plain int.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: 4406d36dfdf1 ("net: phy: bcm54140: add hwmon support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/phy/bcm54140.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/bcm54140.c b/drivers/net/phy/bcm54140.c
index aa854477e06a..7341f0126cc4 100644
--- a/drivers/net/phy/bcm54140.c
+++ b/drivers/net/phy/bcm54140.c
@@ -191,7 +191,8 @@ static int bcm54140_hwmon_read_alarm(struct device *dev, unsigned int bit,
 static int bcm54140_hwmon_read_temp(struct device *dev, u32 attr, long *val)
 {
 	struct phy_device *phydev = dev_get_drvdata(dev);
-	u16 reg, tmp;
+	u16 reg;
+	int tmp;
 
 	switch (attr) {
 	case hwmon_temp_input:
@@ -224,7 +225,8 @@ static int bcm54140_hwmon_read_in(struct device *dev, u32 attr,
 				  int channel, long *val)
 {
 	struct phy_device *phydev = dev_get_drvdata(dev);
-	u16 bit, reg, tmp;
+	u16 bit, reg;
+	int tmp;
 
 	switch (attr) {
 	case hwmon_in_input:
-- 
2.25.1

