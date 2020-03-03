Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48761C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1332B217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583204075;
	bh=1Ab1FCoddUe1BX9XPSIJ0DoL+dXn+oXOQ+sECh6PTO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=czXlt1kcdRvEdqumHhWD30plDKRP4Z5/PLZ0uRvpM6mr2QYP2LijXK7qqo9Ci+QqI
	 Dv6T1gRoHXwtDHbzsWyhh9w4UGMpMAwmiw6mjH97dEmMSwktF30rHCMNsqT2w8K3Le
	 mEMt+n5DJv8FrfXQh9TfsPv3RsoIZUjErNqZkzs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgCCCtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:49:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728637AbgCCCtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:49:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFF4F246BB;
        Tue,  3 Mar 2020 02:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203740;
        bh=1Ab1FCoddUe1BX9XPSIJ0DoL+dXn+oXOQ+sECh6PTO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GRSNiAb0NXPkFVZqAIqhk6CY8uaOnyYxDtYA/qgLr2V2AEsvgN6S6+JBjqrwcy6nL
         fhJqEuYrOvRDVAb7uCu4yA2gNvDdDZgfTX+dqBe1poGHaG6Gf0546eAn99iti8rQYd
         zQUbkq5XKy0YJ05DCH8SEDWtZo9vWFHE3fP1AbRI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 07/32] usb: gadget: serial: fix Tx stall after buffer overflow
Date:   Mon,  2 Mar 2020 21:48:26 -0500
Message-Id: <20200303024851.10054-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024851.10054-1-sashal@kernel.org>
References: <20200303024851.10054-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Organov <sorganov@gmail.com>

[ Upstream commit e4bfded56cf39b8d02733c1e6ef546b97961e18a ]

Symptom: application opens /dev/ttyGS0 and starts sending (writing) to
it while either USB cable is not connected, or nobody listens on the
other side of the cable. If driver circular buffer overflows before
connection is established, no data will be written to the USB layer
until/unless /dev/ttyGS0 is closed and re-opened again by the
application (the latter besides having no means of being notified about
the event of establishing of the connection.)

Fix: on open and/or connect, kick Tx to flush circular buffer data to
USB layer.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
Reviewed-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/u_serial.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index d4d317db89df5..38afe96c5cd26 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -567,8 +567,10 @@ static int gs_start_io(struct gs_port *port)
 	port->n_read = 0;
 	started = gs_start_rx(port);
 
-	/* unblock any pending writes into our circular buffer */
 	if (started) {
+		gs_start_tx(port);
+		/* Unblock any pending writes into our circular buffer, in case
+		 * we didn't in gs_start_tx() */
 		tty_wakeup(port->port.tty);
 	} else {
 		gs_free_requests(ep, head, &port->read_allocated);
-- 
2.20.1

