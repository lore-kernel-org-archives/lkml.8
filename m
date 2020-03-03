Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635DAC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F2C208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y7yyoZEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgCCNHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:07:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51248 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgCCNHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:07:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id a132so3105169wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 05:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vS+hCXJAKRmx8Dc5B7DWkwttpDrd7EUzO0LUB6S40pg=;
        b=y7yyoZEittWnefLa9L+2ZrRgX4Tn0/G3wmR6sXtwtEYMlGF8xl8PFwuDjvsIX6ryLU
         IVskjhMSWt4dW2Yu/MVc97aQ2kBHkWCqSRboKvgIL9dk9Iewks1cQIRxBpDtAbZ4vxh/
         Xaw9Ua2N7tl6NEm0VuEKFZzHz8Uj4Kg4FWBEY0+YIBUor7PdCWqpShCefsEqQKPT9oms
         DDJAv2kfS/Z6gDtezlNfggGwgQxcDFzMyjUrt/ZiEGZTyvAzmZIV1yfy4OgwDxxRAByJ
         cWMqdU0/dmXzTRkXWbtn1r6ZcP+9CjwNQT1Ia9X4KxInckq0H5rBMtpVhXLgWb3+ZneE
         9uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vS+hCXJAKRmx8Dc5B7DWkwttpDrd7EUzO0LUB6S40pg=;
        b=QV1bC9ChYzaEdE8NC0eavoFCOoIv6hnwDhlaoYnvTVRZTa7FrksIpLPApIN2+NoO9/
         mV/VLNXONvFBK1folgGlOavGbPAz4YyY97KtKnGwGLFFVX5cLBZyZiYxbYonGfRzVPwY
         peWejNRZ8rGCL3UStpwsvay5Sd6Fz1sbmh3MNBcpgbq6ELcyj5o7iksZeCJ6d3oOPCe7
         OqK5qzS3q1DuK6doxf4s/TG/gfi86asrJk8IlVnGzsUAM2ffcsjRrJv78UYiu7ISQRJj
         jhRqHjuxncwHbWDcg7qdR2dwaRfqzoxvxGWp0DmurYCmf5Vs6L15VtUMmSgJpbqZa4+y
         IP8Q==
X-Gm-Message-State: ANhLgQ1/SnJBejKgde4u1/LrxKL5xv8Tyj1uYl4bQvFxWHoBmY14biw6
        bxE2I9ghOVVPbVL7xEDV4kF7FDbeJKUCSP5sClT9Ait63fPdtw==
X-Google-Smtp-Source: ADFU+vsetjZL61ql8TOtpHMZM0YU6s8pDcmrNZqkairc34pGuEzC87FSzTvEReIej6jBHzzKzSN06rVr8DMlCNBTd2w=
X-Received: by 2002:a1c:2d88:: with SMTP id t130mr4588112wmt.68.1583240842267;
 Tue, 03 Mar 2020 05:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20200303105427.260620-1-jannh@google.com>
In-Reply-To: <20200303105427.260620-1-jannh@google.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 3 Mar 2020 14:07:11 +0100
Message-ID: <CAKv+Gu82eEpZFz5Qto+BnKifM4duv8sBTx3YhLXU8ZPPsND+Rg@mail.gmail.com>
Subject: Re: [PATCH v2] lib/refcount: Document interaction with PID_MAX_LIMIT
To:     Jann Horn <jannh@google.com>
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 at 11:54, Jann Horn <jannh@google.com> wrote:
>
> Document the circumstances under which refcount_t's saturation mechanism
> works deterministically.
>
> Signed-off-by: Jann Horn <jannh@google.com>

I /think/ the main point of Kees's suggestion was that FUTEX_TID_MASK
is UAPI, so unlikely to change.


> ---
>
> Notes:
>     v2:
>      - write down the math (Kees)
>
>  include/linux/refcount.h | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index 0ac50cf62d062..0e3ee25eb156a 100644
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -38,11 +38,24 @@
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
> + * With the current PID limit, if no batched refcounting operations are used and
> + * the attacker can't repeatedly trigger kernel oopses in the middle of refcount
> + * operations, this makes it impossible for a saturated refcount to leave the
> + * saturation range, even if it is possible for multiple uses of the same
> + * refcount to nest in the context of a single task:
> + *
> + *     (UINT_MAX+1-REFCOUNT_SATURATED) / PID_MAX_LIMIT =
> + *     0x40000000 / 0x400000 = 0x100 = 256
> + *
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
