Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BB3C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE53C21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkcVQcp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbgBYPOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:14:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37658 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbgBYPOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:14:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id l5so10917004wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 07:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXzprrtp68rQTmrZnfpbTAHahYMoR+p+Au9u2qscN2A=;
        b=GkcVQcp/6ZPehbeQY8JZj9qHNu+KM+ij2Ac6LOcyHyi22wIPIdCemfzEJPKLf8LjLj
         FKb4c9SDJ4iV+jyMVfobWZzBWl+d3fXt6N8z1YvZsHakD1ndKIJFlGdpSxbNSb6/5JwG
         lxRlHQMNgeAKzX4T53OJCbDNPiDI35HTSDYdPMMLU8wm33DBGFCjTmapDBfilbz+GA1v
         ILCCmJxgX2voBzpUL+OwmekWtTi2fSOg3z8q47KjKAwxacpL14/gMxeLQjhVdR3Ezzx0
         8LKZK2gneeTU5kbo25SYbcsTM7Bg9QrononOXn3h0yBMFepS717EXBgMt5FQ7qD9YCeX
         ChDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXzprrtp68rQTmrZnfpbTAHahYMoR+p+Au9u2qscN2A=;
        b=IKb3HzuDpFmGwOaAhbcCizp3CD6Qe9mxSJRj9njD6iJiXLaUdfwmAcXKKvOj/QkAZO
         TBljJPDDZ/wOzekNpvr3gv8IeJWs7rxH94lrWxVU2zcGuCg0Jnlxwj8wV2J59yD3L8eN
         AJ9lDRx2LIm5Vt0VfLTQsz0+SrIgBATgHO9LQKOxeQo3XgA2zmDepe3iqfhESDC+5bH8
         Xr6+sn9ZjzwXNiZtquCsMx/RDcEjfpVqZ7uRAOMiopB7Azq4jPCZVuIxepbYz6XPZRIV
         eZAXSw16oNRkwwduxxrog7arlcZyKjltDx8HY1naK6oqIcs1QYr1c+av3pPkP0yuHobM
         JYBA==
X-Gm-Message-State: APjAAAVkjT7YsIpWrs4M2dV8jC4WtwPP+avNagtT6Keg/rFnfaK7g68d
        9lLNMvGPzAHlcwRGEWqkOypmX0IQtrxBd3Sj7Ng=
X-Google-Smtp-Source: APXvYqz015XmLIRToUFz/saw+T7KQVzV9ftDiqBQjP1WNtuDuxUROpWkH2OtTEjG1hUe2M5d5d2uBilnQkLpf0g7uMc=
X-Received: by 2002:adf:b254:: with SMTP id y20mr72518730wra.362.1582643647644;
 Tue, 25 Feb 2020 07:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20200221122139.148664-1-chenzhou10@huawei.com> <MN2PR12MB33447575BAF26E919965AB5CE4EC0@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB33447575BAF26E919965AB5CE4EC0@MN2PR12MB3344.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 25 Feb 2020 10:13:56 -0500
Message-ID: <CADnq5_OZgyYrkPSna0Sp+04-POYxWqgXgOPkjGfgxz2qCqiTwA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/powerplay: Use bitwise instead of
 arithmetic operator for flags
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     Chen Zhou <chenzhou10@huawei.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Feng, Kenneth" <Kenneth.Feng@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 10:21 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> Thanks. Reviewed-by: Evan Quan <evan.quan@amd.com>
>

Applied.  Thanks!

Alex

> -----Original Message-----
> From: Chen Zhou <chenzhou10@huawei.com>
> Sent: Friday, February 21, 2020 8:22 PM
> To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(ChunMing) <David1.Zhou@amd.com>; airlied@linux.ie; daniel@ffwll.ch
> Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; chenzhou10@huawei.com
> Subject: [PATCH -next] drm/amd/powerplay: Use bitwise instead of arithmetic operator for flags
>
> This silences the following coccinelle warning:
>
> "WARNING: sum of probable bitmasks, consider |"
>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> index 92a65e3d..f29f95b 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> @@ -3382,7 +3382,7 @@ static int vega10_populate_and_upload_sclk_mclk_dpm_levels(
>         }
>
>         if (data->need_update_dpm_table &
> -                       (DPMTABLE_OD_UPDATE_SCLK + DPMTABLE_UPDATE_SCLK + DPMTABLE_UPDATE_SOCCLK)) {
> +                       (DPMTABLE_OD_UPDATE_SCLK | DPMTABLE_UPDATE_SCLK |
> +DPMTABLE_UPDATE_SOCCLK)) {
>                 result = vega10_populate_all_graphic_levels(hwmgr);
>                 PP_ASSERT_WITH_CODE((0 == result),
>                                 "Failed to populate SCLK during PopulateNewDPMClocksStates Function!", @@ -3390,7 +3390,7 @@ static int vega10_populate_and_upload_sclk_mclk_dpm_levels(
>         }
>
>         if (data->need_update_dpm_table &
> -                       (DPMTABLE_OD_UPDATE_MCLK + DPMTABLE_UPDATE_MCLK)) {
> +                       (DPMTABLE_OD_UPDATE_MCLK | DPMTABLE_UPDATE_MCLK)) {
>                 result = vega10_populate_all_memory_levels(hwmgr);
>                 PP_ASSERT_WITH_CODE((0 == result),
>                                 "Failed to populate MCLK during PopulateNewDPMClocksStates Function!",
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
