Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431A6C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9C2206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZSEr8Mpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgEEIxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 04:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgEEIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:53:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788E7C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 01:53:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l18so1712340wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 01:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UIkHUMV4Yj2RIV6apr0KJ2z5YGB71epGaZH3k3V8bYQ=;
        b=ZSEr8Mpmoom7F7RXc/Y5zmw0c0i3MuyYkXQC/UzWUCCXl6UX+Ksr9BHwtuw9zJahLa
         /BTPRdD92tB4uRge+uhjWUwcQofkniwrzZkR984LusrWo09+HAwXgRGzHmSzXikpBMbt
         hvMqiyUq6gzVh7iKvZAjO6roQ8sN3ijx/akQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=UIkHUMV4Yj2RIV6apr0KJ2z5YGB71epGaZH3k3V8bYQ=;
        b=FNP3w6RQgLUXXHqGqBqHsQObXStInUnxh3VbtUzkfVxK65f7hr/LI7SdwBB+c7LQ9O
         ZPP5KAV54epp6mqqkzqlS9vVUgTVCfFF0UggrPkJSuWXXRp2NBYOY+/7yzyjGPIp765O
         SirWvRBBjIAzEbEf+LyZtd+SbzbJKQTw0s2z6pYWFokELs/N5/osoqAHgyYhGpYFdVsC
         unpl73cnHfhjlL+UDvNZTqrIbeVVH3IChxdVuOaunao3WUiBg3fwrBUwkMaVOxOC9svT
         kMq5y9E7iTamY5EAN439wO3KCsbt0NFMvDUqZzUmuXmO+YX4PW5emVJNO0vg084Rwz7w
         HDWg==
X-Gm-Message-State: AGi0PuY8sYF0OFMIwDEM0tcsfpvLYoi34uq65qo2cYKlr6rtWjzyeekF
        nzgZiYjwfseEe/EVLnAXXH/PRheNJWU=
X-Google-Smtp-Source: APiQypJ5zgqxnnWESW6G9BiTsXSFSG3XRX0PywO7qVilO6UtSHrC7c4wnsb3n7avewawjNE5ClYY+Q==
X-Received: by 2002:a5d:4d0b:: with SMTP id z11mr2715734wrt.81.1588668821301;
        Tue, 05 May 2020 01:53:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a24sm2623053wmb.24.2020.05.05.01.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 01:53:40 -0700 (PDT)
Date:   Tue, 5 May 2020 10:53:38 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Emmanuel Vadot <manu@FreeBSD.org>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        matthew.d.roper@intel.com, noralf@tronnes.org, kraxel@redhat.com,
        tglx@linutronix.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v2 1/2] drm/client: Dual licence the header in GPL-2 and
 MIT
Message-ID: <20200505085338.GP10381@phenom.ffwll.local>
Mail-Followup-To: Emmanuel Vadot <manu@FreeBSD.org>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, matthew.d.roper@intel.com,
        noralf@tronnes.org, kraxel@redhat.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200430153347.85323-1-manu@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430153347.85323-1-manu@FreeBSD.org>
X-Operating-System: Linux phenom 5.4.0-4-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 05:33:46PM +0200, Emmanuel Vadot wrote:
> Source file was dual licenced but the header was omitted, fix that.
> Contributors for this file are:
> Daniel Vetter <daniel.vetter@ffwll.ch>
> Matt Roper <matthew.d.roper@intel.com>
> Maxime Ripard <mripard@kernel.org>
> Noralf Trønnes <noralf@tronnes.org>
> Thomas Zimmermann <tzimmermann@suse.de>
> 
> Acked-by: Noralf Trønnes <noralf@tronnes.org>
> Acked-by: Matt Roper <matthew.d.roper@intel.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>

Looks like we have them all, applied.
-Daniel


> ---
>  include/drm/drm_client.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
> index 7402f852d3c4..eb259c2547af 100644
> --- a/include/drm/drm_client.h
> +++ b/include/drm/drm_client.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 or MIT */
>  
>  #ifndef _DRM_CLIENT_H_
>  #define _DRM_CLIENT_H_
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
