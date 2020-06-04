Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FE7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE89A207D3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDrViyRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgFDSzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbgFDSzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:55:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D50DC08C5C0;
        Thu,  4 Jun 2020 11:55:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p5so7251252wrw.9;
        Thu, 04 Jun 2020 11:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uiinNKg/VAAIBsMjrTVJDCNhmBGSNxHkcjt+mWjcnNg=;
        b=lDrViyRHFcdsinb5IHbP2qqOylfphQlSRMERDMe/wtWEswGJIceld6eWHhWVmj9kwY
         S9GDEP0NS16fM+nVJhx89txvsDrW8ZZPerN1C/nr8xYKjrLIJ1Dj67yMXuLMtidBXCjv
         l+uaJ0XsIXIb4XkViWBX1q43C7BVVfOVhxmBNVcFfMDZnzjQcCcXsx+HP2/L33r49U9l
         1gqQClBCFhkzWQzH5HubbtmYfShFnXIaUk+sA1cOP9p0adzuhnYRYCP3CshXQEppsPs6
         n5zO4FlxpRudlVm5V/E1QprnephQG9ygNndFspWN/lLh5tZQl0dNtThKw/VNb5KfvKBV
         gEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uiinNKg/VAAIBsMjrTVJDCNhmBGSNxHkcjt+mWjcnNg=;
        b=QCH7i91czk6W90v56naiDA0FNICgQAJPdhTIj7ZylX4PWj+qK5NHWeym5DqAnjb7fP
         9zcfA6QavklLk+ZqotigUoSDp3uMNGPa9qCcbk4Rw+bvLSwkqZPBi2aVQEGjL1+PsvKs
         D4PU0vmhrXz0FgoVOG9k5YScnI/Lhl6r122EA6nLfnGocyuJE3oMqtnjmWSZaQra1Opu
         iXBJUfL7MKkv7Y65o02sXUrYdMuWuF81PF/q0htVWHLCeKJAZN0fp/8NmRnUyx1aiqDi
         KGEj9AZUWsxZpd4Jnj4/j8SVZN5xfSDzt03McRb4DD5z3N3w3TmKuZAA/KGlWZMfY3up
         sGgg==
X-Gm-Message-State: AOAM5336Y8x6g9JU+lnHGMAJ8vuvpQY9dZtcE4RE2/mez2elYwKmvONA
        4vvLlBr7n4/yHQMdwAjcQJLcSBmeGqceQ1GARKc=
X-Google-Smtp-Source: ABdhPJyO1qtFfu8kgFgNsp7xryFcB2IwdjYxZjFEdLusH+8TaUd3IzJ4bblyVzCLX2N+e0qXfwjUFreeN2ucvhsw9nc=
X-Received: by 2002:a5d:6789:: with SMTP id v9mr6163777wru.124.1591296913673;
 Thu, 04 Jun 2020 11:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200604103544.14515-1-colin.king@canonical.com>
In-Reply-To: <20200604103544.14515-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 4 Jun 2020 14:55:02 -0400
Message-ID: <CADnq5_M1f8WrNfmo3xS7G=kVaCougjk1Ebiq1yWN1QG4gTkxZw@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix spelling mistake:
 "propogation" -> "propagation"
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Thu, Jun 4, 2020 at 6:35 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dml_print message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> index 65da6304d6a6..2a32ed6682fc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> @@ -1308,7 +1308,7 @@ static bool CalculatePrefetchSchedule(
>                 dml_print("DML:  Tr0: %fus - time to fetch first row of d=
ata pagetables and first row of meta data (done in parallel)\n", TimeForFet=
chingRowInVBlank);
>                 dml_print("DML:  Tr1: %fus - time to fetch second row of =
data pagetables and second row of meta data (done in parallel)\n", TimeForF=
etchingRowInVBlank);
>                 dml_print("DML:  Tsw: %fus =3D time to fetch enough pixel=
 data and cursor data to feed the scalers init position and detile\n", (dou=
ble)LinesToRequestPrefetchPixelData * LineTime);
> -               dml_print("DML: To: %fus - time for propogation from scal=
er to optc\n", (*DSTYAfterScaler + ((*DSTXAfterScaler) / (double) myPipe->H=
Total)) * LineTime);
> +               dml_print("DML: To: %fus - time for propagation from scal=
er to optc\n", (*DSTYAfterScaler + ((*DSTXAfterScaler) / (double) myPipe->H=
Total)) * LineTime);
>                 dml_print("DML: Tvstartup - Tsetup - Tcalc - Twait - Tpre=
 - To > 0\n");
>                 dml_print("DML: Tslack(pre): %fus - time left over in sch=
edule\n", VStartup * LineTime - TimeForFetchingMetaPTE - 2 * TimeForFetchin=
gRowInVBlank - (*DSTYAfterScaler + ((*DSTXAfterScaler) / (double) myPipe->H=
Total)) * LineTime - TWait - TCalc - Tsetup);
>                 dml_print("DML: row_bytes =3D dpte_row_bytes (per_pipe) =
=3D PixelPTEBytesPerRow =3D : %d\n", PixelPTEBytesPerRow);
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
