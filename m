Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D1C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B78B24676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996915;
	bh=Pyw5wxchVN35tiTMs8UXgw3fopnjWReBFHBylqdnMyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iM+fxe9F/oRUNAGoMXTfQH9b/hXp2X99NKWHNSEgS+15xuqnEvWRR//5VukOvaoOn
	 M2h5KE0m18OWv7bd2yza2F6KxiWiS2OqnYhqp2Z7E0StjUrfugzLyJlpPgOq1y6Olh
	 3j7+g0N1u0YUhbBcjUHF0geSCg8RHUyf1lF0Cfq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbgANKPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:15:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731185AbgANKLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:11:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C1824677;
        Tue, 14 Jan 2020 10:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996681;
        bh=Pyw5wxchVN35tiTMs8UXgw3fopnjWReBFHBylqdnMyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItGiZm5e2gxL67uRre4MwuXIwY04a9x9LNIVijuoHduUEMbsofev0+YjxnQ7PbxOA
         hBUilPa++z2JJUGGoSQke86RiU3OEO2RsOFAH51hdwTW2PR3gO8vW/ohUPNDCrIkyF
         8wyy+2/qDQJ0zYC/BlZqrSjNclUSYZUMqrTs0Fx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.9 18/31] usb: musb: fix idling for suspend after disconnect interrupt
Date:   Tue, 14 Jan 2020 11:02:10 +0100
Message-Id: <20200114094343.362195429@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094334.725604663@linuxfoundation.org>
References: <20200114094334.725604663@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

commit 5fbf7a2534703fd71159d3d71504b0ad01b43394 upstream.

When disconnected as USB B-device, suspend interrupt should come before
diconnect interrupt, because the DP/DM pins are shorter than the
VBUS/GND pins on the USB connectors. But we sometimes get a suspend
interrupt after disconnect interrupt. In that case we have devctl set to
99 with VBUS still valid and musb_pm_runtime_check_session() wrongly
thinks we have an active session. We have no other interrupts after
disconnect coming in this case at least with the omap2430 glue.

Let's fix the issue by checking the interrupt status again with
delayed work for the devctl 99 case. In the suspend after disconnect
case the devctl session bit has cleared by then and musb can idle.
For a typical USB B-device connect case we just continue with normal
interrupts.

Fixes: 467d5c980709 ("usb: musb: Implement session bit based runtime PM for musb-core")

Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Bin Liu <b-liu@ti.com>
Link: https://lore.kernel.org/r/20200107152625.857-2-b-liu@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1832,6 +1832,9 @@ static const struct attribute_group musb
 #define MUSB_QUIRK_B_INVALID_VBUS_91	(MUSB_DEVCTL_BDEVICE | \
 					 (2 << MUSB_DEVCTL_VBUS_SHIFT) | \
 					 MUSB_DEVCTL_SESSION)
+#define MUSB_QUIRK_B_DISCONNECT_99	(MUSB_DEVCTL_BDEVICE | \
+					 (3 << MUSB_DEVCTL_VBUS_SHIFT) | \
+					 MUSB_DEVCTL_SESSION)
 #define MUSB_QUIRK_A_DISCONNECT_19	((3 << MUSB_DEVCTL_VBUS_SHIFT) | \
 					 MUSB_DEVCTL_SESSION)
 
@@ -1854,6 +1857,11 @@ static void musb_pm_runtime_check_sessio
 	s = MUSB_DEVCTL_FSDEV | MUSB_DEVCTL_LSDEV |
 		MUSB_DEVCTL_HR;
 	switch (devctl & ~s) {
+	case MUSB_QUIRK_B_DISCONNECT_99:
+		musb_dbg(musb, "Poll devctl in case of suspend after disconnect\n");
+		schedule_delayed_work(&musb->irq_work,
+				      msecs_to_jiffies(1000));
+		break;
 	case MUSB_QUIRK_B_INVALID_VBUS_91:
 		if (musb->quirk_retries--) {
 			musb_dbg(musb,


