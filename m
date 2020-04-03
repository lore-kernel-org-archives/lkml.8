Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14F6C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE7C20719
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9y0KOJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgDCUaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:30:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39701 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCUaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:30:46 -0400
Received: by mail-io1-f68.google.com with SMTP id c16so8984397iod.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 13:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zik9NrCxAhGPE/lFsh624bVzZ+6DmxMdz0dsT27Kvv8=;
        b=q9y0KOJ5ENlNPLWMhG7SaQVI10HNpx94qBO0mUwW/9M8WvuKG+24bQSGu4cyyz6iSs
         nifLww6ifF1gLpmHsRz8iaZyC8Dw4HrMAdu9Gz53D7SW5pOpQOu2/bM1SDuyHfdMoUUV
         33wLvdjyfnMChPLnSleiiav6sn4O1wXbv88YhHLE6YqA4342StVVb41h1cPHLYUcee0S
         kg5kzrzlQMgI+et7BJ2tC9usx1wXax1i25f91teEtxbdJNLB5x5+psBc2XyaWfMc8aOc
         nJ4pKoiQAwkhJPv5NF/uZ2Wo26el9tNmwHaN0R5GjmGx98WPcWJGqQqV5yUCDk8Ryanm
         QSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zik9NrCxAhGPE/lFsh624bVzZ+6DmxMdz0dsT27Kvv8=;
        b=aDAsQDUQ6xGGw9MgT+lj8dmP0ZF2E/+EKWtVVcK6/qholEKJYyu3Xfi5spMEM7hjQV
         BG7R+sIj2nDZyOyUcUzv0fZr9DP4VONukaBcQew9Rp/vfm2RUgULG+ppSm09kQlvSVoD
         BG4xa167k2V+JBuXz37sLgEDHH/oKBL7ReWRH7Upe9ttklgalezbnJrxPTRRpvJwEoZi
         nxq0xXTxf5sPuTZN8+v4eXMuq0C3Z5zx2fjajRgg7v0mUPRrt2qjnW6NP8DlmkoIn3i8
         mqIlBCri8t9NoxuSVybfimQaXRMs91Jh1e0JEQf5eQbAo8jknAe7owHtS5U/BBbaB9Uj
         nRKA==
X-Gm-Message-State: AGi0Pua3LguIZNkFEJtMXjrKKz/4Kfy/dVRETba9oI/Uk1GgMEmy6HgH
        se2jue5ih9l8fvU7oKKKyTD6geOv4FA7cdNxwPTMGw==
X-Google-Smtp-Source: APiQypLqRZBF1zR/0UOAX4YKl21MpCqrk2G9ANvjPA36Oh7n7qZ0l2V/KB6KKSA0Tsw80mnF6YnfFANBuYqMEwVMVdM=
X-Received: by 2002:a05:6638:186:: with SMTP id a6mr9842874jaq.36.1585945844000;
 Fri, 03 Apr 2020 13:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <1585699438-14394-1-git-send-email-rishabhb@codeaurora.org> <5b1c8287-0077-87e7-9364-b1f5a104c9e3@st.com>
In-Reply-To: <5b1c8287-0077-87e7-9364-b1f5a104c9e3@st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 3 Apr 2020 14:30:33 -0600
Message-ID: <CANLsYky1AR7FHBK9gCxsTLp2LBFc2h_RJCR_4mqqYPhAgnufNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] remoteproc: Add character device interface
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        Siddharth Gupta <sidgup@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Apr 2020 at 11:28, Arnaud POULIQUEN <arnaud.pouliquen@st.com> wrote:
>
> Hi
>
> On 4/1/20 2:03 AM, Rishabh Bhatnagar wrote:
> > Add the character device interface for userspace applications.
> > This interface can be used in order to boot up and shutdown
> > remote subsystems. Currently there is only a sysfs interface
> > which the userspace clients can use. If a usersapce application
> > crashes after booting the remote processor does not get any
> > indication about the crash. It might still assume that the
> > application is running. For example modem uses remotefs service
> > to fetch data from disk/flash memory. If the remotefs service
> > crashes, modem keeps on requesting data which might lead to a
> > crash. Adding a character device interface makes the remote
> > processor tightly coupled with the user space application.
> > A crash of the application leads to a close on the file descriptors
> > therefore shutting down the remoteproc.
>
> Sorry I'm late in the discussion, I hope I've gone through the whole
> discussion so I don't reopen a closed point...
>
> Something here is not crystal clear to me so I'd rather share it...
>
> I suppose that you the automatic restart of the application is not possible to
> stop and restart the remote processor...
>
> Why this use case can not be solved by a process monitor or a service
> in userland that detects the application crash and stop the remote firmware using
> the sysfs interface?

I also looked for a better way to do things...  The conclusion I came
to is that it may take too long between the application crash and the
monitoring service to stop the firmware via sysfs.

>
> I just want to be sure that there is no alternative to this, because having two ways
> for application to shutdown the firmware seems to me confusing...
>
> What about the opposite service, mean inform the application that the remote
> processor is crashed?

Also a valid point - the problem with asynchronous notification
schemes is the possibility to get out of sync.  I would also like to
find a better way...

> Do you identify such need? or the "auto" crash recovery is sufficient?
>
> Thanks,
> Arnaud
> >
> > Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> > ---
> >  drivers/remoteproc/Kconfig               |   9 +++
> >  drivers/remoteproc/Makefile              |   1 +
> >  drivers/remoteproc/remoteproc_cdev.c     | 100 +++++++++++++++++++++++++++++++
> >  drivers/remoteproc/remoteproc_internal.h |  22 +++++++
> >  include/linux/remoteproc.h               |   2 +
> >  5 files changed, 134 insertions(+)
> >  create mode 100644 drivers/remoteproc/remoteproc_cdev.c
> >
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index de3862c..6374b79 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -14,6 +14,15 @@ config REMOTEPROC
> >
> >  if REMOTEPROC
> >
> > +config REMOTEPROC_CDEV
> > +     bool "Remoteproc character device interface"
> > +     help
> > +       Say y here to have a character device interface for Remoteproc
> > +       framework. Userspace can boot/shutdown remote processors through
> > +       this interface.
> > +
> > +       It's safe to say N if you don't want to use this interface.
> > +
> >  config IMX_REMOTEPROC
> >       tristate "IMX6/7 remoteproc support"
> >       depends on ARCH_MXC
> > diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> > index e30a1b1..b7d4f77 100644
> > --- a/drivers/remoteproc/Makefile
> > +++ b/drivers/remoteproc/Makefile
> > @@ -9,6 +9,7 @@ remoteproc-y                          += remoteproc_debugfs.o
> >  remoteproc-y                         += remoteproc_sysfs.o
> >  remoteproc-y                         += remoteproc_virtio.o
> >  remoteproc-y                         += remoteproc_elf_loader.o
> > +obj-$(CONFIG_REMOTEPROC_CDEV)                += remoteproc_cdev.o
> >  obj-$(CONFIG_IMX_REMOTEPROC)         += imx_rproc.o
> >  obj-$(CONFIG_MTK_SCP)                        += mtk_scp.o mtk_scp_ipi.o
> >  obj-$(CONFIG_OMAP_REMOTEPROC)                += omap_remoteproc.o
> > diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
> > new file mode 100644
> > index 0000000..8182bd1
> > --- /dev/null
> > +++ b/drivers/remoteproc/remoteproc_cdev.c
> > @@ -0,0 +1,100 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Character device interface driver for Remoteproc framework.
> > + *
> > + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#include <linux/cdev.h>
> > +#include <linux/fs.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/remoteproc.h>
> > +
> > +#include "remoteproc_internal.h"
> > +
> > +#define NUM_RPROC_DEVICES    64
> > +static dev_t rproc_cdev;
> > +static DEFINE_IDA(cdev_minor_ida);
> > +
> > +static int rproc_cdev_open(struct inode *inode, struct file *file)
> > +{
> > +     struct rproc *rproc;
> > +
> > +     rproc = container_of(inode->i_cdev, struct rproc, char_dev);
> > +
> > +     if (!rproc)
> > +             return -EINVAL;
> > +
> > +     if (rproc->state == RPROC_RUNNING)
> > +             return -EBUSY;
> > +
> > +     return rproc_boot(rproc);
> > +}
> > +
> > +static int rproc_cdev_release(struct inode *inode, struct file *file)
> > +{
> > +     struct rproc *rproc;
> > +
> > +     rproc = container_of(inode->i_cdev, struct rproc, char_dev);
> > +
> > +     if (!rproc || rproc->state != RPROC_RUNNING)
> > +             return -EINVAL;
> > +
> > +     rproc_shutdown(rproc);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct file_operations rproc_fops = {
> > +     .open = rproc_cdev_open,
> > +     .release = rproc_cdev_release,
> > +};
> > +
> > +int rproc_char_device_add(struct rproc *rproc)
> > +{
> > +     int ret, minor;
> > +     dev_t cdevt;
> > +
> > +     minor = ida_simple_get(&cdev_minor_ida, 0, NUM_RPROC_DEVICES,
> > +                            GFP_KERNEL);
> > +     if (minor < 0) {
> > +             dev_err(&rproc->dev, "%s: No more minor numbers left! rc:%d\n",
> > +                     __func__, minor);
> > +             return -ENODEV;
> > +     }
> > +
> > +     cdev_init(&rproc->char_dev, &rproc_fops);
> > +     rproc->char_dev.owner = THIS_MODULE;
> > +
> > +     cdevt = MKDEV(MAJOR(rproc_cdev), minor);
> > +     ret = cdev_add(&rproc->char_dev, cdevt, 1);
> > +     if (ret < 0)
> > +             ida_simple_remove(&cdev_minor_ida, minor);
> > +
> > +     rproc->dev.devt = cdevt;
> > +     return ret;
> > +}
> > +
> > +void rproc_char_device_remove(struct rproc *rproc)
> > +{
> > +     __unregister_chrdev(MAJOR(rproc->dev.devt), MINOR(rproc->dev.devt), 1,
> > +                         "rproc");
> > +     ida_simple_remove(&cdev_minor_ida, MINOR(rproc->dev.devt));
> > +}
> > +
> > +void __init rproc_init_cdev(void)
> > +{
> > +     int ret;
> > +
> > +     ret = alloc_chrdev_region(&rproc_cdev, 0, NUM_RPROC_DEVICES, "rproc");
> > +     if (ret < 0) {
> > +             pr_err("Failed to alloc rproc_cdev region, err %d\n", ret);
> > +             return;
> > +     }
> > +}
> > +
> > +void __exit rproc_exit_cdev(void)
> > +{
> > +     __unregister_chrdev(MAJOR(rproc_cdev), 0, NUM_RPROC_DEVICES, "rproc");
> > +}
> > diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> > index 493ef92..28d61a1 100644
> > --- a/drivers/remoteproc/remoteproc_internal.h
> > +++ b/drivers/remoteproc/remoteproc_internal.h
> > @@ -47,6 +47,27 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
> >  int rproc_init_sysfs(void);
> >  void rproc_exit_sysfs(void);
> >
> > +#ifdef CONFIG_REMOTEPROC_CDEV
> > +void rproc_init_cdev(void);
> > +void rproc_exit_cdev(void);
> > +int rproc_char_device_add(struct rproc *rproc);
> > +void rproc_char_device_remove(struct rproc *rproc);
> > +#else
> > +static inline void rproc_init_cdev(void)
> > +{
> > +}
> > +static inline void rproc_exit_cdev(void)
> > +{
> > +}
> > +static inline int rproc_char_device_add(struct rproc *rproc)
> > +{
> > +     return 0;
> > +}
> > +static inline void  rproc_char_device_remove(struct rproc *rproc)
> > +{
> > +}
> > +#endif
> > +
> >  void rproc_free_vring(struct rproc_vring *rvring);
> >  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
> >
> > @@ -63,6 +84,7 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
> >  struct rproc_mem_entry *
> >  rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
> >
> > +
> >  static inline
> >  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
> >  {
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index 16ad666..c4ca796 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -37,6 +37,7 @@
> >
> >  #include <linux/types.h>
> >  #include <linux/mutex.h>
> > +#include <linux/cdev.h>
> >  #include <linux/virtio.h>
> >  #include <linux/completion.h>
> >  #include <linux/idr.h>
> > @@ -514,6 +515,7 @@ struct rproc {
> >       bool auto_boot;
> >       struct list_head dump_segments;
> >       int nb_vdev;
> > +     struct cdev char_dev;
> >  };
> >
> >  /**
> >
