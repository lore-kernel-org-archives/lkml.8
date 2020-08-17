Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B4DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D53920758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691286;
	bh=0AgMrIP7GP2rYQZIrGzD4CARHK1GDj4u+58ZN43cdUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hbbRccx7uXzzglC82TrGrsHnmjz/UuU3dHVCK9DsYrU+Mx3fxz6Qi4w4iQnfiwVoo
	 kC1yTsylcxdYb+AbIJPY18HtMJmRnJ4CoRFhjB2xdyNnIrIjbJLIi+CSoKfA9YHlc2
	 r8I0rzcP2BL4IfJ5HlGXM37/w4fthjM8WXSmzzgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392008AbgHQTIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387634AbgHQPnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:43:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B59D20760;
        Mon, 17 Aug 2020 15:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679001;
        bh=0AgMrIP7GP2rYQZIrGzD4CARHK1GDj4u+58ZN43cdUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxKHEfpmo1x1KXlNOLQA7eQBjCgoyAazhebylocJ+5Oi+DKdnRzcXZVPjB13OY6R8
         dGldD2G5L0wsu2gVsiu4XHNawAOqdudYsogciQ3G9ew4d53dcCpBP729FEXl6Kc0UE
         CDhosyBEeSrPdkZCXS1N4nYtixz4SCNv/nHLTlW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 055/393] irqchip/loongson-liointc: Fix potential dead lock
Date:   Mon, 17 Aug 2020 17:11:45 +0200
Message-Id: <20200817143822.286279142@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



