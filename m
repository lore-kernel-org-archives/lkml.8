Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FD3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5A520671
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiSDknuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgEPGGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 02:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725803AbgEPGGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 02:06:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3187C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 23:06:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id z15so4848739pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 23:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9yedn3qfHjLM32OIbYmV/Cr3YjdgfcJ0Re0Gxm2GLZg=;
        b=CiSDknuW2CMRJcaVSe9+ahgAMOD3wVXZZnG3298IFAjWCkN9aLnZT5eiBzoRU/9aXy
         egbfwuoj8CVSPlgRT6xaI2W4FrvUAGdFx857ZhrgxBubFNXnA6DkdJkJrNONhobUUAOV
         YMNJ7yd9CipogGdTJM2Oa1gc2QlmHziCfTwzL2oYf9np0E6ZpHTjjUG8Jif4ObLYp9vn
         0C2yPY/uZ17YWxTbon97nipp94Z87HXdak+ufcmyooY+iXFcJbjHyM37fdbHjgtLONKk
         331d95TkOfJ6w7wSi0XNbHrtBOiKRQAJBEhsdYQ/ZhbUM3sD41WsCHKXdOJ89TMi0I4v
         cZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9yedn3qfHjLM32OIbYmV/Cr3YjdgfcJ0Re0Gxm2GLZg=;
        b=A8aDbWhti5TKGGGgJpEAlDLWM9RIICufiWnlKaWUU0+4Ra/3eku5bD8TdB1X3h+/V1
         USLtuKoRZMqthT/FCzmVS9f9HQNAt8lfv/Ok3G6OmuWT0VrQrHsyv5cH3m+6CCDj5PmI
         +uPsxobJ3somBxHXg+NBfMbGPe/zj6sg5/5s1ctDClaiKdbPHvhsweN3+31TGNPRxSdu
         9yfI9sJNMZsGW3FL+03bfbW2JUYDfKnpEw7dXWaUnfEzB6s4hpRTkgNYbz0jheQmgn1m
         T3GQyO9l9Ndoo6s9z2anQsCbQmD/9xEUeNnNP+Wv8/oVTwcgtBOZMGVk3nY6foEnhaZu
         SUng==
X-Gm-Message-State: AOAM532yAURqKjguHi2Tg9QQAl0j0j4jMlF6rd90io22adERCcEbDcgw
        QIl295qA46eg+MlJTfeA0hrJnNJ3
X-Google-Smtp-Source: ABdhPJzGAfpa04r3IfhHrHbETdXS4Ctg9HnFuKMrWSojSbA63aMYelLohClIUG1dqCwqc1UpdZ+BVQ==
X-Received: by 2002:a17:90a:2567:: with SMTP id j94mr6900442pje.26.1589609187183;
        Fri, 15 May 2020 23:06:27 -0700 (PDT)
Received: from localhost ([49.205.222.224])
        by smtp.gmail.com with ESMTPSA id s2sm946201pjs.9.2020.05.15.23.06.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 May 2020 23:06:26 -0700 (PDT)
Date:   Sat, 16 May 2020 11:36:24 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: static kernel in vmalloc space
Message-ID: <20200516060624.GA6371@afzalpc>
References: <20200504091018.GA24897@afzalpc>
 <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc>
 <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc>
 <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc>
 <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc>
 <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 14, 2020 at 05:32:41PM +0200, Arnd Bergmann wrote:

> Typical distros currently offer two kernels, with and without LPAE,
> and they probably don't want to add a third one for LPAE with
> either highmem or vmsplit-4g-4g. Having extra user address
> space and more lowmem is both going to help users that
> still have 8GB configurations.

Okay, so the conclusion i take is,

1. VMSPLIT 4G/4G have to live alongside highmem
2. For user space copy, do pinning followed by kmap

Regards
afzal
