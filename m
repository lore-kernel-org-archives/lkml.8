Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A93C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36995207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S4cxq+/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHSTtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSTto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:49:44 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75219C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:49:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so915272plr.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=biruROHiIJoBrFPsYBUZoikKtJ2eCnO2qeHRGaltBcU=;
        b=S4cxq+/23btjfJqTOIoctnTTrzafOwK+AK0UgBnnQJ8dzI+MER6IOpcF80ATe8N2VM
         3GTBoqW6wrKt4PxIk6buBrFMN77DpQMMTMzZs5pTNOUYPq4oF3RR+l+eK/oWciHJ2CbD
         tiCZSm8XQDLGtiHVzWXbaUgOid2o99jKItqIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=biruROHiIJoBrFPsYBUZoikKtJ2eCnO2qeHRGaltBcU=;
        b=eJ0bt8SQh4m39yGp2GIx2WtJHgLbDVOX5OLs4T/Xpmmn+hgk1L9sWTyNIG2UoP8t0R
         XeS+gfdSl1iFgREZUjvBqFYKpsadLl2M0JYpbWleoQvN8Z0O9bxpj5EVkf/xS+Uq8n7W
         O5hp2nQn5s1FGLjhJeNfQmaW7FkEn08B1B0PTFRrmMUit2CTWUxsV4cq2k+WP2w7PcKn
         stC1Gk1RZRp/hKvZMq+FrVcJjOoOO1k6szTUz9kbQPWg/wkfVVfQYu3zlizBfVNmuioZ
         MSB/9UTCyoLC54DVXcx4dtoPAsDFBxvjE8/V7iXWNTuWnvYqDrElPTz8Um4zcEW1JZvG
         wt6A==
X-Gm-Message-State: AOAM533vEicQK8oZupNXyFJ6ATOQVg1+ZAxz0HtWCTTYGMUjxzAWTSHv
        +FzCsQ7dvqwlAS+WxlJDVs0qGA==
X-Google-Smtp-Source: ABdhPJwurA8GPQepaNU2riEn7gHqyBjnaoiGi8guJwsjtYM8I8F+E56yfB75AYB7nT5y26qpRqUmpw==
X-Received: by 2002:a17:902:7d94:: with SMTP id a20mr19921995plm.174.1597866584026;
        Wed, 19 Aug 2020 12:49:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u3sm3009933pjn.29.2020.08.19.12.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:49:43 -0700 (PDT)
Date:   Wed, 19 Aug 2020 12:49:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mention documentation maintainer entry
 profile
Message-ID: <202008191248.9C653130F@keescook>
References: <20200815102658.12236-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815102658.12236-1-lukas.bulwahn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 12:26:58PM +0200, Lukas Bulwahn wrote:
> Since commit 53b7f3aa411b ("Add a maintainer entry profile for
> documentation"), the documentation "subsystem" has a maintainer entry
> profile, and it deserves to be mentioned in MAINTAINERS with a suitable
> P: entry.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on docs-next, and was checkpatch-ed.
> 
> Jonathan, please pick this patch.
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f520202fa1ef..8aa1369d5926 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5178,6 +5178,7 @@ DOCUMENTATION
>  M:	Jonathan Corbet <corbet@lwn.net>
>  L:	linux-doc@vger.kernel.org
>  S:	Maintained
> +P:	Documentation/doc-guide/maintainer-profile.rst
>  T:	git git://git.lwn.net/linux.git docs-next
>  F:	Documentation/
>  F:	scripts/documentation-file-ref-check
> -- 
> 2.17.1

Oh excellent! I missed this file going in originally; I need to get
similar done for seccomp, etc.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
