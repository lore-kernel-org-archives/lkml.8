Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED47C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9BCF208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX97W0ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgEGTlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGTlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:41:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF6CC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 12:41:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id x4so7844906wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 12:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PMpVNBoEhxmM4CRkfdIX0zaCW76FCXVtwoTgqUPcVLU=;
        b=HX97W0uxJyJtTZ3HW9vIAYer0wvYtLnSikfxmAflXPahf0PgFsIk0LGBDsJfVVrzP6
         x3FABNboCvUFz9RilZ7X33rF8JL7u16GUL9zLUiOE/80ITtDvC/hmPUAzRo2QCzMlQEf
         DuS3fcoY23eYsOCcErlMfOrfIvAoV40J1f90Z0ouwbNBfmSLLKwngBA2cnleXbOz5Ije
         yc15pVmsIdGTk9avwk9xUFH+UrVqJAJAOvjHxN6BwvWAHyB/4OKuGOOdcP6Eb2pt7w59
         u2ctaW0Lk7d92HpR2PcZhsDkbcM1KvAvJ8tE8YytiSt8agVvChqT69F8psGu4vGEGMyT
         ivHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PMpVNBoEhxmM4CRkfdIX0zaCW76FCXVtwoTgqUPcVLU=;
        b=PW9rw90nrQLGWOaX6PZKmdN6Wbgz+8hTmX3lvHsVVfdpPD3/4rjlOnG10XVd9JsJPX
         E+yClnNC+YIrArndgBamniMu81CKsDGVDYO4jAcup9ZIAS9P2yaE8y49Y5dMxQH4fmuc
         erqDXggnvRa0wFBkDSIaDuTZMr+bPttFV70Qun7Qsp6532/YiieB0Q6VDkNgU34kkgNR
         BaEsOc2+fBMwZx7loHApkpzP86Spxh4nHJAB2KmdVXnvPyGI5ufRlvN1y20lAerXB1ln
         +1LJtqIHYxx1/XiX58ok2ytu5zQN3PotXLEp0cJ/Lx68ynoHPNoljP2PMe+m2vUYShUQ
         V46g==
X-Gm-Message-State: AGi0PuY7b90qwxJhhxKLKj+XukaXgl1QeAN1iGN3A922cXnjWqsCBE0j
        cSu9bqLGgmklIpxGGF9D9+9PJpGYWrFlM8aczs0WrA==
X-Google-Smtp-Source: APiQypL+sep8ou8J6mqKZQXNqve2pmJX8BmGCDtinGGz6khiz1mmiredSXRSShGE44sQLQI1B+pqUO+oGpZv4AQ5u9o=
X-Received: by 2002:a1c:6344:: with SMTP id x65mr12146860wmb.56.1588880502897;
 Thu, 07 May 2020 12:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200507112412.10829-1-chentao107@huawei.com>
In-Reply-To: <20200507112412.10829-1-chentao107@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 7 May 2020 15:41:31 -0400
Message-ID: <CADnq5_MDPZbDrrgCCdWVfSX47it0=JvTj3k_W8woK6=O=qzCnQ@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/dc: Remove a useless comparison
To:     ChenTao <chentao107@huawei.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Cyr, Aric" <Aric.Cyr@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, murton.liu@amd.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Su Sung Chung <Su.Chung@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 9:35 AM ChenTao <chentao107@huawei.com> wrote:
>
> Fix the following warning:
>
> 'en' is uint32_t and can never be negative.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_hpd.c:132:10: warning:
> comparison of unsigned expression < 0 is always false [-Wtype-limits]
>   if ((en < GPIO_DDC_LINE_MIN) || (en > GPIO_DDC_LINE_MAX)) {
> drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_generic.c:109:10: warning:
> comparison of unsigned expression < 0 is always false [-Wtype-limits]
>   if ((en < GPIO_DDC_LINE_MIN) || (en > GPIO_DDC_LINE_MAX)) {
>

While it's not required, I think it improves readability and protects
if the enum has negative values.  I think it would be better to change
the en var to signed.

Alex

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: ChenTao <chentao107@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
> index f9e847e6555d..6cd50232c432 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
> @@ -106,7 +106,7 @@ void dal_hw_generic_init(
>         enum gpio_id id,
>         uint32_t en)
>  {
> -       if ((en < GPIO_DDC_LINE_MIN) || (en > GPIO_DDC_LINE_MAX)) {
> +       if (en > GPIO_DDC_LINE_MAX) {
>                 ASSERT_CRITICAL(false);
>                 *hw_generic = NULL;
>         }
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
> index 692f29de7797..f91f426699c0 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
> @@ -129,7 +129,7 @@ void dal_hw_hpd_init(
>         enum gpio_id id,
>         uint32_t en)
>  {
> -       if ((en < GPIO_DDC_LINE_MIN) || (en > GPIO_DDC_LINE_MAX)) {
> +       if (en > GPIO_DDC_LINE_MAX) {
>                 ASSERT_CRITICAL(false);
>                 *hw_hpd = NULL;
>         }
> --
> 2.22.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
