Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA9EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0655820738
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgFBFKF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:10:05 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2097 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbgFBFKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:10:05 -0400
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 479011FABFC121EBD0EF;
        Tue,  2 Jun 2020 13:10:03 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.10]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0487.000;
 Tue, 2 Jun 2020 13:09:57 +0800
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
Thread-Index: AQHWOIpUwdvGGcJ/+UCxidEm0PhHvqjEM/4AgACJWmCAAAdA0A==
Date:   Tue, 2 Jun 2020 05:09:57 +0000
Message-ID: <B926444035E5E2439431908E3842AFD24D8F9E@DGGEMI525-MBS.china.huawei.com>
References: <20200602030139.73012-1-song.bao.hua@hisilicon.com>
 <20200602042340.GA2130884@kroah.com> 
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Platform devices are NUMA?  That's crazy, and feels like a total abuse
> > of platform devices and drivers that really should belong on a "real"
> > bus.
> 
> I am not sure if it is an abuse of platform device. But smmu is a platform
> device,
> drivers/iommu/arm-smmu-v3.c is a platform driver.
> In a typical ARM server, there are maybe multiple SMMU devices which can
> support
> IO virtual address and page tables for other devices on PCI-like busses.
> Each different SMMU device might be close to different NUMA node. There is
> really a hardware topology.
> 
> If you have multiple CPU packages in a NUMA server, some platform devices
> might
> Belong to CPU0, some other might belong to CPU1.

Those devices are populated by acpi_iort for an ARM server:

drivers/acpi/arm64/iort.c:

static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
        .name = "arm-smmu-v3",
        .dev_dma_configure = arm_smmu_v3_dma_configure,
        .dev_count_resources = arm_smmu_v3_count_resources,
        .dev_init_resources = arm_smmu_v3_init_resources,
        .dev_set_proximity = arm_smmu_v3_set_proximity,
};

void __init acpi_iort_init(void)
{
        acpi_status status;

        status = acpi_get_table(ACPI_SIG_IORT, 0, &iort_table);
        ...
        iort_check_id_count_workaround(iort_table);
        iort_init_platform_devices();
}

static void __init iort_init_platform_devices(void)
{
        ...

        for (i = 0; i < iort->node_count; i++) {
                if (iort_node >= iort_end) {
                        pr_err("iort node pointer overflows, bad table\n");
                        return;
                }

                iort_enable_acs(iort_node);

                ops = iort_get_dev_cfg(iort_node);
                if (ops) {
                        fwnode = acpi_alloc_fwnode_static();
                        if (!fwnode)
                                return;

                        iort_set_fwnode(iort_node, fwnode);

                        ret = iort_add_platform_device(iort_node, ops);
                        if (ret) {
                                iort_delete_fwnode(iort_node);
                                acpi_free_fwnode_static(fwnode);
                                return;
                        }
                }

                ...
        }
...
}

NUMA node is got from ACPI:

static int  __init arm_smmu_v3_set_proximity(struct device *dev,
                                              struct acpi_iort_node *node)
{
        struct acpi_iort_smmu_v3 *smmu;

        smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
        if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
                int dev_node = acpi_map_pxm_to_node(smmu->pxm);

                ...

                set_dev_node(dev, dev_node);
                ...
        }
        return 0;
}

Barry

                                                    
