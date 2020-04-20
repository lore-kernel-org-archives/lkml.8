Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AE2C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3302070B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386404;
	bh=DSUepHg9aX4y6qRmRkTuw/85pmvXZiSkSb8A/au42ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N2ztN4QvaXsglLcDG51LyYU19DNEzUGStaCG9MPqM1feTtyEKIBlU1FcH7+kS79oi
	 SA1/qukJ5UYIUlddJdSbYo8zxG57Amvxg8/+r5mS1+xIFhJhQy/0Yyfvx74Traggsz
	 YiV025R6RG/7R/ruCdeabg5lqWDtU9NrxzzDendw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgDTMkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgDTMkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:40:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78605206D4;
        Mon, 20 Apr 2020 12:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386402;
        bh=DSUepHg9aX4y6qRmRkTuw/85pmvXZiSkSb8A/au42ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQ97OtB56nI3jo8YTl6GOyiduay6ndtd03LV6Aii/egq5SdT6hkze8dWQDImrGVQU
         HnS8/HqCDPRrHLuGWxUi84iQ02AR+HYkxTNbINPp5PQgE3lxzCMEWX+oqgZychPYe3
         01HMSYZ+/DWTIenHEISr4+2p3IlJJSuftazu6IKg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 01/65] amd-xgbe: Use __napi_schedule() in BH context
Date:   Mon, 20 Apr 2020 14:38:05 +0200
Message-Id: <20200420121506.241926911@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121505.909671922@linuxfoundation.org>
References: <20200420121505.909671922@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit d518691cbd3be3dae218e05cca3f3fc9b2f1aa77 ]

The driver uses __napi_schedule_irqoff() which is fine as long as it is
invoked with disabled interrupts by everybody. Since the commit
mentioned below the driver may invoke xgbe_isr_task() in tasklet/softirq
context. This may lead to list corruption if another driver uses
__napi_schedule_irqoff() in IRQ context.

Use __napi_schedule() which safe to use from IRQ and softirq context.

Fixes: 85b85c853401d ("amd-xgbe: Re-issue interrupt if interrupt status not cleared")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -514,7 +514,7 @@ static void xgbe_isr_task(unsigned long
 				xgbe_disable_rx_tx_ints(pdata);
 
 				/* Turn on polling */
-				__napi_schedule_irqoff(&pdata->napi);
+				__napi_schedule(&pdata->napi);
 			}
 		} else {
 			/* Don't clear Rx/Tx status if doing per channel DMA


