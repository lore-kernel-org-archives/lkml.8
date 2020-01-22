Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CCAC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260932253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="F9sZ0g+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAVITM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:19:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35075 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgAVITL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:19:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so6156541wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 00:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ahqJi39L7hCmLZPOpPTNeDXrK6DDNhPTKiMAbD2ywhE=;
        b=F9sZ0g+1suMsinawzZ2+380DXDooohvMYhrtAigpsje4enqGS/E3s0VpLBwSqO1j8b
         Amc4lUyYFP9yeCXzfVLT+K9Judmv/BsI0HVUB9Sy+j7iPmjkQzVS/mTdCnbkEqvXvLf1
         784XmubZcHuyL7KHcsx8O6+B5bh3MN77272sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=ahqJi39L7hCmLZPOpPTNeDXrK6DDNhPTKiMAbD2ywhE=;
        b=ROBT7xbzmFe4Ui6RB+cfNtSzkgkUN2S6RLFN3g5otGiWRlpnYsTXGXnaJ1iGBGs66h
         Kvy5SBNPXpIQuw37ygcOCSuZlUaRsFUXOo2udjVOvQ73PcHr2wbUy1cBj2g9idvcYCAd
         4AbGPiQWk2YYbDyz8Pht5C6I6FztVmWj1s1zjP1LQgFWGANE44toLWVzZNnVzTnTHFyC
         TQBTtpUPaJm6bHteY07tB1XbGVxP9kjOcWOQqUZtJghLwN6t3BIOO1qxeEHxU/R0VHSi
         JLl1i7XSBfcgutZRaOotRwz6sBr40KZdEMI4Ga/w6USd8Va9iOqzNH76lU3abjIZqNim
         7bmg==
X-Gm-Message-State: APjAAAWr1hG0LAqlLwBp7en2woEx1e5+XPsbb+wKYd4j3g67mbYi7fVJ
        0LmXtwdnPmwZklAePdG79OmL4KHZCyxEDw==
X-Google-Smtp-Source: APXvYqwN9OhE8aTeF0own3s/Ooyt3OHRegbX3r4sudjELKIGb7qKe67NW4lGo+Sw1GcVN7BxEniEJA==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr1670290wmg.92.1579681149325;
        Wed, 22 Jan 2020 00:19:09 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z11sm58565947wrt.82.2020.01.22.00.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 00:19:08 -0800 (PST)
Date:   Wed, 22 Jan 2020 09:19:06 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        irlied@linux.ie, daniel@ffwll.ch, airlied@redhat.com,
        tprevite@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/drm_dp_mst:remove set but not used variable
 'origlen'
Message-ID: <20200122081906.GO43062@phenom.ffwll.local>
Mail-Followup-To: Bo YU <tsu.yubo@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        irlied@linux.ie, airlied@redhat.com, tprevite@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200118080628.mxcx7bfwdas5m7un@kaowomen.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200118080628.mxcx7bfwdas5m7un@kaowomen.cn>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 04:06:28PM +0800, Bo YU wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/drm_dp_mst_topology.c:3693:16: warning: variable
> ‘origlen’ set but not used [-Wunused-but-set-variable]
>   int replylen, origlen, curreply;
> 
> It looks like never use variable origlen after assign value to it.
> 
> Fixes: ad7f8a1f9ced7 (drm/helper: add Displayport multi-stream helper (v0.6))
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>

Queued in drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 4b74193b89ce..4c76e673206b 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3690,7 +3690,7 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up)
>  {
>  	int len;
>  	u8 replyblock[32];
> -	int replylen, origlen, curreply;
> +	int replylen, curreply;
>  	int ret;
>  	struct drm_dp_sideband_msg_rx *msg;
>  	int basereg = up ? DP_SIDEBAND_MSG_UP_REQ_BASE : DP_SIDEBAND_MSG_DOWN_REP_BASE;
> @@ -3710,7 +3710,6 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up)
>  	}
>  	replylen = msg->curchunk_len + msg->curchunk_hdrlen;
>  
> -	origlen = replylen;
>  	replylen -= len;
>  	curreply = len;
>  	while (replylen > 0) {
> -- 
> 2.11.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
