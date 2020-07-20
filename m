Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDEFC433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D467206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261714;
	bh=NF4StOBLCDG8mQH8cb6ujZI8jdwfCXCdaLFQ1SSqCko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HIWZeBs/lkxIHIzrPA3288YB4VgaivRfK0RZP/nMVf7m7uggnlA5IajtMCxvbHFzz
	 OCpPRNcBkh9V2aCFOIC/HDBX4NYlOn3KhnuXrT+GEMXHzfYn1IAaLnrFTgctpxdw9A
	 fxLeVEcpKCiW4pAa3Uf4WcArJ5XdzgqrIYdrtF8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbgGTQPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387493AbgGTQPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:15:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A33F2064B;
        Mon, 20 Jul 2020 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261705;
        bh=NF4StOBLCDG8mQH8cb6ujZI8jdwfCXCdaLFQ1SSqCko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmM42zT2XQSsitgLnFrTQvVIdXn/Sqa7f6iwrNwcYvXaJeOjSb7xD5zsNrne9UEbB
         pyj6/oDQTjMdgLZ4zRnqX36scA6WM0TCopzwqglTPI3SgODkXraD29lN2gNyRzk9GL
         cvCWIZxr8ukLmyL7UMpzdKd0/kPqhYViJRc74nhM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 5.7 172/244] tty: serial: cpm_uart: Fix behaviour for non existing GPIOs
Date:   Mon, 20 Jul 2020 17:37:23 +0200
Message-Id: <20200720152834.016744811@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

commit 311eab8d5900ea9088513d4c6b4570058958edb5 upstream.

devm_gpiod_get_index() doesn't return NULL but -ENOENT when the
requested GPIO doesn't exist,  leading to the following messages:

[    2.742468] gpiod_direction_input: invalid GPIO (errorpointer)
[    2.748147] can't set direction for gpio #2: -2
[    2.753081] gpiod_direction_input: invalid GPIO (errorpointer)
[    2.758724] can't set direction for gpio #3: -2
[    2.763666] gpiod_direction_output: invalid GPIO (errorpointer)
[    2.769394] can't set direction for gpio #4: -2
[    2.774341] gpiod_direction_input: invalid GPIO (errorpointer)
[    2.779981] can't set direction for gpio #5: -2
[    2.784545] ff000a20.serial: ttyCPM1 at MMIO 0xfff00a20 (irq = 39, base_baud = 8250000) is a CPM UART

Use devm_gpiod_get_index_optional() instead.

At the same time, handle the error case and properly exit
with an error.

Fixes: 97cbaf2c829b ("tty: serial: cpm_uart: Convert to use GPIO descriptors")
Cc: stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/694a25fdce548c5ee8b060ef6a4b02746b8f25c0.1591986307.git.christophe.leroy@csgroup.eu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1215,7 +1215,12 @@ static int cpm_uart_init_port(struct dev
 
 		pinfo->gpios[i] = NULL;
 
-		gpiod = devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
+		gpiod = devm_gpiod_get_index_optional(dev, NULL, i, GPIOD_ASIS);
+
+		if (IS_ERR(gpiod)) {
+			ret = PTR_ERR(gpiod);
+			goto out_irq;
+		}
 
 		if (gpiod) {
 			if (i == GPIO_RTS || i == GPIO_DTR)
@@ -1237,6 +1242,8 @@ static int cpm_uart_init_port(struct dev
 
 	return cpm_uart_request_port(&pinfo->port);
 
+out_irq:
+	irq_dispose_mapping(pinfo->port.irq);
 out_pram:
 	cpm_uart_unmap_pram(pinfo, pram);
 out_mem:


