Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68704C433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378F2206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261382;
	bh=uxgiLrPwE+1KncKw8nOE/x3oZx+zoqFLGSh3HBSla0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ANeyPSQ5VXM/7ipQFof0rVkV3SWS72cF+O99uuERSPqBBX8kWIR4ZyvZrh+CT6KJR
	 l8P68op2d5Qyp80PlfGvcbDy/7qyxmcBhPu+2BdxkXepPodALe3KIxUItAbV9pKq51
	 4W/6Htylm8Zn1PPyuxAunyYJU9N8xSCg3Wc6tGy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbgGTQJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387535AbgGTQJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:09:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E7CE22CBB;
        Mon, 20 Jul 2020 16:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261373;
        bh=uxgiLrPwE+1KncKw8nOE/x3oZx+zoqFLGSh3HBSla0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZSOLANGFTCzSrOVmbW5RipjsU/pjSo0O30IgkWclGKJ/IpbplE6dkzLuc9qSlyFOu
         cYijCIr8xDFTeNgCH1gM1Ejcn28H71FR/LSmWD45+ObzQuQ6svhVRIwfwo1Vglgybm
         qT62E3fUxh2GdscZyz6Om7hbKQNa8xTys4l6hJYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 092/244] bus: ti-sysc: Fix sleeping function called from invalid context for RTC quirk
Date:   Mon, 20 Jul 2020 17:36:03 +0200
Message-Id: <20200720152830.213947600@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit afe6f1eeb08f85e57f0a02b71efb5a0839606aac ]

With CONFIG_DEBUG_ATOMIC_SLEEP enabled we can see the following with RTC probe:

BUG: sleeping function called from invalid context at drivers/bus/ti-sysc.c:1736
...
(sysc_quirk_rtc) from [<c060d01c>] (sysc_write_sysconfig+0x1c/0x60)
(sysc_write_sysconfig) from [<c060d9f4>] (sysc_enable_module+0x11c/0x274)
(sysc_enable_module) from [<c060f37c>] (sysc_probe+0xe9c/0x1380)
(sysc_probe) from [<c06e9384>] (platform_drv_probe+0x48/0x98)

Fixes: e8639e1c986a ("bus: ti-sysc: Handle module unlock quirk needed for some RTC")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index a160c3a1f09a3..a3a279f30177c 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1727,8 +1727,8 @@ static void sysc_quirk_rtc(struct sysc *ddata, bool lock)
 
 	local_irq_save(flags);
 	/* RTC_STATUS BUSY bit may stay active for 1/32768 seconds (~30 usec) */
-	error = readl_poll_timeout(ddata->module_va + 0x44, val,
-				   !(val & BIT(0)), 100, 50);
+	error = readl_poll_timeout_atomic(ddata->module_va + 0x44, val,
+					  !(val & BIT(0)), 100, 50);
 	if (error)
 		dev_warn(ddata->dev, "rtc busy timeout\n");
 	/* Now we have ~15 microseconds to read/write various registers */
-- 
2.25.1



