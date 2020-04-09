Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D161C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B1620757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PvHz7dF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgDIUXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:23:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47024 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgDIUXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:23:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id x2so1626539plv.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 13:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=sBJcOnwg24jleMutN+HP4yNIjd4URpK+S2uxHFb+3BM=;
        b=PvHz7dF20As5sbbYhB4q2ZvdzPKLTHniMisQ6lTKn6fL1VKD9aT+MsurZd5T4Fv5ay
         qj11BWf5ZcmpCRPmF20yYNN0PA7qRI6ovhUYTvUx37Fpt8ufd3xInESvlq9hOzs0Vx81
         z7jN2AMxqMEh4XWww6NDXOnw+Cs/pYKSa+yM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=sBJcOnwg24jleMutN+HP4yNIjd4URpK+S2uxHFb+3BM=;
        b=dUUYE/Gxt9kfTNT9bs7IwoTMCtCTkJfQjF7j8UXlTpqA8z0uydlSN5lSPkyHsignLI
         TRZ5ZgeqS6sQzPjRJNR4cXgrq1aM/GjVs5ffz8gTlJ4MP3ZVoyQuFF87woxiooeQwUsN
         /UX7nBku6iKsTV6eN4NjmgGcLkvoVR2lkTpCxwYHwuRHl7J1Qe8m1OFHeTMCdEN18Yim
         tEmsbIz3La/ueQriCdIGw1XX++fpHSuAWV+9ggN71XtryZOxJrx1myeU3zNammML7gEw
         KcFnfFJCDOaiE0B2kqIFh1zvABHeKxNLoFeuSTiFA0IQf9XnRXDFOBc5HCda/xz5D/CY
         EDwA==
X-Gm-Message-State: AGi0PuahsvngfsN7Gc8bRponNDmyRdTZJHpbkAVvwBjsjDygw1hoPHy8
        VKsPcjC14Tv9bp4RI8/Lh0iyqzxHNtg=
X-Google-Smtp-Source: APiQypLbn4cmz+FXdn7gXrnO7qPuX2QK1uwvFuORE9G27aRb5HAsQ3Iu8eAoYmuET7GFLdrJviAD2g==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr1346044plb.121.1586463796146;
        Thu, 09 Apr 2020 13:23:16 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h10sm18856937pgf.23.2020.04.09.13.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 13:23:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1586154741-8293-4-git-send-email-mkshah@codeaurora.org>
References: <1586154741-8293-1-git-send-email-mkshah@codeaurora.org> <1586154741-8293-4-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v16 3/6] soc: qcom: rpmh: Invalidate SLEEP and WAKE TCSes before flushing new data
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, mka@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        dianders@chromium.org, evgreen@chromium.org
Date:   Thu, 09 Apr 2020 13:23:14 -0700
Message-ID: <158646379456.77611.8638840660664120750@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-04-05 23:32:18)
> TCSes have previously programmed data when rpmh_flush is called.

rpmh_flush()

> This can cause old data to trigger along with newly flushed.
>=20
> Fix this by cleaning SLEEP and WAKE TCSes before new data is flushed.
>=20
> With this there is no need to invoke rpmh_rsc_invalidate() call from
> rpmh_invalidate().
>=20
> Simplify rpmh_invalidate() by moving invalidate_batch() inside.
>=20
> Fixes: 600513dfeef3 ("drivers: qcom: rpmh: cache sleep/wake state request=
s")
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  drivers/soc/qcom/rpmh.c | 41 ++++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index 03630ae..a75f3df 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -498,24 +492,25 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
>  }
> =20
>  /**
> - * rpmh_invalidate: Invalidate all sleep and active sets
> - * sets.
> + * rpmh_invalidate: Invalidate sleep and wake sets in batch_cache
>   *
>   * @dev: The device making the request
>   *
> - * Invalidate the sleep and active values in the TCS blocks.
> + * Invalidate the sleep and wake values in batch_cache.
>   */
>  int rpmh_invalidate(const struct device *dev)
>  {
>         struct rpmh_ctrlr *ctrlr =3D get_rpmh_ctrlr(dev);
> -       int ret;
> -
> -       invalidate_batch(ctrlr);
> +       struct batch_cache_req *req, *tmp;
> +       unsigned long flags;
> =20
> -       do {
> -               ret =3D rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
> -       } while (ret =3D=3D -EAGAIN);
> +       spin_lock_irqsave(&ctrlr->cache_lock, flags);
> +       list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
> +               kfree(req);
> +       INIT_LIST_HEAD(&ctrlr->batch_cache);
> +       ctrlr->dirty =3D true;
> +       spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
> =20
> -       return ret;
> +       return 0;

Now this always returns 0. Maybe it should become a void function, but
doing that requires a change in the interconnect code so maybe do it
later.
