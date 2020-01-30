Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDFFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49260215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410074;
	bh=4AtbueEFuNKAL6mZDMVjdBYtBNKuiC/Tvwz9VqmlWJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X7H+tUbGNx71nuiI7bUcHkNSn3oEC022RMN0nQwF+W/2zbLfOTFnpom2Krm28k2r7
	 YHjAaWAXCR6/KquCY2Rnmqats+yeql1zrJ3oILgABe+fjX7hEF5Og7Bph5HniCoDUv
	 FHBz3/VitysjDvptto+Vg3QiTS9kCu71DfYBDgf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbgA3Srx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731026AbgA3Srr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:47:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE9452082E;
        Thu, 30 Jan 2020 18:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580410067;
        bh=4AtbueEFuNKAL6mZDMVjdBYtBNKuiC/Tvwz9VqmlWJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBxLyeeVXkVpDmVedKMKYBHUsnIB3Uy50ZJxqc0yqjM8HtjH4k4NDE4lCeUwZMcjD
         ETY+h1YBYfCFm0KJSM8ZxFuFp6nLub/4bbY6iCqYpUSkvDO5DbHw53s79HFBrnpvez
         B78pOPz3pP+ZKIr3uLfz4HK0nN5mBbJuA8reEYd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Engraf <david.engraf@sysgo.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 33/55] watchdog: max77620_wdt: fix potential build errors
Date:   Thu, 30 Jan 2020 19:39:14 +0100
Message-Id: <20200130183614.628871091@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.563083888@linuxfoundation.org>
References: <20200130183608.563083888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Engraf <david.engraf@sysgo.com>

[ Upstream commit da9e3f4e30a53cd420cf1e6961c3b4110f0f21f0 ]

max77620_wdt uses watchdog core functions. Enable CONFIG_WATCHDOG_CORE
to fix potential build errors.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20191127084617.16937-1-david.engraf@sysgo.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b165c46aca741..709d4de11f40f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -594,6 +594,7 @@ config MAX63XX_WATCHDOG
 config MAX77620_WATCHDOG
 	tristate "Maxim Max77620 Watchdog Timer"
 	depends on MFD_MAX77620 || COMPILE_TEST
+	select WATCHDOG_CORE
 	help
 	 This is the driver for the Max77620 watchdog timer.
 	 Say 'Y' here to enable the watchdog timer support for
-- 
2.20.1



