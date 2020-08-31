Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFE1C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51804206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Y8v3Tpzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgHaEl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:41:26 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1185 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgHaElD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 00:41:03 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4c7ee10002>; Sun, 30 Aug 2020 21:38:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 30 Aug 2020 21:41:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 30 Aug 2020 21:41:03 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 04:40:58 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 31 Aug 2020 04:40:57 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.4]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4c7f570003>; Sun, 30 Aug 2020 21:40:57 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v2 11/12] usb: host: xhci-tegra: unlink power domain devices
Date:   Mon, 31 Aug 2020 12:40:42 +0800
Message-ID: <20200831044043.1561074-12-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831044043.1561074-1-jckuo@nvidia.com>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598848738; bh=0CTHi9mIhl9G6jvo2lJZ946QRa9r6dmOL3TNK2XctPQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Y8v3Tpzh0fZRXdADuJcLOQKExFQPST6TOazUdGCupNZl3QefRsMUntQdqv27iEHdd
         aANBShgXU+4r9IF6/NSpPbr5T/HEBjITN9cX6h7c41OJlubLT+xr1Eds/WCYbGvPPB
         Hz12kNPmJXf0IbHRdiHLNxRceiXLRDVg+kFXFNCvZzMHl1ruEPfcaEg9T8n9/hzyBh
         MGU9TT+q9H5C+1kKA0ZJjB+3NO3+QLMMofjusX+Siqka53XKEbZwWOdEg7CtqsPI5u
         2VrK+KbHyutM9QYiGSfqDgUPG+GG64Ozdsd8DTw2uj0qqmfmPSbP5YKXJIzC+b5s5A
         4Ve99sdinNL9Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit unlinks xhci-tegra platform device with ss/host power
domain devices. Reasons for this change is - at elpg entry, phy
sleepwalk and wake configuration need to be done before powering
down ss/host partitions, and phy need be powered off after powering
down ss/host partitions. Sequence looks like roughly below:

  tegra_xusb_enter_elpg() -> xhci_suspend()
                          -> enable phy sleepwalk and wake if needed
                          -> power down ss/host partitions
                          -> power down phy

If ss/host power domains are linked to xhci-tegra platform device, we
are not able to perform the sequence like above.

This commit introduces:
  1. tegra_xusb_unpowergate_partitions() to power up ss and host
     partitions together. If ss/host power domain devices are
     available, it invokes pm_runtime_get_sync() to request power
     driver to power up partitions; If power domain devices are not
     available, tegra_powergate_sequence_power_up() will be used to
     power up partitions.

  2. tegra_xusb_powergate_partitions() to power down ss and host
     partitions together. If ss/host power domain devices are
     available, it invokes pm_runtime_put_sync() to request power
     driver to power down partitions; If power domain devices are not
     available, tegra_powergate_power_off() will be used to power down
     partitions.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 202 +++++++++++++++++++---------------
 1 file changed, 111 insertions(+), 91 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 934be1686352..ce6526c2caf6 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -249,8 +249,6 @@ struct tegra_xusb {
=20
 	struct device *genpd_dev_host;
 	struct device *genpd_dev_ss;
-	struct device_link *genpd_dl_host;
-	struct device_link *genpd_dl_ss;
=20
 	struct phy **phys;
 	unsigned int num_phys;
@@ -814,36 +812,12 @@ static void tegra_xusb_phy_disable(struct tegra_xusb =
*tegra)
=20
 static int tegra_xusb_runtime_suspend(struct device *dev)
 {
-	struct tegra_xusb *tegra =3D dev_get_drvdata(dev);
-
-	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
-	tegra_xusb_clk_disable(tegra);
-
 	return 0;
 }
=20
 static int tegra_xusb_runtime_resume(struct device *dev)
 {
-	struct tegra_xusb *tegra =3D dev_get_drvdata(dev);
-	int err;
-
-	err =3D tegra_xusb_clk_enable(tegra);
-	if (err) {
-		dev_err(dev, "failed to enable clocks: %d\n", err);
-		return err;
-	}
-
-	err =3D regulator_bulk_enable(tegra->soc->num_supplies, tegra->supplies);
-	if (err) {
-		dev_err(dev, "failed to enable regulators: %d\n", err);
-		goto disable_clk;
-	}
-
 	return 0;
-
-disable_clk:
-	tegra_xusb_clk_disable(tegra);
-	return err;
 }
=20
 #ifdef CONFIG_PM_SLEEP
@@ -1019,10 +993,6 @@ static int tegra_xusb_load_firmware(struct tegra_xusb=
 *tegra)
 static void tegra_xusb_powerdomain_remove(struct device *dev,
 					  struct tegra_xusb *tegra)
 {
-	if (tegra->genpd_dl_ss)
-		device_link_del(tegra->genpd_dl_ss);
-	if (tegra->genpd_dl_host)
-		device_link_del(tegra->genpd_dl_host);
 	if (!IS_ERR_OR_NULL(tegra->genpd_dev_ss))
 		dev_pm_domain_detach(tegra->genpd_dev_ss, true);
 	if (!IS_ERR_OR_NULL(tegra->genpd_dev_host))
@@ -1048,20 +1018,88 @@ static int tegra_xusb_powerdomain_init(struct devic=
e *dev,
 		return err;
 	}
=20
-	tegra->genpd_dl_host =3D device_link_add(dev, tegra->genpd_dev_host,
-					       DL_FLAG_PM_RUNTIME |
-					       DL_FLAG_STATELESS);
-	if (!tegra->genpd_dl_host) {
-		dev_err(dev, "adding host device link failed!\n");
-		return -ENODEV;
+	return 0;
+}
+
+static int tegra_xusb_unpowergate_partitions(struct tegra_xusb *tegra)
+{
+	struct device *dev =3D tegra->dev;
+	bool use_genpd;
+	int rc;
+
+	use_genpd =3D of_property_read_bool(dev->of_node, "power-domains");
+
+	if (use_genpd) {
+		rc =3D pm_runtime_get_sync(tegra->genpd_dev_ss);
+		if (rc < 0) {
+			dev_err(dev, "failed to enable XUSB SS partition\n");
+			return rc;
+		}
+
+		rc =3D pm_runtime_get_sync(tegra->genpd_dev_host);
+		if (rc < 0) {
+			dev_err(dev, "failed to enable XUSB Host partition\n");
+			pm_runtime_put_sync(tegra->genpd_dev_ss);
+			return rc;
+		}
+	} else {
+		rc =3D tegra_powergate_sequence_power_up(TEGRA_POWERGATE_XUSBA,
+							tegra->ss_clk,
+							tegra->ss_rst);
+		if (rc < 0) {
+			dev_err(dev, "failed to enable XUSB SS partition\n");
+			return rc;
+		}
+
+		rc =3D tegra_powergate_sequence_power_up(TEGRA_POWERGATE_XUSBC,
+							tegra->host_clk,
+							tegra->host_rst);
+		if (rc < 0) {
+			dev_err(dev, "failed to enable XUSB Host partition\n");
+			tegra_powergate_power_off(TEGRA_POWERGATE_XUSBA);
+			return rc;
+		}
 	}
=20
-	tegra->genpd_dl_ss =3D device_link_add(dev, tegra->genpd_dev_ss,
-					     DL_FLAG_PM_RUNTIME |
-					     DL_FLAG_STATELESS);
-	if (!tegra->genpd_dl_ss) {
-		dev_err(dev, "adding superspeed device link failed!\n");
-		return -ENODEV;
+	return 0;
+}
+
+static int tegra_xusb_powergate_partitions(struct tegra_xusb *tegra)
+{
+	struct device *dev =3D tegra->dev;
+	bool use_genpd;
+	int rc;
+
+	use_genpd =3D of_property_read_bool(dev->of_node, "power-domains");
+
+	if (use_genpd) {
+		rc =3D pm_runtime_put_sync(tegra->genpd_dev_host);
+		if (rc < 0) {
+			dev_err(dev, "failed to disable XUSB Host partition\n");
+			return rc;
+		}
+
+		rc =3D pm_runtime_put_sync(tegra->genpd_dev_ss);
+		if (rc < 0) {
+			dev_err(dev, "failed to disable XUSB SS partition\n");
+			pm_runtime_get_sync(tegra->genpd_dev_host);
+			return rc;
+		}
+	} else {
+		rc =3D tegra_powergate_power_off(TEGRA_POWERGATE_XUSBC);
+		if (rc < 0) {
+			dev_err(dev, "failed to disable XUSB Host partition\n");
+			return rc;
+		}
+
+		rc =3D tegra_powergate_power_off(TEGRA_POWERGATE_XUSBA);
+		if (rc < 0) {
+			dev_err(dev, "failed to disable XUSB SS partition\n");
+			tegra_powergate_sequence_power_up(TEGRA_POWERGATE_XUSBC,
+							  tegra->host_clk,
+							  tegra->host_rst);
+			return rc;
+		}
 	}
=20
 	return 0;
@@ -1425,25 +1463,6 @@ static int tegra_xusb_probe(struct platform_device *=
pdev)
 				err);
 			goto put_padctl;
 		}
-
-		err =3D tegra_powergate_sequence_power_up(TEGRA_POWERGATE_XUSBA,
-							tegra->ss_clk,
-							tegra->ss_rst);
-		if (err) {
-			dev_err(&pdev->dev,
-				"failed to enable XUSBA domain: %d\n", err);
-			goto put_padctl;
-		}
-
-		err =3D tegra_powergate_sequence_power_up(TEGRA_POWERGATE_XUSBC,
-							tegra->host_clk,
-							tegra->host_rst);
-		if (err) {
-			tegra_powergate_power_off(TEGRA_POWERGATE_XUSBA);
-			dev_err(&pdev->dev,
-				"failed to enable XUSBC domain: %d\n", err);
-			goto put_padctl;
-		}
 	} else {
 		err =3D tegra_xusb_powerdomain_init(&pdev->dev, tegra);
 		if (err)
@@ -1518,10 +1537,22 @@ static int tegra_xusb_probe(struct platform_device =
*pdev)
 	 */
 	platform_set_drvdata(pdev, tegra);
=20
+	err =3D tegra_xusb_clk_enable(tegra);
+	if (err) {
+		dev_err(tegra->dev, "failed to enable clocks: %d\n", err);
+		goto put_hcd;
+	}
+
+	err =3D regulator_bulk_enable(tegra->soc->num_supplies, tegra->supplies);
+	if (err) {
+		dev_err(tegra->dev, "failed to enable regulators: %d\n", err);
+		goto disable_clk;
+	}
+
 	err =3D tegra_xusb_phy_enable(tegra);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to enable PHYs: %d\n", err);
-		goto put_hcd;
+		goto disable_regulator;
 	}
=20
 	/*
@@ -1540,30 +1571,22 @@ static int tegra_xusb_probe(struct platform_device =
*pdev)
 		goto disable_phy;
 	}
=20
-	pm_runtime_enable(&pdev->dev);
-
-	if (!pm_runtime_enabled(&pdev->dev))
-		err =3D tegra_xusb_runtime_resume(&pdev->dev);
-	else
-		err =3D pm_runtime_get_sync(&pdev->dev);
-
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to enable device: %d\n", err);
+	err =3D tegra_xusb_unpowergate_partitions(tegra);
+	if (err)
 		goto free_firmware;
-	}
=20
 	tegra_xusb_config(tegra);
=20
 	err =3D tegra_xusb_load_firmware(tegra);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to load firmware: %d\n", err);
-		goto put_rpm;
+		goto powergate;
 	}
=20
 	err =3D usb_add_hcd(tegra->hcd, tegra->xhci_irq, IRQF_SHARED);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to add USB HCD: %d\n", err);
-		goto put_rpm;
+		goto powergate;
 	}
=20
 	device_wakeup_enable(tegra->hcd->self.controller);
@@ -1615,24 +1638,21 @@ static int tegra_xusb_probe(struct platform_device =
*pdev)
 	usb_put_hcd(xhci->shared_hcd);
 remove_usb2:
 	usb_remove_hcd(tegra->hcd);
-put_rpm:
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra_xusb_runtime_suspend(&pdev->dev);
-put_hcd:
-	usb_put_hcd(tegra->hcd);
+powergate:
+	tegra_xusb_powergate_partitions(tegra);
 free_firmware:
 	dma_free_coherent(&pdev->dev, tegra->fw.size, tegra->fw.virt,
 			  tegra->fw.phys);
 disable_phy:
 	tegra_xusb_phy_disable(tegra);
-	pm_runtime_disable(&pdev->dev);
+disable_regulator:
+	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
+disable_clk:
+	tegra_xusb_clk_disable(tegra);
+put_hcd:
+	usb_put_hcd(tegra->hcd);
 put_powerdomains:
-	if (!of_property_read_bool(pdev->dev.of_node, "power-domains")) {
-		tegra_powergate_power_off(TEGRA_POWERGATE_XUSBC);
-		tegra_powergate_power_off(TEGRA_POWERGATE_XUSBA);
-	} else {
-		tegra_xusb_powerdomain_remove(&pdev->dev, tegra);
-	}
+	tegra_xusb_powerdomain_remove(&pdev->dev, tegra);
 put_padctl:
 	tegra_xusb_padctl_put(tegra->padctl);
 	return err;
@@ -1657,15 +1677,15 @@ static int tegra_xusb_remove(struct platform_device=
 *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
=20
-	if (!of_property_read_bool(pdev->dev.of_node, "power-domains")) {
-		tegra_powergate_power_off(TEGRA_POWERGATE_XUSBC);
-		tegra_powergate_power_off(TEGRA_POWERGATE_XUSBA);
-	} else {
+	tegra_xusb_powergate_partitions(tegra);
+
+	if (of_property_read_bool(pdev->dev.of_node, "power-domains")) {
 		tegra_xusb_powerdomain_remove(&pdev->dev, tegra);
 	}
=20
 	tegra_xusb_phy_disable(tegra);
-
+	tegra_xusb_clk_disable(tegra);
+	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
 	tegra_xusb_padctl_put(tegra->padctl);
=20
 	return 0;
--=20
2.25.1

