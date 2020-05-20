Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCAEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B2D20708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PWEbg5o8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgETBH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgETBH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:07:27 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC0BC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 18:07:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cx22so487642pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 18:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lG3a8U8tELpoem/GKo/e09JaApoUoFBNqjTmoRhBoMw=;
        b=PWEbg5o8Exmjn8WdgGJo+PugSjKgU2C6C/mB2VOx4WMUDJRjEpKs4LOK1RNhXFuzzw
         SlOARwxds1cyL6BD4X/2vOEgTJrOo1fv0TEjs+hzxcSohFdSJc9Iv1qvK5ixd8HXGNJE
         deD7gwPIXQYbheNTHFSyb/JhgDUlNM/QrAJYuhXGUFQBWNKjZLIMTs76etqjAPEY5b0+
         /JeIsCGZuZuVAtcg4VK2qcmgvR8mEzLY2Xg8UDa5ceKBw368IWAKMiG1DuBL7G/pEATS
         /w/GUvepCfhp44seoF7kzTJk4RxJvebd/Q8F0zrP1xL0QpG/e+F0hkAZn07rXrU0UGX0
         Phkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lG3a8U8tELpoem/GKo/e09JaApoUoFBNqjTmoRhBoMw=;
        b=k5m0Z32XRtsyW2SQ13yO1uTAx2/2JE7q58DRltwshEsf7dAYILGKFP9/Jf/qvP8SeB
         BztLOR82D0UTvPZzkY5ay2yVKJhArbaTs1KjS3aP8xQwDnIJ0glEnkccVhpUQfo31+/7
         GIXRuD0qjQL21/zrzAMFZ3oLbKsq4mBDf0pEyk6/rmgp2VWz9ve1y0Qt9jnC95UdKvix
         8T8uGQBWEFlnc4cd6Gysk3yjBKiNVdHxhT4PJu/nE4HRSOGxXVN2nCsesiiumcogFFSx
         mWFhYYpo6BjQ+NkLa64/sYth0/pXowoYhvzp1G8N/1U4jqMDjp7GikgI3fz6Q42UkUec
         F3Dg==
X-Gm-Message-State: AOAM531AyhRgbV+l2mBt6SSgOAa88yn7v7Qx5LeOa4A8w1vu3Sf0LBsS
        rgJZuX8cacwEnciplwAq7PK4kfgFG9k0o3IS3hQ2fA==
X-Google-Smtp-Source: ABdhPJwJ2RcxkgDBmERSr1ZGbheVeiWNRHSFtZrHCmg4r+GdFs1mew4TvQ9HXWSVX0NGGPD3QR91+TMW08X5u5G+7TY=
X-Received: by 2002:a17:90a:2a4a:: with SMTP id d10mr2434484pjg.32.1589936846245;
 Tue, 19 May 2020 18:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <202005200123.gFjGzJEH%lkp@intel.com> <20200519205505.GD444@zn.tnic>
 <20200519212541.GA3580016@ubuntu-s3-xlarge-x86> <CAKwvOdk+JwddxLaXc9S7SMMTye8bDaGEckcs7zu5tEMD0G3Yog@mail.gmail.com>
 <831EE4E5E37DCC428EB295A351E6624952648ACF@shsmsx102.ccr.corp.intel.com>
 <CAKwvOdmoA5ZFCiUQ5fVf7+970Y4bxvU=kYWb49NENQzxdm7F1Q@mail.gmail.com> <20200520005218.GA3101@intel.com>
In-Reply-To: <20200520005218.GA3101@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 May 2020 18:07:14 -0700
Message-ID: <CAKwvOdkPW2p-4fDUNT6so3DrxiJgtUNEFPJcHNf7VROozc4wjQ@mail.gmail.com>
Subject: Re: [tip:x86/mm 1/23] arch/x86/mm/init.c:75:6: warning: no previous
 prototype for function 'x86_has_pat_wp'
To:     Philip Li <philip.li@intel.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@alien8.de>, lkp <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 5:53 PM Philip Li <philip.li@intel.com> wrote:
>
> On Tue, May 19, 2020 at 05:26:18PM -0700, Nick Desaulniers wrote:
> > I think having in the top of the warning that this is a W=1 build will
> > make it more obvious.
> >
> > I get that -Wmissing-prototypes can be noisy, but it's trivial to fix.
> > I do worry what other warnings lurk in W=1 though...
> with some monitoring, so far, issue like unused-but-set-variable is quite
> helpful. We will keep monitor for other issues and feedbacks.

Hey, I'm always happy to see more warnings turned on.  In our
experience, we had to get a sense of how many instances of a newly
enabled warning there are, and estimate how much time it would take to
fix them all.  It's further complicated by the fix going into
different maintainers' trees and reaching mainline at different points
in time, while regressions continue to sneak in until the warning is
enabled.

It may be time to consider "promoting" some warnings from W=1 to be on
by default.  But that takes careful manual review and estimation of
the work involved.  Turning on W=1 may be blasting people with a lot
of new warnings, but if developers treat them with the same respect as
the default enabled ones for Kbuild then I'm not complaining.
-- 
Thanks,
~Nick Desaulniers
