Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173B8C35E0D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D1F20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ER4Hn5y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbgBYT2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:28:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36399 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731425AbgBYT2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:28:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id d9so38476pgu.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 11:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=4tK5dhNanRBX4RJaY81MXL5uMw9VPzyZ3UaipGWjTeA=;
        b=ER4Hn5y39DsTdFq4OIFR/dyYBA/md+YMiH6Vlftw5sX/8I8svVtJwDWrl+hIbHDMI+
         9DIcp5qY/z7utP3Wlsfmi7SD9FiFgaz3JqHR/5d8KjPWEgJS68eSS/70DaFi0VVUDqjx
         qsRNASKUBSfoa6zYDICVI1jWv5RUSbtgDxLeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=4tK5dhNanRBX4RJaY81MXL5uMw9VPzyZ3UaipGWjTeA=;
        b=DxSeCE+D7NtFoU+xpI2KNhbqnH3xAba/5PBbUPAFg+X4jbGcVgWs+XDPIrimVBUSxu
         d+Vd840oaB7ceEcsdqoElK/7Fn3UhXQoMpS11ztLkormo+k0lCasSFA87t9ADLK14+rT
         MIIewgO4Ar6+2SUeo9ghdpi4KCx1conD3jenLmZxGib0LWxMllUZANWyDEt6CF85sV+n
         fw0geXxRlG9kB+OwRpKfFl/3q117hrhMqQHk8cCKH0+TuWHktSGPsYcWB3J1Is66C0QO
         2AhKFYb3iZ5NVJdru7/9q0C8J0cxMlmNFUvyyulQQ5R5joNIUeBPlZdHKnn5s2ek02Kw
         l0lw==
X-Gm-Message-State: APjAAAUCK7TyngmWuTzzRFCANUTC2nIXCLCQJMsuhNWpUqn/zvjg36X6
        hq8cI3uwdiwgf8Vdefm5FhuB9w==
X-Google-Smtp-Source: APXvYqx/CuR9tWXGTo9ivBHMqDj/j7Gy5ChN3CDCAyQZMV9kpz8TazoKp8muVVv6CLf1YgtUt+g7UA==
X-Received: by 2002:aa7:9808:: with SMTP id e8mr299103pfl.32.1582658880299;
        Tue, 25 Feb 2020 11:28:00 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c26sm18406262pfj.8.2020.02.25.11.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 11:27:59 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200219104148.1.I0183a464f2788d41e6902f3535941f69c594b4c1@changeid>
References: <20200219104148.1.I0183a464f2788d41e6902f3535941f69c594b4c1@changeid>
Subject: Re: [PATCH 1/4] drm/msm/dpu: Remove unused function arguments
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Drew Davenport <ddavenport@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Thomas Gleixner <tglx@linutronix.de>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Drew Davenport <ddavenport@chromium.org>,
        dri-devel@lists.freedesktop.org
Date:   Tue, 25 Feb 2020 11:27:58 -0800
Message-ID: <158265887882.177367.3011043098001339741@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Drew Davenport (2020-02-19 09:42:24)
> Several functions arguments in the resource manager are unused, so
> remove them.
>=20
> Signed-off-by: Drew Davenport <ddavenport@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

>=20
>  drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 37 ++++++++++----------------
>  1 file changed, 14 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm=
/disp/dpu1/dpu_rm.c
> index 23f5b1433b357..dea1dba441fe7 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -144,8 +144,7 @@ static int _dpu_rm_hw_blk_create(
>                 const struct dpu_mdss_cfg *cat,
>                 void __iomem *mmio,
>                 enum dpu_hw_blk_type type,
> -               uint32_t id,
> -               const void *hw_catalog_info)
> +               uint32_t id)

It would be good to use u32 instead of uint32_t in this code too. The
kernel style is to use the shorter name for that type.
