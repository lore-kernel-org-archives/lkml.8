Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10444C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E0F21974
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgFRJca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:32:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46072 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgFRJc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:32:27 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jlquH-0007MQ-3N; Thu, 18 Jun 2020 09:32:25 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] usb: xhci: fix spelling mistake in Kconfig "firwmare" -> "firmware"
Date:   Thu, 18 Jun 2020 10:32:24 +0100
Message-Id: <20200618093224.10179-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two spelling mistakes in the Kconfig text. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: rework so that it cleanly applies against Greg's current USB repo

---
 drivers/usb/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 1cb3004ea7b2..ab12c4bf0ef1 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -44,10 +44,10 @@ config USB_XHCI_PCI
 	default y
 
 config USB_XHCI_PCI_RENESAS
-	tristate "Support for additional Renesas xHCI controller with firwmare"
+	tristate "Support for additional Renesas xHCI controller with firmware"
 	help
 	  Say 'Y' to enable the support for the Renesas xHCI controller with
-	  firwmare. Make sure you have the firwmare for the device and
+	  firmware. Make sure you have the firwmare for the device and
 	  installed on your system for this device to work.
 	  If unsure, say 'N'.
 
-- 
2.27.0.rc0

