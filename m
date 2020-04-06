Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD25C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD38206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="QuGm95H/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDFTno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:43:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44615 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgDFTnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:43:43 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so727667iok.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abwTcU3NPLB9ZnkU0lkxt+NZ4BdMbKcPpC7Ll2Lyoj8=;
        b=QuGm95H/LilnuJBVmVnYx0H7LMduoXK1eUUubT4UBJaC+N68X41iFuZPPIL/qJvwQd
         h4G6ju6hnHbddVb0RuUkYDuVMdezs+invBSiSoOMIbxIChuZqsWIDUpiUxqJKs4gQoOg
         n7E5NwCaO8If0SlL+U/0bhgS4HOPazzvYzPyAxK1IGqwWBD7H0R31WaE853O5cgKoNT+
         cFRrmKFGfNzVeEXky8pX8Bz1mBOdRP15EAtc7GFWOj1VGJI47Po6klHBFnRsMb5szO9X
         k2uJkx9KxgbF9hLJOhotAOxW3WVprGYUxZa8ddaEJlkIfFRkKYjaz36CCeoBBvfULPOx
         tobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abwTcU3NPLB9ZnkU0lkxt+NZ4BdMbKcPpC7Ll2Lyoj8=;
        b=hUz46CS4VAMR2Gm1GIW+I2RwihHXwHDtFFzDj376JBaYYsIk7cnuS52Aiy1pMF8xtX
         5nk5jKQJw51X/Hyj9p5zdjjif7rjVwlwcXfgeGTLl8xVPPczbXGNtjuiLZnSwJZCInH2
         ON+HqlPNo9cgfLzcxLHqhJt3hrQ3KAMSvxnJAafXw43/DaZcD1p8DAUkfCyISp5Djb92
         YuP416wGos8SbsPIozwqC1iFwWVkHO2wnzv9JS2b67BAiGKB536zBm9imrhX/83kdVFZ
         dzso5Mx9t8bNvqM273vBWLUtrNlk1PioyAI/DRSyjw6EEMIc+yBm4OB/gb1WPZclcYro
         okWA==
X-Gm-Message-State: AGi0PuZhHtC4WAIzydPkj88NTCaMYKJqpn3DcuCQ/czo4J/lEUNT2Y8Z
        u4DyYB9hbgO/WTkZXNJmqO3psBRBDTNHmoFTyyl0H8jC
X-Google-Smtp-Source: APiQypLhF2Lp08EtG9n48GKhPoxcqCViZNaBO24fDJpPAR6rwFCZHEUpxBMLCAa2E8pd6+kNcQ8CAuSRjo8ByUOfK6Y=
X-Received: by 2002:a6b:b3c3:: with SMTP id c186mr5093685iof.85.1586202222502;
 Mon, 06 Apr 2020 12:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200403200757.886443-1-lyude@redhat.com> <20200403200757.886443-5-lyude@redhat.com>
In-Reply-To: <20200403200757.886443-5-lyude@redhat.com>
From:   Sean Paul <sean@poorly.run>
Date:   Mon, 6 Apr 2020 15:43:06 -0400
Message-ID: <CAMavQK+UYf8-Esah7kLcMbQtZ_J5h_bHqEroAPkO67fB=ArHyg@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/dp_mst: Print errors on ACT timeouts
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
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

On Fri, Apr 3, 2020 at 4:08 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Although it's not unexpected for drm_dp_check_act_status() to fail due
> to DPCD read failures (as the hub may have just been unplugged
> suddenly), timeouts are a bit more worrying as they either mean we need
> a longer timeout value, or we aren't setting up payload allocations
> properly. So, let's start printing errors on timeouts.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Sean Paul <sean@poorly.run>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index f313407374ed..3d0d373f6f91 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -4494,6 +4494,10 @@ int drm_dp_check_act_status(struct drm_dp_mst_topology_mgr *mgr)
>                                         DP_PAYLOAD_TABLE_UPDATE_STATUS,
>                                         &status);
>                 if (ret < 0) {
> +                       /*
> +                        * Failure here isn't unexpected - the hub may have
> +                        * just been unplugged
> +                        */
>                         DRM_DEBUG_KMS("failed to read payload table status %d\n",
>                                       ret);
>                         return ret;
> @@ -4505,8 +4509,8 @@ int drm_dp_check_act_status(struct drm_dp_mst_topology_mgr *mgr)
>         } while (jiffies < timeout);
>
>         if (!(status & DP_PAYLOAD_ACT_HANDLED)) {
> -               DRM_DEBUG_KMS("failed to get ACT bit %d after %dms\n",
> -                             status, timeout_ms);
> +               DRM_ERROR("Failed to get ACT after %dms, last status: %02x\n",
> +                         timeout_ms, status);
>                 return -EINVAL;
>         }
>         return 0;
> --
> 2.25.1
>
