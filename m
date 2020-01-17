Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4B2C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6158C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgAQOIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:08:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45638 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgAQOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:08:12 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so22589126otp.12;
        Fri, 17 Jan 2020 06:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxppi7pIj8e5sSfdrBldrP06c7HVZk7Bw8KYy+1AxaI=;
        b=SuS3x1PPA24kEimBCf17OmnyBoagBAeii7ZEUupWp/mX+fh8hP+df9x9zYG60Nl5gG
         gPMVkK7fN7zQ6GsyOCH+fZxu3ZdlmX9jAB8eNhQgZQFs8d+K6tlt3ZRtjDqFS/LootbR
         7aSHuAAU6HkpHXN4pR648bNyTMi5EtIVNVeIJivTkfcgdU1D6djC36hhpYPxmuJHexLC
         Xo4HO81UaQ4WeaKTR+EHX/mIeFAfvPDJZBYnLpTjtACaAup6olQ+983IhqRC64T3Baz4
         1/tsHvqWD4DMiFzS42ozkMl6Jvb9lsevoVSdTyMDYYYE9SNfoAJczpzU20b6U8qTnKi7
         707g==
X-Gm-Message-State: APjAAAVlQTaU3YHf9j42Qtwh+jIytGgrtySIUiEH13+/OUssINfCankf
        Gi8IqebyTEi+TtRYDIXfT9+CL4y4Y4IMlyLU+ZM=
X-Google-Smtp-Source: APXvYqz7FBS/FtklMvm4sU6CKtZ5bnsEJ9X8DfF6z56uTKJJzPruMzWUh0wv+Ed3caYwy5q2M9Zw0WNyCnMymcjACSk=
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr6064660ots.250.1579270091226;
 Fri, 17 Jan 2020 06:08:11 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200116145116eucas1p2d512db3f05f01d87bc9039af5bf70af3@eucas1p2.samsung.com>
 <c687dbc5-cf5a-9508-2a61-e757a1a14568@samsung.com>
In-Reply-To: <c687dbc5-cf5a-9508-2a61-e757a1a14568@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Jan 2020 15:08:00 +0100
Message-ID: <CAMuHMdW0qSAn3S+bpFieP=xukK5SapAq1oRC8XouuMJ6fgqOBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] video: fbdev: sh_mobile_lcdcfb: fix sparse warnings
 about using incorrect types
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 3:51 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Use ->screen_buffer instead of ->screen_base to fix sparse warnings.
>
> [ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
>   pointer") for details. ]
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
