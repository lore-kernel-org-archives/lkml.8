Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C65C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0734920781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550674;
	bh=LXPWYG4z5+vvrhoERwmekrRYM9JEuLFtWYJbqt8j26E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AX1cJeOB0ko4roKulwulAAQ1GzwdkVe76yYPvn8hfTXEs79gWB7VRU2QxqhWxiT3A
	 b+oFTOWTVHbajtLiboL6hD2KfTBQFG96iwDHw/j5bcoaqTVssLt9XpBq32ymiuUZDG
	 tplIBMHh1uG7y2jvSJtwg411TV2auiq3zM0vWxDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgDVKRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbgDVKQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:16:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5590120776;
        Wed, 22 Apr 2020 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550605;
        bh=LXPWYG4z5+vvrhoERwmekrRYM9JEuLFtWYJbqt8j26E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AOi4x8gXhn24bCR04I2SL/Ylttqks707xg+Kk5+q0JX9qYXWInn0G9GxBrgpsdH4n
         d5u1eygxNcle+2adHD3MnRdmEVKUdo0ncxj/+pYcwhFkQ2kMwzkhEqNSJ7jsGb8kp+
         NZ/StNLXMExzkN9s/yPgXrrBfdJemwB3RiI5/D8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [PATCH 5.4 002/118] watchdog: sp805: fix restart handler
Date:   Wed, 22 Apr 2020 11:56:03 +0200
Message-Id: <20200422095031.891914693@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

commit ea104a9e4d3e9ebc26fb78dac35585b142ee288b upstream.

The restart handler is missing two things, first, the registers
has to be unlocked and second there is no synchronization for the
write_relaxed() calls.

This was tested on a custom board with the NXP LS1028A SoC.

Fixes: 6c5c0d48b686c ("watchdog: sp805: add restart handler")
Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20200327162450.28506-1-michael@walle.cc
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/sp805_wdt.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -137,10 +137,14 @@ wdt_restart(struct watchdog_device *wdd,
 {
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
 
+	writel_relaxed(UNLOCK, wdt->base + WDTLOCK);
 	writel_relaxed(0, wdt->base + WDTCONTROL);
 	writel_relaxed(0, wdt->base + WDTLOAD);
 	writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base + WDTCONTROL);
 
+	/* Flush posted writes. */
+	readl_relaxed(wdt->base + WDTLOCK);
+
 	return 0;
 }
 


