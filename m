Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9306AC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68879206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eDWJvQoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgDVOfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgDVOfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:35:37 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837E3C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 07:35:37 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id x9so702958vkd.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 07:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6r060DYJVZuVXNH4Pw8Vog7xFy/id6N/VIMCOquzR7U=;
        b=eDWJvQoYw0D566ye1FZEi0s6T0WZmoyGNsc/8zWhyCZTuWw6KdGKF4mnmujYBQc+tC
         BSUGRUwJ9QrdeexT+FmaHXYPQNM7WaImUsMikx2Qulye0j9XGzYCAIJlEFMo10DZdVec
         eu/h3ItHJ5Pi4ijg2do5aCwU5G2x9Ozv3k/jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6r060DYJVZuVXNH4Pw8Vog7xFy/id6N/VIMCOquzR7U=;
        b=ZabPnEtBhC3coupEc9vDAdZ6yOCHoOasUSLly1HdnJAj341MvdPAbq5VB4p60hEd7l
         /XrITthjLYz2xrrdkB29lHlj1p2UGP9IoLyRuGrsMA+IeLMnjO+6eMNTClC8i1d4WfPx
         XSmvjQ0gDDVPRx02F0Id/Bd42zHV887U0KrZWDx0RDFRnBocJpd0RsNSQuGTWc0jo9KM
         qF7dVs+K7chNgaHWQxtB2mDmVkciGTT7ym5S33X4kheRkC+EVy3+FZvK8USuXkdighQ6
         xpqWn/HBedHnZG/7D9zx+ZXeK/Bt+RgIRMe6uDRTSj9pwUwCVtgdaEqeEc9OsmU/t5Ty
         ndgw==
X-Gm-Message-State: AGi0PuavU7wEdKKnAbhUSUAEoMLDqt5JmLp8hgx6edLz9WYtglo+5wTK
        /qqsIOqkDiUJC0AdlZGw0VFRlopfyC8=
X-Google-Smtp-Source: APiQypKIetlCxrnKipqb9LoER+Wa/GEZ7pRd5L/g4ps9+CqHWlM4J7ugplAfbeY3S06bd6AkJT4v8g==
X-Received: by 2002:a1f:32cf:: with SMTP id y198mr19594204vky.96.1587566136196;
        Wed, 22 Apr 2020 07:35:36 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id n193sm1655668vkf.43.2020.04.22.07.35.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 07:35:34 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 10so693480vkr.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 07:35:34 -0700 (PDT)
X-Received: by 2002:a1f:9605:: with SMTP id y5mr5583628vkd.75.1587566133956;
 Wed, 22 Apr 2020 07:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200422112719.826676174@infradead.org> <20200422112831.870192415@infradead.org>
 <20200422135628.GH4898@sirena.org.uk>
In-Reply-To: <20200422135628.GH4898@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 Apr 2020 07:35:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VcbXoxtzyvLsFZuCDXJwCv8Y3pUdYBKMUmJaNcueBrqQ@mail.gmail.com>
Message-ID: <CAD=FV=VcbXoxtzyvLsFZuCDXJwCv8Y3pUdYBKMUmJaNcueBrqQ@mail.gmail.com>
Subject: Re: [PATCH 11/23] sched,spi: Convert to sched_set_fifo*()
To:     Mark Brown <broonie@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, qais.yousef@arm.com,
        juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Benjamin Segall <bsegall@google.com>,
        mgorman@suse.de, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 22, 2020 at 6:56 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Apr 22, 2020 at 01:27:30PM +0200, Peter Zijlstra wrote:
> > Because SCHED_FIFO is a broken scheduler model (see previous patches)
> > take away the priority field, the kernel can't possibly make an
> > informed decision.
> >
> > No effective change.
>
> Copying Doug who did this change and Guenter who reviewed it.  This
> looks fine to me but I've no particular involvement with the code or
> platforms that are affected here.

Thanks!  Probably the maintainers of cros_ec_spi.c (Benson and Enric)
should be aware of it, too.  CCing them.

From my point of view, my response is pretty much identical to the one
I wrote when the priority was reduced from "MAX_RT_PRIO - 1" to
"MAX_RT_PRIO / 2" [1].  Basically, any priority that keeps us from
being preempted by tasks that are only high priority for performance
reasons (like dm crypt and loopback did when I last analyzed) is fine.
Our priority needs to be high not for performance reasons but for
correctness reasons (the other side will drop our data if we don't
respond in time).

Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


[1] https://lore.kernel.org/r/CAD=FV=UsYF1R6+XRfFFFm6PfmkTsEOfxxgCw2JxCnpyu1kGVLQ@mail.gmail.com


> > Cc: broonie@kernel.org
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  drivers/platform/chrome/cros_ec_spi.c |    6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > --- a/drivers/platform/chrome/cros_ec_spi.c
> > +++ b/drivers/platform/chrome/cros_ec_spi.c
> > @@ -709,9 +709,6 @@ static void cros_ec_spi_high_pri_release
> >  static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
> >                                          struct cros_ec_spi *ec_spi)
> >  {
> > -     struct sched_param sched_priority = {
> > -             .sched_priority = MAX_RT_PRIO / 2,
> > -     };
> >       int err;
> >
> >       ec_spi->high_pri_worker =
> > @@ -728,8 +725,7 @@ static int cros_ec_spi_devm_high_pri_all
> >       if (err)
> >               return err;
> >
> > -     err = sched_setscheduler_nocheck(ec_spi->high_pri_worker->task,
> > -                                      SCHED_FIFO, &sched_priority);
> > +     err = sched_set_fifo(ec_spi->high_pri_worker->task);
> >       if (err)
> >               dev_err(dev, "Can't set cros_ec high pri priority: %d\n", err);
> >       return err;
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -1589,11 +1589,9 @@ EXPORT_SYMBOL_GPL(spi_take_timestamp_pos
> >   */
> >  static void spi_set_thread_rt(struct spi_controller *ctlr)
> >  {
> > -     struct sched_param param = { .sched_priority = MAX_RT_PRIO / 2 };
> > -
> >       dev_info(&ctlr->dev,
> >               "will run message pump with realtime priority\n");
> > -     sched_setscheduler(ctlr->kworker_task, SCHED_FIFO, &param);
> > +     sched_set_fifo(ctlr->kworker_task);
> >  }
> >
> >  static int spi_init_queue(struct spi_controller *ctlr)
> >
> >
