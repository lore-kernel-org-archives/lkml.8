Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19793C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 03:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F5E20EDD
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 03:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="KRsh+Fsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgIID5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 23:57:49 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47666 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgIID5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 23:57:48 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A5811806B5;
        Wed,  9 Sep 2020 15:57:44 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1599623864;
        bh=oy6vEeRGVNHpSwqfZtf5OR46azHgDDplVuor0K5/zsE=;
        h=From:To:Cc:Subject:Date;
        b=KRsh+FspnOx9utk291uXAxP36UC1ZjZOIy0vO4fecPF3DJPlmrsudXQW8vyFDGHjw
         hlfqmF0dC1o/h0sGXFkf6RqAkHYntDRbIhzC6Rlv3WpHrguxMQ7D28fgfzPQ2VK2mM
         dvOyu/AWgnAlp+9jSKPeXYGAQLjCxjtZK73D3Eaa4+EK6PKYSOK9sAnxqqpFD0TLQd
         E+MVxBsWhpGHUO5OiQqbDeNaFarrAyz7wghcLTNiXloowo+x4uBhHYtWDVLsNFjwvy
         VUMu3DmLX7yKGnWuu3avTPREeTwjlAExYFukUfzDPov7MneyZsJv0tVPuqvozTWSG0
         VzobQBtUaH7tw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f5852b90000>; Wed, 09 Sep 2020 15:57:45 +1200
Received: from hamishm-dl.ws.atlnz.lc (hamishm-dl.ws.atlnz.lc [10.33.24.30])
        by smtp (Postfix) with ESMTP id 13A2F13EEB7;
        Wed,  9 Sep 2020 15:57:44 +1200 (NZST)
Received: by hamishm-dl.ws.atlnz.lc (Postfix, from userid 1133)
        id 64BEB2A2ADF; Wed,  9 Sep 2020 15:57:44 +1200 (NZST)
From:   Hamish Martin <hamish.martin@alliedtelesis.co.nz>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: [PATCH] usb: ohci: Default to per-port over-current protection
Date:   Wed,  9 Sep 2020 15:57:34 +1200
Message-Id: <20200909035734.22463-1-hamish.martin@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some integrated OHCI controller hubs do not expose all ports of the hub
to pins on the SoC. In some cases the unconnected ports generate
spurious over-current events. For example the Broadcom 56060/Ranger 2 SoC
contains a nominally 3 port hub but only the first port is wired.

Default behaviour for ohci-platform driver is to use global over-current
protection mode (AKA "ganged"). This leads to the spurious over-current
events affecting all ports in the hub.

We now alter the default to use per-port over-current protection.

This patch results in the following configuration changes depending
on quirks:
- For quirk OHCI_QUIRK_SUPERIO no changes. These systems remain set up
  for ganged power switching and no over-current protection.
- For quirk OHCI_QUIRK_AMD756 or OHCI_QUIRK_HUB_POWER power switching
  remains at none, while over-current protection is now guaranteed to be
  set to per-port rather than the previous behaviour where it was either
  none or global over-current protection depending on the value at
  function entry.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
---
 drivers/usb/host/ohci-hcd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index dd37e77dae00..8ab81f6ab150 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -673,20 +673,25 @@ static int ohci_run (struct ohci_hcd *ohci)
=20
 	/* handle root hub init quirks ... */
 	val =3D roothub_a (ohci);
-	val &=3D ~(RH_A_PSM | RH_A_OCPM);
+	/* Configure for per-port over-current protection by default */
+	val &=3D ~RH_A_NOCP;
+	val |=3D RH_A_OCPM;
 	if (ohci->flags & OHCI_QUIRK_SUPERIO) {
-		/* NSC 87560 and maybe others */
+		/* NSC 87560 and maybe others.
+		 * Ganged power switching, no over-current protection.
+		 */
 		val |=3D RH_A_NOCP;
-		val &=3D ~(RH_A_POTPGT | RH_A_NPS);
-		ohci_writel (ohci, val, &ohci->regs->roothub.a);
+		val &=3D ~(RH_A_POTPGT | RH_A_NPS | RH_A_PSM | RH_A_OCPM);
 	} else if ((ohci->flags & OHCI_QUIRK_AMD756) ||
 			(ohci->flags & OHCI_QUIRK_HUB_POWER)) {
 		/* hub power always on; required for AMD-756 and some
-		 * Mac platforms.  ganged overcurrent reporting, if any.
+		 * Mac platforms.
 		 */
+		val &=3D ~RH_A_PSM;
 		val |=3D RH_A_NPS;
-		ohci_writel (ohci, val, &ohci->regs->roothub.a);
 	}
+	ohci_writel(ohci, val, &ohci->regs->roothub.a);
+
 	ohci_writel (ohci, RH_HS_LPSC, &ohci->regs->roothub.status);
 	ohci_writel (ohci, (val & RH_A_NPS) ? 0 : RH_B_PPCM,
 						&ohci->regs->roothub.b);
--=20
2.28.0

