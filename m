Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1691C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26C12073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zylhITGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgD3Qof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726530AbgD3Qof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:44:35 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FDBC035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:44:35 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k6so2182736iob.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPuetDFJcq9HvjlMhNT0YbDsWPBwCbasSZMzgUgJBVQ=;
        b=zylhITGZVrMFbgViOis33MHfBooJC0Q9gLP4TKQe+fp/+6QodVe3YN6Y+OHgvFFwt8
         UKyCh3mC5xWi4aPwsfvKD5EVConXtI1VhozE/S/kVIC5YFB1+6TH3D08gcvCQXLRLMom
         Fdx/HfGhnHAbxB47EvYNEUaepFk+GodOIcKTtrvoC/LFYzbboLqzO+iYmlWHERLCQ96L
         mE3CVO1pVCnM3yV3ZVGlqldQjCHLS6dghAdQgWLjUN9Ozya0yi95qATQUi16F18B+u5w
         e3UB3YgFFEa7pliRxBXo/EiTJG87IjaefuDe0jRrZTFXq5qQiMKQzcmdWN6xpChnuTzq
         TnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPuetDFJcq9HvjlMhNT0YbDsWPBwCbasSZMzgUgJBVQ=;
        b=NCqrbCqrT6BAHWozIZksQ0Poho8rWFULBxDiSz2RsvLIfTxUO7nDyDC7SN5dWRZeVD
         lmsd3s8Qrpj3ZZMW8G/GYIELfEGVEtlkax15sSvGJBd/7mAO5cRGMSzvqsB7OAHhY9YT
         /AHCF9IIILxX0Wk6uqF2mB82iVcu85gVpL/sA3MOC3JvpxIbhYOuovDnqY1blpVFUMNy
         Cr39mrQ3pzqSo04+E6YupouraFWnJJBLlQh6pGvOTPTA9TtFWuxcLEUBsFcI1CheiS9A
         K43FiMhooW1g2gCjjAQZbIdfzIkjCYFjXyC9HlUC7wn2hUhDbSFmIFSJE1jPInnbZD2s
         5gmQ==
X-Gm-Message-State: AGi0Puay2etRS3+vzD8+yeAdYmDloWQvSpcHcyof5zdHlyI017R/rboe
        F3hAoYN/ybR7JW/sCi99P1cz2fQo7ky0M8Skapk8Kw==
X-Google-Smtp-Source: APiQypILJ13oVEnGElyLSboCnjVTyI1ZKnRCTMPt4WnCIpZScmmUBdC8dpCC24gOV0jRJeq4vpa7JDwdHR8e3BzTBBU=
X-Received: by 2002:a02:90cd:: with SMTP id c13mr2638228jag.83.1588265073791;
 Thu, 30 Apr 2020 09:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <1587492618-15896-1-git-send-email-rishabhb@codeaurora.org>
 <1587492618-15896-2-git-send-email-rishabhb@codeaurora.org> <d72ead5a-b25a-d4e2-4bbf-1790d2a64fb8@st.com>
In-Reply-To: <d72ead5a-b25a-d4e2-4bbf-1790d2a64fb8@st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 30 Apr 2020 10:44:22 -0600
Message-ID: <CANLsYkzqHoQ+pMp2Bj++JAsXwY+DjChvJX11Y6KG8wg9PtDNbw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] remoteproc: Add remoteproc character device interface
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, tsoni <tsoni@codeaurora.org>,
        psodagud <psodagud@codeaurora.org>,
        Siddharth Gupta <sidgup@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 at 02:30, Arnaud POULIQUEN <arnaud.pouliquen@st.com> wrote:
>
> Hi Rishabh,
>
>
> On 4/21/20 8:10 PM, Rishabh Bhatnagar wrote:
> > Add the character device interface into remoteproc framework.
> > This interface can be used in order to boot/shutdown remote
> > subsystems and provides a basic ioctl based interface to implement
> > supplementary functionality. An ioctl call is implemented to enable
> > the shutdown on release feature which will allow remote processors to
> > be shutdown when the controlling userpsace application crashes or hangs.
> >
>
> Thanks for intruducing Ioctl, this will help for future evolutions.
>
> > Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> > ---
> >  Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
> >  drivers/remoteproc/Kconfig                         |   9 ++
> >  drivers/remoteproc/Makefile                        |   1 +
> >  drivers/remoteproc/remoteproc_cdev.c               | 143 +++++++++++++++++++++
> >  drivers/remoteproc/remoteproc_internal.h           |  21 +++
> >  include/linux/remoteproc.h                         |   3 +
> >  include/uapi/linux/remoteproc_cdev.h               |  20 +++
> >  7 files changed, 198 insertions(+)
> >  create mode 100644 drivers/remoteproc/remoteproc_cdev.c
> >  create mode 100644 include/uapi/linux/remoteproc_cdev.h
> >
> > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > index 2e91370..412b2a0 100644
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -337,6 +337,7 @@ Code  Seq#    Include File                                           Comments
> >  0xB4  00-0F  linux/gpio.h                                            <mailto:linux-gpio@vger.kernel.org>
> >  0xB5  00-0F  uapi/linux/rpmsg.h                                      <mailto:linux-remoteproc@vger.kernel.org>
> >  0xB6  all    linux/fpga-dfl.h
> > +0xB7  all    uapi/linux/remoteproc_cdev.h                         <mailto:linux-remoteproc@vger.kernel.org>
> >  0xC0  00-0F  linux/usb/iowarrior.h
> >  0xCA  00-0F  uapi/misc/cxl.h
> >  0xCA  10-2F  uapi/misc/ocxl.h
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
> > index 0000000..65142ec
> > --- /dev/null
> > +++ b/drivers/remoteproc/remoteproc_cdev.c
> > @@ -0,0 +1,143 @@
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
> > +#include <uapi/linux/remoteproc_cdev.h>
> > +#include <linux/uaccess.h>
> > +
> > +#include "remoteproc_internal.h"
> > +
> > +#define NUM_RPROC_DEVICES    64
> > +static dev_t rproc_major;
> > +
> > +static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf,
> > +                              size_t len, loff_t *pos)
> > +{
> > +     struct rproc *rproc = container_of(filp->f_inode->i_cdev,
> > +                                        struct rproc, char_dev);
> > +     int ret = 0;
> > +     char cmd[10];
> > +
> > +     if (!len || len > sizeof(cmd))
> > +             return -EINVAL;
> > +
> > +     ret = copy_from_user(cmd, buf, sizeof(cmd));
> > +     if (ret)
> > +             return -EFAULT;
> > +
> > +     if (sysfs_streq(cmd, "start")) {
> > +             if (rproc->state == RPROC_RUNNING)
> > +                     return -EBUSY;
> > +
> > +             ret = rproc_boot(rproc);
> > +             if (ret)
> > +                     dev_err(&rproc->dev, "Boot failed:%d\n", ret);
> > +     } else if (sysfs_streq(cmd, "stop")) {
> > +             if (rproc->state == RPROC_OFFLINE)
> > +                     return -ENXIO;
>
> returning ENXIO in this case seems to me no appropriate , what about EPERM or
> EINVAL (rproc_sysfs) ?
>
> > +
> > +             rproc_shutdown(rproc);
> > +     } else {
> > +             dev_err(&rproc->dev, "Unrecognized option\n");
> > +             ret = -EINVAL;
> > +     }
> > +
> > +     return ret ? ret : len;
> > +}
> > +
> > +static long rproc_device_ioctl(struct file *filp, unsigned int ioctl,
> > +                             unsigned long arg)
> > +{
> > +     struct rproc *rproc = container_of(filp->f_inode->i_cdev,
> > +                                        struct rproc, char_dev);
> > +     void __user *argp = (void __user *)arg;
> > +     int ret;
> > +     bool param;
> > +
> > +     switch (ioctl) {
> > +     case RPROC_SET_SHUTDOWN_ON_RELEASE:
> > +             ret = copy_from_user(&param, argp, sizeof(bool));
> > +             if (ret) {
> > +                     dev_err(&rproc->dev, "Data copy from userspace failed\n");
> > +                     return -EINVAL;
> > +             }
> > +             rproc->cdev_put_on_release = param;
>
> argp is an void value, where cdev_put_on_release is a bool a check or a conversion  seems
> missing
>
> > +             break;
> > +     case RPROC_GET_SHUTDOWN_ON_RELEASE:
> > +             ret = copy_to_user(argp, &rproc->cdev_put_on_release,
> > +                                sizeof(bool));
> > +             if (ret) {
> > +                     dev_err(&rproc->dev, "Data copy to userspace failed\n");
> > +                     return -EINVAL;
> > +             }
> > +             break;
> > +     default:
> > +             dev_err(&rproc->dev, "Unsupported ioctl\n");
> > +             return -EINVAL;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int rproc_cdev_release(struct inode *inode, struct file *filp)
> > +{
> > +     struct rproc *rproc = container_of(inode->i_cdev, struct rproc,
> > +                                        char_dev);
> > +
> > +     if (rproc->cdev_put_on_release && rproc->state != RPROC_OFFLINE)
> > +             rproc_shutdown(rproc);
> > +
> > +     return 0;
> > +}
> > +
> > +
> > +static const struct file_operations rproc_fops = {
> > +     .write = rproc_cdev_write,
> > +     .unlocked_ioctl = rproc_device_ioctl,
> > +     .release = rproc_cdev_release,
> > +};
> > +
> > +int rproc_char_device_add(struct rproc *rproc)
> > +{
> > +     int ret;
> > +     dev_t cdevt;
> > +
> > +     cdev_init(&rproc->char_dev, &rproc_fops);
> > +     rproc->char_dev.owner = THIS_MODULE;
> > +
> > +     cdevt = MKDEV(MAJOR(rproc_major), rproc->index);
> > +     ret = cdev_add(&rproc->char_dev, cdevt, 1);
> > +     if (ret < 0)
> > +             goto out;
> > +
> > +     rproc->dev.devt = cdevt;
> > +out:
> > +     return ret;
> > +}
> > +
> > +void rproc_char_device_remove(struct rproc *rproc)
> > +{
> > +     __unregister_chrdev(MAJOR(rproc->dev.devt), rproc->index, 1, "rproc");
> > +}
> > +
> > +void __init rproc_init_cdev(void)
> > +{
> > +     int ret;
> > +
> > +     ret = alloc_chrdev_region(&rproc_major, 0, NUM_RPROC_DEVICES, "rproc");
>
> "remoteproc"instead of "rproc" (in line with sysfs and debugfs naming) .
>
> > +     if (ret < 0)
> > +             pr_err("Failed to alloc rproc_cdev region, err %d\n", ret);
> > +}
> > +
> > +void __exit rproc_exit_cdev(void)
> > +{
> > +     unregister_chrdev_region(MKDEV(MAJOR(rproc_major), 0),
> > +                              NUM_RPROC_DEVICES);
> > +}
> > diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> > index 493ef92..fb9d891 100644
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
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index 16ad666..9bd2ff5 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -40,6 +40,7 @@
> >  #include <linux/virtio.h>
> >  #include <linux/completion.h>
> >  #include <linux/idr.h>
> > +#include <linux/cdev.h>
> >  #include <linux/of.h>
> >
> >  /**
> > @@ -514,6 +515,8 @@ struct rproc {
> >       bool auto_boot;
> >       struct list_head dump_segments;
> >       int nb_vdev;
> > +     struct cdev char_dev;
> > +     bool cdev_put_on_release;
> >  };
>
> These parameters are local variables of rproc_cdev. Could be defined in a separate structure.
> with a pointer in rproc to this structure.

I think structure @char_dev is just one more core member of rproc - to
me the real problem is with @cdev_put_on_release.  It is yet another
option that has an effect on the processing done on the remote
processor.  Other 'bool' types like has_iommu, auto_boot and
recovery_disabled are additional examples.  No matter how much we are
careful at limiting their proliferation it is clear to me the current
way of declaring bool types every time we need a new option does not
scale.

I have been thinking about introducing a new u32 field called
"options" and assigning each of the current (and future) boolean flags
a bitfield.  Individual options would be set with an exported
function, something like rproc_set_option(RPROC_OPTION_AUTO_BOOT).
That way users never directly manipulate the bitfields and it gives us
the opportunity to change how options are managed in the future if we
need to.

I will be sending a patchset for this feature in the coming days so
that we can discuss the best way to deal with flags.

Thanks,
Mathieu

>
> >
> >  /**
> > diff --git a/include/uapi/linux/remoteproc_cdev.h b/include/uapi/linux/remoteproc_cdev.h
> > new file mode 100644
> > index 0000000..3975120
> > --- /dev/null
> > +++ b/include/uapi/linux/remoteproc_cdev.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> > +/*
> > + * IOCTLs for Remoteproc's character device interface.
> > + *
> > + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +
> > +#ifndef _UAPI_REMOTEPROC_CDEV_H_
> > +#define _UAPI_REMOTEPROC_CDEV_H_
> > +
> > +#include <linux/ioctl.h>
> > +#include <linux/types.h>
> > +
> > +#define RPROC_MAGIC  0xB7
> > +
> > +#define RPROC_SET_SHUTDOWN_ON_RELEASE _IOW(RPROC_MAGIC, 1, int)
> > +#define RPROC_GET_SHUTDOWN_ON_RELEASE _IOR(RPROC_MAGIC, 2, int)
> > +
> > +#endif
> >
> IOCTLs should probaly be documented.
>
> Thanks,
> Arnaud
