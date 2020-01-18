Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE339C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 00:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8564022464
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 00:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9Y7Jt9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgARATH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 19:19:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23073 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730260AbgARATH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 19:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579306746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nkMRlosfOBwcGR259WMKcKORYoc0cAsdlRRPRABPESI=;
        b=K9Y7Jt9vuCs+F6Ok/bmD/N/bO//L5wDJc9m90LngXyRxXe+BEH7VYiOCootC1uqxD3USYy
        DylD9zdPv1y8NtfVj0CI43vBUCDPWWFv5+6XEigaoeb4Ofq2bJkyVu6SpaGmZBPqFW1VF1
        REX5Zjf3uWc2x2sOqyd8rOEcbPI72TQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-UMyKouTgNsWTrvzQyS1uHA-1; Fri, 17 Jan 2020 19:19:02 -0500
X-MC-Unique: UMyKouTgNsWTrvzQyS1uHA-1
Received: by mail-qt1-f198.google.com with SMTP id m8so17025821qta.20
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 16:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=nkMRlosfOBwcGR259WMKcKORYoc0cAsdlRRPRABPESI=;
        b=dNDY0PzEAq6RX4QsBMom0ilq8JWmf1ZapwLKugkIiP0rzEE/GnBioZj/lhtQWkV4OG
         30RrIsT9EE6xlGzZfdGZE2P9YfCaglr2/mzjAwEsFjsGagNELArd1qkbhx2jilOTBUJy
         xnRQsK0GAnP8wWUnsdTRMZvP4LqavC2L8u7+y6le0leUvvcrzBb/XPP8ZDQlqCUGSKKZ
         i9jeZtsoU1ZckVsYpyxLG5jPrMzR6wm6JzBGs2Bxmuz0o0RQgpfxghRq7tNSWUPw5BrF
         8fX07FWXL/Lt2p+TbaKNiCWQE4XuvNTtNATo31JUC5Pe1nfTlZAHYhg1/Z9E0x8L/axL
         x7Jw==
X-Gm-Message-State: APjAAAUbtBP1aWOWP/bRYVEpEJhqxM0QX/AklTU+n3oQnU2M62gE9AU9
        uKebA6d3a11ysYvszSeehhqsWJ4yin+QKwq23QYfUljoO1BjokMe04TVN/Fo/NQzqqCcalCyq+k
        PgD4cbRbxNl+GeJoPh3RlrGrV
X-Received: by 2002:a0c:e58e:: with SMTP id t14mr10162444qvm.131.1579306742079;
        Fri, 17 Jan 2020 16:19:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxNTy3Zp7IZPvd77D4uDVi5088sphWrG/dsjizjp3pS33LcWWWKx4ZUjCa0TdoqrXJ1spKRQQ==
X-Received: by 2002:a0c:e58e:: with SMTP id t14mr10162421qvm.131.1579306741879;
        Fri, 17 Jan 2020 16:19:01 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id r28sm14155261qtr.3.2020.01.17.16.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 16:19:01 -0800 (PST)
Message-ID: <c99174eefb65688c3db3fc25ddec819a58dccc6a.camel@redhat.com>
Subject: Re: [PATCH -next] drm/nouveau/kms/nv50: remove set but not unused
 variable 'nv_connector'
From:   Lyude Paul <lyude@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>, bskeggs@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch, alexander.deucher@amd.com,
        sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Jan 2020 19:19:00 -0500
In-Reply-To: <20200117033642.50656-1-yuehaibing@huawei.com>
References: <20200117033642.50656-1-yuehaibing@huawei.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Fri, 2020-01-17 at 11:36 +0800, YueHaibing wrote:
> drivers/gpu/drm/nouveau/dispnv50/disp.c: In function nv50_pior_enable:
> drivers/gpu/drm/nouveau/dispnv50/disp.c:1672:28: warning:
>  variable nv_connector set but not used [-Wunused-but-set-variable]
> 
> commit ac2d9275f371 ("drm/nouveau/kms/nv50-: Store the
> bpc we're using in nv50_head_atom") left behind this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 5fabe2b..a82b354 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1669,7 +1669,6 @@ nv50_pior_enable(struct drm_encoder *encoder)
>  {
>  	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
>  	struct nouveau_crtc *nv_crtc = nouveau_crtc(encoder->crtc);
> -	struct nouveau_connector *nv_connector;
>  	struct nv50_head_atom *asyh = nv50_head_atom(nv_crtc->base.state);
>  	struct nv50_core *core = nv50_disp(encoder->dev)->core;
>  	u8 owner = 1 << nv_crtc->index;
> @@ -1677,7 +1676,6 @@ nv50_pior_enable(struct drm_encoder *encoder)
>  
>  	nv50_outp_acquire(nv_encoder);
>  
> -	nv_connector = nouveau_encoder_connector_get(nv_encoder);
>  	switch (asyh->or.bpc) {
>  	case 10: asyh->or.depth = 0x6; break;
>  	case  8: asyh->or.depth = 0x5; break;
-- 
Cheers,
	Lyude Paul

