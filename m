Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E825DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA7320786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgHZIus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:50:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33394 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgHZIur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:50:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id t7so912556otp.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 01:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFL0RQvsbwNq/jNgvdCnq2KliIm214CoTcSzUtJeq4o=;
        b=bjIfXCjRiTyiOO3dgsTkIdst7HuT6TNDIyLhfb2Kqmni8cPgXfVb6QWiinIvRavWZz
         CFz1j8tMbk4vlVEgKxVbi8a9by/bfWHZ5K6zOERzLMPAQ/sfojr9zI1BiUE+IFau3d2G
         anUsx09PDvK14wUgnGA21GgIq5HMmCgjvO0ThN2z597H3yxdsk0UCS4S1F9YB9sEAZX+
         C/rJFaGB3H8ldHYxgBGR0OWxuZgOw2UCN/wQk4q0X/jUsrqYyS1qUfd+0sxpFxphZanc
         jBvOa3OJeajlzGP3NVemx9N/j//90XDrPBWCkMIoVZtOem62EUyN5qpBwcHK3gHX0x6A
         UezQ==
X-Gm-Message-State: AOAM530CvgEfjd64a80WJzBPn40vd5LOXlmZyLp43XufUYtmY0JIzuB+
        oBpeoSjAF/BUPcWRbRj7yNBYhuNBuTfomiPCwYBucGs4w+I=
X-Google-Smtp-Source: ABdhPJzYj54zL9tqZab8zYtNItCMN1v1gv+UQD2bCa2fdGjgaqsTHspRhX2PZpPJXSKizGFjTi8wbYnn4VPGHc4B9Vk=
X-Received: by 2002:a9d:7d8c:: with SMTP id j12mr9531749otn.250.1598431846220;
 Wed, 26 Aug 2020 01:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200717184240.79799-1-grandmaster@al2klimov.de>
In-Reply-To: <20200717184240.79799-1-grandmaster@al2klimov.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Aug 2020 10:50:34 +0200
Message-ID: <CAMuHMdV=gy1F2dX0+eURB=hubnbPUGbokrT_9kZXtk_ruAofSg@mail.gmail.com>
Subject: Re: [PATCH] m68k: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Joshua Thompson <funaho@jurai.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Thanks for your patch!

On Fri, Jul 17, 2020 at 8:42 PM Alexander A. Klimov
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

Something must be wrong with your script, as several of them return
"301 Moved Permanently" instead of "200 OK".

>               Replace HTTP with HTTPS.
>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

> --- a/arch/m68k/include/asm/mac_via.h
> +++ b/arch/m68k/include/asm/mac_via.h
> @@ -30,7 +30,7 @@
>   *      http://www.rs6000.ibm.com/resource/technology/chrpio/via5.mak.html
>   *      ftp://ftp.austin.ibm.com/pub/technology/spec/chrp/inwork/CHRP_IORef_1.0.pdf
>   *
> - * also, http://developer.apple.com/technotes/hw/hw_09.html claims the
> + * also, https://developer.apple.com/technotes/hw/hw_09.html claims the

No longer contains the original content.  Perhaps it should be replaced by
https://web.archive.org/web/20041012040104/http://developer.apple.com/technotes/hw/hw_09.html
instead?

>   * following changes for IIfx:
>   * VIA1A_vSccWrReq not available and that VIA1A_vSync has moved to an IOP.
>   * Also, "All of the functionality of VIA2 has been moved to other chips".
> @@ -178,7 +178,7 @@
>                                  * on others, 0=disable processor's instruction
>                                  * and data caches. */
>
> -/* Apple sez: http://developer.apple.com/technotes/ov/ov_04.html
> +/* Apple sez: https://developer.apple.com/technotes/ov/ov_04.html

Probably the same, didn't bother to dive into web.archive.org.

>   * Another example of a valid function that has no ROM support is the use
>   * of the alternate video page for page-flipping animation. Since there
>   * is no ROM call to flip pages, it is necessary to go play with the
> diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
> index 5c9f3a2d6538..6f2eb1dcfc0c 100644
> --- a/arch/m68k/mac/config.c
> +++ b/arch/m68k/mac/config.c
> @@ -240,7 +240,7 @@ static struct mac_model mac_data_table[] = {
>          * Weirdified Mac II hardware - all subtly different. Gee thanks
>          * Apple. All these boxes seem to have VIA2 in a different place to
>          * the Mac II (+1A000 rather than +4000)
> -        * CSA: see http://developer.apple.com/technotes/hw/hw_09.html
> +        * CSA: see https://developer.apple.com/technotes/hw/hw_09.html

Same as above.

>          */
>
>         {
> diff --git a/arch/m68k/mac/macboing.c b/arch/m68k/mac/macboing.c
> index 388780797f7d..a904146dc4e6 100644
> --- a/arch/m68k/mac/macboing.c
> +++ b/arch/m68k/mac/macboing.c
> @@ -116,7 +116,7 @@ static void mac_init_asc( void )
>                          *   support 16-bit stereo output, but only mono input."
>                          *
>                          *   Technical Information Library (TIL) article number 16405.
> -                        *   http://support.apple.com/kb/TA32601
> +                        *   https://support.apple.com/kb/TA32601

This change is fine. Actually the old URL returns 301 to point to the
new URL ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
