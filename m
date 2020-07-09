Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67A2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C318220663
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 05:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tvlbnc6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgGIFnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 01:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgGIFnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 01:43:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BAAC08C5CE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 22:43:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so374446plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 22:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Njmc1vyPe75JslBINheBTnA8lemCls4rpnddifbo0bM=;
        b=Tvlbnc6MDGfSfqeM/smYqpc0feAlERrwBiblUCBtKfK+it2lz045dBNfFnJEu0fzPE
         Zs72nVW0drH2HES6CA6ikXmAaLcxcpgGm66YqbDh53Aq6l2mjMgqSjki6gsO/mhmobGV
         WMxSlbeRt/Jip07ibeC/Q3b17ZuehPlBLDyFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Njmc1vyPe75JslBINheBTnA8lemCls4rpnddifbo0bM=;
        b=b/J/2kD62Jr3GvHkKfaOsPVDcmWdzETk/Rw3Q8QKRHw37y/xHRrmSuIhNGbXX5SQgw
         asApruLW3ZuetDjyUSFFjlIL1URAHz7KHDdmV9ursxxtWPj+I0IDLSnbZIPhrE2xnji5
         yEs0IYqJ/4tP0Tl8KeU4Z/3etbCuJGYugjrnrJqHyqL3fGc8b/OLnZtQTSuK6dvcgsZq
         /2Ky/T3uxVre90wWDcRX8zhwCwVKIBWLe5J3O8ypHk0zArlcBYc6FYssCRhiA+RDTMsA
         7mCRT4KYLjZKi0hglpb4/3fj6G7npZiQkxpkO1tiW2TDWQPGooQnjL6Hx3HQBLwGs7/w
         BG+g==
X-Gm-Message-State: AOAM533C7cj7lxVm0bccPMHbHSzsocW/GBIUg+wOLs7+a+KXuFpB8OQn
        sTqwaJ4UgPnrCQIwgNSUtmW48A==
X-Google-Smtp-Source: ABdhPJwFCs3gNneJ3e5IhDAi3UVeMslNSOmLd6gGIwVLwQJArIjnjDf2nsIP2hKka3h5Q4fhILGSDw==
X-Received: by 2002:a17:90a:e618:: with SMTP id j24mr12895872pjy.41.1594273400806;
        Wed, 08 Jul 2020 22:43:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t5sm1431481pgl.38.2020.07.08.22.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 22:43:19 -0700 (PDT)
Date:   Wed, 8 Jul 2020 22:43:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Jian Cai <jiancai@google.com>,
        Luis Lozano <llozano@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] vmlinux.lds: add PGO and AutoFDO input sections
Message-ID: <202007082240.815932C2@keescook>
References: <20200622231536.7jcshis5mdn3vr54@google.com>
 <20200625184752.73095-1-ndesaulniers@google.com>
 <CAKwvOd=cum+BNHOk2djXx5JtAcCBwq2Bxy=j5ucRd2RcLWwDZQ@mail.gmail.com>
 <CAK8P3a1mBCC=hBMzxZVukHhrWhv=LiPOfV6Mgnw1QpNg=MpONg@mail.gmail.com>
 <202007020856.78DDE23F4A@keescook>
 <CAKwvOd=NeOodb=ebbodd278=ErRSmPxFNVABQS3ZO=D00yFWGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=NeOodb=ebbodd278=ErRSmPxFNVABQS3ZO=D00yFWGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 04:13:54PM -0700, Nick Desaulniers wrote:
> On Thu, Jul 2, 2020 at 8:57 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > This looks good to me. Do you want me to carry it as part of the orphan
> > series? (It doesn't look like it'll collide, so that's not needed, but I
> > can if that makes things easier.)
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> 
> If you would be so kind, I'd owe you yet another beer!

Yup! It's on my list; I've been clearing other stuff so I can do another
revision. (I want to move some things out of discard and into 0-size
asserts, and possibly collect Arvind's runtime relocations series too
(since it seems basically done but no x86 maintainers have snagged it).

-- 
Kees Cook
