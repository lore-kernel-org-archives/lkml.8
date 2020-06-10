Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CC8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D18DE2063A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="juAtCCLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgFJPcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbgFJPcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:32:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EAFC03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:32:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x6so2743019wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=L/g86dBUZKjl5KTVUeFxtA/4wg+xhUm8BJGegAmb5Js=;
        b=juAtCCLziMVmylfyjAk8fr0gNLiH3XWI7z40EkMsjyFvbdVai3ORIxsV2BFJijThoJ
         1g7J023Qy8yQiVLtgS9ojBkn15n0fmjlb4w84EY98IztkprceRsEhhi3/gABkwjyLLAa
         XkrYRg0eOwmbNcES1JGPnazCavOWfb/35HXsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=L/g86dBUZKjl5KTVUeFxtA/4wg+xhUm8BJGegAmb5Js=;
        b=oiimhkusmaPTWw0hq/xfE0If/EJmorjEcVRXG7lSr9OU5PCHm+Q1aQWtFHtYmy8Kug
         RnhMU/BteHtT9jau3XdeClihLkzi3bJpWSyGBThfh+kGCnzA/4IgraIXpv9zZ5wfW3wd
         Y8DLY5kjWkrf4pVwPB6L8J/GtstFcBPtKLkSCcmqtRhOnlVoNyO1QdhbZn6vrSR8WEef
         KjAlXx2KmwTB4renh3Fsyqdc5tx6nCoA7sRrxas65TN9beuJGEvUY+XVlPpX9VFqmjOl
         nKrkrKjhagDWmNabC+z73MjvrM6cwa+TxcDs5HJEwycgsiXLWUII7DSZW9OkFkdC/a27
         QTeg==
X-Gm-Message-State: AOAM531+wxc/rUNnovmxveTZVi2DqIxKZwQ/DAe0ruRqc3xp0KRl+PXY
        1YQbjkEkL9DBuC0OkUhQGoLqc29TnCg=
X-Google-Smtp-Source: ABdhPJyDyoyk9tr3zTqwPfbRN2CNQ0mYPBBQU8gPh438yGWw6/DWZOjH0T/7JDpZdKCb0c9Mz+oYLw==
X-Received: by 2002:adf:8b0c:: with SMTP id n12mr4705954wra.340.1591803133698;
        Wed, 10 Jun 2020 08:32:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a1sm101094wmd.28.2020.06.10.08.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:32:12 -0700 (PDT)
Date:   Wed, 10 Jun 2020 17:32:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jiri Kosina <trivial@kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/17] drivers: gpu: drm: Fix trivial spelling
Message-ID: <20200610153210.GA20149@phenom.ffwll.local>
Mail-Followup-To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Jiri Kosina <trivial@kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
 <20200609124610.3445662-9-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609124610.3445662-9-kieran.bingham+renesas@ideasonboard.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 01:46:01PM +0100, Kieran Bingham wrote:
> The word 'descriptor' is misspelled throughout the tree.
> 
> Fix it up accordingly:
>     decriptors -> descriptors
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Queued for 5.9, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_dp_helper.c | 2 +-
>  include/drm/drm_dp_helper.h     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 19c99dddcb99..8f1b329df16d 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -1365,7 +1365,7 @@ EXPORT_SYMBOL(drm_dp_get_edid_quirks);
>  /**
>   * drm_dp_read_desc - read sink/branch descriptor from DPCD
>   * @aux: DisplayPort AUX channel
> - * @desc: Device decriptor to fill from DPCD
> + * @desc: Device descriptor to fill from DPCD
>   * @is_branch: true for branch devices, false for sink devices
>   *
>   * Read DPCD 0x400 (sink) or 0x500 (branch) into @desc. Also debug log the
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index 2035ac44afde..1165ec105638 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -1701,7 +1701,7 @@ enum drm_dp_quirk {
>  
>  /**
>   * drm_dp_has_quirk() - does the DP device have a specific quirk
> - * @desc: Device decriptor filled by drm_dp_read_desc()
> + * @desc: Device descriptor filled by drm_dp_read_desc()
>   * @edid_quirks: Optional quirk bitmask filled by drm_dp_get_edid_quirks()
>   * @quirk: Quirk to query for
>   *
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
