Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC8CC4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F9F21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZqjG0zC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgBZPWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:22:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35385 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727023AbgBZPWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582730525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=acL3JEsePWMJEzAzv23eQbpcXxYGbwZzV+mHXh+bKQQ=;
        b=GZqjG0zC9rXnZgELTMzDEfdSCrBVB7HI+4MDTKZ/wIYHZbW7z2gsJzvISqxG2R5QMIiZab
        KjRT1JgLB3UUQLQT54tQlXuQCbBODdOsX9s1lg1frN4CmivkVXEffIsPHDVr8uCk/udG06
        D8RHuU1sHL9nYrBbHfDKRleuz7xhyuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-ZlcmmgukPZqFse1kQlQ-1Q-1; Wed, 26 Feb 2020 10:21:59 -0500
X-MC-Unique: ZlcmmgukPZqFse1kQlQ-1Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E471C1007EEE;
        Wed, 26 Feb 2020 15:21:56 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A5495C54A;
        Wed, 26 Feb 2020 15:21:53 +0000 (UTC)
Date:   Wed, 26 Feb 2020 16:21:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 03/13] kprobes: Add symbols for kprobe insn pages
Message-ID: <20200226152151.GA217283@krava>
References: <20200212124949.3589-1-adrian.hunter@intel.com>
 <20200212124949.3589-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212124949.3589-4-adrian.hunter@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 02:49:39PM +0200, Adrian Hunter wrote:
> Symbols are needed for tools to describe instruction addresses. Pages
> allocated for kprobe's purposes need symbols to be created for them.
> Add such symbols to be visible via /proc/kallsyms.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

SNIP

> @@ -272,6 +273,8 @@ static inline bool is_kprobe_##__name##_slot(unsigned long addr)	\
>  {									\
>  	return __is_insn_slot_addr(&kprobe_##__name##_slots, addr);	\
>  }
> +#define KPROBE_INSN_PAGE_SYM		"kprobe_insn_page"
> +#define KPROBE_OPTINSN_PAGE_SYM		"kprobe_optinsn_page"
>  #else /* __ARCH_WANT_KPROBES_INSN_SLOT */
>  #define DEFINE_INSN_CACHE_OPS(__name)					\
>  static inline bool is_kprobe_##__name##_slot(unsigned long addr)	\
> @@ -373,6 +376,13 @@ void dump_kprobe(struct kprobe *kp);
>  void *alloc_insn_page(void);
>  void free_insn_page(void *page);
>  
> +int kprobe_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> +		       char *sym);
> +int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
> +			     unsigned long *value, char *type, char *sym);
> +
> +int arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
> +			    char *type, char *sym);
>  #else /* !CONFIG_KPROBES: */
>  
>  static inline int kprobes_built_in(void)
> @@ -435,6 +445,24 @@ static inline bool within_kprobe_blacklist(unsigned long addr)
>  {
>  	return true;
>  }
> +static inline int kprobe_get_kallsym(unsigned int symnum, unsigned long *value,
> +				     char *type, char *sym)
> +{
> +	return 0;
> +}
> +static inline int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c,
> +					   unsigned int *symnum,
> +					   unsigned long *value, char *type,
> +					   char *sym)
> +{
> +	return 0;
> +}
> +static inline int arch_kprobe_get_kallsym(unsigned int *symnum,
> +					  unsigned long *value, char *type,
> +					  char *sym)
> +{
> +	return 0;
> +}

there's another arch_kprobe_get_kallsym marked as __weak,
is above function superfluous?

jirka

SNIP

> +int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
> +				   char *type, char *sym)
> +{
> +	return -ERANGE;
> +}
> +
> +int kprobe_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> +		       char *sym)
> +{
> +#ifdef __ARCH_WANT_KPROBES_INSN_SLOT
> +	if (!kprobe_cache_get_kallsym(&kprobe_insn_slots, &symnum, value, type, sym))
> +		return 0;
> +#ifdef CONFIG_OPTPROBES
> +	if (!kprobe_cache_get_kallsym(&kprobe_optinsn_slots, &symnum, value, type, sym))
> +		return 0;
> +#endif
> +#endif
> +	if (!arch_kprobe_get_kallsym(&symnum, value, type, sym))
> +		return 0;
> +	return -ERANGE;
> +}
> +
>  int __init __weak arch_populate_kprobe_blacklist(void)
>  {
>  	return 0;
> -- 
> 2.17.1
> 

