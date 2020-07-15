Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B24C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C2E20658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GkljGvwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbgGOMDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgGOMDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:03:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2246FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 05:03:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a6so3330153wmm.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 05:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=1FfPLCjiOZfVPMY6SEoLGJR3cEuEk/qp9UiuwmY8/Zw=;
        b=GkljGvwOCvf76Prs/T1i+Yd+t6gjS1q2k0DDuf8Nw3P2TZeBhiKCa2W28KEezNnfjJ
         ta7zQwmbNPFnYUnKRwCJ7wpo3PXTVaijagpMhPGkaj4Hv8iNYMv6KrMkXMkR81pk/ep0
         nCKtHZuztA/GRllSpUW06if8oWgRaGxpuVN3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=1FfPLCjiOZfVPMY6SEoLGJR3cEuEk/qp9UiuwmY8/Zw=;
        b=jjb8YOqtxvooMsUu60mAJ/wKJm7z52nZGqgMnRkTXtF9fgthd8bMh6lSzOUm4vHf29
         KwObWx29kyv9L78o+wnzSV6dkCO/PgRShptAY5LfVFzPBS0yPz0C6B8okX8Z/9zyOece
         4SZmyn1VxIPpqiytU+dJg7AWPMf9KDHL4hltkHLmTPUWmoTrtbDIxrFWmifenCjqezSD
         N3SI3RFzVKeSWPkacACQImt5QE+Fs1IGSuvT0Xf0+ZZ4RTCVBMSkwPdJqeT1DrL+IezJ
         70rEXUQH9xo9a6higgIgnYEt6EIaRJ5cQpm25GKKHhOY/qKkJZ5/ThsmWu6WZo94VGd2
         REeA==
X-Gm-Message-State: AOAM532tcsxVzV+ovBsihyeGi7ANeLsIwPC0lYGd5EL06HjkqqLlXIU1
        p1huQquHn/9QiHjmlpaoi+d/a4lAthE=
X-Google-Smtp-Source: ABdhPJybPrQq/NJXSsfzu2zrR2PYj1djREC+vWdXXMxKQd32mcieYtJ911F5wuoWXIjo/InQSCTdEQ==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr8205466wma.18.1594814621638;
        Wed, 15 Jul 2020 05:03:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w128sm3557542wmb.19.2020.07.15.05.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 05:03:41 -0700 (PDT)
Date:   Wed, 15 Jul 2020 14:03:39 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/7] drm: drm_atomic.h: delete duplicated word in comment
Message-ID: <20200715120339.GI3278063@phenom.ffwll.local>
Mail-Followup-To: Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20200715052349.23319-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715052349.23319-1-rdunlap@infradead.org>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:23:43PM -0700, Randy Dunlap wrote:
> Drop doubled word "than" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org

Entire series pushed to drm-misc-next, thanks for your patches. Should
still make it to 5.9.

Cheers, Daniel

> ---
>  include/drm/drm_atomic.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200714.orig/include/drm/drm_atomic.h
> +++ linux-next-20200714/include/drm/drm_atomic.h
> @@ -103,7 +103,7 @@ struct drm_crtc_commit {
>  	 *
>  	 * Will be signalled when all hw register changes for this commit have
>  	 * been written out. Especially when disabling a pipe this can be much
> -	 * later than than @flip_done, since that can signal already when the
> +	 * later than @flip_done, since that can signal already when the
>  	 * screen goes black, whereas to fully shut down a pipe more register
>  	 * I/O is required.
>  	 *

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
