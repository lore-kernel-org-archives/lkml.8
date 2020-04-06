Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF516C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B42120672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="B9FOaVqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgDFTuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:50:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45335 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgDFTuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:50:51 -0400
Received: by mail-io1-f65.google.com with SMTP id y14so743791iol.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HN+8QL60vvL9kCpBSbE9fq49Mcbwf74LPWCucZYc7mA=;
        b=B9FOaVqTO+t9lnVPfMPMz/Adln3AhSPXYXjuqMVQ3reEdfCxDmmY6uzxlRmDiPH9pJ
         y/bpog3PifuFFOX1unxdC+wSgxSAxj56kYkUzESy4/YbG15eX8wy0tDhPr8aGNZ267T5
         xLOAP7aJ2agnjB1jHBkT5gtS5jn/nhEoQ4gm4Vlaw+9f90W8wWKSoi4smRo/G2bEi0b0
         Lux6rfQfgad3pDJdYjW2GkRY02XLUJ0C1qjB+XS2zSOILjL5oSDth0o5H/zihn5p4vXv
         jKWUP0X6U1RFeKResnizqbp70IAmVah6nnucDuP0dDgJP6xHiqKZdcFxxhj121UYu7DT
         x26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HN+8QL60vvL9kCpBSbE9fq49Mcbwf74LPWCucZYc7mA=;
        b=RH95urrFBbWrucyvcJi17tZ7S6KkQvxdl7MgF741Sq8NxIIOG86tVLdyn6E74/T1/6
         Xr//SWpmXD1XPECPnT+ZBHnWafO9PlhARpr3bCRDYTj4MhBeqWduKoVwgPNR+CH3VFHy
         zDRZ+JdqTmesmQZ23ca9BRdizorN/auhufs23WwndekXbcTMZTnLALV8wsbiWoclGVdq
         /7sWLb4LJndMbFp2CtSQNIKR649BloiGKtTrmZP38uIj1Jt9Yp/bStNDXaHlSV4fUMTW
         iACVQC6T5WLaKSQEgmmlFOqLzPPKhflArkclD0lG4rClyQDEq3+qbA8+ua+359TgVtpq
         Am3A==
X-Gm-Message-State: AGi0PuYJWNrF3BEcNdk5E6x/U3owC194J0J15Ie8W6LM8NomBMrxpkm0
        iK+E1D+WPZsZOND06QPwa0adtnZ9Q4u9L9+l3mrF1Q==
X-Google-Smtp-Source: APiQypKcSpO3QRsQOcCPdXSdBaq/JteC6JrsZevb7ueYZYqdRIjuhPUpPJUYg/2yI4JWNu2eYOisAC4GmAbJerXl2qY=
X-Received: by 2002:a02:cce2:: with SMTP id l2mr960339jaq.83.1586202650623;
 Mon, 06 Apr 2020 12:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200403200325.885628-1-lyude@redhat.com>
In-Reply-To: <20200403200325.885628-1-lyude@redhat.com>
From:   Sean Paul <sean@poorly.run>
Date:   Mon, 6 Apr 2020 15:50:14 -0400
Message-ID: <CAMavQKKvxrYdi5RfsexT=01KonqEaB-_8VompN4vbexY9gL2mA@mail.gmail.com>
Subject: Re: [PATCH] drm/dp_mst: Don't drop NAKs for down responses
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Wayne Lin <Wayne.Lin@amd.com>, Wayne Lin <waynelin@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 4:03 PM Lyude Paul <lyude@redhat.com> wrote:
>
> It looks like that when we introduced the ability to handle multiple
> down requests at once, we accidentally started dropping NAK replies -
> causing sideband messages which got NAK'd to seemingly timeout and cause
> all sorts of weirdness.
>
> So, fix this by making sure we don't return from
> drm_dp_mst_handle_down_rep() early, but instead treat NAKs like any
> other message.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: fbc821c4a506 ("drm/mst: Support simultaneous down replies")
> Cc: Wayne Lin <Wayne.Lin@amd.com>
> Cc: Wayne Lin <waynelin@amd.com>
> Cc: Sean Paul <seanpaul@chromium.org>

Thank you for fixing this

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 10d0315af513..5449ada3e019 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3813,7 +3813,6 @@ static int drm_dp_mst_handle_down_rep(struct drm_dp_mst_topology_mgr *mgr)
>                               txmsg->reply.u.nak.reason,
>                               drm_dp_mst_nak_reason_str(txmsg->reply.u.nak.reason),
>                               txmsg->reply.u.nak.nak_data);
> -               goto out_clear_reply;
>         }
>
>         memset(msg, 0, sizeof(struct drm_dp_sideband_msg_rx));
> --
> 2.25.1
>
