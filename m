Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17BCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94517208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859853;
	bh=ouo7TMEz/IqYJUsjvl8B3CXtrHu4eF3BTHFsVDf8JeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Vn9i2YJQNJaboj2f0Ju95wTRDSSlFk3PLe8uIcDNrprr4GzsRvp21z3Hq8dLg9PI
	 yxe/pcGvlWxm22O0O7p1E/ymGlw1mo+lEoMVRD1SHObE6C88MxIRfzL4Dz7jfbfv9M
	 B6xDjhLDoXifJI2tCJvQ1PeEx7+Vm7oFgqavfIok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbgG0OYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:24:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732195AbgG0OYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:24:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 116232070A;
        Mon, 27 Jul 2020 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859847;
        bh=ouo7TMEz/IqYJUsjvl8B3CXtrHu4eF3BTHFsVDf8JeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iGRha0dMt6xGi6p8QqeXX4GwTTZy3+K9Me9kM+hpv5zU5gFonB3TBjvBnDDHMMR2R
         AXauEPZBSOJDjwmrUi48sy5sHlf0YZy9rR9Ku7JtloFVd0a8KqnJ0jQtyI3JddVCCV
         d4yJJ9i+YL3okVqggYvGyhmKXw/O1qv/SGgBwqAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasiliy Kupriakov <rublag-ns@yandex.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 129/179] platform/x86: asus-wmi: allow BAT1 battery name
Date:   Mon, 27 Jul 2020 16:05:04 +0200
Message-Id: <20200727134938.934695048@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasiliy Kupriakov <rublag-ns@yandex.ru>

[ Upstream commit 9a33e375d98ece5ea40c576eabd3257acb90c509 ]

The battery on my laptop ASUS TUF Gaming FX706II is named BAT1.
This patch allows battery extension to load.

Signed-off-by: Vasiliy Kupriakov <rublag-ns@yandex.ru>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index cd212ee210e2d..537b824a1ae25 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -432,6 +432,7 @@ static int asus_wmi_battery_add(struct power_supply *battery)
 	 * battery is named BATT.
 	 */
 	if (strcmp(battery->desc->name, "BAT0") != 0 &&
+	    strcmp(battery->desc->name, "BAT1") != 0 &&
 	    strcmp(battery->desc->name, "BATT") != 0)
 		return -ENODEV;
 
-- 
2.25.1



