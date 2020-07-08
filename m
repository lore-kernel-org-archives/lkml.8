Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D0BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FED4207DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594222959;
	bh=yQq6tDjV2ZhHyd7QbhwN8EbWDbqGM6hBsd8z7A4r9Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VobGcMQrvf41G9Q7N661tLL3GEJ5q3EgBg8kmYBgFjt0MKu8IeWIU3Z6GFzGnoID5
	 7y092g/CsQoRfZueyCv0FRbWEWQzVAQRHwW2dTbSH6+KGt3yURHj/qOTs5kpbrTfrt
	 rwj3lEmiHwjYFADyZnXb9l3mRsJBZl938unaC9Tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbgGHPmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730684AbgGHPmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:42:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97A3C20853;
        Wed,  8 Jul 2020 15:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594222935;
        bh=yQq6tDjV2ZhHyd7QbhwN8EbWDbqGM6hBsd8z7A4r9Kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHKIcElszmN9dv0a0bSc2ooxbiBXEIYbkQakR/LFLTYFUxy6ZEDzkrtG126vt+zFa
         geAJ3eZuMDZyhwALXxSa6vo/x+AIIV5ICCNtFa+VWk5FmEUxYUYWPWX78oKjP525rq
         eP5F32yCwRN7FPpC81pb1ut73finLUxRdIOXA07o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 5/5] i2c: eg20t: Load module automatically if ID matches
Date:   Wed,  8 Jul 2020 11:42:08 -0400
Message-Id: <20200708154208.3200232-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708154208.3200232-1-sashal@kernel.org>
References: <20200708154208.3200232-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 5f90786b31fb7d1e199a8999d46c4e3aea672e11 ]

The driver can't be loaded automatically because it misses
module alias to be provided. Add corresponding MODULE_DEVICE_TABLE()
call to the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-eg20t.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index bdeab0174fec2..0b6567d1aa390 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -189,6 +189,7 @@ static const struct pci_device_id pch_pcidev_id[] = {
 	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_I2C), 1, },
 	{0,}
 };
+MODULE_DEVICE_TABLE(pci, pch_pcidev_id);
 
 static irqreturn_t pch_i2c_handler(int irq, void *pData);
 
-- 
2.25.1

