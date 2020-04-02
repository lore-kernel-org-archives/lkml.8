Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD855C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4082077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389467AbgDBWiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 18:38:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:64196 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729549AbgDBWiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 18:38:46 -0400
IronPort-SDR: 8aP+kFMHG2NbOSUqrxqX4eOmPgtC/GFRtLsD9AhVn3A3HJCR6ZqB1ZXR1Oh3cq2HdmWvAAw3Uz
 H5oDM6+dggUw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 15:38:45 -0700
IronPort-SDR: LNIqXv5RqfuX6hbRiyE0+KsHS6NZfbSVjV2o6Ii+z5t+RDEf7+l2XE9UlNinHrVzG7hZ/Np0KY
 ZFzYqcrywAEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,337,1580803200"; 
   d="scan'208";a="295781172"
Received: from perezpri-desk0.jf.intel.com ([134.134.159.53])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Apr 2020 15:38:45 -0700
From:   Bernardo Perez Priego <bernardo.perez.priego@intel.com>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nick Crews <ncrews@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Campello <campello@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/chrome: wilco_ec: Provide correct output format to 'h1_gpio' file
Date:   Thu,  2 Apr 2020 15:33:30 -0700
Message-Id: <20200402223331.28300-1-bernardo.perez.priego@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313232720.22364-1-bernardo.perez.priego@intel.com>
References: <20200313232720.22364-1-bernardo.perez.priego@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function 'h1_gpio_get' is receiving 'val' parameter of type u64,
this is being passed to 'send_ec_cmd' as type u8, thus, result
is stored in least significant byte. Due to output format,
the whole 'val' value was being displayed when any of the most
significant bytes are different than zero.

This fix will make sure only least significant byte is displayed
regardless of remaining bytes value.

Signed-off-by: Bernardo Perez Priego <bernardo.perez.priego@intel.com>
---
Changes in v2:
- Keep original format and apply mask instead to resolve warning

 drivers/platform/chrome/wilco_ec/debugfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index df5a5f6c3ec6..a812788a0bdc 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -208,7 +208,12 @@ static int send_ec_cmd(struct wilco_ec_device *ec, u8 sub_cmd, u8 *out_val)
  */
 static int h1_gpio_get(void *arg, u64 *val)
 {
-	return send_ec_cmd(arg, SUB_CMD_H1_GPIO, (u8 *)val);
+	int ret;
+
+	ret = send_ec_cmd(arg, SUB_CMD_H1_GPIO, (u8 *)val);
+	if (ret == 0)
+		*val &= 0xFF;
+	return ret;
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02llx\n");
-- 
2.17.1

