Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1CFC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE5C206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648436;
	bh=z9rtLhZlzhiOGVZoMMk3LzerzSTwqB0GfVjTvbMw2gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WSfsTOKP1zUB44p6ASMJgK90X0MTxFcahk6+IolPainnu9HqRKeBPPJBvfx40rsn+
	 fHUt4pk5ZDGXjC5NjQpb90F0ILh9VBJay9vZ3bWc/nitvy8gZ0wlFvV4KN+Nkyksfd
	 pybOs3HTR307FH/714wLEYw7vF1XtngdD11kHYF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgDKXkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728633AbgDKXHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:07:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35DF221841;
        Sat, 11 Apr 2020 23:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646440;
        bh=z9rtLhZlzhiOGVZoMMk3LzerzSTwqB0GfVjTvbMw2gI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xYf5oEMdYQd0o+Gh5Fb8l/6kMDvMiA9zWzFPkYsNCCdtUlYfecMoNfuB36xjPvU9W
         GejdfVFzeyLc250Z6RneFSiW3lq+OETnIRTztVDThTGNIBQHanFXmhcqNIjqIJTOlk
         5LBYkygdm86lENEsLqz+W25wg/ENKeuZHUplaLgI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leonid Maksymchuk <leonmaxx@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 012/121] platform/x86: asus_wmi: Fix return value of fan_boost_mode_store
Date:   Sat, 11 Apr 2020 19:05:17 -0400
Message-Id: <20200411230706.23855-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonid Maksymchuk <leonmaxx@gmail.com>

[ Upstream commit edeee341fd6c1099de357c517af215bee2c6f766 ]

Function fan_boost_mode_store returns 0 if store is successful,
this leads to infinite loop after any write to it's sysfs entry:

# echo 0 >/sys/devices/platform/asus-nb-wmi/fan_boost_mode

This command never ends, one CPU core is at 100% utilization.
This patch fixes this by returning size of written data.

Fixes: b096f626a682 ("platform/x86: asus-wmi: Switch fan boost mode")
Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 982f0cc8270ce..977b813cc0fa9 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1712,7 +1712,7 @@ static ssize_t fan_boost_mode_store(struct device *dev,
 	asus->fan_boost_mode = new_mode;
 	fan_boost_mode_write(asus);
 
-	return result;
+	return count;
 }
 
 // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
-- 
2.20.1

