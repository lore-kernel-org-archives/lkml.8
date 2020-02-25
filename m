Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BE0C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C54218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6kt1zJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgBYL4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:56:34 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33857 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbgBYL4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:56:33 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so12269286oig.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 03:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=08sJ0p764WpC9VXzCjK0OX/0j9ek/zNoqprgBJ/BgB4=;
        b=S6kt1zJWxZB2GTmtEiug9PG0YaQcP88HT4NJkgK/hddPAS9kquyrMoipcjL9Fk8u67
         /ypRGwQyXQMJapl0e+8QbfvPM5PatbPfbdep2FGMxWO0oJtbfFBQPZCpx2z71xEEUV9u
         1KS0TqV/BaWSosrRa5v865hsclvU4vCR7XYfEYy9oCU7XvUc4PhII3qUvt/trDlVBjq2
         mAlXTDaWiIqlWnfeT9+WaMLfnoD9n0v+E+fLwdSQQaTh+zJI8M0l75HW+/mWS7t6TDsz
         53ay2AFNDGvs3SvEOTYWjYAC63NY5aCgHQdMq9Jr23T5VaYta3E/UeSDfCddeUO2MLYr
         r9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=08sJ0p764WpC9VXzCjK0OX/0j9ek/zNoqprgBJ/BgB4=;
        b=SPCRIanvKsQ1HygJVrZddD39ODgnHfTz8i+vzgsB0SRel+CdlibL1ZribDF28pdTvg
         +af/ClC5eRWLyCOpXf/AI8SrjY9+50e6XSs/EXXxv+d6Kg4+7bP8B7wOH9vYypO7QckT
         VcgNAy4K/mwIoJLeReS5OAnaqmmDVU9HbwS0OWwJ8DkzX549syfAjhdRj9UhiZ5eDYYo
         UPsUD6HTxZvBDOyhXjiq8o2gUJVy9RfvlsdQH354qaYuwk0Jf1vVsV+ygjWjea1jYzjf
         N44vLtNoux3pKMJeqeQ0hY/bgHo4zt/eEQbAX3Ggku+e1J0/JRUtmsDtmxcAq5q4we7c
         R1pA==
X-Gm-Message-State: APjAAAUcnTaKQT80VSLrK1pgRVs2gC/buKD9ktdgrUcbUsod+odf6vBj
        os2Qo6Cjy7aebDBPrntD+QsJpSAsJ3MefIKeo3Q=
X-Google-Smtp-Source: APXvYqzBZLPznuE8rHduZrjrutnclI/gMZCPXyx1jYU6G/fyIXIWBokuKn5HYd1RRuVadu67KkrTyhvxxBlc2SOIgHo=
X-Received: by 2002:aca:c709:: with SMTP id x9mr3041022oif.130.1582631792885;
 Tue, 25 Feb 2020 03:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20200223231711.157699-1-jbi.octave@gmail.com> <20200223231711.157699-28-jbi.octave@gmail.com>
In-Reply-To: <20200223231711.157699-28-jbi.octave@gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 25 Feb 2020 13:55:50 +0200
Message-ID: <CAFCwf11JWL4ZiYzkGHH3hw_MNkrZf1KWhmTiKLfbggq_9d7jiA@mail.gmail.com>
Subject: Re: [PATCH 27/30] habanalabs: Add missing annotation for goya_hw_queues_lock()
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     boqun.feng@gmail.com,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomer Tayar <ttayar@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Dalit Ben Zoor <dbenzoor@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 1:18 AM Jules Irenge <jbi.octave@gmail.com> wrote:
>
> Sparse reports a warning at goya_hw_queues_lock()
> warning: context imbalance in goya_hw_queues_lock() - wrong count at exit
> The root cause is a missing annotation at goya_hw_queues_lock()
> Add the missing __acquires(&goya->hw_queues_lock) annotation
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/misc/habanalabs/goya/goya.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index 7344e8a222ae..8ca7ee57cbc1 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -5073,6 +5073,7 @@ static bool goya_is_device_idle(struct hl_device *hdev, u32 *mask,
>  }
>
>  static void goya_hw_queues_lock(struct hl_device *hdev)
> +       __acquires(&goya->hw_queues_lock)
>  {
>         struct goya_device *goya = hdev->asic_specific;
>
> --
> 2.24.1
>
This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Applied to -next
Thanks,
Oded
