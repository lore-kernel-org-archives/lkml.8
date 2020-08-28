Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C410C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC672080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YvfSerXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgH1BNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:13:12 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15010 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbgH1BMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 21:12:09 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4859bd0000>; Thu, 27 Aug 2020 18:11:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 18:12:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 27 Aug 2020 18:12:08 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 01:12:04 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 28 Aug 2020 01:12:04 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.4]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4859e20003>; Thu, 27 Aug 2020 18:12:04 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH 05/12] phy: tegra: xusb: add sleepwalk and suspend/resume
Date:   Fri, 28 Aug 2020 09:10:49 +0800
Message-ID: <20200828011056.1067559-6-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828011056.1067559-1-jckuo@nvidia.com>
References: <20200828011056.1067559-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598577085; bh=kX0RwgveLiINhWbSkybtsDBLi2N6bZpxn7iuTnuZPAY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=YvfSerXkhclGj0RSn+rxvV6JPnNNZ2F643vhhpk66ZYWJPkFrXI1OGkApULndR0RM
         9DJOtXRORudac/F/cfGL5urUG+RyRPv6ZCzaKLPqMUbkG3qbDlJkEJrNw6ITDnlAp5
         cBSKTmGH7100W8RP1x+9f8ZpljGERKVKUuN6/LsqUkOaIKrP2Ije3AntxFsdfCe406
         WYuwdRK9JSTznp46HLSK4ZKfwh5fLTjiCcRiEoRyqYoDM8k2KB4aKQpHD9cUF9VNXT
         2wGXiCpVyvBZ3eoNlGOidR08X5O5MLDJQQcsYXgceBj/qNr/2/9hipKps9p1SnIEnm
         M/DZNA8Mnm1Jw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds sleepwalk/wake and suspend/resume interfaces
to Tegra XUSB PHY driver.

Tegra XUSB host controller driver makes use of sleepwalk functions
to enable/disable sleepwalk circuit which is in always-on partition
can respond to USB resume signals when controller is not powered.
Sleepwalk can be enabled/disabled for any USB phy individually.

  - tegra_xusb_padctl_enable_phy_sleepwalk()
  - tegra_xusb_padctl_disable_phy_sleepwalk()

Tegra XUSB host controller driver makes use of wake functions to
enable/disable/query wake circuit which is in always-on partition
can wake system up when USB resume happens.
Wake circuit can be enabled/disabled for any USB phy individually.

  - tegra_xusb_padctl_enable_phy_wake()
  - tegra_xusb_padctl_disable_phy_wake()
  - tegra_xusb_padctl_remote_wake_detected()

This commit also adds two system suspend stubs that can be used to
save and restore XUSB PADCTL context during system suspend and
resume.
  - tegra_xusb_padctl_suspend_noirq()
  - tegra_xusb_padctl_resume_noirq()

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
 drivers/phy/tegra/xusb.c       | 78 ++++++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb.h       | 13 ++++++
 include/linux/phy/tegra/xusb.h | 13 ++++++
 3 files changed, 104 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 74abd67e3a31..3a1551c42c29 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -1274,10 +1274,36 @@ static int tegra_xusb_padctl_remove(struct platform=
_device *pdev)
 	return err;
 }
=20
+static int tegra_xusb_padctl_suspend_noirq(struct device *dev)
+{
+	struct tegra_xusb_padctl *padctl =3D dev_get_drvdata(dev);
+
+	if (padctl->soc && padctl->soc->ops && padctl->soc->ops->suspend_noirq)
+		return padctl->soc->ops->suspend_noirq(padctl);
+
+	return 0;
+}
+
+static int tegra_xusb_padctl_resume_noirq(struct device *dev)
+{
+	struct tegra_xusb_padctl *padctl =3D dev_get_drvdata(dev);
+
+	if (padctl->soc && padctl->soc->ops && padctl->soc->ops->resume_noirq)
+		return padctl->soc->ops->resume_noirq(padctl);
+
+	return 0;
+}
+
+static const struct dev_pm_ops tegra_xusb_padctl_pm_ops =3D {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_xusb_padctl_suspend_noirq,
+				      tegra_xusb_padctl_resume_noirq)
+};
+
 static struct platform_driver tegra_xusb_padctl_driver =3D {
 	.driver =3D {
 		.name =3D "tegra-xusb-padctl",
 		.of_match_table =3D tegra_xusb_padctl_of_match,
+		.pm =3D &tegra_xusb_padctl_pm_ops,
 	},
 	.probe =3D tegra_xusb_padctl_probe,
 	.remove =3D tegra_xusb_padctl_remove,
@@ -1344,6 +1370,58 @@ int tegra_xusb_padctl_hsic_set_idle(struct tegra_xus=
b_padctl *padctl,
 }
 EXPORT_SYMBOL_GPL(tegra_xusb_padctl_hsic_set_idle);
=20
+int tegra_xusb_padctl_enable_phy_sleepwalk(struct tegra_xusb_padctl *padct=
l,
+					   struct phy *phy,
+					   enum usb_device_speed speed)
+{
+	if (padctl->soc->ops->enable_phy_sleepwalk)
+		return padctl->soc->ops->enable_phy_sleepwalk(padctl, phy,
+							      speed);
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(tegra_xusb_padctl_enable_phy_sleepwalk);
+
+int tegra_xusb_padctl_disable_phy_sleepwalk(struct tegra_xusb_padctl *padc=
tl,
+					    struct phy *phy)
+{
+	if (padctl->soc->ops->disable_phy_sleepwalk)
+		return padctl->soc->ops->disable_phy_sleepwalk(padctl, phy);
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(tegra_xusb_padctl_disable_phy_sleepwalk);
+
+int tegra_xusb_padctl_enable_phy_wake(struct tegra_xusb_padctl *padctl,
+				      struct phy *phy)
+{
+	if (padctl->soc->ops->enable_phy_wake)
+		return padctl->soc->ops->enable_phy_wake(padctl, phy);
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(tegra_xusb_padctl_enable_phy_wake);
+
+int tegra_xusb_padctl_disable_phy_wake(struct tegra_xusb_padctl *padctl,
+				       struct phy *phy)
+{
+	if (padctl->soc->ops->disable_phy_wake)
+		return padctl->soc->ops->disable_phy_wake(padctl, phy);
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(tegra_xusb_padctl_disable_phy_wake);
+
+int tegra_xusb_padctl_remote_wake_detected(struct tegra_xusb_padctl *padct=
l,
+					   struct phy *phy)
+{
+	if (padctl->soc->ops->remote_wake_detected)
+		return padctl->soc->ops->remote_wake_detected(phy);
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(tegra_xusb_padctl_remote_wake_detected);
+
 int tegra_xusb_padctl_usb3_set_lfps_detect(struct tegra_xusb_padctl *padct=
l,
 					   unsigned int port, bool enable)
 {
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index 485b692a3b15..c1c4ea3ce050 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -11,6 +11,7 @@
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
=20
+#include <linux/usb/ch9.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/role.h>
=20
@@ -392,6 +393,8 @@ struct tegra_xusb_padctl_ops {
 			 const struct tegra_xusb_padctl_soc *soc);
 	void (*remove)(struct tegra_xusb_padctl *padctl);
=20
+	int (*suspend_noirq)(struct tegra_xusb_padctl *padctl);
+	int (*resume_noirq)(struct tegra_xusb_padctl *padctl);
 	int (*usb3_save_context)(struct tegra_xusb_padctl *padctl,
 				 unsigned int index);
 	int (*hsic_set_idle)(struct tegra_xusb_padctl *padctl,
@@ -400,6 +403,16 @@ struct tegra_xusb_padctl_ops {
 				    unsigned int index, bool enable);
 	int (*vbus_override)(struct tegra_xusb_padctl *padctl, bool set);
 	int (*utmi_port_reset)(struct phy *phy);
+	int (*enable_phy_sleepwalk)(struct tegra_xusb_padctl *padctl,
+				    struct phy *phy,
+				    enum usb_device_speed speed);
+	int (*disable_phy_sleepwalk)(struct tegra_xusb_padctl *padctl,
+				     struct phy *phy);
+	int (*enable_phy_wake)(struct tegra_xusb_padctl *padctl,
+			       struct phy *phy);
+	int (*disable_phy_wake)(struct tegra_xusb_padctl *padctl,
+				struct phy *phy);
+	int (*remote_wake_detected)(struct phy *phy);
 };
=20
 struct tegra_xusb_padctl_soc {
diff --git a/include/linux/phy/tegra/xusb.h b/include/linux/phy/tegra/xusb.=
h
index 71d956935405..9621e69067e1 100644
--- a/include/linux/phy/tegra/xusb.h
+++ b/include/linux/phy/tegra/xusb.h
@@ -8,6 +8,7 @@
=20
 struct tegra_xusb_padctl;
 struct device;
+enum usb_device_speed;
=20
 struct tegra_xusb_padctl *tegra_xusb_padctl_get(struct device *dev);
 void tegra_xusb_padctl_put(struct tegra_xusb_padctl *padctl);
@@ -23,4 +24,16 @@ int tegra_xusb_padctl_set_vbus_override(struct tegra_xus=
b_padctl *padctl,
 int tegra_phy_xusb_utmi_port_reset(struct phy *phy);
 int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
 					 unsigned int port);
+int tegra_xusb_padctl_enable_phy_sleepwalk(struct tegra_xusb_padctl *padct=
l,
+					   struct phy *phy,
+					   enum usb_device_speed speed);
+int tegra_xusb_padctl_disable_phy_sleepwalk(struct tegra_xusb_padctl *padc=
tl,
+					   struct phy *phy);
+int tegra_xusb_padctl_enable_phy_wake(struct tegra_xusb_padctl *padctl,
+				      struct phy *phy);
+int tegra_xusb_padctl_disable_phy_wake(struct tegra_xusb_padctl *padctl,
+				       struct phy *phy);
+int tegra_xusb_padctl_remote_wake_detected(struct tegra_xusb_padctl *padct=
l,
+					struct phy *phy);
+
 #endif /* PHY_TEGRA_XUSB_H */
--=20
2.25.1

