Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77E3C2D0F6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6932206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF0koygm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgELPyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgELPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:54:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06691C061A0C;
        Tue, 12 May 2020 08:54:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l18so16064178wrn.6;
        Tue, 12 May 2020 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqLRxvMmqILCLzIsTlGbC4llYBLLqdGwC3gVHSsdlAY=;
        b=kF0koygmMuIGjj/ZPdBj0uzF19MXcgBj3NFB/K0c1X0zozm2G9b8a/620FkVENe5Jw
         wfq2YI4/bZ/ySAHJD/+/N9NMRwQr69kUPqCbDZcve4+EDUEWgJKBVvg7fIefJAmKH5J+
         ukG1otkwBPWU+OoNIqly2M64c24lDYPKnjCWI0oXkkxpARLxPJelhRg7troyC3CK+zoV
         zlaOjsVLaZbReKQZTMxS2liKh97B3aF8FesfHC2Fkz9fkGkQb1BusyHEWdavQSO1G2G1
         aB9ry4Yb8C5BXiw10VKfrgiL6FTxUXzTnaO0PdiTRhgSPv3DounNF4th5lfe4ZAsRPhe
         m1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqLRxvMmqILCLzIsTlGbC4llYBLLqdGwC3gVHSsdlAY=;
        b=mwHR9hiIo1XBXKjtfp9K0eZj/juFkerTtsPuhTUponiFRt/fVuHud4p/EQUuP0tz+5
         L9vhxfkpTBm7pP+DLgnJ6EbJoj2EOxSii9ogwB8nutzDTmVJ48O3Iv9aUABZ8eA8uj4V
         vmGFTAy/kv/49JbJBIvWLVVTmsJzyOOb6vGcm2hqKZeA4nRwxdutns5geeGRGfYyJRiG
         6vkDY4LmmdgaRpj/IUEofaWYju7+j0g3jXSmkFJ7Dy6eIm6TJDEnkxcsq14o+pDd0T5m
         E29epw366RnMXJXyVpW0zieIg5B/mMo7t5lChNToPHl1zQvOg3iPCQ/YiDjRTpkv+GvE
         BZ7g==
X-Gm-Message-State: AGi0Puaj2AJV+Ejgqv8kP2doo2QYUTVEkZ2mULgTVW4vTkU3FD5nOkHi
        UUOJjhQ5oVB1fKit3c8c/kU8qSaRAJHnWm1Xu8AN+w==
X-Google-Smtp-Source: APiQypKOU/Rd8sG8437lj8j+RkUwRZ/eidY0aY3ImsSTCM9cZAif57CmdDRBPlSXBebCYX8Hj7ohdNcq9ejB8BZfCRQ=
X-Received: by 2002:adf:fa91:: with SMTP id h17mr25463264wrr.111.1589298841655;
 Tue, 12 May 2020 08:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200512124806.195856-1-colin.king@canonical.com>
In-Reply-To: <20200512124806.195856-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 May 2020 11:53:50 -0400
Message-ID: <CADnq5_PPLtqWPtE9LTEz3j333EyqSQ1Y-0p_7YR=cLAEmu7Now@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: remove redundant assignment to variable ret
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 8:48 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable ret is being initializeed with a value that is never read
> and it is being updated later with a new value. The initialization
> is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 90610b4f2c75..e9e59bc68c9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -441,7 +441,7 @@ int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)
>
>  int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_device *adev)
>  {
> -       int ret = -EINVAL;
> +       int ret;
>
>         /* Each psp need to set the latest topology */
>         ret = psp_xgmi_set_topology_info(&adev->psp,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
