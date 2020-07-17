Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89E0C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98BAD20684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="TmH4Q9Lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgGQTsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgGQTsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:48:43 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D6AC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 12:48:43 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f23so11622077iof.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7NpXK7JzSgbCI2SuDg2Kli8CN6q+obgk+/Z7+f8u0g=;
        b=TmH4Q9LgejjEiu1Qaerlx7MagvT4cQZhkhKFD8S9oozZ4oumKAnSPAZdi0n02nFbwh
         xhdImQYdacWvA+zIrwUxLaJk0+p3VQphqd6nihnTS8LGLjCFfAk2cOxMWEpYfxRFy2Hg
         2Frx+TLq5CVW0xNJJvTtyZtDq5knxKSY9AinoPbfgAcHtfUR2m1uz41/fovMfy36dNyi
         moah1R8A1ofRQ4NOh6Z6qHpAoIzmQCmxaquPu8t1Rok3c6dPSn234Lts6XgJP+E8pD4n
         9wQLx2CKAItaKafogOSBDENoXtEtFckkXMOwAqN32x3LD3PYvdWt1z+yYIwxOuQzq1dl
         07Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7NpXK7JzSgbCI2SuDg2Kli8CN6q+obgk+/Z7+f8u0g=;
        b=svLLFTzTqhDcqncw8C/rNGg/LAeFHDm1GSkADOc0NXF/oIOmF6JkQEVCdwTeLDUqFO
         7/zgAoXcLjplO9ua18qHK53jCjB+xm5qeUbvWt6Z3wb0TBRTL4ZZGkLneeCXqLH7EUwZ
         SEabTwERsFiUEMa9vOsKxhVXIFs8qm93FuByxnY1+r3ugq5p4F2yTJE6Ys70QNwiTkqx
         KBxPslJwjS4d0CQFNkknaMBjDf6j5OJTNnTf7OnOTnhbH7s4xbRZxDIUirUNfsbCFeny
         C6HWT6+DrrgAfZ107B7r66Gc4gLeuUtwUyBE91UrqChqtvcHUnhFSmq+COD4tLBd0c46
         4btA==
X-Gm-Message-State: AOAM5314POqNBQU24cYH7PGy6071w38VoUyppATVit63O4/SEcWjg8QZ
        IXw4eYJQVxf9opAuZMbTSridqzBlkZejdtu4Mkqhi2NRT4A=
X-Google-Smtp-Source: ABdhPJyY9OnzdwqNgOEY8poFbPfdtNAb7beS3Be89cJ/AsAbTErEXIkHXehj7O5ureYZn+24mXJO8R7RaiaqWG4nlFQ=
X-Received: by 2002:a05:6602:21c3:: with SMTP id c3mr10602170ioc.93.1595015322241;
 Fri, 17 Jul 2020 12:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200717165538.3275050-1-lee.jones@linaro.org> <20200717165538.3275050-10-lee.jones@linaro.org>
In-Reply-To: <20200717165538.3275050-10-lee.jones@linaro.org>
From:   Crt Mori <cmo@melexis.com>
Date:   Fri, 17 Jul 2020 21:48:06 +0200
Message-ID: <CAKv63uvMb1R2OyBwFuCTU+E5YQfHwBB+bqRP+jXO9yn4e2Wu6w@mail.gmail.com>
Subject: Re: [PATCH 09/30] iio: temperature: mlx90632: Function parameter
 descriptions must match exactly
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Johnathan Iain Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-arm-kernel@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Crt Mori <cmo@melexis.com>

On Fri, 17 Jul 2020 at 18:56, Lee Jones <lee.jones@linaro.org> wrote:
>
> '*'s are not welcome in kerneldoc parameter names.
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/iio/temperature/mlx90632.c:175: warning: Function parameter or member 'data' not described in 'mlx90632_perform_measurement'
>
> Cc: Crt Mori <cmo@melexis.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/iio/temperature/mlx90632.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index eaca6ba068646..b9a8089be3f63 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -164,8 +164,8 @@ static s32 mlx90632_pwr_continuous(struct regmap *regmap)
>  }
>
>  /**
> - * mlx90632_perform_measurement - Trigger and retrieve current measurement cycle
> - * @*data: pointer to mlx90632_data object containing regmap information
> + * mlx90632_perform_measurement() - Trigger and retrieve current measurement cycle
> + * @data: pointer to mlx90632_data object containing regmap information
>   *
>   * Perform a measurement and return latest measurement cycle position reported
>   * by sensor. This is a blocking function for 500ms, as that is default sensor
> --
> 2.25.1
>
