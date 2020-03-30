Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A318C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A79F2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgC3K5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:57:54 -0400
Received: from foss.arm.com ([217.140.110.172]:50134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729374AbgC3K5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:57:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF47A31B;
        Mon, 30 Mar 2020 03:57:52 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 509C83F52E;
        Mon, 30 Mar 2020 03:57:51 -0700 (PDT)
Date:   Mon, 30 Mar 2020 11:57:45 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     George Spelvin <lkml@sdf.org>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v1 44/50] arm64: ptr auth: Use get_random_u64 instead
 of _bytes
Message-ID: <20200330105745.GA1309@C02TD0UTHF1T.local>
References: <202003281643.02SGhOi3016886@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003281643.02SGhOi3016886@sdf.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On Tue, Dec 10, 2019 at 07:15:55AM -0500, George Spelvin wrote:
> Since these are authentication keys, stored in the kernel as long
> as they're important, get_random_u64 is fine.  In particular,
> get_random_bytes has significant per-call overhead, so five
> separate calls is painful.

As I am unaware, how does the cost of get_random_bytes() compare to the
cost of get_random_u64()?

> This ended up being a more extensive change, since the previous
> code was unrolled and 10 calls to get_random_u64() seems excessive.
> So the code was rearranged to have smaller object size.

It's not really "unrolled", but rather "not a loop", so I'd prefer to
not artifially make it look like one.

Could you please quantify the size difference when going from
get_random_bytes() to get_random_u64(), if that is excessive enough to
warrant changing the structure of the code? Otherwise please leave the
structure as-is as given it is much easier to reason about -- suggestion
below on how to do that neatly.

> Currently fields[i] = { 1 << i, 16 * i } for all i could be computed
> rather than looked up, but the table seemed more future-proof.
> 
> For ptrauth_keys_switch(), the MSR instructions must be unrolled and
> are much faster than get_random, so although a similar flags-based
> interface is possible, it's probably not worth it.
> 
> Signed-off-by: George Spelvin <lkml@sdf.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/include/asm/pointer_auth.h | 20 +++++----
>  arch/arm64/kernel/pointer_auth.c      | 62 +++++++++++++++------------
>  2 files changed, 46 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
> index 7a24bad1a58b8..b7ef71362a3ae 100644
> --- a/arch/arm64/include/asm/pointer_auth.h
> +++ b/arch/arm64/include/asm/pointer_auth.h
> @@ -30,17 +30,19 @@ struct ptrauth_keys {
>  	struct ptrauth_key apga;
>  };
>  
> +static inline unsigned long ptrauth_keys_supported(void)
> +{
> +	return (system_supports_address_auth() ?
> +			PR_PAC_APIAKEY | PR_PAC_APIBKEY |
> +			PR_PAC_APDAKEY | PR_PAC_APDBKEY : 0) |
> +	       (system_supports_generic_auth() ? PR_PAC_APGAKEY : 0);
> +}
> +
> +void ptrauth_keys_generate(struct ptrauth_keys *keys, unsigned long flags);
> +
>  static inline void ptrauth_keys_init(struct ptrauth_keys *keys)
>  {
> -	if (system_supports_address_auth()) {
> -		get_random_bytes(&keys->apia, sizeof(keys->apia));
> -		get_random_bytes(&keys->apib, sizeof(keys->apib));
> -		get_random_bytes(&keys->apda, sizeof(keys->apda));
> -		get_random_bytes(&keys->apdb, sizeof(keys->apdb));
> -	}
> -
> -	if (system_supports_generic_auth())
> -		get_random_bytes(&keys->apga, sizeof(keys->apga));
> +	ptrauth_keys_generate(keys, ptrauth_keys_supported());
>  }
>  
>  #define __ptrauth_key_install(k, v)				\
> diff --git a/arch/arm64/kernel/pointer_auth.c b/arch/arm64/kernel/pointer_auth.c
> index c507b584259d0..1604ed246128c 100644
> --- a/arch/arm64/kernel/pointer_auth.c
> +++ b/arch/arm64/kernel/pointer_auth.c
> @@ -7,40 +7,48 @@
>  #include <asm/cpufeature.h>
>  #include <asm/pointer_auth.h>
>  
> +/*
> + * Generating crypto-quality random numbers is expensive enough that
> + * there's no point unrolling this.
> + */
> +void ptrauth_keys_generate(struct ptrauth_keys *keys, unsigned long flags)
> +{
> +	size_t i;
> +	static const struct {
> +		/*
> +		 * 8 bits is enough for now.  Compiler will complain
> +		 * if/when we need more.
> +		 */
> +		unsigned char flag, offset;
> +	} fields[] = {
> +		{ PR_PAC_APIAKEY, offsetof(struct ptrauth_keys, apia) },
> +		{ PR_PAC_APIBKEY, offsetof(struct ptrauth_keys, apib) },
> +		{ PR_PAC_APDAKEY, offsetof(struct ptrauth_keys, apda) },
> +		{ PR_PAC_APDBKEY, offsetof(struct ptrauth_keys, apdb) },
> +		{ PR_PAC_APGAKEY, offsetof(struct ptrauth_keys, apga) }
> +	};
> +
> +	for (i = 0; i < ARRAY_SIZE(fields); i++) {
> +		if (flags & fields[i].flag) {
> +			struct ptrauth_key *k = (void *)keys + fields[i].offset;
> +			k->lo = get_random_u64();
> +			k->hi = get_random_u64();
> +		}
> +	}
> +}

If we must use get_random_u64() in place of get_random_bytes(), please
add a per-key helper and keep the structure largely as-is:

// Note: we can drop inline if there is a real size issue
static inline void __ptrauth_key_init(struct ptrauth_key *key)
{
	key->lo = get_random_u64();
	key->hi = get_random_u64();
}

static inline void ptrauth_keys_init(struct ptrauth_keys *keys)
{
	if (system_supports_address_auth()) {
		__ptrauth_key_init(&keys->apia);
		__ptrauth_key_init(&keys->apib);
		__ptrauth_key_init(&keys->apda);
		__ptrauth_key_init(&keys->apdb);
	}

	if (system_supports_generic_auth())
		__ptrauth_key_init(&keys->apga);
	ptrauth_keys_generate(keys, ptrauth_keys_supported());
}

> +
>  int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg)
>  {
> +	unsigned long supported = ptrauth_keys_supported();
>  	struct ptrauth_keys *keys = &tsk->thread.keys_user;
> -	unsigned long addr_key_mask = PR_PAC_APIAKEY | PR_PAC_APIBKEY |
> -				      PR_PAC_APDAKEY | PR_PAC_APDBKEY;
> -	unsigned long key_mask = addr_key_mask | PR_PAC_APGAKEY;
>  
> -	if (!system_supports_address_auth() && !system_supports_generic_auth())
> +	if (!supported || arg & ~supported)
>  		return -EINVAL;
>  
> -	if (!arg) {
> -		ptrauth_keys_init(keys);
> -		ptrauth_keys_switch(keys);
> -		return 0;
> -	}
> -
> -	if (arg & ~key_mask)
> -		return -EINVAL;
> -
> -	if (((arg & addr_key_mask) && !system_supports_address_auth()) ||
> -	    ((arg & PR_PAC_APGAKEY) && !system_supports_generic_auth()))
> -		return -EINVAL;
> -
> -	if (arg & PR_PAC_APIAKEY)
> -		get_random_bytes(&keys->apia, sizeof(keys->apia));
> -	if (arg & PR_PAC_APIBKEY)
> -		get_random_bytes(&keys->apib, sizeof(keys->apib));
> -	if (arg & PR_PAC_APDAKEY)
> -		get_random_bytes(&keys->apda, sizeof(keys->apda));
> -	if (arg & PR_PAC_APDBKEY)
> -		get_random_bytes(&keys->apdb, sizeof(keys->apdb));
> -	if (arg & PR_PAC_APGAKEY)
> -		get_random_bytes(&keys->apga, sizeof(keys->apga));
> +	if (!arg)
> +		arg = supported;

... and similarly this should only need to change to use
__ptrauth_key_init(), as above.

Thanks,
Mark.

>  
> +	ptrauth_keys_generate(keys, arg);
>  	ptrauth_keys_switch(keys);
>  
>  	return 0;
> -- 
> 2.26.0
> 
