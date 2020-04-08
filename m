Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1B4C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 22:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00309206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 22:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJntHgdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDHWQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 18:16:57 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38660 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgDHWQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 18:16:57 -0400
Received: by mail-il1-f193.google.com with SMTP id n13so8389126ilm.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 15:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzVxSixdDt1O0VOgAo+Th9WLxzFXgFEejCcj1fB2noU=;
        b=MJntHgdHaMoa2uHflpDCu/GRrlybPn7ZLYhlnbGIVfZTwKncXBUQzp2YrleXxKladS
         bDUOmJIiCf7sBFXIqRQTMrL0FFrm3Cez8v+8b8TLNvJ1yubGhWGaeyqrUZ4NYLuvwXak
         FLqbqgs+ujkbsdDM3Va5BPOiE5Tes7mmO4GQWboTiTPz8wfF+tBhXdZtPZwl1f7AceJy
         9Vw/A+i0efw3UNFVqbytxFPEvQAzRoN1nqDOKyaOfrSwEgv/k1rRH1psocSUo7wF2jj+
         FGFgw0oHiT9Vmu3ikb6CG8Oz9U2ObqqlMK6P5GKUVSdxRMa/6PmO/k5nOOUrtXN1esNW
         JWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzVxSixdDt1O0VOgAo+Th9WLxzFXgFEejCcj1fB2noU=;
        b=tngLIg8Zcdh1/00TKxvKcJSWBV87bYiJML1uzzVULTFmnN+Jk/PM85LNswRPbBzaCf
         RsnC36U74KEUrQEg/drG36KXjb9Ug2Dqqtw5w9+49oOyK57YPJknFWdMMUwwj68wM39c
         Hj9aDqSwVsmGa+9/t+g1yiIkL7fHPUml+2yf7zCmRn2zydGeSZEpNieDK/92UrW3EZYV
         x8WAskhfGWWk1kHu12ZEU+48bV981ZSSKJXikkboiXq3N3RNFCZM31uIlKk33zbxFPlC
         WyrlZDRenbhWkl1RLMSXrpJmGWH3ErL2vbf5g9kNh9OlJ2AmWcop4oQ2/nOXYqDB6TRB
         PgdQ==
X-Gm-Message-State: AGi0Pubqm1OHFSO6lioy51Eu3sFjvPMdXOBfQLExZ1eH+6l/gNbP/zuW
        VUkSKBnKIsk2f7zM79gB/RXY9LuWQ7fV4YrBo7pqnw==
X-Google-Smtp-Source: APiQypJv2Cyi9gP/dcqOojScIBtwDkCLb5aev+ZZkFAnJOvfoL201N9g9V7UTneKOgiESidv2zLhUz4xK6OrnHIM9F8=
X-Received: by 2002:a05:6e02:68a:: with SMTP id o10mr10471153ils.72.1586384216677;
 Wed, 08 Apr 2020 15:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200403175005.17130-1-elder@linaro.org> <20200403175005.17130-2-elder@linaro.org>
In-Reply-To: <20200403175005.17130-2-elder@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 8 Apr 2020 16:16:45 -0600
Message-ID: <CANLsYkx4pSs+j83ewJpOkQmY7=q=k71xg7N9A=sDWrDZKzzQTA@mail.gmail.com>
Subject: Re: [PATCH 1/3] remoteproc: fix a bug in rproc_alloc()
To:     Alex Elder <elder@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Andy Gross <agross@kernel.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Fri, 3 Apr 2020 at 11:50, Alex Elder <elder@linaro.org> wrote:
>
> If ida_simple_get() returns an error when called in rproc_alloc(),
> put_device() is called to clean things up.  By this time the rproc
> device type has been assigned, with rproc_type_release() as the
> release function.
>
> The first thing rproc_type_release() does is call:
>     idr_destroy(&rproc->notifyids);
>
> But at the time the ida_simple_get() call is made, the notifyids
> field in the remoteproc structure has not been initialized.
>
> I'm not actually sure this case causes an observable problem, but
> it's incorrect.  Fix this by initializing the notifyids field before
> calling ida_simple_get() in rproc_alloc().
>

Both Suman and I are meddling in function rproc_alloc() for our
respective work [1][2].  I will add this patch to a set that refactors
rproc_alloc() as soon as v5.7-rc1 comes out.  That way we can all base
our work on the same foundation and Bjorn doesn't have to fix 3
different merge conflicts.

Thanks,
Mathieu

[1]. https://patchwork.kernel.org/patch/11456385/
[2]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=261069

> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index e12a54e67588..59b6eb22f01c 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2054,6 +2054,8 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>         rproc->dev.class = &rproc_class;
>         rproc->dev.driver_data = rproc;
>
> +       idr_init(&rproc->notifyids);
> +
>         /* Assign a unique device index and name */
>         rproc->index = ida_simple_get(&rproc_dev_index, 0, 0, GFP_KERNEL);
>         if (rproc->index < 0) {
> @@ -2078,8 +2080,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>
>         mutex_init(&rproc->lock);
>
> -       idr_init(&rproc->notifyids);
> -
>         INIT_LIST_HEAD(&rproc->carveouts);
>         INIT_LIST_HEAD(&rproc->mappings);
>         INIT_LIST_HEAD(&rproc->traces);
> --
> 2.20.1
>
