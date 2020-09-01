Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ACCC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC5E2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975261;
	bh=RUya4KzYZ3Kazt/S7V1kovWUojhiqJnuKTJaHfXwtTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VwcNNHxCfmO7/bB1Q1LmBMWwZICttlKDPM7HN4YOSrOJAfc66KKXTDkkTciodz3I+
	 fgFhIRR0bkE6nQ1GRNkhJebUeiXoKPgHQuayid1XEHf2y6JF1p9jzFktMSWxoy6VmX
	 bWWQ8oZSVUz0bRZQGAoid1i/SzDEIfbgo3l8CDqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbgIAPrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:47:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731770AbgIAPoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:44:07 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BDA4206EB;
        Tue,  1 Sep 2020 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975046;
        bh=RUya4KzYZ3Kazt/S7V1kovWUojhiqJnuKTJaHfXwtTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uIzfts5eZjtdhlTVDsEZq+4RIxvwOlleSypX2nu1cuFOerI0kBJAg4qD89npEBDvW
         BeqBkYY/wL4PLD0WJjcF5uAB0gvbMVaDcUs//LEtOGjfQp9VU0l72Ndz5wHKWARRH2
         BNH00N5OQwU4I8pkqs/O6B9m0VJYhogcDZODCVBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Aleksey Makarov <amakarov@marvell.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Russell King <linux@armlinux.org.uk>,
        Christopher Covington <cov@codeaurora.org>
Subject: [PATCH 5.8 181/255] serial: pl011: Fix oops on -EPROBE_DEFER
Date:   Tue,  1 Sep 2020 17:10:37 +0200
Message-Id: <20200901151009.358712036@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

commit 27afac93e3bd7fa89749cf11da5d86ac9cde4dba upstream.

If probing of a pl011 gets deferred until after free_initmem(), an oops
ensues because pl011_console_match() is called which has been freed.

Fix by removing the __init attribute from the function and those it
calls.

Commit 10879ae5f12e ("serial: pl011: add console matching function")
introduced pl011_console_match() not just for early consoles but
regular preferred consoles, such as those added by acpi_parse_spcr().
Regular consoles may be registered after free_initmem() for various
reasons, one being deferred probing, another being dynamic enablement
of serial ports using a DeviceTree overlay.

Thus, pl011_console_match() must not be declared __init and the
functions it calls mustn't either.

Stack trace for posterity:

Unable to handle kernel paging request at virtual address 80c38b58
Internal error: Oops: 8000000d [#1] PREEMPT SMP ARM
PC is at pl011_console_match+0x0/0xfc
LR is at register_console+0x150/0x468
[<80187004>] (register_console)
[<805a8184>] (uart_add_one_port)
[<805b2b68>] (pl011_register_port)
[<805b3ce4>] (pl011_probe)
[<80569214>] (amba_probe)
[<805ca088>] (really_probe)
[<805ca2ec>] (driver_probe_device)
[<805ca5b0>] (__device_attach_driver)
[<805c8060>] (bus_for_each_drv)
[<805c9dfc>] (__device_attach)
[<805ca630>] (device_initial_probe)
[<805c90a8>] (bus_probe_device)
[<805c95a8>] (deferred_probe_work_func)

Fixes: 10879ae5f12e ("serial: pl011: add console matching function")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.10+
Cc: Aleksey Makarov <amakarov@marvell.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Christopher Covington <cov@codeaurora.org>
Link: https://lore.kernel.org/r/f827ff09da55b8c57d316a1b008a137677b58921.1597315557.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/amba-pl011.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2241,9 +2241,8 @@ pl011_console_write(struct console *co,
 	clk_disable(uap->clk);
 }
 
-static void __init
-pl011_console_get_options(struct uart_amba_port *uap, int *baud,
-			     int *parity, int *bits)
+static void pl011_console_get_options(struct uart_amba_port *uap, int *baud,
+				      int *parity, int *bits)
 {
 	if (pl011_read(uap, REG_CR) & UART01x_CR_UARTEN) {
 		unsigned int lcr_h, ibrd, fbrd;
@@ -2276,7 +2275,7 @@ pl011_console_get_options(struct uart_am
 	}
 }
 
-static int __init pl011_console_setup(struct console *co, char *options)
+static int pl011_console_setup(struct console *co, char *options)
 {
 	struct uart_amba_port *uap;
 	int baud = 38400;
@@ -2344,8 +2343,8 @@ static int __init pl011_console_setup(st
  *
  *	Returns 0 if console matches; otherwise non-zero to use default matching
  */
-static int __init pl011_console_match(struct console *co, char *name, int idx,
-				      char *options)
+static int pl011_console_match(struct console *co, char *name, int idx,
+			       char *options)
 {
 	unsigned char iotype;
 	resource_size_t addr;


