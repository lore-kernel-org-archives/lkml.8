Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115B9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53352078A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZGMwg0bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgGHIFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgGHIFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:05:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96C6C08E6DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 01:05:41 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m9so9368696pfh.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 01:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LkJv69Xj41MVN6g/xAHmv6FvGBiw0q1qso2n51GzrnA=;
        b=ZGMwg0bu7QNzFG/BBSEOyiiso2dm24A1n/oGqU9336Lbuv2SfCKC9anfVRuiuxeNCZ
         WULMXN/Y45y+zAUiJlctanRxRLWHHdRtAvyrO2mL2IT+u9Px9kWWt4lAAZASjfm8uU05
         phLe2mP3RQrtQ0ho1Xq+FR1jRd6FxxT1ZwAU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LkJv69Xj41MVN6g/xAHmv6FvGBiw0q1qso2n51GzrnA=;
        b=asQ7zgyeOsP17hirXkNe4UYpRtwzbPRemeT4wVPnphs9nTxeFhF41L6wuhFP3oS0Me
         If1ddHOWVfvDT+pYi8Go2w+XStg1zKyddslaq80HdfG383o6wnLph2a4K2Fy2w7haYkh
         QQAxIxF0Zn4kE7dPQdqxOW3qAoBylTfuNVwMPqzI7HANXMDTJ5neORoyN39q67yUPBTV
         67wde/H6UYoLthnuFBt8uLK18EY48bH3PiWjtdKkDoc5v2xiscnQB0hpBMn3Ww4/muCb
         2CpfbbsAlYJyxP8ObO3f1KDZmBS9E/JspgjBJk5FwejIoM9uKrFDOGE4qGUyVtIzJ1xe
         XTgw==
X-Gm-Message-State: AOAM530mE77LHIz17X73LXY/oSB38UKmOxYeGmS+rxTrysOp7A0MgYGy
        Z+NBa/XcY8fXhc+dw2p8/VR0cg==
X-Google-Smtp-Source: ABdhPJwtsnWmDHLjVW+FFiAsyZwY19P0WY7rLVAaaPsnV5alGw1jXdX46cHJtsfmYmvYoVrkKcv2gQ==
X-Received: by 2002:a62:e202:: with SMTP id a2mr47869802pfi.8.1594195541088;
        Wed, 08 Jul 2020 01:05:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm4592209pjy.54.2020.07.08.01.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 01:05:40 -0700 (PDT)
Date:   Wed, 8 Jul 2020 01:05:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: YAMA SECURITY MODULE
Message-ID: <202007080103.2DAD857D4C@keescook>
References: <20200708073346.13177-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708073346.13177-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 09:33:46AM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
> 
>  Documentation/admin-guide/LSM/Yama.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/LSM/Yama.rst b/Documentation/admin-guide/LSM/Yama.rst
> index d0a060de3973..64fd62507ae5 100644
> --- a/Documentation/admin-guide/LSM/Yama.rst
> +++ b/Documentation/admin-guide/LSM/Yama.rst
> @@ -21,7 +21,7 @@ of their attack without resorting to user-assisted phishing.
>  
>  This is not a theoretical problem. SSH session hijacking
>  (http://www.storm.net.nz/projects/7) and arbitrary code injection

This link is dead. It is likely best replaced by:
https://www.blackhat.com/presentations/bh-usa-05/bh-us-05-boileau.pdf
(this is the same person, but it seems storm.net.nz is gone)

> -(http://c-skills.blogspot.com/2007/05/injectso.html) attacks already
> +(https://c-skills.blogspot.com/2007/05/injectso.html) attacks already
>  exist and remain possible if ptrace is allowed to operate as before.
>  Since ptrace is not commonly used by non-developers and non-admins, system
>  builders should be allowed the option to disable this debugging system.

With that change:

Acked-by: Kees Cook <keescook@chromium.org>

for the docs tree.

-- 
Kees Cook
