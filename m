Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC2AC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7C22065D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 17:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBLL6J3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgGURMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgGURMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:12:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04982C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:12:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a14so7089196wra.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 10:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=li6Ai+i2GC9C2OTaxMc0Mm8uFP4T7o+Xp3gc7X+SoOc=;
        b=CBLL6J3+4BY47pbGZDKfS3eUO0MuL+xxmDwYvkPLz+F0w7xObrTNc4OCTQJ77r+PZc
         PkcbMxfQBkNxnJjFM/d/avBDGMSIm4x6knuvfkMPQepOuywO2A7Phgg0HcvmVaoGqS9r
         uY6esEnIkMOUODqmMoAURXJArcolQUBL5vokt043mskZU6k5nicicHp6Non51tsyiWbi
         bAsdGtuT0/xhIBHD/vXN+cjudpAJlhCf9jdhqmMX2mYhMBxZazqDsJuTfdSWwFFxu0Et
         Ky+4GrQATUHqiPJ1Yy+N9iAGQYGaLgE+0CvZurAkFuiDYyTUYv/1Z1cJ+iSs8CDFU6rc
         GkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=li6Ai+i2GC9C2OTaxMc0Mm8uFP4T7o+Xp3gc7X+SoOc=;
        b=lFjUXOzyFsdY0v2V55ajIp5L6a5sTw2s1S3q+qrze7lovESUkH6IBEG/DxHO157SBM
         Z7ohnKFoOR8vqIsbnMtLvo5tv0SRvQJFuk45wpR8AlGC6TDafLqiZWn7PS0K3j3a9MaV
         nNMwlkHUBfE8HkKqqBntaOXKtm4tjnDlWRw72ceGy2Z5GrgpbrPIBav9YjF52ytIJqYY
         H8m5aDa66GlFQcL7pd9QMyTQWz0IkuB/4YKTbG+QVVRY1DWqzHJ1X8iHKbsbg2ZKnUvP
         jarIGSglQmEd5nZb0iDWChCdoOlqilbM3l1B7OWbuNMdXVdMufiayU/m+WbwPweojNDG
         0qkQ==
X-Gm-Message-State: AOAM530virVxNzLNtt/DpZ+ywi/eol5kJ6n34+xFQcIDeTH+2auck65n
        i9BzPGG7QPPQ2Ypxrug3WX3CvBMdk29BzOxX0Hs=
X-Google-Smtp-Source: ABdhPJz0YdT8vSTroiEpfkQ8rGiMvt24vskGTjqyubws9569N+5uFZFHkZwRAwl+PoYL3HniBDCOUD8LWlWswqc6nPc=
X-Received: by 2002:a5d:618e:: with SMTP id j14mr1345774wru.374.1595351549684;
 Tue, 21 Jul 2020 10:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200717070958.41489-1-qiuwenbo@phytium.com.cn>
In-Reply-To: <20200717070958.41489-1-qiuwenbo@phytium.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 21 Jul 2020 13:12:17 -0400
Message-ID: <CADnq5_MbawfSJBQ5xurAcUfu8mxN32aUBNqv=295wgaadxKk9Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: fix a crash when overclocking Vega M
To:     Qiu Wenbo <qiuwenbo@phytium.com.cn>
Cc:     Evan Quan <evan.quan@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Chen Wandun <chenwandun@huawei.com>,
        David Airlie <airlied@linux.ie>,
        YueHaibing <yuehaibing@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Eric Huang <JinHuiEric.Huang@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        yu kuai <yukuai3@huawei.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Jul 17, 2020 at 8:23 AM Qiu Wenbo <qiuwenbo@phytium.com.cn> wrote:
>
> Avoid kernel crash when vddci_control is SMU7_VOLTAGE_CONTROL_NONE and
> vddci_voltage_table is empty. It has been tested on Intel Hades Canyon
> (i7-8809G).
>
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=208489
> Fixes: ac7822b0026f ("drm/amd/powerplay: add smumgr support for VEGAM (v2)")
> Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>
> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> index 3da71a088b92..0ecc18b55ffb 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
> @@ -644,9 +644,6 @@ static int vegam_get_dependency_volt_by_clk(struct pp_hwmgr *hwmgr,
>
>         /* sclk is bigger than max sclk in the dependence table */
>         *voltage |= (dep_table->entries[i - 1].vddc * VOLTAGE_SCALE) << VDDC_SHIFT;
> -       vddci = phm_find_closest_vddci(&(data->vddci_voltage_table),
> -                       (dep_table->entries[i - 1].vddc -
> -                                       (uint16_t)VDDC_VDDCI_DELTA));
>
>         if (SMU7_VOLTAGE_CONTROL_NONE == data->vddci_control)
>                 *voltage |= (data->vbios_boot_state.vddci_bootup_value *
> @@ -654,8 +651,13 @@ static int vegam_get_dependency_volt_by_clk(struct pp_hwmgr *hwmgr,
>         else if (dep_table->entries[i - 1].vddci)
>                 *voltage |= (dep_table->entries[i - 1].vddci *
>                                 VOLTAGE_SCALE) << VDDC_SHIFT;
> -       else
> +       else {
> +               vddci = phm_find_closest_vddci(&(data->vddci_voltage_table),
> +                               (dep_table->entries[i - 1].vddc -
> +                                               (uint16_t)VDDC_VDDCI_DELTA));
> +
>                 *voltage |= (vddci * VOLTAGE_SCALE) << VDDCI_SHIFT;
> +       }
>
>         if (SMU7_VOLTAGE_CONTROL_NONE == data->mvdd_control)
>                 *mvdd = data->vbios_boot_state.mvdd_bootup_value * VOLTAGE_SCALE;
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
