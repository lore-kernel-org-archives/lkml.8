Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC73EC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DDF20768
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgGWNCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:02:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:61780 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGWNCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:02:49 -0400
IronPort-SDR: AkH4X9injq6rkx9snx2C5JxJ/NA4WmfZcJK2QpfkjAOyC8s5Tm7auX9NMvDdRX0XgQEv3gi4Qg
 PjSFb6PrMdiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="168648086"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="168648086"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 06:02:48 -0700
IronPort-SDR: xapzQdPEvgGR106XMuEMU2bGIpG54YPHbgbChrqKg5MUi614W+cpVOJh8HrVDquu6DCam6D88k
 P+RQIomwSLaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="392988022"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jul 2020 06:02:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 28486FC; Thu, 23 Jul 2020 16:02:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mfd: dln2: Run event handler loop under spinlock
Date:   Thu, 23 Jul 2020 16:02:46 +0300
Message-Id: <20200723130246.21190-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/mfd/dln2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 39276fa626d2..83e676a096dc 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -287,7 +287,11 @@ static void dln2_rx(struct urb *urb)
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
2.27.0

