Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF7EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689CE20936
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgIIGcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:32:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36990 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgIIGcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:32:01 -0400
Received: from mail-oi1-f198.google.com ([209.85.167.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <koba.ko@canonical.com>)
        id 1kFteA-0000w8-ME
        for linux-kernel@vger.kernel.org; Wed, 09 Sep 2020 06:31:58 +0000
Received: by mail-oi1-f198.google.com with SMTP id b25so537499oic.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 23:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tt9naxs3e2ZAHwC5wB+w1syKG9EDUzrC63aR5SbSofw=;
        b=BgEApoBLDHXqPMuOrMbO6SkmKnefPP6NGkMdN+nwE3HddJGUF7J6Z/YothKeQdaeX8
         9XzleIGu4GwJJs+PeOb4cl1pVlXCKb6yGy1UdDOFo7cnmv/8n4KRp/vlKwLVy5JEqzce
         Uwa+P3JkuYHCjv/r+XXX90hJ6Pf7UEyxueOHZtWeMW4S97ESXoMlKw4RTcFq33uC+IV9
         WQnUzOh+38U4tp4XulTYfB0lDPuKCQcjN/qQBqrGb+5UcEO6IcarY3kUNwK43XrcOV9n
         /5tawCr5FhKgLsvtF8IMOVl5bLSe43DzxyofXkjW6dVHhSxKXeJEnRrWVvsgwxzoHtrV
         H6gg==
X-Gm-Message-State: AOAM530VtdQqjvb4Mu5maiM9XXriHYRDpxSQ8Tqk4YrY7VdSqtcybv77
        kPtl7ZvSTgoysW6w2r/hIIX9njRwXh8fgmXxmYY2KdWYBazOyMAuSfTvfrHtgTGKvLdan/srT9o
        IV9s7pJ8lKpzhaePgk3HpijVVmi4Bvm5ogp2eiI2kNYlmSb11yGuEGBxggw==
X-Received: by 2002:a05:6830:20d8:: with SMTP id z24mr1940333otq.3.1599633117530;
        Tue, 08 Sep 2020 23:31:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIgOfVj1Xg5MKBylPjHguycQ6vULKoi57GYsxKum8ZxbTrhGYO63dGWYCJKkz5ED1KgcVWPeVGQh57Xbg2PK4=
X-Received: by 2002:a05:6830:20d8:: with SMTP id z24mr1940322otq.3.1599633117150;
 Tue, 08 Sep 2020 23:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200827053053.11271-1-koba.ko@canonical.com>
In-Reply-To: <20200827053053.11271-1-koba.ko@canonical.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Wed, 9 Sep 2020 14:31:46 +0800
Message-ID: <CAJB-X+WPiUR8N5sLMS2UC-rPHj=TGJy2ezeBPjjeUXzbN5bfcg@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: For MST hub, Get max_link_rate&max_lane from
 extended rx capability field if EXTENDED_RECEIVER_CAPABILITY_FILED_PRESENT is set.
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lyude@redhat.com
Cc:     Anthony Wong <anthony.wong@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 1:30 PM Koba Ko <koba.ko@canonical.com> wrote:
>
> Currently, DRM get the capability of the mst hub only from DP_DPCD_REV and
> get the slower speed even the mst hub can run in the faster speed.
>
> As per DP-1.3, First check DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT.
> If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 1, read the DP_DP13_DPCD_REV to
> get the faster capability.
> If DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT is 0, read DP_DPCD_REV.
>
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 67dd72ea200e..3b84c6801281 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3497,6 +3497,8 @@ static int drm_dp_get_vc_payload_bw(u8 dp_link_bw, u8  dp_link_count)
>  int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool mst_state)
>  {
>         int ret = 0;
> +       u8 dpcd_ext = 0;
> +       unsigned int dpcd_offset = 0;
>         struct drm_dp_mst_branch *mstb = NULL;
>
>         mutex_lock(&mgr->payload_lock);
> @@ -3510,9 +3512,15 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
>                 struct drm_dp_payload reset_pay;
>
>                 WARN_ON(mgr->mst_primary);
> +               drm_dp_dpcd_read(mgr->aux,
> +                                DP_TRAINING_AUX_RD_INTERVAL,
> +                                &dpcd_ext, sizeof(dpcd_ext));
> +
> +               dpcd_offset =
> +                       ((dpcd_ext & DP_EXTENDED_RECEIVER_CAP_FIELD_PRESENT) ?  DP_DP13_DPCD_REV : DP_DPCD_REV);
>
>                 /* get dpcd info */
> -               ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd, DP_RECEIVER_CAP_SIZE);
> +               ret = drm_dp_dpcd_read(mgr->aux, dpcd_offset, mgr->dpcd, DP_RECEIVER_CAP_SIZE);
>                 if (ret != DP_RECEIVER_CAP_SIZE) {
>                         DRM_DEBUG_KMS("failed to read DPCD\n");
>                         goto out_unlock;
> --
> 2.25.1
>
Add Lyude Paul
