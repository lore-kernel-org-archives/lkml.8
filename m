Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1844FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C098F20714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="EQzB/Tmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgG0JFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:05:24 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:64621
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727012AbgG0JFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:05:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2gparnjJfEzmxZOdS5Mau0Nxlp56oXXhizxsVvEf7W3BmEu0ziyI4m1mXq7cvWfFS1YgvdCuNTRKAOZ1hXURtB/IQTxXptWRzofZhLXVJvvbhZbVsTr4ZQR99iemtkh38RDUj5k88yweQYMoe4FmW/BI0jGmFjYkQ8DXw4KY2G0uR6eYLHbbbDNHuXnTLS7n1vSuEZ51PA2ruIDZljoz5Y+I85AC7tB7VEN8Wfnn96y3CsQzf4Xi2sC6FS7WuK3+iRiGnlZQdh1SN0SRO8OXQpe6sCjynlPLJxeXJ8Q5z5JSkUMzfAIsKHsc8dfTE7iVgjiNloNexpcv++s3TcyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oaoSOp7fN8cfILRibK+H31HXacYX8/tNS+e+e3OCoE=;
 b=ZFUgPknSOJ0j5eGVzm9jKkArxEx0I3xECckVsvLmvMEY5/Dsq+/XxfVWY5TG3qJ+HAIJ98QfbW45AKFMXzevHUt0E0emWP5EdidZPZP91clyyuNRUe54l9QlTBaRXzo3I7Cdbb46+7PatR5ZrujP/fDt0Uk7F/KHf2Oiza3Z14jsM0CxQwf+9kJ3RYu8LfTIMZnwy0QChteIjeDrcdpvVhkNZ2H9Q8tQOdsQLNhSdzG6//qSqhEIWUK08w6AatmXQ+gaExvRf3DV1BA9JHY+Wn3AG5ylShBAq6gkp+gfIoYecVGmGCZ01taGcN49sCrDLmsrGnnQciX9M0/nj3/ITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oaoSOp7fN8cfILRibK+H31HXacYX8/tNS+e+e3OCoE=;
 b=EQzB/TmfKBskIgCwaLK1dHFZ/6VdNKYfif8265KbIsIGepp8ua0HQf8o1hMoynlLsM/uix6e1ApxO8QWXRGU70qAfBRsb3WdB/cjsvA3yoZLkE46XLipIfFf3V+7iTuvvQd2aAcT4iC1Z5a641VaGYFnlR2ygJHTufuEMVNvx8U=
Received: from AM6PR05MB5064.eurprd05.prod.outlook.com (2603:10a6:20b:11::18)
 by AM6PR0502MB4053.eurprd05.prod.outlook.com (2603:10a6:209:1a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 09:05:09 +0000
Received: from AM6PR05MB5064.eurprd05.prod.outlook.com
 ([fe80::c55e:123c:321:7702]) by AM6PR05MB5064.eurprd05.prod.outlook.com
 ([fe80::c55e:123c:321:7702%5]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 09:05:09 +0000
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     Shravan Ramani <sramani@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
CC:     Shravan Ramani <sramani@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] platform/mellanox: mlxbf-pmc: Add Mellanox BlueField
 PMC driver
Thread-Topic: [PATCH v1] platform/mellanox: mlxbf-pmc: Add Mellanox BlueField
 PMC driver
Thread-Index: AQHWY/SsWuu99fj/mUCL6j+uOE+9yakbIY1A
Date:   Mon, 27 Jul 2020 09:05:09 +0000
Message-ID: <AM6PR05MB506464526142320BE23DCB1CA2720@AM6PR05MB5064.eurprd05.prod.outlook.com>
References: <0bad52e6e10ff2e8d8a19f95bab7642ec5e71838.1595838334.git.sramani@mellanox.com>
In-Reply-To: <0bad52e6e10ff2e8d8a19f95bab7642ec5e71838.1595838334.git.sramani@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
x-originating-ip: [46.116.48.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69eec305-16fd-46d8-6842-08d8320c29ee
x-ms-traffictypediagnostic: AM6PR0502MB4053:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0502MB4053A1FEBC295ECA7442A372A2720@AM6PR0502MB4053.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iApaNE+1z3DyQQ7bgUUbHmBT2wSNVIOdmaVoUnWxjiigx8Rz2p79EiUhBCuS/FVOqN0HyWsF6KlsDyQjdZOqbt790rO6qzUzbPwmD+aA52OJC6GhnlpjzuO+mix8qBckntu5utq68u/mAmf0P5H1w8en9ZXC1VvGUVjo9dnHnI/kOPGuU+NEMJ9t+uZ9KnJCCzTOpSzT8u+45A3agbzIfw7iAxldO+zHrQhLM+nVUAxNhKpyCmGI27aqmuT7vkRNJhGINe9cLulNPfvFxIgGFIh/o4A1x52v1OH8ZBMXSu7q/v81xraHJQrGP8lfaKJGPSS+k/l3NEg8yzPQfD0nQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB5064.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(55016002)(26005)(4326008)(53546011)(6506007)(66556008)(30864003)(186003)(9686003)(7696005)(66946007)(66446008)(316002)(66476007)(478600001)(64756008)(76116006)(110136005)(83380400001)(2906002)(71200400001)(54906003)(86362001)(5660300002)(8676002)(33656002)(52536014)(8936002)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: De8bXNUnG7aJxLK7Ki/O6bGU/UyFvYhAbBQm6jojxIkTy4lyz22Put2lxZBZlYpfULpb2DanQN4A81bXXhMx0Z7kyJ88FOtL5f7VRgArkDCZXMsELIWqB7VQb9AMqtfweqlSwTCWtyfpvD+An8XdOsBAV0aLgWTxiFT5N+OVZAvBY7aAckp5hWuv07JUEVNUKQr8LnEjfkrSCoE8YGY1EUp+7G6p/77tP+q1AGeORLwQ4MIbacILbFwR6Qcig8DevevXXOToXHpG13mb+y0drcTCv0l3pIv0apEr5XIfa5iZDosOsoOwn9TXFyzXImq40vdPPqB6puPzFmeOKW1AOfWQskgJLrd55jwfKbC4ELFuDz2rr6g9cf3GazlKyZlai6stQt2FjZMvUbxmWjWzwLlrkwosYZVPo3p1vj7SWLnUWhfzQkEnkfHMqBPvarsCHP02LlbZGQMYW/FcEu2GfXU/Q01qSZYatFsK2NKACWc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB5064.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69eec305-16fd-46d8-6842-08d8320c29ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 09:05:09.6202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ojeuzLjyBbgG1KrBdLO7rObrGn6xPMw+CXm6xskSDVt7oXAz3raoZL8x6izjHUC471LSF03eOhVzLtnnu9r6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB4053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shravan Kumar Ramani <sramani@mellanox.com>
> Sent: Monday, July 27, 2020 12:02 PM
> To: Andy Shevchenko <andy@infradead.org>; Darren Hart
> <dvhart@infradead.org>; Vadim Pasternak <vadimp@mellanox.com>
> Cc: Shravan Ramani <sramani@mellanox.com>; Jiri Pirko
> <jiri@mellanox.com>; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v1] platform/mellanox: mlxbf-pmc: Add Mellanox BlueField
> PMC driver
>=20
> The performance modules in BlueField are present in several hardware bloc=
ks
> and each block provides access to these stats either through counters tha=
t can
> be programmed to monitor supported events or through memory-mapped
> registers that hold the relevant information.
> The hardware blocks that include a performance module are:
>  * Tile (block containing 2 cores and a shared L2 cache)
>  * TRIO (PCIe root complex)
>  * MSS (Memory Sub-system containing the Memory Controller and L3 cache)
>  * GIC (Interrupt controller)
>  * SMMU (System Memory Management Unit)
> The mlx_pmc driver provides access to all of these performance modules
> through a hwmon sysfs interface.
>=20
> Signed-off-by: Shravan Kumar Ramani <sramani@mellanox.com>
> Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Reviewed-by: Vadim Pasternak <vadimp@mellanox.com>

> ---
>  drivers/platform/mellanox/Kconfig     |   10 +
>  drivers/platform/mellanox/Makefile    |    1 +
>  drivers/platform/mellanox/mlxbf-pmc.c | 1486
> +++++++++++++++++++++++++++++++++
>  3 files changed, 1497 insertions(+)
>  create mode 100644 drivers/platform/mellanox/mlxbf-pmc.c
>=20
> diff --git a/drivers/platform/mellanox/Kconfig
> b/drivers/platform/mellanox/Kconfig
> index 916b39d..edd17e1 100644
> --- a/drivers/platform/mellanox/Kconfig
> +++ b/drivers/platform/mellanox/Kconfig
> @@ -56,4 +56,14 @@ config MLXBF_BOOTCTL
>  	  to the userspace tools, to be used in conjunction with the eMMC
>  	  device driver to do necessary initial swap of the boot partition.
>=20
> +config MLXBF_PMC
> +	tristate "Mellanox BlueField Performance Monitoring Counters driver"
> +	depends on ARM64
> +	depends on HWMON
> +	depends on ACPI
> +	help
> +	  Say y here to enable PMC support. The PMC driver provides access
> +	  to performance monitoring counters within various blocks in the
> +	  Mellanox BlueField SoC via a sysfs interface.
> +
>  endif # MELLANOX_PLATFORM
> diff --git a/drivers/platform/mellanox/Makefile
> b/drivers/platform/mellanox/Makefile
> index 499623c..000ddaa 100644
> --- a/drivers/platform/mellanox/Makefile
> +++ b/drivers/platform/mellanox/Makefile
> @@ -4,6 +4,7 @@
>  # Mellanox Platform-Specific Drivers
>  #
>  obj-$(CONFIG_MLXBF_BOOTCTL)	+=3D mlxbf-bootctl.o
> +obj-$(CONFIG_MLXBF_PMC)		+=3D mlxbf-pmc.o
>  obj-$(CONFIG_MLXBF_TMFIFO)	+=3D mlxbf-tmfifo.o
>  obj-$(CONFIG_MLXREG_HOTPLUG)	+=3D mlxreg-hotplug.o
>  obj-$(CONFIG_MLXREG_IO) +=3D mlxreg-io.o
> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c
> b/drivers/platform/mellanox/mlxbf-pmc.c
> new file mode 100644
> index 0000000..07d6790
> --- /dev/null
> +++ b/drivers/platform/mellanox/mlxbf-pmc.c
> @@ -0,0 +1,1486 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR Linux-OpenIB
> +/*
> + * Mellanox BlueField Performance Monitoring Counters driver
> + *
> + * This driver provides a sysfs interface for monitoring
> + * performance statistics in BlueField SoC.
> + *
> + * Copyright (C) 2020 Mellanox Technologies Ltd.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/bitfield.h>
> +#include <linux/errno.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/version.h>
> +#include <uapi/linux/psci.h>
> +
> +#define MLXBF_PMC_WRITE_REG_32 0x82000009 #define
> MLXBF_PMC_READ_REG_32
> +0x8200000A #define MLXBF_PMC_WRITE_REG_64 0x8200000B #define
> +MLXBF_PMC_READ_REG_64 0x8200000C #define MLXBF_PMC_SIP_SVC_UID
> +0x8200ff01 #define MLXBF_PMC_SIP_SVC_VERSION 0x8200ff03 #define
> +MLXBF_PMC_SVC_REQ_MAJOR 0 #define MLXBF_PMC_SVC_MIN_MINOR 3
> +
> +#define MLXBF_PMC_SMCCC_ACCESS_VIOLATION -4
> +
> +#define MLXBF_PMC_EVENT_SET_BF1 0
> +#define MLXBF_PMC_EVENT_SET_BF2 1
> +#define MLXBF_PMC_EVENT_INFO_LEN 100
> +
> +#define MLXBF_PMC_MAX_BLOCKS 30
> +#define MLXBF_PMC_MAX_ATTRS 30
> +#define MLXBF_PMC_INFO_SZ 4
> +#define MLXBF_PMC_REG_SIZE 8
> +#define MLXBF_PMC_L3C_REG_SIZE 4
> +
> +#define MLXBF_PMC_TYPE_COUNTER 1
> +#define MLXBF_PMC_TYPE_REGISTER 0
> +
> +#define MLXBF_PMC_PERFCTL 0
> +#define MLXBF_PMC_PERFEVT 1
> +#define MLXBF_PMC_PERFACC0 4
> +
> +#define MLXBF_PMC_PERFMON_CONFIG_WR_R_B BIT(0) #define
> +MLXBF_PMC_PERFMON_CONFIG_STROBE BIT(1) #define
> +MLXBF_PMC_PERFMON_CONFIG_ADDR GENMASK_ULL(4, 2) #define
> +MLXBF_PMC_PERFMON_CONFIG_WDATA GENMASK_ULL(60, 5)
> +
> +#define MLXBF_PMC_PERFCTL_FM0 GENMASK_ULL(18, 16) #define
> +MLXBF_PMC_PERFCTL_MS0 GENMASK_ULL(21, 20) #define
> +MLXBF_PMC_PERFCTL_ACCM0 GENMASK_ULL(26, 24) #define
> +MLXBF_PMC_PERFCTL_AD0 BIT(27) #define MLXBF_PMC_PERFCTL_ETRIG0
> +GENMASK_ULL(29, 28) #define MLXBF_PMC_PERFCTL_EB0 BIT(30) #define
> +MLXBF_PMC_PERFCTL_EN0 BIT(31)
> +
> +#define MLXBF_PMC_PERFEVT_EVTSEL GENMASK_ULL(31, 24)
> +
> +#define MLXBF_PMC_L3C_PERF_CNT_CFG 0x0
> +#define MLXBF_PMC_L3C_PERF_CNT_SEL 0x10 #define
> +MLXBF_PMC_L3C_PERF_CNT_SEL_1 0x14 #define
> MLXBF_PMC_L3C_PERF_CNT_LOW
> +0x40 #define MLXBF_PMC_L3C_PERF_CNT_HIGH 0x60
> +
> +#define MLXBF_PMC_L3C_PERF_CNT_CFG_EN BIT(0) #define
> +MLXBF_PMC_L3C_PERF_CNT_CFG_RST BIT(1) #define
> +MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_0 GENMASK(5, 0) #define
> +MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_1 GENMASK(13, 8) #define
> +MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_2 GENMASK(21, 16) #define
> +MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_3 GENMASK(29, 24)
> +
> +#define MLXBF_PMC_L3C_PERF_CNT_SEL_1_CNT_4 GENMASK(5, 0)
> +
> +#define MLXBF_PMC_L3C_PERF_CNT_LOW_VAL GENMASK(31, 0) #define
> +MLXBF_PMC_L3C_PERF_CNT_HIGH_VAL GENMASK(24, 0)
> +
> +/**
> + * Structure to hold attribute and block info for each sysfs entry
> + * @dev_attr: Device attribute struct
> + * @index: index to identify counter number within a block
> + * @nr: block number to which the sysfs belongs  */ struct
> +mlxbf_pmc_attribute {
> +	struct device_attribute dev_attr;
> +	int index;
> +	int nr;
> +};
> +
> +/**
> + * Structure to hold info for each HW block
> + *
> + * @mmio_base: The VA at which the PMC block is mapped
> + * @blk_size: Size of each mapped region
> + * @counters: Number of counters in the block
> + * @type: Type of counters in the block
> + * @attr_counter: Attributes for "counter" sysfs files
> + * @attr_event: Attributes for "event" sysfs files
> + * @attr_event_list: Attributes for "event_list" sysfs files
> + * @attr_enable: Attributes for "enable" sysfs files
> + * @block_attr: All attributes needed for the block
> + * @blcok_attr_grp: Attribute group for the block  */ struct
> +mlxbf_pmc_block_info {
> +	void __iomem *mmio_base;
> +	size_t blk_size;
> +	size_t counters;
> +	int type;
> +	struct mlxbf_pmc_attribute *attr_counter;
> +	struct mlxbf_pmc_attribute *attr_event;
> +	struct mlxbf_pmc_attribute attr_event_list;
> +	struct mlxbf_pmc_attribute attr_enable;
> +	struct attribute *block_attr[MLXBF_PMC_MAX_ATTRS];
> +	struct attribute_group block_attr_grp; };
> +
> +/**
> + * Structure to hold PMC context info
> + *
> + * @pdev: The kernel structure representing the device
> + * @total_blocks: Total number of blocks
> + * @tile_count: Number of tiles in the system
> + * @hwmon_dev: Hwmon device for bfperf
> + * @block_name: Block name
> + * @block:  Block info
> + * @groups:  Attribute groups from each block
> + * @sv_sreg_support: Whether SMCs are used to access performance
> +registers
> + * @sreg_tbl_perf: Secure register access table number
> + * @event_set: Event set to use
> + */
> +struct mlxbf_pmc_context {
> +	struct platform_device *pdev;
> +	uint32_t total_blocks;
> +	uint32_t tile_count;
> +	struct device *hwmon_dev;
> +	const char *block_name[MLXBF_PMC_MAX_BLOCKS];
> +	struct mlxbf_pmc_block_info block[MLXBF_PMC_MAX_BLOCKS];
> +	const struct attribute_group *groups[MLXBF_PMC_MAX_BLOCKS];
> +	bool svc_sreg_support;
> +	uint32_t sreg_tbl_perf;
> +	unsigned int event_set;
> +};
> +
> +/**
> + * Structure to hold supported events for each block
> + * @evt_num: Event number used to program counters
> + * @evt_name: Name of the event
> + */
> +struct mlxbf_pmc_events {
> +	int evt_num;
> +	char *evt_name;
> +};
> +
> +static const struct mlxbf_pmc_events mlxbf_pmc_pcie_events[] =3D {
> +	{ 0x0, "IN_P_PKT_CNT" },
> +	{ 0x10, "IN_NP_PKT_CNT" },
> +	{ 0x18, "IN_C_PKT_CNT" },
> +	{ 0x20, "OUT_P_PKT_CNT" },
> +	{ 0x28, "OUT_NP_PKT_CNT" },
> +	{ 0x30, "OUT_C_PKT_CNT" },
> +	{ 0x38, "IN_P_BYTE_CNT" },
> +	{ 0x40, "IN_NP_BYTE_CNT" },
> +	{ 0x48, "IN_C_BYTE_CNT" },
> +	{ 0x50, "OUT_P_BYTE_CNT" },
> +	{ 0x58, "OUT_NP_BYTE_CNT" },
> +	{ 0x60, "OUT_C_BYTE_CNT" }
> +};
> +
> +static const struct mlxbf_pmc_events mlxbf_pmc_smgen_events[] =3D {
> +	{ 0x0, "AW_REQ" },
> +	{ 0x1, "AW_BEATS" },
> +	{ 0x2, "AW_TRANS" },
> +	{ 0x3, "AW_RESP" },
> +	{ 0x4, "AW_STL" },
> +	{ 0x5, "AW_LAT" },
> +	{ 0x6, "AW_REQ_TBU" },
> +	{ 0x8, "AR_REQ" },
> +	{ 0x9, "AR_BEATS" },
> +	{ 0xa, "AR_TRANS" },
> +	{ 0xb, "AR_STL" },
> +	{ 0xc, "AR_LAT" },
> +	{ 0xd, "AR_REQ_TBU" },
> +	{ 0xe, "TBU_MISS" },
> +	{ 0xf, "TX_DAT_AF" },
> +	{ 0x10, "RX_DAT_AF" },
> +	{ 0x11, "RETRYQ_CRED" }
> +};
> +
> +static const struct mlxbf_pmc_events mlxbf_pmc_trio_events_1[] =3D {
> +	{ 0xa0, "TPIO_DATA_BEAT" },
> +	{ 0xa1, "TDMA_DATA_BEAT" },
> +	{ 0xa2, "MAP_DATA_BEAT" },
> +	{ 0xa3, "TXMSG_DATA_BEAT" },
> +	{ 0xa4, "TPIO_DATA_PACKET" },
> +	{ 0xa5, "TDMA_DATA_PACKET" },
> +	{ 0xa6, "MAP_DATA_PACKET" },
> +	{ 0xa7, "TXMSG_DATA_PACKET" },
> +	{ 0xa8, "TDMA_RT_AF" },
> +	{ 0xa9, "TDMA_PBUF_MAC_AF" },
> +	{ 0xaa, "TRIO_MAP_WRQ_BUF_EMPTY" },
> +	{ 0xab, "TRIO_MAP_CPL_BUF_EMPTY" },
> +	{ 0xac, "TRIO_MAP_RDQ0_BUF_EMPTY" },
> +	{ 0xad, "TRIO_MAP_RDQ1_BUF_EMPTY" },
> +	{ 0xae, "TRIO_MAP_RDQ2_BUF_EMPTY" },
> +	{ 0xaf, "TRIO_MAP_RDQ3_BUF_EMPTY" },
> +	{ 0xb0, "TRIO_MAP_RDQ4_BUF_EMPTY" },
> +	{ 0xb1, "TRIO_MAP_RDQ5_BUF_EMPTY" },
> +	{ 0xb2, "TRIO_MAP_RDQ6_BUF_EMPTY" },
> +	{ 0xb3, "TRIO_MAP_RDQ7_BUF_EMPTY" }
> +};
> +
> +static const struct mlxbf_pmc_events mlxbf_pmc_trio_events_2[] =3D {
> +	{ 0xa0, "TPIO_DATA_BEAT" },
> +	{ 0xa1, "TDMA_DATA_BEAT" },
> +	{ 0xa2, "MAP_DATA_BEAT" },
> +	{ 0xa3, "TXMSG_DATA_BEAT" },
> +	{ 0xa4, "TPIO_DATA_PACKET" },
> +	{ 0xa5, "TDMA_DATA_PACKET" },
> +	{ 0xa6, "MAP_DATA_PACKET" },
> +	{ 0xa7, "TXMSG_DATA_PACKET" },
> +	{ 0xa8, "TDMA_RT_AF" },
> +	{ 0xa9, "TDMA_PBUF_MAC_AF" },
> +	{ 0xaa, "TRIO_MAP_WRQ_BUF_EMPTY" },
> +	{ 0xab, "TRIO_MAP_CPL_BUF_EMPTY" },
> +	{ 0xac, "TRIO_MAP_RDQ0_BUF_EMPTY" },
> +	{ 0xad, "TRIO_MAP_RDQ1_BUF_EMPTY" },
> +	{ 0xae, "TRIO_MAP_RDQ2_BUF_EMPTY" },
> +	{ 0xaf, "TRIO_MAP_RDQ3_BUF_EMPTY" },
> +	{ 0xb0, "TRIO_MAP_RDQ4_BUF_EMPTY" },
> +	{ 0xb1, "TRIO_MAP_RDQ5_BUF_EMPTY" },
> +	{ 0xb2, "TRIO_MAP_RDQ6_BUF_EMPTY" },
> +	{ 0xb3, "TRIO_MAP_RDQ7_BUF_EMPTY" },
> +	{ 0xb4, "TRIO_RING_TX_FLIT_CH0" },
> +	{ 0xb5, "TRIO_RING_TX_FLIT_CH1" },
> +	{ 0xb6, "TRIO_RING_TX_FLIT_CH2" },
> +	{ 0xb7, "TRIO_RING_TX_FLIT_CH3" },
> +	{ 0xb8, "TRIO_RING_TX_FLIT_CH4" },
> +	{ 0xb9, "TRIO_RING_RX_FLIT_CH0" },
> +	{ 0xba, "TRIO_RING_RX_FLIT_CH1" },
> +	{ 0xbb, "TRIO_RING_RX_FLIT_CH2" },
> +	{ 0xbc, "TRIO_RING_RX_FLIT_CH3" }
> +};
> +
> +static const struct mlxbf_pmc_events mlxbf_pmc_ecc_events[] =3D {
> +	{ 0x100, "ECC_SINGLE_ERROR_CNT" },
> +	{ 0x104, "ECC_DOUBLE_ERROR_CNT" },
> +	{ 0x114, "SERR_INJ" },
> +	{ 0x118, "DERR_INJ" },
> +	{ 0x124, "ECC_SINGLE_ERROR_0" },
> +	{ 0x164, "ECC_DOUBLE_ERROR_0" },
> +	{ 0x340, "DRAM_ECC_COUNT" },
> +	{ 0x344, "DRAM_ECC_INJECT" },
> +	{ 0x348, "DRAM_ECC_ERROR" }
> +};
> +
> +static const struct mlxbf_pmc_events mlxbf_pmc_mss_events[] =3D {
> +	{ 0xc0, "RXREQ_MSS" },
> +	{ 0xc1, "RXDAT_MSS" },
> +	{ 0xc2, "TXRSP_MSS" },
> +	{ 0xc3, "TXDAT_MSS" }
> +};
> +
> +static const struct mlxbf_pmc_events mlxbf_pmc_hnf_events[] =3D {
> +	{ 0x45, "HNF_REQUESTS" },
> +	{ 0x46, "HNF_REJECTS" },
> +	{ 0x47, "ALL_BUSY" },
> +	{ 0x48, "MAF_BUSY" },
> +	{ 0x49, "MAF_REQUESTS" },
> +	{ 0x4a, "RNF_REQUESTS" },
> +	{ 0x4b, "REQUEST_TYPE" },
> +	{ 0x4c, "MEMORY_READS" },
> +	{ 0x4d, "MEMORY_WRITES" },
> +	{ 0x4e, "VICTIM_WRITE" },
> +	{ 0x4f, "POC_FULL" },
> +	{ 0x50, "POC_FAIL" },
> +	{ 0x51, "POC_SUCCESS" },
> +	{ 0x52, "POC_WRITES" },
> +	{ 0x53, "POC_READS" },
> +	{ 0x54, "FORWARD" },
> +	{ 0x55, "RXREQ_HNF" },
> +	{ 0x56, "RXRSP_HNF" },
> +	{ 0x57, "RXDAT_HNF" },
> +	{ 0x58, "TXREQ_HNF" },
> +	{ 0x59, "TXRSP_HNF" },
> +	{ 0x5a, "TXDAT_HNF" },
> +	{ 0x5b, "TXSNP_HNF" },
> +	{ 0x5c, "INDEX_MATCH" },
> +	{ 0x5d, "A72_ACCESS" },
> +	{ 0x5e, "IO_ACCESS" },
> +	{ 0x5f, "TSO_WRITE" },
> +	{ 0x60, "TSO_CONFLICT" },
> +	{ 0x61, "DIR_HIT" },
> +	{ 0x62, "HNF_ACCEPTS" },
> +	{ 0x63, "REQ_BUF_EMPTY" },
> +	{ 0x64, "REQ_BUF_IDLE_MAF" },
> +	{ 0x65, "TSO_NOARB" },
> +	{ 0x66, "TSO_NOARB_CYCLES" },
> +	{ 0x67, "MSS_NO_CREDIT" },
> +	{ 0x68, "TXDAT_NO_LCRD" },
> +	{ 0x69, "TXSNP_NO_LCRD" },
> +	{ 0x6a, "TXRSP_NO_LCRD" },
> +	{ 0x6b, "TXREQ_NO_LCRD" },
> +	{ 0x6c, "TSO_CL_MATCH" },
> +	{ 0x6d, "MEMORY_READS_BYPASS" },
> +	{ 0x6e, "TSO_NOARB_TIMEOUT" },
> +	{ 0x6f, "ALLOCATE" },
> +	{ 0x70, "VICTIM" },
> +	{ 0x71, "A72_WRITE" },
> +	{ 0x72, "A72_READ" },
> +	{ 0x73, "IO_WRITE" },
> +	{ 0x74, "IO_READ" },
> +	{ 0x75, "TSO_REJECT" },
> +	{ 0x80, "TXREQ_RN" },
> +	{ 0x81, "TXRSP_RN" },
> +	{ 0x82, "TXDAT_RN" },
> +	{ 0x83, "RXSNP_RN" },
> +	{ 0x84, "RXRSP_RN" },
> +	{ 0x85, "RXDAT_RN" }
> +};
> +
> +static const struct mlxbf_pmc_events mlxbf_pmc_hnfnet_events[] =3D {
> +	{ 0x12, "CDN_REQ" },
> +	{ 0x13, "DDN_REQ" },
> +	{ 0x14, "NDN_REQ" },
> +	{ 0x15, "CDN_DIAG_N_OUT_OF_CRED" },
> +	{ 0x16, "CDN_DIAG_S_OUT_OF_CRED" },
> +	{ 0x17, "CDN_DIAG_E_OUT_OF_CRED" },
> +	{ 0x18, "CDN_DIAG_W_OUT_OF_CRED" },
> +	{ 0x19, "CDN_DIAG_C_OUT_OF_CRED" },
> +	{ 0x1a, "CDN_DIAG_N_EGRESS" },
> +	{ 0x1b, "CDN_DIAG_S_EGRESS" },
> +	{ 0x1c, "CDN_DIAG_E_EGRESS" },
> +	{ 0x1d, "CDN_DIAG_W_EGRESS" },
> +	{ 0x1e, "CDN_DIAG_C_EGRESS" },
> +	{ 0x1f, "CDN_DIAG_N_INGRESS" },
> +	{ 0x20, "CDN_DIAG_S_INGRESS" },
> +	{ 0x21, "CDN_DIAG_E_INGRESS" },
> +	{ 0x22, "CDN_DIAG_W_INGRESS" },
> +	{ 0x23, "CDN_DIAG_C_INGRESS" },
> +	{ 0x24, "CDN_DIAG_CORE_SENT" },
> +	{ 0x25, "DDN_DIAG_N_OUT_OF_CRED" },
> +	{ 0x26, "DDN_DIAG_S_OUT_OF_CRED" },
> +	{ 0x27, "DDN_DIAG_E_OUT_OF_CRED" },
> +	{ 0x28, "DDN_DIAG_W_OUT_OF_CRED" },
> +	{ 0x29, "DDN_DIAG_C_OUT_OF_CRED" },
> +	{ 0x2a, "DDN_DIAG_N_EGRESS" },
> +	{ 0x2b, "DDN_DIAG_S_EGRESS" },
> +	{ 0x2c, "DDN_DIAG_E_EGRESS" },
> +	{ 0x2d, "DDN_DIAG_W_EGRESS" },
> +	{ 0x2e, "DDN_DIAG_C_EGRESS" },
> +	{ 0x2f, "DDN_DIAG_N_INGRESS" },
> +	{ 0x30, "DDN_DIAG_S_INGRESS" },
> +	{ 0x31, "DDN_DIAG_E_INGRESS" },
> +	{ 0x32, "DDN_DIAG_W_INGRESS" },
> +	{ 0x33, "DDN_DIAG_C_INGRESS" },
> +	{ 0x34, "DDN_DIAG_CORE_SENT" },
> +	{ 0x35, "NDN_DIAG_S_OUT_OF_CRED" },
> +	{ 0x36, "NDN_DIAG_S_OUT_OF_CRED" },
> +	{ 0x37, "NDN_DIAG_E_OUT_OF_CRED" },
> +	{ 0x38, "NDN_DIAG_W_OUT_OF_CRED" },
> +	{ 0x39, "NDN_DIAG_C_OUT_OF_CRED" },
> +	{ 0x3a, "NDN_DIAG_N_EGRESS" },
> +	{ 0x3b, "NDN_DIAG_S_EGRESS" },
> +	{ 0x3c, "NDN_DIAG_E_EGRESS" },
> +	{ 0x3d, "NDN_DIAG_W_EGRESS" },
> +	{ 0x3e, "NDN_DIAG_C_EGRESS" },
> +	{ 0x3f, "NDN_DIAG_N_INGRESS" },
> +	{ 0x40, "NDN_DIAG_S_INGRESS" },
> +	{ 0x41, "NDN_DIAG_E_INGRESS" },
> +	{ 0x42, "NDN_DIAG_W_INGRESS" },
> +	{ 0x43, "NDN_DIAG_C_INGRESS" },
> +	{ 0x44, "NDN_DIAG_CORE_SENT" }
> +};
> +
> +static const struct mlxbf_pmc_events mlxbf_pmc_l3c_events[] =3D {
> +	{ 0x00, "DISABLE" },
> +	{ 0x01, "CYCLES" },
> +	{ 0x02, "TOTAL_RD_REQ_IN" },
> +	{ 0x03, "TOTAL_WR_REQ_IN" },
> +	{ 0x04, "TOTAL_WR_DBID_ACK" },
> +	{ 0x05, "TOTAL_WR_DATA_IN" },
> +	{ 0x06, "TOTAL_WR_COMP" },
> +	{ 0x07, "TOTAL_RD_DATA_OUT" },
> +	{ 0x08, "TOTAL_CDN_REQ_IN_BANK0" },
> +	{ 0x09, "TOTAL_CDN_REQ_IN_BANK1" },
> +	{ 0x0a, "TOTAL_DDN_REQ_IN_BANK0" },
> +	{ 0x0b, "TOTAL_DDN_REQ_IN_BANK1" },
> +	{ 0x0c, "TOTAL_EMEM_RD_RES_IN_BANK0" },
> +	{ 0x0d, "TOTAL_EMEM_RD_RES_IN_BANK1" },
> +	{ 0x0e, "TOTAL_CACHE_RD_RES_IN_BANK0" },
> +	{ 0x0f, "TOTAL_CACHE_RD_RES_IN_BANK1" },
> +	{ 0x10, "TOTAL_EMEM_RD_REQ_BANK0" },
> +	{ 0x11, "TOTAL_EMEM_RD_REQ_BANK1" },
> +	{ 0x12, "TOTAL_EMEM_WR_REQ_BANK0" },
> +	{ 0x13, "TOTAL_EMEM_WR_REQ_BANK1" },
> +	{ 0x14, "TOTAL_RD_REQ_OUT" },
> +	{ 0x15, "TOTAL_WR_REQ_OUT" },
> +	{ 0x16, "TOTAL_RD_RES_IN" },
> +	{ 0x17, "HITS_BANK0" },
> +	{ 0x18, "HITS_BANK1" },
> +	{ 0x19, "MISSES_BANK0" },
> +	{ 0x1a, "MISSES_BANK1" },
> +	{ 0x1b, "ALLOCATIONS_BANK0" },
> +	{ 0x1c, "ALLOCATIONS_BANK1" },
> +	{ 0x1d, "EVICTIONS_BANK0" },
> +	{ 0x1e, "EVICTIONS_BANK1" },
> +	{ 0x1f, "DBID_REJECT" },
> +	{ 0x20, "WRDB_REJECT_BANK0" },
> +	{ 0x21, "WRDB_REJECT_BANK1" },
> +	{ 0x22, "CMDQ_REJECT_BANK0" },
> +	{ 0x23, "CMDQ_REJECT_BANK1" },
> +	{ 0x24, "COB_REJECT_BANK0" },
> +	{ 0x25, "COB_REJECT_BANK1" },
> +	{ 0x26, "TRB_REJECT_BANK0" },
> +	{ 0x27, "TRB_REJECT_BANK1" },
> +	{ 0x28, "TAG_REJECT_BANK0" },
> +	{ 0x29, "TAG_REJECT_BANK1" },
> +	{ 0x2a, "ANY_REJECT_BANK0" },
> +	{ 0x2b, "ANY_REJECT_BANK1" }
> +};
> +
> +static struct mlxbf_pmc_context *pmc;
> +
> +/* UUID used to probe ATF service. */
> +static const char *mlxbf_pmc_svc_uuid_str =3D
> +"89c036b4-e7d7-11e6-8797-001aca00bfc4";
> +
> +/* Calls an SMC to access a performance register */ static int
> +mlxbf_pmc_secure_read(void __iomem *addr, uint32_t command,
> +				 uint64_t *result)
> +{
> +	struct arm_smccc_res res;
> +	int status, err =3D 0;
> +
> +	arm_smccc_smc(command, pmc->sreg_tbl_perf, (uintptr_t)addr, 0, 0,
> 0, 0,
> +		      0, &res);
> +
> +	status =3D res.a0;
> +
> +	switch (status) {
> +	case PSCI_RET_NOT_SUPPORTED:
> +		err =3D -EINVAL;
> +		break;
> +	case MLXBF_PMC_SMCCC_ACCESS_VIOLATION:
> +		err =3D -EACCES;
> +		break;
> +	default:
> +		*result =3D res.a1;
> +		break;
> +	}
> +
> +	return err;
> +}
> +
> +/* Read from a performance counter */
> +static int mlxbf_pmc_read(void __iomem *addr, uint32_t command,
> +			  uint64_t *result)
> +{
> +	if (pmc->svc_sreg_support)
> +		return mlxbf_pmc_secure_read(addr, command, result);
> +
> +	if (command =3D=3D MLXBF_PMC_READ_REG_32)
> +		*result =3D readl(addr);
> +	else
> +		*result =3D readq(addr);
> +
> +	return 0;
> +}
> +
> +/* Convenience function for 32-bit reads */ static int
> +mlxbf_pmc_readl(void __iomem *addr, uint32_t *result) {
> +	uint64_t read_out;
> +	int status;
> +
> +	status =3D mlxbf_pmc_read(addr, MLXBF_PMC_READ_REG_32,
> &read_out);
> +	if (status)
> +		return status;
> +	*result =3D (uint32_t)read_out;
> +
> +	return 0;
> +}
> +
> +/* Calls an SMC to access a performance register */ static int
> +mlxbf_pmc_secure_write(void __iomem *addr, uint32_t command,
> +				  uint64_t value)
> +{
> +	struct arm_smccc_res res;
> +	int status, err =3D 0;
> +
> +	arm_smccc_smc(command, pmc->sreg_tbl_perf, value,
> (uintptr_t)addr, 0, 0,
> +		      0, 0, &res);
> +
> +	status =3D res.a0;
> +
> +	switch (status) {
> +	case PSCI_RET_NOT_SUPPORTED:
> +		err =3D -EINVAL;
> +		break;
> +	case MLXBF_PMC_SMCCC_ACCESS_VIOLATION:
> +		err =3D -EACCES;
> +		break;
> +	}
> +
> +	return err;
> +}
> +
> +/* Write to a performance counter */
> +static int mlxbf_pmc_write(void __iomem *addr, int command, uint64_t
> +value) {
> +	if (pmc->svc_sreg_support)
> +		return mlxbf_pmc_secure_write(addr, command, value);
> +
> +	if (command =3D=3D MLXBF_PMC_WRITE_REG_32)
> +		writel(value, addr);
> +	else
> +		writeq(value, addr);
> +
> +	return 0;
> +}
> +
> +/* Check if the register offset is within the mapped region for the
> +block */ static bool mlxbf_pmc_valid_range(int blk_num, uint32_t
> +offset) {
> +	if ((offset >=3D 0) && !(offset % MLXBF_PMC_REG_SIZE) &&
> +	    (offset + MLXBF_PMC_REG_SIZE <=3D pmc->block[blk_num].blk_size))
> +		return true; /* inside the mapped PMC space */
> +
> +	return false;
> +}
> +
> +/* Get the event list corresponding to a certain block */ static const
> +struct mlxbf_pmc_events *mlxbf_pmc_event_list(const char *blk,
> +							   int *size)
> +{
> +	const struct mlxbf_pmc_events *events;
> +
> +	if (strstr(blk, "tilenet")) {
> +		events =3D mlxbf_pmc_hnfnet_events;
> +		*size =3D ARRAY_SIZE(mlxbf_pmc_hnfnet_events);
> +	} else if (strstr(blk, "tile")) {
> +		events =3D mlxbf_pmc_hnf_events;
> +		*size =3D ARRAY_SIZE(mlxbf_pmc_hnf_events);
> +	} else if (strstr(blk, "triogen")) {
> +		events =3D mlxbf_pmc_smgen_events;
> +		*size =3D ARRAY_SIZE(mlxbf_pmc_smgen_events);
> +	} else if (strstr(blk, "trio")) {
> +		switch (pmc->event_set) {
> +		case MLXBF_PMC_EVENT_SET_BF1:
> +			events =3D mlxbf_pmc_trio_events_1;
> +			*size =3D ARRAY_SIZE(mlxbf_pmc_trio_events_1);
> +			break;
> +		case MLXBF_PMC_EVENT_SET_BF2:
> +			events =3D mlxbf_pmc_trio_events_2;
> +			*size =3D ARRAY_SIZE(mlxbf_pmc_trio_events_2);
> +			break;
> +		default:
> +			events =3D NULL;
> +			*size =3D 0;
> +			break;
> +		}
> +	} else if (strstr(blk, "mss")) {
> +		events =3D mlxbf_pmc_mss_events;
> +		*size =3D ARRAY_SIZE(mlxbf_pmc_mss_events);
> +	} else if (strstr(blk, "ecc")) {
> +		events =3D mlxbf_pmc_ecc_events;
> +		*size =3D ARRAY_SIZE(mlxbf_pmc_ecc_events);
> +	} else if (strstr(blk, "pcie")) {
> +		events =3D mlxbf_pmc_pcie_events;
> +		*size =3D ARRAY_SIZE(mlxbf_pmc_pcie_events);
> +	} else if (strstr(blk, "l3cache")) {
> +		events =3D mlxbf_pmc_l3c_events;
> +		*size =3D ARRAY_SIZE(mlxbf_pmc_l3c_events);
> +	} else if (strstr(blk, "gic")) {
> +		events =3D mlxbf_pmc_smgen_events;
> +		*size =3D ARRAY_SIZE(mlxbf_pmc_smgen_events);
> +	} else if (strstr(blk, "smmu")) {
> +		events =3D mlxbf_pmc_smgen_events;
> +		*size =3D ARRAY_SIZE(mlxbf_pmc_smgen_events);
> +	} else {
> +		events =3D NULL;
> +		*size =3D 0;
> +	}
> +
> +	return events;
> +}
> +
> +/* Get the event number given the name */ static int
> +mlxbf_pmc_get_event_num(const char *blk, const char *evt) {
> +	const struct mlxbf_pmc_events *events;
> +	int i, size;
> +
> +	events =3D mlxbf_pmc_event_list(blk, &size);
> +	if (!events)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < size; ++i) {
> +		if (!strcmp(evt, events[i].evt_name))
> +			return events[i].evt_num;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +/* Get the event number given the name */ static char
> +*mlxbf_pmc_get_event_name(const char *blk, int evt) {
> +	const struct mlxbf_pmc_events *events;
> +	int i, size;
> +
> +	events =3D mlxbf_pmc_event_list(blk, &size);
> +	if (!events)
> +		return NULL;
> +
> +	for (i =3D 0; i < size; ++i) {
> +		if (evt =3D=3D events[i].evt_num)
> +			return events[i].evt_name;
> +	}
> +
> +	return NULL;
> +}
> +
> +/* Method to enable/disable/reset l3cache counters */ static int
> +mlxbf_pmc_config_l3_counters(int blk_num, bool enable, bool reset) {
> +	uint32_t perfcnt_cfg =3D 0;
> +
> +	if (enable)
> +		perfcnt_cfg |=3D MLXBF_PMC_L3C_PERF_CNT_CFG_EN;
> +	if (reset)
> +		perfcnt_cfg |=3D MLXBF_PMC_L3C_PERF_CNT_CFG_RST;
> +
> +	return mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
> +				       MLXBF_PMC_L3C_PERF_CNT_CFG,
> +			       MLXBF_PMC_WRITE_REG_32, perfcnt_cfg); }
> +
> +/* Method to handle l3cache counter programming */ static int
> +mlxbf_pmc_program_l3_counter(int blk_num, uint32_t cnt_num,
> +					uint32_t evt)
> +{
> +	uint32_t perfcnt_sel_1 =3D 0;
> +	uint32_t perfcnt_sel =3D 0;
> +	uint32_t *wordaddr;
> +	void __iomem *pmcaddr;
> +	int ret;
> +
> +	/* Disable all counters before programming them */
> +	if (mlxbf_pmc_config_l3_counters(blk_num, false, false))
> +		return -EINVAL;
> +
> +	/* Select appropriate register information */
> +	switch (cnt_num) {
> +	case 0 ... 3:
> +		pmcaddr =3D pmc->block[blk_num].mmio_base +
> +			  MLXBF_PMC_L3C_PERF_CNT_SEL;
> +		wordaddr =3D &perfcnt_sel;
> +		break;
> +	case 4:
> +		pmcaddr =3D pmc->block[blk_num].mmio_base +
> +			  MLXBF_PMC_L3C_PERF_CNT_SEL_1;
> +		wordaddr =3D &perfcnt_sel_1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret =3D mlxbf_pmc_readl(pmcaddr, wordaddr);
> +	if (ret)
> +		return ret;
> +
> +	switch (cnt_num) {
> +	case 0:
> +		perfcnt_sel &=3D ~MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_0;
> +		perfcnt_sel |=3D
> FIELD_PREP(MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_0,
> +					  evt);
> +		break;
> +	case 1:
> +		perfcnt_sel &=3D ~MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_1;
> +		perfcnt_sel |=3D
> FIELD_PREP(MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_1,
> +					  evt);
> +		break;
> +	case 2:
> +		perfcnt_sel &=3D ~MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_2;
> +		perfcnt_sel |=3D
> FIELD_PREP(MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_2,
> +					  evt);
> +		break;
> +	case 3:
> +		perfcnt_sel &=3D ~MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_3;
> +		perfcnt_sel |=3D
> FIELD_PREP(MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_3,
> +					  evt);
> +		break;
> +	case 4:
> +		perfcnt_sel_1 &=3D
> ~MLXBF_PMC_L3C_PERF_CNT_SEL_1_CNT_4;
> +		perfcnt_sel_1 |=3D
> FIELD_PREP(MLXBF_PMC_L3C_PERF_CNT_SEL_1_CNT_4,
> +					    evt);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return mlxbf_pmc_write(pmcaddr, MLXBF_PMC_WRITE_REG_32,
> *wordaddr); }
> +
> +/* Method to program a counter to monitor an event */ static int
> +mlxbf_pmc_program_counter(int blk_num, uint32_t cnt_num,
> +				     uint32_t evt, bool is_l3)
> +{
> +	uint64_t perfctl, perfevt, perfmon_cfg;
> +
> +	if (cnt_num >=3D pmc->block[blk_num].counters)
> +		return -ENODEV;
> +
> +	if (is_l3)
> +		return mlxbf_pmc_program_l3_counter(blk_num, cnt_num,
> evt);
> +
> +	/* Configure the counter */
> +	perfctl =3D FIELD_PREP(MLXBF_PMC_PERFCTL_EN0, 1);
> +	perfctl |=3D FIELD_PREP(MLXBF_PMC_PERFCTL_EB0, 0);
> +	perfctl |=3D FIELD_PREP(MLXBF_PMC_PERFCTL_ETRIG0, 1);
> +	perfctl |=3D FIELD_PREP(MLXBF_PMC_PERFCTL_AD0, 0);
> +	perfctl |=3D FIELD_PREP(MLXBF_PMC_PERFCTL_ACCM0, 0);
> +	perfctl |=3D FIELD_PREP(MLXBF_PMC_PERFCTL_MS0, 0);
> +	perfctl |=3D FIELD_PREP(MLXBF_PMC_PERFCTL_FM0, 0);
> +
> +	perfmon_cfg =3D FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_WDATA,
> perfctl);
> +	perfmon_cfg |=3D FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_ADDR,
> +				  MLXBF_PMC_PERFCTL);
> +	perfmon_cfg |=3D
> FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_STROBE, 1);
> +	perfmon_cfg |=3D
> FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_WR_R_B, 1);
> +
> +	if (mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
> +				    cnt_num * MLXBF_PMC_REG_SIZE,
> +			    MLXBF_PMC_WRITE_REG_64, perfmon_cfg))
> +		return -EFAULT;
> +
> +	/* Select the event */
> +	perfevt =3D FIELD_PREP(MLXBF_PMC_PERFEVT_EVTSEL, evt);
> +
> +	perfmon_cfg =3D FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_WDATA,
> perfevt);
> +	perfmon_cfg |=3D FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_ADDR,
> +				  MLXBF_PMC_PERFEVT);
> +	perfmon_cfg |=3D
> FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_STROBE, 1);
> +	perfmon_cfg |=3D
> FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_WR_R_B, 1);
> +
> +	if (mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
> +				    cnt_num * MLXBF_PMC_REG_SIZE,
> +			    MLXBF_PMC_WRITE_REG_64, perfmon_cfg))
> +		return -EFAULT;
> +
> +	/* Clear the accumulator */
> +	perfmon_cfg =3D FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_ADDR,
> +				 MLXBF_PMC_PERFACC0);
> +	perfmon_cfg |=3D
> FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_STROBE, 1);
> +	perfmon_cfg |=3D
> FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_WR_R_B, 1);
> +
> +	if (mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
> +				    cnt_num * MLXBF_PMC_REG_SIZE,
> +			    MLXBF_PMC_WRITE_REG_64, perfmon_cfg))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +/* Method to handle l3 counter reads */ static int
> +mlxbf_pmc_read_l3_counter(int blk_num, uint32_t cnt_num,
> +				     uint64_t *result)
> +{
> +	uint32_t perfcnt_low =3D 0, perfcnt_high =3D 0;
> +	uint64_t value;
> +	int status =3D 0;
> +
> +	status =3D mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
> +					 MLXBF_PMC_L3C_PERF_CNT_LOW +
> +					 cnt_num *
> MLXBF_PMC_L3C_REG_SIZE,
> +				 &perfcnt_low);
> +
> +	if (status)
> +		return status;
> +
> +	status =3D mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
> +					 MLXBF_PMC_L3C_PERF_CNT_HIGH +
> +					 cnt_num *
> MLXBF_PMC_L3C_REG_SIZE,
> +				 &perfcnt_high);
> +
> +	if (status)
> +		return status;
> +
> +	value =3D perfcnt_high;
> +	value =3D value << 32;
> +	value |=3D perfcnt_low;
> +	*result =3D value;
> +
> +	return 0;
> +}
> +
> +/* Method to read the counter value */
> +static int mlxbf_pmc_read_counter(int blk_num, uint32_t cnt_num, bool
> is_l3,
> +				  uint64_t *result)
> +{
> +	uint32_t perfcfg_offset, perfval_offset;
> +	uint64_t perfmon_cfg;
> +	int status;
> +
> +	if (cnt_num >=3D pmc->block[blk_num].counters)
> +		return -EINVAL;
> +
> +	if (is_l3)
> +		return mlxbf_pmc_read_l3_counter(blk_num, cnt_num,
> result);
> +
> +	perfcfg_offset =3D cnt_num * MLXBF_PMC_REG_SIZE;
> +	perfval_offset =3D perfcfg_offset +
> +			 pmc->block[blk_num].counters *
> MLXBF_PMC_REG_SIZE;
> +
> +	/* Set counter in "read" mode */
> +	perfmon_cfg =3D FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_ADDR,
> +				 MLXBF_PMC_PERFACC0);
> +	perfmon_cfg |=3D
> FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_STROBE, 1);
> +	perfmon_cfg |=3D
> FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_WR_R_B, 0);
> +
> +	status =3D mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
> perfcfg_offset,
> +				 MLXBF_PMC_WRITE_REG_64, perfmon_cfg);
> +
> +	if (status)
> +		return status;
> +
> +	/* Get the counter value */
> +	return mlxbf_pmc_read(pmc->block[blk_num].mmio_base +
> perfval_offset,
> +			      MLXBF_PMC_READ_REG_64, result); }
> +
> +/* Method to read L3 block event */
> +static int mlxbf_pmc_read_l3_event(int blk_num, uint32_t cnt_num,
> +				   uint64_t *result)
> +{
> +	uint32_t perfcnt_sel =3D 0, perfcnt_sel_1 =3D 0;
> +	uint32_t *wordaddr;
> +	void __iomem *pmcaddr;
> +	uint64_t evt;
> +
> +	/* Select appropriate register information */
> +	switch (cnt_num) {
> +	case 0 ... 3:
> +		pmcaddr =3D pmc->block[blk_num].mmio_base +
> +			  MLXBF_PMC_L3C_PERF_CNT_SEL;
> +		wordaddr =3D &perfcnt_sel;
> +		break;
> +	case 4:
> +		pmcaddr =3D pmc->block[blk_num].mmio_base +
> +			  MLXBF_PMC_L3C_PERF_CNT_SEL_1;
> +		wordaddr =3D &perfcnt_sel_1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (mlxbf_pmc_readl(pmcaddr, wordaddr))
> +		return -EINVAL;
> +
> +	/* Read from appropriate register field for the counter */
> +	switch (cnt_num) {
> +	case 0:
> +		evt =3D FIELD_GET(MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_0,
> perfcnt_sel);
> +		break;
> +	case 1:
> +		evt =3D FIELD_GET(MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_1,
> perfcnt_sel);
> +		break;
> +	case 2:
> +		evt =3D FIELD_GET(MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_2,
> perfcnt_sel);
> +		break;
> +	case 3:
> +		evt =3D FIELD_GET(MLXBF_PMC_L3C_PERF_CNT_SEL_CNT_3,
> perfcnt_sel);
> +		break;
> +	case 4:
> +		evt =3D FIELD_GET(MLXBF_PMC_L3C_PERF_CNT_SEL_1_CNT_4,
> +				perfcnt_sel_1);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	*result =3D evt;
> +
> +	return 0;
> +}
> +
> +/* Method to find the event currently being monitored by a counter */
> +static int mlxbf_pmc_read_event(int blk_num, uint32_t cnt_num, bool is_l=
3,
> +				uint64_t *result)
> +{
> +	uint32_t perfcfg_offset, perfval_offset;
> +	uint64_t perfmon_cfg, perfevt, perfctl;
> +
> +	if (cnt_num >=3D pmc->block[blk_num].counters)
> +		return -EINVAL;
> +
> +	if (is_l3)
> +		return mlxbf_pmc_read_l3_event(blk_num, cnt_num, result);
> +
> +	perfcfg_offset =3D cnt_num * MLXBF_PMC_REG_SIZE;
> +	perfval_offset =3D perfcfg_offset +
> +			 pmc->block[blk_num].counters *
> MLXBF_PMC_REG_SIZE;
> +
> +	/* Set counter in "read" mode */
> +	perfmon_cfg =3D FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_ADDR,
> +				 MLXBF_PMC_PERFCTL);
> +	perfmon_cfg |=3D
> FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_STROBE, 1);
> +	perfmon_cfg |=3D
> FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_WR_R_B, 0);
> +
> +	if (mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
> perfcfg_offset,
> +			    MLXBF_PMC_WRITE_REG_64, perfmon_cfg))
> +		return -EFAULT;
> +
> +	/* Check if the counter is enabled */
> +
> +	if (mlxbf_pmc_read(pmc->block[blk_num].mmio_base +
> perfval_offset,
> +			   MLXBF_PMC_READ_REG_64, &perfctl))
> +		return -EFAULT;
> +
> +	if (!FIELD_GET(MLXBF_PMC_PERFCTL_EN0, perfctl))
> +		return -EINVAL;
> +
> +	/* Set counter in "read" mode */
> +	perfmon_cfg =3D FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_ADDR,
> +				 MLXBF_PMC_PERFEVT);
> +	perfmon_cfg |=3D
> FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_STROBE, 1);
> +	perfmon_cfg |=3D
> FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_WR_R_B, 0);
> +
> +	if (mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
> perfcfg_offset,
> +			    MLXBF_PMC_WRITE_REG_64, perfmon_cfg))
> +		return -EFAULT;
> +
> +	/* Get the event number */
> +	if (mlxbf_pmc_read(pmc->block[blk_num].mmio_base +
> perfval_offset,
> +			   MLXBF_PMC_READ_REG_64, &perfevt))
> +		return -EFAULT;
> +
> +	*result =3D FIELD_GET(MLXBF_PMC_PERFEVT_EVTSEL, perfevt);
> +
> +	return 0;
> +}
> +
> +/* Method to read a register */
> +static int mlxbf_pmc_read_reg(int blk_num, uint32_t offset, uint64_t
> +*result) {
> +	uint32_t ecc_out;
> +
> +	if (strstr(pmc->block_name[blk_num], "ecc")) {
> +		if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
> offset,
> +				    &ecc_out))
> +			return -EFAULT;
> +
> +		*result =3D ecc_out;
> +		return 0;
> +	}
> +
> +	if (mlxbf_pmc_valid_range(blk_num, offset))
> +		return mlxbf_pmc_read(pmc->block[blk_num].mmio_base +
> offset,
> +				      MLXBF_PMC_READ_REG_64, result);
> +
> +	return -EINVAL;
> +}
> +
> +/* Method to write to a register */
> +static int mlxbf_pmc_write_reg(int blk_num, uint32_t offset, uint64_t
> +data) {
> +	if (strstr(pmc->block_name[blk_num], "ecc")) {
> +		return mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
> offset,
> +				       MLXBF_PMC_WRITE_REG_32, data);
> +	}
> +
> +	if (mlxbf_pmc_valid_range(blk_num, offset))
> +		return mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
> offset,
> +				       MLXBF_PMC_WRITE_REG_64, data);
> +
> +	return -EINVAL;
> +}
> +
> +/* Show function for "counter" sysfs files */ static ssize_t
> +mlxbf_pmc_counter_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf) {
> +	struct mlxbf_pmc_attribute *attr_counter =3D container_of(
> +		attr, struct mlxbf_pmc_attribute, dev_attr);
> +	int blk_num, cnt_num, offset;
> +	bool is_l3 =3D false;
> +	uint64_t value;
> +
> +	blk_num =3D attr_counter->nr;
> +	cnt_num =3D attr_counter->index;
> +
> +	if (strstr(pmc->block_name[blk_num], "l3cache"))
> +		is_l3 =3D true;
> +
> +	if (pmc->block[blk_num].type =3D=3D MLXBF_PMC_TYPE_COUNTER) {
> +		if (mlxbf_pmc_read_counter(blk_num, cnt_num, is_l3,
> &value))
> +			return -EINVAL;
> +	} else if (pmc->block[blk_num].type =3D=3D MLXBF_PMC_TYPE_REGISTER) {
> +		offset =3D mlxbf_pmc_get_event_num(pmc-
> >block_name[blk_num],
> +						 attr->attr.name);
> +		if (offset < 0)
> +			return -EINVAL;
> +		if (mlxbf_pmc_read_reg(blk_num, offset, &value))
> +			return -EINVAL;
> +	} else
> +		return -EINVAL;
> +
> +	return sprintf(buf, "0x%llx\n", value); }
> +
> +/* Store function for "counter" sysfs files */ static ssize_t
> +mlxbf_pmc_counter_store(struct device *dev,
> +				       struct device_attribute *attr,
> +				       const char *buf, size_t count) {
> +	struct mlxbf_pmc_attribute *attr_counter =3D container_of(
> +		attr, struct mlxbf_pmc_attribute, dev_attr);
> +	int blk_num, cnt_num, offset, err, data;
> +	bool is_l3 =3D false;
> +	uint64_t evt_num;
> +
> +	blk_num =3D attr_counter->nr;
> +	cnt_num =3D attr_counter->index;
> +
> +	err =3D sscanf(buf, "%x\n", &data);
> +	if (err < 0)
> +		return err;
> +
> +	/* Allow non-zero writes only to the ecc regs */
> +	if (!(strstr(pmc->block_name[blk_num], "ecc")) && data)
> +		return -EINVAL;
> +
> +	/* Do not allow writes to the L3C regs */
> +	if (strstr(pmc->block_name[blk_num], "l3cache"))
> +		return -EINVAL;
> +
> +	if (pmc->block[blk_num].type =3D=3D MLXBF_PMC_TYPE_COUNTER) {
> +		err =3D mlxbf_pmc_read_event(blk_num, cnt_num, is_l3,
> &evt_num);
> +		if (err)
> +			return err;
> +		err =3D mlxbf_pmc_program_counter(blk_num, cnt_num,
> evt_num,
> +						is_l3);
> +		if (err)
> +			return err;
> +	} else if (pmc->block[blk_num].type =3D=3D MLXBF_PMC_TYPE_REGISTER) {
> +		offset =3D mlxbf_pmc_get_event_num(pmc-
> >block_name[blk_num],
> +						 attr->attr.name);
> +		if (offset < 0)
> +			return -EINVAL;
> +		err =3D mlxbf_pmc_write_reg(blk_num, offset, data);
> +		if (err)
> +			return err;
> +	} else
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
> +/* Show function for "event" sysfs files */ static ssize_t
> +mlxbf_pmc_event_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf) {
> +	struct mlxbf_pmc_attribute *attr_event =3D container_of(
> +		attr, struct mlxbf_pmc_attribute, dev_attr);
> +	int blk_num, cnt_num, err;
> +	bool is_l3 =3D false;
> +	uint64_t evt_num;
> +	char *evt_name;
> +
> +	blk_num =3D attr_event->nr;
> +	cnt_num =3D attr_event->index;
> +
> +	if (strstr(pmc->block_name[blk_num], "l3cache"))
> +		is_l3 =3D true;
> +
> +	err =3D mlxbf_pmc_read_event(blk_num, cnt_num, is_l3, &evt_num);
> +	if (err)
> +		return sprintf(buf, "No event being monitored\n");
> +
> +	evt_name =3D mlxbf_pmc_get_event_name(pmc-
> >block_name[blk_num], evt_num);
> +	if (!evt_name)
> +		return -EINVAL;
> +
> +	return sprintf(buf, "0x%llx: %s\n", evt_num, evt_name); }
> +
> +/* Store function for "event" sysfs files */ static ssize_t
> +mlxbf_pmc_event_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count) {
> +	struct mlxbf_pmc_attribute *attr_event =3D container_of(
> +		attr, struct mlxbf_pmc_attribute, dev_attr);
> +	int blk_num, cnt_num, evt_num, err;
> +	bool is_l3 =3D false;
> +
> +	blk_num =3D attr_event->nr;
> +	cnt_num =3D attr_event->index;
> +
> +	if (isalpha(buf[0])) {
> +		evt_num =3D mlxbf_pmc_get_event_num(pmc-
> >block_name[blk_num],
> +						  buf);
> +		if (evt_num < 0)
> +			return -EINVAL;
> +	} else {
> +		err =3D sscanf(buf, "%x\n", &evt_num);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	if (strstr(pmc->block_name[blk_num], "l3cache"))
> +		is_l3 =3D true;
> +
> +	err =3D mlxbf_pmc_program_counter(blk_num, cnt_num, evt_num,
> is_l3);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +
> +/* Show function for "event_list" sysfs files */ static ssize_t
> +mlxbf_pmc_event_list_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct mlxbf_pmc_attribute *attr_event_list =3D container_of(
> +		attr, struct mlxbf_pmc_attribute, dev_attr);
> +	int blk_num, i, size, len =3D 0, ret =3D 0;
> +	const struct mlxbf_pmc_events *events;
> +	char e_info[MLXBF_PMC_EVENT_INFO_LEN];
> +
> +	blk_num =3D attr_event_list->nr;
> +
> +	events =3D mlxbf_pmc_event_list(pmc->block_name[blk_num], &size);
> +	if (!events)
> +		return -EINVAL;
> +
> +	for (i =3D 0, buf[0] =3D '\0'; i < size; ++i) {
> +		len +=3D sprintf(e_info, "0x%x: %s\n", events[i].evt_num,
> +			       events[i].evt_name);
> +		if (len > PAGE_SIZE)
> +			break;
> +		strcat(buf, e_info);
> +		ret =3D len;
> +	}
> +
> +	return ret;
> +}
> +
> +/* Show function for "enable" sysfs files - only for l3cache */ static
> +ssize_t mlxbf_pmc_enable_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf) {
> +	struct mlxbf_pmc_attribute *attr_enable =3D container_of(
> +		attr, struct mlxbf_pmc_attribute, dev_attr);
> +	uint32_t perfcnt_cfg;
> +	int blk_num, value;
> +
> +	blk_num =3D attr_enable->nr;
> +
> +	if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
> +				    MLXBF_PMC_L3C_PERF_CNT_CFG,
> +			    &perfcnt_cfg))
> +		return -EINVAL;
> +
> +	value =3D FIELD_GET(MLXBF_PMC_L3C_PERF_CNT_CFG_EN,
> perfcnt_cfg);
> +
> +	return sprintf(buf, "%d\n", value);
> +}
> +
> +/* Store function for "enable" sysfs files - only for l3cache */ static
> +ssize_t mlxbf_pmc_enable_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count) {
> +	struct mlxbf_pmc_attribute *attr_enable =3D container_of(
> +		attr, struct mlxbf_pmc_attribute, dev_attr);
> +	int err, en, blk_num;
> +
> +	blk_num =3D attr_enable->nr;
> +
> +	err =3D sscanf(buf, "%x\n", &en);
> +	if (err < 0)
> +		return err;
> +
> +	if (!en) {
> +		err =3D mlxbf_pmc_config_l3_counters(blk_num, false, false);
> +		if (err)
> +			return err;
> +	} else if (en =3D=3D 1) {
> +		err =3D mlxbf_pmc_config_l3_counters(blk_num, false, true);
> +		if (err)
> +			return err;
> +		err =3D mlxbf_pmc_config_l3_counters(blk_num, true, false);
> +		if (err)
> +			return err;
> +	} else
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
> +/* Populate attributes for blocks with counters to monitor performance
> +*/ static int mlxbf_pmc_init_perftype_counter(struct device *dev, int
> +blk_num) {
> +	struct mlxbf_pmc_attribute *attr;
> +	int i =3D 0, j =3D 0;
> +
> +	/* "event_list" sysfs to list events supported by the block */
> +	attr =3D &pmc->block[blk_num].attr_event_list;
> +	attr->dev_attr.attr.mode =3D 0444;
> +	attr->dev_attr.show =3D mlxbf_pmc_event_list_show;
> +	attr->nr =3D blk_num;
> +	attr->dev_attr.attr.name =3D devm_kasprintf(dev, GFP_KERNEL,
> "event_list");
> +	pmc->block[blk_num].block_attr[i] =3D &attr->dev_attr.attr;
> +	attr =3D NULL;
> +
> +	/* "enable" sysfs to start/stop the counters. Only in L3C blocks */
> +	if (strstr(pmc->block_name[blk_num], "l3cache")) {
> +		attr =3D &pmc->block[blk_num].attr_enable;
> +		attr->dev_attr.attr.mode =3D 0644;
> +		attr->dev_attr.show =3D mlxbf_pmc_enable_show;
> +		attr->dev_attr.store =3D mlxbf_pmc_enable_store;
> +		attr->nr =3D blk_num;
> +		attr->dev_attr.attr.name =3D devm_kasprintf(dev, GFP_KERNEL,
> +							  "enable");
> +		pmc->block[blk_num].block_attr[++i] =3D &attr->dev_attr.attr;
> +		attr =3D NULL;
> +	}
> +
> +	pmc->block[blk_num].attr_counter =3D devm_kcalloc(
> +		dev, pmc->block[blk_num].counters,
> +		sizeof(struct mlxbf_pmc_attribute), GFP_KERNEL);
> +	if (!pmc->block[blk_num].attr_counter)
> +		return -ENOMEM;
> +
> +	pmc->block[blk_num].attr_event =3D devm_kcalloc(
> +		dev, pmc->block[blk_num].counters,
> +		sizeof(struct mlxbf_pmc_attribute), GFP_KERNEL);
> +	if (!pmc->block[blk_num].attr_event)
> +		return -ENOMEM;
> +
> +	/* "eventX" and "counterX" sysfs to program and read counter values
> */
> +	for (j =3D 0; j < pmc->block[blk_num].counters; ++j) {
> +		attr =3D &pmc->block[blk_num].attr_counter[j];
> +		attr->dev_attr.attr.mode =3D 0644;
> +		attr->dev_attr.show =3D mlxbf_pmc_counter_show;
> +		attr->dev_attr.store =3D mlxbf_pmc_counter_store;
> +		attr->index =3D j;
> +		attr->nr =3D blk_num;
> +		attr->dev_attr.attr.name =3D devm_kasprintf(dev, GFP_KERNEL,
> +							  "counter%d", j);
> +		pmc->block[blk_num].block_attr[++i] =3D &attr->dev_attr.attr;
> +		attr =3D NULL;
> +
> +		attr =3D &pmc->block[blk_num].attr_event[j];
> +		attr->dev_attr.attr.mode =3D 0644;
> +		attr->dev_attr.show =3D mlxbf_pmc_event_show;
> +		attr->dev_attr.store =3D mlxbf_pmc_event_store;
> +		attr->index =3D j;
> +		attr->nr =3D blk_num;
> +		attr->dev_attr.attr.name =3D devm_kasprintf(dev, GFP_KERNEL,
> +							  "event%d", j);
> +		pmc->block[blk_num].block_attr[++i] =3D &attr->dev_attr.attr;
> +		attr =3D NULL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Populate attributes for blocks with registers to monitor performance
> +*/ static int mlxbf_pmc_init_perftype_reg(struct device *dev, int
> +blk_num) {
> +	struct mlxbf_pmc_attribute *attr;
> +	const struct mlxbf_pmc_events *events;
> +	int i =3D 0, j =3D 0;
> +
> +	events =3D mlxbf_pmc_event_list(pmc->block_name[blk_num], &j);
> +	if (!events)
> +		return -EINVAL;
> +
> +	pmc->block[blk_num].attr_event =3D devm_kcalloc(
> +		dev, j, sizeof(struct mlxbf_pmc_attribute), GFP_KERNEL);
> +	if (!pmc->block[blk_num].attr_event)
> +		return -ENOMEM;
> +
> +	while (j > 0) {
> +		--j;
> +		attr =3D &pmc->block[blk_num].attr_event[j];
> +		attr->dev_attr.attr.mode =3D 0644;
> +		attr->dev_attr.show =3D mlxbf_pmc_counter_show;
> +		attr->dev_attr.store =3D mlxbf_pmc_counter_store;
> +		attr->nr =3D blk_num;
> +		attr->dev_attr.attr.name =3D devm_kasprintf(dev, GFP_KERNEL,
> +							  events[j].evt_name);
> +		pmc->block[blk_num].block_attr[i] =3D &attr->dev_attr.attr;
> +		attr =3D NULL;
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Helper to create the bfperf sysfs sub-directories and files */
> +static int mlxbf_pmc_create_groups(struct device *dev, int blk_num) {
> +	int err;
> +
> +	/* Populate attributes based on counter type */
> +	if (pmc->block[blk_num].type =3D=3D MLXBF_PMC_TYPE_COUNTER)
> +		err =3D mlxbf_pmc_init_perftype_counter(dev, blk_num);
> +	else if (pmc->block[blk_num].type =3D=3D MLXBF_PMC_TYPE_REGISTER)
> +		err =3D mlxbf_pmc_init_perftype_reg(dev, blk_num);
> +	else
> +		err =3D -EINVAL;
> +
> +	if (err)
> +		return err;
> +
> +	/* Add a new attribute_group for the block */
> +	pmc->block[blk_num].block_attr_grp.attrs =3D pmc-
> >block[blk_num].block_attr;
> +	pmc->block[blk_num].block_attr_grp.name =3D devm_kasprintf(
> +		dev, GFP_KERNEL, pmc->block_name[blk_num]);
> +	pmc->groups[blk_num] =3D &pmc->block[blk_num].block_attr_grp;
> +
> +	return 0;
> +}
> +
> +static bool mlxbf_pmc_guid_match(const guid_t *guid,
> +				 const struct arm_smccc_res *res)
> +{
> +	guid_t id =3D GUID_INIT(res->a0, res->a1, res->a1 >> 16, res->a2,
> +			      res->a2 >> 8, res->a2 >> 16, res->a2 >> 24,
> +			      res->a3, res->a3 >> 8, res->a3 >> 16,
> +			      res->a3 >> 24);
> +
> +	return guid_equal(guid, &id);
> +}
> +
> +/* Helper to map the Performance Counters from the varios blocks */
> +static int mlxbf_pmc_map_counters(struct device *dev) {
> +	uint64_t info[MLXBF_PMC_INFO_SZ];
> +	int i, tile_num, ret;
> +
> +	for (i =3D 0; i < pmc->total_blocks; ++i) {
> +		if (strstr(pmc->block_name[i], "tile")) {
> +			ret =3D sscanf(pmc->block_name[i], "tile%d",
> &tile_num);
> +			if (ret < 0)
> +				return ret;
> +
> +			if (tile_num >=3D pmc->tile_count)
> +				continue;
> +		}
> +		ret =3D device_property_read_u64_array(dev, pmc-
> >block_name[i],
> +						     info,
> MLXBF_PMC_INFO_SZ);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Do not remap if the proper SMC calls are supported,
> +		 * since the SMC calls expect physical addresses.
> +		 */
> +		if (pmc->svc_sreg_support)
> +			pmc->block[i].mmio_base =3D (void __iomem *)info[0];
> +		else
> +			pmc->block[i].mmio_base =3D
> +				devm_ioremap(dev, info[0], info[1]);
> +
> +		pmc->block[i].blk_size =3D info[1];
> +		pmc->block[i].counters =3D info[2];
> +		pmc->block[i].type =3D info[3];
> +
> +		if (IS_ERR(pmc->block[i].mmio_base))
> +			return PTR_ERR(pmc->block[i].mmio_base);
> +
> +		ret =3D mlxbf_pmc_create_groups(dev, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mlxbf_pmc_probe(struct platform_device *pdev) {
> +	struct acpi_device *acpi_dev =3D ACPI_COMPANION(&pdev->dev);
> +	const char *hid =3D acpi_device_hid(acpi_dev);
> +	struct device *dev =3D &pdev->dev;
> +	struct arm_smccc_res res;
> +	guid_t guid;
> +	int ret;
> +
> +	/* Ensure we have the UUID we expect for this service. */
> +	arm_smccc_smc(MLXBF_PMC_SIP_SVC_UID, 0, 0, 0, 0, 0, 0, 0, &res);
> +	guid_parse(mlxbf_pmc_svc_uuid_str, &guid);
> +	if (!mlxbf_pmc_guid_match(&guid, &res))
> +		return -ENODEV;
> +
> +	pmc =3D devm_kzalloc(dev, sizeof(struct mlxbf_pmc_context),
> GFP_KERNEL);
> +	if (!pmc)
> +		return -ENOMEM;
> +
> +	/*
> +	 * ACPI indicates whether we use SMCs to access registers or not.
> +	 * If sreg_tbl_perf is not present, just assume we're not using SMCs.
> +	 */
> +	ret =3D device_property_read_u32(dev, "sec_reg_block",
> +				       &pmc->sreg_tbl_perf);
> +	if (ret) {
> +		pmc->svc_sreg_support =3D false;
> +	} else {
> +		/*
> +		 * Check service version to see if we actually do support the
> +		 * needed SMCs. If we have the calls we need, mark support
> for
> +		 * them in the pmc struct.
> +		 */
> +		arm_smccc_smc(MLXBF_PMC_SIP_SVC_VERSION, 0, 0, 0, 0, 0,
> 0, 0,
> +			      &res);
> +		if (res.a0 =3D=3D MLXBF_PMC_SVC_REQ_MAJOR &&
> +		    res.a1 >=3D MLXBF_PMC_SVC_MIN_MINOR)
> +			pmc->svc_sreg_support =3D true;
> +		else
> +			return -EINVAL;
> +	}
> +
> +	if (!strcmp(hid, "MLNXBFD0"))
> +		pmc->event_set =3D MLXBF_PMC_EVENT_SET_BF1;
> +	else if (!strcmp(hid, "MLNXBFD1"))
> +		pmc->event_set =3D MLXBF_PMC_EVENT_SET_BF2;
> +	else
> +		return -ENODEV;
> +
> +	ret =3D device_property_read_u32(dev, "block_num", &pmc-
> >total_blocks);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D device_property_read_string_array(dev, "block_name",
> +						pmc->block_name,
> +						pmc->total_blocks);
> +	if (ret !=3D pmc->total_blocks)
> +		return -EFAULT;
> +
> +	ret =3D device_property_read_u32(dev, "tile_num", &pmc->tile_count);
> +	if (ret)
> +		return ret;
> +
> +	pmc->pdev =3D pdev;
> +
> +	ret =3D mlxbf_pmc_map_counters(dev);
> +	if (ret)
> +		return ret;
> +
> +	pmc->hwmon_dev =3D devm_hwmon_device_register_with_groups(
> +		dev, "bfperf", pmc, pmc->groups);
> +	platform_set_drvdata(pdev, pmc);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id mlxbf_pmc_acpi_ids[] =3D { { "MLNXBFD=
0", 0
> },
> +							    { "MLNXBFD1", 0 },
> +							    {}, };
> +
> +MODULE_DEVICE_TABLE(acpi, mlxbf_pmc_acpi_ids); static struct
> +platform_driver pmc_driver =3D {
> +	.driver =3D { .name =3D "mlxbf-pmc",
> +		    .acpi_match_table =3D ACPI_PTR(mlxbf_pmc_acpi_ids), },
> +	.probe =3D mlxbf_pmc_probe,
> +};
> +
> +module_platform_driver(pmc_driver);
> +
> +MODULE_AUTHOR("Shravan Kumar Ramani <sramani@mellanox.com>");
> +MODULE_DESCRIPTION("Mellanox PMC driver"); MODULE_LICENSE("Dual
> +BSD/GPL");
> --
> 2.1.2

