Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E910C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213A5204EA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4+Z4CDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHXUjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXUje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:39:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7683AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 13:39:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i13so58265pjv.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 13:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VT4X8mepvbrv0KJBt9O6SJE5A3FxGlwUp6omCafz5Qk=;
        b=F4+Z4CDKA53nHZqz+zjw4b8dRuZDyyrEr3ZGpDtzlpJ8RqjO0nSEJw0C3/oId03Rv2
         D6eXsLcEyx7JWNG3FDNXOXZYHWePiuDSUtx2H1w/+sRR9J8SrKDZrNsd7c0lCIvPMnFC
         4nZ7KKbaKqwVgEQC/VyVYjZbJ3UKu3QeXHqwHLZPVJDNtqbGF3CRBpnNqzALV8E/Ex0g
         LVrt9LqNGj1vv1qX8WIRNNqXljOjsEi6mV6FTISAzuqwtZTClPmqnaatfKKoaDaha8E9
         T6VZOMn37OEkv8so9x8H1sL0luBkz1XngYitR+qRR+Hm3iBXFU0p2+6jcg4/opGvbF15
         pwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VT4X8mepvbrv0KJBt9O6SJE5A3FxGlwUp6omCafz5Qk=;
        b=LApIZDvmvUvcZyDOSt1i9VSvLNJ0aIvEb+nlZBUuQewkH9sGwTtENZgEmUFO6gaWHz
         9+0F87WrRMnfjTewzlk1nQxvSkEkul0Jjk7mt1pf1s+GOLI2M69Di9RVOG7Ufi7MdHKy
         QTWl62AuKd7yFJsWxU9Q3QlEtfQns4KDIi7684H9148uX21LdmPxmjDv2mNXttKKkSq9
         1sAArKjD5+8/Oyzx3sMuWZBTAXzbZwTNciShjnDqEcTbfoiagJ5g0rHSKwCSKl1UKQTG
         +5EHzi3rr9Jc6gzOzl+rzAlQiEZRftVIj1RvX8MqoQYv9WOvrdsqtLEb/zr//yUQF6nk
         b0bQ==
X-Gm-Message-State: AOAM530nCrg0FXe/dVxfm9YgU0iV+B7sNhGj4rokY53vhloQ3TTTDcYN
        gq55/9WtLwgVXo2d9T/SCM4=
X-Google-Smtp-Source: ABdhPJxIh3Oe+4pUZ6pOVsNwOxTbvGjfd9ZjxysjN6ewY3Zk3y6Xbq6Wd26w52cFgYBdCcXjqmqajQ==
X-Received: by 2002:a17:90a:6a8d:: with SMTP id u13mr789536pjj.166.1598301573720;
        Mon, 24 Aug 2020 13:39:33 -0700 (PDT)
Received: from Ryzen-9-3900X.localdomain ([89.46.114.92])
        by smtp.gmail.com with ESMTPSA id 8sm413491pjx.14.2020.08.24.13.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 13:39:33 -0700 (PDT)
Date:   Mon, 24 Aug 2020 13:39:29 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] lib: Revert use of fallthrough pseudo-keyword in lib/
Message-ID: <20200824203929.GA606@Ryzen-9-3900X.localdomain>
References: <20200824203614.GA28543@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824203614.GA28543@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 03:36:14PM -0500, Gustavo A. R. Silva wrote:
> The following build error for powerpc64 was reported by Nathan Chancellor:
> 
> "$ scripts/config --file arch/powerpc/configs/powernv_defconfig -e KERNEL_XZ
> 
> $ make -skj"$(nproc)" ARCH=powerpc CROSS_COMPILE=powerpc64le-linux- distclean powernv_defconfig zImage
> ...
> In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:234,
>                  from arch/powerpc/boot/decompress.c:38:
> arch/powerpc/boot/../../../lib/xz/xz_dec_stream.c: In function 'dec_main':
> arch/powerpc/boot/../../../lib/xz/xz_dec_stream.c:586:4: error: 'fallthrough' undeclared (first use in this function)
>   586 |    fallthrough;
>       |    ^~~~~~~~~~~
> arch/powerpc/boot/../../../lib/xz/xz_dec_stream.c:586:4: note: each undeclared identifier is reported only once for each function it appears in
> In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:235,
>                  from arch/powerpc/boot/decompress.c:38:
> arch/powerpc/boot/../../../lib/xz/xz_dec_lzma2.c: In function 'xz_dec_lzma2_run':
> arch/powerpc/boot/../../../lib/xz/xz_dec_lzma2.c:1046:4: error: 'fallthrough' undeclared (first use in this function)
>  1046 |    fallthrough;
>       |    ^~~~~~~~~~~
> make[2]: *** [arch/powerpc/boot/Makefile:215: arch/powerpc/boot/decompress.o] Error 1
> make[2]: Target 'arch/powerpc/boot/zImage' not remade because of errors.
> make[1]: *** [arch/powerpc/Makefile:295: zImage] Error 2
> make: *** [Makefile:335: __build_one_by_one] Error 2
> make: Target 'distclean' not remade because of errors.
> make: Target 'powernv_defconfig' not remade because of errors.
> make: Target 'zImage' not remade because of errors.
> 
> This will end up affecting distribution configurations such as Debian
> and OpenSUSE according to my testing. I am not sure what the solution
> is, the PowerPC wrapper does not set -D__KERNEL__ so I am not sure that
> compiler_attributes.h can be safely included."
> 
> In order to avoid these sort of problems, it seems that the best
> solution is to use /* fall through */ comments instead of the
> fallthrough pseudo-keyword macro in lib/, for now.
> 
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Fixes: df561f6688fe ("treewide: Use fallthrough pseudo-keyword")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  lib/asn1_decoder.c      |  4 ++--
>  lib/assoc_array.c       |  2 +-
>  lib/bootconfig.c        |  4 ++--
>  lib/cmdline.c           | 10 +++++-----
>  lib/dim/net_dim.c       |  2 +-
>  lib/dim/rdma_dim.c      |  4 ++--
>  lib/glob.c              |  2 +-
>  lib/siphash.c           | 36 ++++++++++++++++++------------------
>  lib/ts_fsm.c            |  2 +-
>  lib/vsprintf.c          | 14 +++++++-------
>  lib/xz/xz_dec_lzma2.c   |  4 ++--
>  lib/xz/xz_dec_stream.c  | 16 ++++++++--------
>  lib/zstd/bitstream.h    | 10 +++++-----
>  lib/zstd/compress.c     |  2 +-
>  lib/zstd/decompress.c   | 12 ++++++------
>  lib/zstd/huf_compress.c |  4 ++--
>  16 files changed, 64 insertions(+), 64 deletions(-)
> 
> diff --git a/lib/asn1_decoder.c b/lib/asn1_decoder.c
> index 13da529e2e72..58f72b25f8e9 100644
> --- a/lib/asn1_decoder.c
> +++ b/lib/asn1_decoder.c
> @@ -381,7 +381,7 @@ int asn1_ber_decoder(const struct asn1_decoder *decoder,
>  	case ASN1_OP_END_SET_ACT:
>  		if (unlikely(!(flags & FLAG_MATCHED)))
>  			goto tag_mismatch;
> -		fallthrough;
> +		/* fall through */
>  
>  	case ASN1_OP_END_SEQ:
>  	case ASN1_OP_END_SET_OF:
> @@ -448,7 +448,7 @@ int asn1_ber_decoder(const struct asn1_decoder *decoder,
>  			pc += asn1_op_lengths[op];
>  			goto next_op;
>  		}
> -		fallthrough;
> +		/* fall through */
>  
>  	case ASN1_OP_ACT:
>  		ret = actions[machine[pc + 1]](context, hdr, tag, data + tdp, len);
> diff --git a/lib/assoc_array.c b/lib/assoc_array.c
> index 04c98799c3ba..6f4bcf524554 100644
> --- a/lib/assoc_array.c
> +++ b/lib/assoc_array.c
> @@ -1113,7 +1113,7 @@ struct assoc_array_edit *assoc_array_delete(struct assoc_array *array,
>  						index_key))
>  				goto found_leaf;
>  		}
> -		fallthrough;
> +		/* fall through */
>  	case assoc_array_walk_tree_empty:
>  	case assoc_array_walk_found_wrong_shortcut:
>  	default:
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 1b5de2a45b27..2c905a91d4eb 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -817,7 +817,7 @@ int __init xbc_init(char *buf, const char **emsg, int *epos)
>  							q - 2);
>  				break;
>  			}
> -			fallthrough;
> +			/* fall through */
>  		case '=':
>  			ret = xbc_parse_kv(&p, q, c);
>  			break;
> @@ -826,7 +826,7 @@ int __init xbc_init(char *buf, const char **emsg, int *epos)
>  			break;
>  		case '#':
>  			q = skip_comment(q);
> -			fallthrough;
> +			/* fall through */
>  		case ';':
>  		case '\n':
>  			ret = xbc_parse_key(&p, q);
> diff --git a/lib/cmdline.c b/lib/cmdline.c
> index 55768b4f3f58..fbb9981a04a4 100644
> --- a/lib/cmdline.c
> +++ b/lib/cmdline.c
> @@ -132,23 +132,23 @@ unsigned long long memparse(const char *ptr, char **retptr)
>  	case 'E':
>  	case 'e':
>  		ret <<= 10;
> -		fallthrough;
> +		/* fall through */
>  	case 'P':
>  	case 'p':
>  		ret <<= 10;
> -		fallthrough;
> +		/* fall through */
>  	case 'T':
>  	case 't':
>  		ret <<= 10;
> -		fallthrough;
> +		/* fall through */
>  	case 'G':
>  	case 'g':
>  		ret <<= 10;
> -		fallthrough;
> +		/* fall through */
>  	case 'M':
>  	case 'm':
>  		ret <<= 10;
> -		fallthrough;
> +		/* fall through */
>  	case 'K':
>  	case 'k':
>  		ret <<= 10;
> diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
> index 06811d866775..a4db51c21266 100644
> --- a/lib/dim/net_dim.c
> +++ b/lib/dim/net_dim.c
> @@ -233,7 +233,7 @@ void net_dim(struct dim *dim, struct dim_sample end_sample)
>  			schedule_work(&dim->work);
>  			break;
>  		}
> -		fallthrough;
> +		/* fall through */
>  	case DIM_START_MEASURE:
>  		dim_update_sample(end_sample.event_ctr, end_sample.pkt_ctr,
>  				  end_sample.byte_ctr, &dim->start_sample);
> diff --git a/lib/dim/rdma_dim.c b/lib/dim/rdma_dim.c
> index 15462d54758d..f7e26c7b4749 100644
> --- a/lib/dim/rdma_dim.c
> +++ b/lib/dim/rdma_dim.c
> @@ -59,7 +59,7 @@ static bool rdma_dim_decision(struct dim_stats *curr_stats, struct dim *dim)
>  			break;
>  		case DIM_STATS_WORSE:
>  			dim_turn(dim);
> -			fallthrough;
> +			/* fall through */
>  		case DIM_STATS_BETTER:
>  			step_res = rdma_dim_step(dim);
>  			if (step_res == DIM_ON_EDGE)
> @@ -94,7 +94,7 @@ void rdma_dim(struct dim *dim, u64 completions)
>  			schedule_work(&dim->work);
>  			break;
>  		}
> -		fallthrough;
> +		/* fall through */
>  	case DIM_START_MEASURE:
>  		dim->state = DIM_MEASURE_IN_PROGRESS;
>  		dim_update_sample_with_comps(curr_sample->event_ctr, 0, 0,
> diff --git a/lib/glob.c b/lib/glob.c
> index 85ecbda45cd8..52e3ed7e4a9b 100644
> --- a/lib/glob.c
> +++ b/lib/glob.c
> @@ -102,7 +102,7 @@ bool __pure glob_match(char const *pat, char const *str)
>  			break;
>  		case '\\':
>  			d = *pat++;
> -			fallthrough;
> +			/* fall through */
>  		default:	/* Literal character */
>  literal:
>  			if (c == d) {
> diff --git a/lib/siphash.c b/lib/siphash.c
> index a90112ee72a1..c47bb6ff2149 100644
> --- a/lib/siphash.c
> +++ b/lib/siphash.c
> @@ -68,11 +68,11 @@ u64 __siphash_aligned(const void *data, size_t len, const siphash_key_t *key)
>  						  bytemask_from_count(left)));
>  #else
>  	switch (left) {
> -	case 7: b |= ((u64)end[6]) << 48; fallthrough;
> -	case 6: b |= ((u64)end[5]) << 40; fallthrough;
> -	case 5: b |= ((u64)end[4]) << 32; fallthrough;
> +	case 7: b |= ((u64)end[6]) << 48; /* fall through */
> +	case 6: b |= ((u64)end[5]) << 40; /* fall through */
> +	case 5: b |= ((u64)end[4]) << 32; /* fall through */
>  	case 4: b |= le32_to_cpup(data); break;
> -	case 3: b |= ((u64)end[2]) << 16; fallthrough;
> +	case 3: b |= ((u64)end[2]) << 16; /* fall through */
>  	case 2: b |= le16_to_cpup(data); break;
>  	case 1: b |= end[0];
>  	}
> @@ -101,11 +101,11 @@ u64 __siphash_unaligned(const void *data, size_t len, const siphash_key_t *key)
>  						  bytemask_from_count(left)));
>  #else
>  	switch (left) {
> -	case 7: b |= ((u64)end[6]) << 48; fallthrough;
> -	case 6: b |= ((u64)end[5]) << 40; fallthrough;
> -	case 5: b |= ((u64)end[4]) << 32; fallthrough;
> +	case 7: b |= ((u64)end[6]) << 48; /* fall through */
> +	case 6: b |= ((u64)end[5]) << 40; /* fall through */
> +	case 5: b |= ((u64)end[4]) << 32; /* fall through */
>  	case 4: b |= get_unaligned_le32(end); break;
> -	case 3: b |= ((u64)end[2]) << 16; fallthrough;
> +	case 3: b |= ((u64)end[2]) << 16; /* fall through */
>  	case 2: b |= get_unaligned_le16(end); break;
>  	case 1: b |= end[0];
>  	}
> @@ -268,11 +268,11 @@ u32 __hsiphash_aligned(const void *data, size_t len, const hsiphash_key_t *key)
>  						  bytemask_from_count(left)));
>  #else
>  	switch (left) {
> -	case 7: b |= ((u64)end[6]) << 48; fallthrough;
> -	case 6: b |= ((u64)end[5]) << 40; fallthrough;
> -	case 5: b |= ((u64)end[4]) << 32; fallthrough;
> +	case 7: b |= ((u64)end[6]) << 48; /* fall through */
> +	case 6: b |= ((u64)end[5]) << 40; /* fall through */
> +	case 5: b |= ((u64)end[4]) << 32; /* fall through */
>  	case 4: b |= le32_to_cpup(data); break;
> -	case 3: b |= ((u64)end[2]) << 16; fallthrough;
> +	case 3: b |= ((u64)end[2]) << 16; /* fall through */
>  	case 2: b |= le16_to_cpup(data); break;
>  	case 1: b |= end[0];
>  	}
> @@ -301,11 +301,11 @@ u32 __hsiphash_unaligned(const void *data, size_t len,
>  						  bytemask_from_count(left)));
>  #else
>  	switch (left) {
> -	case 7: b |= ((u64)end[6]) << 48; fallthrough;
> -	case 6: b |= ((u64)end[5]) << 40; fallthrough;
> -	case 5: b |= ((u64)end[4]) << 32; fallthrough;
> +	case 7: b |= ((u64)end[6]) << 48; /* fall through */
> +	case 6: b |= ((u64)end[5]) << 40; /* fall through */
> +	case 5: b |= ((u64)end[4]) << 32; /* fall through */
>  	case 4: b |= get_unaligned_le32(end); break;
> -	case 3: b |= ((u64)end[2]) << 16; fallthrough;
> +	case 3: b |= ((u64)end[2]) << 16; /* fall through */
>  	case 2: b |= get_unaligned_le16(end); break;
>  	case 1: b |= end[0];
>  	}
> @@ -431,7 +431,7 @@ u32 __hsiphash_aligned(const void *data, size_t len, const hsiphash_key_t *key)
>  		v0 ^= m;
>  	}
>  	switch (left) {
> -	case 3: b |= ((u32)end[2]) << 16; fallthrough;
> +	case 3: b |= ((u32)end[2]) << 16; /* fall through */
>  	case 2: b |= le16_to_cpup(data); break;
>  	case 1: b |= end[0];
>  	}
> @@ -454,7 +454,7 @@ u32 __hsiphash_unaligned(const void *data, size_t len,
>  		v0 ^= m;
>  	}
>  	switch (left) {
> -	case 3: b |= ((u32)end[2]) << 16; fallthrough;
> +	case 3: b |= ((u32)end[2]) << 16; /* fall through */
>  	case 2: b |= get_unaligned_le16(end); break;
>  	case 1: b |= end[0];
>  	}
> diff --git a/lib/ts_fsm.c b/lib/ts_fsm.c
> index 64fd9015ad80..ab749ec10ab5 100644
> --- a/lib/ts_fsm.c
> +++ b/lib/ts_fsm.c
> @@ -193,7 +193,7 @@ static unsigned int fsm_find(struct ts_config *conf, struct ts_state *state)
>  				TOKEN_MISMATCH();
>  
>  			block_idx++;
> -			fallthrough;
> +			/* fall through */
>  
>  		case TS_FSM_ANY:
>  			if (next == NULL)
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 19ebe1b257ec..afb9521ddf91 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1265,7 +1265,7 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
>  
>  	case 'R':
>  		reversed = true;
> -		fallthrough;
> +		/* fall through */
>  
>  	default:
>  		separator = ':';
> @@ -1682,7 +1682,7 @@ char *uuid_string(char *buf, char *end, const u8 *addr,
>  	switch (*(++fmt)) {
>  	case 'L':
>  		uc = true;
> -		fallthrough;
> +		/* fall through */
>  	case 'l':
>  		index = guid_index;
>  		break;
> @@ -2219,7 +2219,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  	case 'S':
>  	case 's':
>  		ptr = dereference_symbol_descriptor(ptr);
> -		fallthrough;
> +		/* fall through */
>  	case 'B':
>  		return symbol_string(buf, end, ptr, spec, fmt);
>  	case 'R':
> @@ -2450,7 +2450,7 @@ int format_decode(const char *fmt, struct printf_spec *spec)
>  
>  	case 'x':
>  		spec->flags |= SMALL;
> -		fallthrough;
> +		/* fall through */
>  
>  	case 'X':
>  		spec->base = 16;
> @@ -2468,7 +2468,7 @@ int format_decode(const char *fmt, struct printf_spec *spec)
>  		 * utility, treat it as any other invalid or
>  		 * unsupported format specifier.
>  		 */
> -		fallthrough;
> +		/* fall through */
>  
>  	default:
>  		WARN_ONCE(1, "Please remove unsupported %%%c in format string\n", *fmt);
> @@ -3411,10 +3411,10 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
>  			break;
>  		case 'i':
>  			base = 0;
> -			fallthrough;
> +			/* fall through */
>  		case 'd':
>  			is_sign = true;
> -			fallthrough;
> +			/* fall through */
>  		case 'u':
>  			break;
>  		case '%':
> diff --git a/lib/xz/xz_dec_lzma2.c b/lib/xz/xz_dec_lzma2.c
> index ca2603abee08..65a1aad8c223 100644
> --- a/lib/xz/xz_dec_lzma2.c
> +++ b/lib/xz/xz_dec_lzma2.c
> @@ -1043,7 +1043,7 @@ XZ_EXTERN enum xz_ret xz_dec_lzma2_run(struct xz_dec_lzma2 *s,
>  
>  			s->lzma2.sequence = SEQ_LZMA_PREPARE;
>  
> -			fallthrough;
> +			/* fall through */
>  
>  		case SEQ_LZMA_PREPARE:
>  			if (s->lzma2.compressed < RC_INIT_BYTES)
> @@ -1055,7 +1055,7 @@ XZ_EXTERN enum xz_ret xz_dec_lzma2_run(struct xz_dec_lzma2 *s,
>  			s->lzma2.compressed -= RC_INIT_BYTES;
>  			s->lzma2.sequence = SEQ_LZMA_RUN;
>  
> -			fallthrough;
> +			/* fall through */
>  
>  		case SEQ_LZMA_RUN:
>  			/*
> diff --git a/lib/xz/xz_dec_stream.c b/lib/xz/xz_dec_stream.c
> index fea86deaaa01..32ab2a08b7cb 100644
> --- a/lib/xz/xz_dec_stream.c
> +++ b/lib/xz/xz_dec_stream.c
> @@ -583,7 +583,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
>  			if (ret != XZ_OK)
>  				return ret;
>  
> -			fallthrough;
> +			/* fall through */
>  
>  		case SEQ_BLOCK_START:
>  			/* We need one byte of input to continue. */
> @@ -608,7 +608,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
>  			s->temp.pos = 0;
>  			s->sequence = SEQ_BLOCK_HEADER;
>  
> -			fallthrough;
> +			/* fall through */
>  
>  		case SEQ_BLOCK_HEADER:
>  			if (!fill_temp(s, b))
> @@ -620,7 +620,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
>  
>  			s->sequence = SEQ_BLOCK_UNCOMPRESS;
>  
> -			fallthrough;
> +			/* fall through */
>  
>  		case SEQ_BLOCK_UNCOMPRESS:
>  			ret = dec_block(s, b);
> @@ -629,7 +629,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
>  
>  			s->sequence = SEQ_BLOCK_PADDING;
>  
> -			fallthrough;
> +			/* fall through */
>  
>  		case SEQ_BLOCK_PADDING:
>  			/*
> @@ -651,7 +651,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
>  
>  			s->sequence = SEQ_BLOCK_CHECK;
>  
> -			fallthrough;
> +			/* fall through */
>  
>  		case SEQ_BLOCK_CHECK:
>  			if (s->check_type == XZ_CHECK_CRC32) {
> @@ -675,7 +675,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
>  
>  			s->sequence = SEQ_INDEX_PADDING;
>  
> -			fallthrough;
> +			/* fall through */
>  
>  		case SEQ_INDEX_PADDING:
>  			while ((s->index.size + (b->in_pos - s->in_start))
> @@ -699,7 +699,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
>  
>  			s->sequence = SEQ_INDEX_CRC32;
>  
> -			fallthrough;
> +			/* fall through */
>  
>  		case SEQ_INDEX_CRC32:
>  			ret = crc32_validate(s, b);
> @@ -709,7 +709,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
>  			s->temp.size = STREAM_HEADER_SIZE;
>  			s->sequence = SEQ_STREAM_FOOTER;
>  
> -			fallthrough;
> +			/* fall through */
>  
>  		case SEQ_STREAM_FOOTER:
>  			if (!fill_temp(s, b))
> diff --git a/lib/zstd/bitstream.h b/lib/zstd/bitstream.h
> index 7c65c66e41fd..3a49784d5c61 100644
> --- a/lib/zstd/bitstream.h
> +++ b/lib/zstd/bitstream.h
> @@ -259,15 +259,15 @@ ZSTD_STATIC size_t BIT_initDStream(BIT_DStream_t *bitD, const void *srcBuffer, s
>  		bitD->bitContainer = *(const BYTE *)(bitD->start);
>  		switch (srcSize) {
>  		case 7: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[6]) << (sizeof(bitD->bitContainer) * 8 - 16);
> -			fallthrough;
> +			/* fall through */
>  		case 6: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[5]) << (sizeof(bitD->bitContainer) * 8 - 24);
> -			fallthrough;
> +			/* fall through */
>  		case 5: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[4]) << (sizeof(bitD->bitContainer) * 8 - 32);
> -			fallthrough;
> +			/* fall through */
>  		case 4: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[3]) << 24;
> -			fallthrough;
> +			/* fall through */
>  		case 3: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[2]) << 16;
> -			fallthrough;
> +			/* fall through */
>  		case 2: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[1]) << 8;
>  		default:;
>  		}
> diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
> index b080264ed3ad..5e0b67003e55 100644
> --- a/lib/zstd/compress.c
> +++ b/lib/zstd/compress.c
> @@ -3182,7 +3182,7 @@ static size_t ZSTD_compressStream_generic(ZSTD_CStream *zcs, void *dst, size_t *
>  				zcs->outBuffFlushedSize = 0;
>  				zcs->stage = zcss_flush; /* pass-through to flush stage */
>  			}
> -			fallthrough;
> +			/* fall through */
>  
>  		case zcss_flush: {
>  			size_t const toFlush = zcs->outBuffContentSize - zcs->outBuffFlushedSize;
> diff --git a/lib/zstd/decompress.c b/lib/zstd/decompress.c
> index 66cd487a326a..db6761ea4deb 100644
> --- a/lib/zstd/decompress.c
> +++ b/lib/zstd/decompress.c
> @@ -442,7 +442,7 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx *dctx, const void *src, size_t srcSize
>  		case set_repeat:
>  			if (dctx->litEntropy == 0)
>  				return ERROR(dictionary_corrupted);
> -			fallthrough;
> +			/* fall through */
>  		case set_compressed:
>  			if (srcSize < 5)
>  				return ERROR(corruption_detected); /* srcSize >= MIN_CBLOCK_SIZE == 3; here we need up to 5 for case 3 */
> @@ -1768,7 +1768,7 @@ size_t ZSTD_decompressContinue(ZSTD_DCtx *dctx, void *dst, size_t dstCapacity, c
>  			return 0;
>  		}
>  		dctx->expected = 0; /* not necessary to copy more */
> -		fallthrough;
> +		/* fall through */
>  
>  	case ZSTDds_decodeFrameHeader:
>  		memcpy(dctx->headerBuffer + ZSTD_frameHeaderSize_prefix, src, dctx->expected);
> @@ -2309,7 +2309,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
>  		switch (zds->stage) {
>  		case zdss_init:
>  			ZSTD_resetDStream(zds); /* transparent reset on starting decoding a new frame */
> -			fallthrough;
> +			/* fall through */
>  
>  		case zdss_loadHeader: {
>  			size_t const hSize = ZSTD_getFrameParams(&zds->fParams, zds->headerBuffer, zds->lhSize);
> @@ -2376,7 +2376,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
>  			}
>  			zds->stage = zdss_read;
>  		}
> -			fallthrough;
> +			/* fall through */
>  
>  		case zdss_read: {
>  			size_t const neededInSize = ZSTD_nextSrcSizeToDecompress(zds->dctx);
> @@ -2405,7 +2405,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
>  			zds->stage = zdss_load;
>  			/* pass-through */
>  		}
> -			fallthrough;
> +			/* fall through */
>  
>  		case zdss_load: {
>  			size_t const neededInSize = ZSTD_nextSrcSizeToDecompress(zds->dctx);
> @@ -2438,7 +2438,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
>  				/* pass-through */
>  			}
>  		}
> -			fallthrough;
> +			/* fall through */
>  
>  		case zdss_flush: {
>  			size_t const toFlushSize = zds->outEnd - zds->outStart;
> diff --git a/lib/zstd/huf_compress.c b/lib/zstd/huf_compress.c
> index 08b4ae80aed4..e727812d12aa 100644
> --- a/lib/zstd/huf_compress.c
> +++ b/lib/zstd/huf_compress.c
> @@ -556,9 +556,9 @@ size_t HUF_compress1X_usingCTable(void *dst, size_t dstSize, const void *src, si
>  	n = srcSize & ~3; /* join to mod 4 */
>  	switch (srcSize & 3) {
>  	case 3: HUF_encodeSymbol(&bitC, ip[n + 2], CTable); HUF_FLUSHBITS_2(&bitC);
> -		fallthrough;
> +		/* fall through */
>  	case 2: HUF_encodeSymbol(&bitC, ip[n + 1], CTable); HUF_FLUSHBITS_1(&bitC);
> -		fallthrough;
> +		/* fall through */
>  	case 1: HUF_encodeSymbol(&bitC, ip[n + 0], CTable); HUF_FLUSHBITS(&bitC);
>  	case 0:
>  	default:;
> -- 
> 2.27.0
> 
