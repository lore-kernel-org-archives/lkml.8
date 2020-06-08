Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996FCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9A22072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591661410;
	bh=lnEMHqocNQE7xngj2F9yaPWJK7kSQshce4kc3CvsH9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M9QmEbX30slCwIv1JDgbbXnSDwSYDihJSz0X2RzbYYw6cC3MQk7rzCBs1c8h7RVFB
	 wruGmK6djDq3ByD8GxS9nKtqlbfqpr8S/op0QoU8ivPVo6oDZkErAYhCtPHkt6R/vO
	 eckEfHkHT+keXYLJzO9JmW1jw2M+ulveyg8Prr6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbgFIAKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730939AbgFHXUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:20:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B5B920842;
        Mon,  8 Jun 2020 23:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658418;
        bh=lnEMHqocNQE7xngj2F9yaPWJK7kSQshce4kc3CvsH9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uudcTqtrEDeacMb/vDAbCYoJ3a+j+toFFqIGZZ+INm1ciqJQATEkBKUdR6XFdvQXG
         rUOMN8KieLodleae5pHtrCFMlyDOXp3rBa0vx6HkKto0mGliMVpSDhc79ONIXXUswr
         btqy0aBDua/uTeXgLNkwUMN5jbJCbDDPWJmzjRu8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 066/175] spi: Respect DataBitLength field of SpiSerialBusV2() ACPI resource
Date:   Mon,  8 Jun 2020 19:16:59 -0400
Message-Id: <20200608231848.3366970-66-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 0dadde344d965566589cd82797893d5aa06557a3 ]

By unknown reason the commit 64bee4d28c9e
  ("spi / ACPI: add ACPI enumeration support")
missed the DataBitLength property to encounter when parse SPI slave
device data from ACPI.

Fill the gap here.

Fixes: 64bee4d28c9e ("spi / ACPI: add ACPI enumeration support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20200413180406.1826-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c186d3a944cd..177d31c2ea7d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1950,6 +1950,7 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 			}
 
 			lookup->max_speed_hz = sb->connection_speed;
+			lookup->bits_per_word = sb->data_bit_length;
 
 			if (sb->clock_phase == ACPI_SPI_SECOND_PHASE)
 				lookup->mode |= SPI_CPHA;
-- 
2.25.1

