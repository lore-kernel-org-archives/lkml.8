Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813A3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606EA208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z72Udmli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgFRSF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729414AbgFRSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 14:05:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5FDC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 11:05:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e18so3250129pgn.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=U/NBx5iNuxPhAKHb+kUULsBBMbGGlzASGtNIcw4W5uE=;
        b=Z72UdmlicDyKDeBJTvQpVBA3ht1UUD1b0OD1QjLw/ez1ugGh5UQKAMSLjzs45zbd8W
         Z943RjYBpyrshoTRMDtmv8OsXhbIPDWquxtsT+ddOZhy4NjS2dFIMzzquu2HAa9WCfRR
         Q8Opd/GT3dGPW++wFXkafku/r93AieqnWAq7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=U/NBx5iNuxPhAKHb+kUULsBBMbGGlzASGtNIcw4W5uE=;
        b=PEiB8r9YYDI/oD/yX2zgmR4/WePUuhQc+B/cyg9UjIA3teG3d0BqN1q9KDrJy6CAHB
         aaImGXQmD7szJ1LnkXiFJJDXip23sUWIxOKZjwp4mdgT5/tB1Mig91ocOltrpnbO5pcs
         2DLct5og3JROiaqHQr9Z9UlG+YAqqM1aDEVsnLBfUgv0iS7IizE4Gw5CR7p5H+gKZf5z
         BlSKPx+NYUM4H5oeMdqB5CHJgl4AYjnoH5hartOGlSUDKh5cH4bHaYSjhgDuxPf+3IEu
         7f5kE8oBac3CbIaNFoybthdyd2IeZZjHJmSbhkr3YSy8HSprAp4Z16uHvvoBmnQFonKo
         yLMQ==
X-Gm-Message-State: AOAM533HEfw8ybngHZw9I8qXNzq0cfFSU0kD7uKcz8KYkQEIQ6TG88Wj
        PsFTYktzQ8N5twkYvZnY9Js7LA==
X-Google-Smtp-Source: ABdhPJx3p0Z9jr1KsFl6XpysHkvnoVCnziYUSjlxCRl5yETq1eNcKTLonfueBPsrFSZtLmcL6Q7P0g==
X-Received: by 2002:a63:5a58:: with SMTP id k24mr3964247pgm.1.1592503525574;
        Thu, 18 Jun 2020 11:05:25 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d6sm3133807pjh.5.2020.06.18.11.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 11:05:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200618080459.v4.5.Ib1e6855405fc9c99916ab7c7dee84d73a8bf3d68@changeid>
References: <20200618150626.237027-1-dianders@chromium.org> <20200618080459.v4.5.Ib1e6855405fc9c99916ab7c7dee84d73a8bf3d68@changeid>
Subject: Re: [PATCH v4 5/5] spi: spi-geni-qcom: Don't keep a local state variable
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Date:   Thu, 18 Jun 2020 11:05:23 -0700
Message-ID: <159250352382.62212.8085892973272354046@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-06-18 08:06:26)
> @@ -126,20 +120,23 @@ static void handle_fifo_timeout(struct spi_master *=
spi,
>         struct geni_se *se =3D &mas->se;
> =20
>         spin_lock_irq(&mas->lock);
> -       reinit_completion(&mas->xfer_done);
> -       mas->cur_mcmd =3D CMD_CANCEL;
> -       geni_se_cancel_m_cmd(se);
> +       reinit_completion(&mas->cancel_done);
>         writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> +       mas->cur_xfer =3D NULL;

BTW, is this necessary? It's subtlely placed here without a comment why.

> +       mas->tx_rem_bytes =3D mas->rx_rem_bytes =3D 0;
> +       geni_se_cancel_m_cmd(se);
>         spin_unlock_irq(&mas->lock);
> -       time_left =3D wait_for_completion_timeout(&mas->xfer_done, HZ);
