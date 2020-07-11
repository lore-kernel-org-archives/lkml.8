Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109A7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC902078B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgGKAXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 20:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgGKAXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 20:23:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6238D20767;
        Sat, 11 Jul 2020 00:23:21 +0000 (UTC)
Date:   Fri, 10 Jul 2020 20:23:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 14/17] static_call: Handle tail-calls
Message-ID: <20200710202319.3c3eec12@oasis.local.home>
In-Reply-To: <20200710134336.977578032@infradead.org>
References: <20200710133831.943894387@infradead.org>
        <20200710134336.977578032@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 15:38:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> GCC can turn our static_call(name)(args...) into a tail call, in which
> case we get a JMP.d32 into the trampoline (which then does a further
> tail-call).
> 
> Teach objtool to recognise and mark these in .static_call_sites and
> adjust the code patching to deal with this.
> 

Hmm, were you able to trigger crashes before this patch?

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/static_call.c           |   21 ++++++++++++++++++---
>  include/linux/static_call.h             |    4 ++--
>  include/linux/static_call_types.h       |    7 +++++++
>  kernel/static_call.c                    |   21 +++++++++++++--------
>  tools/include/linux/static_call_types.h |    7 +++++++
>  tools/objtool/check.c                   |   18 +++++++++++++-----
>  6 files changed, 60 insertions(+), 18 deletions(-)
> 
> --- a/arch/x86/kernel/static_call.c
> +++ b/arch/x86/kernel/static_call.c
> @@ -41,15 +41,30 @@ static void __static_call_transform(void
>  	text_poke_bp(insn, code, size, NULL);
>  }
>  
> -void arch_static_call_transform(void *site, void *tramp, void *func)
> +static inline enum insn_type __sc_insn(bool null, bool tail)
> +{
> +	/*
> +	 * Encode the following table without branches:
> +	 *
> +	 *	tail	null	insn
> +	 *	-----+-------+------
> +	 *	  0  |   0   |  CALL
> +	 *	  0  |   1   |  NOP
> +	 *	  1  |   0   |  JMP
> +	 *	  1  |   1   |  RET
> +	 */
> +	return 2*tail + null;
> +}
> +
> +void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
>  {
>  	mutex_lock(&text_mutex);
>  
>  	if (tramp)
> -		__static_call_transform(tramp, func ? JMP : RET, func);
> +		__static_call_transform(tramp, __sc_insn(!func, true), func);
>  
>  	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
> -		__static_call_transform(site, func ? CALL : NOP, func);
> +		__static_call_transform(site, __sc_insn(!func, tail), func);
>  
>  	mutex_unlock(&text_mutex);
>  }
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -103,7 +103,7 @@
>  /*
>   * Either @site or @tramp can be NULL.
>   */
> -extern void arch_static_call_transform(void *site, void *tramp, void *func);
> +extern void arch_static_call_transform(void *site, void *tramp, void *func, bool tail);
>  
>  #define STATIC_CALL_TRAMP_ADDR(name) &STATIC_CALL_TRAMP(name)
>  
> @@ -206,7 +206,7 @@ void __static_call_update(struct static_
>  {
>  	cpus_read_lock();
>  	WRITE_ONCE(key->func, func);
> -	arch_static_call_transform(NULL, tramp, func);
> +	arch_static_call_transform(NULL, tramp, func, false);
>  	cpus_read_unlock();
>  }
>  
> --- a/include/linux/static_call_types.h
> +++ b/include/linux/static_call_types.h
> @@ -17,6 +17,13 @@
>  #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
>  
>  /*
> + * Flags in the low bits of static_call_site::key.
> + */
> +#define STATIC_CALL_SITE_TAIL 1UL	/* tail call */
> +#define STATIC_CALL_SITE_INIT 2UL	/* init section */
> +#define STATIC_CALL_SITE_FLAGS 3UL
> +
> +/*
>   * The static call site table needs to be created by external tooling (objtool
>   * or a compiler plugin).
>   */
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -15,8 +15,6 @@ extern struct static_call_site __start_s
>  
>  static bool static_call_initialized;
>  
> -#define STATIC_CALL_INIT 1UL
> -
>  /* mutex to protect key modules/sites */
>  static DEFINE_MUTEX(static_call_mutex);
>  
> @@ -39,18 +37,23 @@ static inline void *static_call_addr(str
>  static inline struct static_call_key *static_call_key(const struct static_call_site *site)
>  {
>  	return (struct static_call_key *)
> -		(((long)site->key + (long)&site->key) & ~STATIC_CALL_INIT);
> +		(((long)site->key + (long)&site->key) & ~STATIC_CALL_SITE_FLAGS);
>  }
>  
>  /* These assume the key is word-aligned. */
>  static inline bool static_call_is_init(struct static_call_site *site)
>  {
> -	return ((long)site->key + (long)&site->key) & STATIC_CALL_INIT;
> +	return ((long)site->key + (long)&site->key) & STATIC_CALL_SITE_INIT;
> +}
> +
> +static inline bool static_call_is_tail(struct static_call_site *site)
> +{
> +	return ((long)site->key + (long)&site->key) & STATIC_CALL_SITE_TAIL;
>  }
>  
>  static inline void static_call_set_init(struct static_call_site *site)
>  {
> -	site->key = ((long)static_call_key(site) | STATIC_CALL_INIT) -
> +	site->key = ((long)static_call_key(site) | STATIC_CALL_SITE_INIT) -
>  		    (long)&site->key;
>  }
>  
> @@ -104,7 +107,7 @@ void __static_call_update(struct static_
>  
>  	key->func = func;
>  
> -	arch_static_call_transform(NULL, tramp, func);
> +	arch_static_call_transform(NULL, tramp, func, false);
>  
>  	/*
>  	 * If uninitialized, we'll not update the callsites, but they still
> @@ -154,7 +157,8 @@ void __static_call_update(struct static_
>  				continue;
>  			}
>  
> -			arch_static_call_transform(site_addr, NULL, func);
> +			arch_static_call_transform(site_addr, NULL, func,
> +				static_call_is_tail(site));
>  		}
>  	}
>  
> @@ -198,7 +202,8 @@ static int __static_call_init(struct mod
>  			key->mods = site_mod;
>  		}
>  
> -		arch_static_call_transform(site_addr, NULL, key->func);
> +		arch_static_call_transform(site_addr, NULL, key->func,
> +				static_call_is_tail(site));
>  	}
>  
>  	return 0;
> --- a/tools/include/linux/static_call_types.h
> +++ b/tools/include/linux/static_call_types.h
> @@ -17,6 +17,13 @@
>  #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
>  
>  /*
> + * Flags in the low bits of static_call_site::key.
> + */
> +#define STATIC_CALL_SITE_TAIL 1UL	/* tail call */
> +#define STATIC_CALL_SITE_INIT 2UL	/* init section */
> +#define STATIC_CALL_SITE_FLAGS 3UL
> +
> +/*
>   * The static call site table needs to be created by external tooling (objtool
>   * or a compiler plugin).
>   */
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -511,7 +511,7 @@ static int create_static_call_sections(s
>  		}
>  		memset(reloc, 0, sizeof(*reloc));
>  		reloc->sym = key_sym;
> -		reloc->addend = 0;
> +		reloc->addend = is_sibling_call(insn) ? STATIC_CALL_SITE_TAIL : 0;
>  		reloc->type = R_X86_64_PC32;
>  		reloc->offset = idx * sizeof(struct static_call_site) + 4;
>  		reloc->sec = reloc_sec;
> @@ -720,6 +720,10 @@ static int add_jump_destinations(struct
>  		} else {
>  			/* external sibling call */
>  			insn->call_dest = reloc->sym;
> +			if (insn->call_dest->static_call_tramp) {
> +				list_add_tail(&insn->static_call_node,
> +					      &file->static_call_list);
> +			}
>  			continue;
>  		}
>  
> @@ -771,6 +775,10 @@ static int add_jump_destinations(struct
>  
>  				/* internal sibling call */
>  				insn->call_dest = insn->jump_dest->func;
> +				if (insn->call_dest->static_call_tramp) {
> +					list_add_tail(&insn->static_call_node,
> +						      &file->static_call_list);
> +				}
>  			}
>  		}
>  	}
> @@ -1639,6 +1647,10 @@ static int decode_sections(struct objtoo
>  	if (ret)
>  		return ret;
>  
> +	ret = read_static_call_tramps(file);
> +	if (ret)
> +		return ret;
> +
>  	ret = add_jump_destinations(file);
>  	if (ret)
>  		return ret;
> @@ -1671,10 +1683,6 @@ static int decode_sections(struct objtoo
>  	if (ret)
>  		return ret;
>  
> -	ret = read_static_call_tramps(file);
> -	if (ret)
> -		return ret;

Hmm, what's the reason for moving this above? Should we have a comment
here if there's importance that read_static_call_trampoline() is done
earlier?

-- Steve


> -
>  	return 0;
>  }
>  
> 

