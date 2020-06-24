Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52C7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839C22098B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DBQeiRGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbgFXABo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbgFXABn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 20:01:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B34C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 17:01:42 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 207so33824pfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 17:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bLqWa8D4a1aW1RT9kraxn7fj5TtxyMRknVxZIyfvPbs=;
        b=DBQeiRGu/q1Yt+lss+Q+2dUx4pCfe+ephHr5um4LGMOurwGPtymSQEAhTJ91JQV0bt
         zmf6BHln++YUrrLsbJJuwB9YtNqqpVhnkQ0pNU07Xnc59mjwJtm8T5n09r0XuSo71lbt
         fcTkDrtuJjdDW81JL19V5hkYuKItL4j73afO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bLqWa8D4a1aW1RT9kraxn7fj5TtxyMRknVxZIyfvPbs=;
        b=PUOsGLSiUMBcl1NiZSXjmtLXE2CX++QDFtozlKG4WDpbRWk89OhCJz+cuBAWNuOIEn
         dDjvJUvZgtLW0cS6GO/KOoAh0QscTgFdybbuJLaD/SthqRtcDHcAB2B3UKUrzZ/rZUZ5
         tyE+h56lRwlQPXJoyNVWUw1QPNflaeQZGIBlBbvyRTrdFDRQme7+J/p4MNyGAsVwGVB/
         WAV0iTvcR9iBAZZ/Y2A+1auIDa+1OvTUp/iTlTjDnEBmvfwohcx07b42FWNOxjA/kSWa
         DOz802BxRwgSB0MejUpKGAR72XuSi7lFM0X0NpXGDWlXMHvXiySkyq45CT1Y/ppHEEp4
         F9Hw==
X-Gm-Message-State: AOAM533D2ZovjPuJKiEY8i0CJ2+fducMKpdbvj8V67ODJVUCAyDIPldF
        8V6aU3R2KVeRQ1/MiLiQVAAopw==
X-Google-Smtp-Source: ABdhPJwBxv8t7/01Ji74nGYpd4derLxt90CEgi39v4a5aHoq6nRlRjy+Rm7SzqsfF6j2yT8sZcQ3lA==
X-Received: by 2002:a62:1a87:: with SMTP id a129mr26864467pfa.95.1592956901676;
        Tue, 23 Jun 2020 17:01:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jz23sm3378905pjb.2.2020.06.23.17.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 17:01:40 -0700 (PDT)
Date:   Tue, 23 Jun 2020 17:01:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
Message-ID: <202006231701.DACC6F2C9@keescook>
References: <20200529200347.2464284-1-keescook@chromium.org>
 <202006231610.4993DC5@keescook>
 <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 04:32:12PM -0700, Randy Dunlap wrote:
> On 6/23/20 4:10 PM, Kees Cook wrote:
> > On Fri, May 29, 2020 at 01:03:43PM -0700, Kees Cook wrote:
> >> Hi Greg,
> >>
> >> Can you please apply these patches to your drivers/misc tree for LKDTM?
> >> It's mostly a collection of fixes and improvements and tweaks to the
> >> selftest integration.
> > 
> > Friendly ping -- we're past -rc2 now. :)
> > 
> > Thanks!
> > 
> > -Kees
> > 
> >>
> >> Thanks!
> >>
> >> -Kees
> >>
> >> Kees Cook (4):
> >>   lkdtm: Avoid more compiler optimizations for bad writes
> >>   lkdtm/heap: Avoid edge and middle of slabs
> >>   selftests/lkdtm: Reset WARN_ONCE to avoid false negatives
> >>   lkdtm: Make arch-specific tests always available
> >>
> >>  drivers/misc/lkdtm/bugs.c               | 45 +++++++++++++------------
> >>  drivers/misc/lkdtm/heap.c               |  9 ++---
> >>  drivers/misc/lkdtm/lkdtm.h              |  2 --
> >>  drivers/misc/lkdtm/perms.c              | 22 ++++++++----
> >>  drivers/misc/lkdtm/usercopy.c           |  7 ++--
> >>  tools/testing/selftests/lkdtm/run.sh    |  6 ++++
> >>  tools/testing/selftests/lkdtm/tests.txt |  1 +
> >>  7 files changed, 56 insertions(+), 36 deletions(-)
> >>
> >> -- 
> >> 2.25.1
> >>
> > 
> 
> >> Regardless, it seems arch/x86/um/asm/desc.h is not needed any more?
> 
> > True that, we can rip the file.
> 
> Has anyone fixed the uml build errors?

Oh, I thought that had nothing to do with the lkdtm changes? Should I
rip out that file and resend?

-- 
Kees Cook
