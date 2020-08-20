Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF905C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93672078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597925982;
	bh=0QtL807o9NkRWL4R+s8aHKmq0fUx/smANmm7cNR3LnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s//J153RQz+Yzb8xnRhIDBEgTAKjrdSKX7kbExdV8mqpsnoWwXDvi+CiqowmO+17H
	 lTrPQNcOpIUDq59PR/gMEFqwpXQMBl1/dTOPkwNWMXkbbc/cOa025zzPVnwfiBxTA6
	 ETIoZiLc/NsDgxJJYYYMS0nsUcKy0AWddYKfSaZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgHTMTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730239AbgHTJ4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:56:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B758E2078D;
        Thu, 20 Aug 2020 09:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917361;
        bh=0QtL807o9NkRWL4R+s8aHKmq0fUx/smANmm7cNR3LnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdCOrZhFiujoCU42oTuVW6M9yj9ESz6B1R7DDu6yhSoj8IysunqJCAQwHdAj/ulVk
         3F//bwhdTJpWFnNE7qnSiQ+hTnjCv7npr6wOyvBwO0hHbhfhIi9kj4Gr+AuTa7BHq5
         cDqkQSZrpKEtc483V5MKfEOc5YCS7cLz7DPthmtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 83/92] mfd: dln2: Run event handler loop under spinlock
Date:   Thu, 20 Aug 2020 11:22:08 +0200
Message-Id: <20200820091541.964627271@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
References: <20200820091537.490965042@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 3d858942250820b9adc35f963a257481d6d4c81d ]

The event handler loop must be run with interrupts disabled.
Otherwise we will have a warning:

[ 1970.785649] irq 31 handler lineevent_irq_handler+0x0/0x20 enabled interrupts
[ 1970.792739] WARNING: CPU: 0 PID: 0 at kernel/irq/handle.c:159 __handle_irq_event_percpu+0x162/0x170
[ 1970.860732] RIP: 0010:__handle_irq_event_percpu+0x162/0x170
...
[ 1970.946994] Call Trace:
[ 1970.949446]  <IRQ>
[ 1970.951471]  handle_irq_event_percpu+0x2c/0x80
[ 1970.955921]  handle_irq_event+0x23/0x43
[ 1970.959766]  handle_simple_irq+0x57/0x70
[ 1970.963695]  generic_handle_irq+0x42/0x50
[ 1970.967717]  dln2_rx+0xc1/0x210 [dln2]
[ 1970.971479]  ? usb_hcd_unmap_urb_for_dma+0xa6/0x1c0
[ 1970.976362]  __usb_hcd_giveback_urb+0x77/0xe0
[ 1970.980727]  usb_giveback_urb_bh+0x8e/0xe0
[ 1970.984837]  tasklet_action_common.isra.0+0x4a/0xe0
...

Recently xHCI driver switched to tasklets in the commit 36dc01657b49
("usb: host: xhci: Support running urb giveback in tasklet context").

The handle_irq_event_* functions are expected to be called with interrupts
disabled and they rightfully complain here because we run in tasklet context
with interrupts enabled.

Use a event spinlock to protect event handler from being interrupted.

Note, that there are only two users of this GPIO and ADC drivers and both of
them are using generic_handle_irq() which makes above happen.

Fixes: 338a12814297 ("mfd: Add support for Diolan DLN-2 devices")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/dln2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 6ea0dd37b4535..fe614ba5fec90 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -290,7 +290,11 @@ static void dln2_rx(struct urb *urb)
 	len = urb->actual_length - sizeof(struct dln2_header);
 
 	if (handle == DLN2_HANDLE_EVENT) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&dln2->event_cb_lock, flags);
 		dln2_run_event_callbacks(dln2, id, echo, data, len);
+		spin_unlock_irqrestore(&dln2->event_cb_lock, flags);
 	} else {
 		/* URB will be re-submitted in _dln2_transfer (free_rx_slot) */
 		if (dln2_transfer_complete(dln2, urb, handle, echo))
-- 
2.25.1



