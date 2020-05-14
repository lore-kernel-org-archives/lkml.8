Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC6FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236A020727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMSW1I6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgENNfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726037AbgENNfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:35:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A23C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:35:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p21so1240711pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dFH4YBbehMI5t5iqf9Q3qC3HSqGhIHfBCfuP+cdahd4=;
        b=QMSW1I6g69BXV603QaMHpeUSgDh97tVPbW+aOr8TNB1DROgfixI7vPwvLqnPQftRbu
         k/DPWZZCyDkAqkGMyKxaCuU0auNG8u3VNTsYoKg9i/6TfyufPw31JBq/HqrXhlY25q1O
         FEoyvdlBEbpmE+R9iw2Bk2PDZdoUDuaBcRV4+4KZrgKr2IdlZWue1/hOrdi/XGwFUh+L
         myzCQVsNAZHA17H/eqiUz6s17fy9GI9NvsMmjq2Mrnegh2/CXKfNxpd76zfde3+2XF4Y
         9GlNZqEtCWPbdJmgW+qw8QzMoUZgkAfkbH8Vqoah21hxzL4zQOTpotm6U+rO26/XhNZe
         cxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dFH4YBbehMI5t5iqf9Q3qC3HSqGhIHfBCfuP+cdahd4=;
        b=U85Ahm6YsM/ZMxh6SQo/RnaLUaNWUXArzp63gwVwqlUSK2KxK4ZG2frXArO/6CBR//
         3Xybk+gvyc3Uv6GqQEmxlq+CRpy7IhIGL6gaTS1izDYRKFBRdCzyJN8cnAedaGkP9PMp
         YxGdc3cD46flrXgPTr3mya5hWkEzOAcT21MTKXS4hRdtAGVW5mxTK4wmYONJobqdDc93
         Rn4CyNt3zHeZBjGx1sufSF5aFhxfMnwnBfqWmKJn4UvSvoJbmGl/952qfoPV7DrDZD5u
         gbYPERgmvoS49GWNxNDfmN1+E330XuSrNndA8EY10nzGDYvPRj0nmDi8ySpvlFRk2BPS
         NziA==
X-Gm-Message-State: AOAM5329k/MYZXjdkiC8hvcBQHZC1snAJJeynWyLRvYi/wzinzSeFL5H
        y1EQzrm8CH+v7pWLt+UhG08K93Rw
X-Google-Smtp-Source: ABdhPJyQMSiFyybpBsgKRX8zYbVXbAgjPZ/ufU3iqqpt6IQVzBBGvLrZ288ij1pt0DGhq+h93Zc31g==
X-Received: by 2002:a62:ab16:: with SMTP id p22mr4250043pff.216.1589463348447;
        Thu, 14 May 2020 06:35:48 -0700 (PDT)
Received: from localhost ([49.207.51.148])
        by smtp.gmail.com with ESMTPSA id gb6sm4426799pjb.56.2020.05.14.06.35.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 May 2020 06:35:47 -0700 (PDT)
Date:   Thu, 14 May 2020 19:05:45 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: static kernel in vmalloc space
Message-ID: <20200514133545.GA5020@afzalpc>
References: <20200503145017.GA5074@afzalpc>
 <CAK8P3a3OC5UO72rTDWi6+XgmExJmkATEjscq8hns8Bng06OpcQ@mail.gmail.com>
 <20200504091018.GA24897@afzalpc>
 <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc>
 <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc>
 <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc>
 <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 14, 2020 at 02:41:11PM +0200, Arnd Bergmann wrote:
> On Thu, May 14, 2020 at 1:18 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> > 1. SoC w/ LPAE
> > 2. TTBR1 (top 256MB) for static kernel, modules, io mappings, vmalloc,
> >         kmap, fixmap & vectors

> Right, these kind of go together because pre-LPAE cannot do the
> same TTBR1 split, and they more frequently have conflicting
> static mappings.
> 
> It's clearly possible to do something very similar for older chips
> (v6 or v7 without LPAE, possibly even v5), it just gets harder
> while providing less benefit.

Yes, lets have it only for LPAE

> > 3. TTBR0 (low 3768MB) for user space & lowmem (kernel lowmem to have

> hardcoded 3840/256 split is likely the best compromise of all the

hmm,i swallowed 72MB ;)

> > 4. for user space to/from copy
> >  a. pin user pages
> >  b. kmap user page (can't corresponding lowmem be used instead ?)

> - In the long run, there is no need for kmap()/kmap_atomic() after
>   highmem gets removed from the kernel, but for the next few years
>   we should still assume that highmem can be used, in order to support
>   systems like the 8GB highbank, armadaxp, keystone2 or virtual
>   machines. For lowmem pages (i.e. all pages when highmem is
>   disabled), kmap_atomic() falls back to page_address() anyway,
>   so there is no much overhead.

Here i have some confusion - iiuc, VMSPLIT_4G_4G is meant to help
platforms having RAM > 768M and <= 4GB disable high memory and still
be able to access full RAM, so high memory shouldn't come into picture,
right ?. And for the above platforms it can continue current VMPSLIT
option (the default 3G/1G), no ?, as VMSPLIT_4G_4G can't help complete
8G to be accessible from lowmem.

So if we make VMSPLIT_4G_4G, depends on !HIGH_MEMORY (w/ mention of
caveat in Kconfig help that this is meant for platforms w/ <=4GB), then
we can do copy_{from,to}_user the same way currently do, and no need to
do the user page pinning & kmap, right ?

Only problem i see is Kernel compiled w/ VMSPLIT_4G_4G not suitable
for >4GB machines, but anyway iiuc, it is was not meant for those
machines. And it is not going to affect our current multiplatform
setup as LPAE is not defined in multi_v7.

Regards
afzal
