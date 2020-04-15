Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94A0C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47DA208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634533AbgDOOhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:37:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:48956 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394152AbgDOOe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:34:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB07FAB3D;
        Wed, 15 Apr 2020 14:34:26 +0000 (UTC)
Date:   Wed, 15 Apr 2020 16:34:26 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH 1/7] livepatch: Apply vmlinux-specific KLP relocations
 early
In-Reply-To: <8c3af42719fe0add37605ede634c7035a90f9acc.1586881704.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.21.2004151633010.13470@pobox.suse.cz>
References: <cover.1586881704.git.jpoimboe@redhat.com> <8c3af42719fe0add37605ede634c7035a90f9acc.1586881704.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a nit below

> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index e894e74905f3..d9e9b76f6054 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -234,14 +234,30 @@ void klp_shadow_free_all(unsigned long id, klp_shadow_dtor_t dtor);
>  struct klp_state *klp_get_state(struct klp_patch *patch, unsigned long id);
>  struct klp_state *klp_get_prev_state(unsigned long id);
>  
> +int klp_write_relocations(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> +			  const char *shstrtab, const char *strtab,
> +			  unsigned int symindex, struct module *pmod,
> +			  const char *objname);
> +
>  #else /* !CONFIG_LIVEPATCH */
>  
> +struct klp_object;
> +

Is the forward declaration necessary here?

>  static inline int klp_module_coming(struct module *mod) { return 0; }
>  static inline void klp_module_going(struct module *mod) {}
>  static inline bool klp_patch_pending(struct task_struct *task) { return false; }
>  static inline void klp_update_patch_state(struct task_struct *task) {}
>  static inline void klp_copy_process(struct task_struct *child) {}
>  
> +static inline
> +int klp_write_relocations(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> +			  const char *shstrtab, const char *strtab,
> +			  unsigned int symindex, struct module *pmod,
> +			  const char *objname)
> +{
> +	return 0;
> +}
> +
>  #endif /* CONFIG_LIVEPATCH */

Miroslav
