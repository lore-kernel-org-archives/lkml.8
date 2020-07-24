Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069CBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D743B207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q1QRkHyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgGXRdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXRdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:33:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBF2C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:33:52 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so5665005pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6fXu93/1jlX07Hr4lqHKy5c8vfIRiF2jqmKmeTYOgAM=;
        b=Q1QRkHycMk52/bKVqxlla4kawMVY7rJ9Glz8gLDV/8MbzJ1hbsWxA2Nvw14uWnHUyR
         7i0ZEaE+GxwOv5WddwQKgaFbyK/Zqqm89mDtGLrSm4Eo9MCONhkoAcHQdJYOautUQtIl
         BrY8mEeiP/cjryNq+KgqmCIVo1Ikw2cnJeoJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6fXu93/1jlX07Hr4lqHKy5c8vfIRiF2jqmKmeTYOgAM=;
        b=oR33XYgOAaSrqnvOoyYzWpYs+zVfFpbDZNWNv4oB3/PDUb2lJFPmiEpIzTvL/ZzgOs
         wPhxAHNBc2Dh0FRd2AlezUlys0IBOIdNubflRm2zvqBFTXjTmhBIpX8GZagktcLcke65
         Pmvg27YmOEv7LNJKVK1gdlEhqAS6iVbxinb0g0pU0+G06/gfvi3BIokZOgmMIvL/JaDu
         DNl3IbBOaY8l1OYEfcE3nxIzHY0gYxPf52lgnpd3lvmiQGurpVZz4w34y7fly+qlLIaL
         XyfmZudnNg5hImXMKcg70YFCCIZITeQi18JeQ0+xuTCZiE6eXYRa4iKYIlPovymRo278
         EHQA==
X-Gm-Message-State: AOAM5315DJ47e6ZXPJI+CsOLCIG8TR5CEEIWmwt5nIh5dcR57roP24fT
        xcITPzTKoqDOPL3uLYk5Qvh+4Q==
X-Google-Smtp-Source: ABdhPJw0sCIj9SGPQi9/3pSeTdjP3tUKlGQY9tYxdh47l36JCwKd/wL2+T5d4l7kWEKYH9l49xhmsg==
X-Received: by 2002:a17:90b:238a:: with SMTP id mr10mr6130742pjb.187.1595612031653;
        Fri, 24 Jul 2020 10:33:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a9sm6938080pfr.103.2020.07.24.10.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 10:33:50 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:33:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Mazin Rezk <mnrzk@protonmail.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sunpeng.li@amd.com, Alexander Deucher <Alexander.Deucher@amd.com>,
        1i5t5.duncan@cox.net, mphantomx@yahoo.com.br,
        regressions@leemhuis.info, anthony.ruhier@gmail.com
Subject: Re: [PATCH] amdgpu_dm: fix nonblocking atomic commit use-after-free
Message-ID: <202007241016.922B094AAA@keescook>
References: <YIGsJ9LlFquvBI2iWPKhJwjKBwDUr_C-38oVpLJJHJ5rDCY_Zrrv392o6UPNxHoeQrcpLYC9U4fZdpD9ilz6Amg2IxkSexGLQMCQIBek8rc=@protonmail.com>
 <202007231524.A24720C@keescook>
 <a86cba0b-4513-e7c3-ae75-bb331433f664@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a86cba0b-4513-e7c3-ae75-bb331433f664@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 09:45:18AM +0200, Paul Menzel wrote:
> Am 24.07.20 um 00:32 schrieb Kees Cook:
> > On Thu, Jul 23, 2020 at 09:10:15PM +0000, Mazin Rezk wrote:
> As Linux 5.8-rc7 is going to be released this Sunday, I wonder, if commit
> 3202fa62f ("slub: relocate freelist pointer to middle of object") should be
> reverted for now to fix the regression for the users according to Linux’ no
> regression policy. Once the AMDGPU/DRM driver issue is fixed, it can be
> reapplied. I know it’s not optimal, but as some testing is going to be
> involved for the fix, I’d argue it’s the best option for the users.

Well, the SLUB defense was already released in v5.7, so I'm not sure it
really helps for amdgpu_dm users seeing it there too. There was a fix to
disable the async path for this driver that worked around the bug too,
yes? That seems like a safer and more focused change that doesn't revert
the SLUB defense for all users, and would actually provide a complete,
I think, workaround whereas reverting the SLUB change means the race
still exists. For example, it would be hit with slab poisoning, etc.

-- 
Kees Cook
