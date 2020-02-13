Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E295AC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 19:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69DB20659
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 19:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgBMTkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 14:40:47 -0500
Received: from foss.arm.com ([217.140.110.172]:52602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgBMTkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:40:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91F37328;
        Thu, 13 Feb 2020 11:40:45 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8E163F68E;
        Thu, 13 Feb 2020 11:40:43 -0800 (PST)
Subject: Re: arm64 iommu groups issue
To:     John Garry <john.garry@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
Cc:     iommu <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>
References: <9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com>
 <4768c541-ebf4-61d5-0c5e-77dee83f8f94@arm.com>
 <a18b7f26-9713-a5c7-507e-ed70e40bc007@huawei.com>
 <ddc7eaff-c3f9-4304-9b4e-75eff2c66cd5@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <be464e2a-03d5-0b2e-24ee-96d0d14fd739@arm.com>
Date:   Thu, 13 Feb 2020 19:40:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ddc7eaff-c3f9-4304-9b4e-75eff2c66cd5@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2020 3:49 pm, John Garry wrote:
>>>
>>> The underlying issue is that, for historical reasons, OF/IORT-based
>>> IOMMU drivers have ended up with group allocation being tied to endpoint
>>> driver probing via the dma_configure() mechanism (long story short,
>>> driver probe is the only thing which can be delayed in order to wait for
>>> a specific IOMMU instance to be ready).However, in the meantime, the
>>> IOMMU API internals have evolved sufficiently that I think there's a way
>>> to really put things right - I have the spark of an idea which I'll try
>>> to sketch out ASAP...
>>>
>>
>> OK, great.
> 
> Hi Robin,
> 
> I was wondering if you have had a chance to consider this problem again?

Yeah, sorry, more things came up such that it still hasn't been P yet ;)

Lorenzo and I did get as far as discussing it a bit more and writing up 
a ticket, so it's formally on our internal radar now, at least.

> One simple idea could be to introduce a device link between the endpoint 
> device and its parent bridge to ensure that they probe in order, as 
> expected in pci_device_group():
> 
> Subject: [PATCH] PCI: Add device link to ensure endpoint device driver 
> probes after bridge
> 
> It is required to ensure that a device driver for an endpoint will probe
> after the parent port driver, so add a device link for this.
> 
> ---
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 512cb4312ddd..4b832ad25b20 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2383,6 +2383,7 @@ static void pci_set_msi_domain(struct pci_dev *dev)
>   void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>   {
>       int ret;
> +    struct device *parent;
> 
>       pci_configure_device(dev);
> 
> @@ -2420,6 +2421,10 @@ void pci_device_add(struct pci_dev *dev, struct 
> pci_bus *bus)
>       /* Set up MSI IRQ domain */
>       pci_set_msi_domain(dev);
> 
> +    parent = dev->dev.parent;
> +    if (parent && parent->bus == &pci_bus_type)
> +        device_link_add(&dev->dev, parent, DL_FLAG_AUTOPROBE_CONSUMER);
> +
>       /* Notifier could use PCI capabilities */
>       dev->match_driver = false;
>       ret = device_add(&dev->dev);
> -- 
> 
> This would work, but the problem is that if the port driver fails in 
> probing - and not just for -EPROBE_DEFER - then the child device will 
> never probe. This very thing happens on my dev board. However we could 
> expand the device links API to cover this sort of scenario.

Yes, that's an undesirable issue, but in fact I think it's mostly 
indicative that involving drivers in something which is designed to 
happen at a level below drivers is still fundamentally wrong and doomed 
to be fragile at best.

Another thought that crosses my mind is that when pci_device_group() 
walks up to the point of ACS isolation and doesn't find an existing 
group, it can still infer that everything it walked past *should* be put 
in the same group it's then eventually going to return. Unfortunately I 
can't see an obvious way for it to act on that knowledge, though, since 
recursive iommu_probe_device() is unlikely to end well.

> As for alternatives, it looks pretty difficult to me to disassociate the 
> group allocation from the dma_configure path.

Indeed it's non-trivial, but it really does need cleaning up at some point.

Having just had yet another spark, does something like the untested 
super-hack below work at all? I doubt it's a viable direction to take in 
itself, but it could be food for thought if it at least proves the concept.

Robin.

----->8-----
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index aa3ac2a03807..554cde76c766 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3841,20 +3841,20 @@ static int arm_smmu_set_bus_ops(struct iommu_ops 
*ops)
  	int err;

  #ifdef CONFIG_PCI
-	if (pci_bus_type.iommu_ops != ops) {
+	if (1) {
  		err = bus_set_iommu(&pci_bus_type, ops);
  		if (err)
  			return err;
  	}
  #endif
  #ifdef CONFIG_ARM_AMBA
-	if (amba_bustype.iommu_ops != ops) {
+	if (1) {
  		err = bus_set_iommu(&amba_bustype, ops);
  		if (err)
  			goto err_reset_pci_ops;
  	}
  #endif
-	if (platform_bus_type.iommu_ops != ops) {
+	if (1) {
  		err = bus_set_iommu(&platform_bus_type, ops);
  		if (err)
  			goto err_reset_amba_ops;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 660eea8d1d2f..b81ae2b4d4fb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1542,6 +1542,14 @@ static int iommu_bus_init(struct bus_type *bus, 
const struct iommu_ops *ops)
  	return err;
  }

+static int iommu_bus_replay(struct device *dev, void *data)
+{
+	if (dev->iommu_group)
+		return 0;
+
+	return add_iommu_group(dev, data);
+}
+
  /**
   * bus_set_iommu - set iommu-callbacks for the bus
   * @bus: bus.
@@ -1564,6 +1572,9 @@ int bus_set_iommu(struct bus_type *bus, const 
struct iommu_ops *ops)
  		return 0;
  	}

+	if (bus->iommu_ops == ops)
+		return bus_for_each_dev(bus, NULL, NULL, iommu_bus_replay);
+
  	if (bus->iommu_ops != NULL)
  		return -EBUSY;

