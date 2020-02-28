Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC416C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69D220637
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mW96jfeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgB1Vu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 16:50:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35366 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgB1Vu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 16:50:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id a12so3886525ljj.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 13:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXH0XTxwssZu/l+4X5oAuR9SqggcCROpsGbcXwJvrqA=;
        b=mW96jfeglAZLByoAMZs51HsXxurOLdnvn7/kJk4cPKSvtrtzEcwPh/WcuUR/n4ZimP
         gJ1STaJE3Z4gZgXPb6McgLe7AtbFfpPrQQIJRswAqfL3U5p+fCb50cCBBaX2x24doKSG
         Jg3CW6nijHV9T+v2JiW7idDsQD33C1YopjdVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXH0XTxwssZu/l+4X5oAuR9SqggcCROpsGbcXwJvrqA=;
        b=sgOuCxYFlTGp4xQdLeO0sgIVBU6JR/1wQ3SwgzMPASzPV27Pv6RZAZp9H4fuZkVpVF
         BKXDD10dg0Ukvm46qddWz/sbIVDEFFykja3pWtsQubBG2V10QstXmpDepf9puNTMIA/c
         2ONEYw1v/bK1fnWzgjTSkAM73065g/iWLygRmJlc/dhvdBAJJIDgZT9aUlNA64ZC9tt2
         lgOtYlIcRv98t5Pfj7AW1NuufDsKQlUyN9INuiJIUV8UWqehHg6Ry2HgYVi2AgCLCpHt
         W7UlnrDwHHv7Nj5gTdomOgcma0LhGCcCtKFtuvx2rXdnW6pIF8qLwXm6of7P9ltQIrLE
         dSdA==
X-Gm-Message-State: ANhLgQ3a3JUIBnN4PVS/uRVzut27/Vrrt0reAjSO6VUFplq6GnVCnyHR
        qwOpeGD5StSrqY6x6rC5YJlLVSXEKCk=
X-Google-Smtp-Source: ADFU+vsBFNhdKICZRALJmKSAK0INYOGfIpaKny/I0ERvbSt85P91Z9wX9mvVXNcBgB02cfYalopIBA==
X-Received: by 2002:a2e:a361:: with SMTP id i1mr4018159ljn.29.1582926654509;
        Fri, 28 Feb 2020 13:50:54 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id z67sm5827269lfa.50.2020.02.28.13.50.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 13:50:53 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 7so3161891lfz.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 13:50:53 -0800 (PST)
X-Received: by 2002:a19:c611:: with SMTP id w17mr3806178lff.59.1582926652932;
 Fri, 28 Feb 2020 13:50:52 -0800 (PST)
MIME-Version: 1.0
References: <1582889903-12890-1-git-send-email-mkshah@codeaurora.org> <1582889903-12890-3-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1582889903-12890-3-git-send-email-mkshah@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 28 Feb 2020 13:50:16 -0800
X-Gmail-Original-Message-ID: <CAE=gft5aOtOx6MyuNuv3ebc6ZHmG_W3i0EA3HJjKceYMr7Nx3A@mail.gmail.com>
Message-ID: <CAE=gft5aOtOx6MyuNuv3ebc6ZHmG_W3i0EA3HJjKceYMr7Nx3A@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] soc: qcom: rpmh: Update dirty flag only when data changes
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 3:38 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Currently rpmh ctrlr dirty flag is set for all cases regardless of data
> is really changed or not. Add changes to update dirty flag when data is
> changed to newer values.
>
> Also move dirty flag updates to happen from within cache_lock and remove
> unnecessary INIT_LIST_HEAD() call and a default case from switch.
>
> Fixes: 600513dfeef3 ("drivers: qcom: rpmh: cache sleep/wake state requests")
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Srinivas Rao L <lsrao@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index eb0ded0..f28afe4 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -133,26 +133,30 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
>
>         req->addr = cmd->addr;
>         req->sleep_val = req->wake_val = UINT_MAX;
> -       INIT_LIST_HEAD(&req->list);
>         list_add_tail(&req->list, &ctrlr->cache);
>
>  existing:
>         switch (state) {
>         case RPMH_ACTIVE_ONLY_STATE:
> -               if (req->sleep_val != UINT_MAX)
> +               if (req->sleep_val != UINT_MAX) {
>                         req->wake_val = cmd->data;
> +                       ctrlr->dirty = true;
> +               }
>                 break;
>         case RPMH_WAKE_ONLY_STATE:
> -               req->wake_val = cmd->data;
> +               if (req->wake_val != cmd->data) {
> +                       req->wake_val = cmd->data;
> +                       ctrlr->dirty = true;
> +               }
>                 break;
>         case RPMH_SLEEP_STATE:
> -               req->sleep_val = cmd->data;
> -               break;
> -       default:
> +               if (req->sleep_val != cmd->data) {
> +                       req->sleep_val = cmd->data;
> +                       ctrlr->dirty = true;
> +               }
>                 break;
>         }
>
> -       ctrlr->dirty = true;
>  unlock:
>         spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
>
> @@ -287,6 +291,7 @@ static void cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
>
>         spin_lock_irqsave(&ctrlr->cache_lock, flags);
>         list_add_tail(&req->list, &ctrlr->batch_cache);
> +       ctrlr->dirty = true;

Is this fixing a case where we were not previously marking the
controller dirty but should have? I notice there's a fixes tag, but it
would be helpful to add something to the commit text indicating that
you're fixing a missing case where the controller should have been
marked dirty. With that fixed, you can add my tag:

Reviewed-by: Evan Green <evgreen@chromium.org>
