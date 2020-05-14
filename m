Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6FBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 143C820748
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blFSU6/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgENOoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgENOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:44:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98384C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:44:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x77so1411524pfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3517NpCaDBacg/Dwp902mIgUINgvR6pFPGbL/kslfaY=;
        b=blFSU6/kX50CoVlrbhPDy8DHQmKvZ1iW5M5e060phVc6yrJAI7mhafMTdfQ8a5yg8K
         kek6m1LiF3MDFjjFB7XMLpcjP1b9fqTCsBplPrLzh4BzDHMECFlXzJ/v6D5aNI58YqSr
         zdol8qDrATXLReGmRCXdVRXEgxpVJqqJVH0+svDutlfjhKLEGTuwFY3uUpvF8xQU1K++
         6vnZuE4QNeEhxUt5c7ryXSZcdtH+lGXE2bT3GAl8WnVbDe/ABhm8gAeiGVfLLW9Kf+UD
         05RdbAQ3f9Hk5nCbXPcQTSu4Ox7vTPoXvCk+Bb+0RHi3LoGRwiFUEMMUPKMRGvu+6UyP
         6QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3517NpCaDBacg/Dwp902mIgUINgvR6pFPGbL/kslfaY=;
        b=dwUdk7JzHsjtjI6kn5DcDiI2EVBXGGTIs59Oy4BA6pNKnipnRwjUXGVtj1U/DkGnne
         W7WGSFTCfBM5eSviA16B46lv0j8rPZETEf1Oy1WZn/0JajgpwzI/Fla8n9nbNWu+wEDo
         xrgFuhtCG/TS0gOXLn5Y5OHn0kSS/FlidSVXI4ZHmsImwGsfX72fuWuGa2oDHhBngmZM
         qBxY6H6JvYTB9YXRUnhjHZhrefZLb+YHo/mRabVvZxzLP9Q3S+fiAKQCwmxckTg8o3WZ
         SMnhw4UpIF2G6a6OhpbY65eWj147bN3mNpuio1b+C+N/qLOAlKBp0CyX6HrVEuXm3zg7
         WE3Q==
X-Gm-Message-State: AOAM530O46+mvxVvNL1FfntksUc+XPedXvlWDFyTHCoWJCbG1cdkZQ7c
        YlCoMG5sNUGvDUc/gwDGw+o=
X-Google-Smtp-Source: ABdhPJzTN+o4BlFp6Ad0119sdkLFW5d512QRy4tNm/IM3mh2dtrtu8tX3mFraIaxR60CiEHH6aB7Sg==
X-Received: by 2002:aa7:8c0a:: with SMTP id c10mr5081607pfd.177.1589467464241;
        Thu, 14 May 2020 07:44:24 -0700 (PDT)
Received: from localhost ([49.207.51.148])
        by smtp.gmail.com with ESMTPSA id o21sm18060707pjr.37.2020.05.14.07.44.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 May 2020 07:44:23 -0700 (PDT)
Date:   Thu, 14 May 2020 20:14:21 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: static kernel in vmalloc space
Message-ID: <20200514144421.GA6090@afzalpc>
References: <CAK8P3a3OC5UO72rTDWi6+XgmExJmkATEjscq8hns8Bng06OpcQ@mail.gmail.com>
 <20200504091018.GA24897@afzalpc>
 <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc>
 <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc>
 <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc>
 <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514133545.GA5020@afzalpc>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 14, 2020 at 07:05:45PM +0530, afzal mohammed wrote:

> So if we make VMSPLIT_4G_4G, depends on !HIGH_MEMORY (w/ mention of
> caveat in Kconfig help that this is meant for platforms w/ <=4GB), then
> we can do copy_{from,to}_user the same way currently do, and no need to
> do the user page pinning & kmap, right ?

i think user page pinning is still required, but kmap can be avoided
by using lowmem corresponding to that page, right ?, or am i
completely wrong ?

Regards
afzal
