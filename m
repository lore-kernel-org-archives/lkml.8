Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04A0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7397B20675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483521;
	bh=5b1cITD4siBfqcJvrNMsQNnxiLxZtt78fxCTqriWMEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FpTlGRyuiHzFZ1tgbB9J9wnkZOcRcFvcdNvljaWETN2SdVcsrXlcA/hUAqvorqPi2
	 uRW9cS8CeXhSjeYxCD/aH0cLNvEhtVYSkhky2I9jvgXI1csG+OJAFdZ4XAzkJIVpRM
	 LvI5Ig+D5PRa09GXR1jv/2j78Q8xO8SCWGW9T+KI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgENTMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbgENSwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:52:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99D972065F;
        Thu, 14 May 2020 18:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482329;
        bh=5b1cITD4siBfqcJvrNMsQNnxiLxZtt78fxCTqriWMEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tT+PZhW52GsmGaETg2R2mA4ho1+Q2UxpkLfJlkYpihpSbWXkh8Ma7+KjQO/Vy0vUU
         HdGlcr0TGdcTMJe5NBu6Ntxg1MVdmUwkcf0BXYIP5sQI5kToxdo8rtcBrYoMigGND7
         I6/TjF6rUHYJYEIQ284fjF435LMxTksEFD1dFXLo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Gromm <christian.gromm@microchip.com>,
        kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.6 16/62] most: core: use function subsys_initcall()
Date:   Thu, 14 May 2020 14:51:01 -0400
Message-Id: <20200514185147.19716-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185147.19716-1-sashal@kernel.org>
References: <20200514185147.19716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Gromm <christian.gromm@microchip.com>

[ Upstream commit 5e56bc06e18dfc8a66180fa369384b36e2ab621a ]

This patch replaces function module_init() with subsys_initcall().
It is needed to ensure that the core module of the driver is
initialized before a component tries to register with the core. This
leads to a NULL pointer dereference if the driver is configured as
in-tree.

Signed-off-by: Christian Gromm <christian.gromm@microchip.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/1587741394-22021-1-git-send-email-christian.gromm@microchip.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/most/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 0c4ae6920d77d..409c48c597f2f 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -1484,7 +1484,7 @@ static void __exit most_exit(void)
 	ida_destroy(&mdev_id);
 }
 
-module_init(most_init);
+subsys_initcall(most_init);
 module_exit(most_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Christian Gromm <christian.gromm@microchip.com>");
-- 
2.20.1

