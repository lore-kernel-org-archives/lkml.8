Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9847DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EAAE207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oIkV2Iwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgE2UEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgE2UET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:04:19 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3DDC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:04:18 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bg4so1672312plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+g7Oezu2RunpZeGCvY0b0s77w8UFoTcEBsYnh2aCmE=;
        b=oIkV2IwxnKvjZgJ+qdLb8Jx8V/wvhITFMVzbJY5nzmFPezh71a7tDAioCbghNilrqs
         yf84zuHV81ZntwYnrKWyOTM34RfkWDtvc91CAwfcOb5HwHt6B4JGIuGTCe/wMOHB291r
         CTJHTLRbWq9I5PCPnqdJ53R1Y2qNC0FTlRUaecb83hWz+ZlkIRBlsB3o7WcIpN7t0ZN6
         VFJHEH0lA2f4glK3hI6hWda5gKLsfuVoRvyNDt5Qf5nuhAhRM4Pyl8lucO5iZ2oOMKmZ
         OpsQLoTKWgx/PG4/O3BnWMpiV0OLPhRPx3kbaB4J9OwG6eMdDqLVuPffUlG4qP0nvm++
         bcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+g7Oezu2RunpZeGCvY0b0s77w8UFoTcEBsYnh2aCmE=;
        b=EXQxkJyK+XuAjaKyNY+XqOHCMRepO6JHVQwk7btAlFn7eOGFvI7hEjlpqVXc5WDvDi
         XMOX0HddJdbh13pONylTYFioZ5zGcFpn2ZeEZaqodQKEJ5GPXaNIp9V79JSJ9MoXhO/M
         8NdGzQLJiaKojSXMkJbbuHYACcykNjm3gs3l8DAK1m7Ug6aZySrGIpxKXmi3OJcWa1cT
         21cTIZiBUP9qYOzq0xdtwvi9qZkSahxZWvARN838sr4BcnXZ05hzlU7en8j0Zd68rmy0
         THAemLDzQ+zGfwZP0qsiAdIQl2/bVv3nvs/EmtNeGinEOx/Kh6SLVDhqWo/UKLL7SCtY
         kRiQ==
X-Gm-Message-State: AOAM530g342Y2cIMSeUVbsjp7mqc2ii3MhbTFIbWJPFwwtuF/H3MzT/U
        c9IE6JbF3XOp5YggkAd1bmpemm+DUFg2HL5iDnSNaA==
X-Google-Smtp-Source: ABdhPJzajSAOEPn628sZLoiLTrRZedjCZBAQvwF+keg7C4ztulX0K1oUk7mF8ipVkXUUgKnRHQMl+6ln2r4LRdFYT5Q=
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr10068319pll.223.1590782657556;
 Fri, 29 May 2020 13:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200529200031.4117841-1-arnd@arndb.de>
In-Reply-To: <20200529200031.4117841-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 May 2020 13:04:05 -0700
Message-ID: <CAKwvOdnND7XFgr7W9PvZAikJB1nKxB4K5N-oP0YrBT74oX_C9g@mail.gmail.com>
Subject: Re: [PATCH 1/9] staging: media: atomisp: fix incorrect NULL pointer check
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See also Nathan's 7 patch series.
https://lore.kernel.org/lkml/20200527071150.3381228-1-natechancellor@gmail.com/

Might be some overlap between series?

On Fri, May 29, 2020 at 1:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Checking the pointer to a member of a struct against NULL
> is pointless as clang points out:
>
> drivers/staging/media/atomisp/pci/atomisp_cmd.c:4278:17: error: address of 'config->info' will always evaluate to 'true'
>
> Check the original pointer instead, which may also be
> unnecessary here, but makes a little more sense.
>
> Fixes: 9d4fa1a16b28 ("media: atomisp: cleanup directory hierarchy")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/media/atomisp/pci/atomisp_cmd.c | 2 +-
>  drivers/staging/media/atomisp/pci/sh_css.c      | 4 ++--
>  drivers/staging/media/atomisp/pci/sh_css_sp.c   | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
> index 5be690f876c1..342fc3b34fe0 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
> @@ -4275,7 +4275,7 @@ int atomisp_param(struct atomisp_sub_device *asd, int flag,
>                     atomisp_css_get_dvs_grid_info(
>                         &asd->params.curr_grid_info);
>
> -               if (!&config->info) {
> +               if (!config) {
>                         dev_err(isp->dev, "ERROR: NULL pointer in grid_info\n");
>                         return -EINVAL;
>                 }
> diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
> index d77432254a2c..e91c6029c651 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css.c
> +++ b/drivers/staging/media/atomisp/pci/sh_css.c
> @@ -8534,7 +8534,7 @@ ia_css_pipe_load_extension(struct ia_css_pipe *pipe,
>
>         if (firmware->info.isp.type == IA_CSS_ACC_OUTPUT)
>         {
> -               if (&pipe->output_stage)
> +               if (pipe)
>                         append_firmware(&pipe->output_stage, firmware);
>                 else {
>                         IA_CSS_LEAVE_ERR_PRIVATE(IA_CSS_ERR_INTERNAL_ERROR);
> @@ -8542,7 +8542,7 @@ ia_css_pipe_load_extension(struct ia_css_pipe *pipe,
>                 }
>         } else if (firmware->info.isp.type == IA_CSS_ACC_VIEWFINDER)
>         {
> -               if (&pipe->vf_stage)
> +               if (pipe)
>                         append_firmware(&pipe->vf_stage, firmware);
>                 else {
>                         IA_CSS_LEAVE_ERR_PRIVATE(IA_CSS_ERR_INTERNAL_ERROR);
> diff --git a/drivers/staging/media/atomisp/pci/sh_css_sp.c b/drivers/staging/media/atomisp/pci/sh_css_sp.c
> index e574396ad0f4..c0e579c1705f 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css_sp.c
> +++ b/drivers/staging/media/atomisp/pci/sh_css_sp.c
> @@ -1022,7 +1022,7 @@ sh_css_sp_init_stage(struct ia_css_binary *binary,
>                 if (!pipe)
>                         return IA_CSS_ERR_INTERNAL_ERROR;
>                 ia_css_get_crop_offsets(pipe, &args->in_frame->info);
> -       } else if (&binary->in_frame_info)
> +       } else if (binary)
>         {
>                 pipe = find_pipe_by_num(sh_css_sp_group.pipe[thread_id].pipe_num);
>                 if (!pipe)
> @@ -1036,7 +1036,7 @@ sh_css_sp_init_stage(struct ia_css_binary *binary,
>                         if (!pipe)
>                                 return IA_CSS_ERR_INTERNAL_ERROR;
>                         ia_css_get_crop_offsets(pipe, &args->in_frame->info);
> -               } else if (&binary->in_frame_info) {
> +               } else if (binary) {
>                         pipe = find_pipe_by_num(sh_css_sp_group.pipe[thread_id].pipe_num);
>                         if (!pipe)
>                                 return IA_CSS_ERR_INTERNAL_ERROR;
> --
> 2.26.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200529200031.4117841-1-arnd%40arndb.de.



-- 
Thanks,
~Nick Desaulniers
