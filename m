Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D500C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDC92070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="g8g22Wp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgG1FJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 01:09:41 -0400
Received: from mail-co1nam11on2062.outbound.protection.outlook.com ([40.107.220.62]:50401
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbgG1FJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 01:09:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0M+QGBwvxGOQaDo3RpTGv+ZhsfCw8syYSPC5Je+tBpS+ROP7cUcHDLaLShYKz3SwDrBVgBVdjd2E76V7AfWRIkR2jddZW2EyinePZNzFSfjy8/8LMVnjlZH8G2q7mGBN8uf0gx8tfQ7Cd6CBXHKtanQ8hJqow2jkrw+wXFaEME1jPN5njXAffiBnma1/PaS3wvkEPU3rdY7o/5j2L5ti9fNCs0mhHB/FcGLOxG0Mcy1d3x6fME0w4v7IBGGUcky0lmVu6U+iDaalZfkPj/8BX+0XhbfCbrBSlP1c95lLCff/VKGh8NgQKPdUkA48ezQSEsFExtrx/+JSXkNrW59BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0XhzlnLvsGdJGzZNzVib3vC5C6e5zd7qsg82pM17GA=;
 b=UpqOhe3AviBav61pAyr9eK/CYKGJdN0oRXbC8UefsaGCa8axuEgRgcbH2B0ezes48r7mNYbK8wEq3iOvw1P3zs/gQ9S3TyDg9WNAO2FYrChd2Aq19mvWIlwJtx2s6lku02fueAE6+NMhrgqL4gJgEtKtriE2d1qYYcYTtwW3rz4z/Pmr2B33mO3wO1FvASROn6RkyMhMr64dfsGDi+th1W+/P1LWL24lbsXVWU/CIfvgmCQTBnlKyYkYxQj30VCzhxyrfmlboiqpGP0nwKQlu54ulUZEkWcoAbK8OLMf7CMqpNRllzjCl5t1ujDsbru8vf57vmMnVLY1asCUT8DN5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0XhzlnLvsGdJGzZNzVib3vC5C6e5zd7qsg82pM17GA=;
 b=g8g22Wp+wPY4MYLH53vW+oUOTgUJQCy2tUGnd5Afl5awOM9aietObCKuYBZJZyPPf4PslOf9XGE6vP0FMgaePU6SzH+hGJCx6/FjymyKG5HexJ5sFWVkgvL2+/bUnRy/nn0E/L6PzLpZEkCm9iJEf7L/pC5ykuGMzjW77x+LntM=
Received: from SN4PR0501CA0045.namprd05.prod.outlook.com
 (2603:10b6:803:41::22) by SN6PR02MB4208.namprd02.prod.outlook.com
 (2603:10b6:805:39::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 28 Jul
 2020 05:09:34 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:41:cafe::64) by SN4PR0501CA0045.outlook.office365.com
 (2603:10b6:803:41::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.10 via Frontend
 Transport; Tue, 28 Jul 2020 05:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server id 15.20.3216.10 via Frontend Transport; Tue, 28 Jul 2020 05:09:33
 +0000
Received: from [149.199.38.66] (port=41320 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1k0Hps-00029z-UN; Mon, 27 Jul 2020 22:07:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1k0Hrp-00045e-G8; Mon, 27 Jul 2020 22:09:33 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06S59Nb5008215;
        Mon, 27 Jul 2020 22:09:24 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1k0Hrf-00041r-2K; Mon, 27 Jul 2020 22:09:23 -0700
Subject: Re: [PATCH v6 5/5] remoteproc: Add initial zynqmp R5 remoteproc
 driver
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ben Levinsky <ben.levinsky@xilinx.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, JOLLYS@xilinx.com,
        RAJANV@xilinx.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernell@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        stefanos@xilinx.com, Wendy Liang <wendy.liang@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ed Mooring <ed.mooring@xilinx.com>, Jason Wu <j.wu@xilinx.com>
References: <20200715153317.25643-1-ben.levinsky@xilinx.com>
 <20200715153317.25643-6-ben.levinsky@xilinx.com>
 <20200727225952.GA2389399@xps15>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <1c317ed2-f7f7-d7ec-8053-2052a96a2f52@xilinx.com>
Date:   Tue, 28 Jul 2020 07:09:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727225952.GA2389399@xps15>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19f1d39d-268a-4cf8-d123-08d832b46aaa
X-MS-TrafficTypeDiagnostic: SN6PR02MB4208:
X-Microsoft-Antispam-PRVS: <SN6PR02MB42087EE425B8E30CAF551039C6730@SN6PR02MB4208.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LT2sloRcRcz2RAb5fn6JrRjX6CyRfyhm/44jDhsdgp5T3fupIdjSdom7r6XO0c6QggwZ7yNGPT+6hMUnpH1m6BVZrBKta5zKUqqiJ+D0kLwCWJrrd5KnSTb7VTd6DedXbzMRWl/GDSYnP6vYdfJ9X9NlkBnKYnbgo9X6SRf5pcIuruxUELyfXRtS1ir7KSyNaJ0Q5F1xlTewmLrK/QJzdSzAsTinf4OoCe0d7T+xZP0yY4Jpr5QjzEzPBgQvuwxkYujg2nRFAz8azwdrFJ5QeFjTJsQy2HbXmaKTCUdIIeVWanQD9wfhIz00N2HfDkcycRDR0bHlUhmMMr9ZAOmR4FaFV+Pfl1KsgjQ9rUtwJdjDFBdu/9UIafT9WH4Wg3xDi0EuYT0VGPoeHy432sOSZlgsA+gTJbRRULojpbKAgRRABIN0AKO+y8b40Gd1cNe
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(396003)(376002)(346002)(46966005)(478600001)(47076004)(70206006)(6636002)(9786002)(6666004)(36756003)(54906003)(8936002)(30864003)(70586007)(8676002)(83380400001)(5660300002)(82310400002)(426003)(2616005)(81166007)(31696002)(4326008)(110136005)(31686004)(356005)(26005)(2906002)(336012)(44832011)(82740400003)(107886003)(316002)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 05:09:33.7876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f1d39d-268a-4cf8-d123-08d832b46aaa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28. 07. 20 0:59, Mathieu Poirier wrote:
> On Wed, Jul 15, 2020 at 08:33:17AM -0700, Ben Levinsky wrote:
>> R5 is included in Xilinx Zynq UltraScale MPSoC so by adding this
>> remotproc driver, we can boot the R5 sub-system in different
>> configurations.
>>
>> Acked-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
>> Acked-by: Ben Levinsky <ben.levinsky@xilinx.com>
>> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
>> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
>> Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> Signed-off-by: Ed Mooring <ed.mooring@xilinx.com>
>> Signed-off-by: Jason Wu <j.wu@xilinx.com>
>> Tested-by: Ben Levinsky <ben.levinsky@xilinx.com>
>> ---
>> v2:
>> - remove domain struct as per review from Mathieu
>> v3:
>> - add xilinx-related platform mgmt fn's instead of wrapping around
>>   function pointer in xilinx eemi ops struct
>> v4:
>> - add default values for enums
>> - fix formatting as per checkpatch.pl --strict. Note that 1 warning and 1 check
>>   are still raised as each is due to fixing the warning results in that
>> particular line going over 80 characters.
>> v5:
>> - parse_fw change from use of rproc_of_resm_mem_entry_init to rproc_mem_entry_init and use of alloc/release
>> - var's of type zynqmp_r5_pdata all have same local variable name
>> - use dev_dbg instead of dev_info
>> v6:
>> - adding memory carveouts is handled much more similarly. All mem carveouts are
>>   now described in reserved memory as needed. That is, TCM nodes are not
>>   coupled to remoteproc anymore. This is reflected in the remoteproc R5 driver
>>   and the device tree binding.
>> - remove mailbox from device tree binding as it is not necessary for elf
>>   loading
>> - use lockstep-mode property for configuring RPU
>> ---
>>  drivers/remoteproc/Kconfig                |  10 +
>>  drivers/remoteproc/Makefile               |   1 +
>>  drivers/remoteproc/zynqmp_r5_remoteproc.c | 911 ++++++++++++++++++++++
>>  3 files changed, 922 insertions(+)
>>  create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c
>>
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index c4d1731295eb..342a7e668636 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -249,6 +249,16 @@ config STM32_RPROC
>>  
>>  	  This can be either built-in or a loadable module.
>>  
>> +config ZYNQMP_R5_REMOTEPROC
>> +	tristate "ZynqMP_R5 remoteproc support"
>> +	depends on ARM64 && PM && ARCH_ZYNQMP
>> +	select RPMSG_VIRTIO
>> +	select MAILBOX
>> +	select ZYNQMP_IPI_MBOX
>> +	help
>> +	  Say y here to support ZynqMP R5 remote processors via the remote
>> +	  processor framework.
>> +
>>  endif # REMOTEPROC
>>  
>>  endmenu
>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>> index e8b886e511f0..04d1c95d06d7 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -28,5 +28,6 @@ obj-$(CONFIG_QCOM_WCNSS_PIL)		+= qcom_wcnss_pil.o
>>  qcom_wcnss_pil-y			+= qcom_wcnss.o
>>  qcom_wcnss_pil-y			+= qcom_wcnss_iris.o
>>  obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
>> +obj-$(CONFIG_ZYNQMP_R5_REMOTEPROC)	+= zynqmp_r5_remoteproc.o
>>  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
>>  obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
>> diff --git a/drivers/remoteproc/zynqmp_r5_remoteproc.c b/drivers/remoteproc/zynqmp_r5_remoteproc.c
>> new file mode 100644
>> index 000000000000..b600759e257e
>> --- /dev/null
>> +++ b/drivers/remoteproc/zynqmp_r5_remoteproc.c
>> @@ -0,0 +1,911 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Zynq R5 Remote Processor driver
>> + *
>> + * Copyright (C) 2019, 2020 Xilinx Inc. Ben Levinsky <ben.levinsky@xilinx.com>
>> + * Copyright (C) 2015 - 2018 Xilinx Inc.
>> + * Copyright (C) 2015 Jason Wu <j.wu@xilinx.com>
>> + *
>> + * Based on origin OMAP and Zynq Remote Processor driver
>> + *
>> + * Copyright (C) 2012 Michal Simek <monstr@monstr.eu>
>> + * Copyright (C) 2012 PetaLogix
>> + * Copyright (C) 2011 Texas Instruments, Inc.
>> + * Copyright (C) 2011 Google, Inc.
>> + */
>> +
>> +#include <linux/atomic.h>
> 
> Unused
> 
>> +#include <linux/cpu.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/delay.h>
> 
> Unused
> 
>> +#include <linux/err.h>
>> +#include <linux/firmware/xlnx-zynqmp.h>
>> +#include <linux/genalloc.h>
> 
> Unused
> 
>> +#include <linux/idr.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/mailbox/zynqmp-ipi-message.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_reserved_mem.h>
>> +#include <linux/pfn.h>
> 
> Unused
> 
>> +#include <linux/platform_device.h>
>> +#include <linux/remoteproc.h>
>> +#include <linux/skbuff.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +
>> +#include "remoteproc_internal.h"
>> +
>> +#define MAX_RPROCS	2 /* Support up to 2 RPU */
>> +#define MAX_MEM_PNODES	4 /* Max power nodes for one RPU memory instance */
>> +
>> +#define DEFAULT_FIRMWARE_NAME	"rproc-rpu-fw"
>> +
>> +/* PM proc states */
>> +#define PM_PROC_STATE_ACTIVE 1U
> 
> Unused
> 
>> +
>> +/* IPI buffer MAX length */
>> +#define IPI_BUF_LEN_MAX	32U
>> +/* RX mailbox client buffer max length */
>> +#define RX_MBOX_CLIENT_BUF_MAX	(IPI_BUF_LEN_MAX + \
>> +				 sizeof(struct zynqmp_ipi_message))
>> +
>> +#define ZYNQMP_R5_NUM_TCM_BANKS 4
>> +
>> +/* lookup table mapping power-node-ID of TCM bank to absolute base address */
>> +static unsigned long tcm_addr_to_pnode[ZYNQMP_R5_NUM_TCM_BANKS][2] = {
>> +	{0xFFE00000,	0xF },
>> +	{0xFFE20000,	0x10},
>> +	{0xFFE90000,	0x10},
>> +	{0xFFEB0000,	0x11},
>> +};
>> +
>> +static bool autoboot __read_mostly;
>> +
>> +/**
>> + * struct zynqmp_r5_mem - zynqmp rpu memory data
>> + * @pnode_id: TCM power domain ids
>> + * @res: memory resource
>> + * @node: list node
>> + */
>> +struct zynqmp_r5_mem {
>> +	u32 pnode_id[MAX_MEM_PNODES];
>> +	struct resource res;
>> +	struct list_head node;
>> +};
>> +
>> +/**
>> + * struct zynqmp_r5_pdata - zynqmp rpu remote processor private data
>> + * @dev: device of RPU instance
>> + * @rproc: rproc handle
>> + * @pnode_id: RPU CPU power domain id
>> + * @mems: memory resources
>> + * @is_r5_mode_set: indicate if r5 operation mode is set
>> + * @tx_mc: tx mailbox client
>> + * @rx_mc: rx mailbox client
>> + * @tx_chan: tx mailbox channel
>> + * @rx_chan: rx mailbox channel
>> + * @mbox_work: mbox_work for the RPU remoteproc
>> + * @tx_mc_skbs: socket buffers for tx mailbox client
>> + * @rx_mc_buf: rx mailbox client buffer to save the rx message
>> + */
>> +struct zynqmp_r5_pdata {
>> +	struct device dev;
>> +	struct rproc *rproc;
>> +	u32 pnode_id;
>> +	struct list_head mems;
>> +	bool is_r5_mode_set;
>> +	struct mbox_client tx_mc;
>> +	struct mbox_client rx_mc;
>> +	struct mbox_chan *tx_chan;
>> +	struct mbox_chan *rx_chan;
>> +	struct work_struct mbox_work;
>> +	struct sk_buff_head tx_mc_skbs;
>> +	unsigned char rx_mc_buf[RX_MBOX_CLIENT_BUF_MAX];
>> +};
>> +
>> +/**
>> + * table of RPUs
>> + */
>> +struct zynqmp_r5_pdata rpus[MAX_RPROCS];
>> +/**
>> + *  RPU core configuration
>> + */
>> +enum rpu_oper_mode rpu_mode;
>> +
>> +/*
>> + * r5_set_mode - set RPU operation mode
>> + * @pdata: Remote processor private data
>> + *
>> + * set RPU oepration mode
>> + *
>> + * Return: 0 for success, negative value for failure
>> + */
>> +static int r5_set_mode(struct zynqmp_r5_pdata *pdata)
>> +{
>> +	u32 val[PAYLOAD_ARG_CNT] = {0}, expect, tcm_mode;
>> +	struct device *dev = &pdata->dev;
>> +	int ret;
>> +
>> +	expect = (u32)rpu_mode;
>> +	ret = zynqmp_pm_get_rpu_mode(pdata->pnode_id, 0, 0, val);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to get RPU oper mode.\n");
>> +		return ret;
>> +	}
>> +	if (val[0] == expect) {
>> +		dev_dbg(dev, "RPU mode matches: %x\n", val[0]);
>> +	} else {
>> +		ret = zynqmp_pm_set_rpu_mode(pdata->pnode_id,
>> +					     expect, 0, val);
>> +		if (ret < 0) {
>> +			dev_err(dev,
>> +				"failed to set RPU oper mode.\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	tcm_mode = (expect == (u32)PM_RPU_MODE_LOCKSTEP) ?
>> +		    PM_RPU_TCM_COMB : PM_RPU_TCM_SPLIT;
>> +	ret = zynqmp_pm_set_tcm_config(pdata->pnode_id, tcm_mode, 0, val);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to config TCM to %x.\n",
>> +			expect);
>> +		return ret;
>> +	}
>> +	pdata->is_r5_mode_set = true;
>> +	return 0;
>> +}
>> +
>> +/*
>> + * ZynqMP R5 remoteproc memory release function
>> + */
>> +static int zynqmp_r5_mem_release(struct rproc *rproc,
>> +				 struct rproc_mem_entry *mem)
>> +{
>> +	struct zynqmp_r5_mem *priv;
>> +	int i, ret;
>> +	struct device *dev = &rproc->dev;
>> +
>> +	priv = mem->priv;
>> +	if (!priv)
>> +		return 0;
>> +	for (i = 0; i < MAX_MEM_PNODES; i++) {
>> +		if (priv->pnode_id[i]) {
>> +			dev_dbg(dev, "%s, pnode %d\n",
>> +				__func__, priv->pnode_id[i]);
>> +			ret = zynqmp_pm_release_node(priv->pnode_id[i]);
>> +			if (ret < 0) {
>> +				dev_err(dev,
>> +					"failed to release power node: %u\n",
>> +					priv->pnode_id[i]);
>> +				return ret;
>> +			}
>> +		} else {
>> +			break;
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +
>> +/*
>> + * ZynqMP R5 remoteproc operations
>> + */
>> +static int zynqmp_r5_rproc_start(struct rproc *rproc)
>> +{
>> +	struct device *dev = rproc->dev.parent;
>> +	struct zynqmp_r5_pdata *pdata = rproc->priv;
>> +	enum rpu_boot_mem bootmem;
>> +	int ret;
>> +
>> +	if ((rproc->bootaddr & 0xF0000000) == 0xF0000000)
>> +		bootmem = PM_RPU_BOOTMEM_HIVEC;
>> +	else
>> +		bootmem = PM_RPU_BOOTMEM_LOVEC;
>> +	dev_dbg(dev, "RPU boot from %s.",
>> +		bootmem == PM_RPU_BOOTMEM_HIVEC ? "OCM" : "TCM");
>> +	ret = zynqmp_pm_request_wakeup(pdata->pnode_id, 1,
>> +				       bootmem, ZYNQMP_PM_REQUEST_ACK_NO);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to boot R5.\n");
>> +		return ret;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int zynqmp_r5_rproc_stop(struct rproc *rproc)
>> +{
>> +	struct zynqmp_r5_pdata *pdata = rproc->priv;
>> +	int ret;
>> +
>> +	ret = zynqmp_pm_force_powerdown(pdata->pnode_id,
>> +					ZYNQMP_PM_REQUEST_ACK_BLOCKING);
>> +	if (ret < 0) {
>> +		dev_err(&pdata->dev, "failed to shutdown R5.\n");
>> +		return ret;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int zynqmp_r5_rproc_mem_alloc(struct rproc *rproc,
>> +				      struct rproc_mem_entry *mem)
>> +{
>> +	struct device *dev = rproc->dev.parent;
>> +	void *va;
>> +
>> +	dev_dbg(rproc->dev.parent, "map memory: %pa\n", &mem->dma);
>> +	va = ioremap_wc(mem->dma, mem->len);
>> +	if (IS_ERR_OR_NULL(va)) {
>> +		dev_err(dev, "Unable to map memory region: %pa+%lx\n",
>> +			&mem->dma, mem->len);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/* Update memory entry va */
>> +	mem->va = va;
>> +
>> +	return 0;
>> +}
>> +
>> +static int zynqmp_r5_rproc_mem_release(struct rproc *rproc,
>> +				       struct rproc_mem_entry *mem)
>> +{
>> +	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
>> +	iounmap(mem->va);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * TCM needs mapping to R5 relative address and xilinx platform mgmt call
>> + */
>> +struct rproc_mem_entry *handle_tcm_parsing(struct device *dev,
>> +					    struct reserved_mem *rmem,
>> +					    struct device_node *node,
>> +					    int lookup_idx)
>> +{
>> +	void *va;
>> +	dma_addr_t dma;
>> +	resource_size_t size;
>> +	int ret;
>> +	u32 pnode_id;
>> +	struct resource rsc;
>> +	struct rproc_mem_entry *mem;
>> +
>> +	pnode_id =  tcm_addr_to_pnode[lookup_idx][1];
>> +	ret = zynqmp_pm_request_node(pnode_id,
>> +				     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
>> +				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to request power node: %u\n", pnode_id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = of_address_to_resource(node, 0, &rsc);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to get resource of memory %s",
>> +			of_node_full_name(node));
>> +		return -EINVAL;
>> +	}
>> +	size = resource_size(&rsc);
>> +	va = devm_ioremap_wc(dev, rsc.start, size);
>> +	if (!va)
>> +		return -ENOMEM;
>> +
>> +	/* zero out tcm base address */
>> +	if (rsc.start & 0xffe00000) {
>> +		/* R5 can't see anything past 0xfffff so wipe it */
>> +		rsc.start &= 0x000fffff;
>> +		/*
>> +		 * handle tcm banks 1 a and b (0xffe9000 and
>> +		 * 0xffeb0000)
>> +		 */
>> +		if (rsc.start & 0x80000)
>> +			rsc.start -= 0x90000;
>> +	}
>> +
>> +	dma = (dma_addr_t)rsc.start;
>> +	mem = rproc_mem_entry_init(dev, va, dma, (int)size, rsc.start,
>> +				   NULL, zynqmp_r5_mem_release,
>> +				   rsc.name);
>> +	if (!mem)
>> +		return -ENOMEM;
>> +
>> +	return mem;
>> +}
>> +
>> +static int parse_mem_regions(struct rproc *rproc)
>> +{
>> +	int num_mems, i;
>> +	struct zynqmp_r5_pdata *pdata = rproc->priv;
>> +	struct device *dev =  &pdata->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct rproc_mem_entry *mem;
>> +
>> +	num_mems = of_count_phandle_with_args(np, "memory-region", NULL);
>> +	if (num_mems <= 0)
>> +		return 0;
>> +	for (i = 0; i < num_mems; i++) {
>> +		struct device_node *node;
>> +		struct reserved_mem *rmem;
>> +
>> +		node = of_parse_phandle(np, "memory-region", i);
>> +		rmem = of_reserved_mem_lookup(node);
>> +		if (!rmem) {
>> +			dev_err(dev, "unable to acquire memory-region\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (strstr(node->name, "vdev0buffer")) {
>> +			/* Register DMA region */
>> +			mem = rproc_mem_entry_init(dev, NULL,
>> +						   (dma_addr_t)rmem->base,
>> +						   rmem->size, rmem->base,
>> +						   NULL, NULL,
>> +						   "vdev0buffer");
>> +			if (!mem) {
>> +				dev_err(dev, "unable to initialize memory-region %s\n",
>> +					node->name);
>> +				return -ENOMEM;
>> +			}
>> +			dev_dbg(dev, "parsed %s at  %llx\r\n", mem->name,
>> +				mem->dma);
>> +		} else if (strstr(node->name, "vdev0vring")) {
>> +			int vring_id;
>> +			char name[16];
>> +
>> +			/*
>> +			 * can be 1 of multiple vring IDs per IPC channel
>> +			 * e.g. 'vdev0vring0' and 'vdev0vring1'
>> +			 */
>> +			vring_id = node->name[14] - '0';
>> +			snprintf(name, sizeof(name), "vdev0vring%d", vring_id);
>> +			/* Register vring */
>> +			mem = rproc_mem_entry_init(dev, NULL,
>> +						   (dma_addr_t)rmem->base,
>> +						   rmem->size, rmem->base,
>> +						   zynqmp_r5_rproc_mem_alloc,
>> +						   zynqmp_r5_rproc_mem_release,
>> +						   name);
>> +			dev_dbg(dev, "parsed %s at %llx\r\n", mem->name,
>> +				mem->dma);
>> +		} else {
>> +			int idx;
>> +
>> +			/*
>> +			 * if TCM update address space for R5 and
>> +			 * make xilinx platform mgmt call
>> +			 */
>> +			for (idx = 0; idx < ZYNQMP_R5_NUM_TCM_BANKS; idx++) {
>> +				if (tcm_addr_to_pnode[idx][0] == rmem->base)
>> +					break;
>> +			}
>> +
>> +			if (idx != ZYNQMP_R5_NUM_TCM_BANKS) {
>> +				mem = handle_tcm_parsing(dev, rmem, node, idx);
>> +			} else {
>> +				mem = rproc_mem_entry_init(dev, NULL,
>> +						   (dma_addr_t)rmem->base,
>> +						   rmem->size, rmem->base,
>> +						   zynqmp_r5_rproc_mem_alloc,
>> +						   zynqmp_r5_rproc_mem_release,
>> +						   node->name);
>> +			}
>> +
>> +			if (!mem) {
>> +				dev_err(dev,
>> +					"unable to init memory-region %s\n",
>> +					node->name);
>> +				return -ENOMEM;
>> +			}
>> +		}
>> +		rproc_add_carveout(rproc, mem);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
>> +{
>> +	int ret;
>> +	struct zynqmp_r5_pdata *pdata = rproc->priv;
>> +	struct device *dev = &pdata->dev;
>> +
>> +	ret = parse_mem_regions(rproc);
>> +	if (ret) {
>> +		dev_err(dev, "parse_mem_regions failed %x\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = rproc_elf_load_rsc_table(rproc, fw);
>> +	if (ret == -EINVAL) {
>> +		dev_dbg(dev, "no resource table found.\n");
>> +		ret = 0;
>> +	}
>> +	return ret;
>> +}
>> +
>> +/* kick a firmware */
>> +static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
>> +{
>> +	struct device *dev = rproc->dev.parent;
>> +	struct zynqmp_r5_pdata *pdata = rproc->priv;
>> +
>> +	dev_dbg(dev, "KICK Firmware to start send messages vqid %d\n", vqid);
>> +
>> +	if (vqid < 0) {
>> +		/* If vqid is negative, does not pass the vqid to
>> +		 * mailbox. As vqid is supposed to be 0 or possive.
>> +		 * It also gives a way to just kick instead but
>> +		 * not use the IPI buffer. It is better to provide
>> +		 * a proper way to pass the short message, which will
>> +		 * need to sync to upstream first, for now,
>> +		 * use negative vqid to assume no message will be
>> +		 * passed with IPI buffer, but just raise interrupt.
>> +		 * This will be faster as it doesn't need to copy the
>> +		 * message to the IPI buffer.
>> +		 *
>> +		 * It will ignore the return, as failure is due to
>> +		 * there already kicks in the mailbox queue.
>> +		 */
>> +		(void)mbox_send_message(pdata->tx_chan, NULL);
>> +	} else {
>> +		struct sk_buff *skb;
>> +		unsigned int skb_len;
>> +		struct zynqmp_ipi_message *mb_msg;
>> +		int ret;
>> +
>> +		skb_len = (unsigned int)(sizeof(vqid) + sizeof(mb_msg));
>> +		skb = alloc_skb(skb_len, GFP_ATOMIC);
>> +		if (!skb) {
>> +			dev_err(dev,
>> +				"Failed to allocate skb to kick remote.\n");
>> +			return;
>> +		}
>> +		mb_msg = (struct zynqmp_ipi_message *)skb_put(skb, skb_len);
>> +		mb_msg->len = sizeof(vqid);
>> +		memcpy(mb_msg->data, &vqid, sizeof(vqid));
>> +		skb_queue_tail(&pdata->tx_mc_skbs, skb);
>> +		ret = mbox_send_message(pdata->tx_chan, mb_msg);
>> +		if (ret < 0) {
>> +			dev_warn(dev, "Failed to kick remote.\n");
>> +			skb_dequeue_tail(&pdata->tx_mc_skbs);
>> +			kfree_skb(skb);
>> +		}
>> +	}
>> +}
>> +
>> +static struct rproc_ops zynqmp_r5_rproc_ops = {
>> +	.start		= zynqmp_r5_rproc_start,
>> +	.stop		= zynqmp_r5_rproc_stop,
>> +	.load		= rproc_elf_load_segments,
>> +	.parse_fw	= zynqmp_r5_parse_fw,
>> +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
>> +	.sanity_check	= rproc_elf_sanity_check,
>> +	.get_boot_addr	= rproc_elf_get_boot_addr,
>> +	.kick		= zynqmp_r5_rproc_kick,
>> +};
>> +
>> +/* zynqmp_r5_mem_probe() - probes RPU TCM memory device
>> + * @pdata: pointer to the RPU remoteproc private data
>> + * @node: pointer to the memory node
>> + *
>> + * Function to retrieve resources for RPU TCM memory device.
>> + */
>> +static int zynqmp_r5_mem_probe(struct zynqmp_r5_pdata *pdata,
>> +			       struct device_node *node)
>> +{
>> +	struct device *dev;
>> +	struct zynqmp_r5_mem *mem;
>> +	int ret;
>> +	struct property *prop;
>> +	const __be32 *cur;
>> +	u32 val;
>> +	int i;
>> +
>> +	dev = &pdata->dev;
>> +	mem = devm_kzalloc(dev, sizeof(*mem), GFP_KERNEL);
>> +	if (!mem)
>> +		return -ENOMEM;
>> +	ret = of_address_to_resource(node, 0, &mem->res);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to get resource of memory %s",
>> +			of_node_full_name(node));
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Get the power domain id */
>> +	i = 0;
>> +	if (of_find_property(node, "pnode-id", NULL)) {
>> +		of_property_for_each_u32(node, "pnode-id", prop, cur, val)
>> +			mem->pnode_id[i++] = val;
>> +	}
>> +	list_add_tail(&mem->node, &pdata->mems);
>> +	return 0;
>> +}
>> +
>> +/**
>> + * zynqmp_r5_release() - ZynqMP R5 device release function
>> + * @dev: pointer to the device struct of ZynqMP R5
>> + *
>> + * Function to release ZynqMP R5 device.
>> + */
>> +static void zynqmp_r5_release(struct device *dev)
>> +{
>> +	struct zynqmp_r5_pdata *pdata;
>> +	struct rproc *rproc;
>> +	struct sk_buff *skb;
>> +
>> +	pdata = dev_get_drvdata(dev);
>> +	rproc = pdata->rproc;
>> +	if (rproc) {
>> +		rproc_del(rproc);
>> +		rproc_free(rproc);
>> +	}
>> +	if (pdata->tx_chan)
>> +		mbox_free_channel(pdata->tx_chan);
>> +	if (pdata->rx_chan)
>> +		mbox_free_channel(pdata->rx_chan);
>> +	/* Discard all SKBs */
>> +	while (!skb_queue_empty(&pdata->tx_mc_skbs)) {
>> +		skb = skb_dequeue(&pdata->tx_mc_skbs);
>> +		kfree_skb(skb);
>> +	}
>> +
>> +	put_device(dev->parent);
>> +}
>> +
>> +/**
>> + * event_notified_idr_cb() - event notified idr callback
>> + * @id: idr id
>> + * @ptr: pointer to idr private data
>> + * @data: data passed to idr_for_each callback
>> + *
>> + * Pass notification to remoteproc virtio
>> + *
>> + * Return: 0. having return is to satisfy the idr_for_each() function
>> + *          pointer input argument requirement.
>> + **/
>> +static int event_notified_idr_cb(int id, void *ptr, void *data)
>> +{
>> +	struct rproc *rproc = data;
>> +
>> +	(void)rproc_vq_interrupt(rproc, id);
>> +	return 0;
>> +}
>> +
>> +/**
>> + * handle_event_notified() - remoteproc notification work funciton
>> + * @work: pointer to the work structure
>> + *
>> + * It checks each registered remoteproc notify IDs.
>> + */
>> +static void handle_event_notified(struct work_struct *work)
>> +{
>> +	struct rproc *rproc;
>> +	struct zynqmp_r5_pdata *pdata;
>> +
>> +	pdata = container_of(work, struct zynqmp_r5_pdata, mbox_work);
>> +
>> +	(void)mbox_send_message(pdata->rx_chan, NULL);
>> +	rproc = pdata->rproc;
>> +	/*
>> +	 * We only use IPI for interrupt. The firmware side may or may
>> +	 * not write the notifyid when it trigger IPI.
>> +	 * And thus, we scan through all the registered notifyids.
>> +	 */
>> +	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc);
>> +}
>> +
>> +/**
>> + * zynqmp_r5_mb_rx_cb() - Receive channel mailbox callback
>> + * @cl: mailbox client
>> + * @mssg: message pointer
>> + *
>> + * It will schedule the R5 notification work.
>> + */
>> +static void zynqmp_r5_mb_rx_cb(struct mbox_client *cl, void *mssg)
>> +{
>> +	struct zynqmp_r5_pdata *pdata;
>> +
>> +	pdata = container_of(cl, struct zynqmp_r5_pdata, rx_mc);
>> +	if (mssg) {
>> +		struct zynqmp_ipi_message *ipi_msg, *buf_msg;
>> +		size_t len;
>> +
>> +		ipi_msg = (struct zynqmp_ipi_message *)mssg;
>> +		buf_msg = (struct zynqmp_ipi_message *)pdata->rx_mc_buf;
>> +		len = (ipi_msg->len >= IPI_BUF_LEN_MAX) ?
>> +		      IPI_BUF_LEN_MAX : ipi_msg->len;
>> +		buf_msg->len = len;
>> +		memcpy(buf_msg->data, ipi_msg->data, len);
>> +	}
>> +	schedule_work(&pdata->mbox_work);
>> +}
>> +
>> +/**
>> + * zynqmp_r5_mb_tx_done() - Request has been sent to the remote
>> + * @cl: mailbox client
>> + * @mssg: pointer to the message which has been sent
>> + * @r: status of last TX - OK or error
>> + *
>> + * It will be called by the mailbox framework when the last TX has done.
>> + */
>> +static void zynqmp_r5_mb_tx_done(struct mbox_client *cl, void *mssg, int r)
>> +{
>> +	struct zynqmp_r5_pdata *pdata;
>> +	struct sk_buff *skb;
>> +
>> +	if (!mssg)
>> +		return;
>> +	pdata = container_of(cl, struct zynqmp_r5_pdata, tx_mc);
>> +	skb = skb_dequeue(&pdata->tx_mc_skbs);
>> +	kfree_skb(skb);
>> +}
>> +
>> +/**
>> + * zynqmp_r5_setup_mbox() - Setup mailboxes
>> + *
>> + * @pdata: pointer to the ZynqMP R5 processor platform data
>> + * @node: pointer of the device node
>> + *
>> + * Function to setup mailboxes to talk to RPU.
>> + *
>> + * Return: 0 for success, negative value for failure.
>> + */
>> +static int zynqmp_r5_setup_mbox(struct zynqmp_r5_pdata *pdata,
>> +				struct device_node *node)
>> +{
>> +	struct device *dev = &pdata->dev;
>> +	struct mbox_client *mclient;
>> +
>> +	/* Setup TX mailbox channel client */
>> +	mclient = &pdata->tx_mc;
>> +	mclient->dev = dev;
>> +	mclient->rx_callback = NULL;
>> +	mclient->tx_block = false;
>> +	mclient->knows_txdone = false;
>> +	mclient->tx_done = zynqmp_r5_mb_tx_done;
>> +
>> +	/* Setup TX mailbox channel client */
>> +	mclient = &pdata->rx_mc;
>> +	mclient->dev = dev;
>> +	mclient->rx_callback = zynqmp_r5_mb_rx_cb;
>> +	mclient->tx_block = false;
>> +	mclient->knows_txdone = false;
>> +
>> +	INIT_WORK(&pdata->mbox_work, handle_event_notified);
>> +
>> +	/* Request TX and RX channels */
>> +	pdata->tx_chan = mbox_request_channel_byname(&pdata->tx_mc, "tx");
>> +	if (IS_ERR(pdata->tx_chan)) {
>> +		dev_err(dev, "failed to request mbox tx channel.\n");
>> +		pdata->tx_chan = NULL;
>> +		return -EINVAL;
>> +	}
>> +	pdata->rx_chan = mbox_request_channel_byname(&pdata->rx_mc, "rx");
>> +	if (IS_ERR(pdata->rx_chan)) {
>> +		dev_err(dev, "failed to request mbox rx channel.\n");
>> +		pdata->rx_chan = NULL;
>> +		return -EINVAL;
>> +	}
>> +	skb_queue_head_init(&pdata->tx_mc_skbs);
>> +	return 0;
>> +}
>> +
>> +/**
>> + * zynqmp_r5_probe() - Probes ZynqMP R5 processor device node
>> + * @pdata: pointer to the ZynqMP R5 processor platform data
>> + * @pdev: parent RPU domain platform device
>> + * @node: pointer of the device node
>> + *
>> + * Function to retrieve the information of the ZynqMP R5 device node.
>> + *
>> + * Return: 0 for success, negative value for failure.
>> + */
>> +static int zynqmp_r5_probe(struct zynqmp_r5_pdata *pdata,
>> +			   struct platform_device *pdev,
>> +			   struct device_node *node)
>> +{
>> +	struct device *dev = &pdata->dev;
>> +	struct rproc *rproc;
>> +	struct device_node *nc;
>> +	int ret;
>> +
>> +	/* Create device for ZynqMP R5 device */
>> +	dev->parent = &pdev->dev;
>> +	dev->release = zynqmp_r5_release;
>> +	dev->of_node = node;
>> +	dev_set_name(dev, "%s", of_node_full_name(node));
>> +	dev_set_drvdata(dev, pdata);
>> +	ret = device_register(dev);
>> +	if (ret) {
>> +		dev_err(dev, "failed to register device.\n");
>> +		return ret;
>> +	}
>> +	get_device(&pdev->dev);
>> +
>> +	/* Allocate remoteproc instance */
>> +	rproc = rproc_alloc(dev, dev_name(dev), &zynqmp_r5_rproc_ops, NULL, 0);
>> +	if (!rproc) {
>> +		dev_err(dev, "rproc allocation failed.\n");
>> +		ret = -ENOMEM;
>> +		goto error;
>> +	}
>> +	rproc->auto_boot = autoboot;
>> +	pdata->rproc = rproc;
>> +	rproc->priv = pdata;
>> +
>> +	/*
>> +	 * The device has not been spawned from a device tree, so
>> +	 * arch_setup_dma_ops has not been called, thus leaving
>> +	 * the device with dummy DMA ops.
>> +	 * Fix this by inheriting the parent's DMA ops and mask.
>> +	 */
>> +	rproc->dev.dma_mask = pdev->dev.dma_mask;
>> +	set_dma_ops(&rproc->dev, get_dma_ops(&pdev->dev));
>> +
>> +	/* Probe R5 memory devices */
>> +	INIT_LIST_HEAD(&pdata->mems);
>> +	for_each_available_child_of_node(node, nc) {
>> +		ret = zynqmp_r5_mem_probe(pdata, nc);
>> +		if (ret) {
>> +			dev_err(dev, "failed to probe memory %s.\n",
>> +				of_node_full_name(nc));
>> +			goto error;
>> +		}
>> +	}
>> +
>> +	/* Set up DMA mask */
>> +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>> +	if (ret) {
>> +		dev_warn(dev, "dma_set_coherent_mask failed: %d\n", ret);
>> +		/* If DMA is not configured yet, try to configure it. */
>> +		ret = of_dma_configure(dev, node, true);
>> +		if (ret) {
>> +			dev_err(dev, "failed to configure DMA.\n");
>> +			goto error;
>> +		}
>> +	}
>> +
>> +	/* Get R5 power domain node */
>> +	ret = of_property_read_u32(node, "pnode-id", &pdata->pnode_id);
>> +	if (ret) {
>> +		dev_err(dev, "failed to get power node id.\n");
>> +		goto error;
>> +	}
>> +
>> +	/* TODO Check if R5 is running */
>> +
>> +	/* Set up R5 if not already setup */
>> +	ret = pdata->is_r5_mode_set ? 0 : r5_set_mode(pdata);
>> +	if (ret) {
>> +		dev_err(dev, "failed to set R5 operation mode.\n");
>> +		return ret;
>> +	}
>> +
>> +	if (!of_get_property(dev->of_node, "mboxes", NULL)) {
>> +		dev_dbg(dev, "no mailboxes.\n");
>> +		goto error;
>> +	} else {
>> +		ret = zynqmp_r5_setup_mbox(pdata, node);
>> +		if (ret < 0)
>> +			goto error;
>> +	}
>> +
>> +	/* Add R5 remoteproc */
>> +	ret = rproc_add(rproc);
>> +	if (ret) {
>> +		dev_err(dev, "rproc registration failed\n");
>> +		goto error;
>> +	}
>> +	return 0;
>> +error:
>> +	if (pdata->rproc)
>> +		rproc_free(pdata->rproc);
>> +	pdata->rproc = NULL;
>> +	device_unregister(dev);
>> +	put_device(&pdev->dev);
>> +	return ret;
>> +}
>> +
>> +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
>> +{
>> +	int ret, i = 0;
>> +	u32 *lockstep_mode;
> 
> Can this just be a regular variable?
> 
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *nc;
>> +	struct zynqmp_r5_pdata *pdata;
>> +
>> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +	lockstep_mode = devm_kzalloc(dev, sizeof(u32 *), GFP_KERNEL);
>> +	if (!pdata || !lockstep_mode)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, pdata);
>> +
>> +	of_property_read_u32(dev->of_node, "lockstep-mode", lockstep_mode);
> 
> To make Rob's life a little easier this should probably be "xilinx,cluster-mode"
> so that it follows what TI has done.
> 

Note: If this is required change then you need to use xlnx,cluster-mode.

Thanks,
Michal
