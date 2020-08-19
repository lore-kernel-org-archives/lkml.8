Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04B9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CB7207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XdSoOU8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHSWHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHSWHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:07:49 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92797C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 15:07:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so6814pfw.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 15:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kf0ZzHRJMAbFMLLUKsjOglGhImKY7cyfAyt1lKaRTFE=;
        b=XdSoOU8bhGfMFDMNkNB0PbGSyC9b/j1tzuVKEsB9zu7tjC2Vu7SEGSFi1W1cIQakbE
         o9qXTs96ee/VmG7efkxn8wb4vmhSq0ewikBueR4YGGz4OVA6fjbIeZISd2TXUVABiNcj
         2cRCBsILsz+/mHHhsf+pfXMZJsKWFTExc0Fuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kf0ZzHRJMAbFMLLUKsjOglGhImKY7cyfAyt1lKaRTFE=;
        b=I8sE9LMfTYBQTrmcuB4CXrz8VVuv1OYkR7G1cA4/Y4UQdMLckduJOVph30LeR+q8Df
         7USHeQBA6haNnyOMJ6taiQ9PNCtoUq21QPwtx7UDx50FP85EhVBy5jVCywXgf4uBVHz8
         B2c3sSgnH9KM/RYUaZcED8E/yF4RodAWrmRQvAUCIkm54cNTqpPGUPxgQGzzy3jenec2
         bawl9/uOM8heem89/iojdIIFAFddT/3DkdCT8avbtlRcMpNdQ87s56trKwm+Xmm0YV6J
         dujFSF5oJT2c1rFCCKjsTvw0zAjWwanebcZnU57O5rUZ6sOhn9pctI7Pc92Z/KLEcMkc
         Jmmw==
X-Gm-Message-State: AOAM532ZeNX+2VPRtobdI4SfapVGo1cD/SQvAjs+mSmLWH/MrueAAW2Y
        Dg9hdcnd8aubUqXWw3rVSFRFuw==
X-Google-Smtp-Source: ABdhPJxLBSOW/rpsj19Cs2xhJm2vDqZ4jNnT0/9og9Y8mFmIcYvE0rLxvkfRoBix9hXJmZPD7SaZlw==
X-Received: by 2002:a62:6d04:: with SMTP id i4mr10910877pfc.188.1597874869067;
        Wed, 19 Aug 2020 15:07:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q25sm182088pfn.181.2020.08.19.15.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 15:07:48 -0700 (PDT)
Date:   Wed, 19 Aug 2020 15:07:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+017265e8553724e514e8@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3] vt: Reject zero-sized screen buffer size.
Message-ID: <202008191452.0278B57D43@keescook>
References: <189fc902-db7c-9886-cc31-c0348435303a@i-love.sakura.ne.jp>
 <20200712111013.11881-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712111013.11881-1-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 08:10:12PM +0900, Tetsuo Handa wrote:
> [...]
> @@ -1125,6 +1134,11 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
>  	if (!*vc->vc_uni_pagedir_loc)
>  		con_set_default_unimap(vc);
>  
> +	err = -EINVAL;
> +	if (vc->vc_cols > VC_MAXCOL || vc->vc_rows > VC_MAXROW ||
> +	    vc->vc_screenbuf_size > KMALLOC_MAX_SIZE || !vc->vc_screenbuf_size)
> +		goto err_free;
> +	err = -ENOMEM;
>  	vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_KERNEL);
>  	if (!vc->vc_screenbuf)
>  		goto err_free;

I realize this patch already landed, but I wanted to remind folks to
use the check_*_overflow() helpers, which can make a lot of this kind
of stuff easier to deal with.

For example, in this case, I think visual_init() could likely be changed
to return success/failure and do all the sanity checking:

	if (check_shl_overflow(vc->vc_cols, 1, &vc->vc_size_row) ||
	    check_mul_overflow(vc->vc_rows, vc->vc_size_row, &vc->vc_screenbuf_size))
		return -EINVAL;


-- 
Kees Cook
