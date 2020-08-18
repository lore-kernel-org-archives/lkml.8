Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE4EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A87C20709
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 21:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aZHLFzRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgHRV5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 17:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgHRV5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 17:57:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE34FC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:57:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id kr4so159081pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 14:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=80dnnjy4rq5c56BmA2+0ZLTfz0G4aXZ2mmUJRKyYQ5A=;
        b=aZHLFzRxQEfnswcf76XtxHgg0WnTk0m4TIKrSdxQ8tbnhTKpc1G0/xo0UqYkNZC+fJ
         PJ9EBIW0HbqC+GqmMh/EAKNZBazRYeg+hI4H2K0oqYwHN5p9a5V+TvoCo8YgdFSjXz/N
         rJV9/7CSJnXMWG/L/dDtq69UzcKwfiVKcC9aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=80dnnjy4rq5c56BmA2+0ZLTfz0G4aXZ2mmUJRKyYQ5A=;
        b=tmMEBqBXsWdl+AckjJAmfnXkBaXaSC2I1vLG/I9xSEHi8jg3dsnC2/jyyUD+u+Nrjc
         2UFYbd/3b0fALPEWsWHzY00ryLqExiHTQOaKQ95x4yXloaHH1vVm6Ao2iX04l4JE2QmG
         kwrWgZRadnha/6cQ4bJ8k14nHsAVTY8tGLee6K+j78jzTeWvKfTzf88obTRPv/Gg6yhR
         b8HyuHf++19ye8UfD69mCLvZuAsalOKhCWMnKI2Z56dSBKPpV0XGZy4zzazWDDJ6zTEF
         xo3LAztrVXChvjtqKd+cQ9Eo43FQd26ev9BadWUKU+6qnZ7bleMDd/H0DgpZaENrKPp8
         lCkw==
X-Gm-Message-State: AOAM531BI6f+PuBPrKEPZIq3l3QpFnSnQdHfXETf3vPIg0A9PHRU8i42
        vF4JzC0bRhveAXrQKJNhxjeOmQ==
X-Google-Smtp-Source: ABdhPJw45B1bJu3yimJIPaqJkssbWEyQQT4tpsFe/MXaFvISFuRObn5i3HDhDm1nL4eurpdthIb5vQ==
X-Received: by 2002:a17:902:be17:: with SMTP id r23mr16530356pls.284.1597787871275;
        Tue, 18 Aug 2020 14:57:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b20sm25563205pfp.140.2020.08.18.14.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 14:57:50 -0700 (PDT)
Date:   Tue, 18 Aug 2020 14:57:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>
Subject: Re: [GIT PULL] mailmap update for v5.9-rc2
Message-ID: <202008181456.1C6685A6@keescook>
References: <202008171624.8E3C303@keescook>
 <CAHk-=wiKsEC8TUhn5mXapPV7sY_ZxpR-hini75zJ2e-iX+SUNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiKsEC8TUhn5mXapPV7sY_ZxpR-hini75zJ2e-iX+SUNQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 05:32:32PM -0700, Linus Torvalds wrote:
> If you want dictionary sorting you'd use "sort -d".
> 
> But the commit message says "sort -f".

O_o Err, I don't know how that happened. I must have cut/pasted into the
commit log from my command history at the wrong place or something. Sorry
about that and thanks for the pull!

-- 
Kees Cook
