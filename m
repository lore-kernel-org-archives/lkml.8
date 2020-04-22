Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD62C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 473082070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550203;
	bh=rS6fAOwtq53TVDt14sPui+9k4apRV1Z1cq2QWyeB4ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yUn1KIdXjWen+o99NePQKTc/BmAAJVOvA9GF2iz7TmX9U7YYoV4y90SLGXqOJH7Lv
	 VH2pHmszLuD4WHV6DFFqGy/wLMfwE3ytM8AWh1XyZYJC1pgjIm7/U1hpaNDgyp9hMZ
	 2r9qQH74HHY+P/eb49mcse0cevQdg8X0xlL0XUL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgDVKKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgDVKJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:09:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6F8B2070B;
        Wed, 22 Apr 2020 10:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550192;
        bh=rS6fAOwtq53TVDt14sPui+9k4apRV1Z1cq2QWyeB4ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GIPypwZvgTsc4yRn8b/TWt2m5AcboBWdqN2ZZVGIZeAjxwOSbk2Z24oQBWdCoD8Kq
         DaFwaimRy7bC+cImRXtB4AbDSiYA9iGoBFaWyHG3+a38tIoOWjBp2s78BtkzEqEzX8
         VHnxODIsH1tZuYtKlq3B8KcVS2sZbZ1xlSK8eIoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benoit Parrot <bparrot@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 4.14 045/199] media: ti-vpe: cal: fix disable_irqs to only the intended target
Date:   Wed, 22 Apr 2020 11:56:11 +0200
Message-Id: <20200422095102.448080976@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
References: <20200422095057.806111593@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benoit Parrot <bparrot@ti.com>

commit 1db56284b9da9056093681f28db48a09a243274b upstream.

disable_irqs() was mistakenly disabling all interrupts when called.
This cause all port stream to stop even if only stopping one of them.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Benoit Parrot <bparrot@ti.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/ti-vpe/cal.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/media/platform/ti-vpe/cal.c
+++ b/drivers/media/platform/ti-vpe/cal.c
@@ -544,16 +544,16 @@ static void enable_irqs(struct cal_ctx *
 
 static void disable_irqs(struct cal_ctx *ctx)
 {
+	u32 val;
+
 	/* Disable IRQ_WDMA_END 0/1 */
-	reg_write_field(ctx->dev,
-			CAL_HL_IRQENABLE_CLR(2),
-			CAL_HL_IRQ_CLEAR,
-			CAL_HL_IRQ_MASK(ctx->csi2_port));
+	val = 0;
+	set_field(&val, CAL_HL_IRQ_CLEAR, CAL_HL_IRQ_MASK(ctx->csi2_port));
+	reg_write(ctx->dev, CAL_HL_IRQENABLE_CLR(2), val);
 	/* Disable IRQ_WDMA_START 0/1 */
-	reg_write_field(ctx->dev,
-			CAL_HL_IRQENABLE_CLR(3),
-			CAL_HL_IRQ_CLEAR,
-			CAL_HL_IRQ_MASK(ctx->csi2_port));
+	val = 0;
+	set_field(&val, CAL_HL_IRQ_CLEAR, CAL_HL_IRQ_MASK(ctx->csi2_port));
+	reg_write(ctx->dev, CAL_HL_IRQENABLE_CLR(3), val);
 	/* Todo: Add VC_IRQ and CSI2_COMPLEXIO_IRQ handling */
 	reg_write(ctx->dev, CAL_CSI2_VC_IRQENABLE(1), 0);
 }


