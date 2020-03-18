Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90E6C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C478D20738
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCRDGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 23:06:00 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:5484 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgCRDGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:06:00 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2020 23:05:58 EDT
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 0A6584E177F;
        Wed, 18 Mar 2020 10:56:45 +0800 (CST)
From:   Li Tao <tao.li@vivo.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>, Li Tao <tao.li@vivo.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wenhu.wang@vivo.com
Subject: [PATCH] usb: gadget: serial: Fixed KASAN null-ptr-deref in tty_wakeup
Date:   Wed, 18 Mar 2020 10:56:01 +0800
Message-Id: <20200318025606.2058-1-tao.li@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVCQ0pLS0tPSUhPSEpPWVdZKFlBSE
        83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MhA6Nio4Mjg1PDQiOAo0IRwv
        DAoKFD9VSlVKTkNPTktLSUtMTktJVTMWGhIXVQ8aFFUXEjsNEg0UVRgUFkVZV1kSC1lBWU5DVUlO
        SlVMT1VJSU1ZV1kIAVlBSEpIQzcG
X-HM-Tid: 0a70eb9267399376kuws0a6584e177f
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The port->port.tty maybe reset as NULL, If gs_close() was invoked
unexpectedly during running gserial_connect().

BUG: KASAN: null-ptr-deref in tty_wakeup+0x1c/0x84
Call trace:
[<0000000095c3c837>] dump_backtrace+0x0/0x6d4
[<0000000047726bb8>] show_stack+0x18/0x20
[<00000000bedb4c1e>] --dump_stack+0x20/0x28
[<00000000722f2e2a>] dump_stack+0x84/0xb0
[<00000000325683d4>] kasan_report_error+0x178/0x1e4
[<0000000053079998>] kasan_report_error+0x0/0x1e4
[<00000000b6d33afa>] --asan_load8+0x150/0x15c
[<00000000188745b8>] tty_wakeup+0x1c/0x84
[<0000000064f6dd21>] gs_start_io+0xd0/0x11c
[<0000000063d67b6c>] gserial_connect+0x15c/0x1b0
[<00000000faf7c0f9>] dm_set_alt+0xa8/0x190
[<000000008deb1909>] composite_setup+0xde4/0x1edc
[<00000000792ee16d>] android_setup+0x210/0x294
[<00000000ab32ef30>] dwc3_ep0_delegate_req+0x48/0x68
[<0000000054e26fd2>] dwc3_ep0_interrupt+0xf2c/0x16fc
[<0000000050cb2262>] dwc3_interrupt+0x464/0x1f44
[<00000000fdcaa6e9>] --handle_irq_event_percpu+0x184/0x398
[<000000003b24ff56>] handle_irq_event_percpu+0xa0/0x134
[<00000000aedda5ee>] handle_irq_event+0x60/0xa0
[<000000005f51a570>] handle_fasteoi_irq+0x23c/0x31c
[<000000008db2608d>] generic_handle_irq+0x70/0xa4
[<00000000098683fc>] --handle_domain_irq+0x84/0xe0
[<000000008ed23b46>] gic_handle_irq+0x98/0xb8

Signed-off-by: Li Tao <tao.li@vivo.com>
---
 drivers/usb/gadget/function/u_serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 8167d379e115..3c109a8f9ec4 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -565,7 +565,8 @@ static int gs_start_io(struct gs_port *port)
 		gs_start_tx(port);
 		/* Unblock any pending writes into our circular buffer, in case
 		 * we didn't in gs_start_tx() */
-		tty_wakeup(port->port.tty);
+		if (port->port.tty)
+			tty_wakeup(port->port.tty);
 	} else {
 		gs_free_requests(ep, head, &port->read_allocated);
 		gs_free_requests(port->port_usb->in, &port->write_pool,
-- 
2.17.1

