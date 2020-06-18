Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E24DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48402206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+OrRKM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbgFRPSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:18:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54915 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728050AbgFRPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592493510;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQYmuQ6MgsURSBqJgRafWuUZH2kgHeoFm2q5Vrdf7kM=;
        b=V+OrRKM0fAX5wBvC9GSolRA0oS8Frr8GVadEOw5//oMSmyX/dx/BlVfJbLbORrfHzNTqvT
        nh0N6Cm1TAmWjZYYgPu8oTsBQPESbKewPyEmxrMKYRWhkN9PuGrkxHNmJ4NJVaZ2/INSrb
        DJR/WkDG9aF9zlatEUZJEkBSHbjucvY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-6KnL345JNjiVuvF7UE5Nbg-1; Thu, 18 Jun 2020 11:18:28 -0400
X-MC-Unique: 6KnL345JNjiVuvF7UE5Nbg-1
Received: by mail-qt1-f200.google.com with SMTP id x21so4606366qtp.16
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=rQYmuQ6MgsURSBqJgRafWuUZH2kgHeoFm2q5Vrdf7kM=;
        b=hKXrx14LKPUjfP8454dvPMofAKZBlQL6erqAbFC6XirtnBFLrlYZjyJoUxYlucsrkb
         WtVDWnY4ctBkzILBcqI0jwGlXRuqwhfR2gIC0zFMzEiJL89CbxzgFyg6sQOmzkynUMUR
         NnFlbxBwmvVRWVEclb3Fjtts4t4ZIof4/ZhDvTzSbVEav5I+6CMXmHL7rLEuIswF3KMY
         /GZlna6J+zqf1B5zqXJhOipACkPH/LG+3jKn0CRo641Fvqxu2sU4IAL1HEBgPXY1CsIg
         vimXxvxg4olhzm6VTWdb7i68ome0jc01/DcPqS2xQZYSJAoNBNNsmkLYroiq/1VHp4FC
         XKIQ==
X-Gm-Message-State: AOAM532jTUXXOaHb8HUoqGohOFRt8GIfTs/6DxXQhwQCafBdGLcA84Y9
        PGavZGfuKaxCQl4HNeXnAR4sdwohHzdYKFrHm2Z7ha5kJ1M39NWx/qUY3DKaYLlbP/RUaAoJXKp
        K5bLgyfjNyIfa38Hb3UQUX5yV
X-Received: by 2002:ac8:23fb:: with SMTP id r56mr4946253qtr.197.1592493508007;
        Thu, 18 Jun 2020 08:18:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLgX4Z87MobK3H78vsTvXLd+/eu1CkxpTofEBBUyoXsAsemLOYYh7GV5x0KAA4BnDYUAMf5w==
X-Received: by 2002:ac8:23fb:: with SMTP id r56mr4946222qtr.197.1592493507790;
        Thu, 18 Jun 2020 08:18:27 -0700 (PDT)
Received: from Whitewolf.lyude.net (static-173-76-190-23.bstnma.ftas.verizon.net. [173.76.190.23])
        by smtp.gmail.com with ESMTPSA id c2sm3131786qkl.58.2020.06.18.08.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 08:18:26 -0700 (PDT)
Message-ID: <0b1c1a07b6589e91701a1815400a56b66c5f480d.camel@redhat.com>
Subject: Re: [PATCH] drm/noveau: fix reference count leak in
 nv50_disp_atomic_commit
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, wu000273@umn.edu, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Takashi Iwai <tiwai@suse.de>, James Jones <jajones@nvidia.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 18 Jun 2020 11:18:25 -0400
In-Reply-To: <20200614012920.121567-1-pakki001@umn.edu>
References: <20200614012920.121567-1-pakki001@umn.edu>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-06-13 at 20:29 -0500, Aditya Pakki wrote:
> nv50_disp_atomic_commit() calls calls pm_runtime_get_sync and in turn
> increments the reference count. In case of failure, decrement the
> ref count before returning the error.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index d472942102f5..b4039907f0d6 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -2157,8 +2157,10 @@ nv50_disp_atomic_commit(struct drm_device *dev,
>  	int ret, i;
>  
>  	ret = pm_runtime_get_sync(dev->dev);
> -	if (ret < 0 && ret != -EACCES)
> +	if (ret < 0 && ret != -EACCES) {
> +		pm_runtime_put_autosuspend(dev->dev);

s/noveau/nouveau/ in the commit title, but other than that:

Reviewed-by: Lyude Paul <lyude@redhat.com>

>  		return ret;
> +	}
>  
>  	ret = drm_atomic_helper_setup_commit(state, nonblock);
>  	if (ret)

