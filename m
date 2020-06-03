Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E89BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287E220659
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBHFwUnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFCQ0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 12:26:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60695 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725939AbgFCQ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 12:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591201578;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dMqwWWzHo3fy38RH5JowEjmFezZIYfiA+LiXUUe2ODM=;
        b=WBHFwUnX/MT5/kGV/nWfAxLAHG9R/RFl0DmA9gfCzAWf7jyCbxD0vfHF1d6zgLaHktFEe+
        ktzDWAYkJ6zO8BD52HG5bwohdvdR1zHVbv00k+jmDTOTBC1zTP2igCWtHs9RW0PQ/t0bxe
        aKJRlbtZunQpTduS3qLwUMK3zdXmY2w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-qba1G82IOyGmdzqRxgbgTA-1; Wed, 03 Jun 2020 12:26:16 -0400
X-MC-Unique: qba1G82IOyGmdzqRxgbgTA-1
Received: by mail-qt1-f198.google.com with SMTP id c22so1008270qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 09:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=dMqwWWzHo3fy38RH5JowEjmFezZIYfiA+LiXUUe2ODM=;
        b=WFACpjQRbEeK7lEBqtaj04YIZWfc+FiEG3J4wGZb+fJYiRUp9zQmtTZ6HN9AUnfDoI
         qMB8wyzlK7VKV/rZqy7+rzTSuCYqXzBd9xP3exq4U/dXlLvF8+IZqTTwi+fgCNhL+fuc
         7riaGuzsprGJknc+N3uXK6xLL0A9G82jAzpoBTvI9Iu+IkhTd8JZEIP/K2ITSj/58snm
         f6yacaiSZ8K3HpsjroY5r/KjD78NUq6OYtEwgdBN27/yt8QEJsa1wy/3idN/Nbnr8w76
         WGpARncmukY3ZAKbgDFmqvta0h1U0jaZUI1rTq2w99PhTqP8YX22ZZSv3Q6s/eCcW/6L
         E1Zw==
X-Gm-Message-State: AOAM531QAZrLXr/dUUjrACp65LhHZQU0vykMkeaWQ4WXAiyY5vHVVfJB
        l980x5kgeKHNFT9ZZBvE4HJp/BQUCp4Lkg8X2Cm1rKzV3EENX3a5ShJuBRadqYWGG2gnjk6iOuf
        hzcLfFcSrc99dPQuBZ5NescHh
X-Received: by 2002:a37:8302:: with SMTP id f2mr459417qkd.220.1591201576080;
        Wed, 03 Jun 2020 09:26:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKqhMLHPZcgjFr9XB7c/kNuGHGvZZ0lp+ttkkbotvsK/G4TlijsRIMnW9BziRubgOsnvwXrQ==
X-Received: by 2002:a37:8302:: with SMTP id f2mr459396qkd.220.1591201575825;
        Wed, 03 Jun 2020 09:26:15 -0700 (PDT)
Received: from Whitewolf.lyude.net (static-173-76-190-23.bstnma.ftas.verizon.net. [173.76.190.23])
        by smtp.gmail.com with ESMTPSA id a38sm2632175qtb.37.2020.06.03.09.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 09:26:15 -0700 (PDT)
Message-ID: <4c6a9fba546fc9a8c63d9669cfd4876efc903786.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/dispnv50: fix runtime pm imbalance on error
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Takashi Iwai <tiwai@suse.de>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 03 Jun 2020 12:26:14 -0400
In-Reply-To: <20200520104750.21335-1-dinghao.liu@zju.edu.cn>
References: <20200520104750.21335-1-dinghao.liu@zju.edu.cn>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! Was going through my email and found this from last month, it's a bit late
and someone might have reviewed/pushed this already but just in case:

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2020-05-20 at 18:47 +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> the call returns an error code. Thus a pairing decrement is needed
> on the error handling path to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 6be9df1820c5..e670756664ff 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1123,8 +1123,10 @@ nv50_mstc_detect(struct drm_connector *connector,
>  		return connector_status_disconnected;
>  
>  	ret = pm_runtime_get_sync(connector->dev->dev);
> -	if (ret < 0 && ret != -EACCES)
> +	if (ret < 0 && ret != -EACCES) {
> +		pm_runtime_put_autosuspend(connector->dev->dev);
>  		return connector_status_disconnected;
> +	}
>  
>  	ret = drm_dp_mst_detect_port(connector, ctx, mstc->port->mgr,
>  				     mstc->port);

