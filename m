Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E837C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EDE20716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgC1H6y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 03:58:54 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:57532 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725800AbgC1H6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 03:58:53 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20721407-1500050 
        for multiple; Sat, 28 Mar 2020 07:58:46 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200328000422.98978-1-Jason@zx2c4.com>
References: <20200328000422.98978-1-Jason@zx2c4.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: check to see if the FPU is available before using it
Message-ID: <158538232569.25292.15795048542441478192@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Sat, 28 Mar 2020 07:58:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jason A. Donenfeld (2020-03-28 00:04:22)
> It's not safe to just grab the FPU willy nilly without first checking to
> see if it's available. This patch adds the usual call to may_use_simd()
> and falls back to boring memcpy if it's not available.
 
These instructions do not use the fpu, nor are these registers aliased
over the fpu stack. This description and the may_use_simd() do not
look like they express the right granularity as to which simd state are
included

> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/gpu/drm/i915/i915_memcpy.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/i915_memcpy.c b/drivers/gpu/drm/i915/i915_memcpy.c
> index fdd550405fd3..7c0e022586bc 100644
> --- a/drivers/gpu/drm/i915/i915_memcpy.c
> +++ b/drivers/gpu/drm/i915/i915_memcpy.c
> @@ -24,6 +24,7 @@
>  
>  #include <linux/kernel.h>
>  #include <asm/fpu/api.h>
> +#include <asm/simd.h>
>  
>  #include "i915_memcpy.h"
>  
> @@ -38,6 +39,12 @@ static DEFINE_STATIC_KEY_FALSE(has_movntdqa);
>  #ifdef CONFIG_AS_MOVNTDQA
>  static void __memcpy_ntdqa(void *dst, const void *src, unsigned long len)
>  {
> +       if (unlikely(!may_use_simd())) {
> +               memcpy(dst, src, len);
> +               return;

Look at caller, return the error and let them decide if they can avoid
the read from WC, which quite often they can. And no, this is not done
from interrupt context, we would be crucified if we did.
-Chris
