Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0644C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64A9217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgBHSdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 13:33:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34262 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727897AbgBHS3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 13:29:45 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1j0UrJ-0003fW-W2; Sat, 08 Feb 2020 18:29:38 +0000
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1j0UrJ-000CRP-ET; Sat, 08 Feb 2020 18:29:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Johan Hovold" <johan@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Joel Jennings" <joel.jennings@makeitlabs.com>
Date:   Sat, 08 Feb 2020 18:20:37 +0000
Message-ID: <lsq.1581185940.622677161@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 098/148] usb-serial: cp201x: support Mark-10 digital
 force gauge
In-Reply-To: <lsq.1581185939.857586636@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.82-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 347bc8cb26388791c5881a3775cb14a3f765a674 upstream.

Add support for the Mark-10 digital force gauge device to the cp201x
driver.

Based on a report and a larger patch from Joel Jennings

Reported-by: Joel Jennings <joel.jennings@makeitlabs.com>
Acked-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191118092119.GA153852@kroah.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/cp210x.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -121,6 +121,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x10C4, 0x8341) }, /* Siemens MC35PU GPRS Modem */
 	{ USB_DEVICE(0x10C4, 0x8382) }, /* Cygnal Integrated Products, Inc. */
 	{ USB_DEVICE(0x10C4, 0x83A8) }, /* Amber Wireless AMB2560 */
+	{ USB_DEVICE(0x10C4, 0x83AA) }, /* Mark-10 Digital Force Gauge */
 	{ USB_DEVICE(0x10C4, 0x83D8) }, /* DekTec DTA Plus VHF/UHF Booster/Attenuator */
 	{ USB_DEVICE(0x10C4, 0x8411) }, /* Kyocera GPS Module */
 	{ USB_DEVICE(0x10C4, 0x8418) }, /* IRZ Automation Teleport SG-10 GSM/GPRS Modem */

