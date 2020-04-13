Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD0AC2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4D520739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGv7MGiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbgDMQ6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732238AbgDMQ6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:58:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F18C0A3BDC;
        Mon, 13 Apr 2020 09:58:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id u13so10377123wrp.3;
        Mon, 13 Apr 2020 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=786Abko4OwymZpA7zq9NIU+Jcj7CJ578QomD1bj3ank=;
        b=lGv7MGiYg7oEqYLypfycQaA6ew5I9aewcYJs9NmfJNETIijLfn1NwaDh8AFpk/A6aZ
         x8K73t3qPZTrdm/iXN5neVTcVukcTESm6TxmmAltPPoRdM6w6ta1X8KMW0822rbr/7Pv
         XZ8RzIk85b529lnkQYGf7UIlfSY9Fy/v+TZIajPYd8DS/FAbuuhObHapniZuosPkU3E+
         IC0OxraDowSo5wtqeDC2BpBpqBmG1gD0BeTgjr9deMN83wt6ems1YRVHtG4hXsqPXAI+
         gf6D4GmNPpWNdrAVePhYwlIlQTV0PmrhrzAU72QMkXUnW4uJV995oqf8IDEZ/8e8Pk1J
         7Rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=786Abko4OwymZpA7zq9NIU+Jcj7CJ578QomD1bj3ank=;
        b=QVEAyVRhBKmkx59Dq1868tJIsLaAev3k7Hb2d297Ak/3yTTBD8ugEzL4bW2FqzJcTE
         WoXHTgUQfNnZTqjJvo9E5IYdwopjUzQqQRGdxKIXNpji0V81EG/5/embIQms7AV6VnM0
         8e2Q8ICVgA0ZhXj+zt8ZYhDDL3SJsnAx7SlJNcmk1Ry8rafkwFAFkCVoh2s78rpC7YeB
         SXSN3Xegyf6MUxEbdYLkfRSGSib2xGYEMkrIKq8yODJdRzo64m7BBwpTGouy7zHAbrI4
         yq+oBPcY7+qlrtAvSV71AZ3UqcHea1RK9AS5YZ9IAhQ436fn0f/pljJxuwdhjDsWfslA
         GvHw==
X-Gm-Message-State: AGi0PuYZ8idd3p/s8QI6DwFWeb1wqWmI72KiaRyNSH8d4rFZACRo953Y
        B0vc0CA1TJlz9oI2iXCkhZOZEc0eKogyhd6O/E0=
X-Google-Smtp-Source: APiQypLgM6ORe/fUey6PXuV88ju5z6/RrBDlwexv9u4wPO+3r3jSj9FiVWLMwss0rxgA7h39Knz1M70XeoItHyrc3oI=
X-Received: by 2002:a5d:498d:: with SMTP id r13mr15152734wrq.374.1586797118982;
 Mon, 13 Apr 2020 09:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200410114613.15271-1-colin.king@canonical.com>
In-Reply-To: <20200410114613.15271-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 13 Apr 2020 12:58:27 -0400
Message-ID: <CADnq5_MBQyMaLdJE=WOz4pV7u5UZQy3Y_qjL5ZO=7Y=NHQor=w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove redundant assignment to variable dp_ref_clk_khz
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Yang <Eric.Yang2@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Fri, Apr 10, 2020 at 7:46 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable dp_ref_clk_khz is being initialized with a value that is
> never read and it is being updated later with a new value.  The
> initialization is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> index 26db1c5d4e4d..b210f8e9d592 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -131,7 +131,7 @@ int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
>         struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
>         int dprefclk_wdivider;
>         int dprefclk_src_sel;
> -       int dp_ref_clk_khz = 600000;
> +       int dp_ref_clk_khz;
>         int target_div;
>
>         /* ASSERT DP Reference Clock source is from DFS*/
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
