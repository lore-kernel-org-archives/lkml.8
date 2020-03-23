Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5D8C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F7020774
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SYMt7G/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgCWPOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:14:32 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33955 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgCWPOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:14:31 -0400
Received: by mail-io1-f67.google.com with SMTP id h131so14535030iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 08:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nazMPjqIkWs0ZAFFdqSSlzNpLlqJL/D39lu/3l7gP4c=;
        b=SYMt7G/UNMHGwRJntbHtFslxj/bTJmuy0IOrfmiI5HWVY+5tWMTCoB4Y7B0gXVqggj
         9VXOspv4dWzgfyWrDGNrApyhodINuOzS+4+b5NV4HqCrqCPD2gEpX2fPyvEWjiyk3IJF
         foyLw//SN0sA7NqP4/0UcROdLgDy6vM17WcNuuZJ6/f9jchN3xHYFdL8TEKXMCvGiOUF
         AxVVZ+O8g92Gixj8NXSwna/wjy0GM/PYHRUSELh+88+VGPma25T3Zt29uF0r1efuVPTe
         7tJ8zF7YHsdMKoJPwmK1zpYRqlKVitXvFr9zWPN2pMSszkm+Oc/UZ+77xiCkJOFOvy7w
         ldLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nazMPjqIkWs0ZAFFdqSSlzNpLlqJL/D39lu/3l7gP4c=;
        b=XvZgPZvzGh7ZFafmnUasE4xWityy7p0+lRo3/GZW4nvAmiuIrGuLXvTG7sAGlM6C92
         0dSTZolKF3UfyB2C2kXuYVOBWHNJ+49b4Vw+UaBAvQE4PqwtW3hed372eEL+MwEHCtwS
         MSg/e79XscJe32r3rmeriDD1glNWVqPZSx+EnVDUs2HLBKXSzRIqVEsVPfPaJz6S1plL
         exDV5YMezB8VGhXLDErz0YK50HKamBWvliBOt36si5OrKtuA3OLDAR7eGSG8vlN97clP
         AZLax2CIDGbx4Qa6qUhncP+87LcFah42XbwMo6lEQ2+8k62YqawCpZuZRTEm4wqcnHYy
         9SGA==
X-Gm-Message-State: ANhLgQ2ImI0DHnpsYOz4JBBZRLCJE2vIEv8Tf45/j1avGpDXypTwYbDk
        SH1jZvrDqj97+soX9x80y0yN/ia2k+Uq56UweltS4w==
X-Google-Smtp-Source: ADFU+vu9r73PngwSQKcMF8AMCXYhboC6W13IzfBmPA6tsmX7L3igjJ73Z1iIfjSENCYVJ2BRZ4OGgoZmcK+t3q1skho=
X-Received: by 2002:a02:cbd0:: with SMTP id u16mr19827970jaq.36.1584976469483;
 Mon, 23 Mar 2020 08:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200313081718.30612-1-t-kristo@ti.com> <20200313081718.30612-15-t-kristo@ti.com>
 <20200320203224.GB16145@xps15> <3fb94cbd-fd05-b5aa-b7f2-dbef24584040@ti.com>
In-Reply-To: <3fb94cbd-fd05-b5aa-b7f2-dbef24584040@ti.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 23 Mar 2020 09:14:18 -0600
Message-ID: <CANLsYkwnbmXbodEbQQGSMP-oVGeZs6N-NisicGD5DgBfzGu1rg@mail.gmail.com>
Subject: Re: [PATCHv8 14/15] remoteproc/omap: Add watchdog functionality for
 remote processors
To:     Suman Anna <s-anna@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 at 15:48, Suman Anna <s-anna@ti.com> wrote:
>
> On 3/20/20 3:32 PM, Mathieu Poirier wrote:
> > On Fri, Mar 13, 2020 at 10:17:17AM +0200, Tero Kristo wrote:
> >> From: Suman Anna <s-anna@ti.com>
> >>
> >> Remote processors can be stuck in a loop, and may not be recoverable
> >> if they do not have a built-in watchdog. The watchdog implementation
> >> for OMAP remote processors uses external gptimers that can be used
> >> to interrupt both the Linux host as well as the remote processor.
> >>
> >> Each remote processor is responsible for refreshing the timer during
> >> normal behavior - during OS task scheduling or entering the idle loop
> >> properly. During a watchdog condition (executing a tight loop causing
> >> no scheduling), the host processor gets interrupts and schedules a
> >> recovery for the corresponding remote processor. The remote processor
> >> may also get interrupted to be able to print a back trace.
> >>
> >> A menuconfig option has also been added to enable/disable the Watchdog
> >> functionality, with the default as disabled.
> >>
> >> Signed-off-by: Suman Anna <s-anna@ti.com>
> >> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >> Reviewed-by: Andrew F. Davis <afd@ti.com>
> >> ---
> >> v8:
> >>   - minor cosmetic changes
> >>
> >>  drivers/remoteproc/Kconfig           |  12 +++
> >>  drivers/remoteproc/omap_remoteproc.c | 152 +++++++++++++++++++++++++--
> >>  2 files changed, 153 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> >> index b52abc2268cc..5f33358eb2f1 100644
> >> --- a/drivers/remoteproc/Kconfig
> >> +++ b/drivers/remoteproc/Kconfig
> >> @@ -52,6 +52,18 @@ config OMAP_REMOTEPROC
> >>        It's safe to say N here if you're not interested in multimedia
> >>        offloading or just want a bare minimum kernel.
> >>
> >> +config OMAP_REMOTEPROC_WATCHDOG
> >> +    bool "OMAP remoteproc watchdog timer"
> >> +    depends on OMAP_REMOTEPROC
> >> +    default n
> >> +    help
> >> +      Say Y here to enable watchdog timer for remote processors.
> >> +
> >> +      This option controls the watchdog functionality for the remote
> >> +      processors in OMAP. Dedicated OMAP DMTimers are used by the remote
> >> +      processors and triggers the timer interrupt upon a watchdog
> >> +      detection.
> >> +
> >>  config WKUP_M3_RPROC
> >>      tristate "AMx3xx Wakeup M3 remoteproc support"
> >>      depends on SOC_AM33XX || SOC_AM43XX
> >> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> >> index ece60a183e19..29d19a608af8 100644
> >> --- a/drivers/remoteproc/omap_remoteproc.c
> >> +++ b/drivers/remoteproc/omap_remoteproc.c
> >> @@ -24,6 +24,7 @@
> >>  #include <linux/platform_device.h>
> >>  #include <linux/pm_runtime.h>
> >>  #include <linux/dma-mapping.h>
> >> +#include <linux/interrupt.h>
> >>  #include <linux/remoteproc.h>
> >>  #include <linux/mailbox_client.h>
> >>  #include <linux/omap-iommu.h>
> >> @@ -72,10 +73,12 @@ struct omap_rproc_mem {
> >>   * struct omap_rproc_timer - data structure for a timer used by a omap rproc
> >>   * @odt: timer pointer
> >>   * @timer_ops: OMAP dmtimer ops for @odt timer
> >> + * @irq: timer irq
> >>   */
> >>  struct omap_rproc_timer {
> >>      struct omap_dm_timer *odt;
> >>      const struct omap_dm_timer_ops *timer_ops;
> >> +    int irq;
> >>  };
> >>
> >>  /**
> >> @@ -86,6 +89,7 @@ struct omap_rproc_timer {
> >>   * @mem: internal memory regions data
> >>   * @num_mems: number of internal memory regions
> >>   * @num_timers: number of rproc timer(s)
> >> + * @num_wd_timers: number of rproc watchdog timers
> >>   * @timers: timer(s) info used by rproc
> >>   * @autosuspend_delay: auto-suspend delay value to be used for runtime pm
> >>   * @need_resume: if true a resume is needed in the system resume callback
> >> @@ -102,6 +106,7 @@ struct omap_rproc {
> >>      struct omap_rproc_mem *mem;
> >>      int num_mems;
> >>      int num_timers;
> >> +    int num_wd_timers;
> >>      struct omap_rproc_timer *timers;
> >>      int autosuspend_delay;
> >>      bool need_resume;
> >> @@ -219,6 +224,79 @@ static inline int omap_rproc_release_timer(struct omap_rproc_timer *timer)
> >>      return timer->timer_ops->free(timer->odt);
> >>  }
> >>
> >> +/**
> >> + * omap_rproc_get_timer_irq() - get the irq for a timer
> >> + * @timer: handle to a OMAP rproc timer
> >> + *
> >> + * This function is used to get the irq associated with a watchdog timer. The
> >> + * function is called by the OMAP remoteproc driver to register a interrupt
> >> + * handler to handle watchdog events on the remote processor.
> >> + *
> >> + * Return: irq id on success, otherwise a failure as returned by DMTimer ops
> >> + */
> >> +static inline int omap_rproc_get_timer_irq(struct omap_rproc_timer *timer)
> >> +{
> >> +    return timer->timer_ops->get_irq(timer->odt);
> >> +}
> >> +
> >> +/**
> >> + * omap_rproc_ack_timer_irq() - acknowledge a timer irq
> >> + * @timer: handle to a OMAP rproc timer
> >> + *
> >> + * This function is used to clear the irq associated with a watchdog timer. The
> >> + * The function is called by the OMAP remoteproc upon a watchdog event on the
> >> + * remote processor to clear the interrupt status of the watchdog timer.
> >> + */
> >> +static inline void omap_rproc_ack_timer_irq(struct omap_rproc_timer *timer)
> >> +{
> >> +    timer->timer_ops->write_status(timer->odt, OMAP_TIMER_INT_OVERFLOW);
> >> +}
> >> +
> >> +/**
> >> + * omap_rproc_watchdog_isr() - Watchdog ISR handler for remoteproc device
> >> + * @irq: IRQ number associated with a watchdog timer
> >> + * @data: IRQ handler data
> >> + *
> >> + * This ISR routine executes the required necessary low-level code to
> >> + * acknowledge a watchdog timer interrupt. There can be multiple watchdog
> >> + * timers associated with a rproc (like IPUs which have 2 watchdog timers,
> >> + * one per Cortex M3/M4 core), so a lookup has to be performed to identify
> >> + * the timer to acknowledge its interrupt.
> >> + *
> >> + * The function also invokes rproc_report_crash to report the watchdog event
> >> + * to the remoteproc driver core, to trigger a recovery.
> >> + *
> >> + * Return: IRQ_HANDLED on success, otherwise IRQ_NONE
> >> + */
> >> +static irqreturn_t omap_rproc_watchdog_isr(int irq, void *data)
> >> +{
> >> +    struct rproc *rproc = data;
> >> +    struct omap_rproc *oproc = rproc->priv;
> >> +    struct device *dev = rproc->dev.parent;
> >> +    struct omap_rproc_timer *timers = oproc->timers;
> >> +    struct omap_rproc_timer *wd_timer = NULL;
> >> +    int num_timers = oproc->num_timers + oproc->num_wd_timers;
> >> +    int i;
> >> +
> >> +    for (i = oproc->num_timers; i < num_timers; i++) {
> >> +            if (timers[i].irq > 0 && irq == timers[i].irq) {
> >> +                    wd_timer = &timers[i];
> >> +                    break;
> >> +            }
> >> +    }
> >> +
> >> +    if (!wd_timer) {
> >> +            dev_err(dev, "invalid timer\n");
> >> +            return IRQ_NONE;
> >> +    }
> >> +
> >> +    omap_rproc_ack_timer_irq(wd_timer);
> >> +
> >> +    rproc_report_crash(rproc, RPROC_WATCHDOG);
> >> +
> >> +    return IRQ_HANDLED;
> >> +}
> >> +
> >>  /**
> >>   * omap_rproc_enable_timers() - enable the timers for a remoteproc
> >>   * @rproc: handle of a remote processor
> >> @@ -242,19 +320,26 @@ static int omap_rproc_enable_timers(struct rproc *rproc, bool configure)
> >>      struct omap_rproc_timer *timers = oproc->timers;
> >>      struct device *dev = rproc->dev.parent;
> >>      struct device_node *np = NULL;
> >> +    int num_timers = oproc->num_timers + oproc->num_wd_timers;
> >>
> >> -    if (!oproc->num_timers)
> >> +    if (!num_timers)
> >>              return 0;
> >>
> >>      if (!configure)
> >>              goto start_timers;
> >>
> >> -    for (i = 0; i < oproc->num_timers; i++) {
> >> -            np = of_parse_phandle(dev->of_node, "ti,timers", i);
> >> +    for (i = 0; i < num_timers; i++) {
> >> +            if (i < oproc->num_timers)
> >> +                    np = of_parse_phandle(dev->of_node, "ti,timers", i);
> >> +            else
> >> +                    np = of_parse_phandle(dev->of_node,
> >> +                                          "ti,watchdog-timers",
> >> +                                          (i - oproc->num_timers));
> >>              if (!np) {
> >>                      ret = -ENXIO;
> >>                      dev_err(dev, "device node lookup for timer at index %d failed: %d\n",
> >> -                            i, ret);
> >> +                            i < oproc->num_timers ? i :
> >> +                            i - oproc->num_timers, ret);
> >>                      goto free_timers;
> >>              }
> >>
> >> @@ -277,12 +362,14 @@ static int omap_rproc_enable_timers(struct rproc *rproc, bool configure)
> >>              if (!timer_ops || !timer_ops->request_by_node ||
> >>                  !timer_ops->set_source || !timer_ops->set_load ||
> >>                  !timer_ops->free || !timer_ops->start ||
> >> -                !timer_ops->stop) {
> >> +                !timer_ops->stop || !timer_ops->get_irq ||
> >> +                !timer_ops->write_status) {
> >>                      ret = -EINVAL;
> >>                      dev_err(dev, "device does not have required timer ops\n");
> >>                      goto put_node;
> >>              }
> >>
> >> +            timers[i].irq = -1;
> >>              timers[i].timer_ops = timer_ops;
> >>              ret = omap_rproc_request_timer(dev, np, &timers[i]);
> >>              if (ret) {
> >> @@ -291,10 +378,33 @@ static int omap_rproc_enable_timers(struct rproc *rproc, bool configure)
> >>                      goto put_node;
> >>              }
> >>              of_node_put(np);
> >> +
> >> +            if (i >= oproc->num_timers) {
> >> +                    timers[i].irq = omap_rproc_get_timer_irq(&timers[i]);
> >> +                    if (timers[i].irq < 0) {
> >> +                            dev_err(dev, "get_irq for timer %p failed: %d\n",
> >> +                                    np, timers[i].irq);
> >> +                            ret = -EBUSY;
> >> +                            goto free_timers;
> >> +                    }
> >> +
> >> +                    ret = request_irq(timers[i].irq,
> >> +                                      omap_rproc_watchdog_isr, IRQF_SHARED,
> >> +                                      "rproc-wdt", rproc);
> >> +                    if (ret) {
> >> +                            dev_err(dev, "error requesting irq for timer %p\n",
> >> +                                    np);
> >> +                            omap_rproc_release_timer(&timers[i]);
> >> +                            timers[i].odt = NULL;
> >> +                            timers[i].timer_ops = NULL;
> >> +                            timers[i].irq = -1;
> >> +                            goto free_timers;
> >> +                    }
> >> +            }
> >>      }
> >>
> >>  start_timers:
> >> -    for (i = 0; i < oproc->num_timers; i++) {
> >> +    for (i = 0; i < num_timers; i++) {
> >>              ret = omap_rproc_start_timer(&timers[i]);
> >>              if (ret) {
> >>                      dev_err(dev, "start timer %p failed failed: %d\n", np,
> >> @@ -316,9 +426,12 @@ static int omap_rproc_enable_timers(struct rproc *rproc, bool configure)
> >>              of_node_put(np);
> >>  free_timers:
> >>      while (i--) {
> >> +            if (i >= oproc->num_timers)
> >> +                    free_irq(timers[i].irq, rproc);
> >>              omap_rproc_release_timer(&timers[i]);
> >>              timers[i].odt = NULL;
> >>              timers[i].timer_ops = NULL;
> >> +            timers[i].irq = -1;
> >>      }
> >>
> >>      return ret;
> >> @@ -341,16 +454,20 @@ static int omap_rproc_disable_timers(struct rproc *rproc, bool configure)
> >>      int i;
> >>      struct omap_rproc *oproc = rproc->priv;
> >>      struct omap_rproc_timer *timers = oproc->timers;
> >> +    int num_timers = oproc->num_timers + oproc->num_wd_timers;
> >>
> >> -    if (!oproc->num_timers)
> >> +    if (!num_timers)
> >>              return 0;
> >>
> >> -    for (i = 0; i < oproc->num_timers; i++) {
> >> +    for (i = 0; i < num_timers; i++) {
> >>              omap_rproc_stop_timer(&timers[i]);
> >>              if (configure) {
> >> +                    if (i >= oproc->num_timers)
> >> +                            free_irq(timers[i].irq, rproc);
> >>                      omap_rproc_release_timer(&timers[i]);
> >>                      timers[i].odt = NULL;
> >>                      timers[i].timer_ops = NULL;
> >> +                    timers[i].irq = -1;
> >>              }
> >>      }
> >>
> >> @@ -1110,6 +1227,7 @@ static int omap_rproc_of_get_timers(struct platform_device *pdev,
> >>      struct device_node *np = pdev->dev.of_node;
> >>      struct omap_rproc *oproc = rproc->priv;
> >>      struct device *dev = &pdev->dev;
> >> +    int num_timers;
> >>
> >>      /*
> >>       * Timer nodes are directly used in client nodes as phandles, so
> >> @@ -1122,14 +1240,26 @@ static int omap_rproc_of_get_timers(struct platform_device *pdev,
> >>              oproc->num_timers = 0;
> >>      }
> >>
> >> -    if (oproc->num_timers) {
> >> -            oproc->timers = devm_kcalloc(dev, oproc->num_timers,
> >> +#ifdef CONFIG_OMAP_REMOTEPROC_WATCHDOG
> >> +    oproc->num_wd_timers =
> >> +            of_count_phandle_with_args(np, "ti,watchdog-timers", NULL);
> >> +    if (oproc->num_wd_timers <= 0) {
> >> +            dev_dbg(dev, "device does not have watchdog timers, status = %d\n",
> >> +                    oproc->num_wd_timers);
> >> +            oproc->num_wd_timers = 0;
> >> +    }
> >> +#endif
> >
> > I commented on the above in the previous version...
>
> Oh, misunderstood your agreed response. I have moved the entire timer
> parse into a separate function. Do you still prefer just this block to
> be defined in its own function, it is already self-contained?

Please remove the #ifdef block from the function to favour a simple
function that resolve to nothing if the configuration flag is not
defined.

>
> regards
> Suman
>
> >
> >> +
> >> +    num_timers = oproc->num_timers + oproc->num_wd_timers;
> >> +    if (num_timers) {
> >> +            oproc->timers = devm_kcalloc(dev, num_timers,
> >>                                           sizeof(*oproc->timers),
> >>                                           GFP_KERNEL);
> >>              if (!oproc->timers)
> >>                      return -ENOMEM;
> >>
> >> -            dev_dbg(dev, "device has %d tick timers\n", oproc->num_timers);
> >> +            dev_dbg(dev, "device has %d tick timers and %d watchdog timers\n",
> >> +                    oproc->num_timers, oproc->num_wd_timers);
> >>      }
> >>
> >>      return 0;
> >> --
> >> 2.17.1
> >>
> >> --
> >> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
