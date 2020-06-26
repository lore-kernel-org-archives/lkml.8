Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5728DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F33020773
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OV2MEBsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgFZP0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFZP0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:26:33 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732BEC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:26:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so5072928pge.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SGbBcZmi7JWYkcmSuZuMkDkOvcG69EpOPP88SAzNvdw=;
        b=OV2MEBsVbbgFRgkfsg3gKcIyAxzhOi9e+yhzWHyd2zWOkn+XiOwkOJNz/2sSZiG2kh
         W3cMGtcu+UuLnsjvQFu1OYF2TJKX8Ziw751JowQOGuMZM8+sq8293ctqbMzYo9oiPBpd
         GQ7RVsECGWGMaD7YzKmvcbZr6A5ALg98qHxhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SGbBcZmi7JWYkcmSuZuMkDkOvcG69EpOPP88SAzNvdw=;
        b=d1+ttXqrqK4VRlcylDCei2F54U/1ncBIj+6KLT/gsSZ+tRgN45NMcF3/2jSZEYNgPa
         xsdHb6pjoCf+JPUu6IxkpLKmCwKIHtHP2QIvhfj+y4PJIelSCsbZgovvIqd5ZC38RcAw
         JUHH3pPxzdL2hiOLkWfQXBBkKWXBItJO0Je3mjJDvxeoAteVpPy3JBcaRNKR0LegBuhI
         FGrw6JPt9zmIbmeaVCym/w8AcxBAge2zYeKS+nvvQXNTcJfJQ7tHxfa15ngp9jAB5zZB
         k3HPDtZeImrv5wLCs8vhnc0IUvrJt/Kfoq6UAW2XEovKqncpycTmsendZKaoLZEJDrtt
         8T6A==
X-Gm-Message-State: AOAM532gtLl2VVwpcfPianIhbXSU/Cfhvdz2MrJwvZj5hQNyKedI/zjQ
        kWZk5V6a61ofLpTZ3v1hqrh3jw==
X-Google-Smtp-Source: ABdhPJxLbmD5CwIezukq172Xja4wW7yqyiCldoMg6FYFakPoVpwRnS+OWs2h0At9c0wzp83W2w2szQ==
X-Received: by 2002:a63:5013:: with SMTP id e19mr3254551pgb.68.1593185193063;
        Fri, 26 Jun 2020 08:26:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h17sm21791916pgv.41.2020.06.26.08.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:26:32 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:26:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] misc: lkdtm: bugs: At least try to use popuated
 variable
Message-ID: <202006260825.F530851198@keescook>
References: <20200626130525.389469-1-lee.jones@linaro.org>
 <20200626130525.389469-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200626130525.389469-5-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:05:19PM +0100, Lee Jones wrote:
> The result may not be intereresting, but not using a set variable
> is bad form and causes W=1 kernel builds to complain.
> 
> Fixes the following W=1 warning(s):
> 
>  drivers/misc/lkdtm/bugs.c: In function ‘lkdtm_STACK_GUARD_PAGE_LEADING’:
>  drivers/misc/lkdtm/bugs.c:331:25: warning: variable ‘byte’ set but not used [-Wunused-but-set-variable]
>  331 | volatile unsigned char byte;
>  | ^~~~
>  drivers/misc/lkdtm/bugs.c: In function ‘lkdtm_STACK_GUARD_PAGE_TRAILING’:
>  drivers/misc/lkdtm/bugs.c:345:25: warning: variable ‘byte’ set but not used [-Wunused-but-set-variable]
>  345 | volatile unsigned char byte;
>  | ^~~~
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Ah yeah, this looks like a reasonable way to deal with it. Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
