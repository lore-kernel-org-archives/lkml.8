Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53A8C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C57720873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgBNIch convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:32:37 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:57308 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725897AbgBNIcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:32:36 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20220168-1500050 
        for multiple; Fri, 14 Feb 2020 08:32:23 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <87v9o965gg.fsf@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        =?utf-8?q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
References: <20200214054706.33870-1-natechancellor@gmail.com> <87v9o965gg.fsf@intel.com>
Message-ID: <158166913989.4660.10674824117292988120@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: Cast remain to unsigned long in eb_relocate_vma
Date:   Fri, 14 Feb 2020 08:32:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jani Nikula (2020-02-14 06:36:15)
> On Thu, 13 Feb 2020, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > A recent commit in clang added -Wtautological-compare to -Wall, which is
> > enabled for i915 after -Wtautological-compare is disabled for the rest
> > of the kernel so we see the following warning on x86_64:
> >
> >  ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1433:22: warning:
> >  result of comparison of constant 576460752303423487 with expression of
> >  type 'unsigned int' is always false
> >  [-Wtautological-constant-out-of-range-compare]
> >          if (unlikely(remain > N_RELOC(ULONG_MAX)))
> >             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> >  ../include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
> >  # define unlikely(x)    __builtin_expect(!!(x), 0)
> >                                             ^
> >  1 warning generated.
> >
> > It is not wrong in the case where ULONG_MAX > UINT_MAX but it does not
> > account for the case where this file is built for 32-bit x86, where
> > ULONG_MAX == UINT_MAX and this check is still relevant.
> >
> > Cast remain to unsigned long, which keeps the generated code the same
> > (verified with clang-11 on x86_64 and GCC 9.2.0 on x86 and x86_64) and
> > the warning is silenced so we can catch more potential issues in the
> > future.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/778
> > Suggested-by: Michel Dänzer <michel@daenzer.net>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Works for me as a workaround,

But the whole point was that the compiler could see that it was
impossible and not emit the code. Doesn't this break that?
-Chris
