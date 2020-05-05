Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0680BC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E1420746
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgEEOB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:01:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55403 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgEEOB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:01:56 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jVy8s-0000gm-PM; Tue, 05 May 2020 14:01:50 +0000
Date:   Tue, 5 May 2020 16:01:49 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] bitops: avoid clang shift-count-overflow warnings
Message-ID: <20200505140149.lyru5h2zxmkozn75@wittgenstein>
References: <20200505135513.65265-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200505135513.65265-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:54:57PM +0200, Arnd Bergmann wrote:
> Clang normally does not warn about certain issues in inline functions when
> it only happens in an eliminated code path. However if something else
> goes wrong, it does tend to complain about the definition of hweight_long()
> on 32-bit targets:
> 
> include/linux/bitops.h:75:41: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>         return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
>                                                ^~~~~~~~~~~~
> include/asm-generic/bitops/const_hweight.h:29:49: note: expanded from macro 'hweight64'
>  define hweight64(w) (__builtin_constant_p(w) ? __const_hweight64(w) : __arch_hweight64(w))
>                                                 ^~~~~~~~~~~~~~~~~~~~
> include/asm-generic/bitops/const_hweight.h:21:76: note: expanded from macro '__const_hweight64'
>  define __const_hweight64(w) (__const_hweight32(w) + __const_hweight32((w) >> 32))
>                                                                            ^  ~~
> include/asm-generic/bitops/const_hweight.h:20:49: note: expanded from macro '__const_hweight32'
>  define __const_hweight32(w) (__const_hweight16(w) + __const_hweight16((w) >> 16))
>                                                 ^
> include/asm-generic/bitops/const_hweight.h:19:72: note: expanded from macro '__const_hweight16'
>  define __const_hweight16(w) (__const_hweight8(w)  + __const_hweight8((w)  >> 8 ))
>                                                                        ^
> include/asm-generic/bitops/const_hweight.h:12:9: note: expanded from macro '__const_hweight8'
>           (!!((w) & (1ULL << 2))) +     \
> 
> Adding an explicit cast to __u64 avoids that warning and makes it easier
> to read other output.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
