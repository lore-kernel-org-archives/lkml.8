Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E63C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1285A20656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="NmuMt05w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894684AbgDPM7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2894656AbgDPM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:59:25 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A269AC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 05:59:23 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id rh22so1205677ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pqocv/eXd8agG6oQNiPQwe8tU9LueQq90txyZdBuL44=;
        b=NmuMt05wm0nh5pDYjx6jFJ0hyrfOZRfh4rtC8/XsvZETXclm+D/BaNlRZO9BveAbGR
         lXujA2tdsIMCv//33DS0v39tE/BzDr4ZuQktKV6XBouxm5jSWRR0MgXI5g0fLvBuM0kY
         rL0gOwH+/35QQdDIXLEQ/WSZu7csyiz8qW56jw3APfWNuySnek1cPaq7Y3BVw8l48kLb
         BSUDgOE0zeqFY3UBi6DU/xrARIijIXQTtneZdeRg3U1OSxDp+WUatnUACvILY5GawGPG
         c1S9G8rt9VQaJGndxGxdtwhZ3i7RLa0UyrBd1u501/qqb8BCZNa/viQTVy9VHUq3Zz8M
         P5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pqocv/eXd8agG6oQNiPQwe8tU9LueQq90txyZdBuL44=;
        b=WAX59NssNQmi0pGoYuwfTIcsnHaCRhvWkDCFbX4dJXPwWa0+iuO8YhgtSU/P0btRS/
         MlXn+hRZtjCTtRJTPYMdWMGeqp1tmk8DOL+6oHOEELnbV5F9C+KUkcOxiMshMhBVlMIf
         4FPDWQRkltfCb/1XhBuR5ZcQuwZLLvEt+YZRZUGNf4uqvdaUCfWljPkKid2G9JxLOxgg
         LJijSXI9PjvvmNxFv3OKfV4KtkgMp87d2YtMPJXqkODT3ZeflvJhkTpB/fq8XaOVC4bI
         sJwv9qKoFgI2MjB6cqusVuCzhOR2lIzCsvsMnvE27Q8LnH533ACsCExpisn+VmI3zkTN
         o47w==
X-Gm-Message-State: AGi0PuZJUPe/2kiAi36btmOOs73rUpj3yR4atDccnwm2pNYEeT6jJ4km
        XZbYMDlTvu9hunu1dKnn5WOvAt9RE9mSyoG7J+21PA==
X-Google-Smtp-Source: APiQypJZ8a9Xj0AcqhtwU+4h7TWpCu2z8o/G+gdZiRVW5tZY0fxY1YqboCEkjK1ptgUJPvQE71pdnqe4P0py81bICVY=
X-Received: by 2002:a17:906:af6f:: with SMTP id os15mr9748919ejb.78.1587041962281;
 Thu, 16 Apr 2020 05:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200410103501.1083-1-sergey.senozhatsky@gmail.com>
In-Reply-To: <20200410103501.1083-1-sergey.senozhatsky@gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 16 Apr 2020 09:59:10 -0300
Message-ID: <CAAEAJfCyWpNy-Ckn+6fdzUTFiDr5RqYD4V5BgUviRRBxr=ggBQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] media: v4l2-ctrls: add more NULL pointer checks
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

Thanks for the patch!

On Fri, 10 Apr 2020 at 07:35, Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> A number of v4l2-ctrls functions gracefully handle NULL ctrl pointers,
> for instance, v4l2_g_ctrl(), v4l2_ctrl_activate(), __v4l2_ctrl_grab()

Please note that v4l2_g_ctrl doesn't really handle
a NULL ctrl parameter, because it doesn't have a ctrl
parameter :-)

Checking the return of a function such as v4l2_ctrl_find,
is not the same as defensive-style parameter checking.

And the thing is, the kernel doesn't really do defensive checking
like this on internal APIs, unless there are good reasons
allowing a NULL parameter, such as kfree.

Now, maybe this is the case, maybe it should be possible
to add controls without checking the result, or to allow
calling the control API with a NULL ctrl.

Quite frankly, I'm not convinced of this being the case,
or just a quirk of the vivid driver.

In any case...

> to name a few. But not all of them. It is relatively easy to crash the
> kernel with the NULL pointer dereference:
>
>         # modprobe vivid node_types=0x60000
>         $ v4l2-compliance
>
> BUG: kernel NULL pointer dereference, address: 0000000000000020
> PF: supervisor read access in kernel mode
> PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP PTI
> RIP: 0010:v4l2_ctrl_s_ctrl.isra.0+0x4/0x30 [vivid]
> Call Trace:
>  vidioc_s_input.cold+0x1a8/0x38d [vivid]
>  __video_do_ioctl+0x372/0x3a0 [videodev]
>  ? v4l_enumstd+0x20/0x20 [videodev]
>  ? v4l_enumstd+0x20/0x20 [videodev]
>  video_usercopy+0x1cb/0x450 [videodev]
>  v4l2_ioctl+0x3f/0x50 [videodev]
>  ksys_ioctl+0x3f1/0x7e0
>  ? vfs_write+0x1c4/0x1f0
>  __x64_sys_ioctl+0x11/0x20
>  do_syscall_64+0x49/0x2c0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> vivid driver crashes the kernel in various places, for instance,
>
>         v4l2_ctrl_modify_range(dev->brightness, ...);
> or
>         v4l2_ctrl_s_ctrl(dev->brightness, ...);
>
> because ->brightness (and quite likely some more controls) is NULL.
> While we may fix the vivid driver, it would be safer to fix core
> API. This patch adds more NULL pointer checks to ctrl API.
>
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  drivers/media/v4l2-core/v4l2-ctrls.c | 22 ++++++++++++++++-
>  include/media/v4l2-ctrls.h           | 37 ++++++++++++++++++++++++++--
>  2 files changed, 56 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> index 93d33d1db4e8..02a60f67c2ee 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -2869,6 +2869,9 @@ EXPORT_SYMBOL(v4l2_ctrl_add_handler);
>
>  bool v4l2_ctrl_radio_filter(const struct v4l2_ctrl *ctrl)
>  {
> +       if (WARN_ON(!ctrl))
> +               return false;
> +

.. don't think this is needed, as it's always called via v4l2_ctrl_add_handler
which guarantess a non-NULL pointer.

Thanks!
Ezequiel
