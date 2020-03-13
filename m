Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4ABC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F7D20749
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVZzh012"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgCMOQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:16:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36698 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgCMOQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:16:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id s5so12345368wrg.3;
        Fri, 13 Mar 2020 07:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d9Xr8n8MWLm/4regkBUf450Ou11CoE39h1rYIEOXJG4=;
        b=sVZzh012gLBxS+qw7xFFoYYoDFtmqZrVgOjPUnN96JpHAe4fCDpQ0z0X5VX8fGSiz4
         fI6NnduPjBcrnfBi6kN8L+qI1a85vTO3ru/aXAxgcHTHFgs4YLSBVo2J5WFK+MTKezrw
         7ZzpnLbxUbSG/lznRO1NsrcsQb1iF7uthtto+oAVAMO4YP5ScGHlXMizcl4W3UoS1gTA
         8+QPNtk33e12TDymGw044yIQWnxHaQcARTdjEPEJU7oyMA+c73+rFO/qCYrltuXKF7Jn
         7g7yNi3hRv/JERXNOP6HT6Xj72HzeCYFgz5opEHda66b7BW7hxUnDbQJMTmSnu/mr/qa
         osTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d9Xr8n8MWLm/4regkBUf450Ou11CoE39h1rYIEOXJG4=;
        b=BkdgAwQ2h021OUh/fOxpJxtD0lpRTHUFYFrpvXlzw68/4p0dtSIf1+cBaFta8uQbhY
         xxrbmtU4Rq868Sd9ZCwKpEau+R65utxoEct51hOAjfap0HOrzNmgHYL8g5F4ejvtc8lt
         Z6cBNPAvyFM1ergO7YpQHXIdZYFR1FphkyA071L9u9HRVJ2WVLjrtCNywi5LX8s82qyN
         70Xv17OnEoKT9AUhclSUhHPYdmdYbYhs4gQLxy3H47bH52jgfiHuOzdVK5DMcOevWeTD
         zUY7lHV/Ms0h5QNtaZhsL21eVkasTKmV4d0hIgmaBVN8nMLKqo1HlWZNYyc7XSghm5/6
         3Gsg==
X-Gm-Message-State: ANhLgQ1o5MO0Z0E/G146Pt7CCyM47eeDbwnZ2Pg50EouYiVyH1CKICU0
        7R/163Ba/qPpQRRWxlhBBRWjFfTJ9sk=
X-Google-Smtp-Source: ADFU+vtOzoCTgNJV3ClQd+2sAsMgCrlLZCIvUjqtBhc3CrjbHPDVz8JTvW0c/YuyH7nLI+gw2ywKlQ==
X-Received: by 2002:a05:6000:4a:: with SMTP id k10mr17099446wrx.381.1584108989313;
        Fri, 13 Mar 2020 07:16:29 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id l83sm17561422wmf.43.2020.03.13.07.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 07:16:28 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH 3/4] usb: ehci: Add new EHCI driver for Broadcom STB SoC's
Date:   Fri, 13 Mar 2020 10:15:44 -0400
Message-Id: <20200313141545.31943-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313141545.31943-1-alcooperx@gmail.com>
References: <20200313141545.31943-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new EHCI driver for Broadcom STB SoC's. A new EHCI driver
was created instead of adding support to the existing ehci platform
driver because of the code required to workaround bugs in the EHCI
controller.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/host/ehci-brcm.c | 288 +++++++++++++++++++++++++++++++++++
 1 file changed, 288 insertions(+)
 create mode 100644 drivers/usb/host/ehci-brcm.c

diff --git a/drivers/usb/host/ehci-brcm.c b/drivers/usb/host/ehci-brcm.c
new file mode 100644
index 000000000000..ad484bf81cf3
--- /dev/null
+++ b/drivers/usb/host/ehci-brcm.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Broadcom */
+
+#include <linux/acpi.h>
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "ehci.h"
+
+#define BRCM_DRIVER_DESC "EHCI Broadcom STB driver"
+
+#define hcd_to_ehci_priv(h) ((struct brcm_priv *)hcd_to_ehci(h)->priv)
+
+struct brcm_priv {
+	struct clk *clk;
+};
+
+static const char brcm_hcd_name[] = "ehci-brcm";
+
+static int (*org_hub_control)(struct usb_hcd *hcd,
+			u16 typeReq, u16 wValue, u16 wIndex,
+			char *buf, u16 wLength);
+
+/* ehci_brcm_wait_for_sof
+ * Wait for start of next microframe, then wait extra delay microseconds
+ */
+static inline void ehci_brcm_wait_for_sof(struct ehci_hcd *ehci, u32 delay)
+{
+	int frame_idx = ehci_readl(ehci, &ehci->regs->frame_index);
+
+	while (frame_idx == ehci_readl(ehci, &ehci->regs->frame_index))
+		;
+	udelay(delay);
+}
+
+/*
+ * ehci_brcm_hub_control
+ * Intercept echi-hcd request to complete RESUME and align it to the start
+ * of the next microframe.
+ * If RESUME is complete too late in the microframe, host controller
+ * detects babble on suspended port and resets the port afterwards.
+ * This s/w workaround allows to avoid this problem.
+ * See SWLINUX-1909 for more details
+ */
+static int ehci_brcm_hub_control(
+	struct usb_hcd	*hcd,
+	u16		typeReq,
+	u16		wValue,
+	u16		wIndex,
+	char		*buf,
+	u16		wLength)
+{
+	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
+	int		ports = HCS_N_PORTS(ehci->hcs_params);
+	u32 __iomem	*status_reg = &ehci->regs->port_status[
+				(wIndex & 0xff) - 1];
+	unsigned long flags;
+	int retval, irq_disabled = 0;
+
+	/*
+	 * RESUME is cleared when GetPortStatus() is called 20ms after start
+	 * of RESUME
+	 */
+	if ((typeReq == GetPortStatus) &&
+	    (wIndex && wIndex <= ports) &&
+	    ehci->reset_done[wIndex-1] &&
+	    time_after_eq(jiffies, ehci->reset_done[wIndex-1]) &&
+	    (ehci_readl(ehci, status_reg) & PORT_RESUME)) {
+
+		/*
+		 * to make sure we are not interrupted until RESUME bit
+		 * is cleared, disable interrupts on current CPU
+		 */
+		ehci_dbg(ehci, "SOF alignment workaround\n");
+		irq_disabled = 1;
+		local_irq_save(flags);
+		ehci_brcm_wait_for_sof(ehci, 5);
+	}
+	retval = (*org_hub_control)(hcd, typeReq, wValue, wIndex, buf, wLength);
+	if (irq_disabled)
+		local_irq_restore(flags);
+	return retval;
+}
+
+static int ehci_brcm_reset(struct usb_hcd *hcd)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+
+	ehci->big_endian_mmio = 1;
+
+	ehci->caps = (struct ehci_caps *) hcd->regs;
+	ehci->regs = (struct ehci_regs *) (hcd->regs +
+		HC_LENGTH(ehci, ehci_readl(ehci, &ehci->caps->hc_capbase)));
+
+	/* This fixes the lockup during reboot due to prior interrupts */
+	ehci_writel(ehci, CMD_RESET, &ehci->regs->command);
+	mdelay(10);
+
+	/*
+	 * SWLINUX-1705: Avoid OUT packet underflows during high memory
+	 *   bus usage
+	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00 @ 0x90
+	 */
+	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
+	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
+
+	return ehci_setup(hcd);
+}
+
+static struct hc_driver __read_mostly ehci_brcm_hc_driver;
+
+static const struct ehci_driver_overrides brcm_overrides __initconst = {
+
+	.reset =	ehci_brcm_reset,
+	.extra_priv_size = sizeof(struct brcm_priv),
+};
+
+static int ehci_brcm_probe(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd;
+	struct resource *res_mem;
+	struct brcm_priv *priv;
+	int irq;
+	int err;
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (err)
+		return err;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no irq provided");
+		return irq;
+	}
+
+	/* Hook the hub control routine to work around a bug */
+	if (org_hub_control == NULL)
+		org_hub_control = ehci_brcm_hc_driver.hub_control;
+	ehci_brcm_hc_driver.hub_control = ehci_brcm_hub_control;
+
+	/* initialize hcd */
+	hcd = usb_create_hcd(&ehci_brcm_hc_driver,
+			&pdev->dev, dev_name(&pdev->dev));
+	if (!hcd)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, hcd);
+	priv = hcd_to_ehci_priv(hcd);
+
+	priv->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		err = PTR_ERR(priv->clk);
+		goto err_hcd;
+	}
+
+	err = clk_prepare_enable(priv->clk);
+	if (err)
+		goto err_hcd;
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hcd->regs = devm_ioremap_resource(&pdev->dev, res_mem);
+	if (IS_ERR(hcd->regs)) {
+		err = PTR_ERR(hcd->regs);
+		goto err_clk;
+	}
+	hcd->rsrc_start = res_mem->start;
+	hcd->rsrc_len = resource_size(res_mem);
+	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (err)
+		goto err_clk;
+
+	device_wakeup_enable(hcd->self.controller);
+	device_enable_async_suspend(hcd->self.controller);
+	platform_set_drvdata(pdev, hcd);
+
+	return err;
+
+err_clk:
+	clk_disable_unprepare(priv->clk);
+err_hcd:
+	usb_put_hcd(hcd);
+
+	return err;
+}
+
+static int ehci_brcm_remove(struct platform_device *dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct brcm_priv *priv = hcd_to_ehci_priv(hcd);
+
+	usb_remove_hcd(hcd);
+	clk_disable_unprepare(priv->clk);
+	usb_put_hcd(hcd);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+
+static int ehci_brcm_suspend(struct device *dev)
+{
+	int ret;
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct brcm_priv *priv = hcd_to_ehci_priv(hcd);
+	bool do_wakeup = device_may_wakeup(dev);
+
+	ret = ehci_suspend(hcd, do_wakeup);
+	clk_disable_unprepare(priv->clk);
+	return ret;
+}
+
+static int ehci_brcm_resume(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	struct brcm_priv *priv = hcd_to_ehci_priv(hcd);
+	int err;
+
+	err = clk_prepare_enable(priv->clk);
+	if (err)
+		return err;
+	/*
+	 * SWLINUX-1705: Avoid OUT packet underflows during high memory
+	 *   bus usage
+	 * port_status[0x0f] = Broadcom-proprietary USB_EHCI_INSNREG00
+	 * @ 0x90
+	 */
+	ehci_writel(ehci, 0x00800040, &ehci->regs->port_status[0x10]);
+	ehci_writel(ehci, 0x00000001, &ehci->regs->port_status[0x12]);
+
+	ehci_resume(hcd, false);
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(ehci_brcm_pm_ops, ehci_brcm_suspend,
+		ehci_brcm_resume);
+
+static const struct of_device_id brcm_ehci_of_match[] = {
+	{ .compatible = "brcm,ehci-brcm-v2", },
+	{ .compatible = "brcm,bcm7445-ehci", },
+	{}
+};
+
+static struct platform_driver ehci_brcm_driver = {
+	.probe		= ehci_brcm_probe,
+	.remove		= ehci_brcm_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "ehci-brcm",
+		.pm	= &ehci_brcm_pm_ops,
+		.of_match_table = brcm_ehci_of_match,
+	}
+};
+
+static int __init ehci_brcm_init(void)
+{
+	if (usb_disabled())
+		return -ENODEV;
+
+	pr_info("%s: " BRCM_DRIVER_DESC "\n", brcm_hcd_name);
+
+	ehci_init_driver(&ehci_brcm_hc_driver, &brcm_overrides);
+	return platform_driver_register(&ehci_brcm_driver);
+}
+module_init(ehci_brcm_init);
+
+static void __exit ehci_brcm_exit(void)
+{
+	platform_driver_unregister(&ehci_brcm_driver);
+}
+module_exit(ehci_brcm_exit);
+
+MODULE_ALIAS("platform:ehci-brcm");
+MODULE_DESCRIPTION(BRCM_DRIVER_DESC);
+MODULE_AUTHOR("Al Cooper");
+MODULE_LICENSE("GPL");
-- 
2.17.1

