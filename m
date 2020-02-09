Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA21DC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 17:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B46B20715
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 17:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="X+AKAv0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgBIRJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 12:09:30 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:47093 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgBIRJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 12:09:30 -0500
Received: by mail-vk1-f194.google.com with SMTP id u6so1143815vkn.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 09:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cTVo2U9KTioTCLP3XSeVoyKOkuiWdF4fuEhq6a/+zbQ=;
        b=X+AKAv0ks82oqD2t43ZyCyFh4luZOixMPsW/OkM+5LgO6hPsyHglS+wnA0F57EvaUD
         9VwI9lpadXXTYOX6asNXnGu443eMa4uJ8yx8yy60PKBgXVuaV4tDXQwgaZgrUbVEFl7f
         pU0rwxwpz5hM132RK81iOb55ipALo18tXAwL1fFKcuoc5uG8jBudWt/8LH3l/K7oOG+V
         GXXoWiJ0wkluun8HzmK1nvtbGGF4U9slgifNe6d4G05iM+axcRRbv1IXe1RAl8zQyh8D
         otSdVWdFNz4HZmgzlDKGqYtWBgnNWN9Q7/DuSYtxuPp98xFgs1HaUScivcwc3EmNog+W
         CInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cTVo2U9KTioTCLP3XSeVoyKOkuiWdF4fuEhq6a/+zbQ=;
        b=K13jin0vC9nxyY6IWrYqimgZnKF/sFC7a1pU+1vj0yvTsS6ZLP9Cz5mdtV9hFeDXRx
         2EVktm5yVaGXiWnDRwAo0wES56tob7YpUhL13lKxv/RrUuNiaszrKvxy9yX0IDKISZba
         jghX6DjU2i5zKeZhCJ9zwE9cJ5maAj5MZFLLFh2Xx/MT6JRFgzr2F5omLuKzfqHwl5Dc
         JwaPHBiJasSK8y1WKGkc0gw2Gx2qD8JL7Un886/qnFAAPux0+knofD+cpT+WItNP/TRG
         iyWAipc0oloh8mS5uopZFb6bjyt2t7CEe1VBpLWvQZVOt0hDp1maIq4JZTSVwYgkLihy
         WuHg==
X-Gm-Message-State: APjAAAUPUqXmSgYd1s1Lo0H9cHyW8c1tb1fvh9lJxRXMNbiAGg45MRT2
        OQTilgULuOz6zlQFLE1+dJ7CvBSso9koCs2J1c5SMQ==
X-Google-Smtp-Source: APXvYqwC5E1vHaoVe5TD+NTJeDM1TW1xkDse7uMbo4tmjWmqlr3IF/TBaj3K9VzqmEoolu6n+MFERw4KggOFhiWhAQM=
X-Received: by 2002:a1f:9684:: with SMTP id y126mr4247264vkd.84.1581268169240;
 Sun, 09 Feb 2020 09:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20200202155019.1029993-1-nfraprado@protonmail.com>
In-Reply-To: <20200202155019.1029993-1-nfraprado@protonmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sun, 9 Feb 2020 14:09:17 -0300
Message-ID: <CAAEAJfDGicyS9RGkLfPEBP9FCVHiu4tYsnq+BKPsez7pWSxXXQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] media: vimc: Add support for GBR and BGR formats on
 source pad of debayer
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@protonmail.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkcamp@lists.libreplanetbr.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Feb 2020 at 12:50, N=C3=ADcolas F. R. A. Prado
<nfraprado@protonmail.com> wrote:
>
> The objective of this series is to add support for GBR and BGR media bus =
formats
> for the source pad of debayer subdevices of the vimc driver.
>

Can you elaborate why is this needed, e.g. what use-case is this enabling,
or what is this fixing?

Thanks,
Ezequiel

> Since the GBR media bus code doesn't have a corresponding pixelformat, it=
 needed
> to use the pixelformat of another bus code.
>
> The first patch makes it possible to have multiple media bus codes mappin=
g to
> the same pixelformat.
>
> The second patch adds the GBR media bus code, using the RGB pixelformat.
>
> The third patch adds support for GBR and BGR media bus formats on the sou=
rce
> pad of the debayer subdevice.
>
> This patch series passed all tests of v4l2-compliance:
> $ compliance_git -m /dev/media0
> v4l2-compliance SHA: c4a62f26c5c3ecd856ca10cf2f0d35d100283d7f, 64 bits, 6=
4-bit time_t
>
> Grand Total for vimc device /dev/media0: 461, Succeeded: 461, Failed: 0, =
Warnings: 0
>
> N=C3=ADcolas F. R. A. Prado (3):
>   media: vimc: Support multiple buscodes for each pixelformat
>   media: vimc: Add GBR media bus code
>   media: vimc: deb: Add support for GBR and BGR bus formats on source
>     pad
>
>  drivers/media/platform/vimc/vimc-common.c  | 68 +++++++++++++---------
>  drivers/media/platform/vimc/vimc-common.h  |  9 ++-
>  drivers/media/platform/vimc/vimc-debayer.c | 53 +++++++++++++----
>  drivers/media/platform/vimc/vimc-scaler.c  | 10 +++-
>  drivers/media/platform/vimc/vimc-sensor.c  |  6 +-
>  5 files changed, 102 insertions(+), 44 deletions(-)
>
> --
> 2.25.0
>
>
