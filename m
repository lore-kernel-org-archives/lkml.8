Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0919C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D4A2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0OwQW5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDVPsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgDVPsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:48:04 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0A4C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:48:04 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id i16so1406240ybq.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GsWN2mumHC+tUnsEjdfn2YD0cHxCHZv2pk4MpgL4ME8=;
        b=r0OwQW5eZ/zCbYsEpoyYyzpycDCu6SwJDBFFB9UyO3Lf7FEvWbWwciuwrt3nTROspH
         KWmo2VJ0wAsEIxelXMFFdP1XzwHpD8BhDl+QU3NNjxCfDd2LZRyUYymLyPZJMhbHuiQh
         r2vpsL8nWYR9uejvJtMm7Tym+Dph54jpliuVlC3AfMA9faebpv0KISYXj3jUAbvS8ywf
         hq+QDXn4LI6pqIZPSEPHLInXn0dh0a0feyUfE41fsqTdxLIgdgVmvxhT6mEVf6JU+WnE
         i7J5fSnG8tB2G90w+wBp1eR9wtJfH+Xb2mdQlGcdonwmzs9AfEJSgG1EcDZIsbtzrBqn
         n1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GsWN2mumHC+tUnsEjdfn2YD0cHxCHZv2pk4MpgL4ME8=;
        b=lOSfL1el+HRpnoDiA1Vpgirnf7c452MvgjHlrU1v3jI0BfwHJnlNgAijZ+v/qlh/JO
         64TagGt+cyAGvjVuf1MBgS8/uRAfSZU76vyAsxhxI6ym9TsZAAaRyiSNnukA2wPTIQd5
         2NK+lMwD6Hk8xJOxKtfbBDWV8KaQmhErHotjhvys/V4JwMO35Ro0uIbpcAj6sdSBujDS
         aNs6v6LGfQ71AdU+WQVHTjUoL6yM6+oeNU36CUk8XZOlmsTGMx4KUBK7hcbW9zwgn886
         8GmO6hRFtMMyEwNG8TVIUPOJuD3WCisI40OSr43CsBVVjpl16gTAt+XTqtxQzDgXgf0e
         XrpQ==
X-Gm-Message-State: AGi0PuY3vh4c8Z4HnpiNFW5lw3AwdVkyJXzRGFhnudEICM73dOCeFd2I
        nUpNmuzsdipL1X1iwowniq7HN7EX8hBw94uB+HvEqg==
X-Google-Smtp-Source: APiQypJ5FEZwmhSeFCnMsqXJ+pLFFGVJsm7AABTVLabYgFu3ZMgSXjTDIe7leQdzq6g50pDR9dJ/B42qlt6q0tUncV4=
X-Received: by 2002:a25:e0c5:: with SMTP id x188mr38032161ybg.208.1587570483191;
 Wed, 22 Apr 2020 08:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200422112719.826676174@infradead.org> <20200422112831.870192415@infradead.org>
 <20200422135628.GH4898@sirena.org.uk> <CAD=FV=VcbXoxtzyvLsFZuCDXJwCv8Y3pUdYBKMUmJaNcueBrqQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VcbXoxtzyvLsFZuCDXJwCv8Y3pUdYBKMUmJaNcueBrqQ@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 22 Apr 2020 08:47:52 -0700
Message-ID: <CABXOdTd-ze8=s8nXNvPSjBBQKX9N3e4v3xQfs_mbJfKaUrvZ0g@mail.gmail.com>
Subject: Re: [PATCH 11/23] sched,spi: Convert to sched_set_fifo*()
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
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

On Wed, Apr 22, 2020 at 7:35 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Apr 22, 2020 at 6:56 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Wed, Apr 22, 2020 at 01:27:30PM +0200, Peter Zijlstra wrote:
> > > Because SCHED_FIFO is a broken scheduler model (see previous patches)
> > > take away the priority field, the kernel can't possibly make an
> > > informed decision.
> > >
> > > No effective change.
> >
> > Copying Doug who did this change and Guenter who reviewed it.  This
> > looks fine to me but I've no particular involvement with the code or
> > platforms that are affected here.
>
> Thanks!  Probably the maintainers of cros_ec_spi.c (Benson and Enric)
> should be aware of it, too.  CCing them.
>
> From my point of view, my response is pretty much identical to the one
> I wrote when the priority was reduced from "MAX_RT_PRIO - 1" to
> "MAX_RT_PRIO / 2" [1].  Basically, any priority that keeps us from
> being preempted by tasks that are only high priority for performance
> reasons (like dm crypt and loopback did when I last analyzed) is fine.
> Our priority needs to be high not for performance reasons but for
> correctness reasons (the other side will drop our data if we don't
> respond in time).
>
The crypto engine ends up running at the same priority level, so I am
a bit concerned that this patch series will re-introduce the problem
that Doug's initial patch tried to solve. Though I do notice that it
already _is_ running at the same priority, so maybe the problem has
already been re-introduced with the commit that set the priority to
MAX_RT_PRIO / 2, and we just haven't noticed yet. So I guess this
patch indeed doesn't make a difference.

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> Thus:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
>
> [1] https://lore.kernel.org/r/CAD=FV=UsYF1R6+XRfFFFm6PfmkTsEOfxxgCw2JxCnpyu1kGVLQ@mail.gmail.com
>
>
> > > Cc: broonie@kernel.org
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Reviewed-by: Ingo Molnar <mingo@kernel.org>
> > > ---
> > >  drivers/platform/chrome/cros_ec_spi.c |    6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > --- a/drivers/platform/chrome/cros_ec_spi.c
> > > +++ b/drivers/platform/chrome/cros_ec_spi.c
> > > @@ -709,9 +709,6 @@ static void cros_ec_spi_high_pri_release
> > >  static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
> > >                                          struct cros_ec_spi *ec_spi)
> > >  {
> > > -     struct sched_param sched_priority = {
> > > -             .sched_priority = MAX_RT_PRIO / 2,
> > > -     };
> > >       int err;
> > >
> > >       ec_spi->high_pri_worker =
> > > @@ -728,8 +725,7 @@ static int cros_ec_spi_devm_high_pri_all
> > >       if (err)
> > >               return err;
> > >
> > > -     err = sched_setscheduler_nocheck(ec_spi->high_pri_worker->task,
> > > -                                      SCHED_FIFO, &sched_priority);
> > > +     err = sched_set_fifo(ec_spi->high_pri_worker->task);
> > >       if (err)
> > >               dev_err(dev, "Can't set cros_ec high pri priority: %d\n", err);
> > >       return err;
> > > --- a/drivers/spi/spi.c
> > > +++ b/drivers/spi/spi.c
> > > @@ -1589,11 +1589,9 @@ EXPORT_SYMBOL_GPL(spi_take_timestamp_pos
> > >   */
> > >  static void spi_set_thread_rt(struct spi_controller *ctlr)
> > >  {
> > > -     struct sched_param param = { .sched_priority = MAX_RT_PRIO / 2 };
> > > -
> > >       dev_info(&ctlr->dev,
> > >               "will run message pump with realtime priority\n");
> > > -     sched_setscheduler(ctlr->kworker_task, SCHED_FIFO, &param);
> > > +     sched_set_fifo(ctlr->kworker_task);
> > >  }
> > >
> > >  static int spi_init_queue(struct spi_controller *ctlr)
> > >
> > >
