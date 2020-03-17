Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2C6C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D7720724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="R6oowquv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgCQQtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:49:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55256 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQQtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:49:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id n8so14755wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mMiEl9L2S4tlLAiIN1V5kcZjzOStOhhL2zNGzs+Vouc=;
        b=R6oowquvlxrvUCOrWAkR8nSqdDRskytPZj1t+oqMPZIXIdEaqaxrZausO30q5v2cij
         Ta9XPGU0jQaKg5rNB49TK7FEHpqSy2S5b/6hMjglyIwqWn6CM31M2MK33qUQn6/uT7et
         S8yBm+Y4yH5ujfReYwesuo5IRj0cN9DkeDzDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=mMiEl9L2S4tlLAiIN1V5kcZjzOStOhhL2zNGzs+Vouc=;
        b=R4/Ggd+4SBqHtdMMQOj82GwguR7KQmJl7vjgNMI3SRU+Q4OkfEacIR2hZT3Y2BXSm+
         GeKhhKhddVhL5pgiLO3GzVI8NVxrQT/M/TzLGuW5mCoGTWju+0Zmadt4fe7VZ5uoebbc
         xQLgcotVAXpfKDS0Ze3arqqhSZ+BIlgwApzUBBgzlgUcQABaOYgJ1GwhO+v5v4FY2ZYa
         TxVWw5B+rOijh3/rI8se4xECTbcLYd7IG3pM35aFJfIQoWnAzs5raZNk0Ft/UVtZSMAl
         8MN4ULc1q/1XXQKznePSuQ+cSxPcm4KrQlbPW68CADAjyuMlLdau6elh0bvEPE8qZiyb
         ikYg==
X-Gm-Message-State: ANhLgQ3eRl/D0XdXi87HRCBcHf/jOND+1Fhkqof2FcUYGrjbfdJiKufw
        EFOHBvI2+PUC4Dpp0wAwyVRRRQ==
X-Google-Smtp-Source: ADFU+vt8dNlSMJCThKrf5v17M3aD/fp8xVTQ3Zc/gPBrkJ6TA++okOS+dztloBcqbCNdk++CpJkLog==
X-Received: by 2002:a1c:5684:: with SMTP id k126mr163852wmb.181.1584463784547;
        Tue, 17 Mar 2020 09:49:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n10sm5554069wro.14.2020.03.17.09.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 09:49:43 -0700 (PDT)
Date:   Tue, 17 Mar 2020 17:49:41 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, marmarek@invisiblethingslab.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] drm/bochs: downgrade pci_request_region failure from
 error to warning
Message-ID: <20200317164941.GP2363188@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, marmarek@invisiblethingslab.com,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200313084152.2734-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200313084152.2734-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 09:41:52AM +0100, Gerd Hoffmann wrote:
> Shutdown of firmware framebuffer has a bunch of problems.  Because
> of this the framebuffer region might still be reserved even after
> drm_fb_helper_remove_conflicting_pci_framebuffers() returned.

Is that still the fbdev lifetime fun where the cleanup might be delayed if
the char device node is still open?
-Daniel

> 
> Don't consider pci_request_region() failure for the framebuffer
> region as fatal error to workaround this issue.
> 
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs_hw.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index 952199cc0462..dce4672e3fc8 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -157,10 +157,8 @@ int bochs_hw_init(struct drm_device *dev)
>  		size = min(size, mem);
>  	}
>  
> -	if (pci_request_region(pdev, 0, "bochs-drm") != 0) {
> -		DRM_ERROR("Cannot request framebuffer\n");
> -		return -EBUSY;
> -	}
> +	if (pci_request_region(pdev, 0, "bochs-drm") != 0)
> +		DRM_WARN("Cannot request framebuffer, boot fb still active?\n");
>  
>  	bochs->fb_map = ioremap(addr, size);
>  	if (bochs->fb_map == NULL) {
> -- 
> 2.18.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
