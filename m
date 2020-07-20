Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2115DC433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58A920684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260895;
	bh=D3DKfcGdI+dpiadX52RhTxHGjQfXC+iZ3qW+5yEogE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jUYSIim12v0zUkkKndee8VVuCW3UVaUwGBg2+pbr7hch+jffyAkSyI7kdqeqwmR/6
	 Ydb3OydPy90Odva2RUDz2JYkSOQ9P9X7dhG6IYSfH44wXy0jrZaXvRDNkkBhHv6gUF
	 8Br04J22glCtCRl+Z40cbnkCAhJNIsc1lEKdXip4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbgGTQBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732061AbgGTQBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:01:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C64D820672;
        Mon, 20 Jul 2020 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260885;
        bh=D3DKfcGdI+dpiadX52RhTxHGjQfXC+iZ3qW+5yEogE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJSGvB7i5CeWzi/59cybItM3osg6DApV3nrHY+KBh87Lgd0EqwTjHtmVUl8G9+2+C
         iz/E8GuSQj4pgis16g62KQEUlwbfm5NX+0fS9uFuSqdNglpm4bRcH+fsaO4JnvBOBt
         h0+BmZuTQbcKil/bWsFWketcxW7zWrLrODWTghmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 100/215] bus: ti-sysc: Fix sleeping function called from invalid context for RTC quirk
Date:   Mon, 20 Jul 2020 17:36:22 +0200
Message-Id: <20200720152824.967061836@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
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
index da586d75962fd..76e749dfc4fd1 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1571,8 +1571,8 @@ static void sysc_quirk_rtc(struct sysc *ddata, bool lock)
 
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



