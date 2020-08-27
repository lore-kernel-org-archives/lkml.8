Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA966C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77F620738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgH0Hgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:36:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39148 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgH0Hgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:36:42 -0400
Received: by mail-ot1-f67.google.com with SMTP id r8so3659478ota.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bczqUQFB57ZFAWLvm+qps8KvfzclY1FoGAFfhuT5eN4=;
        b=JvGEWqEMWXcS+6OrXvVIRLsmCMsoouWipUzoeWmURTUGCCbquS0kVW53Ra/y7gAlXV
         4MiI8wQOz/kQsaXLnAHoDuFV4CwLnOzAqJ4fpULIGxUb8RumEYayFWEBmaBy4x2ZXxar
         8F8X0JG0XP99OerbNHGaUbd5T+l3mrtCY/Zzbvqj0Fn0DjpIVqnO555M0TnukOLXo3HK
         /F4AWh9urkseXZUTIiYI/PsAE5eavY2gDFJE9D1hH+F5QXZZ0nG3fXrW0P1bIBewxrgG
         KhLkp5BLSaL9biQv2YI3ghE+m5DCkET06x9X/HDmeapc5/ycSVcSfLgImX9sgnPSfgND
         DjoA==
X-Gm-Message-State: AOAM531uTLWNvvZzKnHM/ZP1vr842y+77MoLxatSsMnfVmPhA0SHlF9p
        X6yUR0wCo36t6ci8f654HYYGKsRKRm2Lg40ydVa8XTTE
X-Google-Smtp-Source: ABdhPJwVFgyYRXXpussfl49Xl7C9cX6P0/AbNZ5WQ8m6YD0Ftm/eTjlM5A7//j0mGak+BTd42smNfc0itlWtwjXSAG4=
X-Received: by 2002:a9d:1b62:: with SMTP id l89mr12121818otl.145.1598513801598;
 Thu, 27 Aug 2020 00:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdV=gy1F2dX0+eURB=hubnbPUGbokrT_9kZXtk_ruAofSg@mail.gmail.com>
 <20200826185212.3139-1-grandmaster@al2klimov.de>
In-Reply-To: <20200826185212.3139-1-grandmaster@al2klimov.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Aug 2020 09:36:30 +0200
Message-ID: <CAMuHMdVvx0z6xkH9YaPiWh4_WmmBP_W7VEyP4PjaLfNs9OWL0g@mail.gmail.com>
Subject: Re: [PATCH v2] m68k: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 8:52 PM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  v2: Thrown out de facto broken links.
>  archive.org-ing is on my TODO list, but beyond this project's scope.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.10 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
