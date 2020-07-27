Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9ADC433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747DB207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860455;
	bh=z7Xsc4pAQnAXAS8z63rxjvWkR5v1ktjL8dfKflE2mQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZI2J3vZ1CEeJpUjNF5QVDuO3alPY2hImz05cJBcR4dpG0OgZ8mKiSrT76+yL3R3ld
	 yfFcvGEgaFZtiyTOMut1FNVh8fBpDhpwX3gcwTWGR+KXs8kYNKWpSMikTmUSfgaINm
	 dEq8XhU8+MyyKrRTqAleJvUSRKVfUYRn5Mg6dwC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbgG0OQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730895AbgG0OQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:16:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B575121744;
        Mon, 27 Jul 2020 14:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859394;
        bh=z7Xsc4pAQnAXAS8z63rxjvWkR5v1ktjL8dfKflE2mQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HEeLc0AkG6xqJ22ZCtd0brZkxxHppzCzzjdoPOS8aeD38IR3tcXA7vonxJKsbYAoW
         ZHw+emrMJjijEaw5EVZh9X1NLJjJ0XTTmFhBkx2nCsB+VecHG9C8foiHF9Egs1gHO+
         Ib1lwD2tLeYum+TVUVhSelNkniInWH71RxjhtIxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chu Lin <linchuyuan@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 090/138] hwmon: (adm1275) Make sure we are reading enough data for different chips
Date:   Mon, 27 Jul 2020 16:04:45 +0200
Message-Id: <20200727134929.864259107@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chu Lin <linchuyuan@google.com>

[ Upstream commit 6d1d41c075a1a54ba03370e268171fec20e06563 ]

Issue:
When PEC is enabled, binding adm1272 to the adm1275 would
fail due to PEC error. See below:
adm1275: probe of xxxx failed with error -74

Diagnosis:
Per the datasheet of adm1272, adm1278, adm1293 and amd1294,
PMON_CONFIG (0xd4) is 16bits wide. On the other hand,
PMON_CONFIG (0xd4) for adm1275 is 8bits wide. The driver should not
assume everything is 8bits wide and read only 8bits from it.

Solution:
If it is adm1272, adm1278, adm1293 and adm1294, use i2c_read_word.
Else, use i2c_read_byte

Testing:
Binding adm1272 to the driver.
The change is only tested on adm1272.

Signed-off-by: Chu Lin <linchuyuan@google.com>
Link: https://lore.kernel.org/r/20200709040612.3977094-1-linchuyuan@google.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/adm1275.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 5caa37fbfc187..66b12e5ccbc65 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -454,6 +454,7 @@ MODULE_DEVICE_TABLE(i2c, adm1275_id);
 static int adm1275_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	s32 (*config_read_fn)(const struct i2c_client *client, u8 reg);
 	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
 	int config, device_config;
 	int ret;
@@ -499,11 +500,16 @@ static int adm1275_probe(struct i2c_client *client,
 			   "Device mismatch: Configured %s, detected %s\n",
 			   id->name, mid->name);
 
-	config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
+	if (mid->driver_data == adm1272 || mid->driver_data == adm1278 ||
+	    mid->driver_data == adm1293 || mid->driver_data == adm1294)
+		config_read_fn = i2c_smbus_read_word_data;
+	else
+		config_read_fn = i2c_smbus_read_byte_data;
+	config = config_read_fn(client, ADM1275_PMON_CONFIG);
 	if (config < 0)
 		return config;
 
-	device_config = i2c_smbus_read_byte_data(client, ADM1275_DEVICE_CONFIG);
+	device_config = config_read_fn(client, ADM1275_DEVICE_CONFIG);
 	if (device_config < 0)
 		return device_config;
 
-- 
2.25.1



