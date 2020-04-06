Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBC3C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5A520672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="EJZ4+f8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgDFTqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:46:08 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:34911 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFTqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:46:08 -0400
Received: by mail-il1-f193.google.com with SMTP id u15so456176ilm.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 12:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pqdM4albOPOy3AZvC52W1X+oMJ+ayp+9lG6bAjF590=;
        b=EJZ4+f8FXWMH9z7TXBeHek+lsf+bw3y0S6R+vNG8yqluQyLJU9UHQc1j6V2FdbQozw
         NWWwLzOsKgIzPavdkMoe6B/0uHbk4InVuIhtu5Ij3bTCPw4DxD+435BQHbB9WS/6nOwL
         Ytft9w2UTujVbdkvuyXCXR9z+1LAszxrsZ2Y64wwLs1IO2HE05aW63dxyn8Bg7My2/7E
         BPHKrzR0ZqG+R4mpOFUINLUx/Y/CXhVcyO6We88jUiYLK+LO5fHRp8KajrQoISnM05Dw
         eMPbKWtHv5IjaDFpybeSf4zKR+uMk79mhaO3sSdXsOc7Y9PXWlRY9MyKXO0JB/H6g1si
         SJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pqdM4albOPOy3AZvC52W1X+oMJ+ayp+9lG6bAjF590=;
        b=VI/x/T7SGw/xfxTLadWVZ+s8BVrl2WXZNGYGO3pYOrnGa9kvXZb9Z+fSxl64cnOUvJ
         nCB7WsTJlf75EyNzc7A+p+LVf3rAYJk47Yydp8vTKqqleHRaCTQxrTymTuRjkadY7k44
         zoknFESJaK9cuKa0HXwYvNYAFUlzroAh5ICCiU8SnE3LGrZuIhPvGuNwCFl2Q4Cyd6aZ
         tUFXxIzRLtdFh02t3UhYcOsI6O5CBnvvb5Nq+eoBHmz5l8WQ9g+AVI/4bSMTFiGTt7Ih
         nQ6j7ubLZ47de5oT7elBJbnkhPPoL9kThkQRG6j/b6st3V04Itzre7ka17RMiiZXfPJa
         DkMw==
X-Gm-Message-State: AGi0PuabZCd3FfIzRNkSLLTcQeTcwNgmb7ZmQlcJHiFXxbxvFiWCr6BD
        0quHDDmdchMDd8xf+vC9wQHlR+FzyTiC/O1/nWB/Nw==
X-Google-Smtp-Source: APiQypIzxUc9lo8BfgwCF7ePRKNh7UGZuyaMOHCzkUQNYY3Os8wHIXONk+oHbmhLDFH2B5S1ofvx8r8osaKrZ9Rz8mw=
X-Received: by 2002:a92:1dd9:: with SMTP id g86mr1095904ile.2.1586202367018;
 Mon, 06 Apr 2020 12:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200406193352.1245985-1-lyude@redhat.com>
In-Reply-To: <20200406193352.1245985-1-lyude@redhat.com>
From:   Sean Paul <sean@poorly.run>
Date:   Mon, 6 Apr 2020 15:45:31 -0400
Message-ID: <CAMavQK+tFSVx068FKnxD0X6TMWnf_TKPHy4ZmR=CD8kGtk5A_w@mail.gmail.com>
Subject: Re: [PATCH] drm/dp_mst: Fix NULL deref in drm_dp_get_one_sb_msg()
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

On Mon, Apr 6, 2020 at 3:34 PM Lyude Paul <lyude@redhat.com> wrote:
>
> While we don't need this function to store an mstb anywhere for UP
> requests since we process them asynchronously, we do need to make sure
> that we don't try to write to **mstb for UP requests otherwise we'll
> cause a NULL pointer deref:
>
>     RIP: 0010:drm_dp_get_one_sb_msg+0x4b/0x460 [drm_kms_helper]
>     Call Trace:
>      ? vprintk_emit+0x16a/0x230
>      ? drm_dp_mst_hpd_irq+0x133/0x1010 [drm_kms_helper]
>      drm_dp_mst_hpd_irq+0x133/0x1010 [drm_kms_helper]
>      ? __drm_dbg+0x87/0x90 [drm]
>      ? intel_dp_hpd_pulse+0x24b/0x400 [i915]
>      intel_dp_hpd_pulse+0x24b/0x400 [i915]
>      i915_digport_work_func+0xd6/0x160 [i915]
>      process_one_work+0x1a9/0x370
>      worker_thread+0x4d/0x3a0
>      kthread+0xf9/0x130
>      ? process_one_work+0x370/0x370
>      ? kthread_park+0x90/0x90
>      ret_from_fork+0x35/0x40
>
> So, fix this.

Ugggh, what a fail! I found this in Feb and posted the patch in
20200218171522.GF253734@art_vandelay. I had to migrate my workstation
due to WFH order and didn't apply the patch before pushing. Messy
messy messy.

Thanks for fixing!

Reviewed-by: Sean Paul <sean@poorly.run>

>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: fbc821c4a506 ("drm/mst: Support simultaneous down replies")
> Cc: Wayne Lin <Wayne.Lin@amd.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Wayne Lin <waynelin@amd.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 1ff49547b2e8..8751278b3941 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3703,7 +3703,8 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up,
>         int basereg = up ? DP_SIDEBAND_MSG_UP_REQ_BASE :
>                            DP_SIDEBAND_MSG_DOWN_REP_BASE;
>
> -       *mstb = NULL;
> +       if (!up)
> +               *mstb = NULL;
>         *seqno = -1;
>
>         len = min(mgr->max_dpcd_transaction_bytes, 16);
> --
> 2.25.1
>
