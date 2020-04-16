Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9C6C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 23:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463A92053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 23:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b+6VDpJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgDPX7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 19:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725770AbgDPX7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 19:59:01 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AD2C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 16:59:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kb16so291468pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 16:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=FLWZq8AE4gZ7QviLVtSYRyebpAMt/+sMwOVeXrCKpEQ=;
        b=b+6VDpJQbgNfJbl+SSfpjwemQsFrkixSTJALMx4v7dWF3H8eAevcS4Mr0g7DIVi+v7
         v2Sc5SgvZn3LAkCtxandNCI3xu/LOqj/kClcpDWly3f9B8LJ5+e6EBMyYAwSxLndkyhp
         AVZPQ0AyosSCY8c8E/RvSJm4BvvLdYIfY5uuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=FLWZq8AE4gZ7QviLVtSYRyebpAMt/+sMwOVeXrCKpEQ=;
        b=XS1SqJrVAhX9CZBzvUDNnPdSlTXZOLe5zYfSFD0Ar230slvrp29pmmUgoC7nmfLdQ/
         UAV8C+Gqhmb8zxN0dIQczrnLhzLUrlivPXzK1fI5MyfCJKfPNSeUd6pYPhY9W0F3bKaA
         mT+ZALtjp+9k50lWEYl7BdpVQYHN6TmAlV3yQcxmWaQBFwmrqOkVW1NLhecGOtjbOAoE
         azooIGGr//3B1RgbOE57mnlT/o/KbGoq9gFOeF70qEVKEvH9hh1vL42bOB9xABkBCI6u
         xpeIy8GtS7QQRgprhQ6oeW0wA2Cja8+ppfcQt6CbBclEA4LVb1/1VBS/fAYU0kdgMXZ2
         aLAQ==
X-Gm-Message-State: AGi0PubjZFo+K7RSVTKSv5V8FcvB90uCXuYPwfoZt8dDDhY31lbkqVca
        +xvainDVvOVklvlFRbb5O4YlMExTfpM=
X-Google-Smtp-Source: APiQypL9DkzbkP69P/kl5Tvz4PJpFH1vGa4D1NY1hvSZZ95YX+Y0YPx0Ny7lJfrxucut0r6NEGPh2Q==
X-Received: by 2002:a17:90a:19ca:: with SMTP id 10mr1063701pjj.23.1587081539567;
        Thu, 16 Apr 2020 16:58:59 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p1sm3675780pjr.40.2020.04.16.16.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 16:58:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1586703004-13674-3-git-send-email-mkshah@codeaurora.org>
References: <1586703004-13674-1-git-send-email-mkshah@codeaurora.org> <1586703004-13674-3-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v17 2/6] soc: qcom: rpmh: Update dirty flag only when data changes
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, mka@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        dianders@chromium.org, evgreen@chromium.org
Date:   Thu, 16 Apr 2020 16:58:57 -0700
Message-ID: <158708153779.132238.7823999141480422982@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-04-12 07:50:00)
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index eb0ded0..03630ae 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -133,26 +134,27 @@ static struct cache_req *cache_rpm_request(struct r=
pmh_ctrlr *ctrlr,
> =20
>         req->addr =3D cmd->addr;
>         req->sleep_val =3D req->wake_val =3D UINT_MAX;
> -       INIT_LIST_HEAD(&req->list);
>         list_add_tail(&req->list, &ctrlr->cache);
> =20
>  existing:
> +       old_sleep_val =3D req->sleep_val;
> +       old_wake_val =3D req->wake_val;
> +
>         switch (state) {
>         case RPMH_ACTIVE_ONLY_STATE:
> -               if (req->sleep_val !=3D UINT_MAX)
> -                       req->wake_val =3D cmd->data;
> -               break;
>         case RPMH_WAKE_ONLY_STATE:
>                 req->wake_val =3D cmd->data;
>                 break;
>         case RPMH_SLEEP_STATE:
>                 req->sleep_val =3D cmd->data;
>                 break;
> -       default:
> -               break;
>         }
> =20
> -       ctrlr->dirty =3D true;
> +       ctrlr->dirty =3D (req->sleep_val !=3D old_sleep_val ||
> +                       req->wake_val !=3D old_wake_val) &&
> +                       req->sleep_val !=3D UINT_MAX &&
> +                       req->wake_val !=3D UINT_MAX;

Can this change ctrl->dirty from true to false? I'm worried that we need
to make this a saturating assignment instead of an assignment.

	ctrl->dirty =3D ctrl->dirty || (req->sleep_val !=3D .. );

> +
>  unlock:
>         spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
>
