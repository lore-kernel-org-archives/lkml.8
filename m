Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBACC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B532720732
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FT7vWuyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgC3QNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:13:35 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36153 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgC3QNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:13:35 -0400
Received: by mail-il1-f196.google.com with SMTP id p13so16328612ilp.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bODexIV6jLtyYVwawU8DJgOMgDkTFyGRSElefALKc94=;
        b=FT7vWuyikzgxPomzGjkyE4IEv2HM7lYxtOUlj4CfNO/mlCDMt9yBch04xRdBVKoIb1
         +wp6SiwqOYhUeBNGsXL6+G/yWpEhCqNQpxfZ4YcfpMiUaWOzdePQ2OCalJ2CfdDdJ4us
         82xyZ4JunPKz32xwCvTWzoL3ZrTiUhscCYQRboQhW1itJ6bzbauntekksOsfWlNAgH0v
         Tji8MaOIGB8C4QO2VtJ9TttBv2zAhg5EhaKOnIFXSCEHs4jYaCDM0weyQWSMMVBgsMhS
         +ciigFVgdx59IckiCS8XkE27tvEgBXQWRmoIEQIBv0mGaUTaxIl6d3SoqLYZhPPqL9VZ
         sbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bODexIV6jLtyYVwawU8DJgOMgDkTFyGRSElefALKc94=;
        b=mpBJHe+S5JR8tKLAzceVa38U95Cj2qzhhJonF+BRwX8zuHURh+wHWaVPevFSzHOKGc
         A0ikljeSgPT9D7ViBQvkqMS9lxdfDYwivEuyoChsGo3hKAJF01Sxhvaol1TfXdWZxWWQ
         fzD6G+0jpRmcli6mb/oZeiGS/Tp7GEa/A5HnD2R/YAupSzcuEuEzaADni1qXlOtl2UNL
         czHTyCsBnP0V/8239SNnYaoWrIRuI+5Lw+rqDWZGlaxVNwxBVL7UlScpYPrguNrT7NGV
         /eUwmEulZKOm4bAXPw9XKt3VHNyO/XAyR1cAWPs1bBSmUPIGLe7D0yUD4vwiv3ZRoaOr
         49ag==
X-Gm-Message-State: ANhLgQ3z/vWyE3UY+IVDMLNefNxjSblsNvw4hKYq3Xt82yFyN3q9dVnK
        m6dkGM9jCZT8jt/tg8aoSnRiY0oRrCzAvs6WtljOvQ==
X-Google-Smtp-Source: ADFU+vsONJFXOtpXfvufxuj95WetEkpYrcjQTVIfKk81ZEZO0CeUAb740FntTxqlkUbdf7apaJ7ZReSl0ui2f1wPimY=
X-Received: by 2002:a92:dc51:: with SMTP id x17mr12372330ilq.50.1585584812676;
 Mon, 30 Mar 2020 09:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <1585357147-4616-1-git-send-email-rishabhb@codeaurora.org> <CANLsYkxV7xWUkggBXF=ziGfmLs-EZewuzCzZ3fq56CR+xA0poQ@mail.gmail.com>
In-Reply-To: <CANLsYkxV7xWUkggBXF=ziGfmLs-EZewuzCzZ3fq56CR+xA0poQ@mail.gmail.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 30 Mar 2020 10:13:21 -0600
Message-ID: <CANLsYkzNKDwL6PSSagvk6YWRedLKmW80ji3nOYy1VrPQ3cP-8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] remoteproc: qcom: Add bus scaling capability during bootup
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        Siddharth Gupta <sidgup@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 at 10:06, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Hi Rishabh,
>
> On Fri, 27 Mar 2020 at 18:59, Rishabh Bhatnagar <rishabhb@codeaurora.org> wrote:
> >
> > During bootup since remote processors cannot request for
> > additional bus bandwidth from the interconect framework,
> > platform driver should provide the proxy resources. This
> > is useful for scenarios where the Q6 tries to access the DDR
> > memory in the initial stages of bootup. For e.g. during
> > bootup or after recovery modem Q6 tries to zero out the bss
> > section in the DDR. Since this is a big chunk of memory if
> > don't bump up the bandwidth we might encounter timeout issues.
> > This patch makes a proxy vote for maximizing the bus bandwidth
> > during bootup and removes it once processor is up.
> >
> > Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>
> The title of this patch contains "[PATCH 1/2]" but only one patch was
> sent to the linux-remoteproc mailing list.  Is this a mistake and this
> is a stand alone patch or another patch did not reach the list?
>

I see that you sent another patch [1] that seems to be stand alone but
when looking into the code function of_icc_get() is called, which does
reference the bindings in [1].

[1]. https://patchwork.kernel.org/patch/11463381/

> Thanks,
> Mathieu
>
> > ---
> >  drivers/remoteproc/qcom_q6v5_pas.c | 43 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 42 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> > index edf9d0e..8f5db8d 100644
> > --- a/drivers/remoteproc/qcom_q6v5_pas.c
> > +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/qcom_scm.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/remoteproc.h>
> > +#include <linux/interconnect.h>
> >  #include <linux/soc/qcom/mdt_loader.h>
> >  #include <linux/soc/qcom/smem.h>
> >  #include <linux/soc/qcom/smem_state.h>
> > @@ -28,6 +29,9 @@
> >  #include "qcom_q6v5.h"
> >  #include "remoteproc_internal.h"
> >
> > +#define PIL_TZ_AVG_BW  0
> > +#define PIL_TZ_PEAK_BW UINT_MAX
> > +
> >  struct adsp_data {
> >         int crash_reason_smem;
> >         const char *firmware_name;
> > @@ -62,6 +66,7 @@ struct qcom_adsp {
> >         int proxy_pd_count;
> >
> >         int pas_id;
> > +       struct icc_path *bus_client;
> >         int crash_reason_smem;
> >         bool has_aggre2_clk;
> >
> > @@ -124,6 +129,25 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
> >
> >  }
> >
> > +static int do_bus_scaling(struct qcom_adsp *adsp, bool enable)
> > +{
> > +       int rc;
> > +       u32 avg_bw = enable ? PIL_TZ_AVG_BW : 0;
> > +       u32 peak_bw = enable ? PIL_TZ_PEAK_BW : 0;
> > +
> > +       if (adsp->bus_client) {
> > +               rc = icc_set_bw(adsp->bus_client, avg_bw, peak_bw);
> > +               if (rc) {
> > +                       dev_err(adsp->dev, "bandwidth request failed(rc:%d)\n",
> > +                               rc);
> > +                       return rc;
> > +               }
> > +       } else
> > +               dev_info(adsp->dev, "Bus scaling not setup for %s\n",
> > +                       adsp->rproc->name);
> > +       return 0;
> > +}
> > +
> >  static int adsp_start(struct rproc *rproc)
> >  {
> >         struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> > @@ -131,9 +155,13 @@ static int adsp_start(struct rproc *rproc)
> >
> >         qcom_q6v5_prepare(&adsp->q6v5);
> >
> > +       ret = do_bus_scaling(adsp, true);
> > +       if (ret)
> > +               goto disable_irqs;
> > +
> >         ret = adsp_pds_enable(adsp, adsp->active_pds, adsp->active_pd_count);
> >         if (ret < 0)
> > -               goto disable_irqs;
> > +               goto unscale_bus;
> >
> >         ret = adsp_pds_enable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
> >         if (ret < 0)
> > @@ -183,6 +211,8 @@ static int adsp_start(struct rproc *rproc)
> >         adsp_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
> >  disable_active_pds:
> >         adsp_pds_disable(adsp, adsp->active_pds, adsp->active_pd_count);
> > +unscale_bus:
> > +       do_bus_scaling(adsp, false);
> >  disable_irqs:
> >         qcom_q6v5_unprepare(&adsp->q6v5);
> >
> > @@ -198,6 +228,7 @@ static void qcom_pas_handover(struct qcom_q6v5 *q6v5)
> >         clk_disable_unprepare(adsp->aggre2_clk);
> >         clk_disable_unprepare(adsp->xo);
> >         adsp_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
> > +       do_bus_scaling(adsp, false);
> >  }
> >
> >  static int adsp_stop(struct rproc *rproc)
> > @@ -280,6 +311,14 @@ static int adsp_init_regulator(struct qcom_adsp *adsp)
> >         return PTR_ERR_OR_ZERO(adsp->px_supply);
> >  }
> >
> > +static void adsp_init_bus_scaling(struct qcom_adsp *adsp)
> > +{
> > +       adsp->bus_client = of_icc_get(adsp->dev, NULL);
> > +       if (!adsp->bus_client)
> > +               dev_warn(adsp->dev, "%s: unable to get bus client \n",
> > +                       __func__);
> > +}
> > +
> >  static int adsp_pds_attach(struct device *dev, struct device **devs,
> >                            char **pd_names)
> >  {
> > @@ -410,6 +449,8 @@ static int adsp_probe(struct platform_device *pdev)
> >         if (ret)
> >                 goto free_rproc;
> >
> > +       adsp_init_bus_scaling(adsp);
> > +
> >         ret = adsp_pds_attach(&pdev->dev, adsp->active_pds,
> >                               desc->active_pd_names);
> >         if (ret < 0)
> > --
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
