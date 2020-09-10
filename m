Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B15CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB41321D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Dl/XEoko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgIJCwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:52:44 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48742 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729135AbgIJCwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:52:05 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1A5A4806B5;
        Thu, 10 Sep 2020 14:51:57 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1599706317;
        bh=lQhwDjP6TNS2Ik4pBM/Zgt2mpKx73CO14Av4nyUHdV0=;
        h=From:To:Cc:Subject:Date;
        b=Dl/XEokogax91p9/0956kDDlgva9mRwc6HTUWXhpsAx/lat3/xlutBsKDpTbVFWC+
         hEqYYP8vF8ISmzC94Pm95DB9GaK6kbZPV7bmxh3VPQ8bJ9G4MZPsQAYj2q/YP3Fvvy
         5rhUcg450FlhWEg2KjGFKj2+UqY8YVrXWFHPlOwW7bOnTguhu/UZ38UI9mbNUfxCGm
         SQWEz2GE+v8eUwQ9RtC0Q3qPlsJbPPdnp1OHNglBnUDvFHltRAqhmMRtgbmKJegVJE
         JY+wniQ5CRYWMsjy6Nlo6VrwPzrNKYIftExZxiGh5lX128w3ORRTtkVVeYwmi17N42
         t1rHCz85oJdJA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f5994cc0000>; Thu, 10 Sep 2020 14:51:56 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id DC6C913EEBA;
        Thu, 10 Sep 2020 14:51:55 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C3FE5280076; Thu, 10 Sep 2020 14:51:56 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     stern@rowland.harvard.edu, linux@prisktech.co.nz,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] usb: host: ehci-platform: Add workaround for brcm,xgs-iproc-ehci
Date:   Thu, 10 Sep 2020 14:51:53 +1200
Message-Id: <20200910025154.20848-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ehci controller found in some Broadcom switches with integrated SoCs
has an issue which causes a soft lockup with large transfers like you
see when running ext4 on USB3 flash drive.

Port the fix from the Broadcom XLDK to increase the OUT_THRESHOLD to
avoid the problem.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

I don't have much data on what this change does. I can say it is needed t=
o
avoid a soft lockup when using a USB3 Flash drive formatted has ext4 (USB=
2 +
ext4 is OK, USB3 + fat is OK). I presume the affected combination ends up=
 using
larger transfers triggering the problem.

The equivalent change in the Broadcom XLDK is

	if (IS_ENABLED(CONFIG_USB_EHCI_XGS_IPROC))
		ehci_writel(ehci, BCM_USB_FIFO_THRESHOLD,
				&ehci->regs->reserved4[6]);

This is problematic because it would unconditionally apply to all ehci
controllers whenever CONFIG_USB_EHCI_XGS_IPROC is enabled (also reserved4=
 only
goes to 6 so technically it's indexing off the end of the array).

I wasn't sure if I should add a new property or somehow detect the affect=
ed
host controller. I settled on using of_device_is_compatible() as that see=
med
the simplest thing to do.

 drivers/usb/host/ehci-platform.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-pla=
tform.c
index 006c4f6188a5..0d2de8faa3c1 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -53,6 +53,9 @@ struct ehci_platform_priv {
=20
 static const char hcd_name[] =3D "ehci-platform";
=20
+#define bcm_iproc_insnreg01	hostpc
+#define BCM_USB_FIFO_THRESHOLD	0x00800040
+
 static int ehci_platform_reset(struct usb_hcd *hcd)
 {
 	struct platform_device *pdev =3D to_platform_device(hcd->self.controlle=
r);
@@ -358,6 +361,9 @@ static int ehci_platform_probe(struct platform_device=
 *dev)
=20
 	device_wakeup_enable(hcd->self.controller);
 	device_enable_async_suspend(hcd->self.controller);
+	if (of_device_is_compatible(dev->dev.of_node, "brcm,xgs-iproc-ehci"))
+		ehci_writel(ehci, BCM_USB_FIFO_THRESHOLD,
+			    ehci->regs->bcm_iproc_insnreg01);
 	platform_set_drvdata(dev, hcd);
=20
 	if (priv->quirk_poll)
--=20
2.28.0

