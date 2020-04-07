Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F73FC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E502082F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="cxUdlynH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgDGRnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:43:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41291 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGRnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:43:50 -0400
Received: by mail-io1-f68.google.com with SMTP id b12so4252109ion.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 10:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLa8vWF/VHkJLQ5tzbAupKSkO7Nd/GQhK2vTdnyt2y4=;
        b=cxUdlynHEL2HXCInGiFUbupNgINSW8CZIPliUdfXDuBkfl9kG0+4OYer70mLLKEHr0
         vqQXDHUHcRzSrzCluxfuT9/dha0FCNMZutjG/L4rpPtKF53DKgPRtuHjHhhlsYp2A9gT
         lGg1I8AXOKRD6BuuaD4mpCepf4X4ssrueLB0LWmeGOHvxvHLLo+Cfsfl3GVCxSIMtBJ2
         vc5nAAxFKSV7U4jZTZAKxx/JMFycQS+Gnb1ol6efME71kjoDqbMOLNfF7aljFlioXb0Y
         U+N1gahyzWtPx1NpLQ5wYOVx7k38jtDr/tR8LS9s7LbG34dJt1bEeYpOElRiwhKXMWlX
         ac9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLa8vWF/VHkJLQ5tzbAupKSkO7Nd/GQhK2vTdnyt2y4=;
        b=WuqUFbNVWkdj7tHf3JKe3Tl51H6XQpeAY1giLKiOh5TEkG9eU5hTlt4zN6+Xb9Yb3n
         k9uUud92609wpuUhlb1xbbJqeacN+pk8ttNvTLg3fgV9ifgsmvlCKrbCTQjQcj+2n3mz
         BMi+d8LREEZ8jZBFNnSilVWTeLqVM3MlTrG0ukSlPyxwwr42mQgRN4kgDhuYU/KDsyFK
         OE4YR10dI5pm+4r3rBb0KAAaVtZlnZC58BL8JceiuU7nMZTCEBgKYz61bnEwXpM/hiNE
         6RBBS6QNEE1EhzyQkln7h2Vkf/6YifxoQB+/Vs1xEp1fN/TiBLg+0Pfx7FCk8TTk4kjG
         9aHA==
X-Gm-Message-State: AGi0PubWCgKDHj3o1rL0X4YRoRM8oWX0tpbNWiC7pDASHegRg9cGO1f6
        al0swTQYoaK/8Kjkt1tOpSdFc0PgXN6eQIdV7p03cw==
X-Google-Smtp-Source: APiQypKdMl63j0jsbL/tOJdgN63pxjl9MivX+3Gy3v3cZnXqbMogOdk7L4fQdx+qIQ6fu9+1tIzzkvkw/t6Se/9Qp7k=
X-Received: by 2002:a6b:b3c3:: with SMTP id c186mr3156512iof.85.1586281428368;
 Tue, 07 Apr 2020 10:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200406221253.1307209-1-lyude@redhat.com> <20200406221253.1307209-5-lyude@redhat.com>
In-Reply-To: <20200406221253.1307209-5-lyude@redhat.com>
From:   Sean Paul <sean@poorly.run>
Date:   Tue, 7 Apr 2020 13:43:11 -0400
Message-ID: <CAMavQKJ5TaTbbS2iqkcQhwCbfiXoDvG5+V1qEa509GaqjBwM2g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/dp_mst: Print errors on ACT timeouts
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

On Mon, Apr 6, 2020 at 6:13 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Although it's not unexpected for drm_dp_check_act_status() to fail due
> to DPCD read failures (as the hub may have just been unplugged
> suddenly), timeouts are a bit more worrying as they either mean we need
> a longer timeout value, or we aren't setting up payload allocations
> properly. So, let's start printing errors on timeouts.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Sean Paul <sean@poorly.run>

Patches 1,2,4 are still

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index ce61964baa7c..0cbeb0f5c834 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -4499,10 +4499,14 @@ int drm_dp_check_act_status(struct drm_dp_mst_topology_mgr *mgr)
>                                  status & DP_PAYLOAD_ACT_HANDLED || status < 0,
>                                  100, timeout_ms * USEC_PER_MSEC);
>         if (ret < 0 && status >= 0) {
> -               DRM_DEBUG_KMS("Failed to get ACT bit %d after %dms\n",
> -                             status, timeout_ms);
> +               DRM_ERROR("Failed to get ACT after %dms, last status: %02x\n",
> +                         timeout_ms, status);
>                 return -EINVAL;
>         } else if (status < 0) {
> +               /*
> +                * Failure here isn't unexpected - the hub may have
> +                * just been unplugged
> +                */
>                 DRM_DEBUG_KMS("Failed to read payload table status: %d\n",
>                               status);
>                 return status;
> --
> 2.25.1
>
