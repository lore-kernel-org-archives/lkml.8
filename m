Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA1FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7DD2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ML7H4nDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgA1Qjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:39:35 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42433 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgA1Qje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:39:34 -0500
Received: by mail-oi1-f193.google.com with SMTP id j132so9819172oih.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 08:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nD4uqM90qVZiRS6dUZrtCSHcEDqm2B4XAwmtvXy/0pA=;
        b=ML7H4nDE6zq4bTcKsWGsZFSvFV9hFgPVfiHknWBXK1ofXLjy7CGR2GwiZH98DkPnET
         1ibyf9HUBQwHYxAwiX8daYuOaV9hG0+paczgZgTIRs79c0GgXGSbKt9xIPfdrd2gDaCq
         8iiWuftq2QGUFS+zglwb9t+VRJriBuBlvH+Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nD4uqM90qVZiRS6dUZrtCSHcEDqm2B4XAwmtvXy/0pA=;
        b=AbYArgb0NR9NPxjGdrkz/zsd1JwDQcG1UxTxOperEYgOmkjH8ov8A81x6gNHNCqwoZ
         76OtpbO2k/+Dm+uTtMKbQXOHR8LmRsGQxW43xL66GYO3Bk0shpU0EBJhg8Jfoj/tqF5v
         sKbKUSM1kn2VEgJlBg+IlwK2NW7RCAzXOpKOp2CtH+ioHYeLItkd+pN2/0L54W+Z0S1V
         lDgOxbLxE62QUwRivPih+tW8jS42JGpfQUclawQBwJOl2I5N9hgM5eSJOTFQ4YQMufUx
         YqjoE627o85Jn3LMqoIOW4g0eki0y3dZ+QS3/mw0/Yw32td8g9maVWubBMJFG1anuWXJ
         K58A==
X-Gm-Message-State: APjAAAUhYLJwChlOQoB6rBwZ6X+idFgIyk1Wc91OWwZyk8mAYCKUDnuC
        /fDAzxNVkJgkWaQx0Aauj2fAO0r+xARAFn9X2CdfSQ==
X-Google-Smtp-Source: APXvYqzVolj3YtRfGSVh3phqyOIPhVt6ICt2M0KXD4VyXnXjkWPT4SkGeJy+ULeEK4dpDNDFLaQW70SqzZ3sWpvjXMc=
X-Received: by 2002:aca:d985:: with SMTP id q127mr3302927oig.132.1580229573356;
 Tue, 28 Jan 2020 08:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20200120100014.23488-1-kraxel@redhat.com>
In-Reply-To: <20200120100014.23488-1-kraxel@redhat.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 28 Jan 2020 17:39:22 +0100
Message-ID: <CAKMK7uGMTLoyMnfLmx3r9+qf6sMXcrKT_EgO78f=Gw0Oi51kWQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev: wait for references go away
To:     Gerd Hoffmann <kraxel@redhat.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        marmarek@invisiblethingslab.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 11:00 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Problem: do_unregister_framebuffer() might return before the device is
> fully cleaned up, due to userspace having a file handle for /dev/fb0
> open.  Which can result in drm driver not being able to grab resources
> (and fail initialization) because the firmware framebuffer still holds
> them.  Reportedly plymouth can trigger this.
>
> Fix this by trying to wait until all references are gone.  Don't wait
> forever though given that userspace might keep the file handle open.
>
> Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab=
.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

(Missed this because lca, so a bit late)

This isn't really how driver unload is supposed to happen. Instead:

- Driver unload starts
- Driver calls the foo_unregister function, which stops new userspace
from getting at the driver. If you're subsystem is good (i.e. drm
since Noralf fixed it) this will also sufficiently synchronize with
any pending ioctl.
- Important: This does _not_ wait until userspace closes all
references. You can't force that.
- Driver releases all hw structures and mappings and everything else.
With fbdev this is currently not fully race free because no one is
synchronizing with userspace everywhere correctly.

... much time can pass ...

- Userspace releases the last references, which triggers the final
destroy stuff and which releases the memory occupied by various
structures still (but not anything releated to hw or anything else
really).

So there's two bits:

1. Synchronizing with pending ioctls. This is mostly there already
with lock_fb_info/unlock_fb_info. From a quick look the missing bit
seems to be that the unregister code is not taking that lock, and so
not sufficiently synchronizing against concurrent ioctl calls and
other stuff. Plus would need to audit all entry points.

1a. fbcon works differently. Don't look too closely, but this is also
not the problem your facing here.

2. Refcounting of the fb structure and hw teardown. That's what's
tracked in fb_info->count. Most likely the fbdev driver you have has a
wrong split between the hw teardown code and what's in fb_destroy. If
you have any hw cleanup code in fb_destroy that driver is buggy. efifb
is very buggy in that area :-) Same for offb, simplefb, vesafb and
vesa16fb.

We might need a new fb_unregister callback for these drivers to be
able to fix this properly. Because the unregister comes from the fbdev
core, and not the driver as usual, so the usual driver unload sequence
doesnt work:

drm_dev_unregister();
... release all hw resource ...

drm_dev_put();

Or in terms of fbdev:

unregister_framebuffer(info);
... release all hw resources ... <- everyone gets this wrong
framebuffer_release(info); <- also wrong because not refcounted,
hooray, this should be moved to to end of the ->fb_destroy callback

So we need a callback to put the "release all hw resources" step into
the flow at the right place. Another option (slightly less midlayer)
would be to add a fb_takeover hook, for these platforms drivers, which
would then do the above sequence (like at driver unload).

Also adding Noralf, since he's fixed up all the drm stuff in this area
in the past.

Cheers, Daniel

> ---
>  drivers/video/fbdev/core/fbmem.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/=
fbmem.c
> index d04554959ea7..2ea8ac05b065 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -35,6 +35,7 @@
>  #include <linux/fbcon.h>
>  #include <linux/mem_encrypt.h>
>  #include <linux/pci.h>
> +#include <linux/delay.h>
>
>  #include <asm/fb.h>
>
> @@ -1707,6 +1708,8 @@ static void unlink_framebuffer(struct fb_info *fb_i=
nfo)
>
>  static void do_unregister_framebuffer(struct fb_info *fb_info)
>  {
> +       int limit =3D 100;
> +
>         unlink_framebuffer(fb_info);
>         if (fb_info->pixmap.addr &&
>             (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
> @@ -1726,6 +1729,10 @@ static void do_unregister_framebuffer(struct fb_in=
fo *fb_info)
>         fbcon_fb_unregistered(fb_info);
>         console_unlock();
>
> +       /* try wait until all references are gone */
> +       while (atomic_read(&fb_info->count) > 1 && --limit > 0)
> +               msleep(10);
> +
>         /* this may free fb info */
>         put_fb_info(fb_info);
>  }
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
