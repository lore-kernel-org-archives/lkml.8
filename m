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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435B5C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDBFD208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MhOb6r4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgIIILL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:11:11 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14047 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgIIILF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:11:05 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f588d920000>; Wed, 09 Sep 2020 01:08:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 01:11:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 09 Sep 2020 01:11:05 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 08:11:01 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 9 Sep 2020 08:11:01 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.100.126]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f588e130000>; Wed, 09 Sep 2020 01:11:00 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v3 07/15] phy: tegra: xusb: Add sleepwalk and suspend/resume
Date:   Wed, 9 Sep 2020 16:10:33 +0800
Message-ID: <20200909081041.3190157-8-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909081041.3190157-1-jckuo@nvidia.com>
References: <20200909081041.3190157-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599638930; bh=jJfxEXfaUKOiABpCTz58nFn3fkjkzFBrCqgg90V/bw8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=MhOb6r4nYkhXF9UBM+x/a9pXK/ovy+Xuv7MfOpVSf0jNUENosE+Jlbx+ZZNTr/GAz
         GGuBI6bIF3GofmRwzBuKyo2ldM6FHviOS9qV4DhqwOYLiYbCXWNMoHY/gtxzEsBKQ9
         mXRTcYlNAOBH4usXIG1a9jtEwdxdDBfIc0nhtHa5CkiQMLfXTJJTKKJLmd3jHJyZ/d
         7W7Oka8XCzt/xOx3Td7HV5/4USHnECQlB1c0VhJfo7DQXS2xIp+Fh5aG6FXGGwgNNu
         ZdjbYvYp+iHCID8y1kM9zkPsoKw3V3YFyikH4PV/iV/2ifxMWW8ZLU6iEV67sVX5+a
         wV7DwMp82Yjnw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds sleepwalk/wake and suspend/resume interfaces
to Tegra XUSB PHY driver.

Tegra XUSB host controller driver makes use of sleepwalk functions
to enable/disable sleepwalk circuit which is in always-on partition
and can respond to USB resume signals when controller is not powered.
Sleepwalk can be enabled/disabled for any USB UPHY individually.

  - tegra_xusb_padctl_enable_phy_sleepwalk()
  - tegra_xusb_padctl_disable_phy_sleepwalk()

Tegra XUSB host controller driver makes use of wake functions to
enable/disable/query wake circuit which is in always-on partition
can wake system up when USB resume happens.
Wake circuit can be enabled/disabled for any USB PHY individually.

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
v3:
   commit message improvement, no change in code

 drivers/phy/tegra/xusb.c       | 73 ++++++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb.h       |  9 +++++
 include/linux/phy/tegra/xusb.h |  8 ++++
 3 files changed, 90 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index b92478a350df..bc700e6a5519 100644
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
@@ -1344,6 +1370,53 @@ int tegra_xusb_padctl_hsic_set_idle(struct tegra_xus=
b_padctl *padctl,
 }
 EXPORT_SYMBOL_GPL(tegra_xusb_padctl_hsic_set_idle);
=20
+int tegra_xusb_padctl_enable_phy_sleepwalk(struct tegra_xusb_padctl *padct=
l, struct phy *phy,
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
tl, struct phy *phy)
+{
+	if (padctl->soc->ops->disable_phy_sleepwalk)
+		return padctl->soc->ops->disable_phy_sleepwalk(padctl, phy);
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(tegra_xusb_padctl_disable_phy_sleepwalk);
+
+int tegra_xusb_padctl_enable_phy_wake(struct tegra_xusb_padctl *padctl, st=
ruct phy *phy)
+{
+	if (padctl->soc->ops->enable_phy_wake)
+		return padctl->soc->ops->enable_phy_wake(padctl, phy);
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(tegra_xusb_padctl_enable_phy_wake);
+
+int tegra_xusb_padctl_disable_phy_wake(struct tegra_xusb_padctl *padctl, s=
truct phy *phy)
+{
+	if (padctl->soc->ops->disable_phy_wake)
+		return padctl->soc->ops->disable_phy_wake(padctl, phy);
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(tegra_xusb_padctl_disable_phy_wake);
+
+bool tegra_xusb_padctl_remote_wake_detected(struct tegra_xusb_padctl *padc=
tl, struct phy *phy)
+{
+	if (padctl->soc->ops->remote_wake_detected)
+		return padctl->soc->ops->remote_wake_detected(phy);
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(tegra_xusb_padctl_remote_wake_detected);
+
 int tegra_xusb_padctl_usb3_set_lfps_detect(struct tegra_xusb_padctl *padct=
l,
 					   unsigned int port, bool enable)
 {
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index 9463bc74729e..c796344e3062 100644
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
@@ -396,6 +397,8 @@ struct tegra_xusb_padctl_ops {
 			 const struct tegra_xusb_padctl_soc *soc);
 	void (*remove)(struct tegra_xusb_padctl *padctl);
=20
+	int (*suspend_noirq)(struct tegra_xusb_padctl *padctl);
+	int (*resume_noirq)(struct tegra_xusb_padctl *padctl);
 	int (*usb3_save_context)(struct tegra_xusb_padctl *padctl,
 				 unsigned int index);
 	int (*hsic_set_idle)(struct tegra_xusb_padctl *padctl,
@@ -404,6 +407,12 @@ struct tegra_xusb_padctl_ops {
 				    unsigned int index, bool enable);
 	int (*vbus_override)(struct tegra_xusb_padctl *padctl, bool set);
 	int (*utmi_port_reset)(struct phy *phy);
+	int (*enable_phy_sleepwalk)(struct tegra_xusb_padctl *padctl, struct phy =
*phy,
+				    enum usb_device_speed speed);
+	int (*disable_phy_sleepwalk)(struct tegra_xusb_padctl *padctl, struct phy=
 *phy);
+	int (*enable_phy_wake)(struct tegra_xusb_padctl *padctl, struct phy *phy)=
;
+	int (*disable_phy_wake)(struct tegra_xusb_padctl *padctl, struct phy *phy=
);
+	bool (*remote_wake_detected)(struct phy *phy);
 };
=20
 struct tegra_xusb_padctl_soc {
diff --git a/include/linux/phy/tegra/xusb.h b/include/linux/phy/tegra/xusb.=
h
index 71d956935405..f24d4744db17 100644
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
@@ -23,4 +24,11 @@ int tegra_xusb_padctl_set_vbus_override(struct tegra_xus=
b_padctl *padctl,
 int tegra_phy_xusb_utmi_port_reset(struct phy *phy);
 int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
 					 unsigned int port);
+int tegra_xusb_padctl_enable_phy_sleepwalk(struct tegra_xusb_padctl *padct=
l, struct phy *phy,
+					   enum usb_device_speed speed);
+int tegra_xusb_padctl_disable_phy_sleepwalk(struct tegra_xusb_padctl *padc=
tl, struct phy *phy);
+int tegra_xusb_padctl_enable_phy_wake(struct tegra_xusb_padctl *padctl, st=
ruct phy *phy);
+int tegra_xusb_padctl_disable_phy_wake(struct tegra_xusb_padctl *padctl, s=
truct phy *phy);
+bool tegra_xusb_padctl_remote_wake_detected(struct tegra_xusb_padctl *padc=
tl, struct phy *phy);
+
 #endif /* PHY_TEGRA_XUSB_H */
--=20
2.25.1

