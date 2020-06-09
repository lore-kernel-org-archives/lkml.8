Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF315C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CAB620774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYn0li/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbgFIPrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbgFIPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:47:15 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3772C03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 08:47:14 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c75so8880529ila.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wsaf45n3WHoKm3j4nJUdSB5ov2cLNebnPo0PuKHsIL8=;
        b=jYn0li/HQj9w3PWDCyHFqZ2+tnsWEv7f80eQQYB8+Yr8y5eWqIxg5dxNT/LbHxAxRr
         r+iqh1JkrEoXamNutu/CVIqvMKC6bU/kRsFwdj29gRGNKDlmKajeUdRW0pxzBF/Ai7Of
         hU2vdvK2f9XQNTnPcX/vWUZJaFdqyogYonyTwayX5AkW7y45VGXGnYNQYRgqBuwlXddS
         Oa4YvHlsyGpBaRm+Ib5BsEdC12Vbd+5JXOYwhvpOkvqsMEUZzeZKMrve1K8npFcAQby8
         w8f7Z7/HuYtHnS9PrYGr2luoY/SguPizgvGz3CJn8thOP1u0Keg4kdHqM/2sXZX1SlbY
         SEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wsaf45n3WHoKm3j4nJUdSB5ov2cLNebnPo0PuKHsIL8=;
        b=Gq/f5I0c+Yo20burOake+2OoqJDJoHIyQS7qyO6IdvD3t8qcR+bi2TrPaEywdfxSck
         L9vwtiloQfiS30wg53JowoY47KWrxQ339tcZiD+rPSRRJmK9btQw+SwqPDT+kT8Kmmlo
         VgGREmIyJ+pyJjmpF9U+whetXOWf+2oCKYGN8WVtBzPAO9x4h37N3hnBiHu0h5P96LHL
         exsAcovfU7yMPQ37n11uN/+ibr1stP3Mkb0T5GuIFo0tyHb5Gjt9Joe2EVjMjJXQjFMb
         6t590bvj7u9HM3HSD56aSQVD4piE8KM+sr48Zw0QxikrR2TRoHv0b4CTNtl5kX1BWtf9
         sazQ==
X-Gm-Message-State: AOAM533MHCdWM69nYVCy88RVYJ6zPOTVcQ2edQSI9YT25AruYBqSFpsb
        SZ3Os9n1t9dZvtGthSncZiyPYVCcunfVQpt40u01PQ==
X-Google-Smtp-Source: ABdhPJzTIbx2My7rw1+lwolTtQcviMF1aYV7VapnilJAiMmU2lDr9WQN1fjEZFkSmyYw+9zG78zqbq7kxH4IB/8mztI=
X-Received: by 2002:a92:c985:: with SMTP id y5mr26017334iln.50.1591717633705;
 Tue, 09 Jun 2020 08:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <1591195783-10290-1-git-send-email-ben.levinsky@xilinx.com>
 <1591195783-10290-6-git-send-email-ben.levinsky@xilinx.com>
 <20200608234935.GA4268@xps15> <b4217e0f-b14e-3ea1-e531-3b0962516690@ti.com> <BYAPR02MB4407440D447EA7F4724DDF16B5820@BYAPR02MB4407.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB4407440D447EA7F4724DDF16B5820@BYAPR02MB4407.namprd02.prod.outlook.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 9 Jun 2020 09:47:02 -0600
Message-ID: <CANLsYkz0cVZ=vPY69WDLp-Mt4XaRqpWBv03jzUfp1CwdUXoKiw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] remoteproc: Add initial zynqmp R5 remoteproc driver
To:     Ben Levinsky <BLEVINSK@xilinx.com>
Cc:     Suman Anna <s-anna@ti.com>, "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Michal Simek <michals@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "Ed T. Mooring" <emooring@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jun 2020 at 09:29, Ben Levinsky <BLEVINSK@xilinx.com> wrote:
>
> Hi Suman, Mathieu,
>
> Thank you for your comments. Please see my replies inline.
>
> Best Regards,
> Ben
>
> -----Original Message-----
> From: Suman Anna <s-anna@ti.com>
> Sent: Monday, June 8, 2020 5:00 PM
> To: Mathieu Poirier <mathieu.poirier@linaro.org>; Ben Levinsky <BLEVINSK@=
xilinx.com>
> Cc: ohad@wizery.com; bjorn.andersson@linaro.org; Michal Simek <michals@xi=
linx.com>; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; =
robh+dt@kernel.org; mark.rutland@arm.com; linux-remoteproc@vger.kernel.org;=
 linux-arm-kernell@lists.infradead.org; devicetree@vger.kernel.org; linux-k=
ernel@vger.kernel.org; Jiaying Liang <jliang@xilinx.com>; Michal Simek <mic=
hals@xilinx.com>; Ed T. Mooring <emooring@xilinx.com>; Jason Wu <j.wu@xilin=
x.com>
> Subject: Re: [PATCH v5 5/5] remoteproc: Add initial zynqmp R5 remoteproc =
driver
>
> On 6/8/20 6:49 PM, Mathieu Poirier wrote:
> > On Wed, Jun 03, 2020 at 07:49:43AM -0700, Ben Levinsky wrote:
> >> R5 is included in Xilinx Zynq UltraScale MPSoC so by adding this
> >> remotproc driver, we can boot the R5 sub-system in different
> >> configurations.
> >>
> >> Acked-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> >> Acked-by: Ben Levinsky <ben.levinsky@xilinx.com>
> >> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> >> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> >> Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> Signed-off-by: Ed Mooring <ed.mooring@xilinx.com>
> >> Signed-off-by: Jason Wu <j.wu@xilinx.com>
> >> Tested-by: Ben Levinsky <ben.levinsky@xilinx.com>
> >> ---
> >> v2:
> >> - remove domain struct as per review from Mathieu
> >> v3:
> >> - add xilinx-related platform mgmt fn's instead of wrapping around
> >>    function pointer in xilinx eemi ops struct
> >> v4:
> >> - add default values for enums
> >> - fix formatting as per checkpatch.pl --strict. Note that 1 warning an=
d 1 check
> >>    are still raised as each is due to fixing the warning results in
> >> that particular line going over 80 characters.
> >> v5:
> >> - parse_fw change from use of rproc_of_resm_mem_entry_init to
> >> rproc_mem_entry_init and use of alloc/release
> >> - var's of type zynqmp_r5_pdata all have same local variable name
> >> - use dev_dbg instead of dev_info
> >>
> >> ---
> >>   drivers/remoteproc/Kconfig                |  10 +
> >>   drivers/remoteproc/Makefile               |   1 +
> >>   drivers/remoteproc/zynqmp_r5_remoteproc.c | 898 ++++++++++++++++++++=
++++++++++
> >>   3 files changed, 909 insertions(+)
> >>   create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c
> >>
> >> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> >> index fbaed07..735bd7f 100644
> >> --- a/drivers/remoteproc/Kconfig
> >> +++ b/drivers/remoteproc/Kconfig
> >> @@ -240,6 +240,16 @@ config STM32_RPROC
> >>
> >>        This can be either built-in or a loadable module.
> >>
> >> +config ZYNQMP_R5_REMOTEPROC
> >> +    tristate "ZynqMP_R5 remoteproc support"
> >> +    depends on ARM64 && PM && ARCH_ZYNQMP
> >> +    select RPMSG_VIRTIO
> >> +    select MAILBOX
> >> +    select ZYNQMP_IPI_MBOX
> >> +    help
> >> +      Say y here to support ZynqMP R5 remote processors via the remot=
e
> >> +      processor framework.
> >> +
> >>   endif # REMOTEPROC
> >>
> >>   endmenu
> >> diff --git a/drivers/remoteproc/Makefile
> >> b/drivers/remoteproc/Makefile index 0effd38..806ac3f 100644
> >> --- a/drivers/remoteproc/Makefile
> >> +++ b/drivers/remoteproc/Makefile
> >> @@ -27,5 +27,6 @@ obj-$(CONFIG_QCOM_WCNSS_PIL)               +=3D qcom=
_wcnss_pil.o
> >>   qcom_wcnss_pil-y                   +=3D qcom_wcnss.o
> >>   qcom_wcnss_pil-y                   +=3D qcom_wcnss_iris.o
> >>   obj-$(CONFIG_ST_REMOTEPROC)                +=3D st_remoteproc.o
> >> +obj-$(CONFIG_ZYNQMP_R5_REMOTEPROC)  +=3D zynqmp_r5_remoteproc.o
> >>   obj-$(CONFIG_ST_SLIM_REMOTEPROC)   +=3D st_slim_rproc.o
> >>   obj-$(CONFIG_STM32_RPROC)          +=3D stm32_rproc.o
> >> diff --git a/drivers/remoteproc/zynqmp_r5_remoteproc.c
> >> b/drivers/remoteproc/zynqmp_r5_remoteproc.c
> >> new file mode 100644
> >> index 0000000..0e4f3ad
> >> --- /dev/null
> >> +++ b/drivers/remoteproc/zynqmp_r5_remoteproc.c
> >> @@ -0,0 +1,898 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Zynq R5 Remote Processor driver
> >> + *
> >> + * Copyright (C) 2019, 2020 Xilinx Inc. Ben Levinsky
> >> +<ben.levinsky@xilinx.com>
> >> + * Copyright (C) 2015 - 2018 Xilinx Inc.
> >> + * Copyright (C) 2015 Jason Wu <j.wu@xilinx.com>
> >> + *
> >> + * Based on origin OMAP and Zynq Remote Processor driver
> >> + *
> >> + * Copyright (C) 2012 Michal Simek <monstr@monstr.eu>
> >> + * Copyright (C) 2012 PetaLogix
> >> + * Copyright (C) 2011 Texas Instruments, Inc.
> >> + * Copyright (C) 2011 Google, Inc.
> >> + */
> >> +
> >> +#include <linux/atomic.h>
> >> +#include <linux/cpu.h>
> >> +#include <linux/dma-mapping.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/err.h>
> >> +#include <linux/firmware/xlnx-zynqmp.h> #include <linux/genalloc.h>
> >> +#include <linux/idr.h> #include <linux/interrupt.h> #include
> >> +<linux/kernel.h> #include <linux/list.h> #include
> >> +<linux/mailbox_client.h> #include
> >> +<linux/mailbox/zynqmp-ipi-message.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/of_irq.h>
> >> +#include <linux/of_platform.h>
> >> +#include <linux/of_reserved_mem.h>
> >> +#include <linux/pfn.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/remoteproc.h>
> >> +#include <linux/skbuff.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/sysfs.h>
> >> +
> >> +#include "remoteproc_internal.h"
> >> +
> >> +#define MAX_RPROCS  2 /* Support up to 2 RPU */
> >> +#define MAX_MEM_PNODES      4 /* Max power nodes for one RPU memory i=
nstance */
> >> +
> >> +#define DEFAULT_FIRMWARE_NAME       "rproc-rpu-fw"
> >> +
> >> +/* PM proc states */
> >> +#define PM_PROC_STATE_ACTIVE 1U
> >> +
> >> +/* IPI buffer MAX length */
> >> +#define IPI_BUF_LEN_MAX     32U
> >> +/* RX mailbox client buffer max length */
> >> +#define RX_MBOX_CLIENT_BUF_MAX      (IPI_BUF_LEN_MAX + \
> >> +                             sizeof(struct zynqmp_ipi_message))
> >> +
> >> +static bool autoboot __read_mostly;
> >> +
> >> +/**
> >> + * struct zynqmp_r5_mem - zynqmp rpu memory data
> >> + * @pnode_id: TCM power domain ids
> >> + * @res: memory resource
> >> + * @node: list node
> >> + */
> >> +struct zynqmp_r5_mem {
> >> +    u32 pnode_id[MAX_MEM_PNODES];
> >> +    struct resource res;
> >> +    struct list_head node;
> >> +};
> >> +
> >> +/**
> >> + * struct zynqmp_r5_pdata - zynqmp rpu remote processor private data
> >> + * @dev: device of RPU instance
> >> + * @rproc: rproc handle
> >> + * @pnode_id: RPU CPU power domain id
> >> + * @mems: memory resources
> >> + * @is_r5_mode_set: indicate if r5 operation mode is set
> >> + * @tx_mc: tx mailbox client
> >> + * @rx_mc: rx mailbox client
> >> + * @tx_chan: tx mailbox channel
> >> + * @rx_chan: rx mailbox channel
> >> + * @mbox_work: mbox_work for the RPU remoteproc
> >> + * @tx_mc_skbs: socket buffers for tx mailbox client
> >> + * @rx_mc_buf: rx mailbox client buffer to save the rx message  */
> >> +struct zynqmp_r5_pdata {
> >> +    struct device dev;
> >> +    struct rproc *rproc;
> >> +    u32 pnode_id;
> >> +    struct list_head mems;
> >> +    bool is_r5_mode_set;
> >> +    struct mbox_client tx_mc;
> >> +    struct mbox_client rx_mc;
> >> +    struct mbox_chan *tx_chan;
> >> +    struct mbox_chan *rx_chan;
> >> +    struct work_struct mbox_work;
> >> +    struct sk_buff_head tx_mc_skbs;
> >> +    unsigned char rx_mc_buf[RX_MBOX_CLIENT_BUF_MAX];
> >> +};
> >> +
> >> +/**
> >> + * table of RPUs
> >> + */
> >> +struct zynqmp_r5_pdata rpus[MAX_RPROCS];
> >> +/**
> >> + *  RPU core configuration
> >> + */
> >> +enum rpu_oper_mode rpu_mode;
> >> +
> >> +/*
> >> + * r5_set_mode - set RPU operation mode
> >> + * @pdata: Remote processor private data
> >> + *
> >> + * set RPU oepration mode
> >> + *
> >> + * Return: 0 for success, negative value for failure  */ static int
> >> +r5_set_mode(struct zynqmp_r5_pdata *pdata) {
> >> +    u32 val[PAYLOAD_ARG_CNT] =3D {0}, expect, tcm_mode;
> >> +    struct device *dev =3D &pdata->dev;
> >> +    int ret;
> >> +
> >> +    expect =3D (u32)rpu_mode;
> >> +    ret =3D zynqmp_pm_get_rpu_mode(pdata->pnode_id, 0, 0, val);
> >> +    if (ret < 0) {
> >> +            dev_err(dev, "failed to get RPU oper mode.\n");
> >> +            return ret;
> >> +    }
> >> +    if (val[0] =3D=3D expect) {
> >> +            dev_dbg(dev, "RPU mode matches: %x\n", val[0]);
> >> +    } else {
> >> +            ret =3D zynqmp_pm_set_rpu_mode(pdata->pnode_id,
> >> +                                         expect, 0, val);
> >> +            if (ret < 0) {
> >> +                    dev_err(dev,
> >> +                            "failed to set RPU oper mode.\n");
> >> +                    return ret;
> >> +            }
> >> +    }
> >> +
> >> +    tcm_mode =3D (expect =3D=3D (u32)PM_RPU_MODE_LOCKSTEP) ?
> >> +                PM_RPU_TCM_COMB : PM_RPU_TCM_SPLIT;
> >> +    ret =3D zynqmp_pm_set_tcm_config(pdata->pnode_id, tcm_mode, 0, va=
l);
> >> +    if (ret < 0) {
> >> +            dev_err(dev, "failed to config TCM to %x.\n",
> >> +                    expect);
> >> +            return ret;
> >> +    }
> >> +    pdata->is_r5_mode_set =3D true;
> >> +    return 0;
> >> +}
> >> +
> >> +/**
> >> + * r5_is_running - check if r5 is running
> >> + * @pdata: Remote processor private data
> >> + *
> >> + * check if R5 is running
> >> + *
> >> + * Return: true if r5 is running, false otherwise  */ static bool
> >> +r5_is_running(struct zynqmp_r5_pdata *pdata) {
> >> +    u32 status, requirements, usage;
> >> +    struct device *dev =3D &pdata->dev;
> >> +
> >> +    if (zynqmp_pm_get_node_status(pdata->pnode_id,
> >> +                                  &status, &requirements, &usage)) {
> >> +            dev_err(dev, "Failed to get RPU node %d status.\n",
> >> +                    pdata->pnode_id);
> >> +            return false;
> >> +    } else if (status !=3D PM_PROC_STATE_ACTIVE) {
> >> +            dev_dbg(dev, "RPU is not running.\n");
> >> +            return false;
> >> +    }
> >> +
> >> +    dev_dbg(dev, "RPU is running.\n");
> >> +    return true;
> >> +}
> >> +
> >> +/*
> >> + * ZynqMP R5 remoteproc memory release function  */ static int
> >> +zynqmp_r5_mem_release(struct rproc *rproc,
> >> +                             struct rproc_mem_entry *mem)
> >> +{
> >> +    struct zynqmp_r5_mem *priv;
> >> +    int i, ret;
> >> +    struct device *dev =3D &rproc->dev;
> >> +
> >> +    priv =3D mem->priv;
> >> +    if (!priv)
> >> +            return 0;
> >> +    for (i =3D 0; i < MAX_MEM_PNODES; i++) {
> >> +            if (priv->pnode_id[i]) {
> >> +                    dev_dbg(dev, "%s, pnode %d\n",
> >> +                            __func__, priv->pnode_id[i]);
> >> +                    ret =3D zynqmp_pm_release_node(priv->pnode_id[i])=
;
> >> +                    if (ret < 0) {
> >> +                            dev_err(dev,
> >> +                                    "failed to release power node: %u=
\n",
> >> +                                    priv->pnode_id[i]);
> >> +                            return ret;
> >> +                    }
> >> +            } else {
> >> +                    break;
> >> +            }
> >> +    }
> >> +    return 0;
> >> +}
> >> +
> >> +/*
> >> + * ZynqMP R5 remoteproc operations
> >> + */
> >> +static int zynqmp_r5_rproc_start(struct rproc *rproc) {
> >> +    struct device *dev =3D rproc->dev.parent;
> >> +    struct zynqmp_r5_pdata *pdata =3D rproc->priv;
> >> +    enum rpu_boot_mem bootmem;
> >> +    int ret;
> >> +    /* Set up R5 if not already setup */
> >> +    ret =3D pdata->is_r5_mode_set ? 0 : r5_set_mode(pdata);
> >
> > Is there any reason why r5_set_mode() has to be done as part of the
> > start() function rather than at probe() time?
> >
> [Ben Levinsky] Can be done instead at probe. Will do.
> >> +    if (ret) {
> >> +            dev_err(dev, "failed to set R5 operation mode.\n");
> >> +            return ret;
> >> +    }
> >> +    if ((rproc->bootaddr & 0xF0000000) =3D=3D 0xF0000000)
> >> +            bootmem =3D PM_RPU_BOOTMEM_HIVEC;
> >> +    else
> >> +            bootmem =3D PM_RPU_BOOTMEM_LOVEC;
> >> +    dev_dbg(dev, "RPU boot from %s.",
> >> +            bootmem =3D=3D PM_RPU_BOOTMEM_HIVEC ? "OCM" : "TCM");
> >> +    ret =3D zynqmp_pm_request_wakeup(pdata->pnode_id, 1,
> >> +                                   bootmem, ZYNQMP_PM_REQUEST_ACK_NO)=
;
> >> +    if (ret < 0) {
> >> +            dev_err(dev, "failed to boot R5.\n");
> >> +            return ret;
> >> +    }
> >> +    return 0;
> >> +}
> >> +
> >> +static int zynqmp_r5_rproc_stop(struct rproc *rproc) {
> >> +    struct zynqmp_r5_pdata *pdata =3D rproc->priv;
> >> +    int ret;
> >> +
> >> +    ret =3D zynqmp_pm_force_powerdown(pdata->pnode_id,
> >> +                                    ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> >> +    if (ret < 0) {
> >> +            dev_err(&pdata->dev, "failed to shutdown R5.\n");
> >> +            return ret;
> >> +    }
> >> +    pdata->is_r5_mode_set =3D false;
> >
> > Why resetting this to false?  If r5_set_mode() needs to be called
> > every time the remote processor is booted, why carrying an extra variab=
le (pdata->is_r5_mode_set)?
> >
> [Ben Levinsky] This is because the remote processor can be suspended. So =
when stopped this information should be stored.
> >> +    return 0;
> >> +}
> >> +
> >> +static int zynqmp_r5_rproc_mem_alloc(struct rproc *rproc,
> >> +                                  struct rproc_mem_entry *mem) {
> >> +    struct device *dev =3D rproc->dev.parent;
> >> +    void *va;
> >> +
> >> +    dev_dbg(rproc->dev.parent, "map memory: %pa\n", &mem->dma);
> >> +    va =3D ioremap_wc(mem->dma, mem->len);
> >> +    if (IS_ERR_OR_NULL(va)) {
> >> +            dev_err(dev, "Unable to map memory region: %pa+%x\n",
> >> +                    &mem->dma, mem->len);
> >> +            return -ENOMEM;
> >> +    }
> >> +
> >> +    /* Update memory entry va */
> >> +    mem->va =3D va;
> >> +
> >> +    return 0;
> >> +}
> >> +static int zynqmp_r5_rproc_mem_release(struct rproc *rproc,
> >> +                                   struct rproc_mem_entry *mem) {
> >> +    dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
> >> +    iounmap(mem->va);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct
> >> +firmware *fw) {
> >> +    int num_mems, i, ret;
> >> +    struct zynqmp_r5_pdata *pdata =3D rproc->priv;
> >> +    struct device *dev =3D &pdata->dev;
> >> +    struct device_node *np =3D dev->of_node;
> >> +    struct rproc_mem_entry *mem;
> >> +    struct device_node *child;
> >> +    struct resource rsc;
> >> +
> >> +    num_mems =3D of_count_phandle_with_args(np, "memory-region", NULL=
);
> >> +    if (num_mems <=3D 0)
> >> +            return 0;
> >> +    for (i =3D 0; i < num_mems; i++) {
> >> +            struct device_node *node;
> >> +            struct zynqmp_r5_mem *zynqmp_mem;
> >> +            struct reserved_mem *rmem;
> >> +            char rproc_name[20];
> >> +
> >> +            node =3D of_parse_phandle(np, "memory-region", i);
> >> +            rmem =3D of_reserved_mem_lookup(node);
> >> +            if (!rmem) {
> >> +                    dev_err(dev, "unable to acquire memory-region\n")=
;
> >> +                    return -EINVAL;
> >> +            }
> >> +
> >> +            if (strstr(node->name, "vdev0buffer")) {
> >> +                    /* Register DMA region */
> >> +                    mem =3D rproc_mem_entry_init(dev, NULL,
> >> +                                               (dma_addr_t)rmem->base=
,
> >> +                                               rmem->size, rmem->base=
,
> >> +                                               NULL, NULL,
> >> +                                               "vdev0buffer");
> >
> > Out of sheer curiosity, why did you choose to use
> > rproc_mem_entry_init() rather than rproc_of_resm_mem_entry_init()?
> > After all the vdev0buffer is part of a reserved memory...
> [Ben Levinsky] It is because rproc_mem_entry_init also sets DMA and virtu=
al address fields.
> >
> > There is more comments further below.  I'm out of time for today, I'll
> > continue with the rest of zynmp_r5_parse_fw() tomorrow.
> >
> > Thanks,
> > Mathieu
> >
> >> +                    if (!mem) {
> >> +                            dev_err(dev, "unable to initialize memory=
-region %s\n",
> >> +                                    node->name);
> >> +                            return -ENOMEM;
> >> +                    }
> >> +                    dev_dbg(dev, "parsed %s at  %llx\r\n", mem->name,
> >> +                            mem->dma);
> >> +                    rproc_add_carveout(rproc, mem);
> >> +                    continue;
> >> +            } else if (strstr(node->name, "vdev") &&
> >> +                                strstr(node->name, "vring")) {
> >> +                    int id, vring_id;
> >> +                    char name[16];
> >> +
> >> +                    id =3D node->name[8] - '0';
> >> +                    vring_id =3D node->name[14] - '0';
> >> +                    snprintf(name, sizeof(name), "vdev%dvring%d", id,
> >> +                             vring_id);
> >> +                    /* Register vring */
> >> +                    mem =3D rproc_mem_entry_init(dev, NULL,
> >> +                                               (dma_addr_t)rmem->base=
,
> >> +                                               rmem->size, rmem->base=
,
> >> +                                               zynqmp_r5_rproc_mem_al=
loc,
> >> +                                               zynqmp_r5_rproc_mem_re=
lease,
> >> +                                               name);
> >> +                    dev_dbg(dev, "parsed %s at %llx\r\n", mem->name,
> >> +                            mem->dma);
> >> +                    rproc_add_carveout(rproc, mem);
> >> +                    continue;
> >> +            } else {
> >> +                    mem =3D rproc_mem_entry_init(dev, NULL,
> >> +                                               (dma_addr_t)rmem->base=
,
> >> +                                               rmem->size, rmem->base=
,
> >> +                                               zynqmp_r5_rproc_mem_al=
loc,
> >> +                                               zynqmp_r5_rproc_mem_re=
lease,
> >> +                                               node->name);
> >> +
> >> +                    if (!mem) {
> >> +                            dev_err(dev,
> >> +                                    "unable to init memory-region %s\=
n",
> >> +                                    node->name);
> >> +                            return -ENOMEM;
> >> +                    }
> >> +                    mem->of_resm_idx =3D i;
> >> +
> >> +                    rproc_add_carveout(rproc, mem);
> >> +            }
> >> +    }
> >> +
> >> +    /* map TCM */
> >> +    for_each_available_child_of_node(np, child) {
> >> +            struct property *prop;
> >> +            const __be32 *cur;
> >> +            u32 pnode_id;
> >> +            void *va;
> >> +            dma_addr_t dma;
> >> +            resource_size_t size;
> >> +
> >> +            ret =3D of_address_to_resource(child, 0, &rsc);
> >> +
> >> +            i =3D 0;
> >> +            of_property_for_each_u32(child, "pnode-id", prop, cur,
> >> +                                     pnode_id) {
> >> +                    ret =3D zynqmp_pm_request_node(pnode_id,
> >> +                            ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> >> +                            ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> >> +                    if (ret < 0) {
> >> +                            dev_err(dev, "failed to request power nod=
e: %u\n",
> >> +                                    pnode_id);
> >> +                            return ret;
> >> +                    }
> >> +            }
> >> +            size =3D resource_size(&rsc);
> >> +            va =3D devm_ioremap_wc(dev, rsc.start, size);
> >> +            if (!va)
> >> +                    return -ENOMEM;
> >> +
> >> +            /* zero out tcm base address */
> >> +            if (rsc.start & 0xffe00000) {
> >> +                    rsc.start &=3D 0x000fffff;
> >> +                    /* handle tcm banks 1 a and b
> >> +                     * (0xffe9000 and oxffeb0000)
> >> +                     */
> >> +                            if (rsc.start & 0x80000)
> >> +                                    rsc.start -=3D 0x90000;
> >> +            }
> >> +
> >> +            dma =3D (dma_addr_t)rsc.start;
> >> +            mem =3D rproc_mem_entry_init(dev, va, dma, (int)size, rsc=
.start,
> >> +                                       NULL, zynqmp_r5_mem_release,
> >> +                                       rsc.name);
> >> +            if (!mem)
> >> +                    return -ENOMEM;
> >> +
> >> +            rproc_add_carveout(rproc, mem);
> >> +    }
> >> +
> >> +    ret =3D rproc_elf_load_rsc_table(rproc, fw);
> >> +    if (ret =3D=3D -EINVAL)
> >> +            ret =3D 0;
> >> +    return ret;
> >> +}
> >> +
> >> +/* kick a firmware */
> >> +static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid) {
> >> +    struct device *dev =3D rproc->dev.parent;
> >> +    struct zynqmp_r5_pdata *pdata =3D rproc->priv;
> >> +
> >> +    dev_dbg(dev, "KICK Firmware to start send messages vqid %d\n",
> >> +vqid);
> >> +
> >> +    if (vqid < 0) {
> >> +            /* If vqid is negative, does not pass the vqid to
> >> +             * mailbox. As vqid is supposed to be 0 or possive.
> >> +             * It also gives a way to just kick instead but
> >> +             * not use the IPI buffer. It is better to provide
> >> +             * a proper way to pass the short message, which will
> >> +             * need to sync to upstream first, for now,
> >> +             * use negative vqid to assume no message will be
> >> +             * passed with IPI buffer, but just raise interrupt.
> >> +             * This will be faster as it doesn't need to copy the
> >> +             * message to the IPI buffer.
> >> +             *
> >> +             * It will ignore the return, as failure is due to
> >> +             * there already kicks in the mailbox queue.
> >> +             */
> >> +            (void)mbox_send_message(pdata->tx_chan, NULL);
> >> +    } else {
> >> +            struct sk_buff *skb;
> >> +            unsigned int skb_len;
> >> +            struct zynqmp_ipi_message *mb_msg;
> >> +            int ret;
> >> +
> >> +            skb_len =3D (unsigned int)(sizeof(vqid) + sizeof(mb_msg))=
;
> >> +            skb =3D alloc_skb(skb_len, GFP_ATOMIC);
> >> +            if (!skb) {
> >> +                    dev_err(dev,
> >> +                            "Failed to allocate skb to kick remote.\n=
");
> >> +                    return;
> >> +            }
> >> +            mb_msg =3D (struct zynqmp_ipi_message *)skb_put(skb, skb_=
len);
> >> +            mb_msg->len =3D sizeof(vqid);
> >> +            memcpy(mb_msg->data, &vqid, sizeof(vqid));
> >> +            skb_queue_tail(&pdata->tx_mc_skbs, skb);
> >> +            ret =3D mbox_send_message(pdata->tx_chan, mb_msg);
> >> +            if (ret < 0) {
> >> +                    dev_warn(dev, "Failed to kick remote.\n");
> >> +                    skb_dequeue_tail(&pdata->tx_mc_skbs);
> >> +                    kfree_skb(skb);
> >> +            }
> >> +    }
> >> +}
> >> +
> >> +static struct rproc_ops zynqmp_r5_rproc_ops =3D {
> >> +    .start          =3D zynqmp_r5_rproc_start,
> >> +    .stop           =3D zynqmp_r5_rproc_stop,
> >> +    .load           =3D rproc_elf_load_segments,
> >> +    .parse_fw       =3D zynqmp_r5_parse_fw,
> >> +    .find_loaded_rsc_table =3D rproc_elf_find_loaded_rsc_table,
> >> +    .sanity_check   =3D rproc_elf_sanity_check,
> >> +    .get_boot_addr  =3D rproc_elf_get_boot_addr,
> >> +    .kick           =3D zynqmp_r5_rproc_kick,
> >> +};
> >> +
> >> +/* zynqmp_r5_mem_probe() - probes RPU TCM memory device
> >> + * @pdata: pointer to the RPU remoteproc private data
> >> + * @node: pointer to the memory node
> >> + *
> >> + * Function to retrieve resources for RPU TCM memory device.
> >> + */
> >> +static int zynqmp_r5_mem_probe(struct zynqmp_r5_pdata *pdata,
> >> +                           struct device_node *node)
> >> +{
> >> +    struct device *dev;
> >> +    struct zynqmp_r5_mem *mem;
> >> +    int ret;
> >> +    struct property *prop;
> >> +    const __be32 *cur;
> >> +    u32 val;
> >> +    int i =3D 0;
> >> +
> >> +    dev =3D &pdata->dev;
> >> +    mem =3D devm_kzalloc(dev, sizeof(*mem), GFP_KERNEL);
> >> +    if (!mem)
> >> +            return -ENOMEM;
> >> +    ret =3D of_address_to_resource(node, 0, &mem->res);
> >> +    if (ret < 0) {
> >> +            dev_err(dev, "failed to get resource of memory %s",
> >> +                    of_node_full_name(node));
> >> +            return -EINVAL;
> >> +    }
> >> +
> >> +    /* Get the power domain id */
> >> +    if (of_find_property(node, "pnode-id", NULL)) {
> >> +            of_property_for_each_u32(node, "pnode-id", prop, cur, val=
)
> >> +                    mem->pnode_id[i++] =3D val;
> >> +    }
> >> +    list_add_tail(&mem->node, &pdata->mems);
> >> +    return 0;
> >> +}
> >> +
> >> +/**
> >> + * zynqmp_r5_release() - ZynqMP R5 device release function
> >> + * @dev: pointer to the device struct of ZynqMP R5
> >> + *
> >> + * Function to release ZynqMP R5 device.
> >> + */
> >> +static void zynqmp_r5_release(struct device *dev) {
> >> +    struct zynqmp_r5_pdata *pdata;
> >> +    struct rproc *rproc;
> >> +    struct sk_buff *skb;
> >> +
> >> +    pdata =3D dev_get_drvdata(dev);
> >> +    rproc =3D pdata->rproc;
> >> +    if (rproc) {
> >> +            rproc_del(rproc);
> >> +            rproc_free(rproc);
> >> +    }
> >> +    if (pdata->tx_chan)
> >> +            mbox_free_channel(pdata->tx_chan);
> >> +    if (pdata->rx_chan)
> >> +            mbox_free_channel(pdata->rx_chan);
> >> +    /* Discard all SKBs */
> >> +    while (!skb_queue_empty(&pdata->tx_mc_skbs)) {
> >> +            skb =3D skb_dequeue(&pdata->tx_mc_skbs);
> >> +            kfree_skb(skb);
> >> +    }
> >> +
> >> +    put_device(dev->parent);
> >> +}
> >> +
> >> +/**
> >> + * event_notified_idr_cb() - event notified idr callback
> >> + * @id: idr id
> >> + * @ptr: pointer to idr private data
> >> + * @data: data passed to idr_for_each callback
> >> + *
> >> + * Pass notification to remoteproc virtio
> >> + *
> >> + * Return: 0. having return is to satisfy the idr_for_each() function
> >> + *          pointer input argument requirement.
> >> + **/
> >> +static int event_notified_idr_cb(int id, void *ptr, void *data) {
> >> +    struct rproc *rproc =3D data;
> >> +
> >> +    (void)rproc_vq_interrupt(rproc, id);
> >> +    return 0;
> >> +}
> >> +
> >> +/**
> >> + * handle_event_notified() - remoteproc notification work funciton
> >> + * @work: pointer to the work structure
> >> + *
> >> + * It checks each registered remoteproc notify IDs.
> >> + */
> >> +static void handle_event_notified(struct work_struct *work) {
> >> +    struct rproc *rproc;
> >> +    struct zynqmp_r5_pdata *pdata;
> >> +
> >> +    pdata =3D container_of(work, struct zynqmp_r5_pdata, mbox_work);
> >> +
> >> +    (void)mbox_send_message(pdata->rx_chan, NULL);
> >> +    rproc =3D pdata->rproc;
> >> +    /*
> >> +     * We only use IPI for interrupt. The firmware side may or may
> >> +     * not write the notifyid when it trigger IPI.
> >> +     * And thus, we scan through all the registered notifyids.
> >> +     */
> >> +    idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc); }
> >> +
> >> +/**
> >> + * zynqmp_r5_mb_rx_cb() - Receive channel mailbox callback
> >> + * @cl: mailbox client
> >> + * @mssg: message pointer
> >> + *
> >> + * It will schedule the R5 notification work.
> >> + */
> >> +static void zynqmp_r5_mb_rx_cb(struct mbox_client *cl, void *mssg) {
> >> +    struct zynqmp_r5_pdata *pdata;
> >> +
> >> +    pdata =3D container_of(cl, struct zynqmp_r5_pdata, rx_mc);
> >> +    if (mssg) {
> >> +            struct zynqmp_ipi_message *ipi_msg, *buf_msg;
> >> +            size_t len;
> >> +
> >> +            ipi_msg =3D (struct zynqmp_ipi_message *)mssg;
> >> +            buf_msg =3D (struct zynqmp_ipi_message *)pdata->rx_mc_buf=
;
> >> +            len =3D (ipi_msg->len >=3D IPI_BUF_LEN_MAX) ?
> >> +                  IPI_BUF_LEN_MAX : ipi_msg->len;
> >> +            buf_msg->len =3D len;
> >> +            memcpy(buf_msg->data, ipi_msg->data, len);
> >> +    }
> >> +    schedule_work(&pdata->mbox_work);
> >> +}
> >> +
> >> +/**
> >> + * zynqmp_r5_mb_tx_done() - Request has been sent to the remote
> >> + * @cl: mailbox client
> >> + * @mssg: pointer to the message which has been sent
> >> + * @r: status of last TX - OK or error
> >> + *
> >> + * It will be called by the mailbox framework when the last TX has do=
ne.
> >> + */
> >> +static void zynqmp_r5_mb_tx_done(struct mbox_client *cl, void *mssg,
> >> +int r) {
> >> +    struct zynqmp_r5_pdata *pdata;
> >> +    struct sk_buff *skb;
> >> +
> >> +    if (!mssg)
> >> +            return;
> >> +    pdata =3D container_of(cl, struct zynqmp_r5_pdata, tx_mc);
> >> +    skb =3D skb_dequeue(&pdata->tx_mc_skbs);
> >> +    kfree_skb(skb);
> >> +}
> >> +
> >> +/**
> >> + * zynqmp_r5_setup_mbox() - Setup mailboxes
> >> + *
> >> + * @pdata: pointer to the ZynqMP R5 processor platform data
> >> + * @node: pointer of the device node
> >> + *
> >> + * Function to setup mailboxes to talk to RPU.
> >> + *
> >> + * Return: 0 for success, negative value for failure.
> >> + */
> >> +static int zynqmp_r5_setup_mbox(struct zynqmp_r5_pdata *pdata,
> >> +                            struct device_node *node)
> >> +{
> >> +    struct device *dev =3D &pdata->dev;
> >> +    struct mbox_client *mclient;
> >> +
> >> +    /* Setup TX mailbox channel client */
> >> +    mclient =3D &pdata->tx_mc;
> >> +    mclient->dev =3D dev;
> >> +    mclient->rx_callback =3D NULL;
> >> +    mclient->tx_block =3D false;
> >> +    mclient->knows_txdone =3D false;
> >> +    mclient->tx_done =3D zynqmp_r5_mb_tx_done;
> >> +
> >> +    /* Setup TX mailbox channel client */
> >> +    mclient =3D &pdata->rx_mc;
> >> +    mclient->dev =3D dev;
> >> +    mclient->rx_callback =3D zynqmp_r5_mb_rx_cb;
> >> +    mclient->tx_block =3D false;
> >> +    mclient->knows_txdone =3D false;
> >> +
> >> +    INIT_WORK(&pdata->mbox_work, handle_event_notified);
> >> +
> >> +    /* Request TX and RX channels */
> >> +    pdata->tx_chan =3D mbox_request_channel_byname(&pdata->tx_mc, "tx=
");
> >> +    if (IS_ERR(pdata->tx_chan)) {
> >> +            dev_err(dev, "failed to request mbox tx channel.\n");
> >> +            pdata->tx_chan =3D NULL;
> >> +            return -EINVAL;
> >> +    }
> >> +    pdata->rx_chan =3D mbox_request_channel_byname(&pdata->rx_mc, "rx=
");
> >> +    if (IS_ERR(pdata->rx_chan)) {
> >> +            dev_err(dev, "failed to request mbox rx channel.\n");
> >> +            pdata->rx_chan =3D NULL;
> >> +            return -EINVAL;
> >> +    }
> >> +    skb_queue_head_init(&pdata->tx_mc_skbs);
> >> +    return 0;
> >> +}
> >> +
> >> +/**
> >> + * zynqmp_r5_probe() - Probes ZynqMP R5 processor device node
> >> + * @pdata: pointer to the ZynqMP R5 processor platform data
> >> + * @pdev: parent RPU domain platform device
> >> + * @node: pointer of the device node
> >> + *
> >> + * Function to retrieve the information of the ZynqMP R5 device node.
> >> + *
> >> + * Return: 0 for success, negative value for failure.
> >> + */
> >> +static int zynqmp_r5_probe(struct zynqmp_r5_pdata *pdata,
> >> +                       struct platform_device *pdev,
> >> +                       struct device_node *node)
> >> +{
> >> +    struct device *dev =3D &pdata->dev;
> >> +    struct rproc *rproc;
> >> +    struct device_node *nc;
> >> +    int ret;
> >> +
> >> +    /* Create device for ZynqMP R5 device */
> >> +    dev->parent =3D &pdev->dev;
> >> +    dev->release =3D zynqmp_r5_release;
> >> +    dev->of_node =3D node;
> >> +    dev_set_name(dev, "%s", of_node_full_name(node));
> >> +    dev_set_drvdata(dev, pdata);
> >> +    ret =3D device_register(dev);
> >> +    if (ret) {
> >> +            dev_err(dev, "failed to register device.\n");
> >> +            return ret;
> >> +    }
> >> +    get_device(&pdev->dev);
> >> +
> >> +    /* Allocate remoteproc instance */
> >> +    rproc =3D rproc_alloc(dev, dev_name(dev), &zynqmp_r5_rproc_ops, N=
ULL, 0);
> >> +    if (!rproc) {
> >> +            dev_err(dev, "rproc allocation failed.\n");
> >> +            ret =3D -ENOMEM;
> >> +            goto error;
> >> +    }
> >> +    rproc->auto_boot =3D autoboot;
> >> +    pdata->rproc =3D rproc;
> >> +    rproc->priv =3D pdata;
> >> +
> >> +    /*
> >> +     * The device has not been spawned from a device tree, so
> >> +     * arch_setup_dma_ops has not been called, thus leaving
> >> +     * the device with dummy DMA ops.
> >> +     * Fix this by inheriting the parent's DMA ops and mask.
> >> +     */
> >> +    rproc->dev.dma_mask =3D pdev->dev.dma_mask;
> >> +    set_dma_ops(&rproc->dev, get_dma_ops(&pdev->dev));
> >> +
> >> +    /* Probe R5 memory devices */
> >> +    INIT_LIST_HEAD(&pdata->mems);
> >> +    for_each_available_child_of_node(node, nc) {
> >> +            ret =3D zynqmp_r5_mem_probe(pdata, nc);
> >> +            if (ret) {
> >> +                    dev_err(dev, "failed to probe memory %s.\n",
> >> +                            of_node_full_name(nc));
> >> +                    goto error;
> >> +            }
> >> +    }
> >> +
> >> +    /* Set up DMA mask */
> >> +    ret =3D dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> >> +    if (ret) {
> >> +            dev_warn(dev, "dma_set_coherent_mask failed: %d\n", ret);
> >> +            /* If DMA is not configured yet, try to configure it. */
> >> +            ret =3D of_dma_configure(dev, node, true);
> >> +            if (ret) {
> >> +                    dev_err(dev, "failed to configure DMA.\n");
> >> +                    goto error;
> >> +            }
> >> +    }
> >> +
> >> +    /* Get R5 power domain node */
> >> +    ret =3D of_property_read_u32(node, "pnode-id", &pdata->pnode_id);
> >> +    if (ret) {
> >> +            dev_err(dev, "failed to get power node id.\n");
> >> +            goto error;
> >> +    }
> >> +
> >> +    /* Check if R5 is running */
> >> +    if (r5_is_running(pdata)) {
> >> +            atomic_inc(&rproc->power);
> >> +            rproc->state =3D RPROC_RUNNING;
> >> +    }
> >
> > How does this work when state_store() returns an error if rproc->state
> > =3D=3D RPROC_RUNNING?  As such the remote processor is running but ther=
e
> > is no way to attach to it.  As I requested during my previous review,
> > please hold off on supporting scenarios where the remote processor is
> > already running when the driver is probe.  We are working on introducin=
g that in the remoteproc core.
> [Ben Levinsky] Will do. Ok I will leave it as a FIXME for now
> >
> >> +
> >> +    if (!of_get_property(dev->of_node, "mboxes", NULL)) {
> >> +            dev_dbg(dev, "no mailboxes.\n");
> >> +            goto error;
> >> +    } else {
> >> +            ret =3D zynqmp_r5_setup_mbox(pdata, node);
> >> +            if (ret < 0)
> >> +                    goto error;
> >> +    }
> >> +
> >> +    /* Add R5 remoteproc */
> >> +    ret =3D rproc_add(rproc);
> >> +    if (ret) {
> >> +            dev_err(dev, "rproc registration failed\n");
> >> +            goto error;
> >> +    }
> >> +    return 0;
> >> +error:
> >> +    if (pdata->rproc)
> >> +            rproc_free(pdata->rproc);
> >> +    pdata->rproc =3D NULL;
> >> +    device_unregister(dev);
> >> +    put_device(&pdev->dev);
> >> +    return ret;
> >> +}
> >> +
> >> +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
> >> +{
> >> +    const unsigned char *prop;
> >> +    int ret, i;
> >> +    struct device *dev =3D &pdev->dev;
> >> +    struct device_node *nc;
> >> +    struct zynqmp_r5_pdata *pdata;
> >> +
> >> +    pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> >> +    if (!pdata)
> >> +            return -ENOMEM;
> >> +    platform_set_drvdata(pdev, pdata);
> >> +
> >> +    prop =3D of_get_property(dev->of_node, "core_conf", NULL);
> >> +    if (!prop) {
> >> +            dev_err(&pdev->dev, "core_conf is not used.\n");
> >> +            return -EINVAL;
> >> +    }
> >
> > This should be the same as what Texas Instrument is doing, i.e:
> >          lockstep-mode =3D <1>
> >
> > That way:
> >
> > 1) The wheel is not re-invented.
> > 2) An 'enum rpu_oper_mode' can be used directly.
> > 3) No need for string comparison.
>
> So, for my next version, I am planning to change this "lockstep-mode" to =
a ti,cluster-mode property (still an enum/integer). We have a new SoC famil=
y coming up wherein we are supporting a unique mode called "Single CPU" mod=
e which is not the same as LockStep, and I will be finding the current "loc=
kstep-mode" property limiting there.
>
> [Ben Levinsky] will do, this will be in the revision.

Thanks for the heads-up Suman.  Ben, based on the above it is probably
best to introduce a "qcomm,cluster-mode" property.


> regards
> Suman
>
> >
> >> +
> >> +    dev_dbg(dev, "RPU core_conf: %s\n", prop);
> >> +    if (!strcmp(prop, "split")) {
> >> +            rpu_mode =3D PM_RPU_MODE_SPLIT;
> >> +    } else if (!strcmp(prop, "lockstep")) {
> >> +            rpu_mode =3D PM_RPU_MODE_LOCKSTEP;
> >> +    } else {
> >> +            dev_err(dev,
> >> +                    "Invalid core_conf mode provided - %s , %d\n",
> >> +                    prop, (int)rpu_mode);
> >> +            return -EINVAL;
> >> +    }
> >> +
> >> +    i =3D 0;
> >
> > This can be done when the variable is declared above.
> >
> >> +    for_each_available_child_of_node(dev->of_node, nc) {
> >> +            ret =3D zynqmp_r5_probe(&rpus[i], pdev, nc);
> >> +            if (ret) {
> >> +                    dev_err(dev, "failed to probe rpu %s.\n",
> >> +                            of_node_full_name(nc));
> >> +                    return ret;
> >> +            }
> >> +            i++;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int zynqmp_r5_remoteproc_remove(struct platform_device *pdev)
> >> +{
> >> +    int i;
> >> +
> >> +    for (i =3D 0; i < MAX_RPROCS; i++) {
> >> +            struct zynqmp_r5_pdata *pdata =3D &rpus[i];
> >> +            struct rproc *rproc;
> >> +
> >> +            rproc =3D pdata->rproc;
> >> +            if (rproc) {
> >> +                    rproc_del(rproc);
> >> +                    rproc_free(rproc);
> >> +                    pdata->rproc =3D NULL;
> >> +            }
> >> +            if (pdata->tx_chan) {
> >> +                    mbox_free_channel(pdata->tx_chan);
> >> +                    pdata->tx_chan =3D NULL;
> >> +            }
> >> +            if (pdata->rx_chan) {
> >> +                    mbox_free_channel(pdata->rx_chan);
> >> +                    pdata->rx_chan =3D NULL;
> >> +            }
> >> +
> >> +            device_unregister(&pdata->dev);
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +/* Match table for OF platform binding */ static const struct
> >> +of_device_id zynqmp_r5_remoteproc_match[] =3D {
> >> +    { .compatible =3D "xlnx,zynqmp-r5-remoteproc-1.0", },
> >> +    { /* end of list */ },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> >> +
> >> +static struct platform_driver zynqmp_r5_remoteproc_driver =3D {
> >> +    .probe =3D zynqmp_r5_remoteproc_probe,
> >> +    .remove =3D zynqmp_r5_remoteproc_remove,
> >> +    .driver =3D {
> >> +            .name =3D "zynqmp_r5_remoteproc",
> >> +            .of_match_table =3D zynqmp_r5_remoteproc_match,
> >> +    },
> >> +};
> >> +module_platform_driver(zynqmp_r5_remoteproc_driver);
> >> +
> >> +module_param_named(autoboot,  autoboot, bool, 0444);
> >> +MODULE_PARM_DESC(autoboot,
> >> +             "enable | disable autoboot. (default: true)");
> >> +
> >> +MODULE_AUTHOR("Ben Levinsky <ben.levinsky@xilinx.com>");
> >> +MODULE_LICENSE("GPL v2"); MODULE_DESCRIPTION("ZynqMP R5 remote
> >> +processor control driver");
> >> --
> >> 2.7.4
> >>
>
