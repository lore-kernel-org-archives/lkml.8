Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69D3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B063207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZHUB2ZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgESLkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 07:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgESLkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 07:40:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082C7C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 04:40:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f13so2691599wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cTKYH+mp/bhcR85XQxkJ8OwwsY1zKVWgOX9zGZznoL0=;
        b=MZHUB2ZXTdwLAmgOpCVyQjfyasKoo+pyNdYM9+FPR+5DIBal6yroxOGSNKZH6XWnWH
         c6Ms4Byxq3yTfxeqNJ3eAG0k0EraIU/71QMv0I60UuvNYIhmMGIwOlie06z/m2jAkp1s
         E0zXBbjFMSmJeKWFWdTYTRkL+NYJVwBQnfV0j+tSmNee3UxX65pAQ1T7BXERUCAo31or
         povr55CG1IJBMb+wfWoNt1VgsdfOJSGB18eLoEl98yykvN46WfwqX9PLEDyXc1TdcyUk
         Gt/jX2G23Vkir+HGDDstNmbBBBRVoRvTzclBwBacRPYxdobkL4RY5CQCSftE9g/R9/Fq
         vtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cTKYH+mp/bhcR85XQxkJ8OwwsY1zKVWgOX9zGZznoL0=;
        b=gSiN4K3APp5rg8R4o79uyUtTcmVONEutmUeg9Yz85jysgvy1Rq554vDuTYCUgYpaKu
         05FpWVfp882KS9rjQrH4vQ+3oMgi1BsLg+MrNwsFFB0pTLOakqli8yhEfMJHy14sLh7m
         UgONyyaJwVO3W/EWIUQkAJ3vbdyMKDYibsXWbX0A8AZh5STaPHitrFBjnXyN0lBFFbM6
         Fpj+Y/y5rSvB9z1uYIH+XYGja1rF/EhFs+PqRaoRZZXhI7csoxNwlZrKoZspB9mR2FMf
         L5gfpWG8fEqGE2ZFXA4YoPpeUORefU94LiYny4sACQzHnGeUBw09VU2Ka+HI/ActvNoW
         Rq+w==
X-Gm-Message-State: AOAM530nSk+9GGxl+/zr3FtenLchlCAsbxCK0dgoJ+O4smD7xnX5BiaZ
        VjKlM0/wt2jmknvJskpzal4McLBBjWU=
X-Google-Smtp-Source: ABdhPJxkzXzSGi0I3tTgZ6x7A+f5Zr0659258Yl+tQWXZmWMobtDKKKEHVlFcps7BOvzvTpauYfFuA==
X-Received: by 2002:a7b:c939:: with SMTP id h25mr5036964wml.9.1589888410760;
        Tue, 19 May 2020 04:40:10 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 89sm21569339wrj.37.2020.05.19.04.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 04:40:10 -0700 (PDT)
Date:   Tue, 19 May 2020 12:40:08 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kdb: Make the internal env 'KDBFLAGS' undefinable
Message-ID: <20200519114008.lmdf44zmgcmnf27c@holly.lan>
References: <20200516092606.41576-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516092606.41576-1-liwei391@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 05:26:06PM +0800, Wei Li wrote:
> 'KDBFLAGS' is an internal variable of kdb, it is combined by 'KDBDEBUG'
> and state flags. But the user can define an environment variable named
> 'KDBFLAGS' too, so let's make it undefinable to avoid confusion.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

I took a quick look at this and find myself thinking of KDBFLAGS as
something of a misfeature.

I think I'd rather get kdb_env to show the value we wrote into
KDBDEBUG.

Sure this means we cannot use KDBDEBUG to look at the least significant
16-bits but I think anyone who is debugging kdb itself should know
enough to use `md4c1 kdb_flags` to read those anyway.


Daniel.



> ---
> v1 -> v2:
>  - Fix lack of braces.
> 
>  kernel/debug/kdb/kdb_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 4fc43fb17127..75b798340300 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -423,6 +423,8 @@ int kdb_set(int argc, const char **argv)
>  			| (debugflags << KDB_DEBUG_FLAG_SHIFT);
>  
>  		return 0;
> +	} else if (strcmp(argv[1], "KDBFLAGS") == 0) {
> +		return KDB_NOPERM;
>  	}
>  
>  	/*
> -- 
> 2.17.1
> 
