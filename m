Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAADC761A0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688822072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="d7j3oGOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgBQJ1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:27:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47059 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgBQJ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:27:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so18708509wrl.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 01:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QvErWIb5S/uA6PFWOeMDnc2AE5YEYZNhLlZmfOWNVCk=;
        b=d7j3oGOWhVJU1EeHCkuhfd5rV6btv2OpWWlWXsT1vDJfBvN4GyLzhjc4d3PnB6X85v
         q90kZdGApPBVFOsTRC9hhGh7zTY582Ke7R+uwKWLMFXPJL9FUmFie67e/1tXPMYUXUo0
         /gxnXxXqG4i5Ma75+snordE2m4kIFFW+eb13Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=QvErWIb5S/uA6PFWOeMDnc2AE5YEYZNhLlZmfOWNVCk=;
        b=AAUr74c6rRngZsyuw8PUX55IwIkHgS/NsCXJiDI1My1Va+IInJPjzUlbrGnXfO62tv
         KBoNB4s7AgFrPjuWTXgWikH0cnyvqbEWao+ZPWpr+7ucPeftZAft5weVSErMBCMTKIKR
         km8gKM9CtIwKQ6baJcNz64POvXuQlkCdrSQ03HKkmtGJA50m8jAUnkzQY+A8u5MP2x4e
         bfZEZ9gjTUIZTC3++zHgXgPc9oI2SkMM9g3iIdTjKIC6An18xF9qBDVH/9j4SEelPQOK
         W+xkSUupYqVEop7Td9+dkb9vwRWWbwGNNaI/g7A9YgSJIpnEAN/08aYQ/LieaCnGd60s
         Ytzw==
X-Gm-Message-State: APjAAAXtStXhkquJknXZPuZOgguPVNnXBT62GnBgZ2Z8FKzwEMUSzNU2
        AuQW0x8oMu7z1g9QZ979gPCksQ==
X-Google-Smtp-Source: APXvYqyEofBTojDI8GHGTPMb6Dq3HZCbMdNUJ6xlC4vWUe1Co3YZ5fHSHg2v5biis04RgN+hS3xOvg==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr20370782wru.382.1581931628031;
        Mon, 17 Feb 2020 01:27:08 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x11sm19658953wmg.46.2020.02.17.01.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:27:07 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:27:05 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Emmanuel Vadot <manu@FreeBSD.org>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@intel.com,
        efremov@linux.com, tzimmermann@suse.de, noralf@tronnes.org,
        sam@ravnborg.org, chris@chris-wilson.co.uk, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/format_helper: Dual licence the file in GPL 2
 and MIT
Message-ID: <20200217092705.GE2363188@phenom.ffwll.local>
Mail-Followup-To: Emmanuel Vadot <manu@FreeBSD.org>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, jani.nikula@intel.com, efremov@linux.com,
        tzimmermann@suse.de, noralf@tronnes.org, sam@ravnborg.org,
        chris@chris-wilson.co.uk, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200215180911.18299-1-manu@FreeBSD.org>
 <20200215180911.18299-3-manu@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200215180911.18299-3-manu@FreeBSD.org>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2020 at 07:09:11PM +0100, Emmanuel Vadot wrote:
> From: Emmanuel Vadot <manu@FreeBSD.Org>
> 
> Contributors for this file are :
> Gerd Hoffmann <kraxel@redhat.com>
> Maxime Ripard <mripard@kernel.org>
> Noralf Trønnes <noralf@tronnes.org>
> 
> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>

Patch applied since we have all the acks we need. I think for the first
one we still need a few more.
-Daniel

> ---
>  drivers/gpu/drm/drm_format_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index 0897cb9aeaff..3b818f2b2392 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0 or MIT
>  /*
>   * Copyright (C) 2016 Noralf Trønnes
>   *
> -- 
> 2.25.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
