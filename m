Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509B5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1973120786
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brEmphkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHYOhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgHYOgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:36:52 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0942BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:36:52 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id r13so10600539iln.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQfc64bfuEyKpEEZAon+9n12ebrxd7vsPrxt68G6qCs=;
        b=brEmphkcX8M5Y3aoiqVxQGM2cL5+ACrlG62QDtresXZNE0D4xo+zRpXwY4hESFaGNU
         cVPI6oBnYRsJNLbs/lCNdV2er8j4/tMmmPACdxvbRECv13QXC9oAXtFRs0fhQDhlfNFi
         +6/fpBbHOdiMxBjqfG3k4wdIm/0ZcGd1+xbxzsq7cD1RCE51HqhNRucgmNXoVgoOWpRS
         GSnMr5wQApymyy57IXwVWcBdKJ3LssM1EsIWYWL9bNuhXIQv/+ovjHFScLbpuCRnCoZE
         zBtP4+zMtkndMidmKyIFY31lGu+njT+ht952+pz1zoSshg+SUiD5meM9V6m0sZvOCvJ4
         bR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQfc64bfuEyKpEEZAon+9n12ebrxd7vsPrxt68G6qCs=;
        b=ExV41rPX9xYfSkFaL6nfDZsgHfYoR/+Tr9HnBP0+QKGuRAfGSdxDH/lFYSljshKBNh
         sl/9h5RAnNzcB118C2gS1HTuBD681QUzOxJM5cHPIuWpFEZrnP87vZJa3ThnLFPFWpv2
         SQNm4V8xKowOLWBi0RLjDH83sV0ZzjT7yb9dSQF4l6RgwPM+HH0G34aTEPvLv6iYcxWf
         TxqCohdJm4zTuoPM3oukvUVmWDwF0Ks/I7yRahm6KK47lq1bN2WvatFO5WF+4hpiBtuH
         MYa1KCTBNAFp0mUIBC1afcwcvt4iA36mpnhJNJOVA9gkJFVQg1YGFj9AFT/V4FatnrCq
         +Rnw==
X-Gm-Message-State: AOAM532HkcMZ+DiljXRzCABRSuRuqh8XJYhjiVgpJ0s4zlSdlnaXMpLd
        8RWfW5dGZ2A8vFbqG798eimTPL9pv+pAvXwzVgRz5g==
X-Google-Smtp-Source: ABdhPJwX2ABTm79iSgzUob9tSIrQGxSO1sP7btXExFocazya01XxMEPu9YSKaq0/0R1EJn360Qp9/ZlJ3KW/qvTcCdw=
X-Received: by 2002:a92:5a05:: with SMTP id o5mr8829828ilb.58.1598366211164;
 Tue, 25 Aug 2020 07:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200731114732.12815-1-arnaud.pouliquen@st.com>
 <20200731114732.12815-6-arnaud.pouliquen@st.com> <20200824224736.GD3938186@xps15>
 <cbb145da-95ea-9f10-98e5-2618294996d6@st.com>
In-Reply-To: <cbb145da-95ea-9f10-98e5-2618294996d6@st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 25 Aug 2020 08:36:40 -0600
Message-ID: <CANLsYkybyfayh7aKd75=omjJk76MuyZJ0N1=5-O76YmFjYVaFQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] rpmsg: introduce reserved rpmsg driver for ns announcement
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

On Tue, 25 Aug 2020 at 05:57, Arnaud POULIQUEN <arnaud.pouliquen@st.com> wrote:
>
> Hi Mathieu
>
> Thanks for the review! please find few comments below.
>
> On 8/25/20 12:47 AM, Mathieu Poirier wrote:
> > On Fri, Jul 31, 2020 at 01:47:28PM +0200, Arnaud Pouliquen wrote:
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
> >> index f96716893c2a..140faa975ea1 100644
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
> >> +      channel that probes the associate RPMsg device on remote endpoint
> >
> > s/associate/associated
> >
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
> >> index 000000000000..fe7713e737c2
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
> >> +    u32 addr;
> >> +    u32 flags;
> >> +} __packed;
> >> +
> >> +/* invoked when a name service announcement arrives */
> >> +static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
> >> +                   void *priv, u32 src)
> >> +{
> >> +    struct rpmsg_ns_msg *msg = data;
> >> +    struct rpmsg_device *newch;
> >> +    struct rpmsg_channel_info chinfo;
> >> +    struct device *dev = &rpdev->dev;
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
> >> +    /* don't trust the remote processor for null terminating the name */
> >> +    msg->name[RPMSG_NAME_SIZE - 1] = '\0';
> >> +
> >> +    strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
> >> +    chinfo.src = RPMSG_ADDR_ANY;
> >> +    chinfo.dst = msg->addr;
> >> +
> >> +    dev_info(dev, "%sing channel %s addr 0x%x\n",
> >> +             msg->flags & RPMSG_NS_DESTROY ? "destroy" : "creat",
> >> +             msg->name, msg->addr);
> >> +
> >> +    if (msg->flags & RPMSG_NS_DESTROY) {
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
> >> +     * create and attach the endpoint to the rpmsg device that it would be
> >> +     * destroy when the rpmsg device will be deleted
> >> +     */
> >
> > This comment doesn't work, please revise.
>
> Could you clarify what does not work, from your POV?
> in view of your comment, it seems I should at least rephrase it...
> proposal:
>         /*
>          * Create the NS service endpoint associated to the rpmsg device.
>          * The endpoint will be automatically destroyed when the rpmsg device
>          * will be deleted.
>          */

Yes, now it is perfectly clear - thanks for revisiting.

>
> >
> >> +    ns_ept = rpmsg_create_ept(rpdev, rpmsg_ns_cb, NULL, ns_chinfo);
> >> +    if (!ns_ept) {
> >> +            dev_err(&rpdev->dev, "failed to create the ns ept\n");
> >> +            return -ENOMEM;
> >> +    }
> >> +    rpdev->ept = ns_ept;
> >> +
> >> +    rpdev->src = RPMSG_NS_ADDR;
> >
> > I think this is already done in rpmsg_ns_register_device().
>
> You are right!
>
> thanks,
> Arnaud
> >
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
