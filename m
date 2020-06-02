Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7E2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980682074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgFBEmy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:42:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2096 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbgFBEmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:42:53 -0400
Received: from dggemi406-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id B531CB564B3EBAAFC3AC;
        Tue,  2 Jun 2020 12:42:50 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.10]) by
 dggemi406-hub.china.huawei.com ([10.3.17.144]) with mapi id 14.03.0487.000;
 Tue, 2 Jun 2020 12:42:43 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH] driver core: platform: expose numa_node to users in
 sysfs
Thread-Topic: [PATCH] driver core: platform: expose numa_node to users in
 sysfs
Thread-Index: AQHWOIpUwdvGGcJ/+UCxidEm0PhHvqjEM/4AgACJWmA=
Date:   Tue, 2 Jun 2020 04:42:42 +0000
Message-ID: <B926444035E5E2439431908E3842AFD24D8D1E@DGGEMI525-MBS.china.huawei.com>
References: <20200602030139.73012-1-song.bao.hua@hisilicon.com>
 <20200602042340.GA2130884@kroah.com>
In-Reply-To: <20200602042340.GA2130884@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.56]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Tuesday, June 2, 2020 4:24 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: rafael@kernel.org; iommu@lists.linux-foundation.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Robin
> Murphy <robin.murphy@arm.com>
> Subject: Re: [PATCH] driver core: platform: expose numa_node to users in sysfs
> 
> On Tue, Jun 02, 2020 at 03:01:39PM +1200, Barry Song wrote:
> > For some platform devices like iommu, particually ARM smmu, users may
> > care about the numa locality. for example, if threads and drivers run
> > near iommu, they may get much better performance on dma_unmap_sg.
> > For other platform devices, users may still want to know the hardware
> > topology.
> >
> > Cc: Prime Zeng <prime.zeng@hisilicon.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >  drivers/base/platform.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index b27d0f6c18c9..7794b9a38d82 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -1062,13 +1062,37 @@ static ssize_t driver_override_show(struct
> device *dev,
> >  }
> >  static DEVICE_ATTR_RW(driver_override);
> >
> > +static ssize_t numa_node_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	return sprintf(buf, "%d\n", dev_to_node(dev));
> > +}
> > +static DEVICE_ATTR_RO(numa_node);
> > +
> > +static umode_t platform_dev_attrs_visible(struct kobject *kobj, struct
> attribute *a,
> > +		int n)
> > +{
> > +	struct device *dev = container_of(kobj, typeof(*dev), kobj);
> > +
> > +	if (a == &dev_attr_numa_node.attr &&
> > +			dev_to_node(dev) == NUMA_NO_NODE)
> > +		return 0;
> > +
> > +	return a->mode;
> > +}
> >
> >  static struct attribute *platform_dev_attrs[] = {
> >  	&dev_attr_modalias.attr,
> > +	&dev_attr_numa_node.attr,
> >  	&dev_attr_driver_override.attr,
> >  	NULL,
> >  };
> > -ATTRIBUTE_GROUPS(platform_dev);
> > +
> > +static struct attribute_group platform_dev_group = {
> > +	.attrs = platform_dev_attrs,
> > +	.is_visible = platform_dev_attrs_visible,
> > +};
> > +__ATTRIBUTE_GROUPS(platform_dev);
> >
> >  static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
> >  {
> 
> Platform devices are NUMA?  That's crazy, and feels like a total abuse
> of platform devices and drivers that really should belong on a "real"
> bus.

I am not sure if it is an abuse of platform device. But smmu is a platform device,
drivers/iommu/arm-smmu-v3.c is a platform driver.
In a typical ARM server, there are maybe multiple SMMU devices which can support
IO virtual address and page tables for other devices on PCI-like busses.
Each different SMMU device might be close to different NUMA node. There is
really a hardware topology.

If you have multiple CPU packages in a NUMA server, some platform devices might
Belong to CPU0, some other might belong to CPU1.

-barry

> 
> What drivers in the kernel today have this issue?
> 
> thanks,
> 
> greg k-h


