Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0274C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7159220738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584484045;
	bh=WSXaZv4sBHYHlVj8zTa5shxvXfP6CX+7XiIDcketcUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dr8dTg+AEkl4eSFNyrcGJ8I1kpFNAc4DgS32ptypxu8AANAYdSzO7tvrjYqMl1YZF
	 JArsW0we6wGj4uMm9SwpkelasT5Z2D3PlM/iYGrSGQf+U19GXtFgYtNli+BB7JTKL7
	 c6inZ/WSv492IROGqPeQNQz7w/wFP16RzawS+OyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgCQW1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgCQW1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:27:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2AE9206EC;
        Tue, 17 Mar 2020 22:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584484043;
        bh=WSXaZv4sBHYHlVj8zTa5shxvXfP6CX+7XiIDcketcUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2CQnmxeeLHsCdzqgtAmSYikJb9AbHGeb/jxXXqzH4ZEKKagjBEK/gOiAdnVkUX/Pu
         7fV8BVw9jfyrQVgpnp2pEZqG9Z5RJbm3HNoA5K/FJW3KwxhlmslXzqu3Cx33OpW0rA
         NElFjXRUwEy7KPEtGrYSnZxe6FglFSIdfyAQl+Ao=
Date:   Tue, 17 Mar 2020 22:27:18 +0000
From:   Will Deacon <will@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v2] lib/refcount: Document interaction with PID_MAX_LIMIT
Message-ID: <20200317222717.GF20788@willie-the-truck>
References: <20200303105427.260620-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303105427.260620-1-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 11:54:27AM +0100, Jann Horn wrote:
> Document the circumstances under which refcount_t's saturation mechanism
> works deterministically.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
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

Acked-by: Will Deacon <will@kernel.org>

Peter -- would you be able to take this through -tip, please?

Will
