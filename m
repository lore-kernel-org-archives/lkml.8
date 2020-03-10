Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE1BC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CA9208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846191;
	bh=oOarDqXzXEyubzGGeT5kwf3Dt9K29ttw3xnFlPWPUPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LI51YQDpzgmbtzj7ZWyU010MbbvPGWAJ+JO8aTfdmrrrAlAwqVxpSuhBGFywzhn/j
	 rsf0QJUcyQ2YubKUQrqgg5gh/CgjvLUUrbxgQxQaMnMS7dg7odP8Mi/k6fC/6qs3V2
	 IBDzaqqisYCF+o2hKp3BOId8IT4FK10zVzm+MzNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgCJNQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgCJNNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:13:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17AFF2467D;
        Tue, 10 Mar 2020 13:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845990;
        bh=oOarDqXzXEyubzGGeT5kwf3Dt9K29ttw3xnFlPWPUPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pwn78D1eAjH7Nb8vuSITcwV4BVwSBIp+tVU1ncKDuHWxuSqTkdKlJKU+TjsPoJ7yp
         mZBaMSMWBXo8lR0cTVHR8lp6oCbhgKsVx0VFlgbPJ+HipAuJIj0ChtuJpAQgfTtkbj
         aQ7Fgb5ivF4cKBXmht5S8vxNnDBYuzBnDFfselVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH 4.19 47/86] serial: 8250_exar: add support for ACCES cards
Date:   Tue, 10 Mar 2020 13:45:11 +0100
Message-Id: <20200310124533.343814613@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124530.808338541@linuxfoundation.org>
References: <20200310124530.808338541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jay Dolan <jay.dolan@accesio.com>

commit 10c5ccc3c6d32f3d7d6c07de1d3f0f4b52f3e3ab upstream.

Add ACCES VIDs and PIDs that use the Exar chips

Signed-off-by: Jay Dolan <jay.dolan@accesio.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200305140504.22237-1-jay.dolan@accesio.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_exar.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -24,6 +24,14 @@
 
 #include "8250.h"
 
+#define PCI_DEVICE_ID_ACCES_COM_2S		0x1052
+#define PCI_DEVICE_ID_ACCES_COM_4S		0x105d
+#define PCI_DEVICE_ID_ACCES_COM_8S		0x106c
+#define PCI_DEVICE_ID_ACCES_COM232_8		0x10a8
+#define PCI_DEVICE_ID_ACCES_COM_2SM		0x10d2
+#define PCI_DEVICE_ID_ACCES_COM_4SM		0x10db
+#define PCI_DEVICE_ID_ACCES_COM_8SM		0x10ea
+
 #define PCI_DEVICE_ID_COMMTECH_4224PCI335	0x0002
 #define PCI_DEVICE_ID_COMMTECH_4222PCI335	0x0004
 #define PCI_DEVICE_ID_COMMTECH_2324PCI335	0x000a
@@ -571,6 +579,22 @@ static int __maybe_unused exar_resume(st
 
 static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
 
+static const struct exar8250_board acces_com_2x = {
+	.num_ports	= 2,
+	.setup		= pci_xr17c154_setup,
+};
+
+static const struct exar8250_board acces_com_4x = {
+	.num_ports	= 4,
+	.setup		= pci_xr17c154_setup,
+};
+
+static const struct exar8250_board acces_com_8x = {
+	.num_ports	= 8,
+	.setup		= pci_xr17c154_setup,
+};
+
+
 static const struct exar8250_board pbn_fastcom335_2 = {
 	.num_ports	= 2,
 	.setup		= pci_fastcom335_setup,
@@ -639,6 +663,15 @@ static const struct exar8250_board pbn_e
 	}
 
 static const struct pci_device_id exar_pci_tbl[] = {
+	EXAR_DEVICE(ACCESSIO, ACCES_COM_2S, acces_com_2x),
+	EXAR_DEVICE(ACCESSIO, ACCES_COM_4S, acces_com_4x),
+	EXAR_DEVICE(ACCESSIO, ACCES_COM_8S, acces_com_8x),
+	EXAR_DEVICE(ACCESSIO, ACCES_COM232_8, acces_com_8x),
+	EXAR_DEVICE(ACCESSIO, ACCES_COM_2SM, acces_com_2x),
+	EXAR_DEVICE(ACCESSIO, ACCES_COM_4SM, acces_com_4x),
+	EXAR_DEVICE(ACCESSIO, ACCES_COM_8SM, acces_com_8x),
+
+
 	CONNECT_DEVICE(XR17C152, UART_2_232, pbn_connect),
 	CONNECT_DEVICE(XR17C154, UART_4_232, pbn_connect),
 	CONNECT_DEVICE(XR17C158, UART_8_232, pbn_connect),


