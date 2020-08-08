Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0FCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC692053B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930089;
	bh=UjThr/AbDF+r+cHfs7kHV66RNhDFQIPaR76spC6viQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=msDF/WrTuEbaO3l//kUVTXgIxvI0KFhyfnBJnPfLZgOoiht1dg5eXiInxjrd+yik6
	 c/TW1x6ZFm6mA61ro970F/1dTqh4UAak+HG9XpIlGL2Q2n3YFYuYn/y4joCB68FdbZ
	 Ro0aRdQPkStikYm8ner7ry8/y29Ndm8BQ3Q5qw2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgHHXl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgHHXku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:40:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFBCB20658;
        Sat,  8 Aug 2020 23:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596930049;
        bh=UjThr/AbDF+r+cHfs7kHV66RNhDFQIPaR76spC6viQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPJVtMkiIpW5luR04xA+ywtDS9f9EXcvRkXJFsCzTo4b7mXJTxmBJPI+aRj5BJrGG
         8P5w68YEFNk1BT6hoYqOEm3NAjwmW2u2juhgfxnICZgz1o35fIACFaAh/CLk9T3P3J
         yuVo0+AOgZgfUGNj7yG/ilpE4nalF75nJIFTfWF8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lu Wei <luwei32@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 6/9] platform/x86: intel-hid: Fix return value check in check_acpi_dev()
Date:   Sat,  8 Aug 2020 19:40:33 -0400
Message-Id: <20200808234037.3619732-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808234037.3619732-1-sashal@kernel.org>
References: <20200808234037.3619732-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Wei <luwei32@huawei.com>

[ Upstream commit 71fbe886ce6dd0be17f20aded9c63fe58edd2806 ]

In the function check_acpi_dev(), if it fails to create
platform device, the return value is ERR_PTR() or NULL.
Thus it must use IS_ERR_OR_NULL() to check return value.

Fixes: ecc83e52b28c ("intel-hid: new hid event driver for hotkeys")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Lu Wei <luwei32@huawei.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index 12dbb50633761..a5c645b9e3f2a 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -264,7 +264,7 @@ check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
 		return AE_OK;
 
 	if (acpi_match_device_ids(dev, ids) == 0)
-		if (acpi_create_platform_device(dev, NULL))
+		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
 			dev_info(&dev->dev,
 				 "intel-hid: created platform device\n");
 
-- 
2.25.1

