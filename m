Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6313EC2BB84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 23:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2E92084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 23:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="H3WcttUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgIDXMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 19:12:02 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:38284 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728215AbgIDXL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 19:11:59 -0400
X-Greylist: delayed 10916 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Sep 2020 19:11:55 EDT
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 084K9g0u025126;
        Fri, 4 Sep 2020 15:09:50 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-00010702.pphosted.com with ESMTP id 337k212epe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Sep 2020 15:09:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nadLsf0HKDzvA2V5wp5LndPjD7N9MT9bodypqMI6fqvdLEa7gKQ1q0Z5Sxjl/4maV6T+14/3rnG9KOW9Sq29Yrh8TujC7om6TSyU+g1sUUquZegqGWnEIgxv4eEzttaMdA4n4LypT3kXkhx4Y56XObk4ce6SeA4SyIphe2pkxrOi3de0clYku7PbPO9xHslsBwmilSeZ4FMyI230FhBqYgyKWgHeRPfJBKkGo5kXgoLT7/mbE6vhyVjETajVMBlqqB+eu//2glPogadF/Z+nqP7/QM90kxbBuO82wRT60twP9Lgg9bdtf2FiCDfaAFrG374zM0k4CulwPcAt48HNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsSPBKI0qWoAdJ5cSJWB68leD/y+tHAbiQgV57JWDAA=;
 b=m3OfI4uKnB0uILl9bhS6R9o4E44XIQFTju4wXPXaBL926k77GSHpBt+CrFXm3txSSHAK4aVw72XqUkTv2BdY5GH3T1mWZD5oCd/AyhoHHESj8BL9DZ/dYfNvGb6NuGV8piaeQJDGmhRaXrsr145qXkeKDnP5Awcf7qAnLWsHaLPRxkbLVVoJgGeMlW4ZtnJwbnAvZ1AVk8nGaiynkLoLeMY0xrh0tbVZdLN0+OyMuJUeXUPhjWGWRZlFxEWSImuMVRfI+R78nqrG2ISh9cz11JHxb4KqYmGiFrunghaQwCbijRRpxnmfBv0FMzjtC9paUHH8RYyZ0WxYgdrSYiwNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsSPBKI0qWoAdJ5cSJWB68leD/y+tHAbiQgV57JWDAA=;
 b=H3WcttUUBWUlbrSGKvQNl2y0bJMESX3D04SOqu2UMLSjLJoM8gPpTyesSijImj/JPKN0SIRxJtYES0TeYqSm6ABq1I5jmTIJ3nCrDww+We4uSYmV276o5H+9yGv5hYJ1BwjU9EKkN+gGz8d9Smd/mDQ9LLrfQ1+rlZ91xI9ZCV8=
Authentication-Results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB4287.namprd04.prod.outlook.com
 (2603:10b6:805:35::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 20:09:47 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::30f8:af2b:efff:2750]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::30f8:af2b:efff:2750%3]) with mapi id 15.20.3305.034; Fri, 4 Sep 2020
 20:09:47 +0000
Date:   Fri, 4 Sep 2020 15:09:45 -0500
From:   Michael Auchter <michael.auchter@ni.com>
To:     Ben Levinsky <ben.levinsky@xilinx.com>
Cc:     punit1.agrawal@toshiba.co.jp, stefanos@xilinx.com,
        michals@xilinx.com, devicetree@vger.kernel.org,
        mathieu.poirier@linaro.org, emooring@xilinx.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jliang@xilinx.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Wendy Liang <wendy.liang@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ed Mooring <ed.mooring@xilinx.com>, Jason Wu <j.wu@xilinx.com>
Message-ID: <20200904200945.GD48975@xaphan>
References: <20200904143209.31235-1-ben.levinsky@xilinx.com>
 <20200904143209.31235-6-ben.levinsky@xilinx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904143209.31235-6-ben.levinsky@xilinx.com>
X-ClientProxiedBy: SN6PR01CA0012.prod.exchangelabs.com (2603:10b6:805:b6::25)
 To SN4PR0401MB3646.namprd04.prod.outlook.com (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2605:a601:ab6f:2000:2739:a39e:9b12:ab20) by SN6PR01CA0012.prod.exchangelabs.com (2603:10b6:805:b6::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 20:09:46 +0000
X-Originating-IP: [2605:a601:ab6f:2000:2739:a39e:9b12:ab20]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c84ea067-0ed0-4f3d-41e8-08d8510e7871
X-MS-TrafficTypeDiagnostic: SN6PR04MB4287:
X-Microsoft-Antispam-PRVS: <SN6PR04MB4287ACA20C40D040476A6FB4872D0@SN6PR04MB4287.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:348;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8djCHaFyB1QNG0hrcMfWFP4OBVcViWGBzrDS4Vcst6ptZSBRWXIAgkgp879SasyOJh/+rn2y5txcQxKaoS1BsflVH4vZZUK6311WYnUAFrIsIEkQ5saqQ6GbyK7LgEwUI0rlAkgxYMA9vPjQtFP19OKc6JvBQgCHCdfS+n9t8WceVdi9LsGZ0Ti2oeZg5M144B6GceXlaceGXmwaaJabx+9EkNgRwa9geL6HPpGzIXMNOcjLzzGyQvkWSRGC1m4D+AkAtoJ7Eh9zsaas0eHJs+RpZ/myjfC/KcquxSccN49XYMj5VnX0GGJ/oDsCeqWiLnZ7lo56Z+quCfnrR7ZrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(376002)(366004)(346002)(396003)(39860400002)(52116002)(33656002)(66556008)(66946007)(186003)(66476007)(1076003)(83380400001)(8936002)(9686003)(8676002)(5660300002)(30864003)(316002)(44832011)(16526019)(7416002)(6496006)(4326008)(86362001)(6486002)(6916009)(54906003)(478600001)(2906002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: HZ8HSzXQLHE7VnhhzuJDwcInElaEEIgYv+E13XWX/zUqgSVvOuaSi+2VDhheA6ZWvL28R4yLmae70XJECMspMHc6e7ZFQ1Vl5D5GB1rB1W8hq4qiNF3Wm/DfgeVBh5w2MIQdQRgGUt0fi+88tGqCjijkiBfeRPp7A4KPt3RUIUeD6mL7jbHCOpWbX2TVS92awLfUO2jTLkwidY67bAaUNXHhMec4UgoDDGAsdscd5hZExHDLllr/1JxwjLBTJhf7sDECob5NhIu0M2I9bgXAKYpUn2zQIYM2NLmQssH+3fzzYDst5+E5JXh9ah0bh+hR9mXU074rVbm+j43rcpd8LBagFVyDGOmAFIo9rCtTqvev4BB6zpTScvDnLLnXq2kpm30vu8t4sRBzfTLBAzq9ftplp1biV8s1NJI8A7uNy0NME4EZ5CO+lK7CbBkYAiaODZgaiFM3878WESHVGwYW3RP/5X66oaCcGq4z/7vKVUUM+Z5xMa2lhY0c49OzFXDSfXx4vFvj7KcQChug+wkSThGicKW8yz+NYcQ8kPIDviQeYMGLrVdh3yfHUl9eFCCfjz3yoQuZ3ZT7QfRziG0OMS6WNfY4jRhWkFdsA2QOpTzT5J1hoWG0TiX0scOmQayKi9dIfpXGq5cirIM9l0yfdgV5S3qK2RGKyAEtf8PJWTYnyIkiOj7PUV+IjijDsWcI4DjaDc6K8nHzgPu4wbKJDQ==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84ea067-0ed0-4f3d-41e8-08d8510e7871
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 20:09:46.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvzZYlC0vOyPy/E0VgnLpSmwSx1zoMjV7tK9o5IikG4m06hd5h1+uFrSbtJ+TNIvx+hL2xiyYU0r0sBVuFFtNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4287
Subject: Re: [PATCH v13 5/5] remoteproc: Add initial zynqmp R5 remoteproc driver
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-04_15:2020-09-04,2020-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 adultscore=0
 suspectscore=7 clxscore=1011 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009040173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ben,

On Fri, Sep 04, 2020 at 07:32:09AM -0700, Ben Levinsky wrote:
> R5 is included in Xilinx Zynq UltraScale MPSoC so by adding this
> remotproc driver, we can boot the R5 sub-system in different 2
> configurations: split or lock-step.
> 
> The Xilinx R5 Remoteproc Driver boots the R5's via calls to the Xilinx
> Platform Management Unit that handles the R5 configuration, memory access
> and R5 lifecycle management. The interface to this manager is done in this
> driver via zynqmp_pm_* function calls.
> 
> Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Ed Mooring <ed.mooring@xilinx.com>
> Signed-off-by: Jason Wu <j.wu@xilinx.com>
> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> ---
> v2:
>  - remove domain struct as per review from Mathieu
>  v3:
>  - add xilinx-related platform mgmt fn's instead of wrapping around
>    function pointer in xilinx eemi ops struct
>  v4:
>  - add default values for enums
>  - fix formatting as per checkpatch.pl --strict. Note that 1 warning and 1 check
>    are still raised as each is due to fixing the warning results in that
>  particular line going over 80 characters.
>  v5:
>  - parse_fw change from use of rproc_of_resm_mem_entry_init to
>  rproc_mem_entry_init and use of alloc/release
>  - var's of type zynqmp_r5_pdata all have same local variable name
>  - use dev_dbg instead of dev_info
>  v6:
>  - adding memory carveouts is handled much more similarly. All mem
>  carveouts are
>    now described in reserved memory as needed. That is, TCM nodes are not
>    coupled to remoteproc anymore. This is reflected in the remoteproc R5
>  driver
>    and the device tree binding.
>  - remove mailbox from device tree binding as it is not necessary for elf
>    loading
>  - use lockstep-mode property for configuring RPU
>  v7:
>  - remove unused headers
>  - change  u32 *lockstep_mode ->  u32 lockstep_mode;
>  - change device-tree binding "lockstep-mode"  to xlnx,cluster-mode
>  - remove zynqmp_r5_mem_probe and loop to Probe R5 memory devices at
>    remoteproc-probe time
>  - remove is_r5_mode_set from  zynqmp rpu remote processor private data
>  - do not error out if no mailbox is provided
>  - remove zynqmp_r5_remoteproc_probe call of platform_set_drvdata as
>  pdata is
>    handled in zynqmp_r5_remoteproc_remove
> v8:
>  - remove old acks, reviewed-by's in commit message
> v9:
> - as mboxes are now optional, if pdata->tx_mc_skbs not initialized then
>   do not call skb_queue_empty
> - update usage for zynqmp_pm_set_rpu_mode, zynqmp_pm_set_tcm_config and
>   zynqmp_pm_get_rpu_mode
> - update 5/5 patch commit message to document supported configurations
>   and how they are booted by the driver.
> - remove copyrights other than SPDX from zynqmp_r5_remoteproc.c
> - compilation warnings no longer raised
> - remove unused includes from zynqmp_r5_remoteproc.c
> - remove unused  var autoboot from zynqmp_r5_remoteproc.c
> - reorder zynqmp_r5_pdata fpr small mem savings due to alignment
> - use of zynqmp_pm_set_tcm_config now does not have
>   output arg
> - in tcm handling, unconditionally use &= 0x000fffff mask since all nodes
>   in this fn are for tcm
> - update comments for translating dma field in tcm handling to device
>   address
> - update calls to rproc_mem_entry_init in parse_mem_regions so that there
>   are only 2 cases for types of carveouts instead of 3
> - in parse_mem_regions, check if device tree node is null before using it
> - add example device tree nodes used in parse_mem_regions and tcm parsing
> - add comment for vring id node length
> - add check for string length so that vring id is at least min length
> - move tcm nodes from reserved mem to instead own device tree nodes
>    and only use them if enabled in device tree
> - add comment for explaining handling of rproc_elf_load_rsc_table
> - remove obsolete check for "if (vqid < 0)" in zynqmp_r5_rproc_kick
> - remove unused field mems in struct zynqmp_r5_pdata
> - remove call to zynqmp_r5_mem_probe and the fn itself as tcm handling
>   is done by zyqmp_r5_pm_request_tcm
> - remove obsolete setting of dma_ops and parent device dma_mask
> - remove obsolete use of of_dma_configure
> - add comment for call to r5_set_mode fn
> - make mbox usage optional and gracefully inform user via dev_dbg if not
>   present
> - change var lockstep_mode from u32* to u32
> v11:
> - use enums instead of u32 where possible in zynqmp_r5_remoteproc
> - update usage of zynqmp_pm_set/get_rpu_mode and zynqmp_pm_set_tcm_config
> - update prints to not use carriage return, just newline
> - look up tcm banks via property in r5 node instead of string name
> - print device tree nodes with %pOF instead of %s with node name field
> - update tcm release to unmap VA
> - handle r5-1 use case
> v12:
> - update signed off by so that latest developer name is last
> - do not cast enums to u32s for zynqmp_pm* functions
> ---
>  drivers/remoteproc/Kconfig                |  10 +
>  drivers/remoteproc/Makefile               |   1 +
>  drivers/remoteproc/zynqmp_r5_remoteproc.c | 898 ++++++++++++++++++++++
>  3 files changed, 909 insertions(+)
>  create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index c4d1731295eb..dd9ed45654e0 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -249,6 +249,16 @@ config STM32_RPROC
>  
>  	  This can be either built-in or a loadable module.
>  
> +config ZYNQMP_R5_REMOTEPROC
> +	tristate "ZynqMP_R5 remoteproc support"
> +	depends on ARM64 && PM && ARCH_ZYNQMP
> +	select RPMSG_VIRTIO
> +	select MAILBOX
> +	select ZYNQMP_IPI_MBOX
> +	help
> +	  Say y or m here to support ZynqMP R5 remote processors via the remote
> +	  processor framework.
> +
>  endif # REMOTEPROC
>  
>  endmenu
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index e8b886e511f0..04d1c95d06d7 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -28,5 +28,6 @@ obj-$(CONFIG_QCOM_WCNSS_PIL)		+= qcom_wcnss_pil.o
>  qcom_wcnss_pil-y			+= qcom_wcnss.o
>  qcom_wcnss_pil-y			+= qcom_wcnss_iris.o
>  obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
> +obj-$(CONFIG_ZYNQMP_R5_REMOTEPROC)	+= zynqmp_r5_remoteproc.o
>  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
>  obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
> diff --git a/drivers/remoteproc/zynqmp_r5_remoteproc.c b/drivers/remoteproc/zynqmp_r5_remoteproc.c
> new file mode 100644
> index 000000000000..4fc4098ae1ea
> --- /dev/null
> +++ b/drivers/remoteproc/zynqmp_r5_remoteproc.c
> @@ -0,0 +1,898 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Zynq R5 Remote Processor driver
> + *
> + * Based on origin OMAP and Zynq Remote Processor driver
> + *
> + */
> +
> +#include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mailbox/zynqmp-ipi-message.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +#include <linux/skbuff.h>
> +#include <linux/sysfs.h>
> +
> +#include "remoteproc_internal.h"
> +
> +#define MAX_RPROCS	2 /* Support up to 2 RPU */
> +#define MAX_MEM_PNODES	4 /* Max power nodes for one RPU memory instance */
> +
> +#define DEFAULT_FIRMWARE_NAME	"rproc-rpu-fw"
> +#define BANK_LIST_PROP "meta-memory-regions"
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
> +/**
> + * struct zynqmp_r5_mem - zynqmp rpu memory data
> + * @pnode_id: TCM power domain ids
> + * @res: memory resource
> + * @node: list node
> + */
> +struct zynqmp_r5_mem {
> +	u32 pnode_id[MAX_MEM_PNODES];
> +	struct resource res;
> +	struct list_head node;
> +};
> +
> +/**
> + * struct zynqmp_r5_pdata - zynqmp rpu remote processor private data
> + * @dev: device of RPU instance
> + * @rproc: rproc handle
> + * @pnode_id: RPU CPU power domain id
> + * @is_r5_mode_set: indicate if r5 operation mode is set
> + * @tx_mc: tx mailbox client
> + * @rx_mc: rx mailbox client
> + * @tx_chan: tx mailbox channel
> + * @rx_chan: rx mailbox channel
> + * @mbox_work: mbox_work for the RPU remoteproc
> + * @tx_mc_skbs: socket buffers for tx mailbox client
> + * @rx_mc_buf: rx mailbox client buffer to save the rx message
> + */
> +struct zynqmp_r5_pdata {
> +	unsigned char rx_mc_buf[RX_MBOX_CLIENT_BUF_MAX];
> +	struct mbox_client tx_mc;
> +	struct mbox_client rx_mc;
> +	struct work_struct mbox_work;
> +	struct sk_buff_head tx_mc_skbs;
> +	struct device dev;
> +	struct rproc *rproc;
> +	struct mbox_chan *tx_chan;
> +	struct mbox_chan *rx_chan;
> +	u32 pnode_id;
> +	bool is_r5_mode_set;
> +};
> +
> +/**
> + * table of RPUs
> + */
> +struct zynqmp_r5_pdata rpus[MAX_RPROCS];

static, if this really isn't going to be dynamically allocated.

> +/**
> + * RPU core configuration
> + */
> +enum rpu_oper_mode rpu_mode;

static

> +
> +/*
> + * r5_set_mode - set RPU operation mode
> + * @pdata: Remote processor private data
> + *
> + * set RPU oepration mode

operation

> + *
> + * Return: 0 for success, negative value for failure
> + */
> +static int r5_set_mode(struct zynqmp_r5_pdata *pdata)
> +{
> +	struct device *dev = &pdata->dev;
> +	enum rpu_tcm_comb cur_tcm_mode;
> +	enum rpu_oper_mode cur_rpu_mode;
> +	int ret;
> +
> +	cur_rpu_mode = rpu_mode;

Unnecessary assignment

> +	ret = zynqmp_pm_get_rpu_mode(pdata->pnode_id, &cur_rpu_mode);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get RPU oper mode.\n");
> +		return ret;
> +	}
> +	if (rpu_mode == cur_rpu_mode) {
> +		dev_dbg(dev, "RPU mode matches: %x\n", rpu_mode);
> +	} else {
> +		ret = zynqmp_pm_set_rpu_mode(pdata->pnode_id,
> +					     cur_rpu_mode);

This logic is broken: rpu_mode is the desired state (set by the
lockstep-mode), cur_rpu_mode is the mode the rpu is currently configured
for (retrieved from firmware). So this is a no-op: it configures the RPU
to be in the mode that it's already in.

> +		if (ret < 0) {
> +			dev_err(dev,
> +				"failed to set RPU oper mode.\n");
> +			return ret;
> +		}
> +	}
> +
> +	cur_tcm_mode = (cur_rpu_mode == PM_RPU_MODE_LOCKSTEP) ?
> +		    PM_RPU_TCM_COMB : PM_RPU_TCM_SPLIT;
> +	ret = zynqmp_pm_set_tcm_config(pdata->pnode_id, cur_tcm_mode);

This logic is also broken: the TCM mode should be inferred from the
desired RPU mode, not the mode the RPU was in when this function was
called.

These two issues prevent this driver from successfully loading firmware
to RPU 1 in split mode.

cur_tcm_mode isn't the best name for this, either, as it's not the
"current" tcm mode, but rather the desired tcm_mode.

> +	if (ret < 0) {
> +		dev_err(dev, "failed to config TCM to %x.\n",
> +			cur_rpu_mode);

tcm_mode instead of cur_rpu_mode?

Also, there's an unnecessary line wrap here and elsewhere in this patch.

> +		return ret;
> +	}
> +	pdata->is_r5_mode_set = true;
> +	return 0;
> +}
> +
> +/*
> + * ZynqMP R5 remoteproc memory release function
> + */
> +static int tcm_mem_release(struct rproc *rproc, struct rproc_mem_entry *mem)
> +{
> +	u32 pnode_id;
> +	int ret;
> +	struct device *dev = &rproc->dev;
> +
> +	pnode_id = *(u32 *)mem->priv;
> +
> +	if (pnode_id <= 0)
> +		dev_err(dev, "rproc_mem_entry has null priv field\n");
> +
> +	iounmap(mem->va);
> +
> +	ret = zynqmp_pm_release_node(pnode_id);
> +	if (ret < 0)
> +		dev_err(dev, "failed to release power node: %u\n", pnode_id);
> +
> +	return ret;
> +}
> +
> +/*
> + * ZynqMP R5 remoteproc operations
> + */
> +static int zynqmp_r5_rproc_start(struct rproc *rproc)
> +{
> +	struct device *dev = rproc->dev.parent;
> +	struct zynqmp_r5_pdata *pdata = rproc->priv;
> +	enum rpu_boot_mem bootmem;
> +	int ret;
> +
> +	if ((rproc->bootaddr & 0xF0000000) == 0xF0000000)
> +		bootmem = PM_RPU_BOOTMEM_HIVEC;
> +	else
> +		bootmem = PM_RPU_BOOTMEM_LOVEC;
> +	dev_dbg(dev, "RPU boot from %s.",
> +		bootmem == PM_RPU_BOOTMEM_HIVEC ? "OCM" : "TCM");
> +	ret = zynqmp_pm_request_wake(pdata->pnode_id, 1,
> +				     bootmem, ZYNQMP_PM_REQUEST_ACK_NO);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to boot R5.\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int zynqmp_r5_rproc_stop(struct rproc *rproc)
> +{
> +	struct zynqmp_r5_pdata *pdata = rproc->priv;
> +	int ret;
> +
> +	ret = zynqmp_pm_force_pwrdwn(pdata->pnode_id,
> +				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +	if (ret < 0) {
> +		dev_err(&pdata->dev, "failed to shutdown R5.\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static int zynqmp_r5_rproc_mem_alloc(struct rproc *rproc,
> +				     struct rproc_mem_entry *mem)
> +{
> +	struct device *dev = rproc->dev.parent;
> +	void *va;
> +
> +	dev_dbg(rproc->dev.parent, "map memory: %pa\n", &mem->dma);
> +	va = ioremap_wc(mem->dma, mem->len);
> +	if (IS_ERR_OR_NULL(va)) {
> +		dev_err(dev, "Unable to map memory region: %pa+%lx\n",
> +			&mem->dma, mem->len);
> +		return -ENOMEM;
> +	}
> +
> +	/* Update memory entry va */
> +	mem->va = va;
> +
> +	return 0;
> +}
> +
> +static int zynqmp_r5_rproc_mem_release(struct rproc *rproc,
> +				       struct rproc_mem_entry *mem)
> +{
> +	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
> +	iounmap(mem->va);
> +
> +	return 0;
> +}
> +
> +static int parse_mem_regions(struct rproc *rproc)
> +{
> +	int num_mems, i;
> +	struct zynqmp_r5_pdata *pdata = rproc->priv;
> +	struct device *dev =  &pdata->dev;
> +	struct device_node *np = dev->of_node;
> +	struct rproc_mem_entry *mem;
> +
> +	num_mems = of_count_phandle_with_args(np, "memory-region", NULL);
> +	if (num_mems <= 0)
> +		return 0;
> +	for (i = 0; i < num_mems; i++) {
> +		struct device_node *node;
> +		struct reserved_mem *rmem;
> +
> +		node = of_parse_phandle(np, "memory-region", i);
> +		if (!node) {
> +			dev_err(dev, "no memory-region specified\n");
> +			return -EINVAL;
> +		}
> +
> +		rmem = of_reserved_mem_lookup(node);
> +		if (!rmem) {
> +			dev_err(dev, "unable to acquire memory-region\n");
> +			return -EINVAL;
> +		}
> +
> +		if (strstr(node->name, "vdev0vring")) {
> +			int vring_id;
> +			char name[16];
> +
> +			/*
> +			 * expecting form of "rpuXvdev0vringX as documented
> +			 * in xilinx remoteproc device tree binding
> +			 */
> +			if (strlen(node->name) < 14) {
> +				dev_err(dev, "%pOF is less than 14 chars",
> +					node);
> +				return -EINVAL;
> +			}
> +
> +			/*
> +			 * can be 1 of multiple vring IDs per IPC channel
> +			 * e.g. 'vdev0vring0' and 'vdev0vring1'
> +			 */
> +			vring_id = node->name[14] - '0';
> +			snprintf(name, sizeof(name), "vdev0vring%d", vring_id);
> +			/* Register vring */
> +			mem = rproc_mem_entry_init(dev, NULL,
> +						   (dma_addr_t)rmem->base,
> +						   rmem->size, rmem->base,
> +						   zynqmp_r5_rproc_mem_alloc,
> +						   zynqmp_r5_rproc_mem_release,
> +						   name);
> +			dev_dbg(dev, "parsed %s at %llx\n", mem->name,
> +				mem->dma);
> +		} else {
> +			/* Register DMA region */
> +			int (*alloc)(struct rproc *r,
> +				     struct rproc_mem_entry *rme);
> +			int (*release)(struct rproc *r,
> +				       struct rproc_mem_entry *rme);
> +			char name[20];
> +
> +			if (strstr(node->name, "vdev0buffer")) {
> +				alloc = NULL;
> +				release = NULL;
> +				strcpy(name, "vdev0buffer");
> +			} else {
> +				alloc = zynqmp_r5_rproc_mem_alloc;
> +				release = zynqmp_r5_rproc_mem_release;
> +				strcpy(name, node->name);
> +			}
> +
> +			mem = rproc_mem_entry_init(dev, NULL,
> +						   (dma_addr_t)rmem->base,
> +						   rmem->size, rmem->base,
> +						   alloc, release, name);
> +			if (!mem) {
> +				dev_err(dev,
> +					"unable to init memory-region %pOF\n",
> +					node);
> +				return -ENOMEM;
> +			}
> +			dev_dbg(dev, "parsed %s at  %llx\n", mem->name,
> +				mem->dma);
> +		}
> +		rproc_add_carveout(rproc, mem);
> +	}
> +
> +	return 0;
> +}
> +
> +/* call Xilix Platform manager to request access to TCM bank */
> +static int zyqmp_r5_pm_request_tcm(struct device_node *tcm_node,
> +				   struct device *dev,
> +				   u32 *pnode_id)
> +{
> +	int ret;
> +
> +	ret = of_property_read_u32(tcm_node, "pnode-id", pnode_id);
> +	if (ret) {
> +		dev_err(dev, "Can't parse pnode-id property\n");
> +		return ret;
> +	}
> +
> +	ret = zynqmp_pm_request_node(*pnode_id, ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> +				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to request power node: %u\n", *pnode_id);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Given tcm bank entry,
> + * this callback will set device address for R5 running on TCM
> + * and also setup virtual address for tcm bank remoteproc carveout
> + */
> +static int tcm_mem_alloc(struct rproc *rproc,
> +			 struct rproc_mem_entry *mem)
> +{
> +	void *va;
> +	struct device *dev = rproc->dev.parent;
> +
> +	dev_dbg(rproc->dev.parent, "map memory: %pa\n", &mem->dma);
> +	va = ioremap_wc(mem->dma, mem->len);
> +	if (IS_ERR_OR_NULL(va)) {
> +		dev_err(dev, "Unable to map memory region: %pa+%lx\n",
> +			&mem->dma, mem->len);
> +		return -ENOMEM;
> +	}
> +
> +	/* Update memory entry va */
> +	mem->va = va;
> +
> +	va = devm_ioremap_wc(dev, mem->da, mem->len);
> +	if (!va)
> +		return -ENOMEM;
> +	/* As R5 is 32 bit, wipe out extra high bits */
> +	mem->da &= 0x000fffff;
> +	/*
> +	 * handle tcm banks 1 a and b (0xffe90000 and oxffeb0000)
> +	 * As both of these the only common bit found not in tcm bank0 a or b
> +	 * is at 0x80000 use this mask to suss it out
> +	 */
> +	if (mem->da & 0x80000)
> +		/*
> +		 * similar to wiping tcm banks 0a and 0b with just the
> +		 * mask of 0x000fffff will translate to device addr's
> +		 * at 0x0 and 0x20000, need to do more to further translate
> +		 * tcm banks 1a and 1b at 0xffe90000 and oxffeb0000
> +		 * respectively to 0x0 and 0x20000
> +		 */
> +		mem->da -= 0x90000;
> +
> +	return 0;
> +}
> +
> +/*
> + * Given R5 node in remoteproc instance,
> + * allocate remoteproc carveout for TCM memory
> + * needed for firmware to be loaded
> + */
> +static int parse_tcm_banks(struct rproc *rproc)
> +{
> +	int i, num_banks;
> +
> +	struct zynqmp_r5_pdata *pdata = rproc->priv;
> +	struct device *dev = &pdata->dev;
> +	struct device_node *r5_node = dev->of_node;
> +
> +	/* go through tcm banks for r5 node */
> +	num_banks = of_count_phandle_with_args(r5_node, BANK_LIST_PROP, NULL);

While I think this looks better than the special node-names used before,
I'm not so sure about introducing a new meta-memory-regions property.

I hope someone else can chime in here.

> +	if (num_banks <= 0) {
> +		dev_err(dev, "need to specify TCM banks\n");
> +		return -EINVAL;
> +	}
> +	for (i = 0; i < num_banks; i++) {
> +		struct resource rsc;
> +		resource_size_t size;
> +		struct device_node *dt_node;
> +		struct rproc_mem_entry *mem;
> +		int ret;
> +		/*
> +		 * use u32 as zynqmp_pm* functions use this type
> +		 *
> +		 * use ptr because it needs be used later on when releasing
> +		 * each tcm node in tcm_mem_release
> +		 */
> +		u32 *pnode_id_ptr;
> +
> +		dt_node = of_parse_phandle(r5_node, BANK_LIST_PROP, i);
> +		if (!dt_node) {
> +			dev_err(dev, "no tcm banks specified\n");
> +			return -EINVAL;
> +		}
> +
> +		if (of_device_is_available(dt_node)) {
> +			dev_dbg(dev, "%pOF is available\n", dt_node);
> +
> +			/* get address */
> +			ret = of_address_to_resource(dt_node, 0, &rsc);
> +			if (ret < 0) {
> +				dev_err(dev, "fail to get rsc mem %pOF",
> +					dt_node);
> +				return -EINVAL;
> +			}
> +
> +			pnode_id_ptr = devm_kzalloc(dev, sizeof(*pdata),
> +						    GFP_KERNEL);

The allocation size here looks incorrect (larger than it should be). But
I think this allocation should just be removed: you can just stuff the
pnode_id into the mem->priv pointer directly.

> +			if (!pnode_id_ptr)
> +				return -ENOMEM;
> +
> +			/* request access */
> +			zyqmp_r5_pm_request_tcm(dt_node, dev, pnode_id_ptr);
> +
> +			/* add carveout */
> +			size = resource_size(&rsc);
> +			mem = rproc_mem_entry_init(dev, NULL, rsc.start,
> +						   (int)size, rsc.start,
> +						   tcm_mem_alloc,
> +						   tcm_mem_release,
> +						   rsc.name);
> +			if (!mem)
> +				return -ENOMEM;
> +			mem->priv = (void *)pnode_id_ptr;
> +
> +			rproc_add_carveout(rproc, mem);
> +		} else {
> +			dev_info(dev, "node %pOF is not available\n", dt_node);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
> +{
> +	int ret;
> +	struct zynqmp_r5_pdata *pdata = rproc->priv;
> +	struct device *dev = &pdata->dev;
> +
> +	ret = parse_tcm_banks(rproc);
> +	if (ret) {
> +		dev_err(dev, "parse_tcm_banks failed %x\n", ret);
> +		return ret;
> +	}
> +
> +	ret = parse_mem_regions(rproc);
> +	if (ret) {
> +		dev_err(dev, "parse_mem_regions failed %x\n", ret);
> +		return ret;
> +	}
> +
> +	ret = rproc_elf_load_rsc_table(rproc, fw);
> +	if (ret == -EINVAL) {
> +		/*
> +		 * resource table only required for IPC.
> +		 * if not present, this is not necessarily an error;
> +		 * for example, loading r5 hello world application
> +		 * so simply inform user and keep going.
> +		 */
> +		dev_info(dev, "no resource table found.\n");
> +		ret = 0;
> +	}
> +	return ret;
> +}
> +
> +/* kick a firmware */
> +static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
> +{
> +	struct sk_buff *skb;
> +	unsigned int skb_len;
> +	struct zynqmp_ipi_message *mb_msg;
> +	int ret;
> +
> +	struct device *dev = rproc->dev.parent;
> +	struct zynqmp_r5_pdata *pdata = rproc->priv;
> +
> +	dev_dbg(dev, "KICK Firmware to start send messages vqid %d\n", vqid);
> +
> +	skb_len = (unsigned int)(sizeof(vqid) + sizeof(mb_msg));
> +	skb = alloc_skb(skb_len, GFP_ATOMIC);
> +	if (!skb) {
> +		dev_err(dev,
> +			"Failed to allocate skb to kick remote.\n");
> +		return;
> +	}
> +	mb_msg = (struct zynqmp_ipi_message *)skb_put(skb, skb_len);
> +	mb_msg->len = sizeof(vqid);
> +	memcpy(mb_msg->data, &vqid, sizeof(vqid));
> +	skb_queue_tail(&pdata->tx_mc_skbs, skb);
> +	ret = mbox_send_message(pdata->tx_chan, mb_msg);
> +	if (ret < 0) {
> +		dev_warn(dev, "Failed to kick remote.\n");
> +		skb_dequeue_tail(&pdata->tx_mc_skbs);
> +		kfree_skb(skb);
> +	}
> +}
> +
> +static struct rproc_ops zynqmp_r5_rproc_ops = {
> +	.start		= zynqmp_r5_rproc_start,
> +	.stop		= zynqmp_r5_rproc_stop,
> +	.load		= rproc_elf_load_segments,
> +	.parse_fw	= zynqmp_r5_parse_fw,
> +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> +	.sanity_check	= rproc_elf_sanity_check,
> +	.get_boot_addr	= rproc_elf_get_boot_addr,
> +	.kick		= zynqmp_r5_rproc_kick,
> +};
> +
> +/**
> + * zynqmp_r5_release() - ZynqMP R5 device release function
> + * @dev: pointer to the device struct of ZynqMP R5
> + *
> + * Function to release ZynqMP R5 device.
> + */
> +static void zynqmp_r5_release(struct device *dev)
> +{
> +	struct zynqmp_r5_pdata *pdata;
> +	struct rproc *rproc;
> +	struct sk_buff *skb;
> +
> +	pdata = dev_get_drvdata(dev);
> +	rproc = pdata->rproc;
> +	if (rproc) {
> +		rproc_del(rproc);
> +		rproc_free(rproc);
> +	}
> +	if (pdata->tx_chan)
> +		mbox_free_channel(pdata->tx_chan);
> +	if (pdata->rx_chan)
> +		mbox_free_channel(pdata->rx_chan);
> +
> +	/* Discard all SKBs if tx_mc_skbs is initialized */
> +	if (&pdata->tx_mc_skbs.prev) {
> +		while (!skb_queue_empty(&pdata->tx_mc_skbs)) {
> +			skb = skb_dequeue(&pdata->tx_mc_skbs);
> +			kfree_skb(skb);
> +		}
> +	}
> +
> +	put_device(dev->parent);
> +}
> +
> +/**
> + * event_notified_idr_cb() - event notified idr callback
> + * @id: idr id
> + * @ptr: pointer to idr private data
> + * @data: data passed to idr_for_each callback
> + *
> + * Pass notification to remoteproc virtio
> + *
> + * Return: 0. having return is to satisfy the idr_for_each() function
> + *          pointer input argument requirement.
> + **/
> +static int event_notified_idr_cb(int id, void *ptr, void *data)
> +{
> +	struct rproc *rproc = data;
> +
> +	(void)rproc_vq_interrupt(rproc, id);
> +	return 0;
> +}
> +
> +/**
> + * handle_event_notified() - remoteproc notification work funciton
> + * @work: pointer to the work structure
> + *
> + * It checks each registered remoteproc notify IDs.
> + */
> +static void handle_event_notified(struct work_struct *work)
> +{
> +	struct rproc *rproc;
> +	struct zynqmp_r5_pdata *pdata;
> +
> +	pdata = container_of(work, struct zynqmp_r5_pdata, mbox_work);
> +
> +	(void)mbox_send_message(pdata->rx_chan, NULL);
> +	rproc = pdata->rproc;
> +	/*
> +	 * We only use IPI for interrupt. The firmware side may or may
> +	 * not write the notifyid when it trigger IPI.
> +	 * And thus, we scan through all the registered notifyids.
> +	 */
> +	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc);
> +}
> +
> +/**
> + * zynqmp_r5_mb_rx_cb() - Receive channel mailbox callback
> + * @cl: mailbox client
> + * @mssg: message pointer
> + *
> + * It will schedule the R5 notification work.
> + */
> +static void zynqmp_r5_mb_rx_cb(struct mbox_client *cl, void *mssg)
> +{
> +	struct zynqmp_r5_pdata *pdata;
> +
> +	pdata = container_of(cl, struct zynqmp_r5_pdata, rx_mc);
> +	if (mssg) {
> +		struct zynqmp_ipi_message *ipi_msg, *buf_msg;
> +		size_t len;
> +
> +		ipi_msg = (struct zynqmp_ipi_message *)mssg;
> +		buf_msg = (struct zynqmp_ipi_message *)pdata->rx_mc_buf;
> +		len = (ipi_msg->len >= IPI_BUF_LEN_MAX) ?
> +		      IPI_BUF_LEN_MAX : ipi_msg->len;
> +		buf_msg->len = len;
> +		memcpy(buf_msg->data, ipi_msg->data, len);
> +	}
> +	schedule_work(&pdata->mbox_work);
> +}
> +
> +/**
> + * zynqmp_r5_mb_tx_done() - Request has been sent to the remote
> + * @cl: mailbox client
> + * @mssg: pointer to the message which has been sent
> + * @r: status of last TX - OK or error
> + *
> + * It will be called by the mailbox framework when the last TX has done.
> + */
> +static void zynqmp_r5_mb_tx_done(struct mbox_client *cl, void *mssg, int r)
> +{
> +	struct zynqmp_r5_pdata *pdata;
> +	struct sk_buff *skb;
> +
> +	if (!mssg)
> +		return;
> +	pdata = container_of(cl, struct zynqmp_r5_pdata, tx_mc);
> +	skb = skb_dequeue(&pdata->tx_mc_skbs);
> +	kfree_skb(skb);
> +}
> +
> +/**
> + * zynqmp_r5_setup_mbox() - Setup mailboxes
> + *
> + * @pdata: pointer to the ZynqMP R5 processor platform data
> + * @node: pointer of the device node
> + *
> + * Function to setup mailboxes to talk to RPU.
> + *
> + * Return: 0 for success, negative value for failure.
> + */
> +static int zynqmp_r5_setup_mbox(struct zynqmp_r5_pdata *pdata,
> +				struct device_node *node)
> +{
> +	struct device *dev = &pdata->dev;
> +	struct mbox_client *mclient;
> +
> +	/* Setup TX mailbox channel client */
> +	mclient = &pdata->tx_mc;
> +	mclient->dev = dev;
> +	mclient->rx_callback = NULL;
> +	mclient->tx_block = false;
> +	mclient->knows_txdone = false;
> +	mclient->tx_done = zynqmp_r5_mb_tx_done;
> +
> +	/* Setup TX mailbox channel client */
> +	mclient = &pdata->rx_mc;
> +	mclient->dev = dev;
> +	mclient->rx_callback = zynqmp_r5_mb_rx_cb;
> +	mclient->tx_block = false;
> +	mclient->knows_txdone = false;
> +
> +	INIT_WORK(&pdata->mbox_work, handle_event_notified);
> +
> +	/* Request TX and RX channels */
> +	pdata->tx_chan = mbox_request_channel_byname(&pdata->tx_mc, "tx");
> +	if (IS_ERR(pdata->tx_chan)) {
> +		dev_err(dev, "failed to request mbox tx channel.\n");
> +		pdata->tx_chan = NULL;
> +		return -EINVAL;
> +	}
> +	pdata->rx_chan = mbox_request_channel_byname(&pdata->rx_mc, "rx");
> +	if (IS_ERR(pdata->rx_chan)) {
> +		dev_err(dev, "failed to request mbox rx channel.\n");
> +		pdata->rx_chan = NULL;
> +		return -EINVAL;
> +	}
> +	skb_queue_head_init(&pdata->tx_mc_skbs);
> +
> +	return 0;
> +}
> +
> +/**
> + * zynqmp_r5_probe() - Probes ZynqMP R5 processor device node
> + * @pdata: pointer to the ZynqMP R5 processor platform data
> + * @pdev: parent RPU domain platform device
> + * @node: pointer of the device node
> + *
> + * Function to retrieve the information of the ZynqMP R5 device node.
> + *
> + * Return: 0 for success, negative value for failure.
> + */
> +static int zynqmp_r5_probe(struct zynqmp_r5_pdata *pdata,
> +			   struct platform_device *pdev,
> +			   struct device_node *node)
> +{
> +	struct device *dev = &pdata->dev;
> +	struct rproc *rproc;
> +	int ret;
> +
> +	/* Create device for ZynqMP R5 device */
> +	dev->parent = &pdev->dev;
> +	dev->release = zynqmp_r5_release;
> +	dev->of_node = node;
> +	dev_set_name(dev, "%pOF", node);
> +	dev_set_drvdata(dev, pdata);
> +	ret = device_register(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to register device.\n");
> +		return ret;
> +	}
> +	get_device(&pdev->dev);
> +
> +	/* Allocate remoteproc instance */
> +	rproc = rproc_alloc(dev, dev_name(dev), &zynqmp_r5_rproc_ops, NULL, 0);
> +	if (!rproc) {
> +		dev_err(dev, "rproc allocation failed.\n");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +	pdata->rproc = rproc;
> +	rproc->priv = pdata;
> +
> +	/* Set up DMA mask */
> +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(&pdev->dev, "dma_set_coherent_mask: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Get R5 power domain node */
> +	ret = of_property_read_u32(node, "pnode-id", &pdata->pnode_id);
> +	if (ret) {
> +		dev_err(dev, "failed to get power node id.\n");
> +		goto error;
> +	}
> +
> +	/* TODO Check if R5 is running */
> +
> +	/*
> +	 * Set up R5 if not already setup
> +	 * This check is needed as there are cases where
> +	 * a user might repeatedly do modprobe
> +	 * and modprobe -r. In this case, upon a
> +	 * subsequent load, this check is needed.
> +	 */
> +	ret = pdata->is_r5_mode_set ? 0 : r5_set_mode(pdata);

I'm a bit confused by this comment. How would this flag persist across
module loads / unloads?

> +	if (ret) {
> +		dev_err(dev, "failed to set R5 operation mode.\n");
> +		return ret;
> +	}
> +
> +	if (!of_get_property(dev->of_node, "mboxes", NULL)) {
> +		dev_dbg(dev, "no mailboxes.\n");
> +	} else {
> +		ret = zynqmp_r5_setup_mbox(pdata, node);
> +		if (ret < 0)
> +			goto error;
> +	}
> +
> +	/* Add R5 remoteproc */
> +	ret = rproc_add(rproc);
> +	if (ret) {
> +		dev_err(dev, "rproc registration failed\n");
> +		goto error;
> +	}
> +	return 0;
> +error:
> +	if (pdata->rproc)
> +		rproc_free(pdata->rproc);
> +	pdata->rproc = NULL;
> +	device_unregister(dev);
> +	put_device(&pdev->dev);
> +	return ret;
> +}
> +
> +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
> +{
> +	int ret, i = 0;
> +	u32 lockstep_mode;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *nc;
> +	struct zynqmp_r5_pdata *pdata;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pdata);

Where is this allocated pdata used? Below when calling zynqmp_r5_probe,
you end up passing a pointer to the rpus array...

> +
> +	of_property_read_u32(dev->of_node, "lockstep-mode", &lockstep_mode);

It seems like probe should error if this property isn't present.

> +
> +	if (!lockstep_mode) {
> +		rpu_mode = PM_RPU_MODE_SPLIT;
> +	} else if (lockstep_mode == 1) {
> +		rpu_mode = PM_RPU_MODE_LOCKSTEP;
> +	} else {
> +		dev_err(dev,
> +			"Invalid lockstep-mode mode %x in %pOF\n",
> +			lockstep_mode, dev->of_node);
> +		return -EINVAL;
> +	}
> +	dev_dbg(dev, "RPU configuration: %s\n",
> +		lockstep_mode ? "lockstep" : "split");
> +
> +	for_each_available_child_of_node(dev->of_node, nc) {
> +		ret = zynqmp_r5_probe(&rpus[i], pdev, nc);
> +		if (ret) {
> +			dev_err(dev, "failed to probe rpu %pOF.\n", nc);
> +			return ret;
> +		}
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int zynqmp_r5_remoteproc_remove(struct platform_device *pdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_RPROCS; i++) {
> +		struct zynqmp_r5_pdata *pdata = &rpus[i];
> +		struct rproc *rproc;
> +
> +		/* only do clean up for pdata with active rpu */
> +		if (pdata->pnode_id == 0)
> +			continue;
> +
> +		rproc = pdata->rproc;
> +		if (rproc) {
> +			rproc_del(rproc);
> +			rproc_free(rproc);
> +			pdata->rproc = NULL;
> +		}
> +		if (pdata->tx_chan) {
> +			mbox_free_channel(pdata->tx_chan);
> +			pdata->tx_chan = NULL;
> +		}
> +		if (pdata->rx_chan) {
> +			mbox_free_channel(pdata->rx_chan);
> +			pdata->rx_chan = NULL;
> +		}
> +		if (&(&pdata->dev)->dma_pools)
> +			device_unregister(&pdata->dev);
> +	}
> +
> +	return 0;
> +}
> +
> +/* Match table for OF platform binding */
> +static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
> +	{ .compatible = "xlnx,zynqmp-r5-remoteproc-1.0", },
> +	{ /* end of list */ },
> +};
> +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> +
> +static struct platform_driver zynqmp_r5_remoteproc_driver = {
> +	.probe = zynqmp_r5_remoteproc_probe,
> +	.remove = zynqmp_r5_remoteproc_remove,
> +	.driver = {
> +		.name = "zynqmp_r5_remoteproc",
> +		.of_match_table = zynqmp_r5_remoteproc_match,
> +	},
> +};
> +module_platform_driver(zynqmp_r5_remoteproc_driver);
> +
> +MODULE_AUTHOR("Ben Levinsky <ben.levinsky@xilinx.com>");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1

Thanks,
 Michael
