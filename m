Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D38C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EED32082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1NVM1lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBLKwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:52:09 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45579 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgBLKwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:52:08 -0500
Received: by mail-qk1-f193.google.com with SMTP id a2so1537386qko.12;
        Wed, 12 Feb 2020 02:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EMzVX/YLP1+SbnH42xOv/8pwooiQMHByy//3lEv1sak=;
        b=C1NVM1lkDhTP1uaUXH/4tREjDZmVhVHdcfee7xWWYIxzGthzZ2uOqaS4rfx0JzxDXf
         fFC30AojhbAiB5CCG1Rsu4xlSjOyQu6EkIK0+D65+KMLqFjg6S4y0NZG75LPmh6mhXTM
         ydZTRzHOSk419OewdH+1en5gZAorTHIZLt/xlohddGvT/3dJanL/QfapvFF6qPLj4a4M
         FwM5Ni5YwXHppO1nJvRuKNaYFBHA0q9VWLAhbGGzRSGPcargXRHspy5vYmM/mdQEYh6L
         /YYsvmjobcHPHNqz3LwnQ9fsFbV4RlFCl81VJ5PadWTK15ZNu5myqnxkG8TWe5HayuaR
         e1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EMzVX/YLP1+SbnH42xOv/8pwooiQMHByy//3lEv1sak=;
        b=tsgtkh4Vd5CwroIKeyrI0jV4/wsRAvUxlWJu8bfr1szRBwssODcUtB37kCZykmV1yQ
         R8PNFA0sqS3D67SSXd+8KvFLI7c6t41QRZNVuErZu7+r2vr3fuDJ4Wcud6vtpxS6Fcq0
         UHWsbOD/fRABOAxkw8I79T0LdQivL/lhpQIL6fXdWfmxIqlgquRgj5fy56TAK+hXh2ei
         TtpxCCS8xJgKv8m/OHBCyovo9mtx5M7HL1ov4IOGiildFS3vp7yLapGlC3KVsvbBUfR0
         5RZ/eKRufYR2zSs51+zSxhkZwkjhEg7zbv/IeSFjuzex/7XUMnIt0Cgq5aX75toYwbOu
         I4Zw==
X-Gm-Message-State: APjAAAW+F69TbEJpljZemV/y/BlRr+Fb3tG2HjDio1zHcELVvVVhR7R+
        vZ14lHzOxSL/cX0PiH4Mac/pSkGNug8EyAUIIh4z2ZoW
X-Google-Smtp-Source: APXvYqxc8fvhT+2QyzzS4gwE7LYquSfP7WbDWdAaH5y6o3SbzNRJOgC25Rebn1OlJvtQpjKu+rrs/yl53YPKVlNA/8U=
X-Received: by 2002:a05:620a:204d:: with SMTP id d13mr9812950qka.56.1581504726180;
 Wed, 12 Feb 2020 02:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20200212101651.9010-1-geert+renesas@glider.be>
In-Reply-To: <20200212101651.9010-1-geert+renesas@glider.be>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Wed, 12 Feb 2020 18:51:28 +0800
Message-ID: <CAEbi=3fMRq++Eot+BEtCedeyhM65kTc+nS7=inCTR8MkT5srww@mail.gmail.com>
Subject: Re: [PATCH] nds32: Replace <linux/clk-provider.h> by <linux/of_clk.h>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Nick Hu <nickhu@andestech.com>, Vincent Chen <deanbo422@gmail.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> =E6=96=BC 2020=E5=B9=B42=E6=9C=
=8812=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:16=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> The Andes platform code is not a clock provider, and just needs to call
> of_clk_init().
>
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/nds32/kernel/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/nds32/kernel/time.c b/arch/nds32/kernel/time.c
> index ac9d78ce3a818926..574a3d0a853980a9 100644
> --- a/arch/nds32/kernel/time.c
> +++ b/arch/nds32/kernel/time.c
> @@ -2,7 +2,7 @@
>  // Copyright (C) 2005-2017 Andes Technology Corporation
>
>  #include <linux/clocksource.h>
> -#include <linux/clk-provider.h>
> +#include <linux/of_clk.h>
>
>  void __init time_init(void)
>  {

Thank you, Geert.

Let me know if you like to put in your tree or nds32's.
Acked-by: Greentime Hu <green.hu@gmail.com>
