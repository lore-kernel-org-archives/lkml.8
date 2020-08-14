Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B064C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18AE3205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aFW4l0oX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgHNTZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHNTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 15:25:41 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3789C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 12:25:40 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v6so11763614iow.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 12:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ayx2osqkGYyYmtCpQpi4VnenZwpKUC2ibrz4ES7QYAw=;
        b=aFW4l0oXOFK3RjfBWLSYv0SKDYvgo1Jb3Kib2RyWH86/htADthQcwHGRKISPm2vaM3
         o4J9DFzNRN1a82XLrqM3NsTCaL2O/e6SbU8/8qxeDyxHAjq0fCI7LLiXuaiB9C02H0nv
         bpvhzj3WPTWxaOUD0TI91yvt78w6TSnyf9KezelXCQR1RWmcbGXyzn6g+RlJWo7eHJ24
         luAi6R2Xdqo52h7Pn9we21zyzsbx8kfcwTp2dfRdqQxvwKYhvdJrawsgugZIOW9hWkIN
         pZkl2v0GRSJFz6iYolf/EZP5KtDtcfCvWoBD407i6UgPwjFjjhXSpy/DhQUqvib/9Chj
         znIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ayx2osqkGYyYmtCpQpi4VnenZwpKUC2ibrz4ES7QYAw=;
        b=dGYuSSwHO4WNPx5OTqVg6gpKL59K5hUKhSkD6nRSAvYClBhGXTcguAv01tVpNJeoah
         eZTX9uove5svZ5yuwmqMt89OEo0ZjNyp9KyI5AeTaSJb+KAJEqVLcujUutwU26LGztjv
         VUBAIf0sFYYxhHOiLPfgfyxCOt6Z07YcPHwMRraP0dKaoxDsv2A9nt5ZY8becpoAe3y+
         QgvanUa4qL2eqlwlmMKjM692XjROcbP7kjK15oFC/NU1BQyGxaSd8e7gGOnesGYgPU1D
         nLningKgmac1n17IHWI9wxVtI/5lHUZP0O3H0i/vQuHYsRZV74v5nGvuN6jss2yVQ/rB
         qrRg==
X-Gm-Message-State: AOAM533WXPwNaIfqBqXmpzfnwz/8hFU6M4IO1CFO7GIGQCGXeJleAp+u
        IsvQbva3JCM71R7ITH44zy8zE7G4GWYWXW32XrQtDg==
X-Google-Smtp-Source: ABdhPJytWcAbXvzQyRfuX5bXB5ZnHLjbA6E5KXYFCxjtPwoKfTDZnmqAIRVQXBwm5v432vHFlGR0x4tiwvzCXWh38nM=
X-Received: by 2002:a6b:2b52:: with SMTP id r79mr3295106ior.157.1597433140015;
 Fri, 14 Aug 2020 12:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200813210357.146936-1-lpy@google.com> <159741850487.10342.14268227307882225260@build.alporthouse.com>
In-Reply-To: <159741850487.10342.14268227307882225260@build.alporthouse.com>
From:   Peiyong Lin <lpy@google.com>
Date:   Fri, 14 Aug 2020 12:25:24 -0700
Message-ID: <CA+0soA=9D6Rj9Z_3P58dFQB7ZkZooEfjKgpVeAVtoAHJ8MVfsA@mail.gmail.com>
Subject: Re: [PATCH] Add power/gpu_frequency tracepoint.
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Sidath Senanayake <sidaths@google.com>, zzyiwei@android.com
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org,
        Prahlad Kilambi <prahladk@google.com>,
        android-kernel@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris, please see my comments inline.


On Fri, Aug 14, 2020 at 8:22 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Peiyong Lin (2020-08-13 22:03:57)
> > Historically there is no common trace event for GPU frequency, in
> > downstream Android each different hardware vendor implements their own
> > way to expose GPU frequency, for example as a debugfs node.  This patch
> > standardize it as a common trace event in upstream linux kernel to help
> > the ecosystem have a common implementation across hardware vendors.
> > Toolings in the Linux ecosystem will benefit from this especially in the
> > downstream Android, where this information is critical to graphics
> > developers.
> >
> > Signed-off-by: Peiyong Lin <lpy@google.com>
> > ---
> >  drivers/gpu/Makefile                    |  1 +
> >  drivers/gpu/trace/Kconfig               |  3 +++
> >  drivers/gpu/trace/Makefile              |  1 +
> >  drivers/gpu/trace/trace_gpu_frequency.c | 13 +++++++++++++
> >  include/trace/events/power.h            | 26 +++++++++++++++++++++++++
> >  5 files changed, 44 insertions(+)
> >  create mode 100644 drivers/gpu/trace/trace_gpu_frequency.c
> >
> > diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
> > index 835c88318cec..f289a47eb031 100644
> > --- a/drivers/gpu/Makefile
> > +++ b/drivers/gpu/Makefile
> > @@ -6,3 +6,4 @@ obj-$(CONFIG_TEGRA_HOST1X)      += host1x/
> >  obj-y                  += drm/ vga/
> >  obj-$(CONFIG_IMX_IPUV3_CORE)   += ipu-v3/
> >  obj-$(CONFIG_TRACE_GPU_MEM)            += trace/
> > +obj-$(CONFIG_TRACE_GPU_FREQUENCY)              += trace/
> > diff --git a/drivers/gpu/trace/Kconfig b/drivers/gpu/trace/Kconfig
> > index c24e9edd022e..ac4aec8d5845 100644
> > --- a/drivers/gpu/trace/Kconfig
> > +++ b/drivers/gpu/trace/Kconfig
> > @@ -2,3 +2,6 @@
> >
> >  config TRACE_GPU_MEM
> >         bool
> > +
> > +config TRACE_GPU_FREQUENCY
> > +       bool
> > diff --git a/drivers/gpu/trace/Makefile b/drivers/gpu/trace/Makefile
> > index b70fbdc5847f..2b7ae69327d6 100644
> > --- a/drivers/gpu/trace/Makefile
> > +++ b/drivers/gpu/trace/Makefile
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  obj-$(CONFIG_TRACE_GPU_MEM) += trace_gpu_mem.o
> > +obj-$(CONFIG_TRACE_GPU_FREQUENCY) += trace_gpu_frequency.o
> > diff --git a/drivers/gpu/trace/trace_gpu_frequency.c b/drivers/gpu/trace/trace_gpu_frequency.c
> > new file mode 100644
> > index 000000000000..f5af5800b52d
> > --- /dev/null
> > +++ b/drivers/gpu/trace/trace_gpu_frequency.c
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * GPU frequency trace points
> > + *
> > + * Copyright (C) 2020 Google, Inc.
> > + */
> > +
> > +#include <linux/module.h>
> > +
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/power.h>
> > +
> > +EXPORT_TRACEPOINT_SYMBOL(gpu_frequency);
> > diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> > index af5018aa9517..befc0157131e 100644
> > --- a/include/trace/events/power.h
> > +++ b/include/trace/events/power.h
> > @@ -500,6 +500,32 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
> >
> >         TP_ARGS(name, type, new_value)
> >  );
> > +
> > +/**
> > + * gpu_frequency - Reports frequency changes in GPU clock domains
> > + * @state:  New frequency (in KHz)
> > + * @gpu_id: GPU clock domain
> > + */
> > +TRACE_EVENT(gpu_frequency,
> > +
> > +       TP_PROTO(unsigned int state, unsigned int gpu_id),
> > +
> > +       TP_ARGS(state, gpu_id),
> > +
> > +       TP_STRUCT__entry(
> > +               __field(unsigned int, state)
> > +               __field(unsigned int, gpu_id)
>
> What is a gpu-id and how are we supposed to create one?

gpu_id is the id for per GPU clock domain, it should be created for
per GPU clock domain. It's not necessarily tied to a physical GPU.

>
> 'state' is quite non-descript, and since this is not an event template
> you could be a little more specific.
>
> So when should this tracepoint fire? For the frequency change we request,
> or the frequency change of the black box of the pcu?

If an implementation implements this, the GPU frequency tracepoint
should be fired whenever there's a frequency change. That is to say,
when gpu goes from idle to active or vice versa, or when the gpu
frequency goes up and down.

>
> We have found that a tracepoint is not a useful monitor of the actual GPU
> frequencies, for that we use provide sampling via perf-events.
> -Chris
