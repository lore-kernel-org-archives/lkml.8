Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6C3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE453208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HykgGlBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgFZVII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFZVIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:08:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB9BC03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:08:07 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so3110060pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5QZafrBOHReSAigLeQLaB8dHFcFb66791XFnIdiUaS4=;
        b=HykgGlBZz5r44Jrelk4LBTxug9hBtN340JGZEKohdio9yzd7feI5yweIlsuQ1vtm47
         jNWofa2w5mVPzhJnl0AS8ccR3gk1vRVSNzrA3/UmNzuV67NDtOGzhJ1OIiNBbbyDhN/9
         q9yZsDBk+04uuDc3GYEzPyMIirFlthojK6kjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5QZafrBOHReSAigLeQLaB8dHFcFb66791XFnIdiUaS4=;
        b=eUp3v7pAGazDKuIfArqfOoOm1oFuuGjHNyzGG0L4YLhuFxaWSj8DRr6HM/x+nlNj7h
         pOtChEeTYLekD5WQXkrsLh1g7gszeC9EL6447vrvipu2gLaUpR3U6b/XpkdMeJt9q3pe
         73nGe4kn1Jg28BlTit4ACfkBbfuB45PxY6Tczu8RM/Mf10YFKep4jqAlJ5bpQjh+JRmX
         t8yLqBRyDkdBZfBy8givVSoDRI/uw0ymKPk+6sWRv0d5HQXzlfxCq9nuJvpkjfA40R+1
         G9p3WS1ns2znPExMcz+O1AxU1ZsBBFQBLfKX8BuNYzIGyL9roY7wxBTgs43UzGbLujYZ
         THCg==
X-Gm-Message-State: AOAM530ZlcUEZwnfZSwtJXVWyQ8OlRlBDwMQLLCTLZIZpHj34NIdKSck
        fPBpaQ8ko76gC6IoapyfQIUDkg==
X-Google-Smtp-Source: ABdhPJzFsFB/Cbqr/aK6fGHvmGyKXEaW+XrPiL4vutbiKFHT7jNkqp2PGPWXmLlHaJpxIotgSqEOhg==
X-Received: by 2002:a65:664a:: with SMTP id z10mr580379pgv.352.1593205686932;
        Fri, 26 Jun 2020 14:08:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i191sm27542104pfe.99.2020.06.26.14.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:08:06 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:08:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <202006261406.4C2ABC2E06@keescook>
References: <20200626170514.13f9cd5a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626170514.13f9cd5a@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 05:06:03PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the akpm-current tree, today's linux-next build (sparc
> defconfig) failed like this:
> 
> mm/slab.c: In function '___cache_free':
> mm/slab.c:3471:2: error: implicit declaration of function '__free_one'; did you mean '__free_page'? [-Werror=implicit-function-declaration]
>   __free_one(ac, objp);
>   ^~~~~~~~~~
>   __free_page
> 
> 
> Caused by commit
> 
>   1420b22124be ("mm/slab: add naive detection of double free")
> 
> __free_one() is ony defined when CONFIG_NUMA is set but used more
> generally.
> 
> I have reverted that commit for today.

Thanks! Just to close the loop here, Randy also pointed this out and
I've sent a fix:
https://lore.kernel.org/lkml/1de6b098-a759-dd96-df5d-9a282b2a991b@infradead.org/

-- 
Kees Cook
