Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A147C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5FE2053B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930037;
	bh=+L89NUu3MbpLpCeF89RPkfWaaUFVqKtkxemjqpB3GH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qb1eycEtN3agqvOhOoJNRNlrRboMu0cilh69AHnQJwM497GOj1bpVBb4SgokpqBTG
	 VYsTkTpEIQMrWFo4N4X+Y7AMA6r/eAn1ppajbLUY/Yn/i1YEXxNj5NK5SrvV3j9fA1
	 9VIf3k7iYelcgG/ZKu8YJoSQEasGxeTLC+Mnq1cM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgHHXkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgHHXkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:40:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1626920658;
        Sat,  8 Aug 2020 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596930032;
        bh=+L89NUu3MbpLpCeF89RPkfWaaUFVqKtkxemjqpB3GH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIRWro9WYz3+Ht4GVv6p6QjlZLC8UN7E1VmrKqZaKxvkQWYwJUVV4dHVn7q9aWJvo
         cs5e6s+E9ohff/mzuXaVCQOYWDWNMUc7KDk5+yEazOY4EBRtPyi+eoUdUYnF31QgSQ
         JR66+ijut17EoFcY6FUv4eZtpKCNLLyTQ4R+lKfs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lu Wei <luwei32@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 11/14] platform/x86: intel-vbtn: Fix return value check in check_acpi_dev()
Date:   Sat,  8 Aug 2020 19:40:10 -0400
Message-Id: <20200808234013.3619541-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808234013.3619541-1-sashal@kernel.org>
References: <20200808234013.3619541-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Wei <luwei32@huawei.com>

[ Upstream commit 64dd4a5a7d214a07e3d9f40227ec30ac8ba8796e ]

In the function check_acpi_dev(), if it fails to create
platform device, the return value is ERR_PTR() or NULL.
Thus it must use IS_ERR_OR_NULL() to check return value.

Fixes: 332e081225fc ("intel-vbtn: new driver for Intel Virtual Button")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Lu Wei <luwei32@huawei.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel-vbtn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index 58c5ff36523ab..d7fa2b88d27ab 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -178,7 +178,7 @@ check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
 		return AE_OK;
 
 	if (acpi_match_device_ids(dev, ids) == 0)
-		if (acpi_create_platform_device(dev, NULL))
+		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
 			dev_info(&dev->dev,
 				 "intel-vbtn: created platform device\n");
 
-- 
2.25.1

