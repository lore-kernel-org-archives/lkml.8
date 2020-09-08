Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AD2C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 02:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D9E21D20
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 02:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hehPh0C1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgIHC3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 22:29:17 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12900 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgIHC3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 22:29:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f56ec6c0000>; Mon, 07 Sep 2020 19:29:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 07 Sep 2020 19:29:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 07 Sep 2020 19:29:14 -0700
Received: from [10.19.100.126] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 02:29:07 +0000
Subject: Re: [PATCH v2 12/12] xhci: tegra: enable ELPG for runtime/system PM
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <robh@kernel.org>,
        <jonathanh@nvidia.com>, <kishon@ti.com>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
 <20200831044043.1561074-13-jckuo@nvidia.com> <20200831125035.GH1689119@ulmo>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <9f34c9cd-d2ca-42dd-fafe-2be27cdbc490@nvidia.com>
Date:   Tue, 8 Sep 2020 10:29:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831125035.GH1689119@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599532140; bh=IGymOoc5l6SdrrLt9eRBXeyGt169x+fSTH/ATJLBsj0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hehPh0C1yhhaT0S3qp/KKiVPKd7156qzdL0bitnrtTmp+PWAgHmK+sOxf0iHe4D8c
         uMIHXEmHpuknlgV2U1vQ8OC+sgDbw8pzyGchwYQM6G5bPbnAgDHt9I95uJJ2hxClfZ
         Xj8npFhzEJkfEyhUuO6AeqDiCMonrIy2C7r/2d05MeqV5QKcBj4DJLH/xAagpmuLv2
         qtYSzBi0ICwX0nkhgC7TuZDAgOJp30Pt7gnUYz3L1Deek+tKCtzSNpbAoCOGfP2QOr
         ZPyIdKo6Ru6xsxPcTEzNdfhgnJ3xoTou98UcE1b6VAEZs9vkNxBkTKupcPUYAMiTpj
         Hy14iuq6DlgkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,
Thanks for review. I will amend accordingly and submit a new revision.

JC

On 8/31/20 8:50 PM, Thierry Reding wrote:
> On Mon, Aug 31, 2020 at 12:40:43PM +0800, JC Kuo wrote:
>> This commit implements the complete programming sequence for ELPG
>> entry and exit.
>>
>>  1. At ELPG entry, invokes tegra_xusb_padctl_enable_phy_sleepwalk()
>>     and tegra_xusb_padctl_enable_phy_wake() to configure XUSB PADCTL
>>     sleepwalk and wake detection circuits to maintain USB lines level
>>     and respond to wake events (wake-on-connect, wake-on-disconnect,
>>     device-initiated-wake).
>>
>>  2. At ELPG exit, invokes tegra_xusb_padctl_disable_phy_sleepwalk()
>>     and tegra_xusb_padctl_disable_phy_wake() to disarm sleepwalk and
>>     wake detection circuits.
>>
>> At runtime suspend, XUSB host controller can enter ELPG to reduce
>> power consumption. When XUSB PADCTL wake detection circuit detects
>> a wake event, an interrupt will be raised. xhci-tegra driver then
>> will invoke pm_runtime_resume() for xhci-tegra.
>>
>> Runtime resume could also be triggered by protocol drivers, this is
>> the host-initiated-wake event. At runtime resume, xhci-tegra driver
>> brings XUSB host controller out of ELPG to handle the wake events.
>>
>> The same ELPG enter/exit procedure will be performed for system
>> suspend/resume path so USB devices can remain connected across SC7.
>>
>> Signed-off-by: JC Kuo <jckuo@nvidia.com>
>> ---
>>  drivers/usb/host/xhci-tegra.c | 391 +++++++++++++++++++++++++++++++---
>>  1 file changed, 361 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
>> index ce6526c2caf6..9530cfc83f45 100644
>> --- a/drivers/usb/host/xhci-tegra.c
>> +++ b/drivers/usb/host/xhci-tegra.c
>> @@ -15,9 +15,11 @@
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/of_device.h>
>> +#include <linux/of_irq.h>
>>  #include <linux/phy/phy.h>
>>  #include <linux/phy/tegra/xusb.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/usb/ch9.h>
>>  #include <linux/pm.h>
>>  #include <linux/pm_domain.h>
>>  #include <linux/pm_runtime.h>
>> @@ -224,6 +226,7 @@ struct tegra_xusb {
>>  
>>  	int xhci_irq;
>>  	int mbox_irq;
>> +	int padctl_irq;
>>  
>>  	void __iomem *ipfs_base;
>>  	void __iomem *fpci_base;
>> @@ -268,10 +271,13 @@ struct tegra_xusb {
>>  		dma_addr_t phys;
>>  	} fw;
>>  
>> +	bool suspended;
>>  	struct tegra_xusb_context context;
>>  };
>>  
>>  static struct hc_driver __read_mostly tegra_xhci_hc_driver;
>> +static int tegra_xusb_exit_elpg(struct tegra_xusb *tegra, bool runtime);
>> +static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime);
>>  
>>  static inline u32 fpci_readl(struct tegra_xusb *tegra, unsigned int offset)
>>  {
>> @@ -657,6 +663,9 @@ static irqreturn_t tegra_xusb_mbox_thread(int irq, void *data)
>>  
>>  	mutex_lock(&tegra->lock);
>>  
>> +	if (pm_runtime_suspended(tegra->dev) || tegra->suspended)
>> +		goto out;
>> +
>>  	value = fpci_readl(tegra, tegra->soc->mbox.data_out);
>>  	tegra_xusb_mbox_unpack(&msg, value);
>>  
>> @@ -670,6 +679,7 @@ static irqreturn_t tegra_xusb_mbox_thread(int irq, void *data)
>>  
>>  	tegra_xusb_mbox_handle(tegra, &msg);
>>  
>> +out:
>>  	mutex_unlock(&tegra->lock);
>>  	return IRQ_HANDLED;
>>  }
>> @@ -812,12 +822,27 @@ static void tegra_xusb_phy_disable(struct tegra_xusb *tegra)
>>  
>>  static int tegra_xusb_runtime_suspend(struct device *dev)
>>  {
>> -	return 0;
>> +	struct tegra_xusb *tegra = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	synchronize_irq(tegra->mbox_irq);
>> +	mutex_lock(&tegra->lock);
>> +	ret = tegra_xusb_enter_elpg(tegra, true);
>> +	mutex_unlock(&tegra->lock);
>> +
>> +	return ret;
>>  }
>>  
>>  static int tegra_xusb_runtime_resume(struct device *dev)
>>  {
>> -	return 0;
>> +	struct tegra_xusb *tegra = dev_get_drvdata(dev);
>> +	int err;
>> +
>> +	mutex_lock(&tegra->lock);
>> +	err = tegra_xusb_exit_elpg(tegra, true);
>> +	mutex_unlock(&tegra->lock);
>> +
>> +	return err;
>>  }
>>  
>>  #ifdef CONFIG_PM_SLEEP
>> @@ -1121,6 +1146,22 @@ static int __tegra_xusb_enable_firmware_messages(struct tegra_xusb *tegra)
>>  	return err;
>>  }
>>  
>> +static irqreturn_t tegra_xusb_padctl_irq(int irq, void *data)
>> +{
>> +	struct tegra_xusb *tegra = data;
>> +
>> +	mutex_lock(&tegra->lock);
>> +	if (tegra->suspended) {
>> +		mutex_unlock(&tegra->lock);
>> +		return IRQ_HANDLED;
>> +	}
>> +	mutex_unlock(&tegra->lock);
> 
> Blank lines before and after a block can help make this less cluttered.
> 
>> +
>> +	pm_runtime_resume(tegra->dev);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>>  static int tegra_xusb_enable_firmware_messages(struct tegra_xusb *tegra)
>>  {
>>  	int err;
>> @@ -1244,6 +1285,51 @@ static void tegra_xhci_id_work(struct work_struct *work)
>>  	}
>>  }
>>  
>> +static bool is_usb2_otg_phy(struct tegra_xusb *tegra, int index)
> 
> unsigned int index?
> 
>> +{
>> +	return (tegra->usbphy[index] != NULL);
>> +}
>> +
>> +static bool is_usb3_otg_phy(struct tegra_xusb *tegra, int index)
> 
> Here too.
> 
>> +{
>> +	struct tegra_xusb_padctl *padctl = tegra->padctl;
>> +	int i, port;
> 
> These can also be unsigned.
> 
>> +
>> +	for (i = 0; i < tegra->num_usb_phys; i++) {
>> +		if (is_usb2_otg_phy(tegra, i)) {
>> +			port = tegra_xusb_padctl_get_usb3_companion(padctl,i);
> 
> Space after ",".
> 
>> +			if (index == port)
>> +				return true;
>> +		}
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static bool is_host_mode_phy(struct tegra_xusb *tegra, int phy_type, int index)
>> +{
>> +	if (strcmp(tegra->soc->phy_types[phy_type].name, "hsic") == 0)
>> +		return true;
>> +
>> +	if (strcmp(tegra->soc->phy_types[phy_type].name, "usb2") == 0) {
>> +		if (is_usb2_otg_phy(tegra, index)) {
>> +			return ((index == tegra->otg_usb2_port) &&
>> +				 tegra->host_mode);
>> +		} else
>> +			return true;
>> +	}
>> +
>> +	if (strcmp(tegra->soc->phy_types[phy_type].name, "usb3") == 0) {
>> +		if (is_usb3_otg_phy(tegra, index)) {
>> +			return ((index == tegra->otg_usb3_port) &&
>> +				 tegra->host_mode);
>> +		} else
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>  static int tegra_xusb_get_usb2_port(struct tegra_xusb *tegra,
>>  					      struct usb_phy *usbphy)
>>  {
>> @@ -1336,6 +1422,7 @@ static void tegra_xusb_deinit_usb_phy(struct tegra_xusb *tegra)
>>  static int tegra_xusb_probe(struct platform_device *pdev)
>>  {
>>  	struct tegra_xusb *tegra;
>> +	struct device_node *np;
>>  	struct resource *regs;
>>  	struct xhci_hcd *xhci;
>>  	unsigned int i, j, k;
>> @@ -1383,6 +1470,14 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>>  	if (IS_ERR(tegra->padctl))
>>  		return PTR_ERR(tegra->padctl);
>>  
>> +	np = of_parse_phandle(pdev->dev.of_node, "nvidia,xusb-padctl", 0);
>> +	if (!np)
>> +		return -ENODEV;
>> +
>> +	tegra->padctl_irq = of_irq_get(np, 0);
>> +	if (tegra->padctl_irq < 0)
>> +		return tegra->padctl_irq;
>> +
>>  	tegra->host_clk = devm_clk_get(&pdev->dev, "xusb_host");
>>  	if (IS_ERR(tegra->host_clk)) {
>>  		err = PTR_ERR(tegra->host_clk);
>> @@ -1527,6 +1622,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>>  		goto put_powerdomains;
>>  	}
>>  
>> +	tegra->hcd->skip_phy_initialization = 1;
>>  	tegra->hcd->regs = tegra->regs;
>>  	tegra->hcd->rsrc_start = regs->start;
>>  	tegra->hcd->rsrc_len = resource_size(regs);
>> @@ -1609,12 +1705,6 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>>  		goto put_usb3;
>>  	}
>>  
>> -	err = tegra_xusb_enable_firmware_messages(tegra);
>> -	if (err < 0) {
>> -		dev_err(&pdev->dev, "failed to enable messages: %d\n", err);
>> -		goto remove_usb3;
>> -	}
>> -
>>  	err = devm_request_threaded_irq(&pdev->dev, tegra->mbox_irq,
>>  					tegra_xusb_mbox_irq,
>>  					tegra_xusb_mbox_thread, 0,
>> @@ -1624,12 +1714,40 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>>  		goto remove_usb3;
>>  	}
>>  
>> +	err = devm_request_threaded_irq(&pdev->dev, tegra->padctl_irq,
>> +		NULL,
>> +		tegra_xusb_padctl_irq,
>> +		IRQF_ONESHOT |
>> +		IRQF_TRIGGER_HIGH,
>> +		dev_name(&pdev->dev), tegra);
> 
> The alignment here is off. Also, try to make good use of those 100
> columns.
> 
>> +	if (err < 0) {
>> +		dev_err(&pdev->dev, "failed to request padctl IRQ: %d\n", err);
>> +		goto remove_usb3;
>> +	}
>> +
>> +	err = tegra_xusb_enable_firmware_messages(tegra);
>> +	if (err < 0) {
>> +		dev_err(&pdev->dev, "failed to enable messages: %d\n", err);
>> +		goto remove_usb3;
>> +	}
>> +
>>  	err = tegra_xusb_init_usb_phy(tegra);
>>  	if (err < 0) {
>>  		dev_err(&pdev->dev, "failed to init USB PHY: %d\n", err);
>>  		goto remove_usb3;
>>  	}
>>  
>> +	/* Enable wake for both USB 2.0 and USB 3.0 roothubs */
>> +	device_init_wakeup(&tegra->hcd->self.root_hub->dev, true);
>> +	device_init_wakeup(&xhci->shared_hcd->self.root_hub->dev, true);
>> +	device_init_wakeup(tegra->dev, true);
>> +
>> +	pm_runtime_use_autosuspend(tegra->dev);
>> +	pm_runtime_set_autosuspend_delay(tegra->dev, 2000);
>> +	pm_runtime_mark_last_busy(tegra->dev);
>> +	pm_runtime_set_active(tegra->dev);
>> +	pm_runtime_enable(tegra->dev);
>> +
>>  	return 0;
>>  
>>  remove_usb3:
>> @@ -1665,6 +1783,7 @@ static int tegra_xusb_remove(struct platform_device *pdev)
>>  
>>  	tegra_xusb_deinit_usb_phy(tegra);
>>  
>> +	pm_runtime_get_sync(&pdev->dev);
>>  	usb_remove_hcd(xhci->shared_hcd);
>>  	usb_put_hcd(xhci->shared_hcd);
>>  	xhci->shared_hcd = NULL;
>> @@ -1674,8 +1793,8 @@ static int tegra_xusb_remove(struct platform_device *pdev)
>>  	dma_free_coherent(&pdev->dev, tegra->fw.size, tegra->fw.virt,
>>  			  tegra->fw.phys);
>>  
>> -	pm_runtime_put_sync(&pdev->dev);
>>  	pm_runtime_disable(&pdev->dev);
>> +	pm_runtime_put(&pdev->dev);
>>  
>>  	tegra_xusb_powergate_partitions(tegra);
>>  
>> @@ -1717,9 +1836,17 @@ static bool xhci_hub_ports_suspended(struct xhci_hub *hub)
>>  static int tegra_xusb_check_ports(struct tegra_xusb *tegra)
>>  {
>>  	struct xhci_hcd *xhci = hcd_to_xhci(tegra->hcd);
>> +	struct xhci_hub *rhub =  xhci_get_rhub(xhci->main_hcd);
>> +	struct xhci_bus_state *bus_state = &rhub->bus_state;
>>  	unsigned long flags;
>>  	int err = 0;
>>  
>> +	if (bus_state->bus_suspended) {
>> +		/* xusb_hub_suspend() has just directed one or more USB2 port(s)
>> +		 * to U3 state, it takes 3ms to enter U3. */
>> +		usleep_range(3000, 4000);
>> +	}
>> +
>>  	spin_lock_irqsave(&xhci->lock, flags);
>>  
>>  	if (!xhci_hub_ports_suspended(&xhci->usb2_rhub) ||
>> @@ -1765,45 +1892,184 @@ static void tegra_xusb_restore_context(struct tegra_xusb *tegra)
>>  	}
>>  }
>>  
>> -static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool wakeup)
>> +static enum usb_device_speed
>> +tegra_xhci_portsc_to_speed(struct tegra_xusb *tegra, u32 portsc)
>> +{
>> +	if (DEV_LOWSPEED(portsc))
>> +		return USB_SPEED_LOW;
>> +	else if (DEV_HIGHSPEED(portsc))
>> +		return USB_SPEED_HIGH;
>> +	else if (DEV_FULLSPEED(portsc))
>> +		return USB_SPEED_FULL;
>> +	else if (DEV_SUPERSPEED_ANY(portsc))
>> +		return USB_SPEED_SUPER;
>> +	else
>> +		return USB_SPEED_UNKNOWN;
>> +}
> 
> As in a prior patch you can make this simpler by dropping the elses.
> 
>> +
>> +static void tegra_xhci_enable_phy_sleepwalk_wake(struct tegra_xusb *tegra)
>> +{
>> +	struct tegra_xusb_padctl *padctl = tegra->padctl;
>> +	struct xhci_hcd *xhci = hcd_to_xhci(tegra->hcd);
>> +	enum usb_device_speed speed;
>> +	struct phy *phy;
>> +	int index, offset;
>> +	int i, j, k;
> 
> It looks like these can all be unsigned int.
> 
>> +	struct xhci_hub *rhub;
>> +	u32 portsc;
>> +
>> +	for (i = 0, k = 0; i < tegra->soc->num_types; i++) {
>> +		if (strcmp(tegra->soc->phy_types[i].name, "usb3") == 0)
>> +			rhub = &xhci->usb3_rhub;
>> +		else
>> +			rhub = &xhci->usb2_rhub;
>> +
>> +		if (strcmp(tegra->soc->phy_types[i].name, "hsic") == 0)
>> +			offset = tegra->soc->ports.usb2.count;
>> +		else
>> +			offset = 0;
>> +
>> +		for (j = 0; j < tegra->soc->phy_types[i].num; j++) {
>> +			phy = tegra->phys[k++];
>> +
>> +			if (!phy)
>> +				continue;
>> +
>> +			index = j + offset;
>> +
>> +			if (index >= rhub->num_ports)
>> +				continue;
>> +
>> +			if (!is_host_mode_phy(tegra, i, j))
>> +				continue;
>> +
>> +			portsc = readl(rhub->ports[index]->addr);
>> +			speed = tegra_xhci_portsc_to_speed(tegra, portsc);
>> +			tegra_xusb_padctl_enable_phy_sleepwalk(padctl, phy,
>> +							       speed);
>> +			tegra_xusb_padctl_enable_phy_wake(padctl, phy);
>> +		}
>> +	}
>> +}
>> +
>> +static void tegra_xhci_disable_phy_wake(struct tegra_xusb *tegra)
>> +{
>> +	struct tegra_xusb_padctl *padctl = tegra->padctl;
>> +	int i;
> 
> Same here.
> 
>> +
>> +	for (i = 0; i < tegra->num_phys; i++) {
>> +		if (!tegra->phys[i])
>> +			continue;
>> +
>> +		tegra_xusb_padctl_disable_phy_wake(padctl, tegra->phys[i]);
>> +	}
>> +}
>> +
>> +static void tegra_xhci_disable_phy_sleepwalk(struct tegra_xusb *tegra)
>> +{
>> +	struct tegra_xusb_padctl *padctl = tegra->padctl;
>> +	int i;
> 
> And here.
> 
>> +
>> +	for (i = 0; i < tegra->num_phys; i++) {
>> +		if (!tegra->phys[i])
>> +			continue;
>> +
>> +		tegra_xusb_padctl_disable_phy_sleepwalk(padctl, tegra->phys[i]);
>> +	}
>> +}
>> +
>> +static int tegra_xusb_enter_elpg(struct tegra_xusb *tegra, bool runtime)
>>  {
>>  	struct xhci_hcd *xhci = hcd_to_xhci(tegra->hcd);
>> +	struct device *dev = tegra->dev;
>> +	bool wakeup = runtime ? true : device_may_wakeup(dev);
>> +	unsigned int i;
>>  	int err;
>> +	u32 usbcmd;
>> +
>> +	dev_dbg(dev, "entering ELPG\n");
>> +
>> +	usbcmd = readl(&xhci->op_regs->command);
>> +	usbcmd &= ~CMD_EIE;
>> +	writel(usbcmd, &xhci->op_regs->command);
>>  
>>  	err = tegra_xusb_check_ports(tegra);
>>  	if (err < 0) {
>>  		dev_err(tegra->dev, "not all ports suspended: %d\n", err);
>> -		return err;
>> +		goto out;
>>  	}
>>  
>>  	err = xhci_suspend(xhci, wakeup);
>>  	if (err < 0) {
>>  		dev_err(tegra->dev, "failed to suspend XHCI: %d\n", err);
>> -		return err;
>> +		goto out;
>>  	}
>>  
>>  	tegra_xusb_save_context(tegra);
>> -	tegra_xusb_phy_disable(tegra);
>> +
>> +	if (wakeup)
>> +		tegra_xhci_enable_phy_sleepwalk_wake(tegra);
>> +
>> +	tegra_xusb_powergate_partitions(tegra);
>> +
>> +	for (i = 0; i < tegra->num_phys; i++) {
>> +		if (!tegra->phys[i])
>> +			continue;
>> +
>> +		phy_power_off(tegra->phys[i]);
>> +		if (!wakeup)
>> +			phy_exit(tegra->phys[i]);
>> +	}
>>  	tegra_xusb_clk_disable(tegra);
> 
> Use blank lines to separate blocks of code.
> 
>>  
>> -	return 0;
>> +out:
>> +	if (!err)
>> +		dev_dbg(tegra->dev, "entering ELPG done\n");
>> +	else {
>> +		usbcmd = readl(&xhci->op_regs->command);
>> +		usbcmd |= CMD_EIE;
>> +		writel(usbcmd, &xhci->op_regs->command);
>> +
>> +		dev_dbg(tegra->dev, "entering ELPG failed\n");
>> +		pm_runtime_mark_last_busy(tegra->dev);
>> +	}
>> +
>> +	return err;
>>  }
>>  
>> -static int tegra_xusb_exit_elpg(struct tegra_xusb *tegra, bool wakeup)
>> +static int tegra_xusb_exit_elpg(struct tegra_xusb *tegra, bool runtime)
>>  {
>>  	struct xhci_hcd *xhci = hcd_to_xhci(tegra->hcd);
>> +	struct device *dev = tegra->dev;
>> +	bool wakeup = runtime ? true : device_may_wakeup(dev);
>> +	unsigned int i;
>> +	u32 usbcmd;
>>  	int err;
>>  
>> +	dev_dbg(dev, "exiting ELPG\n");
>> +	pm_runtime_mark_last_busy(tegra->dev);
>> +
>>  	err = tegra_xusb_clk_enable(tegra);
>>  	if (err < 0) {
>>  		dev_err(tegra->dev, "failed to enable clocks: %d\n", err);
>> -		return err;
>> +		goto out;
>>  	}
>>  
>> -	err = tegra_xusb_phy_enable(tegra);
>> -	if (err < 0) {
>> -		dev_err(tegra->dev, "failed to enable PHYs: %d\n", err);
>> -		goto disable_clk;
>> +	err = tegra_xusb_unpowergate_partitions(tegra);
>> +	if (err)
>> +		goto disable_clks;
>> +
>> +	if (wakeup)
>> +		tegra_xhci_disable_phy_wake(tegra);
>> +
>> +	for (i = 0; i < tegra->num_phys; i++) {
>> +		if (!tegra->phys[i])
>> +			continue;
>> +
>> +		if (!wakeup)
>> +			phy_init(tegra->phys[i]);
>> +
>> +		phy_power_on(tegra->phys[i]);
>>  	}
>>  
>>  	tegra_xusb_config(tegra);
>> @@ -1821,31 +2087,78 @@ static int tegra_xusb_exit_elpg(struct tegra_xusb *tegra, bool wakeup)
>>  		goto disable_phy;
>>  	}
>>  
>> -	err = xhci_resume(xhci, true);
>> +	if (wakeup)
>> +		tegra_xhci_disable_phy_sleepwalk(tegra);
>> +
>> +	err = xhci_resume(xhci, 0);
>>  	if (err < 0) {
>>  		dev_err(tegra->dev, "failed to resume XHCI: %d\n", err);
>>  		goto disable_phy;
>>  	}
>>  
>> -	return 0;
>> +	usbcmd = readl(&xhci->op_regs->command);
>> +	usbcmd |= CMD_EIE;
>> +	writel(usbcmd, &xhci->op_regs->command);
>> +
>> +	goto out;
>>  
>>  disable_phy:
>> -	tegra_xusb_phy_disable(tegra);
>> -disable_clk:
>> +	for (i = 0; i < tegra->num_phys; i++) {
>> +		if (!tegra->phys[i])
>> +			continue;
>> +
>> +		phy_power_off(tegra->phys[i]);
>> +		if (!wakeup)
>> +			phy_exit(tegra->phys[i]);
>> +	}
>> +	tegra_xusb_powergate_partitions(tegra);
>> +disable_clks:
>>  	tegra_xusb_clk_disable(tegra);
>> +out:
>> +	if (!err)
>> +		dev_dbg(dev, "exiting ELPG done\n");
>> +	else
>> +		dev_dbg(dev, "exiting ELPG failed\n");
>> +
>>  	return err;
>>  }
>>  
>>  static int tegra_xusb_suspend(struct device *dev)
>>  {
>>  	struct tegra_xusb *tegra = dev_get_drvdata(dev);
>> -	bool wakeup = device_may_wakeup(dev);
>>  	int err;
>>  
>>  	synchronize_irq(tegra->mbox_irq);
>> -
> 
> I think that blank line actually helped with readability.
> 
> Thierry
> 
>>  	mutex_lock(&tegra->lock);
>> -	err = tegra_xusb_enter_elpg(tegra, wakeup);
>> +
>> +	if (pm_runtime_suspended(dev)) {
>> +		err = tegra_xusb_exit_elpg(tegra, true);
>> +		if (err < 0)
>> +			goto out;
>> +	}
>> +
>> +	err = tegra_xusb_enter_elpg(tegra, false);
>> +	if (err < 0) {
>> +		if (pm_runtime_suspended(dev)) {
>> +			pm_runtime_disable(dev);
>> +			pm_runtime_set_active(dev);
>> +			pm_runtime_enable(dev);
>> +		}
>> +
>> +		goto out;
>> +	}
>> +
>> +out:
>> +	if (!err) {
>> +		tegra->suspended = true;
>> +		pm_runtime_disable(dev);
>> +
>> +		if (device_may_wakeup(dev)) {
>> +			if (enable_irq_wake(tegra->padctl_irq))
>> +				dev_err(dev, "failed to enable padctl wakes\n");
>> +		}
>> +	}
>> +
>>  	mutex_unlock(&tegra->lock);
>>  
>>  	return err;
>> @@ -1854,14 +2167,32 @@ static int tegra_xusb_suspend(struct device *dev)
>>  static int tegra_xusb_resume(struct device *dev)
>>  {
>>  	struct tegra_xusb *tegra = dev_get_drvdata(dev);
>> -	bool wakeup = device_may_wakeup(dev);
>>  	int err;
>>  
>>  	mutex_lock(&tegra->lock);
>> -	err = tegra_xusb_exit_elpg(tegra, wakeup);
>> +
>> +	if (!tegra->suspended) {
>> +		mutex_unlock(&tegra->lock);
>> +		return 0;
>> +	}
>> +
>> +	err = tegra_xusb_exit_elpg(tegra, false);
>> +	if (err < 0) {
>> +		mutex_unlock(&tegra->lock);
>> +		return err;
>> +	}
>> +
>> +	if (device_may_wakeup(dev)) {
>> +		if (disable_irq_wake(tegra->padctl_irq))
>> +			dev_err(dev, "failed to disable padctl wakes\n");
>> +	}
>> +	tegra->suspended = false;
>>  	mutex_unlock(&tegra->lock);
>>  
>> -	return err;
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>> +
>> +	return 0;
>>  }
>>  #endif
>>  
>> -- 
>> 2.25.1
>>
