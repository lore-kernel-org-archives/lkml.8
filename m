Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D01C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 06:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935242137B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 06:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ky57WAfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgDQGcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 02:32:55 -0400
Received: from mail-eopbgr690043.outbound.protection.outlook.com ([40.107.69.43]:53061
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbgDQGcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 02:32:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxUI5yzvDGjyrDuafKz4OALdot32PD2dV8saqfq1W7D1VvCyTC11YyESu31d4Eak6ZHbyCGhunQkzmIeCCFTozhJ9zpNXKpXv1QaxBd3+yPvZv320Dmx0ZOjsls4LuwHUtrI0nXM4bxMU+7qNkRtih6drZJfQuXrVbJFlDAHwMel1k7PctCOewodnEOxXogk0xZ3vGcZDEEF22TmWQPrvCKBgka5pAW8xdZcdtO1ltleSO+fqhSVu0VQnubkZs7aTSl3JWtP9DGkDkhPiyV2N7OSDn08Ob7C1SD18hVKddOVGiT6o/Rm0LfgJ/umFvXg0eBcwvzGZRjFk5ZkkE0WWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFcQjqvfssTMOVlxDWpiyK5CEhnTPeMxMDOSANQOMzo=;
 b=T6XzyJDxQKShZWA59mhq+HocbwmxR81+CzcNPp2tSKw+zDWb7AREQR88yeyA+C1hcy2IjxBFjIPtXW7u5D6iAtyrX9jp+Gri6VaVIeNCrunhxMZ5R/0MIyFh/ll1cEWWHBHaZmB1fy38Gh/Zns9OM69EDvlyCuYe5kgWUCURTD5ZhxMoFSLkfLSOtnmEAA4kKxPPo2Sqw682sLbTaaFbEtjizQpapzG6L8Lrx8deVtSE2uWes462qkhc6vwsb15A4IWHMR8MwLaHFf9e/rj5mFcHuLq+69xrAoMVig64hRGeuJ9FozKquzwehOll55jhRPu6mtI/psYcWLTak82qmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFcQjqvfssTMOVlxDWpiyK5CEhnTPeMxMDOSANQOMzo=;
 b=Ky57WAfSJwHvdeNrjDdU7kVUyqH0j/WTMC2aSGGlV+hfnyKqYf2uHuVYKKBmnj5HMx3npse9rEkOOFAQcERRoLo6wUOgyuud3jb/M7DNeMvoYnNCToehaDQV2jqG4mA5F6sMNcA9Ji310bEAUlWkNDqlgvLNnMYsmaY2bZiKvFw=
Received: from MN2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:208:fc::31)
 by DM6PR02MB4905.namprd02.prod.outlook.com (2603:10b6:5:17::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Fri, 17 Apr
 2020 06:32:51 +0000
Received: from BL2NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:fc:cafe::e) by MN2PR02CA0018.outlook.office365.com
 (2603:10b6:208:fc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Fri, 17 Apr 2020 06:32:50 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT037.mail.protection.outlook.com (10.152.77.11) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 06:32:50
 +0000
Received: from [149.199.38.66] (port=55572 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jPKXh-0002Co-Gt; Thu, 16 Apr 2020 23:32:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jPKYT-0002aw-QK; Thu, 16 Apr 2020 23:32:49 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jPKYQ-0002aS-0G; Thu, 16 Apr 2020 23:32:46 -0700
Subject: Re: [PATCH v2 5/5] remoteproc: Add initial zynqmp R5 remoteproc
 driver
To:     Ben Levinsky <ben.levinsky@xilinx.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org, michal.simek@xilinx.com,
        jollys@xilinx.com, rajan.vaja@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wendy Liang <wendy.liang@xilinx.com>,
        Ed Mooring <ed.mooring@xilinx.com>, Jason Wu <j.wu@xilinx.com>
References: <1587074082-14836-1-git-send-email-ben.levinsky@xilinx.com>
 <1587074082-14836-6-git-send-email-ben.levinsky@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <baaa1b13-6ea2-8ca5-6883-46fb9da4f7e8@xilinx.com>
Date:   Fri, 17 Apr 2020 08:32:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587074082-14836-6-git-send-email-ben.levinsky@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966005)(54906003)(5660300002)(2906002)(81166007)(356005)(478600001)(81156014)(8676002)(186003)(36756003)(6666004)(44832011)(426003)(336012)(9786002)(2616005)(31686004)(31696002)(26005)(70206006)(107886003)(8936002)(70586007)(4326008)(82740400003)(316002)(47076004);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a931262f-04d4-490c-cd7c-08d7e299269f
X-MS-TrafficTypeDiagnostic: DM6PR02MB4905:
X-Microsoft-Antispam-PRVS: <DM6PR02MB490545614BC8CFC75E9C3A73C6D90@DM6PR02MB4905.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OhGnSocBWXgKf6li1If0l/qnt577LOLxN3y/DiRzf9+fdiwTJOg+PtD6AXT/hN9TcZRc4he8sUiQAtjEHB6SfoMJCQ/s1QRaLTw2NrpdC3IRQN01TDMuJakXQAVlqmBR2W/eU3GpqVzCIapu2MSJxj5g/QFrkp1ZsaymsCkAzL/071xJ1A9VkhMGflLepowOS1IP7H50WFf3IMZ9QcQgCUAP8158PmIdtd7Sfz6oTlZkXk0MJWiMtGqbJtaRv8IoMwWz27burmtvfIehMoiM6hOfdOZy9xg6xvxapTeZaOmHlFIOCXV2HmS0SP3YqhEXrVrY8hYilhfk5rYNSsw/cET6fAYxka8071ePbIJ0gseFWoIK9SktdDMOyTy8IrAJfxtV/9wPnSuZXwwDG6e04Pp8QWmxEnYBe81KLzYCagT0o6blyDr3Nys46pQQLKsM9JD5NF1iRKKC7KdCsMut0Hk7oTJHpfT8/I0x8Ta9rRRqGqRfZkM73HnA56szIKoZVTxJmTDbpmyTuqAc1V5b8Q==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 06:32:50.1975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a931262f-04d4-490c-cd7c-08d7e299269f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4905
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 04. 20 23:54, Ben Levinsky wrote:
> R5 is included in Xilinx Zynq UltraScale MPSoC so by adding this
> remotproc driver, we can boot the R5 sub-system in different
> configurations.
> 
> Acked-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> Acked-by: Ben Levinsky <ben.levinsky@xilinx.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Ed Mooring <ed.mooring@xilinx.com>
> Signed-off-by: Jason Wu <j.wu@xilinx.com>
> Tested-by: Ben Levinsky <ben.levinsky@xilinx.com>
> ---
> Changes since v1:
> - remove domain struct as per review from Mathieu
> ---
>  drivers/remoteproc/Kconfig                |  10 +
>  drivers/remoteproc/Makefile               |   1 +
>  drivers/remoteproc/zynqmp_r5_remoteproc.c | 911 ++++++++++++++++++++++++++++++
>  3 files changed, 922 insertions(+)
>  create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index fbaed07..f094c84 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -222,6 +222,16 @@ config ST_REMOTEPROC
>  	  processor framework.
>  	  This can be either built-in or a loadable module.
>  
> +config ZYNQMP_R5_REMOTEPROC
> +	tristate "ZynqMP_r5 remoteproc support"
> +	depends on ARM64 && PM && ARCH_ZYNQMP
> +	select RPMSG_VIRTIO
> +	select MAILBOX
> +	select ZYNQMP_IPI_MBOX
> +	help
> +	  Say y here to support ZynqMP R5 remote processors via the remote
> +	  processor framework.
> +
>  config ST_SLIM_REMOTEPROC
>  	tristate
>  
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 0effd38..806ac3f 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -27,5 +27,6 @@ obj-$(CONFIG_QCOM_WCNSS_PIL)		+= qcom_wcnss_pil.o
>  qcom_wcnss_pil-y			+= qcom_wcnss.o
>  qcom_wcnss_pil-y			+= qcom_wcnss_iris.o
>  obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
> +obj-$(CONFIG_ZYNQMP_R5_REMOTEPROC)	+= zynqmp_r5_remoteproc.o
>  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
>  obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
> diff --git a/drivers/remoteproc/zynqmp_r5_remoteproc.c b/drivers/remoteproc/zynqmp_r5_remoteproc.c
> new file mode 100644
> index 0000000..2cfc6b6
> --- /dev/null
> +++ b/drivers/remoteproc/zynqmp_r5_remoteproc.c
> @@ -0,0 +1,911 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Zynq R5 Remote Processor driver
> + *
> + * Copyright (C) 2015 - 2018 Xilinx Inc.
> + * Copyright (C) 2015 Jason Wu <j.wu@xilinx.com>
> + *
> + * Based on origin OMAP and Zynq Remote Processor driver
> + *
> + * Copyright (C) 2012 Michal Simek <monstr@monstr.eu>
> + * Copyright (C) 2012 PetaLogix
> + * Copyright (C) 2011 Texas Instruments, Inc.
> + * Copyright (C) 2011 Google, Inc.
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/cpu.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/genalloc.h>
> +#include <linux/idr.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mailbox/zynqmp-ipi-message.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/pfn.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +#include <linux/skbuff.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +
> +#include "remoteproc_internal.h"
> +
> +#define MAX_RPROCS	2 /* Support up to 2 RPU */
> +#define MAX_MEM_PNODES	4 /* Max power nodes for one RPU memory instance */
> +
> +#define DEFAULT_FIRMWARE_NAME	"rproc-rpu-fw"
> +
> +/* PM proc states */
> +#define PM_PROC_STATE_ACTIVE 1U
> +
> +/* IPI buffer MAX length */
> +#define IPI_BUF_LEN_MAX	32U
> +/* RX mailbox client buffer max length */
> +#define RX_MBOX_CLIENT_BUF_MAX	(IPI_BUF_LEN_MAX + \
> +				 sizeof(struct zynqmp_ipi_message))
> +
> +static bool autoboot __read_mostly;
> +
> +static const struct zynqmp_eemi_ops *eemi_ops;

Take a look at Jolly's series which she sent recently and use the same
style as was recommended by Greg.

Thanks,
Michal
