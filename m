Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB41C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AD6218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="wbteIZ89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgBFPKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:10:08 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:40419 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbgBFPKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:10:06 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id fd6139fb;
        Thu, 6 Feb 2020 15:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=mail; bh=hCSZI3yFG5bI3FQ2aJZ88GjlsbQ=; b=wbteIZ8
        9JNF6qqVmEPpTWwRJW+dLN1smHNE8DAyaTIIIvea+fAlYw8LPoFdsEuOdcL/qTtv
        eZY0n6RAW2Ruh57HeFIIX3rXqWaT6hDmLZpoPKoRig4OKwatJM2S94nhKgmvq8ix
        ZNYFslxrtwwxQtLCEeE+3+noy0RQqTsij91uLugcLsqjmy7ML+GfHhtq/nV5k1AI
        xx6dhqDX7UQVfEo/81on552tZQhAR8BA6LXmhBsusb2DzIurkt+6GYl8K8JU/gF4
        izZk3MHJUYgu3KFYRh1injM9RwX5c9/UF5Dbo5yjSsAB7TuHYyZIyg65q2nzJaHW
        Ssvprkwr+/GhF9g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fe7ef0f8 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 6 Feb 2020 15:08:59 +0000 (UTC)
Date:   Thu, 6 Feb 2020 16:10:01 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        keescook@chromium.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, keescook@chromium.org,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        jeanphilippe.aumasson@gmail.com
Subject: Re: [RFC PATCH 04/11] x86/boot/KASLR: Introduce PRNG for faster
 shuffling
Message-ID: <20200206151001.GA280489@zx2c4.com>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-5-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200205223950.1212394-5-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Kees,

On Wed, Feb 05, 2020 at 02:39:43PM -0800, Kristen Carlson Accardi wrote:
> +#define rot(x, k) (((x)<<(k))|((x)>>(64-(k))))
> +static u64 prng_u64(struct prng_state *x)
> +{
> +	u64 e;
> +
> +	e = x->a - rot(x->b, 7);
> +	x->a = x->b ^ rot(x->c, 13);
> +	x->b = x->c + rot(x->d, 37);
> +	x->c = x->d + e;
> +	x->d = e + x->a;
> +
> +	return x->d;
> +}

I haven't looked closely at where the original entropy sources are
coming from and how all this works, but on first glance, this prng
doesn't look like an especially cryptographically secure one. I realize
that isn't necessarily your intention (you're focused on speed), but
actually might this be sort of important? If I understand correctly, the
objective of this patch set is so that leaking the address of one
function doesn't leak the address of all other functions, as is the case
with fixed-offset kaslr. But if you leak the addresses of _some_ set of
functions, and your prng is bogus, might it be possible to figure out
the rest? For some prngs, if you give me the output stream of a few
numbers, I can predict the rest. For others, it's not this straight
forward, but there are some varieties of similar attacks. If any of that
set of concerns turns out to apply to your prng_u64 here, would that
undermine kaslr in similar ways as the current fixed-offset variety? Or
does it not matter because it's some kind of blinded fixed-size shuffle
with complex reasoning that makes this not a problem?

Jason
