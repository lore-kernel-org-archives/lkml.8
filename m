Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C85AC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7602921D7B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="S6ObeyaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbgDKX0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:26:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35359 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbgDKXLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:11:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id c7so7116709edl.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 16:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j1v+KX0c0vN9YAU7uM6QypK1ttzUW4y+OxpBn0M3m3M=;
        b=S6ObeyaX8+WvxpzJV4Jp692S50a2yGFQh+4wOaDJVvpFjCLDrfQyw1CF8MiCC/Hkoo
         Wu2yLceSH7wqAkDDS78Nm3CM0oxEYnNWKTuOzNspGDbKt70Ov+mkz08p+UqjRthkXDQe
         7g+ywrKByPcQX7Z4VirISCe93FyM5bqM/Cd59h6IO7TQQfn6Ng/bQpFzYYyC988z8brO
         WuH/iPJkS3KW0lt7gA2tvIDd86Q1P6r+mGijPNe3owwUZGobTjXFX8e6fSWQ1NTiM+AQ
         JfKFxArsy6uKqudGjR9mqyzywvRJikOWlwke+x9Hw9HGnRe5ql+mTFQAETohZEZ+DwUZ
         T40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1v+KX0c0vN9YAU7uM6QypK1ttzUW4y+OxpBn0M3m3M=;
        b=MJ++UtvYaUjn/5FDFsv2b2javtyMkwrYw5uSSQ0zHr1AekhZBKk2zpGtCUxOLsHj+o
         0Vl5Ybolxx2wKFdUA8zKZHhwCmYzSm1oIqGABG2NQMZYxzK4+z0AMwfsEsiKyj49wICG
         bnQUqjK0G496dq9WrCn+Sw6sX68v9hSP/948PaC1jVL++FzmeWSEbJeLS7slHUm9sgNB
         S7WfJ+AZar1QmWWETesYXpGeOgjkUIN2rKb/okbHHyYF3xU9d2/VLCVnJgN1lQ97M/id
         V+fnnGQuvaKR3kKOKBBy3130oQfI7DXky9B784+jxsPs9UQNcxU1lMYt+/QSPjhJOQMo
         R27Q==
X-Gm-Message-State: AGi0PuYH5ZdMP3IrjY4JLEpmK2Uv6kZdj4WGtCt4s+rV8EX5j58TtcjK
        LflV/NMqe9pzPqiIry1rtoIWqnBTyreHsU/mpFU1JQ==
X-Google-Smtp-Source: APiQypIQV+O4plRu4V7wCIyi5dxeIfE6EeeB3ExaZvqvAUx/G7mUWqkxg21V766Y2OZi676a3KrW4JA/WqDlJwvAoNw=
X-Received: by 2002:a17:906:2994:: with SMTP id x20mr9475367eje.156.1586646714555;
 Sat, 11 Apr 2020 16:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200410141813.29497-1-colin.king@canonical.com>
In-Reply-To: <20200410141813.29497-1-colin.king@canonical.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sat, 11 Apr 2020 20:11:43 -0300
Message-ID: <CAAEAJfB3D7KxruC2TzeEhyeF8qGHOWUa2hKmqcptub5gciSAxQ@mail.gmail.com>
Subject: Re: [PATCH] media: gspca: remove redundant assignment to variable status
To:     Colin King <colin.king@canonical.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020 at 11:18, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable status is being assigned a value that is never read.
> The assignment is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

> ---
>  drivers/media/usb/gspca/mr97310a.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/media/usb/gspca/mr97310a.c b/drivers/media/usb/gspca/mr97310a.c
> index 502fc2eaffe0..464aa61cd914 100644
> --- a/drivers/media/usb/gspca/mr97310a.c
> +++ b/drivers/media/usb/gspca/mr97310a.c
> @@ -287,7 +287,6 @@ static int zero_the_pointer(struct gspca_dev *gspca_dev)
>                         return err_code;
>
>                 err_code = cam_get_response16(gspca_dev, 0x21, 0);
> -               status = data[0];
>                 tries++;
>                 if (err_code < 0)
>                         return err_code;
> --
> 2.25.1
>
