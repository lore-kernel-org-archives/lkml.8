Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBDCC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B752168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvlk7S2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgBNNqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:46:17 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36049 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgBNNqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:46:17 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so9452528oic.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 05:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Z2AWHyN/sOb4PsOQdZpFIB/8+XI9oSRqPBfKZfRwFiU=;
        b=Cvlk7S2k5FNnFaMpydJh39pH3ElahgOrWipX78FuTVFaxf29cfR+obZPVLb1Fn5iqH
         uDLkhVA0jBDmtwTB3X4MSEOHPBJcXLKCErV9jPgOcdyYFHYwQIOqAghL8TvYQvbMz+5+
         +4TZBxiaF5pLh4ecvXXHacUTkln64pBdi1eQAmrGBrxDjg0xOAiGNyXvOFGcvmKG7PVr
         z/5Chh+c761a76kWqwUuerFL9V2FNYwZzYekwLn2pJQhUZr/E3Y+W7Ywdg6GW6YFdg66
         K/YlabYQv5xVqBZYRlwXrSCgLVMw4IV5wqB0dFL5rO2FihwOIBIIJReYPygoq/8pckPK
         9FMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Z2AWHyN/sOb4PsOQdZpFIB/8+XI9oSRqPBfKZfRwFiU=;
        b=lq50tL/k+6fG6E6elXAGJNiQIi/vDGClim41r8hUt5RZ6hF1Ppsr7EzlJFcNMaAkgb
         0yc2wn1r5SLqn4FlG5M7NQyJJtYhsjQ8JnPgFTMgAYOuONZ6NbeJCV3NCMuIvNuxM24a
         Wv7+MZeD4hF7a1dU0befXIiFiPLid09ugB/CnIxJOQn+jFgMG46ShdBd2Bh1o7w1Klc0
         fEq2hUMvb2cKd3cMTJPuuzv2th6KqZvInK4Wqr8CHqbwskeishIkNf0CzRVeGsEIHROy
         K0BXc7tqxzFMfEM4yQZvu6uQy8PmfKZoLSJ0+RXBSoTEnCHRYFxLwwSc66ZEkqTbVqCS
         3Lyg==
X-Gm-Message-State: APjAAAXS3zCEP9dtMHKCIhIdcEwFox3yEE2sLHXvG3oN+7BmjcdFAcHa
        Q8seSSofEKQjURjKFdOmHTA=
X-Google-Smtp-Source: APXvYqzDN8yB/OO+Niqa/er7303KT4elsvbSX2QFbbWCRBEluLHYhvxVws70OxqoDU3dH4uxeKg5Hg==
X-Received: by 2002:aca:4306:: with SMTP id q6mr1922461oia.54.1581687975994;
        Fri, 14 Feb 2020 05:46:15 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id k17sm1885677oic.45.2020.02.14.05.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 05:46:15 -0800 (PST)
Date:   Fri, 14 Feb 2020 06:46:13 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/i915: Cast remain to unsigned long in eb_relocate_vma
Message-ID: <20200214134613.GA41838@ubuntu-m2-xlarge-x86>
References: <20200214054706.33870-1-natechancellor@gmail.com>
 <87v9o965gg.fsf@intel.com>
 <158166913989.4660.10674824117292988120@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <158166913989.4660.10674824117292988120@skylake-alporthouse-com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 08:32:19AM +0000, Chris Wilson wrote:
> Quoting Jani Nikula (2020-02-14 06:36:15)
> > On Thu, 13 Feb 2020, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > A recent commit in clang added -Wtautological-compare to -Wall, which is
> > > enabled for i915 after -Wtautological-compare is disabled for the rest
> > > of the kernel so we see the following warning on x86_64:
> > >
> > >  ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1433:22: warning:
> > >  result of comparison of constant 576460752303423487 with expression of
> > >  type 'unsigned int' is always false
> > >  [-Wtautological-constant-out-of-range-compare]
> > >          if (unlikely(remain > N_RELOC(ULONG_MAX)))
> > >             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> > >  ../include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
> > >  # define unlikely(x)    __builtin_expect(!!(x), 0)
> > >                                             ^
> > >  1 warning generated.
> > >
> > > It is not wrong in the case where ULONG_MAX > UINT_MAX but it does not
> > > account for the case where this file is built for 32-bit x86, where
> > > ULONG_MAX == UINT_MAX and this check is still relevant.
> > >
> > > Cast remain to unsigned long, which keeps the generated code the same
> > > (verified with clang-11 on x86_64 and GCC 9.2.0 on x86 and x86_64) and
> > > the warning is silenced so we can catch more potential issues in the
> > > future.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/778
> > > Suggested-by: Michel Dänzer <michel@daenzer.net>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > 
> > Works for me as a workaround,
> 
> But the whole point was that the compiler could see that it was
> impossible and not emit the code. Doesn't this break that?
> -Chris

As noted in the commit message, I ran diff <(objdump -Dr) <(objdump -Dr)
on objects files compiled with and without the patch with clang and gcc
for x86_64 and gcc for i386 (i386 does not build with clang) and there
was zero difference aside from the file names.

At the end of the day, I do not really care how the warning get fixed,
just that it does since it is the only one on x86_64 defconfig.

Cheers,
Nathan
