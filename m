Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998CDC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F472098B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ch5116YJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbgIHSi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731222AbgIHSiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:38:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A86C061756
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:38:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id n3so138456pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=DjkIx1P1Yaxa+Auz4Hv5F6fQbSDCX4zGHI1CORxsnvo=;
        b=Ch5116YJyepkGpw+1UW17XG01LG/Pm90dnlvn725RqhqaU4K8logIxM79H9+sIUoQ8
         OiB2hKqFTTb/CrA4MTXj0FA17E0hyz3kemhaxUxNt+kgpXnoSGgFoS2faieUZXeiearM
         Bq3F/+1d+pj1Mc5PD3zu/eq5qxogXCWs0O71k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=DjkIx1P1Yaxa+Auz4Hv5F6fQbSDCX4zGHI1CORxsnvo=;
        b=iOsSxZ21s6j8EpSoZPCDzK0pVqs9ZvpcyUdqkP745u8b8Re4Gc/MzMeadTwRkWeUyK
         BkOi7apndZQ/2z/A5+Hhf3gGjhUdzhfRxNcjMqmXSvbUZIwzqBdugN9aOwhQoOa1XeqG
         XgIw+E9d5Rb/aHX3NIXikU1AfgDHWEVaSp1nMpcE+TG8rvEOCPmWBKDItduNlLUVtw4m
         V58scTg0UGv0NZ6pDkTy6T1R8OT1I1VhYWqtlMxAfof+VAI6zlO+rgT0uJ3V+jvGmE1N
         orK17w55ITx57qj7wwa++4XusKZxnxTPac0733JRqWuiUJNtg46jVgXiLLCiKKGJpL8D
         5S5g==
X-Gm-Message-State: AOAM533Z0GXTOoUmYo46zM5Zon5pMl8bEwI6wrBVeKdG7Ij7v1ngJP7E
        q6JxIAfpC6zSRYUMgcHL08ZgjFLGen+XRQ==
X-Google-Smtp-Source: ABdhPJxQU7U8Qy5RDG4z+Rc6wVE9+Uj/BS7LyHlH3lOBzdg4vrt5MnIa+fMmuCRzZtHg0Ko5860+sw==
X-Received: by 2002:a17:90a:930e:: with SMTP id p14mr171770pjo.49.1599590299498;
        Tue, 08 Sep 2020 11:38:19 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id e123sm133688pfh.167.2020.09.08.11.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:38:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1599536678-4666-1-git-send-email-mansur@codeaurora.org>
References: <1599536678-4666-1-git-send-email-mansur@codeaurora.org>
Subject: Re: [PATCH 2/2] venus: core: vote for video-mem icc path and change avg, peak bw
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org,
        Mansur Alisha Shaik <mansur@codeaurora.org>
To:     Mansur Alisha Shaik <mansur@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Date:   Tue, 08 Sep 2020 11:38:17 -0700
Message-ID: <159959029779.454335.10674172341529908104@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mansur Alisha Shaik (2020-09-07 20:44:38)
> Currently we are voting for venus0-ebi path during buffer processing
> with an average bandwidth of all the instances and unvoting during
> session release.
>=20
> While video streaming when we try to do XO-SD using the command
> "echo mem > /sys/power/state command" , device is not entering
> to suspend state and from interconnect summary seeing votes for venus0-ebi
>=20
> Corrected this by voting for venus0-ebi path in venus_runtime_resume

venus_runtime_resume() please so we know it's a function.

> and unvote during venus_runtime_suspend.

venus_runtime_suspend().

>=20
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> ---

Any Fixes: tag?

>  drivers/media/platform/qcom/venus/core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/pla=
tform/qcom/venus/core.c
> index 4857bbd..79d8600 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -373,6 +373,10 @@ static __maybe_unused int venus_runtime_suspend(stru=
ct device *dev)
>         if (ret)
>                 return ret;
> =20
> +       ret =3D icc_set_bw(core->video_path, 0, 0);
> +       if (ret)
> +               return ret;
> +
>         return ret;
>  }
> =20
> @@ -382,7 +386,11 @@ static __maybe_unused int venus_runtime_resume(struc=
t device *dev)
>         const struct venus_pm_ops *pm_ops =3D core->pm_ops;
>         int ret;
> =20
> -       ret =3D icc_set_bw(core->cpucfg_path, 0, kbps_to_icc(1000));
> +       ret =3D icc_set_bw(core->video_path, kbps_to_icc(20000), 0);

This also shows that the arguments to icc_set_bw() we're backwards? Can
that be fixed in another patch instead of putting it in this one?
