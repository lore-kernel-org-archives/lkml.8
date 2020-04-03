Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA86C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9F5206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guU56ioH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgDCUS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:18:28 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45708 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgDCUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:18:28 -0400
Received: by mail-io1-f65.google.com with SMTP id y14so8913037iol.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gHLwd7tW+yY/xm1BU5jr+xQmR6G7Y08mWvbB2R+BIOo=;
        b=guU56ioHZYD2xEZoRKj05PK3YlJGJtnnDqkI3bEL3d9FJdLgZydpbdCl1mz5sbqLhh
         IY+Re+sujqYwZfMzixBYJQvegRlF+aklZV/3dNu3CnfLJGDe/kl6TKl/204AolUO0ufY
         43O6bclh6ydBizC7VQXh8JFuyk9zvgLhwHYrJcngYi5shwmsetcTyyacKE1McEkgp9+v
         P3kC40Nj6MoVcgh8C6hpWZr1+dEkWALogt/1rH/tcTQV4Bwzzv2bwgx7pCtAcOBY4Fit
         /OiKxlO63mSAJewDcBEQ0Re0FO9qDucNdTI7g51esvzSadgVbG4JVHuJdSNjbSsD3Wox
         K86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gHLwd7tW+yY/xm1BU5jr+xQmR6G7Y08mWvbB2R+BIOo=;
        b=kZTWHZXVWVk9xPLAHkLUWyoIn/CQ4LHdNx/Whg7N9H+cz9UuVGhF6v/Wd/v20EmM6B
         iIRT+MpeJl3mh/cbraaW+ss4aa6wS1a/HP33s5+My68VY5lBtDXc1BVExiK9QBF076Ku
         4DUpb0vlee2qHRQ9C2UIhNJAWfsM8fR3uX9AUbeNoMsY62KQy/TCOSFwCKNDpnGCCL2D
         hAW3SS6a9IbjitEp9QYgO+dX6iqkO98mBMIYTzMcb39BKzhsBxrg3A1djNGYPfU7ePP7
         21TeCz323pjCQ64RLvc8v83rM0pr1AppRWvkbLp+v+q4oW1jat96Ch1f2lG9SdIbyl+/
         6jFg==
X-Gm-Message-State: AGi0PuY27RWEzoM31JAGdTnXwawcaqX9cY2fM5aQXqKFP0qrKIkloOYH
        WtMLP2efNRltlrzKyjFserkFNXfxBaI/LZpvkp6ilA==
X-Google-Smtp-Source: APiQypJJ1JxG3ZtPL8mi5Gu4NvUT/Z+F1mhNkXcOLq+UQOEAs0l6eh88MXAtMqZ7vYQPLZzNAqbF3CZqRilT/H/4aWs=
X-Received: by 2002:a6b:bb45:: with SMTP id l66mr9493673iof.73.1585945104007;
 Fri, 03 Apr 2020 13:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200324170407.16470-1-arnaud.pouliquen@st.com>
 <20200324170407.16470-3-arnaud.pouliquen@st.com> <20200401180618.GB23918@xps15>
 <dab484a2-fcf4-889e-a05c-923b95dcd501@st.com>
In-Reply-To: <dab484a2-fcf4-889e-a05c-923b95dcd501@st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 3 Apr 2020 14:18:12 -0600
Message-ID: <CANLsYkwCMR5OiFC8r-V29iWZL46-Mo6WL-oSnmNioGd2czDQtw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] tty: add rpmsg driver
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        xiang xiao <xiaoxiang781216@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Apr 2020 at 09:25, Arnaud POULIQUEN <arnaud.pouliquen@st.com> wro=
te:
>
> Hi Mathieu,
>
> On 4/1/20 8:06 PM, Mathieu Poirier wrote:
> > On Tue, Mar 24, 2020 at 06:04:07PM +0100, Arnaud Pouliquen wrote:
> >> This driver exposes a standard TTY interface on top of the rpmsg
> >> framework through a rpmsg service.
> >>
> >> This driver supports multi-instances, offering a /dev/ttyRPMSGx entry
> >> per rpmsg endpoint.
> >>
> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> >> ---
> >>  Documentation/serial/tty_rpmsg.rst |  45 ++++
> >>  drivers/tty/Kconfig                |   9 +
> >>  drivers/tty/Makefile               |   1 +
> >>  drivers/tty/rpmsg_tty.c            | 417 ++++++++++++++++++++++++++++=
+
> >>  4 files changed, 472 insertions(+)
> >>  create mode 100644 Documentation/serial/tty_rpmsg.rst
> >>  create mode 100644 drivers/tty/rpmsg_tty.c
> >>
> >> diff --git a/Documentation/serial/tty_rpmsg.rst b/Documentation/serial=
/tty_rpmsg.rst
> >> new file mode 100644
> >> index 000000000000..fc1d3fba73c5
> >> --- /dev/null
> >> +++ b/Documentation/serial/tty_rpmsg.rst
> >> @@ -0,0 +1,45 @@
> >> +.. SPDX-License-Identifier: GPL-2.0
> >> +
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +The rpmsg TTY
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +The rpmsg tty driver implements serial communication on the RPMsg bus=
 to makes possible for user-space programs to send and receive rpmsg messag=
es as a standard tty protocol.
> >> +
> >> +The remote processor can instantiate a new tty by requesting:
> >> +- a "rpmsg-tty-raw" RPMsg service, for TTY raw data support without f=
low control
> >> +- a "rpmsg-tty-ctrl" RPMSg service, for TTY support with flow control=
.
> >> +
> >> +Information related to the RPMsg and associated tty device is availab=
le in
> >> +/sys/bus/rpmsg/devices/.
> >> +
> >> +RPMsg TTY without control
> >> +---------------------
> >> +
> >> +The default end point associated with the "rpmsg-tty-raw" service is =
directly
> >> +used for data exchange. No flow control is available.
> >> +
> >> +To be compliant with this driver, the remote firmware must create its=
 data end point associated with the "rpmsg-tty-raw" service.
> >> +
> >> +RPMsg TTY with control
> >> +---------------------
> >> +
> >> +The default end point associated with the "rpmsg-tty-ctrl" service is=
 reserved for
> >> +the control. A second endpoint must be created for data exchange.
> >> +
> >> +The control channel is used to transmit to the remote processor the C=
TS status,
> >> +as well as the end point address for data transfer.
> >> +
> >> +To be compatible with this driver, the remote firmware must create or=
 use its end point associated with "rpmsg-tty-ctrl" service, plus a second =
endpoint for the data flow.
> >> +On Linux rpmsg_tty probes, the data endpoint address and the CTS (set=
 to disable)
> >> +is sent to the remote processor.
> >> +The remote processor has to respect following rules:
> >> +- It only transmits data when Linux remote cts is enable, otherwise m=
essage
> >> +  could be lost.
> >> +- It can pause/resume reception by sending a control message (rely on=
 CTS state).
> >> +
> >> +Control message structure:
> >> +struct rpmsg_tty_ctrl {
> >> +    u8 cts;                 /* remote reception status */
> >> +    u16 d_ept_addr;         /* data endpoint address */
> >> +};
> >> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> >> index a312cb33a99b..9d3ff6df9f25 100644
> >> --- a/drivers/tty/Kconfig
> >> +++ b/drivers/tty/Kconfig
> >> @@ -454,6 +454,15 @@ config VCC
> >>      help
> >>        Support for Sun logical domain consoles.
> >>
> >> +config RPMSG_TTY
> >> +    tristate "RPMSG tty driver"
> >> +    depends on RPMSG
> >> +    help
> >> +      Say y here to export rpmsg endpoints as tty devices, usually fo=
und
> >> +      in /dev/ttyRPMSGx.
> >> +      This makes it possible for user-space programs to send and rece=
ive
> >> +      rpmsg messages as a standard tty protocol.
> >> +
> >>  config LDISC_AUTOLOAD
> >>      bool "Automatically load TTY Line Disciplines"
> >>      default y
> >> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> >> index 020b1cd9294f..c2465e7ebc2a 100644
> >> --- a/drivers/tty/Makefile
> >> +++ b/drivers/tty/Makefile
> >> @@ -34,5 +34,6 @@ obj-$(CONFIG_PPC_EPAPR_HV_BYTECHAN) +=3D ehv_bytecha=
n.o
> >>  obj-$(CONFIG_GOLDFISH_TTY)  +=3D goldfish.o
> >>  obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) +=3D mips_ejtag_fdc.o
> >>  obj-$(CONFIG_VCC)           +=3D vcc.o
> >> +obj-$(CONFIG_RPMSG_TTY)             +=3D rpmsg_tty.o
> >>
> >>  obj-y +=3D ipwireless/
> >> diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
> >> new file mode 100644
> >> index 000000000000..49ce3b72781a
> >> --- /dev/null
> >> +++ b/drivers/tty/rpmsg_tty.c
> >> @@ -0,0 +1,417 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (C) STMicroelectronics 2020 - All Rights Reserved
> >> + * Authors: Arnaud Pouliquen <arnaud.pouliquen@st.com> for STMicroele=
ctronics.
> >> + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/rpmsg.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/tty.h>
> >> +#include <linux/tty_flip.h>
> >> +
> >> +#define MAX_TTY_RPMSG       32
> >> +
> >> +#define TTY_CH_NAME_RAW             "rpmsg-tty-raw"
> >> +#define TTY_CH_NAME_WITH_CTS        "rpmsg-tty-ctrl"
> >> +
> >> +static DEFINE_IDR(tty_idr); /* tty instance id */
> >> +static DEFINE_MUTEX(idr_lock);      /* protects tty_idr */
> >> +
> >> +static struct tty_driver *rpmsg_tty_driver;
> >> +
> >> +struct rpmsg_tty_ctrl {
> >> +    u16 d_ept_addr;         /* data endpoint address */
> >> +    u8 cts;                 /* remote reception status */
> >> +} __packed;
> >> +
> >> +struct rpmsg_tty_port {
> >> +    struct tty_port         port;    /* TTY port data */
> >> +    int                     id;      /* TTY rpmsg index */
> >> +    bool                    cts;     /* remote reception status */
> >> +    struct rpmsg_device     *rpdev;  /* rpmsg device */
> >> +    struct rpmsg_endpoint   *cs_ept; /* channel control endpoint */
> >> +    struct rpmsg_endpoint   *d_ept;  /* data endpoint */
> >> +    u32 data_dst;                    /* data destination endpoint add=
ress */
> >> +};
> >> +
> >> +typedef void (*rpmsg_tty_rx_cb_t)(struct rpmsg_device *, void *, int,=
 void *,
> >> +                              u32);
> >> +
> >> +static int rpmsg_tty_cb(struct rpmsg_device *rpdev, void *data, int l=
en,
> >> +                    void *priv, u32 src)
> >> +{
> >> +    struct rpmsg_tty_port *cport =3D dev_get_drvdata(&rpdev->dev);
> >> +    int copied;
> >> +
> >> +    if (src =3D=3D cport->data_dst) {
> >> +            /* data message */
> >> +            if (!len)
> >> +                    return -EINVAL;
> >> +            copied =3D tty_insert_flip_string_fixed_flag(&cport->port=
, data,
> >> +                                                       TTY_NORMAL, le=
n);
> >> +            if (copied !=3D len)
> >> +                    dev_dbg(&rpdev->dev, "trunc buffer: available spa=
ce is %d\n",
> >> +                            copied);
> >> +            tty_flip_buffer_push(&cport->port);
> >> +    } else {
> >> +            /* control message */
> >> +            struct rpmsg_tty_ctrl *msg =3D data;
> >> +
> >> +            if (len !=3D sizeof(*msg))
> >> +                    return -EINVAL;
> >> +
> >> +            cport->data_dst =3D msg->d_ept_addr;
> >> +
> >> +            /* Update remote cts state */
> >> +            cport->cts =3D msg->cts ? 1 : 0;
> >> +
> >> +            if (cport->cts)
> >> +                    tty_port_tty_wakeup(&cport->port);
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static void rpmsg_tty_send_term_ready(struct tty_struct *tty, u8 stat=
e)
> >> +{
> >> +    struct rpmsg_tty_port *cport =3D tty->driver_data;
> >> +    struct rpmsg_tty_ctrl m_ctrl;
> >> +    int ret;
> >> +
> >> +    m_ctrl.cts =3D state;
> >> +    m_ctrl.d_ept_addr =3D cport->d_ept->addr;
> >> +
> >> +    ret =3D rpmsg_trysend(cport->cs_ept, &m_ctrl, sizeof(m_ctrl));
> >> +    if (ret < 0)
> >> +            dev_dbg(tty->dev, "cannot send control (%d)\n", ret);
> >> +};
> >> +
> >> +static void rpmsg_tty_throttle(struct tty_struct *tty)
> >> +{
> >> +    struct rpmsg_tty_port *cport =3D tty->driver_data;
> >> +
> >> +    /* Disable remote transmission */
> >> +    if (cport->cs_ept)
> >> +            rpmsg_tty_send_term_ready(tty, 0);
> >> +};
> >> +
> >> +static void rpmsg_tty_unthrottle(struct tty_struct *tty)
> >> +{
> >> +    struct rpmsg_tty_port *cport =3D tty->driver_data;
> >> +
> >> +    /* Enable remote transmission */
> >> +    if (cport->cs_ept)
> >> +            rpmsg_tty_send_term_ready(tty, 1);
> >> +};
> >> +
> >> +static int rpmsg_tty_install(struct tty_driver *driver, struct tty_st=
ruct *tty)
> >> +{
> >> +    struct rpmsg_tty_port *cport =3D idr_find(&tty_idr, tty->index);
> >> +
> >> +    if (!cport) {
> >> +            dev_err(tty->dev, "cannot get cport\n");
> >> +            return -ENODEV;
> >> +    }
> >> +
> >> +    tty->driver_data =3D cport;
> >> +
> >> +    return tty_port_install(&cport->port, driver, tty);
> >> +}
> >> +
> >> +static int rpmsg_tty_open(struct tty_struct *tty, struct file *filp)
> >> +{
> >> +    return tty_port_open(tty->port, tty, filp);
> >> +}
> >> +
> >> +static void rpmsg_tty_close(struct tty_struct *tty, struct file *filp=
)
> >> +{
> >> +    return tty_port_close(tty->port, tty, filp);
> >> +}
> >> +
> >> +static int rpmsg_tty_write(struct tty_struct *tty, const u8 *buf, int=
 len)
> >> +{
> >> +    struct rpmsg_tty_port *cport =3D tty->driver_data;
> >> +    struct rpmsg_device *rpdev;
> >> +    int msg_max_size, msg_size;
> >> +    int ret;
> >> +    u8 *tmpbuf;
> >> +
> >> +    /* If cts not set, the message is not sent*/
> >> +    if (!cport->cts)
> >> +            return 0;
> >> +
> >> +    rpdev =3D cport->rpdev;
> >> +
> >> +    dev_dbg(&rpdev->dev, "%s: send msg from tty->index =3D %d, len =
=3D %d\n",
> >> +            __func__, tty->index, len);
> >> +
> >> +    msg_max_size =3D rpmsg_get_mtu(rpdev->ept);
> >> +
> >> +    msg_size =3D min(len, msg_max_size);
> >> +    tmpbuf =3D kzalloc(msg_size, GFP_KERNEL);
> >> +    if (!tmpbuf)
> >> +            return -ENOMEM;
> >> +
> >> +    memcpy(tmpbuf, buf, msg_size);
> >> +
> >> +    /*
> >> +     * Try to send the message to remote processor, if failed return =
0 as
> >> +     * no data sent
> >> +     */
> >> +    ret =3D rpmsg_trysendto(cport->d_ept, tmpbuf, msg_size, cport->da=
ta_dst);
> >> +    kfree(tmpbuf);
> >> +    if (ret) {
> >> +            dev_dbg(&rpdev->dev, "rpmsg_send failed: %d\n", ret);
> >> +            return 0;
> >> +    }
> >> +
> >> +    return msg_size;
> >> +}
> >> +
> >> +static int rpmsg_tty_write_room(struct tty_struct *tty)
> >> +{
> >> +    struct rpmsg_tty_port *cport =3D tty->driver_data;
> >> +
> >> +    return cport->cts ? rpmsg_get_mtu(cport->rpdev->ept) : 0;
> >> +}
> >> +
> >> +static const struct tty_operations rpmsg_tty_ops =3D {
> >> +    .install        =3D rpmsg_tty_install,
> >> +    .open           =3D rpmsg_tty_open,
> >> +    .close          =3D rpmsg_tty_close,
> >> +    .write          =3D rpmsg_tty_write,
> >> +    .write_room     =3D rpmsg_tty_write_room,
> >> +    .throttle       =3D rpmsg_tty_throttle,
> >> +    .unthrottle     =3D rpmsg_tty_unthrottle,
> >> +};
> >> +
> >> +static struct rpmsg_tty_port *rpmsg_tty_alloc_cport(void)
> >> +{
> >> +    struct rpmsg_tty_port *cport;
> >> +
> >> +    cport =3D kzalloc(sizeof(*cport), GFP_KERNEL);
> >> +    if (!cport)
> >> +            return ERR_PTR(-ENOMEM);
> >> +
> >> +    mutex_lock(&idr_lock);
> >> +    cport->id =3D idr_alloc(&tty_idr, cport, 0, MAX_TTY_RPMSG, GFP_KE=
RNEL);
> >> +    mutex_unlock(&idr_lock);
> >> +
> >> +    if (cport->id < 0) {
> >> +            kfree(cport);
> >> +            return ERR_PTR(-ENOSPC);
> >> +    }
> >> +
> >> +    return cport;
> >> +}
> >> +
> >> +static void rpmsg_tty_release_cport(struct rpmsg_tty_port *cport)
> >> +{
> >> +    mutex_lock(&idr_lock);
> >> +    idr_remove(&tty_idr, cport->id);
> >> +    mutex_unlock(&idr_lock);
> >> +
> >> +    kfree(cport);
> >> +}
> >> +
> >> +static int rpmsg_tty_port_activate(struct tty_port *p, struct tty_str=
uct *tty)
> >> +{
> >> +    p->low_latency =3D (p->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
> >> +
> >> +    /* Allocate the buffer we use for writing data */
> >> +    return tty_port_alloc_xmit_buf(p);
> >> +}
> >> +
> >> +static void rpmsg_tty_port_shutdown(struct tty_port *p)
> >> +{
> >> +    /* Free the write buffer */
> >> +    tty_port_free_xmit_buf(p);
> >> +}
> >> +
> >> +static void rpmsg_tty_dtr_rts(struct tty_port *port, int raise)
> >> +{
> >> +    dev_dbg(port->tty->dev, "%s: dtr_rts state %d\n", __func__, raise=
);
> >> +
> >> +    if (raise)
> >> +            rpmsg_tty_unthrottle(port->tty);
> >> +    else
> >> +            rpmsg_tty_throttle(port->tty);
> >> +}
> >> +
> >> +static const struct tty_port_operations rpmsg_tty_port_ops =3D {
> >> +    .activate =3D rpmsg_tty_port_activate,
> >> +    .shutdown =3D rpmsg_tty_port_shutdown,
> >> +    .dtr_rts  =3D rpmsg_tty_dtr_rts,
> >> +};
> >> +
> >> +static int rpmsg_tty_probe(struct rpmsg_device *rpdev)
> >> +{
> >> +    struct rpmsg_tty_port *cport;
> >> +    struct device *dev =3D &rpdev->dev;
> >> +    struct rpmsg_channel_info chinfo;
> >> +    struct device *tty_dev;
> >> +    int ret;
> >> +
> >> +    cport =3D rpmsg_tty_alloc_cport();
> >> +    if (IS_ERR(cport)) {
> >> +            dev_err(dev, "failed to alloc tty port\n");
> >> +            return PTR_ERR(cport);
> >> +    }
> >> +
> >> +    if (!strncmp(rpdev->id.name, TTY_CH_NAME_WITH_CTS,
> >> +                 sizeof(TTY_CH_NAME_WITH_CTS))) {
> >> +            /*
> >> +             * the default endpoint is used for control. Create a sec=
ond
> >> +             * endpoint for the data that would be exchanges trough c=
ontrol
> >> +             * endpoint. address of the data endpoint will be provide=
d with
> >> +             * the cts state
> >> +             */
> >> +            cport->cs_ept =3D rpdev->ept;
> >> +            cport->data_dst =3D RPMSG_ADDR_ANY;
> >> +
> >> +            strscpy(chinfo.name, TTY_CH_NAME_WITH_CTS, sizeof(chinfo.=
name));
> >
> > Shouldn't this be TTY_CH_NAME_RAW instead of TTY_CH_NAME_WITH_CTS?
> The TTY_CH_NAME_WITH_CTS represent here the service "TTY support with flo=
w control"
> the aim here is to define 2 endpoints on top of the service channel.
> the main is used for the CTS control but also to exchange the addresses o=
f the
> second endpoint that is used for the data flow.

Right - the new endpoint, the one that is about to be created using
"chinfo.name" is a data endpoint, hence the confusion.

> here if you associate the 2nd endpoint to a diff=C3=A9rent service name, =
you have no
> correlation between the control ept and the data endpoint ( at least if y=
ou
> want to support multi instance)
>
> I can probaly implement it in a different way using your path [1]
> by creating a correlation between the control and the data, based
> on the naming.
> something like:
> - "tty-featureA"  /* data stream associated to featureA"
> - "tty-featureB"  /* data stream associated to featureB"
> - "tty-ctl-featureB"  /* control associated to featureB"

I would do "tty-featureB-ctrl".  That way "tty-featureB" and
"tty-featureB-ctrl" always appear one after the other when doing an
"ls" on the command line.

>
> That would be probably more straight forward for users...
>
> [1] https://lkml.org/lkml/2020/2/12/1083
> >
> >> +            chinfo.src =3D RPMSG_ADDR_ANY;
> >> +            chinfo.dst =3D RPMSG_ADDR_ANY;
> >> +
> >> +            cport->d_ept =3D rpmsg_create_ept(rpdev, rpmsg_tty_cb, cp=
ort,
> >> +                                            chinfo);
> >> +            if (!cport->d_ept) {
> >> +                    dev_err(dev, "failed to create tty control channe=
l\n");
> >
> > Here too I don't understand why we are talking about the control channe=
l when
> > the data channel is created.  Am I missing something?
> >
> > Also I suggest function rpmsg_tty_cp() to be split, one for control and=
 one for
> > data.  That will make it easier to follow who processes what.
>
> you mean rpmsg_tty_probe?  yes i will.

Splitting rpmsg_tty_probe() would be good too, but I was referring to
rpmsg_tty_cb().

>
> >
> >> +                    ret =3D -ENOMEM;
> >> +                    goto err_r_cport;
> >> +            }
> >> +            dev_dbg(dev, "%s: creating data endpoint with address %#x=
\n",
> >> +                    __func__, cport->d_ept->addr);
> >> +    } else {
> >> +            /*
> >> +             * TTY over rpmsg without CTS management the default endp=
oint
> >> +             * is use for raw data transmission.
> >> +             */
> >> +            cport->cs_ept =3D NULL;
> >> +            cport->cts =3D 1;
> >> +            cport->d_ept =3D rpdev->ept;
> >> +            cport->data_dst =3D rpdev->dst;
> >> +    }
> >> +
> >> +    tty_port_init(&cport->port);
> >> +    cport->port.ops =3D &rpmsg_tty_port_ops;
> >> +
> >> +    tty_dev =3D tty_port_register_device(&cport->port, rpmsg_tty_driv=
er,
> >> +                                       cport->id, dev);
> >> +    if (IS_ERR(tty_dev)) {
> >> +            dev_err(dev, "failed to register tty port\n");
> >> +            ret =3D PTR_ERR(tty_dev);
> >> +            goto  err_destroy;
> >> +    }
> >> +
> >> +    cport->rpdev =3D rpdev;
> >> +
> >> +    dev_set_drvdata(dev, cport);
> >> +
> >> +    dev_dbg(dev, "new channel: 0x%x -> 0x%x : ttyRPMSG%d\n",
> >> +            rpdev->src, rpdev->dst, cport->id);
> >> +
> >> +    return 0;
> >> +
> >> +err_destroy:
> >> +    tty_port_destroy(&cport->port);
> >> +    if (cport->cs_ept)
> >> +            rpmsg_destroy_ept(cport->d_ept);
> >> +err_r_cport:
> >> +    rpmsg_tty_release_cport(cport);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static void rpmsg_tty_remove(struct rpmsg_device *rpdev)
> >> +{
> >> +    struct rpmsg_tty_port *cport =3D dev_get_drvdata(&rpdev->dev);
> >> +
> >> +    dev_dbg(&rpdev->dev, "removing rpmsg tty device %d\n", cport->id)=
;
> >> +
> >> +    /* User hang up to release the tty */
> >> +    if (tty_port_initialized(&cport->port))
> >> +            tty_port_tty_hangup(&cport->port, false);
> >> +
> >> +    tty_unregister_device(rpmsg_tty_driver, cport->id);
> >> +
> >> +    tty_port_destroy(&cport->port);
> >> +    if (cport->cs_ept)
> >> +            rpmsg_destroy_ept(cport->d_ept);
> >> +    rpmsg_tty_release_cport(cport);
> >> +}
> >> +
> >> +static struct rpmsg_device_id rpmsg_driver_tty_id_table[] =3D {
> >> +    { .name =3D TTY_CH_NAME_RAW },
> >> +    { .name =3D TTY_CH_NAME_WITH_CTS},
> >
> > If I'm not mistaken support for more than one tty
> > per remote proc can't happen because of rpmsg_find_device() in
> > rpmsg_create_channel() - is this correct?
>
> There is not bloker to instantiate the same service several times.

You are correct.  I took another look at rpmsg_device_match() and the
second condition [2] allows for channels to have the same name for as
long as the destination address is different.

[2]. https://elixir.bootlin.com/linux/v5.6/source/drivers/rpmsg/rpmsg_core.=
c#L299

> On remote side it is enough to create 2 endpoints with the same service
> name and with the destination address set to RPMSG_ADDR_ANY. This will
> trig 2 rpmsg_ns_cb, that will probe 2 times the device.
>
> As example please have a look to the stm32MP1 sample here which creates
> 2 tty rpmsg channels:
> https://github.com/STMicroelectronics/STM32CubeMP1/tree/master/Projects/S=
TM32MP157C-DK2/Applications/OpenAMP/OpenAMP_TTY_echo
>
> Thanks,
> Arnaud
>
> >
> > Thanks,
> > Mathieu
> >
> >> +    { },
> >> +};
> >> +MODULE_DEVICE_TABLE(rpmsg, rpmsg_driver_tty_id_table);
> >> +
> >> +static struct rpmsg_driver rpmsg_tty_rpmsg_drv =3D {
> >> +    .drv.name       =3D KBUILD_MODNAME,
> >> +    .id_table       =3D rpmsg_driver_tty_id_table,
> >> +    .probe          =3D rpmsg_tty_probe,
> >> +    .callback       =3D rpmsg_tty_cb,
> >> +    .remove         =3D rpmsg_tty_remove,
> >> +};
> >> +
> >> +static int __init rpmsg_tty_init(void)
> >> +{
> >> +    int err;
> >> +
> >> +    rpmsg_tty_driver =3D tty_alloc_driver(MAX_TTY_RPMSG, TTY_DRIVER_R=
EAL_RAW |
> >> +                                        TTY_DRIVER_DYNAMIC_DEV);
> >> +    if (IS_ERR(rpmsg_tty_driver))
> >> +            return PTR_ERR(rpmsg_tty_driver);
> >> +
> >> +    rpmsg_tty_driver->driver_name =3D "rpmsg_tty";
> >> +    rpmsg_tty_driver->name =3D "ttyRPMSG";
> >> +    rpmsg_tty_driver->major =3D 0;
> >> +    rpmsg_tty_driver->type =3D TTY_DRIVER_TYPE_CONSOLE;
> >> +
> >> +    /* Disable unused mode by default */
> >> +    rpmsg_tty_driver->init_termios =3D tty_std_termios;
> >> +    rpmsg_tty_driver->init_termios.c_lflag &=3D ~(ECHO | ICANON);
> >> +    rpmsg_tty_driver->init_termios.c_oflag &=3D ~(OPOST | ONLCR);
> >> +
> >> +    tty_set_operations(rpmsg_tty_driver, &rpmsg_tty_ops);
> >> +
> >> +    err =3D tty_register_driver(rpmsg_tty_driver);
> >> +    if (err < 0) {
> >> +            pr_err("Couldn't install rpmsg tty driver: err %d\n", err=
);
> >> +            goto error_put;
> >> +    }
> >> +
> >> +    err =3D register_rpmsg_driver(&rpmsg_tty_rpmsg_drv);
> >> +    if (err < 0) {
> >> +            pr_err("Couldn't register rpmsg tty driver: err %d\n", er=
r);
> >> +            goto error_unregister;
> >> +    }
> >> +
> >> +    return 0;
> >> +
> >> +error_unregister:
> >> +    tty_unregister_driver(rpmsg_tty_driver);
> >> +
> >> +error_put:
> >> +    put_tty_driver(rpmsg_tty_driver);
> >> +
> >> +    return err;
> >> +}
> >> +
> >> +static void __exit rpmsg_tty_exit(void)
> >> +{
> >> +    unregister_rpmsg_driver(&rpmsg_tty_rpmsg_drv);
> >> +    tty_unregister_driver(rpmsg_tty_driver);
> >> +    put_tty_driver(rpmsg_tty_driver);
> >> +    idr_destroy(&tty_idr);
> >> +}
> >> +
> >> +module_init(rpmsg_tty_init);
> >> +module_exit(rpmsg_tty_exit);
> >> +
> >> +MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
> >> +MODULE_DESCRIPTION("remote processor messaging tty driver");
> >> +MODULE_LICENSE("GPL v2");
> >> --
> >> 2.17.1
> >>
