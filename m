Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DFAC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0813C2468E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844424;
	bh=F+0TqD+X8sIsI6owgc1H/U6SPBKg/yevNWDS2WQHKNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h44xmOnRo5P2IhHLP/fEhO5V3QwSOHp5q+EhXNXwoTxrjvIo9ghdnT60JIr5/qZBA
	 HaB4Xfj4/XNzudw2NQW2GBVTWhnAJ2ZdG+dwvCcnFKVBdzCHHFLU0okuZwpy/FFYQ8
	 CrhecT2x368sGYCQ+o7Gw9hErJTHLs38l8nFxiBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgCJMq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbgCJMqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:46:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EC822468D;
        Tue, 10 Mar 2020 12:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844410;
        bh=F+0TqD+X8sIsI6owgc1H/U6SPBKg/yevNWDS2WQHKNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2A4n+pYWBbqBWN2h69feSKkLY30lHrD/vvmmgs75piAKwfz3CLsXodpgS7/jZ6zQ
         W0tS1VppiBjPcvNq74fxlysFWADXkJ+4CklQhUmlBZN7eOMaQ+gWb5H1oQB3xH1Aax
         pGR76PvjbCp0f38h464HxKa3HTyhertf0MGj4uDE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, tangbin <tangbin@cmss.chinamobile.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4.9 70/88] tty:serial:mvebu-uart:fix a wrong return
Date:   Tue, 10 Mar 2020 13:39:18 +0100
Message-Id: <20200310123623.232186664@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
References: <20200310123606.543939933@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tangbin <tangbin@cmss.chinamobile.com>

commit 4a3e208474204e879d22a310b244cb2f39e5b1f8 upstream.

in this place, the function should return a
negative value and the PTR_ERR already returns
a negative,so return -PTR_ERR() is wrong.

Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Jiri Slaby <jslaby@suse.cz>
Link: https://lore.kernel.org/r/20200305013823.20976-1-tangbin@cmss.chinamobile.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/mvebu-uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -581,7 +581,7 @@ static int mvebu_uart_probe(struct platf
 
 	port->membase = devm_ioremap_resource(&pdev->dev, reg);
 	if (IS_ERR(port->membase))
-		return -PTR_ERR(port->membase);
+		return PTR_ERR(port->membase);
 
 	data = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_uart_data),
 			    GFP_KERNEL);


