Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD9CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5E02072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eMQ4Qfh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgCFKub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:50:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39476 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgCFKua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:50:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so1785646wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 02:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lqj1r2+XesR/fgg0h5Zp8P3qsanXcYJ2Wo6lT5aKNU0=;
        b=eMQ4Qfh/shQdBEarZjsy80ZBoZmiDtadXBdBl2WipOlamwZgkExgTdE7XR4O9qD/H3
         SSa1bPhGT8t8YoMCzhpWDT7dxRUbDCb+nqp5Zpbq2SFDJvyenna6flQXGL2C0l7yR/40
         tZ1mAVIw2A4G1eFea4oYh6iQTBJmwIDieLvqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lqj1r2+XesR/fgg0h5Zp8P3qsanXcYJ2Wo6lT5aKNU0=;
        b=QH23BBI/mv/shhmp3sV8k4e0KeuObnwHQZFndi5/3TDo0Ev3i1FV+jcYSY+7gVo9DG
         HAH7YkFOxr9RSOjBQ/aejBK2kIuJ4fgHI/clg0Wa+RT8k/JUx1AmRThxvUObU4d+yTzb
         TsZjFocgZ0p0gyCRQR/7724daZmVkg+9Fw17rELcOD8kujhLQA63ICug892st5uwATjB
         cCv76QTVKFN5f1Wq1UPHXO7vzGI/AXA19MaOEq+csVuQOjKm7MoWJ2Px6tvxcI99jxYS
         5vexkANRVZC3k7ojhOny74c+xyB50YcEwiVA9euM7Dmkj0onEi8kNYkQDTOrxh23pGGO
         MsCQ==
X-Gm-Message-State: ANhLgQ3VFNZEJYx74Sw9VarumMEtPL2kc4TYJnuFmDx1RuCn32HA9ahu
        YpQEVK/lsqVzpk5fqp4/ox65OQ==
X-Google-Smtp-Source: ADFU+vvK8LQqjtAJ72mqtWovLbVlUtPxZCNRoHgeIjCmFWcoNHTF1RZkXRQ0Tv6bXfunwYZfaciwfQ==
X-Received: by 2002:adf:df82:: with SMTP id z2mr3361131wrl.46.1583491828337;
        Fri, 06 Mar 2020 02:50:28 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w16sm14656890wrp.8.2020.03.06.02.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 02:50:27 -0800 (PST)
Date:   Fri, 6 Mar 2020 11:50:25 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/vc4/vc4_drv.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200306105025.GW2363188@phenom.ffwll.local>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200305105707.GA19261@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305105707.GA19261@embeddedor>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 04:57:07AM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Applied to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/vc4/vc4_drv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index f90c0d08e740..5ecb8b4a48a1 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -65,7 +65,7 @@ struct vc4_perfmon {
>  	 * Note that counter values can't be reset, but you can fake a reset by
>  	 * destroying the perfmon and creating a new one.
>  	 */
> -	u64 counters[0];
> +	u64 counters[];
>  };
>  
>  struct vc4_dev {
> -- 
> 2.25.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
