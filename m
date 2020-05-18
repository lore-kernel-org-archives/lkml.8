Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1518DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D4320671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824093;
	bh=BbIyYrkkIGh6hehJIAtPxyWW6nXk8aZrtvgFaM+FyQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xHZDEHYpTx1ekguVCgMcuWWsLXRajNP3USIdWFmTD4D80mbKPCLtvBzrv0Xb4FIIO
	 MDhLZzAOXFwCBsPzSBiLteKi6CPSB0+e79zuJehVd6+NIvq1aaLieEOnprGkI4r+dU
	 cWYjb9TOpCidFOFB8mhN06g2NfO5jWKws3QIkxJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbgERRsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730320AbgERRsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:48:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D0CB20835;
        Mon, 18 May 2020 17:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824085;
        bh=BbIyYrkkIGh6hehJIAtPxyWW6nXk8aZrtvgFaM+FyQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffET2ZVUzlSxQ2WckV3qduNXddAVjABDZNBJ6H/267HByfrmmkNP3TTgQ+XXiH892
         Jp6EIVo1E37GYkM7W32fIxmH9xUM5eKPtsj9dGfGLc/OB5DkmcCLDAWGViZKbFuOY3
         +sBsFCscpOX4bHWDxufV++2Gh4iu3+yzwZccF/bo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Grace Kao <grace.kao@intel.com>,
        Brian Norris <briannorris@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 065/114] pinctrl: cherryview: Add missing spinlock usage in chv_gpio_irq_handler
Date:   Mon, 18 May 2020 19:36:37 +0200
Message-Id: <20200518173514.871102598@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grace Kao <grace.kao@intel.com>

[ Upstream commit 69388e15f5078c961b9e5319e22baea4c57deff1 ]

According to Braswell NDA Specification Update (#557593),
concurrent read accesses may result in returning 0xffffffff and write
instructions may be dropped. We have an established format for the
commit references, i.e.
cdca06e4e859 ("pinctrl: baytrail: Add missing spinlock usage in
byt_gpio_irq_handler")

Fixes: 0bd50d719b00 ("pinctrl: cherryview: prevent concurrent access to GPIO controllers")
Signed-off-by: Grace Kao <grace.kao@intel.com>
Reported-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 0907531a02caa..d39718b4242d9 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1514,11 +1514,15 @@ static void chv_gpio_irq_handler(struct irq_desc *desc)
 	struct chv_pinctrl *pctrl = gpiochip_get_data(gc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned long pending;
+	unsigned long flags;
 	u32 intr_line;
 
 	chained_irq_enter(chip, desc);
 
+	raw_spin_lock_irqsave(&chv_lock, flags);
 	pending = readl(pctrl->regs + CHV_INTSTAT);
+	raw_spin_unlock_irqrestore(&chv_lock, flags);
+
 	for_each_set_bit(intr_line, &pending, pctrl->community->nirqs) {
 		unsigned irq, offset;
 
-- 
2.20.1



