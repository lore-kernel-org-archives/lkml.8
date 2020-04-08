Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEF8C2BA80
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412F92075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KonMvLDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDHCus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 22:50:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34929 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgDHCur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 22:50:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id a13so1744622pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 19:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=JUXF7hM/mccP8YBSv8k1M2FRkWg1QLWdAClD45zoF40=;
        b=KonMvLDAFt3ozAn0+2/wsP0c5xo5b+hNVOzSBOLp/x0CNovDbKsm+UhULuUMmC5D+5
         ukMqw7dOF80Xv8Pk/DlQGB/JXqeXCIs/c/5dPHdcia7i2QGyTLJhJK9UofXg2uzPu4H6
         VBdyXC/zTpvt0zmf80LLyHx0y/2InrYjIxBJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=JUXF7hM/mccP8YBSv8k1M2FRkWg1QLWdAClD45zoF40=;
        b=ewMpshCNyrD8fEgab6w/vw5O0TGic80g6kWqSFSmFWgE8jJgnsRMLpkEBkZSJzDqoi
         muPYc0p4l3nQm3EoWtn8/qg5/3qWVLyhE4HCDFbyaozxkzZCbVAFrf6fXnaYyNOWqGJX
         0ioxB7PTvdLihQLoBEYHvqmXlztXOo9y6Dj6AdzX0//8bmI1X3c90IlXGE8fZvRNcRYI
         Zw7dcsCY+5+B1sVk+m72l8Dyd6RIl9DCIvL8mxhBekOvhvlS/VD9bgKXV4UhTnIH+b3+
         u+L8I65I23XNSoQz1E89LazLAN+Sz7JoDntyJDLqj8MIbzdRuh+nJrFMm/nxMfrJZ/pB
         zxuA==
X-Gm-Message-State: AGi0PuaYIH/JzDA2SIbBwLLr5DIyuK26+kdNr5USDzYa2JlfZ9gPGWj+
        S1x3Ztv8LlSqqc9AvURbMVvgyGRvFgQ=
X-Google-Smtp-Source: APiQypIREFpQNdyfpZWQZ7fuIoKTQzbCwB9eC/LyMF4RhE1zhQVPTI0b5JqFmD0p7Qjg6dKXPuq1OQ==
X-Received: by 2002:a65:67c7:: with SMTP id b7mr5006016pgs.345.1586314245452;
        Tue, 07 Apr 2020 19:50:45 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 135sm15636454pfu.207.2020.04.07.19.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 19:50:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1586154741-8293-5-git-send-email-mkshah@codeaurora.org>
References: <1586154741-8293-1-git-send-email-mkshah@codeaurora.org> <1586154741-8293-5-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v16 4/6] soc: qcom: rpmh: Invoke rpmh_flush() for dirty caches
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, mka@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        dianders@chromium.org, evgreen@chromium.org
Date:   Tue, 07 Apr 2020 19:50:43 -0700
Message-ID: <158631424318.216820.1843109743502322053@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-04-05 23:32:19)
> Add changes to invoke rpmh flush() from CPU PM notification.
> This is done when the last the cpu is entering power collapse and
> controller is not busy.
>=20
> Controllers that do have 'HW solver' mode do not need to register

Controllers that have 'HW solver' mode don't need to register? The 'do
have' is throwing me off.

> for CPU PM notification. They may be in autonomous mode executing
> low power mode and do not require rpmh_flush() to happen from CPU
> PM notification.
>=20
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  drivers/soc/qcom/rpmh-internal.h |  25 +++++---
>  drivers/soc/qcom/rpmh-rsc.c      | 123 +++++++++++++++++++++++++++++++++=
++----
>  drivers/soc/qcom/rpmh.c          |  26 +++------
>  3 files changed, 137 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index b718221..fbe1f3e 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -6,6 +6,7 @@
[...]
> +
> +static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
> +                                   unsigned long action, void *v)
> +{
> +       struct rsc_drv *drv =3D container_of(nfb, struct rsc_drv, rsc_pm);
> +       int ret =3D NOTIFY_OK;
> +
> +       spin_lock(&drv->pm_lock);
> +
> +       switch (action) {
> +       case CPU_PM_ENTER:

I thought CPU_PM notifiers weren't supposed to be used anymore? Or at
least, the genpd work that has gone on for cpuidle could be used here in
place of CPU_PM notifiers? And so this isn't actually any different
than what was proposed originally to use genpd for this?

> +               cpumask_set_cpu(raw_smp_processor_id(),

Why do we need to use raw_smp_processor_id()? smp_processor_id() should
work just as well?

> +                               &drv->cpus_entered_pm);
> +
> +               if (!cpumask_equal(&drv->cpus_entered_pm, cpu_online_mask=
))
> +                       goto exit;
> +               break;
> +       case CPU_PM_ENTER_FAILED:
> +       case CPU_PM_EXIT:
> +               cpumask_clear_cpu(raw_smp_processor_id(),
> +                                 &drv->cpus_entered_pm);
> +               goto exit;
> +       }
> +
> +       ret =3D rpmh_rsc_ctrlr_is_busy(drv);
> +       if (ret) {
> +               ret =3D NOTIFY_BAD;
> +               goto exit;
> +       }
> +
> +       ret =3D rpmh_flush(&drv->client);
> +       if (ret)
> +               ret =3D NOTIFY_BAD;
> +       else
> +               ret =3D NOTIFY_OK;
> +
> +exit:
> +       spin_unlock(&drv->pm_lock);
> +       return ret;
> +}
> +
