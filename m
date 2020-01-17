Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6864BC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3977E2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYiiJAtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgAQK7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:59:51 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43049 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgAQK7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:59:51 -0500
Received: by mail-io1-f65.google.com with SMTP id n21so25500279ioo.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 02:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1W+1tNt7mzVWLiRP9zTR54IrHdo1Wi4KI2T1N1KRn4=;
        b=SYiiJAtI6qekuwlu7bpgNew9pgGNZCZJUy4S3w9CfPWXyCM+0ZalBOBDT+O2A6CJfd
         3WnYFeoni3+tmsT8p1DnvGoDACfbwksQsP6qlkOVcFsTVzWGD/2xLns96iAsXQH4XjHG
         EjnyFqcFcSJ8w47Ml7pEmu+OhuoWIHYDZbGcUyMEJpcewLzF7sxoTDh+6EG0ML8oBLAF
         nMzKTg6A3fG0DQ9HU4cR74pAX9zob/xtno1yIiI5xGYtwpmOhKbreKkUy4NeZdSdi+CF
         v6Q2Q1qkIY89bsLZWHJjmev2ospDdRLecLTsPDbtjVa6yBOlPQIHjAK2nTfLljIxaxrX
         VGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1W+1tNt7mzVWLiRP9zTR54IrHdo1Wi4KI2T1N1KRn4=;
        b=pbQIEx/DF7fRSB6woeY4LrKieBMPgGRkR6Qy7TEhCuEU5T2vpSt0BYFuqCxaZpyDE6
         T0nbyMm5ndsh3l/Na1rBMJII2NeH5n7mSlBddyaSn8vGH5uLfqjUzBa0hk1kbTDy9pqQ
         nXOtdktiwqlPwlh3bRI+c6n7gNyEyAiZlGSwZ9hMa2IJda/q1ca+eWXRyrf87OMWvHAj
         2SgRcgMebcq9x7hExgIMq5Th+eF/JLnNoivltoaeMH59hhFbEce038ZZYv+naNtzYVuM
         tBtBHlxHDoQgu6QwtlmfV9+grVSsmaTrWO4VWM3w7cvyXeCqhnJDzQvHI4YlY7RnXuA0
         KWZQ==
X-Gm-Message-State: APjAAAWqfK/kXuSI8K6lg1hjZX6yRDEnikNTQQVp3z+wOesnu/lphkha
        tJtSpSJFnPlmkgqosgXHCqtqSZpJTo2wx+ftTO8=
X-Google-Smtp-Source: APXvYqxpUSrw8OKIJU+pupxnh2g00DrbizM3Vl3ADeeQCYmdscVZyh6WwBom7Zxsz4RvrDCtXuM3bGh8kt3Lzx6PlKw=
X-Received: by 2002:a5d:9f05:: with SMTP id q5mr30837264iot.199.1579258790129;
 Fri, 17 Jan 2020 02:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20200104122217.148883-1-dor.askayo@gmail.com>
In-Reply-To: <20200104122217.148883-1-dor.askayo@gmail.com>
From:   Dor Askayo <dor.askayo@gmail.com>
Date:   Fri, 17 Jan 2020 12:59:39 +0200
Message-ID: <CAO80jNS795mgHCp3XedZQ1o1QHbwxb8DeuSqPtKHmKbAVYsfmg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: do not allocate display_mode_lib unnecessarily
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 4, 2020 at 2:23 PM Dor Askayo <dor.askayo@gmail.com> wrote:
>
> This allocation isn't required and can fail when resuming from suspend.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/1009
> Signed-off-by: Dor Askayo <dor.askayo@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index dd4731ab935c..83ebb716166b 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2179,12 +2179,7 @@ void dc_set_power_state(
>         enum dc_acpi_cm_power_state power_state)
>  {
>         struct kref refcount;
> -       struct display_mode_lib *dml = kzalloc(sizeof(struct display_mode_lib),
> -                                               GFP_KERNEL);
> -
> -       ASSERT(dml);
> -       if (!dml)
> -               return;
> +       struct display_mode_lib *dml;
>
>         switch (power_state) {
>         case DC_ACPI_CM_POWER_STATE_D0:
> @@ -2206,6 +2201,12 @@ void dc_set_power_state(
>                  * clean state, and dc hw programming optimizations will not
>                  * cause any trouble.
>                  */
> +               dml = kzalloc(sizeof(struct display_mode_lib),
> +                               GFP_KERNEL);
> +
> +               ASSERT(dml);
> +               if (!dml)
> +                       return;
>
>                 /* Preserve refcount */
>                 refcount = dc->current_state->refcount;
> @@ -2219,10 +2220,10 @@ void dc_set_power_state(
>                 dc->current_state->refcount = refcount;
>                 dc->current_state->bw_ctx.dml = *dml;
>
> +               kfree(dml);
> +
>                 break;
>         }
> -
> -       kfree(dml);
>  }
>
>  void dc_resume(struct dc *dc)
> --
> 2.24.1
>

I've been running with this fix applied on top of Fedora's
5.3.16-300.fc31.x86_64 kernel for
the past two weeks, suspending and resuming often. This the first time
since I bought my
RX 580 8GB more than a year ago that I can suspend and resume reliably.

I'd appreciate a quick review for the above, it really is a trivial change.

Thanks,
Dor
