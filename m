Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F57C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3D820792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lvaXW0EH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgGWWcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgGWWcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:32:19 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1626AC0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 15:32:19 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id l6so3333582plt.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 15:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rcHiH1Tqs5ADJ+MGb3vcjbWBOdmK6BVfKbafmPqedI4=;
        b=lvaXW0EH58h+/+Oelkh/2EltLVN21JeGtH9oA9rq4r7QwYFgUzxZHdbdpcj6L0OT4+
         NUzurvHLRVuiuFxDjQ4s+3XcN+azqQ4Z9/kmtqIXftHCj7BYQ13jO1kHZnF5qpLkb/5/
         Db2jc9KY+6XmdRAlWCgKbg6WL/mHQCeBQS4JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rcHiH1Tqs5ADJ+MGb3vcjbWBOdmK6BVfKbafmPqedI4=;
        b=BJd39YCXfQTXzjP0JC3IVw0yvBG7+UBHq5ueMXqtG3R2kP643/SbMJGMKgtTmIairb
         c4h+l94fSUzE+5fNtiXk+m0zusdvJRabeEjBxSdEMWZhQVZH9EYAhouWLwBh51BRY5pE
         CNzsdy9bYRPFHNyreWyj+wvXXEv6fP9KiBm3WbLgEeCPDj4lUEiOGJu43woxAaHztcnR
         xG3DE53rjwOtJCjLgRnU+OZmUAmVHkgo5RVdmNv3zurw1Fi5fCV8mPDtwU/KBTllABGH
         OhLaoyXcM0D4DrgL8PxkwvxAW4xPdtNaBjDLh1AzGj6iCkDFGbB1fAEQwq75i2YnGsjy
         i/rg==
X-Gm-Message-State: AOAM532qBbl14h3QOSLseqT700OnjGYkRchqEVboRgTuSfAWEf1ICt5n
        kLOK4/3GqQzngG+FcokRbbfoNQ==
X-Google-Smtp-Source: ABdhPJx/HbAN/k8ICmlNADe+1VuDo0tfRRzSOZ3OPXagZgfd/TkGMW8mipyokLFnWdO7JgsaGPhN/w==
X-Received: by 2002:a17:90a:1b64:: with SMTP id q91mr2452247pjq.119.1595543538591;
        Thu, 23 Jul 2020 15:32:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m68sm3815562pje.24.2020.07.23.15.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 15:32:17 -0700 (PDT)
Date:   Thu, 23 Jul 2020 15:32:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mazin Rezk <mnrzk@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "1i5t5.duncan@cox.net" <1i5t5.duncan@cox.net>,
        "mphantomx@yahoo.com.br" <mphantomx@yahoo.com.br>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "anthony.ruhier@gmail.com" <anthony.ruhier@gmail.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH] amdgpu_dm: fix nonblocking atomic commit use-after-free
Message-ID: <202007231524.A24720C@keescook>
References: <YIGsJ9LlFquvBI2iWPKhJwjKBwDUr_C-38oVpLJJHJ5rDCY_Zrrv392o6UPNxHoeQrcpLYC9U4fZdpD9ilz6Amg2IxkSexGLQMCQIBek8rc=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIGsJ9LlFquvBI2iWPKhJwjKBwDUr_C-38oVpLJJHJ5rDCY_Zrrv392o6UPNxHoeQrcpLYC9U4fZdpD9ilz6Amg2IxkSexGLQMCQIBek8rc=@protonmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 09:10:15PM +0000, Mazin Rezk wrote:
> When amdgpu_dm_atomic_commit_tail is running in the workqueue,
> drm_atomic_state_put will get called while amdgpu_dm_atomic_commit_tail is
> running, causing a race condition where state (and then dm_state) is
> sometimes freed while amdgpu_dm_atomic_commit_tail is running. This bug has
> occurred since 5.7-rc1 and is well documented among polaris11 users [1].
> 
> Prior to 5.7, this was not a noticeable issue since the freelist pointer
> was stored at the beginning of dm_state (base), which was unused. After
> changing the freelist pointer to be stored in the middle of the struct, the
> freelist pointer overwrote the context, causing dc_state to become garbage
> data and made the call to dm_enable_per_frame_crtc_master_sync dereference
> a freelist pointer.
> 
> This patch fixes the aforementioned issue by calling drm_atomic_state_get
> in amdgpu_dm_atomic_commit before drm_atomic_helper_commit is called and
> drm_atomic_state_put after amdgpu_dm_atomic_commit_tail is complete.
> 
> According to my testing on 5.8.0-rc6, this should fix bug 207383 on
> Bugzilla [1].
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=207383

Nice work tracking this down!

> Fixes: 3202fa62f ("slub: relocate freelist pointer to middle of object")

I do, however, object to this Fixes tag. :) The flaw appears to have
been with amdgpu_dm's reference tracking of "state" in the nonblocking
case. (How this reference counting is supposed to work correctly, though,
I'm not sure.) If I look at where the drm helper was split from being
the default callback, it looks like this was what introduced the bug:

da5c47f682ab ("drm/amd/display: Remove acrtc->stream")

? 3202fa62f certainly exposed it much more quickly, but there was a race
even without 3202fa62f where something could have realloced the memory
and written over it.

-- 
Kees Cook
