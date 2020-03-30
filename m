Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1E4C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3897F2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 19:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OmXL0tBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgC3TDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:03:47 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:49381 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbgC3TDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:03:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585595025; h=Message-ID: References: In-Reply-To: Subject:
 To: From: Date: Content-Transfer-Encoding: Content-Type: MIME-Version:
 Sender; bh=AQGiG5GDREzTfhSq9CASDUgd4b4IkanSkzsRnrcZxMs=; b=OmXL0tBiC8cQKq78SxbE6PKh5NW7SXXI2Y/Kc1YFiwJYqteBr/1SgIVjqdeet+hVJP4o0Z+F
 fl6cuOAc3qyJLo0tm6dG5ZVLCq0FA90vwGZIlwnOW1biiz4vSrp20C4OeqOYGC3pTiE0sP4E
 EKu8puLhDdWgfANBwpMLm57eJY0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e824284.7f655b780ed8-smtp-out-n02;
 Mon, 30 Mar 2020 19:03:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 337E9C43636; Mon, 30 Mar 2020 19:03:32 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5CF7EC433BA;
        Mon, 30 Mar 2020 19:03:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Mar 2020 12:03:30 -0700
From:   rishabhb@codeaurora.org
To:     undisclosed-recipients:;
Subject: Re: [PATCH 1/2] remoteproc: qcom: Add bus scaling capability during
 bootup
In-Reply-To: <CANLsYkzNKDwL6PSSagvk6YWRedLKmW80ji3nOYy1VrPQ3cP-8w@mail.gmail.com>
References: <1585357147-4616-1-git-send-email-rishabhb@codeaurora.org>
 <CANLsYkxV7xWUkggBXF=ziGfmLs-EZewuzCzZ3fq56CR+xA0poQ@mail.gmail.com>
 <CANLsYkzNKDwL6PSSagvk6YWRedLKmW80ji3nOYy1VrPQ3cP-8w@mail.gmail.com>
Message-ID: <f049524d9789d005ba83b51d30011bcb@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-30 09:13, Mathieu Poirier wrote:
> On Mon, 30 Mar 2020 at 10:06, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
>> 
>> Hi Rishabh,
>> 
>> On Fri, 27 Mar 2020 at 18:59, Rishabh Bhatnagar 
>> <rishabhb@codeaurora.org> wrote:
>> >
>> > During bootup since remote processors cannot request for
>> > additional bus bandwidth from the interconect framework,
>> > platform driver should provide the proxy resources. This
>> > is useful for scenarios where the Q6 tries to access the DDR
>> > memory in the initial stages of bootup. For e.g. during
>> > bootup or after recovery modem Q6 tries to zero out the bss
>> > section in the DDR. Since this is a big chunk of memory if
>> > don't bump up the bandwidth we might encounter timeout issues.
>> > This patch makes a proxy vote for maximizing the bus bandwidth
>> > during bootup and removes it once processor is up.
>> >
>> > Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>> 
>> The title of this patch contains "[PATCH 1/2]" but only one patch was
>> sent to the linux-remoteproc mailing list.  Is this a mistake and this
>> is a stand alone patch or another patch did not reach the list?
>> 
> 
> I see that you sent another patch [1] that seems to be stand alone but
> when looking into the code function of_icc_get() is called, which does
> reference the bindings in [1].
> 
> [1]. https://patchwork.kernel.org/patch/11463381/
> 
>> Thanks,
>> Mathieu
Yes its supposed to be a patchset of 2, somehow the numbering got messed 
up.
I'll resend the two patches so that you can take a look.
>> 
>> > ---
>> >  drivers/remoteproc/qcom_q6v5_pas.c | 43 +++++++++++++++++++++++++++++++++++++-
>> >  1 file changed, 42 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>> > index edf9d0e..8f5db8d 100644
>> > --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> > +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> > @@ -20,6 +20,7 @@
>> >  #include <linux/qcom_scm.h>
>> >  #include <linux/regulator/consumer.h>
>> >  #include <linux/remoteproc.h>
>> > +#include <linux/interconnect.h>
>> >  #include <linux/soc/qcom/mdt_loader.h>
>> >  #include <linux/soc/qcom/smem.h>
>> >  #include <linux/soc/qcom/smem_state.h>
>> > @@ -28,6 +29,9 @@
>> >  #include "qcom_q6v5.h"
>> >  #include "remoteproc_internal.h"
>> >
>> > +#define PIL_TZ_AVG_BW  0
>> > +#define PIL_TZ_PEAK_BW UINT_MAX
>> > +
>> >  struct adsp_data {
>> >         int crash_reason_smem;
>> >         const char *firmware_name;
>> > @@ -62,6 +66,7 @@ struct qcom_adsp {
>> >         int proxy_pd_count;
>> >
>> >         int pas_id;
>> > +       struct icc_path *bus_client;
>> >         int crash_reason_smem;
>> >         bool has_aggre2_clk;
>> >
>> > @@ -124,6 +129,25 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>> >
>> >  }
>> >
>> > +static int do_bus_scaling(struct qcom_adsp *adsp, bool enable)
>> > +{
>> > +       int rc;
>> > +       u32 avg_bw = enable ? PIL_TZ_AVG_BW : 0;
>> > +       u32 peak_bw = enable ? PIL_TZ_PEAK_BW : 0;
>> > +
>> > +       if (adsp->bus_client) {
>> > +               rc = icc_set_bw(adsp->bus_client, avg_bw, peak_bw);
>> > +               if (rc) {
>> > +                       dev_err(adsp->dev, "bandwidth request failed(rc:%d)\n",
>> > +                               rc);
>> > +                       return rc;
>> > +               }
>> > +       } else
>> > +               dev_info(adsp->dev, "Bus scaling not setup for %s\n",
>> > +                       adsp->rproc->name);
>> > +       return 0;
>> > +}
>> > +
>> >  static int adsp_start(struct rproc *rproc)
>> >  {
>> >         struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>> > @@ -131,9 +155,13 @@ static int adsp_start(struct rproc *rproc)
>> >
>> >         qcom_q6v5_prepare(&adsp->q6v5);
>> >
>> > +       ret = do_bus_scaling(adsp, true);
>> > +       if (ret)
>> > +               goto disable_irqs;
>> > +
>> >         ret = adsp_pds_enable(adsp, adsp->active_pds, adsp->active_pd_count);
>> >         if (ret < 0)
>> > -               goto disable_irqs;
>> > +               goto unscale_bus;
>> >
>> >         ret = adsp_pds_enable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
>> >         if (ret < 0)
>> > @@ -183,6 +211,8 @@ static int adsp_start(struct rproc *rproc)
>> >         adsp_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
>> >  disable_active_pds:
>> >         adsp_pds_disable(adsp, adsp->active_pds, adsp->active_pd_count);
>> > +unscale_bus:
>> > +       do_bus_scaling(adsp, false);
>> >  disable_irqs:
>> >         qcom_q6v5_unprepare(&adsp->q6v5);
>> >
>> > @@ -198,6 +228,7 @@ static void qcom_pas_handover(struct qcom_q6v5 *q6v5)
>> >         clk_disable_unprepare(adsp->aggre2_clk);
>> >         clk_disable_unprepare(adsp->xo);
>> >         adsp_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
>> > +       do_bus_scaling(adsp, false);
>> >  }
>> >
>> >  static int adsp_stop(struct rproc *rproc)
>> > @@ -280,6 +311,14 @@ static int adsp_init_regulator(struct qcom_adsp *adsp)
>> >         return PTR_ERR_OR_ZERO(adsp->px_supply);
>> >  }
>> >
>> > +static void adsp_init_bus_scaling(struct qcom_adsp *adsp)
>> > +{
>> > +       adsp->bus_client = of_icc_get(adsp->dev, NULL);
>> > +       if (!adsp->bus_client)
>> > +               dev_warn(adsp->dev, "%s: unable to get bus client \n",
>> > +                       __func__);
>> > +}
>> > +
>> >  static int adsp_pds_attach(struct device *dev, struct device **devs,
>> >                            char **pd_names)
>> >  {
>> > @@ -410,6 +449,8 @@ static int adsp_probe(struct platform_device *pdev)
>> >         if (ret)
>> >                 goto free_rproc;
>> >
>> > +       adsp_init_bus_scaling(adsp);
>> > +
>> >         ret = adsp_pds_attach(&pdev->dev, adsp->active_pds,
>> >                               desc->active_pd_names);
>> >         if (ret < 0)
>> > --
>> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> > a Linux Foundation Collaborative Project
