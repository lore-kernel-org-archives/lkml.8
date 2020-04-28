Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74F3C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3FA72186A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098770;
	bh=mNN3goFAdj6cbIOVlz0S+XGlyz6dKS6SjydtWTzaTLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qK1T1Uzs1Oc42+uTCzFw4N+hzxYuZb2tY5v5ssB4qyw7g0H8zJHVyrEJ3oIReCOns
	 WLGN9GPbCUBU88nb350lgIsA66fcDAel4OMqNDagB0VvuyhfWn32WlxWcV+XxUrqiI
	 HfeM1Dquk8zWinxAJuaVmsEgMLEdcmhscLFgcd44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgD1Sct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729847AbgD1Scq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:32:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95AE221707;
        Tue, 28 Apr 2020 18:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098766;
        bh=mNN3goFAdj6cbIOVlz0S+XGlyz6dKS6SjydtWTzaTLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=so8idE6I28Sjdt5EeFXqXc348NyBcvbn0OhCSl19Y2Cd5MgGzGoAWjhyiYRpKgP//
         voNT7UtsHEvCO4qiKb9UnAZV7grqY3Pv6Bm0giYP2a7o2j/ZTLPN3NFz6+wcM2zz6j
         I0aR1RMtOnH1hJIWMNKAUQHYRzGnT+m8hsB6gqZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 009/168] watchdog: reset last_hw_keepalive time at start
Date:   Tue, 28 Apr 2020 20:23:03 +0200
Message-Id: <20200428182232.852576017@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182231.704304409@linuxfoundation.org>
References: <20200428182231.704304409@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

[ Upstream commit 982bb70517aef2225bad1d802887b733db492cc0 ]

Currently the watchdog core does not initialize the last_hw_keepalive
time during watchdog startup. This will cause the watchdog to be pinged
immediately if enough time has passed from the system boot-up time, and
some types of watchdogs like K3 RTI does not like this.

To avoid the issue, setup the last_hw_keepalive time during watchdog
startup.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20200302200426.6492-3-t-kristo@ti.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/watchdog_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ce04edc69e5f0..c4147e93aa7d4 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -282,6 +282,7 @@ static int watchdog_start(struct watchdog_device *wdd)
 	if (err == 0) {
 		set_bit(WDOG_ACTIVE, &wdd->status);
 		wd_data->last_keepalive = started_at;
+		wd_data->last_hw_keepalive = started_at;
 		watchdog_update_worker(wdd);
 	}
 
-- 
2.20.1



