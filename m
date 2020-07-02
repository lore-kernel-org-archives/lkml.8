Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790DCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B49207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UBVcKDgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgGBNOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbgGBNN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:13:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05391C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 06:13:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so20224618wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=zILgKaetTBwolch6rF03SRdkX/5q6atkzkbETazvBAE=;
        b=UBVcKDgtdhC6vC/FuLh+o8LKBbatbmZ82QTPSPB4E2XeAGBQYES5PswiSDVsB1y35/
         YTn38PmXCqwZ0qnV/PV4WaldiK66HTXlVCYGArJv6UF2ZJNDOosueBQKbkTnPbw7TOdj
         Rz4iWXQLrMyp/jnasqHu//tr3/nYCwDgNE0f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=zILgKaetTBwolch6rF03SRdkX/5q6atkzkbETazvBAE=;
        b=VqBjyX6ps5fkiaUX4GAUGlstEB65ADOzFI/+N1hmVL/V92alb5Q+wr97ou9IZGR5Am
         Dhnb7TcGCwIEtkaRzrSuo22n5Yx+vtmgFl/cg68hc+LunuxMJ4PHpVip+CfH32q/AMvj
         po5Gqqu6xf+se0yisml1p/84MRaxOyJdRXvblZA8lwuBmcKYTraQ4ZcUWvF/hq+fIuv9
         AAHrKgT5xzCSuZOe1otiOtSQXdLSXFo/eBsLRMxezpVbGr3xzAXYAiAIy9ny+SMSMV1M
         8Mx1gfSlY+cn+TsidcLv8MP32OBdZovcOkmfdQuiziOJe8lT5J3wW+Mv0Co8OiTcphOp
         Xk+g==
X-Gm-Message-State: AOAM53273Fk9tnk+/cQLs9MCK8oAS5+RoZduHzyy7YhE/KwUoKsbkgGs
        4d2w8yAHlpLmRwpHxvS49E8dow==
X-Google-Smtp-Source: ABdhPJzw5CpFHu7RNQ5l+6PpSRit16K2KOdpRIIkkIx1cqWsAls2OKTWgQ6li418LbgC3qx1vw+Ehw==
X-Received: by 2002:a5d:628b:: with SMTP id k11mr31781751wru.107.1593695637756;
        Thu, 02 Jul 2020 06:13:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c15sm348250wme.23.2020.07.02.06.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 06:13:57 -0700 (PDT)
Date:   Thu, 2 Jul 2020 15:13:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: add wait_for_vblanks in atomic_commit_tail
Message-ID: <20200702131355.GX3278063@phenom.ffwll.local>
Mail-Followup-To: Sidong Yang <realwakka@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200701153134.4187-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701153134.4187-1-realwakka@gmail.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 03:31:34PM +0000, Sidong Yang wrote:
> there is an error when igt test is run continuously. vkms_atomic_commit_tail()
> need to call drm_atomic_helper_wait_for_vblanks() for give up ownership of
> vblank events. without this code, next atomic commit will not enable vblank
> and raise timeout error.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 1e8b2169d834..10b9be67a068 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -93,6 +93,8 @@ static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
>  		flush_work(&vkms_state->composer_work);
>  	}
>  
> +	drm_atomic_helper_wait_for_vblanks(dev, old_state);

Uh, we have a wait_for_flip_done right above, which should be doing
exactly the same, but more precisely: Instead of just waiting for any
vblank to happen, we wait for exactly the vblank corresponding to this
atomic commit. So no races possible. If this is papering over some issue,
then I think more debugging is needed.

What exactly is going wrong here for you?
-Daniel

> +
>  	drm_atomic_helper_cleanup_planes(dev, old_state);
>  }
>  
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
