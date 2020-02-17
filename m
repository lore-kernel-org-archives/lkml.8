Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABFDC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37C320726
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="E9P//0DI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgBQJ16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:27:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37529 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbgBQJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:27:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id a6so17595043wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 01:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=W3cuPNWL6G9Mkzazr5aYw69mCYySh4JxTzpizFSnP50=;
        b=E9P//0DIVwrempoYlQvPpQ3JLBfVeQX+Igm9H93gtrvhaRYwHmsK2QZLopBDq5HpE+
         /s8riZMDYh/UK5hZKHwcrYWmawp1zyUPGR7QkVeB7Lfj18xoNoLqFRUNObijflqvu8dK
         4DmxlwRS+PTg5okQaXwvwaXC50DXpUnlx6syc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=W3cuPNWL6G9Mkzazr5aYw69mCYySh4JxTzpizFSnP50=;
        b=LfWlRCf0H/xaKIcbVVbb77EvseRcIdYUqANCefHyNaNrqNIEHCpFcoYJxAtEhD9bVB
         hq+Pf5Lyel6lcRWCSG5QIIAYuQrHd9iHn7rBrbTGNA/Wi0ykngCXaGhUBgl/rfdgvE4s
         GK+H87T2tnBHRrbLOLsB7Mo1tJpwknikByuRRVRiQo0B4QpypgZwjFpAkKwFU6gFpiWt
         Co/4Wpdsa7hSdF1aYe/9twZ4tihmIflLef1RQ9e5kGcCBdsTHC7fF9bPCj425FXM5zQQ
         KOH4yC0WAIvPVWQDUbDDtEkanPDln+aAaMC7wzzw3zmVd95Iqe8pTu1AP3LREKBPc1PV
         Sn4w==
X-Gm-Message-State: APjAAAXpJ3C6/LNpp1mzB6sD6t/3SlwLjUrR3SBNdVe4/ANzcRUeT7CU
        wYfOYSrfj4bN4qctWFso48H1qW0yNW4=
X-Google-Smtp-Source: APXvYqwubPOPLq30URt7q/mmbsEDobFNeewy4T855nPo/3eKy/wiWdgXW1I99+bIl4JyIDmgOWUVgA==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr19977570wmi.146.1581931674639;
        Mon, 17 Feb 2020 01:27:54 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v15sm114015wrf.7.2020.02.17.01.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:27:53 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:27:52 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     sumit.semwal@linaro.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] dma-buf: Fix a typo in Kconfig
Message-ID: <20200217092752.GF2363188@phenom.ffwll.local>
Mail-Followup-To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        sumit.semwal@linaro.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org
References: <20200216114708.20583-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216114708.20583-1-christophe.jaillet@wanadoo.fr>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 12:47:08PM +0100, Christophe JAILLET wrote:
> A 'h' ismissing in' syncronization'
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thanks for your patch.
-Daniel

> ---
>  drivers/dma-buf/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index 0613bb7770f5..e7d820ce0724 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -6,7 +6,7 @@ config SYNC_FILE
>  	default n
>  	select DMA_SHARED_BUFFER
>  	---help---
> -	  The Sync File Framework adds explicit syncronization via
> +	  The Sync File Framework adds explicit synchronization via
>  	  userspace. It enables send/receive 'struct dma_fence' objects to/from
>  	  userspace via Sync File fds for synchronization between drivers via
>  	  userspace components. It has been ported from Android.
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
