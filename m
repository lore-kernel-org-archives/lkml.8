Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A751C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E223120702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 15:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgGLP2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 11:28:40 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:49181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgGLP2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 11:28:39 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mhl0I-1kYOZf3rJw-00dljv for <linux-kernel@vger.kernel.org>; Sun, 12 Jul
 2020 17:28:36 +0200
Received: by mail-qt1-f170.google.com with SMTP id u12so8130853qth.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 08:28:35 -0700 (PDT)
X-Gm-Message-State: AOAM5328YwtAPfsIPoC5hNNy3zOrD7Z3vBv4XBkQPwmLF9cxvHOYZ6es
        Sdi8e+Uo4IrPTXE0H2tuqHJAoISi8gh5a8FGf10=
X-Google-Smtp-Source: ABdhPJwzFklmr0AOJ9DYIP8t7JtSFYNJqtAMh1HyvEMLVLDdiAXiLqFXp6MI9bF4ZnHhdoRuPaRfPhT04+2Mw/Gkpxk=
X-Received: by 2002:ac8:2b98:: with SMTP id m24mr80555183qtm.7.1594567714697;
 Sun, 12 Jul 2020 08:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200712134331.8169-1-gage.eads@intel.com> <20200712134331.8169-5-gage.eads@intel.com>
In-Reply-To: <20200712134331.8169-5-gage.eads@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 12 Jul 2020 17:28:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2OmSPGNghM+Y9ThH7hgKJKVSKRPaSPN17gUVRUh_o3bQ@mail.gmail.com>
Message-ID: <CAK8P3a2OmSPGNghM+Y9ThH7hgKJKVSKRPaSPN17gUVRUh_o3bQ@mail.gmail.com>
Subject: Re: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
To:     Gage Eads <gage.eads@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>, magnus.karlsson@intel.com,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:LGijz2mj/Ugi8JB22j2Bol92RTZ9zEMLqlFbCjuaxvnGIlkUYgk
 o1Nnh4amctmabfn+AcNnQuxoip4omOuDVg7Z73U1BBSfWX7KtpIq8tINQpsVZho9HSwHFzt
 435xDkRe3tDqO8ZTHWsPvk7qEZJloiGBJ3HDa1ys+OQ0TQi/iHupQvtkDr+n/kbqre6giIl
 hUMKUuVvMUcqi1MRes9+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NuZ7yUoxqs8=:/lFFlyiMPMbO1hDHTC7cJJ
 fOZRvFmST1AQP1SRai2QbGEz0/cW8fSKTjQkuY4lfwQZNVTsf52La0unryMNj+xBGwOXZo2q/
 Z6XmQJdDZJV34mjMwVfc4aRKhN+Ero7Gwq/PyRmbNggdPj9JU/Lh91B+RpXieTsQOlWEjHqTW
 APYqiG8qOOE51ZCeP1YQl704KMohFd0nQuPHrn/nM3ib52Lz+tuwzjIoh8v8/371KJA5ACiuU
 Cyv1nu3Dj700F8zkHnlPZmn9y8P1B3BsDzwu7w/bKtCqNBNzbAZs3fLKj44OhDryzP6mWfA7K
 EkRZFPLO0GDStBmu0HcBytnF837CutKsVwnPD3ZEgk5s4Wlhu0e2OrphVTFiIoHYE2RQ6w1R9
 J8Jl18HfT128LEvLcdslh2m2ARoVZZDU+Eeypiyj1BL4nlNHPKtxaD3UJAzT2d/u6pzQyxPvo
 pSKwKuUz8AZNvqn36c8NcPnMlDpljjHdBGZ/n3Pnzc8pQgSm2LUb64wqPd7aWvRQbyP8oqEJD
 J1n7XPK16PaHAIKAkl2mQ3lqHzA3+E6cddSLZDuQdd4gGEhZU5oK7U7y0Es16yAC/ZXW2D2Uf
 HVUF9sDBydVvECC/Ww4xYd1cWtYc4xZQMJj+NJjksH0k1wGmYgYkjV5XO/jNT3pMqafG0vx/S
 iVCsnIJlp9rLcww5VQvhR52oyVmYDS5YBCdStsI0axrFRGxscUFRd4ejkaAblFGWiTI2VmgLo
 ntP6w0SXUeO7+OHXruVr8EfF1+2ScEFaW1Z9xnuSSROTLmWjuzSkYcW5tDL2CL3915S8J17xw
 LOk8TseoM79baXO56AKbnWI0Z8WmUrMOnNfYHCYuLlZsMMz/SOW68a8uUYif2XA5E3xfnrr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 3:46 PM Gage Eads <gage.eads@intel.com> wrote:
>
> This commit introduces the dlb2 device ioctl layer, and the first four
> ioctls: query device version, driver version, and available resources; and
> create a scheduling domain. This commit also introduces the user-space
> interface file dlb2_user.h.
>
> The PF hardware operation for scheduling domain creation will be added in a
> subsequent commit.
>
> Signed-off-by: Gage Eads <gage.eads@intel.com>
> Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>

I'm looking only at the ioctl interface here, as that is usually the
hardest part to get right, and you can't easily change it after it gets
merged.

The definitions all look portable and will work fine in compat mode
(which is often a problem), but you have added a bit of complexity
compared to how it is commonly done, so it's better to simplify it
and write it more like other drivers do. More on that below.

> +/* Verify the ioctl argument size and copy the argument into kernel memory */
> +static int dlb2_copy_from_user(struct dlb2_dev *dev,
> +                              unsigned long user_arg,
> +                              u16 user_size,
> +                              void *arg,
> +                              size_t size)
> +{
> +       if (user_size != size) {
> +               dev_err(dev->dlb2_device,
> +                       "[%s()] Invalid ioctl size\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       if (copy_from_user(arg, (void __user *)user_arg, size)) {
> +               dev_err(dev->dlb2_device,
> +                       "[%s()] Invalid ioctl argument pointer\n", __func__);
> +               return -EFAULT;
> +       }
> +
> +       return 0;
> +}

You should avoid error messages that are triggered based on user input.
and can cause a denial-of-service when the console is spammed that
way.

A plain copy_from_user() in place of this function should be fine.

> +/* [7:0]: device revision, [15:8]: device version */
> +#define DLB2_SET_DEVICE_VERSION(ver, rev) (((ver) << 8) | (rev))
> +
> +static int dlb2_ioctl_get_device_version(struct dlb2_dev *dev,
> +                                        unsigned long user_arg,
> +                                        u16 size)
> +{
> +       struct dlb2_get_device_version_args arg;
> +       struct dlb2_cmd_response response;
> +       int ret;
> +
> +       dev_dbg(dev->dlb2_device, "Entering %s()\n", __func__);
> +
> +       response.status = 0;
> +       response.id = DLB2_SET_DEVICE_VERSION(2, DLB2_REV_A0);
> +
> +       ret = dlb2_copy_from_user(dev, user_arg, size, &arg, sizeof(arg));
> +       if (ret)
> +               return ret;
> +
> +       ret = dlb2_copy_resp_to_user(dev, arg.response, &response);

Better avoid any indirect pointers. As you always return a constant
here, I think the entire ioctl command can be removed until you
actually need it. If you have an ioctl command that needs both
input and output, use _IOWR() to define it and put all arguments
into the same structure.

> +static int dlb2_ioctl_create_sched_domain(struct dlb2_dev *dev,
> +                                         unsigned long user_arg,
> +                                         u16 size)
> +{
> +       struct dlb2_create_sched_domain_args arg;
> +       struct dlb2_cmd_response response = {0};
> +       int ret;
> +
> +       dev_dbg(dev->dlb2_device, "Entering %s()\n", __func__);

I assume you have finished debugging this version and can remove
these debug comments again. If you find new bugs, you can add them
temporarily, but nothing is gained by these here. You can use ftrace
to see when functions are called.

> +
> +       ret = dlb2_copy_from_user(dev, user_arg, size, &arg, sizeof(arg));
> +       if (ret)
> +               return ret;
> +
> +       /* Copy zeroes to verify the user-provided response pointer */
> +       ret = dlb2_copy_resp_to_user(dev, arg.response, &response);
> +       if (ret)
> +               return ret;

There is no need to verify the response pointer. If it fails later,
it's the user's fault, and they get to deal with it.

> +static int dlb2_ioctl_get_driver_version(struct dlb2_dev *dev,
> +                                        unsigned long user_arg,
> +                                        u16 size)
> +{
> +       struct dlb2_get_driver_version_args arg;
> +       struct dlb2_cmd_response response;
> +       int ret;
> +
> +       dev_dbg(dev->dlb2_device, "Entering %s()\n", __func__);
> +
> +       response.status = 0;
> +       response.id = DLB2_VERSION;

Just remove the driver version command, trying to have explicit
interface versions creates more problems than it solves.

> +int dlb2_ioctl_dispatcher(struct dlb2_dev *dev,
> +                         unsigned int cmd,
> +                         unsigned long arg)
> +{
> +       u16 sz = _IOC_SIZE(cmd);
> +
> +       if (_IOC_NR(cmd) >= NUM_DLB2_CMD) {
> +               dev_err(dev->dlb2_device,
> +                       "[%s()] Unexpected DLB command %d\n",
> +                       __func__, _IOC_NR(cmd));
> +               return -1;
> +       }
> +
> +       return dlb2_ioctl_callback_fns[_IOC_NR(cmd)](dev, arg, sz);
> +}

This is usually written with a switch/case statement, so doing the same here
tends to make it easier to understand.

> +static long
> +dlb2_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
> +{
> +       struct dlb2_dev *dev;
> +
> +       dev = container_of(f->f_inode->i_cdev, struct dlb2_dev, cdev);
> +
> +       if (_IOC_TYPE(cmd) != DLB2_IOC_MAGIC) {
> +               dev_err(dev->dlb2_device,
> +                       "[%s()] Bad magic number!\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       return dlb2_ioctl_dispatcher(dev, cmd, arg);
> +}

This function can also be removed then, just call the dispatcher
directly.
>         int err;
>
> -       pr_info("%s\n", dlb2_driver_name);
> +       pr_info("%s - version %d.%d.%d\n", dlb2_driver_name,
> +               DLB2_VERSION_MAJOR_NUMBER,
> +               DLB2_VERSION_MINOR_NUMBER,
> +               DLB2_VERSION_REVISION_NUMBER);
>         pr_info("%s\n", dlb2_driver_copyright);

Just remove the pr_info completely.

      Arnd
