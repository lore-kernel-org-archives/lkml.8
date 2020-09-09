Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB76C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE95920757
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mulne7TQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgIIILe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:11:34 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14129 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgIIILY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:11:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f588da40003>; Wed, 09 Sep 2020 01:09:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 01:11:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Sep 2020 01:11:23 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 08:11:20 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 9 Sep 2020 08:11:19 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.100.126]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f588e250003>; Wed, 09 Sep 2020 01:11:19 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v3 15/15] xhci: tegra: Enable ELPG for runtime/system PM
Date:   Wed, 9 Sep 2020 16:10:41 +0800
Message-ID: <20200909081041.3190157-16-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909081041.3190157-1-jckuo@nvidia.com>
References: <20200909081041.3190157-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599638948; bh=tD/5Wp3hSTKebN8Bfr3z8aJvVUzMQzm/8mFortT886Q=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=mulne7TQxiEmgFYQqG11QmvFpLR47lNTv+UdqU7uYVatpsC/lVxPnvfXPd+SVUR7Y
         3M/jjTVCxk8BIhErJdkUCshHOwlBPJsCoyX4CNoPT3Pht3bqaihRvgXlPX9XmdVXaV
         7ESevDTYnG41rRbUtn8NlO1kX3aMRfxIZdOo8ZluBFtG15AoswvVdUh4LGpDEzXm75
         ChKm85FpAHUFPKxICY6z3dSafNeNpTBrPcudgmj8iyYpI2RNEPTOSRLMlsNwh33hGs
         6tU1hkVbM5knOkvZP2DyiZzT8WV1aQ/oBbRqVr6zYBxLo5pE7jGjlEmMxRzMMw2QsM
         Wcno2TTW6r+nQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements the complete programming sequence for ELPG
entry and exit.

 1. At ELPG entry, invokes tegra_xusb_padctl_enable_phy_sleepwalk()
    and tegra_xusb_padctl_enable_phy_wake() to configure XUSB PADCTL
    sleepwalk and wake detection circuits to maintain USB lines level
    and respond to wake events (wake-on-connect, wake-on-disconnect,
    device-initiated-wake).

 2. At ELPG exit, invokes tegra_xusb_padctl_disable_phy_sleepwalk()
    and tegra_xusb_padctl_disable_phy_wake() to disarm sleepwalk and
    wake detection circuits.

At runtime suspend, XUSB host controller can enter ELPG to reduce
power consumption. When XUSB PADCTL wake detection circuit detects
a wake event, an interrupt will be raised. xhci-tegra driver then
will invoke pm_runtime_resume() for xhci-tegra.

Runtime resume could also be triggered by protocol drivers, this is
the host-initiated-wake event. At runtime resume, xhci-tegra driver
brings XUSB host controller out of ELPG to handle the wake events.

The same ELPG enter/exit procedure will be performed for system
suspend/resume path so USB devices can remain connected across SC7.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
v3:
   use 'unsigned int' for PHY index
   remove unnecessary 'else'
   drop IRQF_TRIGGER_HIGH when invokes devm_request_threaded_irq()
  =20
 drivers/usb/host/xhci-tegra.c | 389 +++++++++++++++++++++++++++++++---
 1 file changed, 360 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index aabff8ee0bb3..ba3f40e78171 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -15,9 +15,11 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/phy/phy.h>
 #include <linux/phy/tegra/xusb.h>
 #include <linux/platform_device.h>
+#include <linux/usb/ch9.h>
 #include <linux/pm.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -224,6 +226,7 @@ struct tegra_xusb {
=20
 	int xhci_irq;
 	int mbox_irq;
+	int padctl_irq;
=20
 	void __iomem *ipfs_base;
 	void __iomem *fpci_base;
@@ -269,10 +272,13 @@ struct tegra_xusb {
 		dma_addr_t phys;
 	} fw;
=20
+	bool suspended;
 	struct tegra_xusb_context context;
 };
=20
 static struct hc_driver __read_mostly tegra_xhci_hc_driver;
+static int tegra_xusb_exit_elpg(struct tegra_xusb *tegra, bool runtime);
+static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime);
=20
 static inline u32 fpci_readl(struct tegra_xusb *tegra, unsigned int offset=
)
 {
@@ -658,6 +664,9 @@ static irqreturn_t tegra_xusb_mbox_thread(int irq, void=
 *data)
=20
 	mutex_lock(&tegra->lock);
=20
+	if (pm_runtime_suspended(tegra->dev) || tegra->suspended)
+		goto out;
+
 	value =3D fpci_readl(tegra, tegra->soc->mbox.data_out);
 	tegra_xusb_mbox_unpack(&msg, value);
=20
@@ -671,6 +680,7 @@ static irqreturn_t tegra_xusb_mbox_thread(int irq, void=
 *data)
=20
 	tegra_xusb_mbox_handle(tegra, &msg);
=20
+out:
 	mutex_unlock(&tegra->lock);
 	return IRQ_HANDLED;
 }
@@ -813,12 +823,27 @@ static void tegra_xusb_phy_disable(struct tegra_xusb =
*tegra)
=20
 static int tegra_xusb_runtime_suspend(struct device *dev)
 {
-	return 0;
+	struct tegra_xusb *tegra =3D dev_get_drvdata(dev);
+	int ret;
+
+	synchronize_irq(tegra->mbox_irq);
+	mutex_lock(&tegra->lock);
+	ret =3D tegra_xusb_enter_elpg(tegra, true);
+	mutex_unlock(&tegra->lock);
+
+	return ret;
 }
=20
 static int tegra_xusb_runtime_resume(struct device *dev)
 {
-	return 0;
+	struct tegra_xusb *tegra =3D dev_get_drvdata(dev);
+	int err;
+
+	mutex_lock(&tegra->lock);
+	err =3D tegra_xusb_exit_elpg(tegra, true);
+	mutex_unlock(&tegra->lock);
+
+	return err;
 }
=20
 #ifdef CONFIG_PM_SLEEP
@@ -1118,6 +1143,24 @@ static int __tegra_xusb_enable_firmware_messages(str=
uct tegra_xusb *tegra)
 	return err;
 }
=20
+static irqreturn_t tegra_xusb_padctl_irq(int irq, void *data)
+{
+	struct tegra_xusb *tegra =3D data;
+
+	mutex_lock(&tegra->lock);
+
+	if (tegra->suspended) {
+		mutex_unlock(&tegra->lock);
+		return IRQ_HANDLED;
+	}
+
+	mutex_unlock(&tegra->lock);
+
+	pm_runtime_resume(tegra->dev);
+
+	return IRQ_HANDLED;
+}
+
 static int tegra_xusb_enable_firmware_messages(struct tegra_xusb *tegra)
 {
 	int err;
@@ -1241,6 +1284,50 @@ static void tegra_xhci_id_work(struct work_struct *w=
ork)
 	}
 }
=20
+static bool is_usb2_otg_phy(struct tegra_xusb *tegra, unsigned int index)
+{
+	return (tegra->usbphy[index] !=3D NULL);
+}
+
+static bool is_usb3_otg_phy(struct tegra_xusb *tegra, unsigned int index)
+{
+	struct tegra_xusb_padctl *padctl =3D tegra->padctl;
+	unsigned int i;
+	int port;
+
+	for (i =3D 0; i < tegra->num_usb_phys; i++) {
+		if (is_usb2_otg_phy(tegra, i)) {
+			port =3D tegra_xusb_padctl_get_usb3_companion(padctl, i);
+			if ((port >=3D 0) && (index =3D=3D (unsigned int)port))
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static bool is_host_mode_phy(struct tegra_xusb *tegra, unsigned int phy_ty=
pe, unsigned int index)
+{
+	if (strcmp(tegra->soc->phy_types[phy_type].name, "hsic") =3D=3D 0)
+		return true;
+
+	if (strcmp(tegra->soc->phy_types[phy_type].name, "usb2") =3D=3D 0) {
+		if (is_usb2_otg_phy(tegra, index))
+			return ((index =3D=3D tegra->otg_usb2_port) && tegra->host_mode);
+		else
+			return true;
+	}
+
+	if (strcmp(tegra->soc->phy_types[phy_type].name, "usb3") =3D=3D 0) {
+		if (is_usb3_otg_phy(tegra, index))
+			return ((index =3D=3D tegra->otg_usb3_port) && tegra->host_mode);
+		else
+			return true;
+	}
+
+	return false;
+}
+
 static int tegra_xusb_get_usb2_port(struct tegra_xusb *tegra,
 					      struct usb_phy *usbphy)
 {
@@ -1333,6 +1420,7 @@ static void tegra_xusb_deinit_usb_phy(struct tegra_xu=
sb *tegra)
 static int tegra_xusb_probe(struct platform_device *pdev)
 {
 	struct tegra_xusb *tegra;
+	struct device_node *np;
 	struct resource *regs;
 	struct xhci_hcd *xhci;
 	unsigned int i, j, k;
@@ -1380,6 +1468,14 @@ static int tegra_xusb_probe(struct platform_device *=
pdev)
 	if (IS_ERR(tegra->padctl))
 		return PTR_ERR(tegra->padctl);
=20
+	np =3D of_parse_phandle(pdev->dev.of_node, "nvidia,xusb-padctl", 0);
+	if (!np)
+		return -ENODEV;
+
+	tegra->padctl_irq =3D of_irq_get(np, 0);
+	if (tegra->padctl_irq < 0)
+		return tegra->padctl_irq;
+
 	tegra->host_clk =3D devm_clk_get(&pdev->dev, "xusb_host");
 	if (IS_ERR(tegra->host_clk)) {
 		err =3D PTR_ERR(tegra->host_clk);
@@ -1524,6 +1620,7 @@ static int tegra_xusb_probe(struct platform_device *p=
dev)
 		goto put_powerdomains;
 	}
=20
+	tegra->hcd->skip_phy_initialization =3D 1;
 	tegra->hcd->regs =3D tegra->regs;
 	tegra->hcd->rsrc_start =3D regs->start;
 	tegra->hcd->rsrc_len =3D resource_size(regs);
@@ -1606,12 +1703,6 @@ static int tegra_xusb_probe(struct platform_device *=
pdev)
 		goto put_usb3;
 	}
=20
-	err =3D tegra_xusb_enable_firmware_messages(tegra);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to enable messages: %d\n", err);
-		goto remove_usb3;
-	}
-
 	err =3D devm_request_threaded_irq(&pdev->dev, tegra->mbox_irq,
 					tegra_xusb_mbox_irq,
 					tegra_xusb_mbox_thread, 0,
@@ -1621,12 +1712,36 @@ static int tegra_xusb_probe(struct platform_device =
*pdev)
 		goto remove_usb3;
 	}
=20
+	err =3D devm_request_threaded_irq(&pdev->dev, tegra->padctl_irq, NULL, te=
gra_xusb_padctl_irq,
+					IRQF_ONESHOT, dev_name(&pdev->dev), tegra);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to request padctl IRQ: %d\n", err);
+		goto remove_usb3;
+	}
+
+	err =3D tegra_xusb_enable_firmware_messages(tegra);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to enable messages: %d\n", err);
+		goto remove_usb3;
+	}
+
 	err =3D tegra_xusb_init_usb_phy(tegra);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to init USB PHY: %d\n", err);
 		goto remove_usb3;
 	}
=20
+	/* Enable wake for both USB 2.0 and USB 3.0 roothubs */
+	device_init_wakeup(&tegra->hcd->self.root_hub->dev, true);
+	device_init_wakeup(&xhci->shared_hcd->self.root_hub->dev, true);
+	device_init_wakeup(tegra->dev, true);
+
+	pm_runtime_use_autosuspend(tegra->dev);
+	pm_runtime_set_autosuspend_delay(tegra->dev, 2000);
+	pm_runtime_mark_last_busy(tegra->dev);
+	pm_runtime_set_active(tegra->dev);
+	pm_runtime_enable(tegra->dev);
+
 	return 0;
=20
 remove_usb3:
@@ -1662,6 +1777,7 @@ static int tegra_xusb_remove(struct platform_device *=
pdev)
=20
 	tegra_xusb_deinit_usb_phy(tegra);
=20
+	pm_runtime_get_sync(&pdev->dev);
 	usb_remove_hcd(xhci->shared_hcd);
 	usb_put_hcd(xhci->shared_hcd);
 	xhci->shared_hcd =3D NULL;
@@ -1671,8 +1787,8 @@ static int tegra_xusb_remove(struct platform_device *=
pdev)
 	dma_free_coherent(&pdev->dev, tegra->fw.size, tegra->fw.virt,
 			  tegra->fw.phys);
=20
-	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put(&pdev->dev);
=20
 	tegra_xusb_powergate_partitions(tegra);
=20
@@ -1714,9 +1830,17 @@ static bool xhci_hub_ports_suspended(struct xhci_hub=
 *hub)
 static int tegra_xusb_check_ports(struct tegra_xusb *tegra)
 {
 	struct xhci_hcd *xhci =3D hcd_to_xhci(tegra->hcd);
+	struct xhci_hub *rhub =3D  xhci_get_rhub(xhci->main_hcd);
+	struct xhci_bus_state *bus_state =3D &rhub->bus_state;
 	unsigned long flags;
 	int err =3D 0;
=20
+	if (bus_state->bus_suspended) {
+		/* xusb_hub_suspend() has just directed one or more USB2 port(s)
+		 * to U3 state, it takes 3ms to enter U3. */
+		usleep_range(3000, 4000);
+	}
+
 	spin_lock_irqsave(&xhci->lock, flags);
=20
 	if (!xhci_hub_ports_suspended(&xhci->usb2_rhub) ||
@@ -1762,45 +1886,186 @@ static void tegra_xusb_restore_context(struct tegr=
a_xusb *tegra)
 	}
 }
=20
-static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool wakeup)
+static enum usb_device_speed tegra_xhci_portsc_to_speed(struct tegra_xusb =
*tegra, u32 portsc)
 {
+	if (DEV_LOWSPEED(portsc))
+		return USB_SPEED_LOW;
+
+	if (DEV_HIGHSPEED(portsc))
+		return USB_SPEED_HIGH;
+
+	if (DEV_FULLSPEED(portsc))
+		return USB_SPEED_FULL;
+
+	if (DEV_SUPERSPEED_ANY(portsc))
+		return USB_SPEED_SUPER;
+
+	return USB_SPEED_UNKNOWN;
+}
+
+static void tegra_xhci_enable_phy_sleepwalk_wake(struct tegra_xusb *tegra)
+{
+	struct tegra_xusb_padctl *padctl =3D tegra->padctl;
 	struct xhci_hcd *xhci =3D hcd_to_xhci(tegra->hcd);
+	enum usb_device_speed speed;
+	struct phy *phy;
+	unsigned int index, offset;
+	unsigned int i, j, k;
+	struct xhci_hub *rhub;
+	u32 portsc;
+
+	for (i =3D 0, k =3D 0; i < tegra->soc->num_types; i++) {
+		if (strcmp(tegra->soc->phy_types[i].name, "usb3") =3D=3D 0)
+			rhub =3D &xhci->usb3_rhub;
+		else
+			rhub =3D &xhci->usb2_rhub;
+
+		if (strcmp(tegra->soc->phy_types[i].name, "hsic") =3D=3D 0)
+			offset =3D tegra->soc->ports.usb2.count;
+		else
+			offset =3D 0;
+
+		for (j =3D 0; j < tegra->soc->phy_types[i].num; j++) {
+			phy =3D tegra->phys[k++];
+
+			if (!phy)
+				continue;
+
+			index =3D j + offset;
+
+			if (index >=3D rhub->num_ports)
+				continue;
+
+			if (!is_host_mode_phy(tegra, i, j))
+				continue;
+
+			portsc =3D readl(rhub->ports[index]->addr);
+			speed =3D tegra_xhci_portsc_to_speed(tegra, portsc);
+			tegra_xusb_padctl_enable_phy_sleepwalk(padctl, phy, speed);
+			tegra_xusb_padctl_enable_phy_wake(padctl, phy);
+		}
+	}
+}
+
+static void tegra_xhci_disable_phy_wake(struct tegra_xusb *tegra)
+{
+	struct tegra_xusb_padctl *padctl =3D tegra->padctl;
+	unsigned int i;
+
+	for (i =3D 0; i < tegra->num_phys; i++) {
+		if (!tegra->phys[i])
+			continue;
+
+		tegra_xusb_padctl_disable_phy_wake(padctl, tegra->phys[i]);
+	}
+}
+
+static void tegra_xhci_disable_phy_sleepwalk(struct tegra_xusb *tegra)
+{
+	struct tegra_xusb_padctl *padctl =3D tegra->padctl;
+	unsigned int i;
+
+	for (i =3D 0; i < tegra->num_phys; i++) {
+		if (!tegra->phys[i])
+			continue;
+
+		tegra_xusb_padctl_disable_phy_sleepwalk(padctl, tegra->phys[i]);
+	}
+}
+
+static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
+{
+	struct xhci_hcd *xhci =3D hcd_to_xhci(tegra->hcd);
+	struct device *dev =3D tegra->dev;
+	bool wakeup =3D runtime ? true : device_may_wakeup(dev);
+	unsigned int i;
 	int err;
+	u32 usbcmd;
+
+	dev_dbg(dev, "entering ELPG\n");
+
+	usbcmd =3D readl(&xhci->op_regs->command);
+	usbcmd &=3D ~CMD_EIE;
+	writel(usbcmd, &xhci->op_regs->command);
=20
 	err =3D tegra_xusb_check_ports(tegra);
 	if (err < 0) {
 		dev_err(tegra->dev, "not all ports suspended: %d\n", err);
-		return err;
+		goto out;
 	}
=20
 	err =3D xhci_suspend(xhci, wakeup);
 	if (err < 0) {
 		dev_err(tegra->dev, "failed to suspend XHCI: %d\n", err);
-		return err;
+		goto out;
 	}
=20
 	tegra_xusb_save_context(tegra);
-	tegra_xusb_phy_disable(tegra);
+
+	if (wakeup)
+		tegra_xhci_enable_phy_sleepwalk_wake(tegra);
+
+	tegra_xusb_powergate_partitions(tegra);
+
+	for (i =3D 0; i < tegra->num_phys; i++) {
+		if (!tegra->phys[i])
+			continue;
+
+		phy_power_off(tegra->phys[i]);
+		if (!wakeup)
+			phy_exit(tegra->phys[i]);
+	}
+
 	tegra_xusb_clk_disable(tegra);
=20
-	return 0;
+out:
+	if (!err)
+		dev_dbg(tegra->dev, "entering ELPG done\n");
+	else {
+		usbcmd =3D readl(&xhci->op_regs->command);
+		usbcmd |=3D CMD_EIE;
+		writel(usbcmd, &xhci->op_regs->command);
+
+		dev_dbg(tegra->dev, "entering ELPG failed\n");
+		pm_runtime_mark_last_busy(tegra->dev);
+	}
+
+	return err;
 }
=20
-static int tegra_xusb_exit_elpg(struct tegra_xusb *tegra, bool wakeup)
+static int tegra_xusb_exit_elpg(struct tegra_xusb *tegra, bool runtime)
 {
 	struct xhci_hcd *xhci =3D hcd_to_xhci(tegra->hcd);
+	struct device *dev =3D tegra->dev;
+	bool wakeup =3D runtime ? true : device_may_wakeup(dev);
+	unsigned int i;
+	u32 usbcmd;
 	int err;
=20
+	dev_dbg(dev, "exiting ELPG\n");
+	pm_runtime_mark_last_busy(tegra->dev);
+
 	err =3D tegra_xusb_clk_enable(tegra);
 	if (err < 0) {
 		dev_err(tegra->dev, "failed to enable clocks: %d\n", err);
-		return err;
+		goto out;
 	}
=20
-	err =3D tegra_xusb_phy_enable(tegra);
-	if (err < 0) {
-		dev_err(tegra->dev, "failed to enable PHYs: %d\n", err);
-		goto disable_clk;
+	err =3D tegra_xusb_unpowergate_partitions(tegra);
+	if (err)
+		goto disable_clks;
+
+	if (wakeup)
+		tegra_xhci_disable_phy_wake(tegra);
+
+	for (i =3D 0; i < tegra->num_phys; i++) {
+		if (!tegra->phys[i])
+			continue;
+
+		if (!wakeup)
+			phy_init(tegra->phys[i]);
+
+		phy_power_on(tegra->phys[i]);
 	}
=20
 	tegra_xusb_config(tegra);
@@ -1818,31 +2083,79 @@ static int tegra_xusb_exit_elpg(struct tegra_xusb *=
tegra, bool wakeup)
 		goto disable_phy;
 	}
=20
-	err =3D xhci_resume(xhci, true);
+	if (wakeup)
+		tegra_xhci_disable_phy_sleepwalk(tegra);
+
+	err =3D xhci_resume(xhci, 0);
 	if (err < 0) {
 		dev_err(tegra->dev, "failed to resume XHCI: %d\n", err);
 		goto disable_phy;
 	}
=20
-	return 0;
+	usbcmd =3D readl(&xhci->op_regs->command);
+	usbcmd |=3D CMD_EIE;
+	writel(usbcmd, &xhci->op_regs->command);
+
+	goto out;
=20
 disable_phy:
-	tegra_xusb_phy_disable(tegra);
-disable_clk:
+	for (i =3D 0; i < tegra->num_phys; i++) {
+		if (!tegra->phys[i])
+			continue;
+
+		phy_power_off(tegra->phys[i]);
+		if (!wakeup)
+			phy_exit(tegra->phys[i]);
+	}
+	tegra_xusb_powergate_partitions(tegra);
+disable_clks:
 	tegra_xusb_clk_disable(tegra);
+out:
+	if (!err)
+		dev_dbg(dev, "exiting ELPG done\n");
+	else
+		dev_dbg(dev, "exiting ELPG failed\n");
+
 	return err;
 }
=20
 static int tegra_xusb_suspend(struct device *dev)
 {
 	struct tegra_xusb *tegra =3D dev_get_drvdata(dev);
-	bool wakeup =3D device_may_wakeup(dev);
 	int err;
=20
 	synchronize_irq(tegra->mbox_irq);
=20
 	mutex_lock(&tegra->lock);
-	err =3D tegra_xusb_enter_elpg(tegra, wakeup);
+
+	if (pm_runtime_suspended(dev)) {
+		err =3D tegra_xusb_exit_elpg(tegra, true);
+		if (err < 0)
+			goto out;
+	}
+
+	err =3D tegra_xusb_enter_elpg(tegra, false);
+	if (err < 0) {
+		if (pm_runtime_suspended(dev)) {
+			pm_runtime_disable(dev);
+			pm_runtime_set_active(dev);
+			pm_runtime_enable(dev);
+		}
+
+		goto out;
+	}
+
+out:
+	if (!err) {
+		tegra->suspended =3D true;
+		pm_runtime_disable(dev);
+
+		if (device_may_wakeup(dev)) {
+			if (enable_irq_wake(tegra->padctl_irq))
+				dev_err(dev, "failed to enable padctl wakes\n");
+		}
+	}
+
 	mutex_unlock(&tegra->lock);
=20
 	return err;
@@ -1851,14 +2164,32 @@ static int tegra_xusb_suspend(struct device *dev)
 static int tegra_xusb_resume(struct device *dev)
 {
 	struct tegra_xusb *tegra =3D dev_get_drvdata(dev);
-	bool wakeup =3D device_may_wakeup(dev);
 	int err;
=20
 	mutex_lock(&tegra->lock);
-	err =3D tegra_xusb_exit_elpg(tegra, wakeup);
+
+	if (!tegra->suspended) {
+		mutex_unlock(&tegra->lock);
+		return 0;
+	}
+
+	err =3D tegra_xusb_exit_elpg(tegra, false);
+	if (err < 0) {
+		mutex_unlock(&tegra->lock);
+		return err;
+	}
+
+	if (device_may_wakeup(dev)) {
+		if (disable_irq_wake(tegra->padctl_irq))
+			dev_err(dev, "failed to disable padctl wakes\n");
+	}
+	tegra->suspended =3D false;
 	mutex_unlock(&tegra->lock);
=20
-	return err;
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
 }
 #endif
=20
--=20
2.25.1

