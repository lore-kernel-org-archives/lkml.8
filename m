Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9AEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F5720672
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930354;
	bh=0AgMrIP7GP2rYQZIrGzD4CARHK1GDj4u+58ZN43cdUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tc8nL5geGTDK745pOBaXyWuQzHbi5E1gkIuQEhfWf1iaiwnOJTHiWXQ2xbsWBLzNB
	 gYxZv+lFAGIAUJm2KW6wmF2P2+ce47qOGnAFALSCrW5fX2yC/wHICXNRzgtbp+rBXF
	 gcLN40wNv+37NdGzgDxHXcNJPRlKiLQLbPijlm9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgHHXpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:45:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbgHHXif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:38:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6E0B208E4;
        Sat,  8 Aug 2020 23:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929914;
        bh=0AgMrIP7GP2rYQZIrGzD4CARHK1GDj4u+58ZN43cdUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fAKOFLqYQ/ihpcYLgJ9d9MMit65PnTvlzuMoUIKATrRSgGsNi7bJN94w9yt+EVYB/
         db2m7q+T3fghZYlIOM3B3rhVzUUkf6lyqZlRZO39SDrUO3TH6GidvtRMT74a0oI5+p
         yORMBhVay9cL68xOGU2CyDeR42GhM4wtuws2zI+E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 51/58] irqchip/loongson-liointc: Fix potential dead lock
Date:   Sat,  8 Aug 2020 19:37:17 -0400
Message-Id: <20200808233724.3618168-51-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233724.3618168-1-sashal@kernel.org>
References: <20200808233724.3618168-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit fa03587cad9bd32aa552377de4f05c50181a35a8 ]

In the function liointc_set_type(), we need to call the function
irq_gc_unlock_irqrestore() before returning.

Fixes: dbb152267908 ("irqchip: Add driver for Loongson I/O Local Interrupt Controller")
Reported-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1594087972-21715-8-git-send-email-yangtiezhu@loongson.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-loongson-liointc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 63b61474a0cc2..6ef86a334c62d 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -114,6 +114,7 @@ static int liointc_set_type(struct irq_data *data, unsigned int type)
 		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, false);
 		break;
 	default:
+		irq_gc_unlock_irqrestore(gc, flags);
 		return -EINVAL;
 	}
 	irq_gc_unlock_irqrestore(gc, flags);
-- 
2.25.1

