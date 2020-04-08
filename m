Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96140C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6932B20768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRmrWvcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgDHTRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:17:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55577 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgDHTRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:17:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id e26so602005wmk.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6JzrZjnSiXEa9+7zWd+dDvEone33rVhyL+hGBTdC80=;
        b=hRmrWvcKKjoy8psvsbRSOoTPjT/LbPaDB5n94pF6pMwCEgeLaWJdf/aziAZXVCsFUt
         vf20mJBTzLgCgHQhkIUVzZtksdRYr2o8GFAbAUjwbQ+CcFaN5/Hk6VTY4wKNxV7byM5i
         9WPXCoOKEPT9Uw5qOyeHM+iobynnZpn8nHMPNFeTIt9ItCmmkszBFyZG3Ej4/uF5R4e+
         rAuLI8tA+6JUM2f+MVawq0VwbXBZF6BmxgKIaADMsZhAt4A6XCIJkiwX4C3joV+nERkc
         fYm1RCNJPbV0cYAeSenR5KfPn89eTA5k7qYRRPXSD7dCVRamlvyXACaKo0w4gFCwEU+q
         ZNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6JzrZjnSiXEa9+7zWd+dDvEone33rVhyL+hGBTdC80=;
        b=eoERHQh8UD4yWnALJgYr3pFjynZ/HYvlZKnclWgTfy2ZXuScyUoij1kpMk6jB3Z3vo
         ysAez8YrGdZT3Ryk1/AU//ClldG+8lOXtaV/uC0MgchFkPnhVs6/4VzmHtDsfJdfiMrZ
         lYnQ3iO0QnpynHAOX6FW3ufZcy1VZfo8+sUaNmnYU+bt+niMcDI3J3KO3x9bztnUSzSl
         4bPknZJE+71n1G2lVc4iR8EEa2Co7FiOQ7X42wTLa/4aZT0sNcKg8EWqiVO+MBQ4IVjM
         Jkct28O5u1pPShwj8XT0OIgEjMbmQxsh8Z+uIeXOhv3qgFBgtjPyJ6hcGO0dW01fZm4m
         cX0g==
X-Gm-Message-State: AGi0PuZVcgO35IyQ4DUuy72TqsJHW+Ey0n+SqeqjFEae9yKtCpTtshTo
        UWsM/A5UCDVnmtRkzZG4cqOzdeTH56zWUglmpC8=
X-Google-Smtp-Source: APiQypLTeMFPxlYaC7RUOxxRIYya9dI7QcYjmKm2GLyGj1BRBapdHfC8cywqbmuYCSzDkPolem0Eft6U6fTo14K+9hg=
X-Received: by 2002:a1c:6344:: with SMTP id x65mr3689039wmb.56.1586373462592;
 Wed, 08 Apr 2020 12:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200408191305.1179310-1-arnd@arndb.de>
In-Reply-To: <20200408191305.1179310-1-arnd@arndb.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 8 Apr 2020 15:17:31 -0400
Message-ID: <CADnq5_OQqos8x-pkYzo0zdxj3Ay427BRmau4Hyk6zX5Nd4pKDA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: avoid unused-variable warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Roman Li <roman.li@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 3:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Without CONFIG_DEBUG_FS, this newly added function causes a harmless
> warning:
>
> amdgpu_dm/amdgpu_dm.c: In function 'amdgpu_dm_connector_late_register':
> amdgpu_dm/amdgpu_dm.c:4723:30: error: unused variable 'amdgpu_dm_connector' [-Werror=unused-variable]
>  4723 |  struct amdgpu_dm_connector *amdgpu_dm_connector =
>       |                              ^~~~~~~~~~~~~~~~~~~
>
> Use an IS_ENABLED() check instead to let the compiler see what
> is going on.
>
> Fixes: 14f04fa4834a ("drm/amdgpu/display: add a late register connector callback")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Already fixed:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=drm-next&id=ef04ca2a941ae62cef517eac08210fed5c20fd5d

Alex

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d3674d805a0a..8ab23fe98059 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -51,9 +51,7 @@
>  #include "amdgpu_dm_irq.h"
>  #include "dm_helpers.h"
>  #include "amdgpu_dm_mst_types.h"
> -#if defined(CONFIG_DEBUG_FS)
>  #include "amdgpu_dm_debugfs.h"
> -#endif
>
>  #include "ivsrcid/ivsrcid_vislands30.h"
>
> @@ -4723,9 +4721,8 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
>         struct amdgpu_dm_connector *amdgpu_dm_connector =
>                 to_amdgpu_dm_connector(connector);
>
> -#if defined(CONFIG_DEBUG_FS)
> -       connector_debugfs_init(amdgpu_dm_connector);
> -#endif
> +       if (IS_ENABLED(CONFIG_DEBUG_FS))
> +               connector_debugfs_init(amdgpu_dm_connector);
>
>         return 0;
>  }
> --
> 2.26.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
