Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242A6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB834206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1J8WZEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgENLR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgENLR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:17:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA8C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:17:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fu13so12314731pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hknV+GJMZHyHLAY2im/FQF7wHV4s+FSMrkKyD2kNtOw=;
        b=q1J8WZEFW7zcbs4kfMwHVNcPHEvHzP0sWCL1KDOejr+Oz4wbi66N2QIJHSjF4QRW3Q
         TEDfEChsLpQbBMWtT6S0V4Je1V3/Kxw2Ii8ipz53soDuZFlMN3tvKjzxQDXY03e0FnAB
         Jg6FI4bRC175fUnWz3QeCj9PmuQoJoo46BfEbGKM9BRYH3vJtBEeZCq24PuckXMpFn2k
         VAYNw3kO7blN2xdlp55KlI1JN2CpIU8h97kLDnhSRNEuqNgr6zNVM7IL4CJVtAN7eM1Q
         cEHqy92xeP6BQn5y4Ncknujhip2GTZvq/Ny62ESqPkpUVlycWaVsNKkF23F46abJzrV/
         qbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hknV+GJMZHyHLAY2im/FQF7wHV4s+FSMrkKyD2kNtOw=;
        b=Xcngq+HsxnWRBEsPR8qD8Yk59Pt1K6o/30F+ab6+S50cteDk4brzkpgiy3LHkiA7N2
         RSizSzpIvpahhNZVb+MM1K5JwYGKBkjM+4K8QKWV1ReHCSXWuMkc+6r9rvup2ERw+k1m
         x8r2Oi0LsAthVdTfwIq5YQJ/Ukw+uVw9nZr99QYeV0akHU1u0rPWpAta7xCCDsRufCgs
         cnVAcPDOHmQLJ8WmopW2v2Aq30pJItvFEQI+XkeGpPTuPyOblO4Gsw4UrXiuzMv0vCx6
         lX4KF6f8QPybcn+q96gEi3CqE3vIdEiJcrA+GjtKmwON59XkMBlPS3yoa+4EINeZgtgH
         qeFw==
X-Gm-Message-State: AGi0PuaTR3L5P7lFTSr0ujXlbx4ozp1Yvcvw+ZTSCLxdaGQ3JCxgZggA
        mjKoKAIcxqXYvdFp3vY45bI=
X-Google-Smtp-Source: APiQypLarzhPpMk65VrkKnqffPBenJAa46xewdPlN9VCMxKTNk/8c6C3ICwXE0q0hf7R3DKGKlS54g==
X-Received: by 2002:a17:90a:cc6:: with SMTP id 6mr39655685pjt.17.1589455078047;
        Thu, 14 May 2020 04:17:58 -0700 (PDT)
Received: from localhost ([49.205.220.80])
        by smtp.gmail.com with ESMTPSA id g10sm2156051pfk.103.2020.05.14.04.17.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 May 2020 04:17:57 -0700 (PDT)
Date:   Thu, 14 May 2020 16:47:55 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: static kernel in vmalloc space
Message-ID: <20200514111755.GA4997@afzalpc>
References: <CAK8P3a0JW9x-Wk9Ec3+zLjPHbWAvPQx8MF-xe-PnWUgEjRAuTg@mail.gmail.com>
 <20200415135407.GA6553@afzalpc>
 <20200503145017.GA5074@afzalpc>
 <CAK8P3a3OC5UO72rTDWi6+XgmExJmkATEjscq8hns8Bng06OpcQ@mail.gmail.com>
 <20200504091018.GA24897@afzalpc>
 <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc>
 <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc>
 <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 12, 2020 at 09:49:59PM +0200, Arnd Bergmann wrote:

> Any idea which bit you want to try next?

My plan has been to next post patches for the static kernel migration
to vmalloc space (currently the code is rigid, taking easy route
wherever possible & not of high quality) as that feature has an
independent existence & adds value by itself.  And then start working
on other steps towards VMSPLIT_4G_4G.

Now that you mentioned about other things, i will slowly start those
as well.

> Creating a raw_copy_{from,to}_user()
> based on get_user_pages()/kmap_atomic()/memcpy() is probably a good
> next thing to do. I think it can be done one page at a time with only
> checking for
> get_fs(), access_ok(), and page permissions, while get_user()/put_user()
> need to handle a few more corner cases.

Before starting w/ other things, i would like to align on the high
level design,

My understanding (mostly based on your comments) as follows,
(i currently do not have a firm grip over these things, hope to have
it once started w/ the implementation)

1. SoC w/ LPAE 
2. TTBR1 (top 256MB) for static kernel, modules, io mappings, vmalloc,
        kmap, fixmap & vectors
3. TTBR0 (low 3768MB) for user space & lowmem (kernel lowmem to have
        separate ASID)
4. for user space to/from copy
 a. pin user pages
 b. kmap user page (can't corresponding lowmem be used instead ?)
 c. copy

Main points are as above, right ?, anything missed ?, or anything more
you want to add ?, let me know your opinion.

Regards
afzal
