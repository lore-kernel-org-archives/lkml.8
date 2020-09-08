Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739E8C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 22:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC942087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 22:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSN+wQH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgIHWDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 18:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbgIHWDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 18:03:14 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAE2C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 15:03:13 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r9so1059050ioa.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 15:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3YZ4mxqC1B1fpYJx5/A80nChWYlGFJ6FMnFE/tdR77c=;
        b=dSN+wQH6pQkVUtD7IleigQD6Y7p2Fhm99vlc4vY1j6U9UwK43eU6AXO6yRzuqZoT/g
         vaZ7N90fmDWjY15Ny3ab0/npdgvPoy0rLOzIWYU5fsHnrN3OriMOzcmv+S1RRBZ8a0rm
         VPB50/hfexoe0aVE5AdiQLSFYPpmziMksMwmbG4Vjlfwij3FM+OBVPESGNYqdhg8U/o4
         YyEWX4XNpS2NkuNkbHvi+qj8/bwIddZOje929OnzBYtm9qhVYMWewJqKY/auw0tc2Qqj
         7oBX1L1fiMR+srKpmzyssRcq/OY8ueKE3QCpDSJKvZClMspOZGRUa1ZTMNbBx2HParFE
         6C9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YZ4mxqC1B1fpYJx5/A80nChWYlGFJ6FMnFE/tdR77c=;
        b=V20ZU7JZzQvrhK6bivRkkxYFhpp1aVP2felOzadgu8CZ26zV21rkGe40+9HrZhR4cn
         CmGh6aowrCmUEoLSC4PI4F5iuzDUszdzNfKFiVGUFGXo+ZIrAoNM54aPcrjkZJZPXeIg
         hZ/3jlmnhFQP+LAaYZCjDZyzi1+E9gIU3wQaKxhthq87wUQUj1jZ1597pBosycHg6klp
         cvbKJ+rL+oSg0KhHNufCxViXG2j0B7bO83CG8uS14stDOWnwfFbEKyuRrV6K29FnIvLI
         COykLjQMzmG6t5iG6WFZJTgF9dzGW4/FcWDrP88hkAFwqN/z+aahACJ/DV1k7T7oAVfC
         QKpA==
X-Gm-Message-State: AOAM533VFP/K8lWBOPHXumo36kr+E4UmqjBnLqEUL+SHEyHq+Fsbj+hS
        XMrQU7rWX6UsAlru4GF5G8LFaMtuH0+bfaNCzYqCxQ==
X-Google-Smtp-Source: ABdhPJyjczNCUkEcHJt9laTZ7R4VlYbrUfQfx95d6122ZiMbs4a2V6lAbQHAPOl1mqF/sKwo1Pe/hTjS3xoE7baV+7k=
X-Received: by 2002:a6b:4f13:: with SMTP id d19mr889359iob.90.1599602592468;
 Tue, 08 Sep 2020 15:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200825164907.3642-1-arnaud.pouliquen@st.com>
 <20200825164907.3642-6-arnaud.pouliquen@st.com> <20200903230009.GD333030@xps15>
 <9f62520b-63b2-b3e5-feff-58142e92de2a@st.com>
In-Reply-To: <9f62520b-63b2-b3e5-feff-58142e92de2a@st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 8 Sep 2020 16:03:01 -0600
Message-ID: <CANLsYkwVubYCM2fdvCc3tC6mu_26d7gBYQVC7uT7eoNocvro4w@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] rpmsg: introduce reserved rpmsg driver for ns announcement
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020 at 02:28, Arnaud POULIQUEN <arnaud.pouliquen@st.com> wrote:
>
> Hi Mathieu,
>
> On 9/4/20 1:00 AM, Mathieu Poirier wrote:
> > On Tue, Aug 25, 2020 at 06:49:04PM +0200, Arnaud Pouliquen wrote:
> >> The name service announcement should not be linked to the RPMsg virtio bus
> >> but to the RPMsg protocol itself.
> >>
> >> This patch proposes to break the dependency with the RPmsg virtio bus by
> >> the introduction of the reserved RPMsg name service driver which will be in
> >> charge of managing the RPMsg name service announcement.
> >>
> >> This first patch only implements the probe and the RPMsg endpoint to
> >> manage create and release channels remote requests.
> >>
> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> >> ---
> >>  drivers/rpmsg/Kconfig          |   8 ++
> >>  drivers/rpmsg/Makefile         |   1 +
> >>  drivers/rpmsg/rpmsg_internal.h |  17 +++++
> >>  drivers/rpmsg/rpmsg_ns.c       | 135 +++++++++++++++++++++++++++++++++
> >>  4 files changed, 161 insertions(+)
> >>  create mode 100644 drivers/rpmsg/rpmsg_ns.c
> >>
> >> diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
> >> index f96716893c2a..c3fc75e6514b 100644
> >> --- a/drivers/rpmsg/Kconfig
> >> +++ b/drivers/rpmsg/Kconfig
> >> @@ -15,6 +15,14 @@ config RPMSG_CHAR
> >>        in /dev. They make it possible for user-space programs to send and
> >>        receive rpmsg packets.
> >>
> >> +config RPMSG_NS
> >> +    tristate "RPMSG name service announcement"
> >> +    depends on RPMSG
> >> +    help
> >> +      Say Y here to enable the support of the name service announcement
> >> +      channel that probes the associated RPMsg device on remote endpoint
> >> +      service announcement.
> >> +
> >>  config RPMSG_MTK_SCP
> >>      tristate "MediaTek SCP"
> >>      depends on MTK_SCP
> >> diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
> >> index ffe932ef6050..8d452656f0ee 100644
> >> --- a/drivers/rpmsg/Makefile
> >> +++ b/drivers/rpmsg/Makefile
> >> @@ -1,6 +1,7 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >>  obj-$(CONFIG_RPMSG)         += rpmsg_core.o
> >>  obj-$(CONFIG_RPMSG_CHAR)    += rpmsg_char.o
> >> +obj-$(CONFIG_RPMSG_NS)              += rpmsg_ns.o
> >>  obj-$(CONFIG_RPMSG_MTK_SCP) += mtk_rpmsg.o
> >>  qcom_glink-objs                     := qcom_glink_native.o qcom_glink_ssr.o
> >>  obj-$(CONFIG_RPMSG_QCOM_GLINK) += qcom_glink.o
> >> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> >> index d5ab286d0e5e..641b48f6bf2a 100644
> >> --- a/drivers/rpmsg/rpmsg_internal.h
> >> +++ b/drivers/rpmsg/rpmsg_internal.h
> >> @@ -102,4 +102,21 @@ static inline int rpmsg_chrdev_register_device(struct rpmsg_device *rpdev)
> >>      return rpmsg_register_device(rpdev);
> >>  }
> >>
> >> +/**
> >> + * rpmsg_ns_register_device() - register name service device based on rpdev
> >> + * @rpdev: prepared rpdev to be used for creating endpoints
> >> + *
> >> + * This function wraps rpmsg_register_device() preparing the rpdev for use as
> >> + * basis for the rpmsg name service device.
> >> + */
> >> +static inline int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
> >> +{
> >> +    strcpy(rpdev->id.name, "rpmsg_ns");
> >> +    rpdev->driver_override = "rpmsg_ns";
> >> +    rpdev->src = RPMSG_NS_ADDR;
> >> +    rpdev->dst = RPMSG_NS_ADDR;
> >> +
> >> +    return rpmsg_register_device(rpdev);
> >> +}
> >> +
> >>  #endif
> >> diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
> >> new file mode 100644
> >> index 000000000000..3c929b6976a6
> >> --- /dev/null
> >> +++ b/drivers/rpmsg/rpmsg_ns.c
> >> @@ -0,0 +1,135 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) STMicroelectronics 2020 - All Rights Reserved
> >> + */
> >> +#include <linux/device.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/slab.h>
> >> +#include "rpmsg_internal.h"
> >> +
> >> +/**
> >> + * enum rpmsg_ns_flags - dynamic name service announcement flags
> >> + *
> >> + * @RPMSG_NS_CREATE: a new remote service was just created
> >> + * @RPMSG_NS_DESTROY: a known remote service was just destroyed
> >> + */
> >> +enum rpmsg_ns_flags {
> >> +    RPMSG_NS_CREATE         = 0,
> >> +    RPMSG_NS_DESTROY        = 1,
> >> +};
> >> +
> >> +/**
> >> + * struct rpmsg_ns_msg - dynamic name service announcement message
> >> + * @name: name of remote service that is published
> >> + * @addr: address of remote service that is published
> >> + * @flags: indicates whether service is created or destroyed
> >> + *
> >> + * This message is sent across to publish a new service, or announce
> >> + * about its removal. When we receive these messages, an appropriate
> >> + * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
> >> + * or ->remove() handler of the appropriate rpmsg driver will be invoked
> >> + * (if/as-soon-as one is registered).
> >> + */
> >> +struct rpmsg_ns_msg {
> >> +    char name[RPMSG_NAME_SIZE];
> >> +    __le32 addr;
> >> +    __le32 flags;
> >
> > This is about to get moved to a header file [1] so that the virtualisation people
> > can use the same structures.  As such we can't just assume their type is __le32
> > and we can't move them here either.  I suggest to move this to
> > include/linux/rpmsg/virtio.h as Guennadi did.
> >
> > [1]. https://patchwork.kernel.org/patch/11749285/
>
> The objective of this patch is to treat the ns annoucement as a service so it should not
> depend on the virtio.

I agree that name service announcement and virtio are disjoint and
should remain as such.  That being said I would like to avoid the
proliferation of "struct rpmsg_ns_msg" in the kernel.  I am convinced
we can find a middle ground that can work for everyone.

> From my POV we have to separate the header from the payload in term of endianness.
>
> That make sense that the rpmsg_hdr is virtio struct dependent. But the rpmsg_ns_msg
> describes the payload message. The payload message should be fixed by the service itself
> and should not depend on the virualization.
> Here i proposed to fix the payload in little endian for compatibility with the legacy.
> But we also could decide to not fixe the endianess.

I think the only way forward is to take the time to really understand
how the rpmsg_ns_msg is used in [1].  I will do that tomorrow
(Wednesday) or Thursday and I suggest you do the same at one point.

>
> >
> >> +} __packed;
> >> +
> >> +/* Invoked when a name service announcement arrives */
> >> +static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
> >> +                   void *priv, u32 src)
> >> +{
> >> +    struct rpmsg_ns_msg *msg = data;
> >> +    struct rpmsg_device *newch;
> >> +    struct rpmsg_channel_info chinfo;
> >> +    struct device *dev = &rpdev->dev;
> >> +    unsigned int flags = le32_to_cpu(msg->flags);
> >
> > I've been staring at this for a long time and I suspect you did too.
> >
> > Can we assume that a name service is running on a virtio implementation?  It
> > certainly has been the case so far, and doing so would make this patchset a lot
> > more simple.  Otherwise we need to find a way to make this work without
> > losing flexibility, which will make things more complex.
> >
> > What do you think?
>
> I am not sure to understand your point...
> I'm also intertesting in understanding more in details what do you have in mind in term of
> "losing flexibility"?
>

I was referring to the format of the rpmsg_ns_msg and the transport
layer, i.e virtio, Glink or otherwise.

> The purpose of this patchset is to generalize the ns announcement so that it does
> not depend on the implementation. The goal is to avoid that implementations
> rewrite the service.
>
> The vhost patchset is an exemple which is also virtio based. But there are some other
> implementations (exemples below).
>
> Anyway I think the main question associated to this patchset is:
> Is the ns annoucement is a RPMsg service or a virtio RPMsg service?
>
> From my point of view it should be a RPMsg service, that is enbled or
> not, depending on the backend implementation.

I agree.

As I said above I don't think we can move forward with this set and
[1] until we understand how name space services are used in the vhost
driver.  That will help us define the rpmsg_ns_msg structure and how
to handle it in a generic way.  Otherwise I think the rest of this set
works.

I will get back to you once I have gone through [1].

Thanks,
Mathieu

>
> 2 other ns annoucement service exemples:
> - the mtk_rpmsg driver[1].
> - In ST we have a PoC to extend the rpmsg over a physical serial link [2]. Notice that, with
>   this implementation we can have the LE-BE inter-communication use case.
>   For this PoC we also defined a common file that does not depend on the virtio[3], so
>   an alternative to what Guennadi did in include/linux/rpmsg/virtio.h.
>
> [1]https://elixir.bootlin.com/linux/v5.9-rc3/source/drivers/rpmsg/mtk_rpmsg.c#L45
> [2]https://github.com/arnopo/linux/blob/ELCE_demos/drivers/rpmsg/uart_rpmsg_bus.c
> [3]https://github.com/arnopo/linux/blob/ELCE_demos/drivers/rpmsg/rpmsg_bus_common.c
>
> Thanks,
> Arnaud
>
> >
> >> +    int ret;
> >> +
> >> +#if defined(CONFIG_DYNAMIC_DEBUG)
> >> +    dynamic_hex_dump("NS announcement: ", DUMP_PREFIX_NONE, 16, 1,
> >> +                     data, len, true);
> >> +#endif
> >> +
> >> +    if (len != sizeof(*msg)) {
> >> +            dev_err(dev, "malformed ns msg (%d)\n", len);
> >> +            return -EINVAL;
> >> +    }
> >> +
> >> +    /* Don't trust the remote processor for null terminating the name */
> >> +    msg->name[RPMSG_NAME_SIZE - 1] = '\0';
> >> +
> >> +    strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
> >> +    chinfo.src = RPMSG_ADDR_ANY;
> >> +    chinfo.dst = le32_to_cpu(msg->addr);
> >> +
> >> +    dev_info(dev, "%sing channel %s addr 0x%x\n",
> >> +             (flags & RPMSG_NS_DESTROY) ? "destroy" : "creat",
> >> +             msg->name, chinfo.dst);
> >> +
> >> +    if (flags & RPMSG_NS_DESTROY) {
> >> +            ret = rpmsg_release_channel(rpdev, &chinfo);
> >> +            if (ret)
> >> +                    dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
> >> +    } else {
> >> +            newch = rpmsg_create_channel(rpdev, &chinfo);
> >> +            if (!newch)
> >> +                    dev_err(dev, "rpmsg_create_channel failed\n");
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int rpmsg_ns_probe(struct rpmsg_device *rpdev)
> >> +{
> >> +    struct rpmsg_channel_info ns_chinfo;
> >> +    struct rpmsg_endpoint *ns_ept;
> >> +
> >> +    ns_chinfo.src = RPMSG_NS_ADDR;
> >> +    ns_chinfo.dst = RPMSG_NS_ADDR;
> >> +    strcpy(ns_chinfo.name, "name_service");
> >> +
> >> +    /*
> >> +     * Create the NS announcement service endpoint associated to the RPMsg
> >> +     * device. The endpoint will be automatically destroyed when the RPMsg
> >> +     * device will be deleted.
> >> +     */
> >> +    ns_ept = rpmsg_create_ept(rpdev, rpmsg_ns_cb, NULL, ns_chinfo);
> >> +    if (!ns_ept) {
> >> +            dev_err(&rpdev->dev, "failed to create the ns ept\n");
> >> +            return -ENOMEM;
> >> +    }
> >> +    rpdev->ept = ns_ept;
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static struct rpmsg_driver rpmsg_ns_driver = {
> >> +    .drv.name = "rpmsg_ns",
> >> +    .probe = rpmsg_ns_probe,
> >> +};
> >> +
> >> +static int rpmsg_ns_init(void)
> >> +{
> >> +    int ret;
> >> +
> >> +    ret = register_rpmsg_driver(&rpmsg_ns_driver);
> >> +    if (ret < 0)
> >> +            pr_err("%s: Failed to register rpmsg driver\n", __func__);
> >> +
> >> +    return ret;
> >> +}
> >> +postcore_initcall(rpmsg_ns_init);
> >> +
> >> +static void rpmsg_ns_exit(void)
> >> +{
> >> +    unregister_rpmsg_driver(&rpmsg_ns_driver);
> >> +}
> >> +module_exit(rpmsg_ns_exit);
> >> +
> >> +MODULE_DESCRIPTION("Name service announcement rpmsg Driver");
> >> +MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
> >> +MODULE_ALIAS("rpmsg_ns");
> >> +MODULE_LICENSE("GPL v2");
> >> --
> >> 2.17.1
> >>
