Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD6EC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F77820716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ijyPN0EP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgICO4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:56:40 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:46044 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgICOKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1599142230; x=1630678230;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yAlQCfI87sxPe78LUN486EmZ8/vrFT3DkpttqgEbkLI=;
  b=ijyPN0EPSe3TjOeYckG3ElMMsev/2BkEozYMr/k1jgEf3eOJVflQnT0o
   MHe6PkPAZn+58+BYWaCicpn7Ox/qm1QCLQSPak/vQZ+d04SjYnXeFrwdi
   TOKIX2NpPhrs/zHCt+8xmqVBtJC7FQRdowzGiU9kxY41RttxCQ8g2Hp3g
   Kr+geJOCrZKNALEbyO2E2r8iukpwl7IJJMwe+ldVnniaB9Ykrq2aM8QGz
   omU2MkSbXCmjOcBI+MgZRazLOwB5A/FZdKhui1SEUIyjAhkhXZRXOtLcU
   +rWeHW8qkgzR/+TjH+Bzmi6D0PHrsNo8FiPHcC+/DiQEIhg2sFF1bgHh2
   w==;
IronPort-SDR: fg+MNFt/hACS4QNbg/H6mQOCtEp4dzqSAZUSVAvmahPMw5Qyd0tkbuTD8auWo12N6Helz72fXD
 cvf0wTwnnYCBBIAaJvsAHb83XO/9jwSjDEYSrrA9jJh4TYKkRaY6DihEyqAHPfVtKq0l8gU4Mn
 UlIFHeICeyPaoVSqMySs/ZwYZFQssTBXHEsI38n8gQ1Gp1es9jZyUsE7QTgEZREIxJ1vFs814/
 ITTqronlWeJLAXiBsulEHiSJJabTct4sTB2qHvuxLJqqjYOI5n6Wh4+QqMGLM56YqPXIDSA8aL
 2dk=
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="87817699"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Sep 2020 06:47:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Sep 2020 06:46:32 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 3 Sep 2020 06:47:10 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon: sparx5: Fix initial reading of temperature
Date:   Thu, 3 Sep 2020 15:47:04 +0200
Message-ID: <20200903134704.8949-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the temperature is read before the internal calibration is
completed, the driver returns -EIO. Instead it should return -EAGAIN
to encourage repeating the operation.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 drivers/hwmon/sparx5-temp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/sparx5-temp.c b/drivers/hwmon/sparx5-temp.c
index 1a2b1026b026..98be48e3a22a 100644
--- a/drivers/hwmon/sparx5-temp.c
+++ b/drivers/hwmon/sparx5-temp.c
@@ -56,7 +56,7 @@ static int s5_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_temp_input:
 		stat = readl_relaxed(hwmon->base + TEMP_STAT);
 		if (!(stat & TEMP_STAT_VALID))
-			return -EIO;
+			return -EAGAIN;
 		value = stat & TEMP_STAT_TEMP;
 		/*
 		 * From register documentation:
--
2.27.0
