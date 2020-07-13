Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89476C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6092B20758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USyMiXvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgGMTR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGMTR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:17:28 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A86C061755;
        Mon, 13 Jul 2020 12:17:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so5937045plk.1;
        Mon, 13 Jul 2020 12:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5U6F41TkrmuFMdMBZZCA57RfJVOhnudyCPli5pfjRs=;
        b=USyMiXvoNPiMCCop7qertDsazIIU+3jR2JLEgjshl4JNxoDALxJ/lUUN604xtEAG5w
         avXkgdCT5xXSJOLJ0L+17MxbCyM1X+6q5aHui70iVXuHx3VGw62uaLl04iF6klkz5FR4
         lW8B+E5FQsH1ZvbjyZiL5m+wu7XjqO9uYq1n+vibGLp2UKgH0c3h3pDkXKnj9nsYvEpM
         H3gHmCgO983PwSz2G9m4xiD5ryR/DG8HL06fcgpb/9c0zR8vkX0vBpMQZBEu/6zimYcs
         CikDfZlSSHVg42QzE4kZ/YelvCaLtqLRh1aLlHyvCjBoFDGvEzS5eyyva7nwCkTd3rNF
         b2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5U6F41TkrmuFMdMBZZCA57RfJVOhnudyCPli5pfjRs=;
        b=d3+wUUdzdr8Ga9WTM9IeHDDIIJi4oQGBf38QBCzuAGJ8yrSbG6iDfc9fzfMvbaKUkN
         X9TbyissGSeYiNZcvLLhYd5YF+oYDfs1sCoaMQTNlytQiZzgnZtSXLE07WlQi0t4ouhg
         wYvxXcfpkErWlsLoJc1XlS7pCrqXWNKtlgBDg42buKbu4CRtNXqSuOjDQxyXqy9a/Rmt
         LqObBLL5s6a3g64yEO+hVyOrB8nJR36CryYJitlIuvtuGckuRxjm8jUCHYqtcDZsTzMP
         EgDwZ9ZW0xOKAi8IcwDALJizUNzI9B0JWiluahYY/HPWH3B5rkG5xCOTaSjvbWjzt2F5
         YWGQ==
X-Gm-Message-State: AOAM5309Wu0MdCQiYbbMHxUrLb7Qlj3KfayFI7+XLnoQYQ2KmpzqaOe3
        dQiyL4bM1/7FFH2dAFoVUctFXkOq1Sw/1WSULJg=
X-Google-Smtp-Source: ABdhPJzBe4Z0IIVCnp2VDfH3SltGa57BzPspnJlSjUB2gW4zz73hNPrxa7Tqrenphov1bJgTQ3bGgnPJ9nN36fGhsLA=
X-Received: by 2002:a17:902:8491:: with SMTP id c17mr914342plo.262.1594667847297;
 Mon, 13 Jul 2020 12:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200713184606.37033-1-grandmaster@al2klimov.de>
In-Reply-To: <20200713184606.37033-1-grandmaster@al2klimov.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Jul 2020 22:17:10 +0300
Message-ID: <CAHp75Ve2pPGN3BtMw6x1xR5Cyv8VP=KMJMMJ9qao29ArrxPo9w@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 9:46 PM Alexander A. Klimov
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

Please split per driver basis.

> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
>
>  If there are any URLs to be removed completely or at least not just HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
>
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
>
>  If you apply the patch, please let me know.
>
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
>
>
>  drivers/platform/x86/Kconfig      |  2 +-
>  drivers/platform/x86/apple-gmux.c | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0581a54cf562..1d96e07b2a02 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -140,7 +140,7 @@ config ACERHDF
>           in the same node directory will tell you if it is "acerhdf".
>
>           For more information about this driver see
> -         <http://piie.net/files/acerhdf_README.txt>
> +         <https://piie.net/files/acerhdf_README.txt>
>
>           If you have an Acer Aspire One netbook, say Y or M
>           here.
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
