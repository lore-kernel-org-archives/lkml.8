Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3F9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEA9206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgA2TkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:40:01 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:56207 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgA2TkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:40:01 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MHndY-1ilLoW45ws-00Ey4t for <linux-kernel@vger.kernel.org>; Wed, 29 Jan
 2020 20:39:59 +0100
Received: by mail-qt1-f171.google.com with SMTP id j5so427989qtq.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 11:39:58 -0800 (PST)
X-Gm-Message-State: APjAAAUXom1wGQtbpOTo2p9OphE4lUNGgiD6yfqhpXujwMHbQ57hvg9L
        ZtjJyIR6MJT5yslqMBcsEFwLE7BnDs/FweDfY3s=
X-Google-Smtp-Source: APXvYqzACP3TO+P6FLWJ5jTCyPG3LZ4i+VNkUByFIqUFh0dA9JI+62Ze5H6Yh9WsU2nlxUJY9emmgZMupGdGnoSZrHg=
X-Received: by 2002:ac8:34b2:: with SMTP id w47mr881540qtb.142.1580326797791;
 Wed, 29 Jan 2020 11:39:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580299067.git.vitor.soares@synopsys.com>
 <442a0c2c52223f9ff1a1d1018ff863fb23105389.1580299067.git.vitor.soares@synopsys.com>
 <CAK8P3a0uFjhuO7e-i3r_RiA_ni=S8MfYoZUwZzmbXRcd=+kMKw@mail.gmail.com> <CH2PR12MB4216ED068AD93C43B2C421A8AE050@CH2PR12MB4216.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4216ED068AD93C43B2C421A8AE050@CH2PR12MB4216.namprd12.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Jan 2020 20:39:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a384ksr95FTxcxr=48G-ytUqmAru7g1JT-Pdfpt1DcLMg@mail.gmail.com>
Message-ID: <CAK8P3a384ksr95FTxcxr=48G-ytUqmAru7g1JT-Pdfpt1DcLMg@mail.gmail.com>
Subject: Re: [RFC v2 4/4] i3c: add i3cdev module to expose i3c dev in /dev
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:StOuYar9eXRqJiMfuHJmnwjixjGCyjF7oysUY/M/4Hisn//g4zA
 OHZ3zIp+IBXVDZ4pKxYV67HZJo7Cim1wADskYtUwdglsfx3LoYmhUw+68IRNMdB/Z2DI/qW
 v5phjGAxngJudPSiqdtwZnTkkaJEU00T8Tlgtiwa8ThBvyunOrhNNJaL6unhuXyJdpvIKC1
 igDhS6z7VFe2Wrj+C9CUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1+zeVzzXv9Y=:2HiyQ5foiNQofPTnQZLFzJ
 wjvIybX9HveEhhTOkgYAJjIcGi1d8dIR5A0wx0HhLnApUFjV6me+Jr6AMpq89JjuAFkQqDjhB
 qOOd9psCUMH2E+fS6PTGi1iw7u9KXoKlqtH/On1bw2L4teUcCM+zVUIc1TcFRGniZev4KMlHB
 DPChXTXrmFocgARsq/0+ceSq8nAn+wWBEoa9GuJJW93nqLxPaCpFzMPHVoQIJRDA7pONA+MUt
 3oPoOcYo0zyyX5aWWALQM9XOjxvIVNp+stGsK0yQR1umCkPi3016Eqn850mbt1twMN2ZrIJQy
 Hx+72pdLI1l1lNxG/wr5m0MPu9xryDs2AaVuLDRTHOW0wwdbEWfsYqlQojbW2X7jIMdEsfkTz
 GjL8+Jtw/RYh41uNfDB/WR6A/cjinigCCMof2oHC30lmlNi3E7dKFVvPCdjJRskAQmBE6KMPw
 9c2OEojZaZ9RJh1klc+HE2PTiucVlHfPJE6R7tU48/Z3G6tQVUmeynwpEzPujlQ7GIpNuiF9+
 oqfvC5HOBioFYxk+6RPpq4mV7GPr09twcH2clfW3qaCdVNlkWIY9QnXoJdSTyBLVloT41mdit
 AScoYDkxiccwwIZwBKcb3iGPoshgl+0Rl6HE6J40xKhISTFV4xNV7+E+Ua3HevxM94jiQq9S1
 H8Uzp/C9YU0330uvKmshpii4Sg7vWUgZdQ0Zlar3QkQeQLJREecNtIAi4K2Ed81MuTndy6oiA
 26NSrgXoxXMzo6+NI/ouIvtaqtMir7zfrMOTDtOb0BUZnf2QR+K7JQkYmTlPnvdiZXQk6P/Ap
 ozE8pQOKNMtPLcNDOuBOtwmtsP6oPPHvznKHBE0cKJY4pmvP7U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 6:00 PM Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>
> Hi Arnd,
>
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed, Jan 29, 2020 at 14:30:56
>
> > On Wed, Jan 29, 2020 at 1:17 PM Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > >
> > > +
> > > +struct i3cdev_data {
> > > +       struct list_head list;
> > > +       struct i3c_device *i3c;
> > > +       struct cdev cdev;
> > > +       struct device *dev;
> > > +       int id;
> > > +};
> > > +
> > > +static DEFINE_IDA(i3cdev_ida);
> > > +static dev_t i3cdev_number;
> > > +#define I3C_MINORS 16 /* 16 I3C devices supported for now */
> > > +
> > > +static LIST_HEAD(i3cdev_list);
> > > +static DEFINE_SPINLOCK(i3cdev_list_lock);
> >
> > Please try to avoid arbitrarily limiting the number of devices you support.
>
> Should I use all minors range instead?

Yes, I'm fairly sure that if you use a dynamic major number, there
is no downside in using all of them.

> > Searching through the list feels a little clumsy. If the i3c user interface is
> > supposed to become a standard feature of the subsystem, it would seem
> > appropriate to put a pointer into the device to simplify the lookup,
>
> Do you mean i3c->dev ?

I was thinking you could add another member in i3c_device, next to ->dev.

> > or
> > just embed the cdev inside of i3c_device.
>
> I would prefer to have a pointer in i3c_device for i3cdev_data, but I see
> others using it in drvdata.

Ok, I think drvdata should work, but you should check that this is
correct when the device goes back between being bound to a device
driver and used through the chardev.

> >
> > > +static int
> > > +i3cdev_do_priv_xfer(struct i3c_device *dev, struct i3c_ioc_priv_xfer *xfers,
> > > +                   unsigned int nxfers)
> > > +{
> > > +       struct i3c_priv_xfer *k_xfers;
> > > +       u8 **data_ptrs;
> > > +       int i, ret = 0;
> > > +
> > > +       k_xfers = kcalloc(nxfers, sizeof(*k_xfers), GFP_KERNEL);
> > > +       if (!k_xfers)
> > > +               return -ENOMEM;
> > > +
> > > +       data_ptrs = kcalloc(nxfers, sizeof(*data_ptrs), GFP_KERNEL);
> > > +       if (!data_ptrs) {
> > > +               ret = -ENOMEM;
> > > +               goto err_free_k_xfer;
> > > +       }
> >
> > Maybe use a  combined allocation to simplify the error handling?
>
> Could you please provide an example?

Something like

       k_xfers = kcalloc(nxfers, sizeof(*k_xfers) +
sizeof(*data_ptrs), GFP_KERNEL);
       data_ptrs = (void *)k_xfers + (nxfers, sizeof(*k_xfers));

This would need a comment to explain the pointer math, but the resulting
object code is slightly simpler.

> > > +       /* Keep track of busses which have devices to add or remove later */
> > > +       res = bus_register_notifier(&i3c_bus_type, &i3c_notifier);
> > > +       if (res)
> > > +               goto out_unreg_class;
> > > +
> > > +       /* Bind to already existing device without driver right away */
> > > +       i3c_for_each_dev(NULL, i3cdev_attach);
> >
> > The combination of the notifier and searching through the devices
> > seems to be racy. What happens when a device appears just before
> > or during the i3c_for_each_dev() traversal?
>
> The i3c core is locked during this phase.

Ok.

> > What happens when a driver attaches to a device that is currently
> > transferring data on the user interface?
> >
>
> It may lost references for inode and file. I need to guarantee there no
> tranfer going on during the detach.
> Do you have any suggestion?

If the notifier is blocking, you could hold another mutex during the transfer
I think.

> > Is there any guarantee that the notifiers for attach and detach
> > are serialized?
> >
>
> Sorry I didn't get this part.

I think you answered this above: if the i3c code is locked while calling
the notifier, this cannot happen.

> > > +/**
> > > + * struct i3c_ioc_priv_xfer - I3C SDR ioctl private transfer
> > > + * @data: Holds pointer to userspace buffer with transmit data.
> > > + * @len: Length of data buffer buffers, in bytes.
> > > + * @rnw: encodes the transfer direction. true for a read, false for a write
> > > + */
> > > +struct i3c_ioc_priv_xfer {
> > > +       __u64 data;
> > > +       __u16 len;
> > > +       __u8 rnw;
> > > +       __u8 pad[5];
> > > +};
> > > +
> > > +
> > > +#define I3C_PRIV_XFER_SIZE(N)  \
> > > +       ((((sizeof(struct i3c_ioc_priv_xfer)) * (N)) < (1 << _IOC_SIZEBITS)) \
> > > +       ? ((sizeof(struct i3c_ioc_priv_xfer)) * (N)) : 0)
> > > +
> > > +#define I3C_IOC_PRIV_XFER(N)   \
> > > +       _IOC(_IOC_READ|_IOC_WRITE, I3C_DEV_IOC_MAGIC, 30, I3C_PRIV_XFER_SIZE(N))
> >
> > This looks like a reasonable ioctl definition, avoiding the usual problems
> > with compat mode etc.
>
> Do you think I should add more reserved fields for future?

No, what I meant is that I like it the way it is.

     Arnd
