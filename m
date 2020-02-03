Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178BEC35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68FA20838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747275;
	bh=p2WfEJ8ZKgV4J+cESH1NT9VjmZZwXfOgTWMsFY15Pwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KJYmutYo1UY0+zkodNQy7WghwKR5Jf66OSrx9e7XhpAEnpJ2PTJeNQJErYtfupu3Q
	 1d2NiCu/xN78X+4omiDwSdBqQeOmJGFqYlCOPTJ/WMes3M935KLSYNi4k5B0rlLOob
	 LYHJbl6rIzF4FvstSYDdwEQvb9ssAgTRbs6Q+NK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgBCQ1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:27:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728793AbgBCQ1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:27:46 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00E542051A;
        Mon,  3 Feb 2020 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747265;
        bh=p2WfEJ8ZKgV4J+cESH1NT9VjmZZwXfOgTWMsFY15Pwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBiTzcQsDuJ54+H8R98Ykx5qmF5DDzdGw4ET6xhL1SlIdV1DwahA6hzgjxLIX+Czw
         6l1z3lBNQmSWfIPAXrq24RyTREERrZ4JTWpHqzHh/wRH5ZvASDRhEeXa7BZGP//LN/
         5kOfquXBFRJcJ30uyhxGKBC0XNzeLaeD2HvlAlK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 4.14 12/89] serial: 8250_bcm2835aux: Fix line mismatch on driver unbind
Date:   Mon,  3 Feb 2020 16:18:57 +0000
Message-Id: <20200203161918.499498763@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161916.847439465@linuxfoundation.org>
References: <20200203161916.847439465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

commit dc76697d7e933d5e299116f219c890568785ea15 upstream.

Unbinding the bcm2835aux UART driver raises the following error if the
maximum number of 8250 UARTs is set to 1 (via the 8250.nr_uarts module
parameter or CONFIG_SERIAL_8250_RUNTIME_UARTS):

(NULL device *): Removing wrong port: a6f80333 != fa20408b

That's because bcm2835aux_serial_probe() retrieves UART line number 1
from the devicetree and stores it in data->uart.port.line, while
serial8250_register_8250_port() instead uses UART line number 0,
which is stored in data->line.

On driver unbind, bcm2835aux_serial_remove() uses data->uart.port.line,
which contains the wrong number.  Fix it.

The issue does not occur if the maximum number of 8250 UARTs is >= 2.

Fixes: bdc5f3009580 ("serial: bcm2835: add driver for bcm2835-aux-uart")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.6+
Cc: Martin Sperl <kernel@martin.sperl.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Link: https://lore.kernel.org/r/912ccf553c5258135c6d7e8f404a101ef320f0f4.1579175223.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_bcm2835aux.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -119,7 +119,7 @@ static int bcm2835aux_serial_remove(stru
 {
 	struct bcm2835aux_data *data = platform_get_drvdata(pdev);
 
-	serial8250_unregister_port(data->uart.port.line);
+	serial8250_unregister_port(data->line);
 	clk_disable_unprepare(data->clk);
 
 	return 0;


