Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29294C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 19:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46D62072A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 19:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7EDzTSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHATah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 15:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHATag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 15:30:36 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B65CC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 12:30:36 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so957097ljn.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 12:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SlN9/S+aNdC6sddgxbiMaYF2Yz0R+ULiccy0Ba778V0=;
        b=P7EDzTSg73QoN3lZ0AoPLC9cx19Vl1Jl7kYRTK/Q71lxHcBph/vO0pOWVEg6YXCg3/
         1MmqL9O5Msal7fj4bshj17XurZpbZsErvnck6JiYho+Kta1ped8Rmbvg3kXXh74Vy0B8
         7SA40X0sczsUcnwVhlsRNZpn0JIsEkl8AV/yWDrErFwwcrLKTNOPUCETLoAWdzT2WNo1
         E4ZbGeR0ZaX4o0ce1bnttKKc5290Ls9AWJWeNP3QIoarfFSDflby4UvoWE8iUqIicsos
         1XWlX+Uq10bwI6F109IFN1M0WdD64NpAlpDwCJ0Pbm8VV8zamytYVSvEqcxcUPI95a3L
         /IOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SlN9/S+aNdC6sddgxbiMaYF2Yz0R+ULiccy0Ba778V0=;
        b=SoqgZ/FCSIcIagw08hFhPMieFaFR0bCWHiJuW2H/U2+LB+qF97X/e0sg/GhUgm90Pr
         sYEk+5GgJCysHxB+0bR2xV/l4TPrp7YCSxpNKD04hxVfw800IuESX+QvxRXaey1szXvt
         UewmRUnDFj0gjtxfRH+aXNc3AZEwQl5VhP20i1KTYJ67/2mrQcBfey0gsvgYlG6saSfD
         HJgBVpyHaI/88Xn2v3XFqQZha6DK70GU5NWSPDZSqGgB2WX8TGTlBgwmSuwvPZeV+ZK7
         UZkSn8oQxaSGgZseJvOBuL+3lObE7Xo3XKZKQvW2g4g+192hGBFHqNSHoS5lyu2m7u+M
         iesQ==
X-Gm-Message-State: AOAM5303e/3gbmjG6bl4+fUb08jm8pkcKZpYdvprTFdx43fGIMz355r3
        1F89Ve+k4jhbnssawZ8YGykJTqVTiwYbTUwKh4QP/+eR
X-Google-Smtp-Source: ABdhPJxeKPTnUhdR8Rn6HnsdvsqA85nyB3c5n3E3GiD3AUsCCD2lZrgS1aEmHrHP54o8XOhQMaSaYCJhRuzcMsRegpM=
X-Received: by 2002:a2e:9859:: with SMTP id e25mr1034219ljj.410.1596310234519;
 Sat, 01 Aug 2020 12:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200729152231.13249-1-realwakka@gmail.com>
In-Reply-To: <20200729152231.13249-1-realwakka@gmail.com>
From:   Melissa Wen <melissa.srw@gmail.com>
Date:   Sat, 1 Aug 2020 16:30:23 -0300
Message-ID: <CAJeY4oEAHmY5icF_EPpojW5U+ryt3-guuvGQfj_S=XskO_xyRA@mail.gmail.com>
Subject: Re: [PATCH] drm/vkms: modify sequence disable/plane/enable in commit_tail
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 12:22 PM Sidong Yang <realwakka@gmail.com> wrote:
>
> This patch modifies function call sequence in commit tail. This is for
> the problem that raised when kms_cursor_crc test is tested repeatedly.
> In second test, there is an bug that crtc commit doesn't start vblank eve=
nts.
> Because there is some error about vblank's refcount. in commit_flush() th=
at
> called from commit_plane, drm_vblank_get() is called and vblank is enable=
d
> in normal case. But in second test, vblank isn't enable for vblank->refco=
unt
> is already increased in previous test. Increased refcount will be decreas=
ed
> in drm_atomic_helper_commit_modeset_enables() after commit_plane.
> Therefore, commit_plane should be called after commit_modeset_enable.
>
> In this situation, there is a warning raised in get_vblank_timestamp().
> hrtimer.node.expires and vblank->time are zero for no vblank events befor=
e.
> This patch returns current time when vblank is not enabled.
>
Hi Sidong,

I think this patch tries to solve two different issues.

I am not a maintainer, but I believe you can split it.

Everything indicates that changing the commit tail sequence does not
ideally solve the problem of subtests getting stuck (as we have dicussed);
however, for me, the treatment of the warning is valid and it is also relat=
ed
to other IGT tests using VKMS.

One option is to send a patch that only treats the warning. I believe that
in the body of the commit message, it would be nice to have the warning
that this patch addresses, and when it appears by running an IGT test.
Also, say why it should be done this way in vkms.
This info could help future debugging.

Off-topic: I removed the group's mailing list of the University of S=C3=A3o
Paulo (kernel-usp) from the cc, since I believe you had no intention of
sending the patch to them.

Best regards,

Melissa

> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c | 5 +++++
>  drivers/gpu/drm/vkms/vkms_drv.c  | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms=
_crtc.c
> index ac85e17428f8..09c012d54d58 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -86,6 +86,11 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc =
*crtc,
>         struct vkms_output *output =3D &vkmsdev->output;
>         struct drm_vblank_crtc *vblank =3D &dev->vblank[pipe];
>
> +       if (!READ_ONCE(vblank->enabled)) {
> +               *vblank_time =3D ktime_get();
> +               return true;
> +       }
> +
>         *vblank_time =3D READ_ONCE(output->vblank_hrtimer.node.expires);
>
>         if (WARN_ON(*vblank_time =3D=3D vblank->time))
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_=
drv.c
> index 1e8b2169d834..c2c83a01d4a7 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -76,10 +76,10 @@ static void vkms_atomic_commit_tail(struct drm_atomic=
_state *old_state)
>
>         drm_atomic_helper_commit_modeset_disables(dev, old_state);
>
> -       drm_atomic_helper_commit_planes(dev, old_state, 0);
> -
>         drm_atomic_helper_commit_modeset_enables(dev, old_state);
>
> +       drm_atomic_helper_commit_planes(dev, old_state, 0);
> +
>         drm_atomic_helper_fake_vblank(old_state);
>
>         drm_atomic_helper_commit_hw_done(old_state);
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-usp+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kernel-usp/20200729152231.13249-1-realwakka%40gmail.com.
