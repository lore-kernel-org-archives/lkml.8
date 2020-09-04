Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039DEC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C630F206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="zmR7hY9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgIDDX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:23:28 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:42875 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbgIDDXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:23:05 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C95FC806B5;
        Fri,  4 Sep 2020 15:22:59 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1599189779;
        bh=n+fBehIe1ELC+DWrAylntGDT22Q6opsy+sjhUKzMBTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=zmR7hY9RAp+EoSGFYTC79ccQLt0bN0Ny7aQUZGaCUAFNpJAcq09sGF0GidoMI+ucD
         YaFSJC2UWTq+Ldn4FT2R0wNEkE0h8Ch5yhhVSfRKFjjeJuGqyHKSgek9FiyBPVZ1hK
         1O/hUp7SJEqFQUsWFpV2yP3pLPqS8VjwXXp5NAD3OTgW4NFVJR1OioyAQrNVxsbFjO
         R3UuZSLkZIj+7dz0G3vyZa1AgROutI2uNRgn1oNbTzHWCUsIT8sorGc1PXTNQSko5J
         xZVL+PzGTzT1mculkiM7KT5F+yE6eivWNoHrABIQkcufTiU1oTbGj6KICQY16uGCwf
         Nv9pwDa1tRxHw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f51b3130000>; Fri, 04 Sep 2020 15:22:59 +1200
Received: from hamishm-dl.ws.atlnz.lc (hamishm-dl.ws.atlnz.lc [10.33.24.30])
        by smtp (Postfix) with ESMTP id 5B5EF13EF39;
        Fri,  4 Sep 2020 15:22:59 +1200 (NZST)
Received: by hamishm-dl.ws.atlnz.lc (Postfix, from userid 1133)
        id A1CD22A06EA; Fri,  4 Sep 2020 15:22:59 +1200 (NZST)
From:   Hamish Martin <hamish.martin@alliedtelesis.co.nz>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: [PATCH 1/2] usb: ohci: Add per-port overcurrent quirk
Date:   Fri,  4 Sep 2020 15:22:46 +1200
Message-Id: <20200904032247.11345-2-hamish.martin@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904032247.11345-1-hamish.martin@alliedtelesis.co.nz>
References: <20200904032247.11345-1-hamish.martin@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some integrated OHCI controller hubs do not expose all ports of the hub
to pins on the SoC. In some cases the unconnected ports generate
spurious overcurrent events. For example the Broadcom 56060/Ranger 2 SoC
contains a nominally 3 port hub but only the first port is wired.

Default behaviour for ohci-platform driver is to use "ganged"
overcurrent protection mode. This leads to the spurious overcurrent
events affecting all ports in the hub.

Allow this to be rectified by specifying per-port overcurrent protection
mode via the device tree.

Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
---
 drivers/usb/host/ohci-hcd.c      | 4 ++++
 drivers/usb/host/ohci-platform.c | 3 +++
 drivers/usb/host/ohci.h          | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index dd37e77dae00..01e3d75e29d9 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -687,6 +687,10 @@ static int ohci_run (struct ohci_hcd *ohci)
 		val |=3D RH_A_NPS;
 		ohci_writel (ohci, val, &ohci->regs->roothub.a);
 	}
+	if (ohci->flags & OHCI_QUIRK_PER_PORT_OC) {
+		val |=3D RH_A_OCPM;
+		ohci_writel(ohci, val, &ohci->regs->roothub.a);
+	}
 	ohci_writel (ohci, RH_HS_LPSC, &ohci->regs->roothub.status);
 	ohci_writel (ohci, (val & RH_A_NPS) ? 0 : RH_B_PPCM,
 						&ohci->regs->roothub.b);
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-pla=
tform.c
index 4a8456f12a73..45e69ce4ef86 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -137,6 +137,9 @@ static int ohci_platform_probe(struct platform_device=
 *dev)
 		if (of_property_read_bool(dev->dev.of_node, "no-big-frame-no"))
 			ohci->flags |=3D OHCI_QUIRK_FRAME_NO;
=20
+		if (of_property_read_bool(dev->dev.of_node, "per-port-overcurrent"))
+			ohci->flags |=3D OHCI_QUIRK_PER_PORT_OC;
+
 		if (of_property_read_bool(dev->dev.of_node,
 					  "remote-wakeup-connected"))
 			ohci->hc_control =3D OHCI_CTRL_RWC;
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index aac6285b37f8..9c2bc816246c 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -422,6 +422,7 @@ struct ohci_hcd {
 #define	OHCI_QUIRK_AMD_PREFETCH	0x400			/* pre-fetch for ISO transfer */
 #define	OHCI_QUIRK_GLOBAL_SUSPEND	0x800		/* must suspend ports */
 #define	OHCI_QUIRK_QEMU		0x1000			/* relax timing expectations */
+#define	OHCI_QUIRK_PER_PORT_OC	0x2000			/* per-port overcurrent protecti=
on */
=20
 	// there are also chip quirks/bugs in init logic
=20
--=20
2.28.0

