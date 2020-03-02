Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0E5C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A86720848
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GjfdZfC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgCBWhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:37:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43853 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCBWht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:37:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id u12so512811pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 14:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vMvtD7yXrueh3vfUHlByM8qY7eCzHyinRu2E+qXaOss=;
        b=GjfdZfC1QiuMpLpPsnZEuquo4oHOa6dHmIj6OqZDUbNT7AclNTgp0O4svXm4SryVJt
         Olz68E/9hj1IIa7jv4bNLsvw2rAtQJ7hTpi0ZlT45hPzFXva4B3s2ep3nII4TGhQndrc
         lRyYcirIVSu4/s+87HgtYyVQvIRweobi5fik8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vMvtD7yXrueh3vfUHlByM8qY7eCzHyinRu2E+qXaOss=;
        b=LResKU0G8tIrEoiEHqtD6iwh+lYNToPXD2r2BxKgxQrjuH4jarNawKDYAbw3kFzeD7
         rKgdvvh55WU1lHT/xCuAuhezf8bod3rDvPSx2Nos+yj1XL/jPZCJlw7f5WdYDknIKfNG
         ba4EqSJoc/IKPunyoCyJQmwu72l1RxfVQDjDSFV+0r8c9M+vb/OemfYh/Tv77tteHPYR
         LTsAA9y85tqjMgf2cnF70YLsIKOGSnIpp0ih6fspn2GSq0HFaQzXJ7spIUg0/2fvWcfR
         1lCy9hDfgfy5tYeJ55VGSLWGVAFJmcWdGo8ej5fcn8nsS6CytTBZk+a2M47JSGsqRKN1
         Gang==
X-Gm-Message-State: ANhLgQ02StqEAR4odXr/slmsgEYt/54rtgNd3tjq8UnLA752BFz1Ofyf
        aSExGJblXNQJtS3TqKzwqKrxug==
X-Google-Smtp-Source: ADFU+vu+LBEKzP0lHq5FZPqaf5eomvXFSkF432SpPtfLA/ZzVKEhYND7T51KsXHbjKA27j0gEiLnKQ==
X-Received: by 2002:a63:564d:: with SMTP id g13mr1025563pgm.157.1583188668690;
        Mon, 02 Mar 2020 14:37:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x62sm5061386pfc.175.2020.03.02.14.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 14:37:47 -0800 (PST)
Date:   Mon, 2 Mar 2020 14:37:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH] lib/refcount: Document interaction with PID_MAX_LIMIT
Message-ID: <202003021434.713F5559@keescook>
References: <20200302195352.226103-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302195352.226103-1-jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 08:53:52PM +0100, Jann Horn wrote:
> Document the circumstances under which refcount_t's saturation mechanism
> works deterministically.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

With one note below...

> ---
>  include/linux/refcount.h | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index 0ac50cf62d062..cf14db393d89d 100644
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -38,11 +38,20 @@
>   * atomic operations, then the count will continue to edge closer to 0. If it
>   * reaches a value of 1 before /any/ of the threads reset it to the saturated
>   * value, then a concurrent refcount_dec_and_test() may erroneously free the
> - * underlying object. Given the precise timing details involved with the
> - * round-robin scheduling of each thread manipulating the refcount and the need
> - * to hit the race multiple times in succession, there doesn't appear to be a
> - * practical avenue of attack even if using refcount_add() operations with
> - * larger increments.
> + * underlying object.
> + * Linux limits the maximum number of tasks to PID_MAX_LIMIT, which is currently
> + * 0x400000 (and can't easily be raised in the future beyond FUTEX_TID_MASK).

Maybe just to clarify and make readers not have to go search the source:

	"... beyond FUTEX_TID_MASK, which is UAPI defined as 0x3fffffff)."

and is it worth showing the math on this, just to have it clearly
stated?

-Kees

> + * With the current PID limit, if no batched refcounting operations are used and
> + * the attacker can't repeatedly trigger kernel oopses in the middle of refcount
> + * operations, this makes it impossible for a saturated refcount to leave the
> + * saturation range, even if it is possible for multiple uses of the same
> + * refcount to nest in the context of a single task.
> + * If hundreds of references are added/removed with a single refcounting
> + * operation, it may potentially be possible to leave the saturation range; but
> + * given the precise timing details involved with the round-robin scheduling of
> + * each thread manipulating the refcount and the need to hit the race multiple
> + * times in succession, there doesn't appear to be a practical avenue of attack
> + * even if using refcount_add() operations with larger increments.
>   *
>   * Memory ordering
>   * ===============
> 
> base-commit: 98d54f81e36ba3bf92172791eba5ca5bd813989b
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 

-- 
Kees Cook
