Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BD7C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A1B20409
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6Yk57QA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCILwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:52:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46290 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCILwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:52:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id a22so9751478oid.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4HPoRw+ValB5ZbyEUy46k2en5A7aJXO+W5FltijQOQ=;
        b=k6Yk57QAQsG+jr62EeMZFC2rxh4PDkZCHhrgk9UjV+35yOIWaVn2Xlje8cbGmQQS57
         T4FripUMPXasCBwaPUdzqe6wANX7a2DxCQ9sSQtpKfA7HNjV4ajf5CA2lX75xD/AHP06
         BpO/+1BZb1DzPdLny6RB42ufghknOZ3hfEMqTHREbv1+CQvfQB05IeV4vf/EtevYrhYH
         k3wqMARQI//6vyQXxQU2zTxH9oIRhTn4bsucHdzwecxPNG7pTa9gQ1+JI/dK/1T/NR6j
         mMAPx8ec+rYXV/Qiv/9uMzIAF25K1eS03O2TGTzIQBg27vJbV0p3q353y1dOdxOZ6GWi
         k13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4HPoRw+ValB5ZbyEUy46k2en5A7aJXO+W5FltijQOQ=;
        b=ukd7p63SgoW8KQwf1lbqZ+wC9wjBz7Xdzy5ZwZSdS6x7D1H1+uiGe0mzTcJdvKEaNv
         zgU8w+ZnPGUeVaxFqEkfin5ZIQXrOdfC9Lgl3AsDF3R7smsXgg6v4rigdPPu1TgZqLMP
         vNojZjA+NwH2ePiuScnVDjf2J6+Jxv55y9pCIyNNe6OMNnXLuDuNz0nvpdPucTaMp34k
         8w0YNg+tj1ErVJmNwALtFa7HHkN3cPAqbtanPAWAsXpWzGMKm/uV4cirnwNOwkGR4XHx
         d6mS3rCoZTTetefM2LHkhgMC7xXsE0sPhEnWIitN5gD0zuC7WMzs6coYMwC060Fz2v9K
         Dt6g==
X-Gm-Message-State: ANhLgQ0XLXric5N76OgFNRL7KznGSy0P0QANMJ25FkNFCUAExIC2s+3H
        Eyuna63nL0wPmSKYtBLZdm613M4IH8RsR2nnA0TjOQ==
X-Google-Smtp-Source: ADFU+vv1+chTLOhUJera67jlIXT1UdFlZALI0u8sTrfTccw0pNHY5BnNHlPCESLK/t/7gZ8HM+Fvx/w0k6AyTbriI6s=
X-Received: by 2002:aca:5ed4:: with SMTP id s203mr6837973oib.102.1583754738385;
 Mon, 09 Mar 2020 04:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200309112547.22123-1-oshpigelman@habana.ai>
In-Reply-To: <20200309112547.22123-1-oshpigelman@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 9 Mar 2020 13:51:40 +0200
Message-ID: <CAFCwf11VL2S96Moi8M3rPXdNrPH02aXnGvxeHRgQ=w80GEfsVA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: add print upon clock change
To:     Omer Shpigelman <oshpigelman@habana.ai>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 1:25 PM Omer Shpigelman <oshpigelman@habana.ai> wrote:
>
> Add print upon clock slow down due to power consumption or overheating.
> In addition, add print when back to optimal clock.
>
> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> ---
>  drivers/misc/habanalabs/goya/goya.c           | 50 ++++++++++++++++++-
>  .../include/goya/goya_async_events.h          |  4 ++
>  2 files changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index 9d4295cc83cf..1ccf2ed9a8dc 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -324,7 +324,11 @@ static u32 goya_all_events[] = {
>         GOYA_ASYNC_EVENT_ID_DMA_BM_CH1,
>         GOYA_ASYNC_EVENT_ID_DMA_BM_CH2,
>         GOYA_ASYNC_EVENT_ID_DMA_BM_CH3,
> -       GOYA_ASYNC_EVENT_ID_DMA_BM_CH4
> +       GOYA_ASYNC_EVENT_ID_DMA_BM_CH4,
> +       GOYA_ASYNC_EVENT_ID_POWER_ENV_S,
> +       GOYA_ASYNC_EVENT_ID_POWER_ENV_E,
> +       GOYA_ASYNC_EVENT_ID_THERMAL_ENV_S,
> +       GOYA_ASYNC_EVENT_ID_THERMAL_ENV_E
>  };
>
>  static int goya_mmu_clear_pgt_range(struct hl_device *hdev);
> @@ -4389,6 +4393,14 @@ static const char *_goya_get_event_desc(u16 event_type)
>                 return "TPC%d_bmon_spmu";
>         case GOYA_ASYNC_EVENT_ID_DMA_BM_CH0 ... GOYA_ASYNC_EVENT_ID_DMA_BM_CH4:
>                 return "DMA_bm_ch%d";
> +       case GOYA_ASYNC_EVENT_ID_POWER_ENV_S:
> +               return "POWER_ENV_S";
> +       case GOYA_ASYNC_EVENT_ID_POWER_ENV_E:
> +               return "POWER_ENV_E";
> +       case GOYA_ASYNC_EVENT_ID_THERMAL_ENV_S:
> +               return "THERMAL_ENV_S";
> +       case GOYA_ASYNC_EVENT_ID_THERMAL_ENV_E:
> +               return "THERMAL_ENV_E";
>         default:
>                 return "N/A";
>         }
> @@ -4619,6 +4631,33 @@ static int goya_unmask_irq(struct hl_device *hdev, u16 event_type)
>         return rc;
>  }
>
> +static void goya_print_clk_change_info(struct hl_device *hdev, u16 event_type)
> +{
> +       switch (event_type) {
> +       case GOYA_ASYNC_EVENT_ID_POWER_ENV_S:
> +               dev_info_ratelimited(hdev->dev,
> +                       "Clock throttling due to power consumption\n");
> +               break;
> +       case GOYA_ASYNC_EVENT_ID_POWER_ENV_E:
> +               dev_info_ratelimited(hdev->dev,
> +                       "Power envelop is safe, back to optimal clock\n");
> +               break;
> +       case GOYA_ASYNC_EVENT_ID_THERMAL_ENV_S:
> +               dev_info_ratelimited(hdev->dev,
> +                       "Clock throttling due to overheating\n");
> +               break;
> +       case GOYA_ASYNC_EVENT_ID_THERMAL_ENV_E:
> +               dev_info_ratelimited(hdev->dev,
> +                       "Thermal envelop is safe, back to optimal clock\n");
> +               break;
> +
> +       default:
> +               dev_err(hdev->dev, "Received invalid clock change event %d\n",
> +                       event_type);
> +               break;
> +       }
> +}
> +
>  void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
>  {
>         u32 ctl = le32_to_cpu(eq_entry->hdr.ctl);
> @@ -4702,6 +4741,15 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
>                 goya_unmask_irq(hdev, event_type);
>                 break;
>
> +       case GOYA_ASYNC_EVENT_ID_POWER_ENV_S:
> +       case GOYA_ASYNC_EVENT_ID_POWER_ENV_E:
> +       case GOYA_ASYNC_EVENT_ID_THERMAL_ENV_S:
> +       case GOYA_ASYNC_EVENT_ID_THERMAL_ENV_E:
> +               goya_print_irq_info(hdev, event_type, false);
> +               goya_print_clk_change_info(hdev, event_type);
> +               goya_unmask_irq(hdev, event_type);
> +               break;
> +
>         default:
>                 dev_err(hdev->dev, "Received invalid H/W interrupt %d\n",
>                                 event_type);
> diff --git a/drivers/misc/habanalabs/include/goya/goya_async_events.h b/drivers/misc/habanalabs/include/goya/goya_async_events.h
> index bb7a1aa3279e..6be41a846c99 100644
> --- a/drivers/misc/habanalabs/include/goya/goya_async_events.h
> +++ b/drivers/misc/habanalabs/include/goya/goya_async_events.h
> @@ -188,6 +188,10 @@ enum goya_async_event_id {
>         GOYA_ASYNC_EVENT_ID_HALT_MACHINE = 485,
>         GOYA_ASYNC_EVENT_ID_INTS_REGISTER = 486,
>         GOYA_ASYNC_EVENT_ID_SOFT_RESET = 487,
> +       GOYA_ASYNC_EVENT_ID_POWER_ENV_S = 507,
> +       GOYA_ASYNC_EVENT_ID_POWER_ENV_E = 508,
> +       GOYA_ASYNC_EVENT_ID_THERMAL_ENV_S = 509,
> +       GOYA_ASYNC_EVENT_ID_THERMAL_ENV_E = 510,
>         GOYA_ASYNC_EVENT_ID_LAST_VALID_ID = 1023,
>         GOYA_ASYNC_EVENT_ID_SIZE
>  };
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
