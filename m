Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED922C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD23F2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="ZAmz+GjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDFTYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:24:24 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:32880 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFTYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:24:23 -0400
Received: by mail-il1-f194.google.com with SMTP id k29so677727ilg.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 12:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vePX0/zywlzH/S3pB4C4OQDkDkegT3qQSMEsAoWIPuc=;
        b=ZAmz+GjJjLF4PlS9vtEeLKUZ1oOZ13Gyd7sGQCR5YO9Hc0UXp6aoZdrwCaL9kCEUnA
         cOvFtLY21jz6X4TTAvJ5i9zxcVKrq50xT3z+ZQH4nzBwBxuZsds9EgHd5Jh/B4GnHjMI
         gb4Fivc2nyAbAg0PuA+5EVBZoevMCno9B1edFLNPe5qBw5+Zi3hO9jqV4K0v9SGkXunN
         chfufTf/QYAhCf+Y2BWfwWvSkKM9hoTFoIYLwlIjWS0yUhbyqgsb89Dj1pBu8zDqhieV
         se9OX4bwhCB+5XB2qXblllxcrLk2knEyumL4GBZ3rHZqp4WePONPYj457rD7l5BS4YAK
         FCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vePX0/zywlzH/S3pB4C4OQDkDkegT3qQSMEsAoWIPuc=;
        b=Z2di9S744q6t3fm4IHKNH2R9M5TeLtVf+GNUQTAM8aynvxrjqpdT6rGWzBc9Ub8Qg2
         tZnDioF81eNWVE+y+l+4xKQiyJlFbCY2Dn2EOQxFJtU8mfDa2L4UXkjr1r8HWiuH97q3
         nljn1jRPIgK7AcEnVhSxs5DCxVrRFg9GcqVvKDCvUE8KhrGzMzPBDi+3cx88kFU313Pt
         e3a/ojFCAbS61+Op8UGlYLaAGuCjnTO9lVWkMwLiDy3xHgnb/zonD5F3pvTlBmWruOpJ
         4W/HpuMccy1gS2eHmrcXPjTmjIkJFrgeAtGlvEsdm5I5ZebBGA1FffngINz6jg0RCuD9
         n2Pw==
X-Gm-Message-State: AGi0PuZ8Y5eNruqEefUIB0r3JZq3TTlbLKG2dDczYyzf+ho5eHlqhX+W
        bigVlyBQXkYEVo6y1aAY4/CeBi/QS3/WZ7zMEHiyCg==
X-Google-Smtp-Source: APiQypL2MG5b6ggF1ip4yCdvbuL8ZGEpWTi12pOkrrcYep7bseoSKkbcrp87/m+HbZrf5Mac2unzD5FFDmdmURhBvkM=
X-Received: by 2002:a92:3b56:: with SMTP id i83mr960355ila.75.1586201062614;
 Mon, 06 Apr 2020 12:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200403200757.886443-1-lyude@redhat.com> <20200403200757.886443-3-lyude@redhat.com>
In-Reply-To: <20200403200757.886443-3-lyude@redhat.com>
From:   Sean Paul <sean@poorly.run>
Date:   Mon, 6 Apr 2020 15:23:46 -0400
Message-ID: <CAMavQKL6G9QsUE7ZzGXNpjjEVdZGQZkbN3oke-M=Lz=pHOn70A@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/dp_mst: Reformat drm_dp_check_act_status() a bit
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        stable <stable@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Todd Previte <tprevite@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 4:08 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Just add a bit more line wrapping, get rid of some extraneous
> whitespace, remove an unneeded goto label, and move around some variable
> declarations. No functional changes here.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> [this isn't a fix, but it's needed for the fix that comes after this]
> Fixes: ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper (v0.6)")
> Cc: Sean Paul <sean@poorly.run>
> Cc: <stable@vger.kernel.org> # v3.17+
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 2b9ce965f044..7aaf184a2e5f 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -4473,33 +4473,31 @@ static int drm_dp_dpcd_write_payload(struct drm_dp_mst_topology_mgr *mgr,
>   */
>  int drm_dp_check_act_status(struct drm_dp_mst_topology_mgr *mgr)
>  {
> +       int count = 0, ret;
>         u8 status;
> -       int ret;
> -       int count = 0;
>
>         do {
> -               ret = drm_dp_dpcd_readb(mgr->aux, DP_PAYLOAD_TABLE_UPDATE_STATUS, &status);
> -
> +               ret = drm_dp_dpcd_readb(mgr->aux,
> +                                       DP_PAYLOAD_TABLE_UPDATE_STATUS,
> +                                       &status);
>                 if (ret < 0) {
> -                       DRM_DEBUG_KMS("failed to read payload table status %d\n", ret);
> -                       goto fail;
> +                       DRM_DEBUG_KMS("failed to read payload table status %d\n",
> +                                     ret);
> +                       return ret;
>                 }
>
>                 if (status & DP_PAYLOAD_ACT_HANDLED)
>                         break;
>                 count++;
>                 udelay(100);
> -
>         } while (count < 30);
>
>         if (!(status & DP_PAYLOAD_ACT_HANDLED)) {
> -               DRM_DEBUG_KMS("failed to get ACT bit %d after %d retries\n", status, count);
> -               ret = -EINVAL;
> -               goto fail;
> +               DRM_DEBUG_KMS("failed to get ACT bit %d after %d retries\n",

Should we print status in base16 here?

Otherwise:

Reviewed-by: Sean Paul <sean@poorly.run>

> +                             status, count);
> +               return -EINVAL;
>         }
>         return 0;
> -fail:
> -       return ret;
>  }
>  EXPORT_SYMBOL(drm_dp_check_act_status);
>
> --
> 2.25.1
>
