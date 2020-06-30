Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A953AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90EE420760
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgF3Cn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:43:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:35120 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgF3Cn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:43:58 -0400
IronPort-SDR: 0eYd3uo7oYVeK9QNa+JpdZYu4vtcc4UN4h5UmBJOI9f0IHvoVSMK+dmMz0d744792hiVfHlq1x
 gq1Bp1oChEUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="147678580"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="147678580"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 19:43:58 -0700
IronPort-SDR: xkDX+TYq9LZuJz0dItZ/6FPZqkq5q9DFqkIgenfjuiSfv3L+nY4EJ+S8HK+UDM0w5GDCRebgZ6
 T7ze+QW53OxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="425040347"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2020 19:43:56 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jq6FX-0001IQ-V5; Tue, 30 Jun 2020 02:43:55 +0000
Date:   Tue, 30 Jun 2020 10:43:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     alexandru.tachici@analog.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, robh+dt@kernel.org, linux@roeck-us.net,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [RFC PATCH] hwmon: pmbus: adm1266: pmbus_block_xfer() can be static
Message-ID: <20200630024310.GA23779@89284d6ea506>
References: <20200624151736.95785-3-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624151736.95785-3-alexandru.tachici@analog.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 adm1266.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 381d89a8569f2..1aa3f0a738151 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -24,8 +24,8 @@ DECLARE_CRC8_TABLE(pmbus_crc_table);
  * followed by a Read Block without the Read-Block command field and the
  * Write-Block STOP bit.
  */
-int pmbus_block_xfer(struct i2c_client *client, u8 cmd, u8 w_len,
-		     u8 *data_w, u8 *data_r)
+static int pmbus_block_xfer(struct i2c_client *client, u8 cmd, u8 w_len,
+			    u8 *data_w, u8 *data_r)
 {
 	u8 write_buf[ADM1266_PMBUS_BLOCK_MAX + 2];
 	struct i2c_msg msgs[2] = {
