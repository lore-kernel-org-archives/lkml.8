Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA091C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85745206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI9YsfAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbgGOKCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgGOKCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:02:46 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFA8C061755;
        Wed, 15 Jul 2020 03:02:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x72so1880597pfc.6;
        Wed, 15 Jul 2020 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llF0yay839iWALyP0hbCSBfYBxqEqwDN3fSZBINYVls=;
        b=mI9YsfAMVwDCEzm/EW/uMw+KKHIh+CxJGTIa/XUN1ZoITWWIn749udGFUb+sLOGBah
         6GzUVdIRiy5uVZl17beazartRvxdoQc8tHO27NP8Gnctjw9Wt73SMlKRqE/0iCg0geXX
         NuZ9YWPfEDXH9OnxN7ofc8/ibo7WwuVxQqjcgYgHaouokUi1OpS8ijVM7WH30kHf5j3m
         VfiN0exw2PwtktUuaY4SqnBcqrFXQb+gBADKUJj5AhqO9hgBumcGXI74TIFB8Yrd6gfh
         rpnRGYgNnNcYqaXmE5Jz/xh8XeL81cD5CJtWKbROGVjNB+SivvCOD2C/v/qxzLO62r0Q
         bc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llF0yay839iWALyP0hbCSBfYBxqEqwDN3fSZBINYVls=;
        b=QTfTpnUVYDvCFgQ4w/A1Aasd3vBSHZz3ckJLMLzgYvCzaS7g3Ov7DwhsNgOdU8CNHR
         kLOXNLY2fTu2vFlVviUO7lfOnJV53bYs7+qwad/jpRdwRaNcYXl2Wcj2V1GCfRQhdRKa
         ejtqlSviKwedXQBWCEEh7uUDIHGkqhlvJyRDrnzVf9WN26b0smmO5XvR5IowkSCdjHcD
         pjv6MW/SUJd58gJH0845O8mcmPWuEBvEHECvigVvQNvG/rXsz3fY+8cbHA6osppNaXga
         AxlVhIf3LcoiqIWr9VnvAh29J40rxTGGXF1DHEwMms6rKLi/E4aBba3kMrWFGxoi+9Wf
         KRdw==
X-Gm-Message-State: AOAM530w00NAY9w03m+z9YNMkx437McOG1jZAJz1ptvWnu3EdPnPcDeP
        Pt7vBjZHowP38UtdOdE3uiovXy/lxeCtC46EvSU=
X-Google-Smtp-Source: ABdhPJzt+8bqbkjqShATlvuMIdRl1iXUFpCcIDxNWgSyJr9Tmk3w+wv8JCXqwg1aCgKcs15WfBnYYDGkiSphxZyG3es=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr7217982pgn.4.1594807365930;
 Wed, 15 Jul 2020 03:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Ve2pPGN3BtMw6x1xR5Cyv8VP=KMJMMJ9qao29ArrxPo9w@mail.gmail.com>
 <20200714190721.47603-1-grandmaster@al2klimov.de>
In-Reply-To: <20200714190721.47603-1-grandmaster@al2klimov.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jul 2020 13:02:29 +0300
Message-ID: <CAHp75Vc+JuwwitN6KVVE9FcV_Go-qWYJ3fuo272sBh9-R=D_mQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: apple-gmux: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:07 PM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
>
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

Pushed to my review and testing queue, thanks!

> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  drivers/platform/x86/apple-gmux.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 7e3083deb1c5..9aae45a45200 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -277,8 +277,8 @@ static bool gmux_is_indexed(struct apple_gmux_data *gmux_data)
>   * MBP5 2008/09 uses a `TI LP8543`_ backlight driver. All newer models
>   * use a `TI LP8545`_.
>   *
> - * .. _TI LP8543: http://www.ti.com/lit/ds/symlink/lp8543.pdf
> - * .. _TI LP8545: http://www.ti.com/lit/ds/symlink/lp8545.pdf
> + * .. _TI LP8543: https://www.ti.com/lit/ds/symlink/lp8543.pdf
> + * .. _TI LP8545: https://www.ti.com/lit/ds/symlink/lp8545.pdf
>   */
>
>  static int gmux_get_brightness(struct backlight_device *bd)
> @@ -373,14 +373,14 @@ static const struct backlight_ops gmux_bl_ops = {
>   * switch the panel and the external DP connector and allocates a framebuffer
>   * for the selected GPU.
>   *
> - * .. _US 8,687,007 B2: http://pimg-fpiw.uspto.gov/fdd/07/870/086/0.pdf
> - * .. _NXP CBTL06141:   http://www.nxp.com/documents/data_sheet/CBTL06141.pdf
> - * .. _NXP CBTL06142:   http://www.nxp.com/documents/data_sheet/CBTL06141.pdf
> - * .. _TI HD3SS212:     http://www.ti.com/lit/ds/symlink/hd3ss212.pdf
> + * .. _US 8,687,007 B2: https://pimg-fpiw.uspto.gov/fdd/07/870/086/0.pdf
> + * .. _NXP CBTL06141:   https://www.nxp.com/documents/data_sheet/CBTL06141.pdf
> + * .. _NXP CBTL06142:   https://www.nxp.com/documents/data_sheet/CBTL06141.pdf
> + * .. _TI HD3SS212:     https://www.ti.com/lit/ds/symlink/hd3ss212.pdf
>   * .. _Pericom PI3VDP12412: https://www.pericom.com/assets/Datasheets/PI3VDP12412.pdf
> - * .. _TI SN74LV4066A:  http://www.ti.com/lit/ds/symlink/sn74lv4066a.pdf
> + * .. _TI SN74LV4066A:  https://www.ti.com/lit/ds/symlink/sn74lv4066a.pdf
>   * .. _NXP CBTL03062:   http://pdf.datasheetarchive.com/indexerfiles/Datasheets-SW16/DSASW00308511.pdf
> - * .. _TI TS3DS10224:   http://www.ti.com/lit/ds/symlink/ts3ds10224.pdf
> + * .. _TI TS3DS10224:   https://www.ti.com/lit/ds/symlink/ts3ds10224.pdf
>   */
>
>  static void gmux_read_switch_state(struct apple_gmux_data *gmux_data)
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
