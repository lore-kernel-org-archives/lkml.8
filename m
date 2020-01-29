Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E179C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63416207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 14:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgA2ObR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:31:17 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:33501 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgA2ObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 09:31:17 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M4roN-1iyB9Q06Wl-00232v for <linux-kernel@vger.kernel.org>; Wed, 29 Jan
 2020 15:31:15 +0100
Received: by mail-qt1-f175.google.com with SMTP id w47so13345834qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 06:31:14 -0800 (PST)
X-Gm-Message-State: APjAAAVLUfDEhHpxx311cqRUBqc63HWhKM8g2mrZ10pPuuG+oE/CK+e5
        TvvC6eqNlPjVu5/h3YSN8XWq7oQt2s0SqoOkxdY=
X-Google-Smtp-Source: APXvYqyAUPRTN/4PzvPi5NueZDdmGdAafYBIacuzV4RqMoCyPeL4BrXrRFatMmY/bm62fbzhnzIPFlOzCWlcdR5pSJA=
X-Received: by 2002:ac8:768d:: with SMTP id g13mr27089460qtr.7.1580308273837;
 Wed, 29 Jan 2020 06:31:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580299067.git.vitor.soares@synopsys.com> <442a0c2c52223f9ff1a1d1018ff863fb23105389.1580299067.git.vitor.soares@synopsys.com>
In-Reply-To: <442a0c2c52223f9ff1a1d1018ff863fb23105389.1580299067.git.vitor.soares@synopsys.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Jan 2020 15:30:56 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0uFjhuO7e-i3r_RiA_ni=S8MfYoZUwZzmbXRcd=+kMKw@mail.gmail.com>
Message-ID: <CAK8P3a0uFjhuO7e-i3r_RiA_ni=S8MfYoZUwZzmbXRcd=+kMKw@mail.gmail.com>
Subject: Re: [RFC v2 4/4] i3c: add i3cdev module to expose i3c dev in /dev
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-i3c@lists.infradead.org,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jmHxeMen6QQN8wi+Mr7c8dMCGeHhwf2Vm5e4ABPCq8PJHV/IlxB
 2hgeQEVtSHTkdnIQgtGlnD+gSokB2l5oZc1x+r8/W7qO512h1jy8oU/a5jvcq1cVnqVtfda
 BFPMmAvnrcKL/MU5nbXx73V3Y28I9tcUuC1lleK6oOh5pnQrNHwxF8yjGXoSaw8emIPyBpK
 z2Q1jJwMeXOY+B3zYHDPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RPye+uCDh2w=:XI23s1WbcVhcX/KEqWx143
 LAriGWbZ2eRCEQUj8KpazsUR31kcwBMJk77XwQ2yCPct8FPbLCcuuI9D4aAJ2C9K/WteBP/QA
 2PXuf0mIJ2fTLNfsCNoKp7dGQdK5AxoX5MQZGFpONsX/CAmNczVptW+nW9pf4tM2/OI3x4Nrl
 yTKO4HzsgzgFMLrVC+fzwIbKZ+wcXCcwEfGuc833qrYj3wG7cCEKodAg6orcUlUazbZgBqK0P
 XZRe9BBORj5fWML5Fw//5Svoe5m/Xpht2eqGjUS2v8PVBrQe1p/EW3MTQ1xnuFksNKD43qOVO
 9qfGh9iE/ai1m8YNpVLYYLZlQ7xXONGS12Ei7zMg5QoP1yfRgEUH1LjFsl3a5PSzHAitPkqMX
 3cflMWiLdaEgqMhaBr5iV88qIxL2/fXneBjJSdHge9fXDPhS+kA4f4927HvQPVkmlZSMoAhrc
 YTS3B1k7UfV2bWCbQjPWTDu+hJSiwoicADtK3yBnJFDL3m2NSTaGrYej1RogRpNruBWAWRN8u
 1C89FiZgzq3Em2WgyKC5eG4d2rV35MHosGyxOkQTHH10AUmjIqwoej5if77BT7iHY5dWHT8+N
 mIevnpCBUJ2ImUeIhTotY7iuv96fdK8jBs/WFGbYSkY0mLTxtIwLHLqoRIMnApX3Y9hY9ahNd
 r1hYMdeR6khjWAaOXAhmyF+xOmDVyZ18+VFy0Qpid9JG5EZIutNjVT8WQ66K6PL10kSXztvYA
 1MvrBmHENnxlXun2+HxCtAsDmjtINW/REsUMKitkQyna0TxdX0+XEEzyaeMDsVkOAXfdYYbex
 SEYsV739Wnk+BM3aV/Pt8CS3YQSmWoxmxKJMdwg6LMaBFv3K4w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 1:17 PM Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>
> +
> +struct i3cdev_data {
> +       struct list_head list;
> +       struct i3c_device *i3c;
> +       struct cdev cdev;
> +       struct device *dev;
> +       int id;
> +};
> +
> +static DEFINE_IDA(i3cdev_ida);
> +static dev_t i3cdev_number;
> +#define I3C_MINORS 16 /* 16 I3C devices supported for now */
> +
> +static LIST_HEAD(i3cdev_list);
> +static DEFINE_SPINLOCK(i3cdev_list_lock);

Please try to avoid arbitrarily limiting the number of devices you support.

Searching through the list feels a little clumsy. If the i3c user interface is
supposed to become a standard feature of the subsystem, it would seem
appropriate to put a pointer into the device to simplify the lookup, or
just embed the cdev inside of i3c_device.

> +static int
> +i3cdev_do_priv_xfer(struct i3c_device *dev, struct i3c_ioc_priv_xfer *xfers,
> +                   unsigned int nxfers)
> +{
> +       struct i3c_priv_xfer *k_xfers;
> +       u8 **data_ptrs;
> +       int i, ret = 0;
> +
> +       k_xfers = kcalloc(nxfers, sizeof(*k_xfers), GFP_KERNEL);
> +       if (!k_xfers)
> +               return -ENOMEM;
> +
> +       data_ptrs = kcalloc(nxfers, sizeof(*data_ptrs), GFP_KERNEL);
> +       if (!data_ptrs) {
> +               ret = -ENOMEM;
> +               goto err_free_k_xfer;
> +       }

Maybe use a  combined allocation to simplify the error handling?

> +       for (i = 0; i < nxfers; i++) {
> +               data_ptrs[i] = memdup_user((const u8 __user *)
> +                                          (uintptr_t)xfers[i].data,
> +                                          xfers[i].len);

> +               if (xfers[i].rnw) {
> +                       if (copy_to_user((void __user *)(uintptr_t)xfers[i].data,
> +                                        data_ptrs[i], xfers[i].len))

Use u64_to_user_ptr() here.

> +
> +static struct i3c_ioc_priv_xfer *
> +i3cdev_get_ioc_priv_xfer(unsigned int cmd, struct i3c_ioc_priv_xfer *u_xfers,
> +                        unsigned int *nxfers)
> +{
> +       u32 tmp = _IOC_SIZE(cmd);
> +
> +       if ((tmp % sizeof(struct i3c_ioc_priv_xfer)) != 0)
> +               return ERR_PTR(-EINVAL);
> +
> +       *nxfers = tmp / sizeof(struct i3c_ioc_priv_xfer);
> +       if (*nxfers == 0)
> +               return NULL;
> +
> +       return memdup_user(u_xfers, tmp);
> +}
> +
> +static int
> +i3cdev_ioc_priv_xfer(struct i3c_device *i3c, unsigned int cmd,
> +                    struct i3c_ioc_priv_xfer *u_xfers)
> +{
> +       struct i3c_ioc_priv_xfer *k_xfers;
> +       unsigned int nxfers;
> +       int ret;
> +
> +       k_xfers = i3cdev_get_ioc_priv_xfer(cmd, u_xfers, &nxfers);
> +       if (IS_ERR_OR_NULL(k_xfers))
> +               return PTR_ERR(k_xfers);
> +
> +       ret = i3cdev_do_priv_xfer(i3c, k_xfers, nxfers);

The IS_ERR_OR_NULL() usage looks suspicious. It's generally
better to avoid interfaces that require this. What does it mean to
return NULL from i3cdev_get_ioc_priv_xfer() and turn that into
success? Could you handle this condition in the caller instead,
or turn it into an error?

> +       /* Keep track of busses which have devices to add or remove later */
> +       res = bus_register_notifier(&i3c_bus_type, &i3c_notifier);
> +       if (res)
> +               goto out_unreg_class;
> +
> +       /* Bind to already existing device without driver right away */
> +       i3c_for_each_dev(NULL, i3cdev_attach);

The combination of the notifier and searching through the devices
seems to be racy. What happens when a device appears just before
or during the i3c_for_each_dev() traversal?

What happens when a driver attaches to a device that is currently
transferring data on the user interface?

Is there any guarantee that the notifiers for attach and detach
are serialized?

> +/**
> + * struct i3c_ioc_priv_xfer - I3C SDR ioctl private transfer
> + * @data: Holds pointer to userspace buffer with transmit data.
> + * @len: Length of data buffer buffers, in bytes.
> + * @rnw: encodes the transfer direction. true for a read, false for a write
> + */
> +struct i3c_ioc_priv_xfer {
> +       __u64 data;
> +       __u16 len;
> +       __u8 rnw;
> +       __u8 pad[5];
> +};
> +
> +
> +#define I3C_PRIV_XFER_SIZE(N)  \
> +       ((((sizeof(struct i3c_ioc_priv_xfer)) * (N)) < (1 << _IOC_SIZEBITS)) \
> +       ? ((sizeof(struct i3c_ioc_priv_xfer)) * (N)) : 0)
> +
> +#define I3C_IOC_PRIV_XFER(N)   \
> +       _IOC(_IOC_READ|_IOC_WRITE, I3C_DEV_IOC_MAGIC, 30, I3C_PRIV_XFER_SIZE(N))

This looks like a reasonable ioctl definition, avoiding the usual problems
with compat mode etc.

      Arnd
