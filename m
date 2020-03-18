Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AC5C5ACD8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4552920753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCRIfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:35:23 -0400
Received: from comms.puri.sm ([159.203.221.185]:55288 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgCRIfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 04:35:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 33C99DFBC8;
        Wed, 18 Mar 2020 01:35:22 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nDDoW9hT1CA6; Wed, 18 Mar 2020 01:35:21 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     balbi@kernel.org, robh@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 1/2] usb: dwc3: support continuous runtime PM with dual role
Date:   Wed, 18 Mar 2020 09:35:07 +0100
Message-Id: <20200318083508.20781-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRD module calls dwc3_set_mode() on role switches, i.e. when a device is
being pugged in. In order to support continuous runtime power management when
plugging in / unplugging a cable, we need to call pm_runtime_get() in this path.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/usb/dwc3/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index edc17155cb2b..7743c4de82e9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -196,11 +196,16 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 {
 	unsigned long flags;
 
+	pm_runtime_get(dwc->dev);
+
 	spin_lock_irqsave(&dwc->lock, flags);
 	dwc->desired_dr_role = mode;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	queue_work(system_freezable_wq, &dwc->drd_work);
+
+	pm_runtime_mark_last_busy(dwc->dev);
+	pm_runtime_put_autosuspend(dwc->dev);
 }
 
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
-- 
2.20.1

