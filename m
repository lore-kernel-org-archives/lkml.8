Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A402BC2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8062820768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bv2uDX/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404168AbgDOHGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393646AbgDOHGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:06:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F322DC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 00:06:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n10so1128210pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 00:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=gB44+UKmPj76z1NnBeNC/neb/wrLk3JtJ7qsM1U7HOo=;
        b=bv2uDX/wYmyaJRdNHZFQQZu1/xQ1jmFZPrcbg6gnQwnqZSvbs6nnsOyArJhjM/Y7gH
         jw08VROk9uuYZnSN9yC8WHydWZYCGMl1xzZoAlCN3gYiGpmiP5U4G/uVJt50OH/mWkbY
         SzCeq49IxgkOhR1rq2RX3CRF+M+B4HcdFzyTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=gB44+UKmPj76z1NnBeNC/neb/wrLk3JtJ7qsM1U7HOo=;
        b=iDNDIN+Cii/YiD6CHEFq2zQfeyqkxnB6BeYgwxwNQefv7va5p3e6Nw1GlzqO/urEE0
         mBWnOvZKqcemz5AzMiTinRPsbDuu1JVaRPwOQeLRqYPZ3JCwo929btA0pefOXRYJvJ6A
         /Yktc7g6Mb8m/BQ9v7FGXRFbHk7rT8vMo/cllzGH86ISy7pfw3jaaJXzqhDmN4InULgI
         VJhCF5FLFRfrAvjHB7L4V9tDiVi4I9ndVFhsSNDPmm0ExNq8vi97IK/k1Li9xhiBbT6e
         OEJ3Kgmb3s+yp7OJs5Ifl/OczM5kkhGIndn6qfrlvVYi0cFTnmUuS05NLWSvxQuGHbVz
         ywrQ==
X-Gm-Message-State: AGi0PubeaRkA8VvVTPnkQw4Njt8YsBsdeI+TE9AzPYP7+jSI5xMqoHzw
        5joM5pUuwVd357OymJC06s7kVg==
X-Google-Smtp-Source: APiQypLD1gz2pRrZgJsDuTIFnJu127jJZKw1RN/gdgSCN2IicZ2Bw01LaGz7MXEESFuqe5wOWrAXDw==
X-Received: by 2002:a63:2c07:: with SMTP id s7mr24739126pgs.230.1586934395227;
        Wed, 15 Apr 2020 00:06:35 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i9sm13150593pfd.148.2020.04.15.00.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 00:06:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200414102312.1.I295cb72bc5334a2af80313cbe97cb5c9dcb1442c@changeid>
References: <20200414102312.1.I295cb72bc5334a2af80313cbe97cb5c9dcb1442c@changeid>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Remove the pm_lock
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mkshah@codeaurora.org, mka@chromium.org, evgreen@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Wed, 15 Apr 2020 00:06:32 -0700
Message-ID: <158693439287.105027.14163532309100663169@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-14 10:23:26)
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 732316bb67dc..4e45a8ac6cde 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -791,36 +790,36 @@ static int rpmh_rsc_cpu_pm_callback(struct notifier=
_block *nfb,
>  {
>         struct rsc_drv *drv =3D container_of(nfb, struct rsc_drv, rsc_pm);
>         int ret =3D NOTIFY_OK;
> -
> -       spin_lock(&drv->pm_lock);
> +       int cpus_in_pm;
> =20
>         switch (action) {
>         case CPU_PM_ENTER:
> -               cpumask_set_cpu(smp_processor_id(), &drv->cpus_entered_pm=
);
> -
> -               if (!cpumask_equal(&drv->cpus_entered_pm, cpu_online_mask=
))
> -                       goto exit;
> +               cpus_in_pm =3D atomic_inc_return(&drv->cpus_in_pm);
> +               if (cpus_in_pm < num_online_cpus())

Might be worth adding a comment here explaining that num_online_cpus()
is stable because this is called from the cpu PM notifier path and a CPU
can't go offline or come online without stopping the world.

> +                       return NOTIFY_OK;
>                 break;
>         case CPU_PM_ENTER_FAILED:
>         case CPU_PM_EXIT:
> -               cpumask_clear_cpu(smp_processor_id(), &drv->cpus_entered_=
pm);
> -               goto exit;
> -       }
> -
> -       ret =3D rpmh_rsc_ctrlr_is_busy(drv);
> -       if (ret) {
> -               ret =3D NOTIFY_BAD;
> -               goto exit;
> +               atomic_dec(&drv->cpus_in_pm);

We should also handle the cluster PM enums. I'm actually confused the
compiler didn't complain about that already. Presumably we want to just
ignore the cluster PM notifications because the counter handles it
already. Looks like other code uses NOTIFY_DONE for the default case.

> +               return NOTIFY_OK;
>         }
> =20
> -       ret =3D rpmh_flush(&drv->client);
> -       if (ret)
> +       /*
> +        * It's likely we're on the last CPU. Grab the drv->lock and write
> +        * out the sleep/wake commands to RPMH hardware. Grabbing the lock
> +        * means that if we race with another CPU coming up we are still
> +        * guaranteed to be safe. If another CPU came up just after we ch=
ecked
> +        * and has already started an active transfer then we'll notice w=
e're
> +        * busy and abort. If another CPU comes up after we start flushin=
g it
> +        * will be blocked from starting an active transfer until we're d=
one
> +        * flushing. If another CPU starts an active transfer after we re=
lease
> +        * the lock we're still OK because we're no longer the last CPU.
> +        */
> +       spin_lock(&drv->lock);

This should probably be a raw spinlock given that this is called from
the idle path and sleeping there is not very nice for RT. That can come
later of course.

> +       if (rpmh_rsc_ctrlr_is_busy(drv) || !rpmh_flush(&drv->client))

It almost feels like rpmh_rsc_ctrlr_is_busy() shold be rolled straight
into rpmh_flush() so that rpmh_flush() fails if there are active
requests in flight.

>                 ret =3D NOTIFY_BAD;
> -       else
> -               ret =3D NOTIFY_OK;
> +       spin_unlock(&drv->lock);

I'm looking at the latest linux-next code that I think has all the
patches on the list for rpmh (latest commit is 1d3c6f86fd3f ("soc: qcom:
rpmh: Allow RPMH driver to be loaded as a module")). I see that
tcs->lock is taken first, and then drv->lock is taken next in
tcs_write(). But then this takes drv->lock first and then calls
rpmh_flush() (which goes to a different file.. yay!) and that calls
flush_batch() which calls rpmh_rsc_write_ctrl_data() (back to this
file... yay again!) which then locks tcs->lock. Isn't that an ABBA
deadlock?

> =20
> -exit:
> -       spin_unlock(&drv->pm_lock);
>         return ret;
