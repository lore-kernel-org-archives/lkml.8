Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A06C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9182098B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624350;
	bh=WCE4+VYZhrwFUZKCCcqJqUTgAjKlW0Go2G+/HwLWmO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LZ8VMwSfR0VCucKgXcZNKwRaatN9X6JnmBaynuOozQhPYEmD4dOhP6mCqrpf0JAjP
	 kP0/Z6eK/ghJpfuG96JD+hJOg4Q5CK0ovmKP6duWlIxAk2NYpt4olkE5xaTpa0boPl
	 Wgnbr0fhAi2cVaV/3C02eCYaBISWNrLBe0Na621k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbgCSNZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730678AbgCSNZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:25:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BA3C2080C;
        Thu, 19 Mar 2020 13:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624344;
        bh=WCE4+VYZhrwFUZKCCcqJqUTgAjKlW0Go2G+/HwLWmO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sEQry4LTZbBpP84r9eMQyQzlA3lZipjQJTzWgysMzVgD7wP7UeV5m0fT9aJm5yMFS
         Vw4utiKazRwC2WfZbhS3GyuASSEu5MTVIQFRAPKaMDwj/rk5rxNkY2UZ4fNeUKVLCy
         uRIc+p99Q4EYoiikeZHBFvlW3PslInvo7DqwzArc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 11/65] ACPI: watchdog: Set default timeout in probe
Date:   Thu, 19 Mar 2020 14:03:53 +0100
Message-Id: <20200319123929.806674971@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123926.466988514@linuxfoundation.org>
References: <20200319123926.466988514@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit cabe17d0173ab04bd3f87b8199ae75f43f1ea473 ]

If the BIOS default timeout for the watchdog is too small userspace may
not have enough time to configure new timeout after opening the device
before the system is already reset. For this reason program default
timeout of 30 seconds in the driver probe and allow userspace to change
this from command line or through module parameter (wdat_wdt.timeout).

Reported-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/wdat_wdt.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index e1b1fcfc02af8..3065dd670a182 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -54,6 +54,13 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+#define WDAT_DEFAULT_TIMEOUT	30
+
+static int timeout = WDAT_DEFAULT_TIMEOUT;
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
+		 __MODULE_STRING(WDAT_DEFAULT_TIMEOUT) ")");
+
 static int wdat_wdt_read(struct wdat_wdt *wdat,
 	 const struct wdat_instruction *instr, u32 *value)
 {
@@ -438,6 +445,22 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wdat);
 
+	/*
+	 * Set initial timeout so that userspace has time to configure the
+	 * watchdog properly after it has opened the device. In some cases
+	 * the BIOS default is too short and causes immediate reboot.
+	 */
+	if (timeout * 1000 < wdat->wdd.min_hw_heartbeat_ms ||
+	    timeout * 1000 > wdat->wdd.max_hw_heartbeat_ms) {
+		dev_warn(dev, "Invalid timeout %d given, using %d\n",
+			 timeout, WDAT_DEFAULT_TIMEOUT);
+		timeout = WDAT_DEFAULT_TIMEOUT;
+	}
+
+	ret = wdat_wdt_set_timeout(&wdat->wdd, timeout);
+	if (ret)
+		return ret;
+
 	watchdog_set_nowayout(&wdat->wdd, nowayout);
 	return devm_watchdog_register_device(dev, &wdat->wdd);
 }
-- 
2.20.1



