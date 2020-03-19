Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC54DC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 03:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA0F20724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 03:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="OOpx54C/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCSDBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:01:51 -0400
Received: from mail-co1nam11on2136.outbound.protection.outlook.com ([40.107.220.136]:8224
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbgCSDBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 23:01:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyfBsB994APNK+nADHll6X2PPGoGCIT/mjzKxOC3SEDmVzQQKsFNnbRoaAnWZxNRxLYKWdyFPaEahYcg1UbmHHqt9fjukq1uDvHJkTdGsoBJSCan//lz0ghSgXFvl6SacIEqWANoLX4+QcuuiiARrkrtFuty2r8tJd0bRmJ+14PtwKn2opjry5dZwBCukRDHhtAXjtqJrurNSOrufhN8WJK6VY9blsUa1h0CaEWkR8pyX0AsI5x/Ispbm3zNDPsCdPkdNO9DgEl7D+hhHUEEqMr5BMOmrvLyiuIICQx/AUZyDp/+9FEvabXthpCwsAhd6Pj4yXDLz0CoFZ5b9h5yCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBEYikkCfnpCkraTJm0Qs8e5EQl/2Vwy2D9nB4ks4wU=;
 b=gAuAmZRtennDPLKMxyMu1R1G0OKPcwttTfGgMKbaaKGDRehryWvD2WQJYooAgj9L1DwH9Wq6mPystz2G/bThGlJKPLBo62g3Z9xuexlM30dgvXtGZq5Aw7yz9svR/h/1IhDKFdCKShVYyre7UCl+XK3KjsEZ1RJXxEha4tuDE/cZ1E1Dga9IhBILNfLTNjLXa3b3smF5GPvqUb/s57qSFMvx2wvQlj1CLPDpDVzRNQ430uExC/BRCR6VnCPf5Bp1VlS15bcJbhmBStaCA2k3k1WWzLy8SjPL1XMDTdLz7oBXtBEXCA6vehQsg3UZLdrfVVaIptlbHrUDxT/Y/tN4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBEYikkCfnpCkraTJm0Qs8e5EQl/2Vwy2D9nB4ks4wU=;
 b=OOpx54C/NBLEK/zU57pwNgLHHMFD/y7hrdHyTle8yVwreMX3toYslQ5l7b62MgvjklkvMA6sH7JBmyTgl8JCQqGI3V4aAzkJKuEWfz/N8vwxfqbKSnCC3I1JC7lDZtSKeHJNB+JSg8mCogf0qlS2/R6TRTzGshFZG+Z4OflYb2U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tuanphan@os.amperecomputing.com; 
Received: from MWHPR01MB2317.prod.exchangelabs.com (2603:10b6:300:28::16) by
 MWHPR01MB2589.prod.exchangelabs.com (2603:10b6:300:3d::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Thu, 19 Mar 2020 03:01:31 +0000
Received: from MWHPR01MB2317.prod.exchangelabs.com
 ([fe80::5151:bb2b:8ed2:b53c]) by MWHPR01MB2317.prod.exchangelabs.com
 ([fe80::5151:bb2b:8ed2:b53c%12]) with mapi id 15.20.2814.021; Thu, 19 Mar
 2020 03:01:31 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: [PATCH] driver/perf: Add PMU driver for the ARM DMC-620 memory
 controller.
From:   Tuan Phan <tuanphan@amperemail.onmicrosoft.com>
In-Reply-To: <593912ac-943c-349e-9e6e-bd2fda7fb97d@hisilicon.com>
Date:   Wed, 18 Mar 2020 20:01:28 -0700
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <843837AC-504F-471A-92DE-7071F60973E5@amperemail.onmicrosoft.com>
References: <1584491381-31492-1-git-send-email-tuanphan@os.amperecomputing.com>
 <593912ac-943c-349e-9e6e-bd2fda7fb97d@hisilicon.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-ClientProxiedBy: CY4PR22CA0031.namprd22.prod.outlook.com
 (2603:10b6:903:ed::17) To MWHPR01MB2317.prod.exchangelabs.com
 (2603:10b6:300:28::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.104] (73.151.103.95) by CY4PR22CA0031.namprd22.prod.outlook.com (2603:10b6:903:ed::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Thu, 19 Mar 2020 03:01:30 +0000
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Originating-IP: [73.151.103.95]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2cc348a-f707-460a-2c1d-08d7cbb1d361
X-MS-TrafficTypeDiagnostic: MWHPR01MB2589:|MWHPR01MB2589:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR01MB25890C7F5C455FD449241728E0F40@MWHPR01MB2589.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39840400004)(136003)(396003)(366004)(346002)(376002)(199004)(66946007)(2906002)(81166006)(956004)(8676002)(42882007)(66476007)(66556008)(8936002)(316002)(33656002)(16576012)(186003)(478600001)(81156014)(54906003)(6916009)(26005)(6486002)(5660300002)(2616005)(52116002)(16526019)(53546011)(4326008)(30864003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR01MB2589;H:MWHPR01MB2317.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
Received-SPF: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/zl2Q7QCGp6ftDH+0D9cjbtGrIL+jZbty60fnZrViceAki9OdQ2ILFOjhTQOel+iVUf/z6vapFHqQm/3P8GDmbe8famx/LvIXtvT/etNkkBjvcPOGtg6HoUGGJHSWg0ULq/5W7cbUyIA4oAUe4J0mVgNqbRebwtKljRHdML64+QFj1MnuJ8bt88GOXLIJh+PPD+fNCoYv6mj9VugCM3kO7dXu3ntQYKK4XbskWkZyt+BCB/J/uAcdVgGlltuiCD0/6mtO9jFf8QPu20vCaGb3VXLA5ffPnYrh1+k+3b2O6Y4p8DhKf4MM2qOEkywJ7ObND7i/XVm+ADDT2NulE3BQnejH+0dt5ki4iRI3ugjFizkgNdszSKdd/ExRRu1EjrX/a7sJGxpYo2+jw5Rb33eVsPOngpn4oi1ROoSRVjCcMFazXkxO6tOtOiaBq5Wzme
X-MS-Exchange-AntiSpam-MessageData: +0Akv3kpsP7+/LCdrH3t5JB1MoqIwudDdEcwgeqrGespnxGHCO7B/QsCGm02byKZPjExqD3I2pK1dlGhx4+ixZfQSV8KDnxIXgydaodaj+rnR0bs52v+x1UgH8mVspSsGg4gQX3nvF6tYS7SaWUsgQ==
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cc348a-f707-460a-2c1d-08d7cbb1d361
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 03:01:31.5683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUxTOpAQMgMDlWg2suLqn36An6Xyon4gj798vXiVaYMn//ytlN+Y7xhxKKBxTrIUhjmEOx+Dg8mXdITuPKy7Zu0bwwm1KezRZxzKl5O+spxPvlLub8IhyFeeW4WO9eNk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaokun,
Please find my comments below.

> On Mar 18, 2020, at 6:34 PM, Shaokun Zhang <zhangshaokun@hisilicon.com> w=
rote:
>=20
> Hi Tuan,
>=20
> On 2020/3/18 8:29, Tuan Phan wrote:
>> DMC-620 PMU supports total 10 counters which each is
>> independently programmable to different events and can
>> be started and stopped individually.
>>=20
>> DMC-620 PMU devices are named as arm_dmc620_<uid> where
>> <uid> is the UID of DMC-620 PMU ACPI node. Currently, it only
>> supports ACPI. Other platforms feel free to test and add
>> support for device tree.
>>=20
>> Usage example:
>>  #perf stat -e arm_dmc620_0/clk_cycle_count/ -C 0
>>  Get perf event for clk_cycle_count counter.
>>=20
>>  #perf stat -e arm_dmc620_0/clkdiv2_allocate,mask=3D0x1f,match=3D0x2f,
>>  incr=3D2,invert=3D1/ -C 0
>>  The above example shows how to specify mask, match, incr,
>>  invert parameters for clkdiv2_allocate event.
>>=20
>> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
>> ---
>> drivers/perf/Kconfig          |   8 +
>> drivers/perf/Makefile         |   1 +
>> drivers/perf/arm_dmc620_pmu.c | 836 ++++++++++++++++++++++++++++++++++++=
++++++
>> 3 files changed, 845 insertions(+)
>> create mode 100644 drivers/perf/arm_dmc620_pmu.c
>>=20
>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>> index 09ae8a9..8c5b5cf 100644
>> --- a/drivers/perf/Kconfig
>> +++ b/drivers/perf/Kconfig
>> @@ -129,4 +129,12 @@ config ARM_SPE_PMU
>> 	  Extension, which provides periodic sampling of operations in
>> 	  the CPU pipeline and reports this via the perf AUX interface.
>>=20
>> +config ARM_DMC620_PMU
>> +	bool "Enable PMU support for the ARM DMC-620 memory controller"
>> +	depends on ARM64 && ACPI
>> +	default n
>> +	help
>> +	  Support for PMU events monitoring on the ARM DMC-620 memory
>> +	  controller.
>> +
>> endmenu
>> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
>> index 2ebb4de..15a31ac 100644
>> --- a/drivers/perf/Makefile
>> +++ b/drivers/perf/Makefile
>> @@ -12,3 +12,4 @@ obj-$(CONFIG_QCOM_L3_PMU) +=3D qcom_l3_pmu.o
>> obj-$(CONFIG_THUNDERX2_PMU) +=3D thunderx2_pmu.o
>> obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
>> obj-$(CONFIG_ARM_SPE_PMU) +=3D arm_spe_pmu.o
>> +obj-$(CONFIG_ARM_DMC_PMU) +=3D arm_dmc_pmu.o
>> \ No newline at end of file
>> diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu=
.c
>> new file mode 100644
>> index 0000000..e222bdb
>> --- /dev/null
>> +++ b/drivers/perf/arm_dmc620_pmu.c
>> @@ -0,0 +1,836 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * ARM DMC-620 memory controller PMU driver
>> + *
>> + * Copyright (C) 2020 Ampere Computing LLC.
>> + */
>> +
>> +#define PMUNAME		"arm_dmc620"
>> +#define DRVNAME		PMUNAME "_pmu"
>> +#define pr_fmt(fmt)	DRVNAME ": " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/bitops.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/device.h>
>> +#include <linux/errno.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/perf_event.h>
>> +#include <linux/perf/arm_pmu.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/printk.h>
>> +
>> +#define DMC620_CNT_MAX_PERIOD				0xffffffff
>> +#define DMC620_PMU_CLKDIV2_MAX_COUNTERS			8
>> +#define DMC620_PMU_CLK_MAX_COUNTERS			2
>> +#define DMC620_PMU_MAX_COUNTERS				\
>> +	(DMC620_PMU_CLKDIV2_MAX_COUNTERS + DMC620_PMU_CLK_MAX_COUNTERS)
>> +
>> +#define DMC620_PMU_OVERFLOW_STATUS_CLKDIV2_OFFSET	8
>> +#define  DMC620_PMU_OVERFLOW_STATUS_CLKDIV2_MASK	\
>> +		(DMC620_PMU_CLKDIV2_MAX_COUNTERS - 1)
>> +#define DMC620_PMU_OVERFLOW_STATUS_CLK_OFFSET		12
>> +#define  DMC620_PMU_OVERFLOW_STATUS_CLK_MASK		\
>> +		(DMC620_PMU_CLK_MAX_COUNTERS - 1)
>> +#define DMC620_PMU_COUNTERS_BASE_OFFSET			16
>> +#define DMC620_PMU_COUNTER_MASK_31_00_OFFSET		0
>> +#define DMC620_PMU_COUNTER_MASK_63_32_OFFSET		4
>> +#define DMC620_PMU_COUNTER_MATCH_31_00_OFFSET		8
>> +#define DMC620_PMU_COUNTER_MATCH_63_32_OFFSET		12
>> +#define DMC620_PMU_COUNTER_CONTROL_OFFSET		16
>> +#define  DMC620_PMU_COUNTER_CONTROL_ENABLE_MASK		BIT(0)
>> +#define  DMC620_PMU_COUNTER_CONTROL_INVERT_SHIFT	1
>> +#define  DMC620_PMU_COUNTER_CONTROL_EVENT_MUX		(((x)&0x1f)>>2)
>> +#define  DMC620_PMU_COUNTER_CONTROL_EVENT_MUX_SHIFT	2
>> +#define  DMC620_PMU_COUNTER_CONTROL_INCR		(((x)&0x1ff)>>7)
>> +#define  DMC620_PMU_COUNTER_CONTROL_INCR_SHIFT		7
>> +#define DMC620_PMU_COUNTER_SNAPSHOT_OFFSET		24
>> +#define DMC620_PMU_COUNTER_VALUE_OFFSET			32
>> +#define DMC620_PMU_COUNTER_REG_BYTE_LENGTH		40
>> +
>> +#define DMC620_PMU_CLKDIV2_CYCLE_COUNT			0x0
>> +#define DMC620_PMU_CLKDIV2_ALLOCATE			0x1
>> +#define DMC620_PMU_CLKDIV2_QUEUE_DEPTH			0x2
>> +#define DMC620_PMU_CLKDIV2_WAITING_FOR_WR_DATA		0x3
>> +#define DMC620_PMU_CLKDIV2_READ_BACKLOG			0x4
>> +#define DMC620_PMU_CLKDIV2_WAITING_FOR_MI		0x5
>> +#define DMC620_PMU_CLKDIV2_HAZARD_RESOLUTION		0x6
>> +#define DMC620_PMU_CLKDIV2_ENQUEUE			0x7
>> +#define DMC620_PMU_CLKDIV2_ARBITRATE			0x8
>> +#define DMC620_PMU_CLKDIV2_LRANK_TURNAROUND_ACTIVATE	0x9
>> +#define DMC620_PMU_CLKDIV2_PRANK_TURNAROUND_ACTIVATE	0xA
>> +#define DMC620_PMU_CLKDIV2_READ_DEPTH			0xB
>> +#define DMC620_PMU_CLKDIV2_WRITE_DEPTH			0xC
>> +#define DMC620_PMU_CLKDIV2_HIGHHIGH_QOS_DEPTH		0xD
>> +#define DMC620_PMU_CLKDIV2_HIGH_QOS_DEPTH		0xE
>> +#define DMC620_PMU_CLKDIV2_MEDIUM_QOS_DEPTH		0xF
>> +#define DMC620_PMU_CLKDIV2_LOW_QOS_DEPTH		0x10
>> +#define DMC620_PMU_CLKDIV2_ACTIVATE			0x11
>> +#define DMC620_PMU_CLKDIV2_RDWR				0x12
>> +#define DMC620_PMU_CLKDIV2_REFRESH			0x13
>> +#define DMC620_PMU_CLKDIV2_TRAINING_REQUEST		0x14
>> +#define DMC620_PMU_CLKDIV2_T_MAC_TRACKER		0x15
>> +#define DMC620_PMU_CLKDIV2_BK_FSM_TRACKER		0x16
>> +#define DMC620_PMU_CLKDIV2_BK_OPEN_TRACKER		0x17
>> +#define DMC620_PMU_CLKDIV2_RANKS_IN_PWR_DOWN		0x18
>> +#define DMC620_PMU_CLKDIV2_RANKS_IN_SREF		0x19
>> +
>> +#define DMC620_PMU_CLK_CYCLE_COUNTER			0x20
>> +#define DMC620_PMU_CLK_REQUEST				0x21
>> +#define DMC620_PMU_CLK_UPLOAD_STALL			0x22
>> +#define DMC620_PMU_CLK_INDICATE_MASK			0x20
>> +
>> +struct arm_dmc620_pmu {
>> +	struct pmu		pmu;
>> +	struct platform_device	*pdev;
>> +
>> +	void __iomem		*pmu_csr;
>> +	int			irq;
>> +	cpumask_t		cpu;
>> +	struct hlist_node	hotplug_node;
>> +
>> +	/*
>> +	 * We put all clkdiv2 and clk counters to a same array.
>> +	 * The first DMC620_PMU_CLKDIV2_MAX_COUNTERS bits belong to
>> +	 * clkdiv2 counters, the last DMC620_PMU_CLK_MAX_COUNTERS
>> +	 * belong to clk counters.
>> +	 */
>> +	DECLARE_BITMAP(used_mask, DMC620_PMU_MAX_COUNTERS);
>> +	struct perf_event	*act_counter[DMC620_PMU_MAX_COUNTERS];
>> +};
>> +
>> +#define to_dmc620_pmu(p) (container_of(p, struct arm_dmc620_pmu, pmu))
>> +
>> +/* Keep track of our dynamic hotplug state */
>> +static enum cpuhp_state arm_dmc620_pmu_online;
>> +
>> +static ssize_t
>> +dmc620_pmu_events_sysfs_show(struct device *dev,
>> +			   struct device_attribute *attr, char *page)
>> +{
>> +	struct perf_pmu_events_attr *pmu_attr;
>> +
>> +	pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr);
>> +
>> +	return sprintf(page, "event=3D0x%03llx\n", pmu_attr->id);
>> +}
>> +
>> +#define DMC620_PMU_EVENT_ATTR(name, config)			\
>> +	PMU_EVENT_ATTR(name, dmc620_pmu_event_attr_##name,	\
>> +		       config, dmc620_pmu_events_sysfs_show)
>> +
>=20
> How about this and can simplify the event attributes?
>=20
> #define DMC620_PMU_EVENT_ATTR(name, config)                              =
           \
>       (&((struct perf_pmu_events_attr) {                                 =
     \
>               .attr =3D __ATTR(name, 0444, dmc620_pmu_events_sysfs_show, =
NULL),   \
>               .id =3D config,                                            =
       \
>       }).attr.attr)
>=20
> static struct attribute *arm_dmc620_pmu_events_attrs[] =3D {
> 	DMC620_PMU_EVENT_ATTR(clkdiv2_cycle_count, DMC620_PMU_CLKDIV2_CYCLE_COUN=
T),
> 	......
> };
=3D> Thanks for the suggestion. Though, the usage of PMU_EVENT_ATTR is bett=
er because it is defined in perf_event.h and if there are any changes in th=
e structure format later, we don=E2=80=99t need to update the drive, right?
>=20
>=20
> Thanks,
> Shaokun
>=20
>> +/* clkdiv2 events list */
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_cycle_count,
>> +		DMC620_PMU_CLKDIV2_CYCLE_COUNT);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_allocate,
>> +		DMC620_PMU_CLKDIV2_ALLOCATE);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_queue_depth,
>> +		DMC620_PMU_CLKDIV2_QUEUE_DEPTH);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_waiting_for_wr_data,
>> +		DMC620_PMU_CLKDIV2_WAITING_FOR_WR_DATA);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_read_backlog,
>> +		DMC620_PMU_CLKDIV2_READ_BACKLOG);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_waiting_for_mi,
>> +		DMC620_PMU_CLKDIV2_WAITING_FOR_MI);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_hazard_resolution,
>> +		DMC620_PMU_CLKDIV2_HAZARD_RESOLUTION);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_enqueue,
>> +		DMC620_PMU_CLKDIV2_ENQUEUE);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_arbitrate,
>> +		DMC620_PMU_CLKDIV2_ARBITRATE);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_lrank_turnaround_activate,
>> +		DMC620_PMU_CLKDIV2_LRANK_TURNAROUND_ACTIVATE);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_prank_turnaround_activate,
>> +		DMC620_PMU_CLKDIV2_PRANK_TURNAROUND_ACTIVATE);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_read_depth,
>> +		DMC620_PMU_CLKDIV2_READ_DEPTH);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_write_depth,
>> +		DMC620_PMU_CLKDIV2_WRITE_DEPTH);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_highigh_qos_depth,
>> +		DMC620_PMU_CLKDIV2_HIGHHIGH_QOS_DEPTH);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_high_qos_depth,
>> +		DMC620_PMU_CLKDIV2_HIGH_QOS_DEPTH);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_medium_qos_depth,
>> +		DMC620_PMU_CLKDIV2_MEDIUM_QOS_DEPTH);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_low_qos_depth,
>> +		DMC620_PMU_CLKDIV2_LOW_QOS_DEPTH);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_activate,
>> +		DMC620_PMU_CLKDIV2_ACTIVATE);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_rdwr,
>> +		DMC620_PMU_CLKDIV2_RDWR);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_refresh,
>> +		DMC620_PMU_CLKDIV2_REFRESH);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_training_request,
>> +		DMC620_PMU_CLKDIV2_TRAINING_REQUEST);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_t_mac_tracker,
>> +		DMC620_PMU_CLKDIV2_T_MAC_TRACKER);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_bk_fsm_tracker,
>> +		DMC620_PMU_CLKDIV2_BK_FSM_TRACKER);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_bk_open_tracker,
>> +		DMC620_PMU_CLKDIV2_BK_OPEN_TRACKER);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_ranks_in_pwr_down,
>> +		DMC620_PMU_CLKDIV2_RANKS_IN_PWR_DOWN);
>> +DMC620_PMU_EVENT_ATTR(clkdiv2_ranks_in_sref,
>> +		DMC620_PMU_CLKDIV2_RANKS_IN_SREF);
>> +
>> +/* clk events list */
>> +DMC620_PMU_EVENT_ATTR(clk_cycle_count,
>> +		DMC620_PMU_CLK_CYCLE_COUNTER);
>> +DMC620_PMU_EVENT_ATTR(clk_request,
>> +		DMC620_PMU_CLK_REQUEST);
>> +DMC620_PMU_EVENT_ATTR(clk_upload_stall,
>> +		DMC620_PMU_CLK_UPLOAD_STALL);
>> +
>> +static struct attribute *arm_dmc620_pmu_events_attrs[] =3D {
>> +	&dmc620_pmu_event_attr_clkdiv2_cycle_count.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_allocate.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_queue_depth.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_waiting_for_wr_data.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_read_backlog.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_waiting_for_mi.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_hazard_resolution.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_enqueue.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_arbitrate.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_lrank_turnaround_activate.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_prank_turnaround_activate.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_read_depth.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_write_depth.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_highigh_qos_depth.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_high_qos_depth.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_medium_qos_depth.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_low_qos_depth.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_activate.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_rdwr.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_refresh.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_training_request.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_t_mac_tracker.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_bk_fsm_tracker.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_bk_open_tracker.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_ranks_in_pwr_down.attr.attr,
>> +	&dmc620_pmu_event_attr_clkdiv2_ranks_in_sref.attr.attr,
>> +	&dmc620_pmu_event_attr_clk_cycle_count.attr.attr,
>> +	&dmc620_pmu_event_attr_clk_request.attr.attr,
>> +	&dmc620_pmu_event_attr_clk_upload_stall.attr.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group arm_dmc620_pmu_events_attr_group =3D {
>> +	.name =3D "events",
>> +	.attrs =3D arm_dmc620_pmu_events_attrs,
>> +};
>> +
>> +/* User ABI */
>> +#define ATTR_CFG_FLD_mask_CFG		config
>> +#define ATTR_CFG_FLD_mask_LO		0
>> +#define ATTR_CFG_FLD_mask_HI		44
>> +#define ATTR_CFG_FLD_match_CFG		config1
>> +#define ATTR_CFG_FLD_match_LO		0
>> +#define ATTR_CFG_FLD_match_HI		44
>> +#define ATTR_CFG_FLD_invert_CFG		config2
>> +#define ATTR_CFG_FLD_invert_LO		0
>> +#define ATTR_CFG_FLD_invert_HI		0
>> +#define ATTR_CFG_FLD_incr_CFG		config2
>> +#define ATTR_CFG_FLD_incr_LO		1
>> +#define ATTR_CFG_FLD_incr_HI		2
>> +#define ATTR_CFG_FLD_event_CFG		config2
>> +#define ATTR_CFG_FLD_event_LO		3
>> +#define ATTR_CFG_FLD_event_HI		8
>> +
>> +#define __GEN_PMU_FORMAT_ATTR(cfg, lo, hi)			\
>> +	(lo) =3D=3D (hi) ? #cfg ":" #lo "\n" : #cfg ":" #lo "-" #hi
>> +
>> +#define _GEN_PMU_FORMAT_ATTR(cfg, lo, hi)			\
>> +	__GEN_PMU_FORMAT_ATTR(cfg, lo, hi)
>> +
>> +#define GEN_PMU_FORMAT_ATTR(name)				\
>> +	PMU_FORMAT_ATTR(name,					\
>> +	_GEN_PMU_FORMAT_ATTR(ATTR_CFG_FLD_##name##_CFG,		\
>> +			     ATTR_CFG_FLD_##name##_LO,		\
>> +			     ATTR_CFG_FLD_##name##_HI))
>> +
>> +#define _ATTR_CFG_GET_FLD(attr, cfg, lo, hi)			\
>> +	((((attr)->cfg) >> lo) & GENMASK(hi - lo, 0))
>> +
>> +#define ATTR_CFG_GET_FLD(attr, name)				\
>> +	_ATTR_CFG_GET_FLD(attr,					\
>> +			  ATTR_CFG_FLD_##name##_CFG,		\
>> +			  ATTR_CFG_FLD_##name##_LO,		\
>> +			  ATTR_CFG_FLD_##name##_HI)
>> +
>> +GEN_PMU_FORMAT_ATTR(mask);
>> +GEN_PMU_FORMAT_ATTR(match);
>> +GEN_PMU_FORMAT_ATTR(invert);
>> +GEN_PMU_FORMAT_ATTR(incr);
>> +GEN_PMU_FORMAT_ATTR(event);
>> +
>> +static struct attribute *arm_dmc620_pmu_formats_attrs[] =3D {
>> +	&format_attr_mask.attr,
>> +	&format_attr_match.attr,
>> +	&format_attr_invert.attr,
>> +	&format_attr_incr.attr,
>> +	&format_attr_event.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group arm_dmc620_pmu_format_attr_group =3D {
>> +	.name	=3D "format",
>> +	.attrs	=3D arm_dmc620_pmu_formats_attrs,
>> +};
>> +
>> +static const struct attribute_group *arm_dmc620_pmu_attr_groups[] =3D {
>> +	&arm_dmc620_pmu_events_attr_group,
>> +	&arm_dmc620_pmu_format_attr_group,
>> +	NULL,
>> +};
>> +
>> +static inline
>> +unsigned int arm_dmc620_pmu_counter_read32(struct arm_dmc620_pmu *dmc62=
0_pmu,
>> +					  unsigned int idx,
>> +					  unsigned int offset)
>> +{
>> +	return readl(dmc620_pmu->pmu_csr + DMC620_PMU_COUNTERS_BASE_OFFSET +
>> +		(idx * DMC620_PMU_COUNTER_REG_BYTE_LENGTH + offset));
>> +}
>> +
>> +static inline
>> +void arm_dmc620_pmu_counter_write32(struct arm_dmc620_pmu *dmc620_pmu,
>> +					  unsigned int idx,
>> +					  unsigned int offset,
>> +					  unsigned int val)
>> +{
>> +	writel(val, dmc620_pmu->pmu_csr + DMC620_PMU_COUNTERS_BASE_OFFSET +
>> +		(idx * DMC620_PMU_COUNTER_REG_BYTE_LENGTH + offset));
>> +}
>> +
>> +static
>> +unsigned int arm_dmc620_event_to_counter_control(struct perf_event *eve=
nt)
>> +{
>> +	struct perf_event_attr *attr =3D &event->attr;
>> +	unsigned int reg =3D 0;
>> +
>> +	reg |=3D ATTR_CFG_GET_FLD(attr, invert) <<
>> +		DMC620_PMU_COUNTER_CONTROL_INVERT_SHIFT;
>> +	reg |=3D ATTR_CFG_GET_FLD(attr, incr) <<
>> +		DMC620_PMU_COUNTER_CONTROL_INCR_SHIFT;
>> +	reg |=3D (ATTR_CFG_GET_FLD(attr, event) &
>> +		~DMC620_PMU_CLK_INDICATE_MASK) <<
>> +		DMC620_PMU_COUNTER_CONTROL_EVENT_MUX_SHIFT;
>> +
>> +	return reg;
>> +}
>> +
>> +static int arm_dmc620_get_event_idx(struct perf_event *event)
>> +{
>> +	struct arm_dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
>> +	struct perf_event_attr *attr =3D &event->attr;
>> +	int start_idx, end_idx;
>> +	int idx;
>> +
>> +	if (ATTR_CFG_GET_FLD(attr, event) & DMC620_PMU_CLK_INDICATE_MASK) {
>> +		/* clk events are selected */
>> +		start_idx =3D DMC620_PMU_CLKDIV2_MAX_COUNTERS;
>> +		end_idx =3D DMC620_PMU_MAX_COUNTERS;
>> +	} else {
>> +		start_idx =3D 0;
>> +		end_idx =3D DMC620_PMU_CLKDIV2_MAX_COUNTERS;
>> +	}
>> +
>> +	for (idx =3D start_idx; idx < end_idx; ++idx) {
>> +		if (!test_and_set_bit(idx, dmc620_pmu->used_mask))
>> +			return idx;
>> +	}
>> +
>> +	/* The counters are all in use. */
>> +	return -EAGAIN;
>> +}
>> +
>> +static u64 arm_dmc620_pmu_read_counter(struct perf_event *event)
>> +{
>> +	struct arm_dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
>> +
>> +	return (u64)arm_dmc620_pmu_counter_read32(dmc620_pmu,
>> +			  event->hw.idx,
>> +			  DMC620_PMU_COUNTER_VALUE_OFFSET);
>> +}
>> +
>> +static void arm_dmc620_pmu_event_update(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc =3D &event->hw;
>> +	u64 delta, prev_count, new_count;
>> +
>> +	do {
>> +		/* We may also be called from the irq handler */
>> +		prev_count =3D local64_read(&hwc->prev_count);
>> +		new_count =3D arm_dmc620_pmu_read_counter(event);
>> +	} while (local64_cmpxchg(&hwc->prev_count,
>> +			prev_count, new_count) !=3D prev_count);
>> +	delta =3D (new_count - prev_count) & DMC620_CNT_MAX_PERIOD;
>> +	local64_add(delta, &event->count);
>> +}
>> +
>> +static void arm_dmc620_pmu_event_set_period(struct perf_event *event)
>> +{
>> +	struct arm_dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
>> +
>> +	/*
>> +	 * All DMC-620 PMU event counters are 32bit counters.
>> +	 * To handle cases of extreme interrupt latency, we program
>> +	 * the counter with half of the max count for the counters.
>> +	 */
>> +	u64 val =3D DMC620_CNT_MAX_PERIOD >> 1;
>> +
>> +	local64_set(&event->hw.prev_count, val);
>> +	arm_dmc620_pmu_counter_write32(dmc620_pmu,
>> +			  event->hw.idx, DMC620_PMU_COUNTER_VALUE_OFFSET,
>> +			  val);
>> +}
>> +
>> +static void arm_dmc620_pmu_enable_counter(struct perf_event *event)
>> +{
>> +	struct arm_dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
>> +	unsigned int reg;
>> +
>> +	reg =3D arm_dmc620_pmu_counter_read32(dmc620_pmu,
>> +			  event->hw.idx, DMC620_PMU_COUNTER_CONTROL_OFFSET);
>> +	reg |=3D DMC620_PMU_COUNTER_CONTROL_ENABLE_MASK;
>> +	arm_dmc620_pmu_counter_write32(dmc620_pmu,
>> +			  event->hw.idx, DMC620_PMU_COUNTER_CONTROL_OFFSET,
>> +			  reg);
>> +}
>> +
>> +static void arm_dmc620_pmu_disable_counter(struct perf_event *event)
>> +{
>> +	struct arm_dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
>> +	unsigned int reg;
>> +
>> +	reg =3D arm_dmc620_pmu_counter_read32(dmc620_pmu,
>> +			  event->hw.idx, DMC620_PMU_COUNTER_CONTROL_OFFSET);
>> +	reg &=3D ~DMC620_PMU_COUNTER_CONTROL_ENABLE_MASK;
>> +	arm_dmc620_pmu_counter_write32(dmc620_pmu,
>> +			  event->hw.idx, DMC620_PMU_COUNTER_CONTROL_OFFSET,
>> +			  reg);
>> +}
>> +
>> +static irqreturn_t arm_dmc620_pmu_handle_irq(int irq_num, void *dev)
>> +{
>> +	struct arm_dmc620_pmu *dmc620_pmu =3D dev;
>> +	struct perf_event *event;
>> +	bool handled =3D false;
>> +	unsigned long overflow_clkdiv2, overflow_clk;
>> +	int i;
>> +
>> +	overflow_clkdiv2 =3D readl(dmc620_pmu->pmu_csr +
>> +				DMC620_PMU_OVERFLOW_STATUS_CLKDIV2_OFFSET);
>> +	overflow_clk =3D readl(dmc620_pmu->pmu_csr +
>> +				DMC620_PMU_OVERFLOW_STATUS_CLK_OFFSET);
>> +	if (!overflow_clkdiv2 && !overflow_clk)
>> +		return IRQ_NONE;
>> +
>> +	for_each_set_bit(i, &overflow_clkdiv2,
>> +				DMC620_PMU_CLKDIV2_MAX_COUNTERS) {
>> +		/* clkdiv2 event overflow */
>> +		event =3D dmc620_pmu->act_counter[i];
>> +		if (!event)
>> +			continue;
>> +		arm_dmc620_pmu_disable_counter(event);
>> +		arm_dmc620_pmu_event_update(event);
>> +		arm_dmc620_pmu_event_set_period(event);
>> +		arm_dmc620_pmu_enable_counter(event);
>> +		handled =3D true;
>> +	}
>> +
>> +	for_each_set_bit(i, &overflow_clk,
>> +				DMC620_PMU_CLK_MAX_COUNTERS) {
>> +		/* clk event overflow */
>> +		event =3D dmc620_pmu->act_counter[i +
>> +			DMC620_PMU_CLKDIV2_MAX_COUNTERS];
>> +		if (!event)
>> +			continue;
>> +		arm_dmc620_pmu_disable_counter(event);
>> +		arm_dmc620_pmu_event_update(event);
>> +		arm_dmc620_pmu_event_set_period(event);
>> +		arm_dmc620_pmu_enable_counter(event);
>> +		handled =3D true;
>> +	}
>> +
>> +	if (overflow_clkdiv2)
>> +		writel(0, dmc620_pmu->pmu_csr +
>> +			DMC620_PMU_OVERFLOW_STATUS_CLKDIV2_OFFSET);
>> +	if (overflow_clk)
>> +		writel(0, dmc620_pmu->pmu_csr +
>> +			DMC620_PMU_OVERFLOW_STATUS_CLK_OFFSET);
>> +
>> +	return IRQ_RETVAL(handled);
>> +}
>> +
>> +static int arm_dmc620_pmu_event_init(struct perf_event *event)
>> +{
>> +	struct arm_dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
>> +	struct hw_perf_event *hwc =3D &event->hw;
>> +	struct perf_event *sibling;
>> +
>> +	if (event->attr.type !=3D event->pmu->type)
>> +		return -ENOENT;
>> +
>> +	/*
>> +	 * DMC 620 PMUs are shared across all cpus and cannot
>> +	 * support task bound and sampling events.
>> +	 */
>> +	if (is_sampling_event(event) ||
>> +		event->attach_state & PERF_ATTACH_TASK) {
>> +		dev_dbg(dmc620_pmu->pmu.dev,
>> +			"Can't support per-task counters\n");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (event->cpu < 0) {
>> +		dev_dbg(dmc620_pmu->pmu.dev,
>> +			"Per-task mode not supported\n");
>> +		return -EOPNOTSUPP;
>> +	}
>> +	/*
>> +	 * Many perf core operations (eg. events rotation) operate on a
>> +	 * single CPU context. This is obvious for CPU PMUs, where one
>> +	 * expects the same sets of events being observed on all CPUs,
>> +	 * but can lead to issues for off-core PMUs, where each
>> +	 * event could be theoretically assigned to a different CPU. To
>> +	 * mitigate this, we enforce CPU assignment to one, selected
>> +	 * processor.
>> +	 */
>> +	event->cpu =3D cpumask_first(&dmc620_pmu->cpu);
>> +
>> +	/*
>> +	 * We must NOT create groups containing mixed PMUs, although software
>> +	 * events are acceptable
>> +	 */
>> +	if (event->group_leader->pmu !=3D event->pmu &&
>> +			!is_software_event(event->group_leader))
>> +		return -EINVAL;
>> +
>> +	for_each_sibling_event(sibling, event->group_leader) {
>> +		if (sibling->pmu !=3D event->pmu &&
>> +				!is_software_event(sibling))
>> +			return -EINVAL;
>> +	}
>> +
>> +	hwc->idx =3D -1;
>> +	return 0;
>> +}
>> +
>> +static void arm_dmc620_pmu_read(struct perf_event *event)
>> +{
>> +	arm_dmc620_pmu_event_update(event);
>> +}
>> +
>> +static void arm_dmc620_pmu_start(struct perf_event *event, int flags)
>> +{
>> +	struct arm_dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
>> +
>> +	event->hw.state =3D 0;
>> +	arm_dmc620_pmu_event_set_period(event);
>> +
>> +	if (flags & PERF_EF_RELOAD) {
>> +		unsigned long prev_raw_count =3D
>> +			local64_read(&event->hw.prev_count);
>> +
>> +		arm_dmc620_pmu_counter_write32(dmc620_pmu,
>> +			  event->hw.idx, DMC620_PMU_COUNTER_VALUE_OFFSET,
>> +			  (unsigned int)prev_raw_count);
>> +	}
>> +	arm_dmc620_pmu_enable_counter(event);
>> +}
>> +
>> +static void arm_dmc620_pmu_stop(struct perf_event *event, int flags)
>> +{
>> +	if (event->hw.state & PERF_HES_STOPPED)
>> +		return;
>> +
>> +	arm_dmc620_pmu_disable_counter(event);
>> +	arm_dmc620_pmu_event_update(event);
>> +	event->hw.state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
>> +}
>> +
>> +static int arm_dmc620_pmu_add(struct perf_event *event, int flags)
>> +{
>> +	struct arm_dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
>> +	struct hw_perf_event *hwc =3D &event->hw;
>> +	struct perf_event_attr *attr =3D &event->attr;
>> +	unsigned long reg;
>> +	int idx =3D 0;
>> +
>> +	idx =3D arm_dmc620_get_event_idx(event);
>> +	if (idx < 0)
>> +		return idx;
>> +
>> +	hwc->idx =3D idx;
>> +	dmc620_pmu->act_counter[idx] =3D event;
>> +	hwc->state =3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
>> +
>> +	/* Write to mask 31-00 register */
>> +	reg =3D ATTR_CFG_GET_FLD(attr, mask);
>> +	arm_dmc620_pmu_counter_write32(dmc620_pmu,
>> +			  event->hw.idx, DMC620_PMU_COUNTER_MASK_31_00_OFFSET,
>> +			  (unsigned int)(reg & 0xffffffff));
>> +	/* Write to mask 63-32 register */
>> +	arm_dmc620_pmu_counter_write32(dmc620_pmu,
>> +			  event->hw.idx, DMC620_PMU_COUNTER_MASK_63_32_OFFSET,
>> +			  (unsigned int)(reg >> 32));
>> +
>> +	/* Write to match 31-00 register */
>> +	reg =3D ATTR_CFG_GET_FLD(attr, match);
>> +	arm_dmc620_pmu_counter_write32(dmc620_pmu,
>> +			  event->hw.idx, DMC620_PMU_COUNTER_MATCH_31_00_OFFSET,
>> +			  (unsigned int)(reg & 0xffffffff));
>> +	/* Write to match 63-32 register */
>> +	arm_dmc620_pmu_counter_write32(dmc620_pmu,
>> +			  event->hw.idx, DMC620_PMU_COUNTER_MATCH_63_32_OFFSET,
>> +			  (unsigned int)(reg >> 32));
>> +
>> +	/* Write to control register */
>> +	reg =3D arm_dmc620_event_to_counter_control(event);
>> +	arm_dmc620_pmu_counter_write32(dmc620_pmu,
>> +			  event->hw.idx, DMC620_PMU_COUNTER_CONTROL_OFFSET,
>> +			  (unsigned int)reg);
>> +
>> +	if (flags & PERF_EF_START)
>> +		arm_dmc620_pmu_start(event, PERF_EF_RELOAD);
>> +
>> +	perf_event_update_userpage(event);
>> +	return 0;
>> +}
>> +
>> +static void arm_dmc620_pmu_del(struct perf_event *event, int flags)
>> +{
>> +	struct arm_dmc620_pmu *dmc620_pmu =3D to_dmc620_pmu(event->pmu);
>> +	struct hw_perf_event *hwc =3D &event->hw;
>> +	int idx =3D hwc->idx;
>> +
>> +	arm_dmc620_pmu_stop(event, PERF_EF_UPDATE);
>> +	dmc620_pmu->act_counter[idx] =3D NULL;
>> +	clear_bit(idx, dmc620_pmu->used_mask);
>> +	perf_event_update_userpage(event);
>> +}
>> +
>> +static int arm_dmc620_pmu_perf_init(struct arm_dmc620_pmu *dmc620_pmu)
>> +{
>> +	struct device *dev =3D &dmc620_pmu->pdev->dev;
>> +	unsigned long long value;
>> +	char *name;
>> +	acpi_handle handle;
>> +	acpi_status status;
>> +
>> +	dmc620_pmu->pmu =3D (struct pmu) {
>> +		.capabilities	=3D PERF_PMU_CAP_NO_EXCLUDE,
>> +		.task_ctx_nr	=3D perf_invalid_context,
>> +		.event_init	=3D arm_dmc620_pmu_event_init,
>> +		.add		=3D arm_dmc620_pmu_add,
>> +		.del		=3D arm_dmc620_pmu_del,
>> +		.start		=3D arm_dmc620_pmu_start,
>> +		.stop		=3D arm_dmc620_pmu_stop,
>> +		.read		=3D arm_dmc620_pmu_read,
>> +		.attr_groups	=3D arm_dmc620_pmu_attr_groups,
>> +	};
>> +
>> +	handle =3D ACPI_HANDLE(dev);
>> +	if (!handle)
>> +		return -ENODEV;
>> +
>> +	status =3D acpi_evaluate_integer(handle, METHOD_NAME__UID, NULL,
>> +					&value);
>> +	if (ACPI_FAILURE(status)) {
>> +		dev_err(dev, "Failed to evaluate _UID (0x%x)\n", status);
>> +		return -ENODEV;
>> +	}
>> +
>> +	name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_%d", PMUNAME,
>> +				(unsigned int)value);
>> +
>> +	return perf_pmu_register(&dmc620_pmu->pmu, name, -1);
>> +}
>> +
>> +static void arm_dmc620_pmu_perf_destroy(struct arm_dmc620_pmu *dmc620_p=
mu)
>> +{
>> +	perf_pmu_unregister(&dmc620_pmu->pmu);
>> +}
>> +
>> +static int arm_dmc620_pmu_cpu_startup(unsigned int cpu,
>> +				   struct hlist_node *node)
>> +{
>> +	struct arm_dmc620_pmu *dmc620_pmu =3D hlist_entry_safe(node,
>> +						struct arm_dmc620_pmu,
>> +						hotplug_node);
>> +
>> +	dmc620_pmu =3D hlist_entry_safe(node, struct arm_dmc620_pmu,
>> +					hotplug_node);
>> +	if (cpumask_empty(&dmc620_pmu->cpu))
>> +		cpumask_set_cpu(cpu, &dmc620_pmu->cpu);
>> +
>> +	/* Overflow interrupt also should use the same CPU */
>> +	WARN_ON(irq_set_affinity(dmc620_pmu->irq, &dmc620_pmu->cpu));
>> +
>> +	return 0;
>> +}
>> +
>> +static int arm_dmc620_pmu_cpu_teardown(unsigned int cpu,
>> +				   struct hlist_node *node)
>> +{
>> +	struct arm_dmc620_pmu *dmc620_pmu =3D hlist_entry_safe(node,
>> +						struct arm_dmc620_pmu,
>> +						hotplug_node);
>> +	unsigned int target;
>> +
>> +	if (!cpumask_test_and_clear_cpu(cpu, &dmc620_pmu->cpu))
>> +		return 0;
>> +
>> +	target =3D cpumask_any_but(cpu_online_mask, cpu);
>> +	if (target >=3D nr_cpu_ids)
>> +		return 0;
>> +
>> +	cpumask_set_cpu(target, &dmc620_pmu->cpu);
>> +
>> +	/* Overflow interrupt also should use the same CPU */
>> +	WARN_ON(irq_set_affinity(dmc620_pmu->irq, &dmc620_pmu->cpu));
>> +
>> +	return 0;
>> +}
>> +
>> +static int arm_dmc620_pmu_dev_init(struct arm_dmc620_pmu *dmc620_pmu)
>> +{
>> +	struct platform_device *pdev =3D dmc620_pmu->pdev;
>> +	int ret;
>> +
>> +	ret =3D devm_request_irq(&pdev->dev, dmc620_pmu->irq,
>> +				arm_dmc620_pmu_handle_irq,
>> +				IRQF_SHARED,
>> +				dev_name(&pdev->dev), dmc620_pmu);
>> +	if (ret)
>> +		dev_err(&pdev->dev,
>> +			"Could not request IRQ %d\n", dmc620_pmu->irq);
>> +
>> +	/*
>> +	 * Register our hotplug notifier now so we don't miss any events.
>> +	 */
>> +	return cpuhp_state_add_instance(arm_dmc620_pmu_online,
>> +				       &dmc620_pmu->hotplug_node);
>> +}
>> +
>> +static void arm_dmc620_pmu_dev_teardown(struct arm_dmc620_pmu *dmc620_p=
mu)
>> +{
>> +	cpuhp_state_remove_instance(arm_dmc620_pmu_online,
>> +					&dmc620_pmu->hotplug_node);
>> +}
>> +
>> +static int arm_dmc620_pmu_resource_probe(struct arm_dmc620_pmu *dmc620_=
pmu)
>> +{
>> +	struct platform_device *pdev =3D dmc620_pmu->pdev;
>> +	struct resource *res;
>> +	int irq;
>> +
>> +	irq =3D platform_get_irq(pdev, 0);
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev, "failed to get IRQ (%d)\n", irq);
>> +		return -ENXIO;
>> +	}
>> +	dmc620_pmu->irq =3D irq;
>> +
>> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	dmc620_pmu->pmu_csr =3D devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(dmc620_pmu->pmu_csr)) {
>> +		dev_err(&pdev->dev,
>> +			"ioremap failed for DMC-620 PMU resource\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int arm_dmc620_pmu_device_probe(struct platform_device *pdev)
>> +{
>> +	struct arm_dmc620_pmu *dmc620_pmu;
>> +	struct device *dev =3D &pdev->dev;
>> +	int ret;
>> +
>> +	dmc620_pmu =3D devm_kzalloc(dev, sizeof(*dmc620_pmu), GFP_KERNEL);
>> +	if (!dmc620_pmu)
>> +		return -ENOMEM;
>> +
>> +	dmc620_pmu->pdev =3D pdev;
>> +	platform_set_drvdata(pdev, dmc620_pmu);
>> +
>> +	ret =3D arm_dmc620_pmu_resource_probe(dmc620_pmu);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D arm_dmc620_pmu_dev_init(dmc620_pmu);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D arm_dmc620_pmu_perf_init(dmc620_pmu);
>> +	if (ret)
>> +		goto out_teardown_dev;
>> +
>> +	return 0;
>> +
>> +out_teardown_dev:
>> +	arm_dmc620_pmu_dev_teardown(dmc620_pmu);
>> +	return ret;
>> +}
>> +
>> +static int arm_dmc620_pmu_device_remove(struct platform_device *pdev)
>> +{
>> +	struct arm_dmc620_pmu *dmc620_pmu =3D platform_get_drvdata(pdev);
>> +
>> +	arm_dmc620_pmu_perf_destroy(dmc620_pmu);
>> +	arm_dmc620_pmu_dev_teardown(dmc620_pmu);
>> +	return 0;
>> +}
>> +
>> +static const struct acpi_device_id arm_dmc620_acpi_match[] =3D {
>> +	{ "ARMHD620", 0},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(acpi, arm_dmc620_acpi_match);
>> +static struct platform_driver arm_dmc620_pmu_driver =3D {
>> +	.driver	=3D {
>> +		.name		=3D DRVNAME,
>> +		.acpi_match_table =3D ACPI_PTR(arm_dmc620_acpi_match),
>> +	},
>> +	.probe	=3D arm_dmc620_pmu_device_probe,
>> +	.remove	=3D arm_dmc620_pmu_device_remove,
>> +};
>> +
>> +static int __init arm_dmc620_pmu_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, DRVNAME,
>> +				      arm_dmc620_pmu_cpu_startup,
>> +				      arm_dmc620_pmu_cpu_teardown);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	arm_dmc620_pmu_online =3D ret;
>> +
>> +	ret =3D platform_driver_register(&arm_dmc620_pmu_driver);
>> +	if (ret)
>> +		cpuhp_remove_multi_state(arm_dmc620_pmu_online);
>> +
>> +	return ret;
>> +}
>> +
>> +static void __exit arm_dmc620_pmu_exit(void)
>> +{
>> +	platform_driver_unregister(&arm_dmc620_pmu_driver);
>> +	cpuhp_remove_multi_state(arm_dmc620_pmu_online);
>> +}
>> +
>> +module_init(arm_dmc620_pmu_init);
>> +module_exit(arm_dmc620_pmu_exit);
>> +
>> +MODULE_DESCRIPTION("Perf driver for the ARM DMC-620 memory controller")=
;
>> +MODULE_AUTHOR("Tuan Phan <tuanphan@os.amperecomputing.com");
>> +MODULE_LICENSE("GPL v2");
>>=20
>=20

