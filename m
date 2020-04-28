Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D984C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CED220B80
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3Lktalo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgD1UJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726412AbgD1UJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:09:25 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC74DC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:09:24 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id f3so24747263ioj.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6b8JEdc86QQaLWgUONgVk5QnyKn0OwJfe4nUlQTwps0=;
        b=d3LktalotbLI0rJhUPptVS5m6TeC3T7IVM9AmAJQcKzSqXkCYx4sHzfZBRXBWNrhJ9
         nChBqVreBXCMxoNCEjAdTXCR1vRzfCytEZUtf13z9oltklrIDGVULrwgUMUto7+0T9eP
         0tAKMU6ESdpJJtGA7/8moPsY9glywvT/o6LZIGOKLkAUj+DSnUNkiSLG/haa3Vu9JQSt
         XZT9vMf6gbkocCwqFSitNVkd2Xqvyt4YOII+8CJDtXjmcZbbo2a9JtwVOsVq9az4EJs+
         jOBj56RrVFe/Zh/Ev3wvJuYasVOlY0KYDQx3OsfEiC5t6GDwauOkY9EpJBKZdEGwt0Gx
         EYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6b8JEdc86QQaLWgUONgVk5QnyKn0OwJfe4nUlQTwps0=;
        b=oj8hadvvJHvi+zQ0cCm93ON9ut1ADiurOmDV4guTs4zwJx2B1b0eGCX7ZYh//z40ve
         smcZTLtRuHy3FzIzgVycGR2fcudrAB+Jqki1hfClySQKxv+qYZIqeLaywuw/cjE57yWw
         3kz2BMdfz0SpvU+qiby9Ef5XDZcTnGb8OkBGBf2bzYKSIVQwnx4tM9qxVuPzKpdwztr1
         65svDG3/5t7Photop3Y4yjNhdVKH++xjxv4488Npqphcz5EktnZgfitdjbxzj0hkhra8
         04bD2NdUl2HKvyf7N066B8X7jdwOsySJx6z+BUCRJABfVfBDBKhYdkC6KUapvzQXzi1r
         guOg==
X-Gm-Message-State: AGi0PuZYtSE5NourLISD7/wpwISWj0Qk11CrAzn3xobNGHLS5rsDWpVB
        c9J/7W17+mG/+DjNEAC6U9u5X2szY5i4htq2tGjdGMuf
X-Google-Smtp-Source: APiQypIQBpPQQkAuehJj3ca3UUx0zUIWzRrOwv/RHaXCYe3333MWUVd7I0T7xj4J5l8onxqQ42VCv8lSggS7jkyeOw8=
X-Received: by 2002:a02:b88e:: with SMTP id p14mr25945179jam.36.1588104563944;
 Tue, 28 Apr 2020 13:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200325201839.15896-1-s-anna@ti.com> <20200325201839.15896-4-s-anna@ti.com>
 <20200428195855.GC10552@xps15>
In-Reply-To: <20200428195855.GC10552@xps15>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 28 Apr 2020 14:09:13 -0600
Message-ID: <CANLsYkwgCJrDu-Y5iyG0maCVqFqDXW_0vD4Sv2e+-dwryTNaRA@mail.gmail.com>
Subject: Re: [PATCH 3/3] remoteproc/k3-dsp: Add support for L2RAM loading on
 C66x DSPs
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 at 13:58, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Wed, Mar 25, 2020 at 03:18:39PM -0500, Suman Anna wrote:
> > The resets for the DSP processors on K3 SoCs are managed through the
> > Power and Sleep Controller (PSC) module. Each DSP typically has two
> > resets - a global module reset for powering on the device, and a local
> > reset that affects only the CPU while allowing access to the other
> > sub-modules within the DSP processor sub-systems.
> >
> > The C66x DSPs have two levels of internal RAMs that can be used to
> > boot from, and the firmware loading into these RAMs require the
> > local reset to be asserted with the device powered on/enabled using
> > the module reset. Enhance the K3 DSP remoteproc driver to add support
> > for loading into the internal RAMs. The local reset is deasserted on
> > SoC power-on-reset, so logic has to be added in probe in remoteproc
> > mode to balance the remoteproc state-machine.
> >
> > Note that the local resets are a no-op on C71x cores, and the hardware
> > does not supporting loading into its internal RAMs.
> >
> > Signed-off-by: Suman Anna <s-anna@ti.com>
> > ---
> >  drivers/remoteproc/ti_k3_dsp_remoteproc.c | 82 +++++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >
> > diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> > index fd0d84f46f90..7b712ef74611 100644
> > --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> > +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> > @@ -175,6 +175,9 @@ static int k3_dsp_rproc_reset(struct k3_dsp_rproc *kproc)
> >               return ret;
> >       }
> >
> > +     if (kproc->data->uses_lreset)
> > +             return ret;
> > +
> >       ret = kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
> >                                                   kproc->ti_sci_id);
> >       if (ret) {
> > @@ -192,6 +195,9 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
> >       struct device *dev = kproc->dev;
> >       int ret;
> >
> > +     if (kproc->data->uses_lreset)
> > +             goto lreset;
> > +
> >       ret = kproc->ti_sci->ops.dev_ops.get_device(kproc->ti_sci,
> >                                                  kproc->ti_sci_id);
> >       if (ret) {
> > @@ -199,6 +205,7 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
> >               return ret;
> >       }
> >
> > +lreset:
> >       ret = reset_control_deassert(kproc->reset);
> >       if (ret) {
> >               dev_err(dev, "local-reset deassert failed, ret = %d\n", ret);
> > @@ -210,6 +217,63 @@ static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
> >       return ret;
> >  }
> >
> > +/*
> > + * The C66x DSP cores have a local reset that affects only the CPU, and a
> > + * generic module reset that powers on the device and allows the DSP internal
> > + * memories to be accessed while the local reset is asserted. This function is
> > + * used to release the global reset on C66x DSPs to allow loading into the DSP
> > + * internal RAMs. The .prepare() ops is invoked by remoteproc core before any
> > + * firmware loading, and is followed by the .start() ops after loading to
> > + * actually let the C66x DSP cores run. The local reset on C71x cores is a
> > + * no-op and the global reset cannot be released on C71x cores until after
> > + * the firmware images are loaded, so this function does nothing for C71x cores.
> > + */
> > +static int k3_dsp_rproc_prepare(struct rproc *rproc)
> > +{
> > +     struct k3_dsp_rproc *kproc = rproc->priv;
> > +     struct device *dev = kproc->dev;
> > +     int ret;
> > +
> > +     /* local reset is no-op on C71x processors */
> > +     if (!kproc->data->uses_lreset)
> > +             return 0;
>
> In k3_dsp_rproc_release() the condition is "if (kproc->data->uses_lreset)" and
> here it is the opposite, which did a good job at getting me confused.
>
> Taking a step back, I assume c71 DSPs will have their own k3_dsp_dev_data where
> the users_lreset flag will be false.  In that case I think it would make the
> code easier to understand if the k3_dsp_rproc_ops was declared without the
> .prepare and .unprepare.  In probe(), if data->uses_lreset is true then
> k3_dsp_rproc_prepare() and k3_dsp_rproc_unprepare() are set.
>

I forgot... Since this is a C71 related change, was there a reason to
lump it with the C66 set?  If not I would simply move that to the C71
work.

> I am done reviewing this set.
>
> Thanks,
> Mathieu
>
> > +
> > +     ret = kproc->ti_sci->ops.dev_ops.get_device(kproc->ti_sci,
> > +                                                 kproc->ti_sci_id);
> > +     if (ret)
> > +             dev_err(dev, "module-reset deassert failed, cannot enable internal RAM loading, ret = %d\n",
> > +                     ret);
> > +
> > +     return ret;
> > +}
> > +
> > +/*
> > + * This function implements the .unprepare() ops and performs the complimentary
> > + * operations to that of the .prepare() ops. The function is used to assert the
> > + * global reset on applicable C66x cores. This completes the second portion of
> > + * powering down the C66x DSP cores. The cores themselves are only halted in the
> > + * .stop() callback through the local reset, and the .unprepare() ops is invoked
> > + * by the remoteproc core after the remoteproc is stopped to balance the global
> > + * reset.
> > + */
> > +static int k3_dsp_rproc_unprepare(struct rproc *rproc)
> > +{
> > +     struct k3_dsp_rproc *kproc = rproc->priv;
> > +     struct device *dev = kproc->dev;
> > +     int ret;
> > +
> > +     /* local reset is no-op on C71x processors */
> > +     if (!kproc->data->uses_lreset)
> > +             return 0;
> > +
> > +     ret = kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
> > +                                                 kproc->ti_sci_id);
> > +     if (ret)
> > +             dev_err(dev, "module-reset assert failed, ret = %d\n", ret);
> > +
> > +     return ret;
> > +}
> > +
> >  /*
> >   * Power up the DSP remote processor.
> >   *
> > @@ -353,6 +417,8 @@ static void *k3_dsp_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len)
> >  }
> >
> >  static const struct rproc_ops k3_dsp_rproc_ops = {
> > +     .prepare        = k3_dsp_rproc_prepare,
> > +     .unprepare      = k3_dsp_rproc_unprepare,
> >       .start          = k3_dsp_rproc_start,
> >       .stop           = k3_dsp_rproc_stop,
> >       .kick           = k3_dsp_rproc_kick,
> > @@ -644,6 +710,22 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
> >               goto disable_clk;
> >       }
> >
> > +     /*
> > +      * ensure the DSP local reset is asserted to ensure the DSP doesn't
> > +      * execute bogus code in .prepare() when the module reset is released.
> > +      */
> > +     if (data->uses_lreset) {
> > +             ret = reset_control_status(kproc->reset);
> > +             if (ret < 0) {
> > +                     dev_err(dev, "failed to get reset status, status = %d\n",
> > +                             ret);
> > +                     goto release_mem;
> > +             } else if (ret == 0) {
> > +                     dev_warn(dev, "local reset is deasserted for device\n");
> > +                     k3_dsp_rproc_reset(kproc);
> > +             }
> > +     }
> > +
> >       ret = rproc_add(rproc);
> >       if (ret) {
> >               dev_err(dev, "failed to add register device with remoteproc core, status = %d\n",
> > --
> > 2.23.0
> >
