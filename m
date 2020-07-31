Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6A6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C4320791
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PpKrDqws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgGaXdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgGaXdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:33:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C6AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:33:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t6so4701357pjr.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d+nAbn95QFMNyC0khRAqZBOpjDeBLSM9xETqQyODpGI=;
        b=PpKrDqwsyi4ds6f6Er7lLKpLa7EmX38iRMCZ4aeOpqqX96i0ozzxrSzMt9kRg9Xdeh
         pixKEhi1q4w843Mq0Hd2BaJBZavap5ziwh6T1uXf4RwYYu3d0FIHBIm0W5BMQD1I1J70
         WU8AU3P0Tfc9+Dto5f8ySIfYQOwT7iMpBIhhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d+nAbn95QFMNyC0khRAqZBOpjDeBLSM9xETqQyODpGI=;
        b=fBOYtSaIZTijqdVdcxVaps7VLK7F1Da47FCOkNXJgTYKA0IevLSkCH1d5oCcChABdz
         f3xSDoJfK7UUuo4tmbC18f5aIR6PXcHqUSQtBImV5hb+sQpTVy3tRzv6YqOtIniANVhq
         yv9ovibRtOGf+WLB6F/rwlZpWLKEDGzSmCWzpIzyIk6U0kxK7vSbvdm3ciIkOFdMeawf
         pIHQpeygDH71VCCq/xDXITi/ggBV86slAMlQp5xIM60ctaRiYVLqNLkWFAQ7+cTmHfzA
         N7mt+yKVo5UQrdWJvJWFdEuYt/x5UtgvN6T2/2T1CRbt7iygXp5xri2wRZEkdO6teLBh
         /CuA==
X-Gm-Message-State: AOAM532hZScInFMKHGZh6to9fGwV8j77hvtVyitJbx11b8rSAPUlB9JF
        TVJieGfDllczTODpw2OWQ09ymw==
X-Google-Smtp-Source: ABdhPJwKfLJMgjnDicr37wQLS4YBsNmWRltJWSDIZvKgXW0gzFEALnjka+WnSww6WfmyPbIiUjmIyw==
X-Received: by 2002:a17:902:7005:: with SMTP id y5mr5190726plk.342.1596238417500;
        Fri, 31 Jul 2020 16:33:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m9sm10229027pjs.18.2020.07.31.16.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:33:36 -0700 (PDT)
Date:   Fri, 31 Jul 2020 16:33:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/21] x86/kaslr: Cleanup and small bugfixes
Message-ID: <202007311632.54A7554192@keescook>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
 <20200728225722.67457-1-nivedita@alum.mit.edu>
 <20200730180224.GA1203420@rani.riverdale.lan>
 <20200731092146.GB2956@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731092146.GB2956@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 11:21:46AM +0200, Ingo Molnar wrote:
> 
> * Arvind Sankar <nivedita@alum.mit.edu> wrote:
> 
> > On Tue, Jul 28, 2020 at 06:57:01PM -0400, Arvind Sankar wrote:
> > > v2->v3:
> > > - Fix the first patch: command line size should be strlen + 1 to account
> > >   for terminating NUL. Avoid calling add_identity_map if cmdline was
> > >   NULL, though it should do nothing in that case anyway.
> > 
> > Hi Ingo, I noticed that WIP.x86/kaslr and x86/kaslr both have the v2
> > version of the first patch. That has a bug in the cmd_line_size
> > calculation (missing the +1).
> 
> Indeed, well spotted. I rebased the affected 4 patches in x86/kaslr 
> and used the opportunity to add Kees's Reviewed-by to the first 4 
> patches as well.
> 
> I've zapped tip:x86/kaslr for now and put the whole series into 
> tip:WIP.x86/kaslr, will move it into tip:x86/kaslr for a v5.9 merge 
> once Kees is happy with the latest version.
> 
> Kees, AFAICS your type truncation and patch split-up review 
> suggestions were resolved in v3?

I need to double-check, but I think so. I'm hoping to get to that on
Monday. My orphan section series work took MUCH longer than I thought it
was going to. :P

-- 
Kees Cook
