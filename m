Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13E3C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A724C206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYz7fnw4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgEEWLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:11:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38624 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727089AbgEEWLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588716664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IrYsPYEWZgQPaSn+dBPLkVTg1XAFBcfFSdTS4eHPqMw=;
        b=IYz7fnw4yZAaFziqjpKac2YblanUpV5ZbOBaH1iP+qyuOIrpGPLIsluBXP6RQYFKj2iGOZ
        TL1Aam0vbSEUHYhoN5yOwLvCyQcZOLVP12bNi0+J4te13nLKU1RvPygbfTdheV2ViStSWU
        niv/C6F4DaTxXI6d3MafkhcEmu5aN0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-wMaqkGPnNZq4phnkGF36Zg-1; Tue, 05 May 2020 18:11:02 -0400
X-MC-Unique: wMaqkGPnNZq4phnkGF36Zg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A49EB1005510;
        Tue,  5 May 2020 22:11:00 +0000 (UTC)
Received: from treble (ovpn-114-99.rdu2.redhat.com [10.10.114.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 664F57054D;
        Tue,  5 May 2020 22:10:54 +0000 (UTC)
Date:   Tue, 5 May 2020 17:10:51 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 07/18] static_call: Add inline static call
 infrastructure
Message-ID: <20200505221051.x6mz33ylqy62m4s4@treble>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.186964469@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501202944.186964469@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 10:28:56PM +0200, Peter Zijlstra wrote:
> +#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
> +
> +struct static_call_mod {
> +	struct static_call_mod *next;
> +	struct module *mod; /* for vmlinux, mod == NULL */
> +	struct static_call_site *sites;
> +};
> +
> +struct static_call_key {
> +	void *func;
> +	struct static_call_mod *next;
> +};

"next" implies it links to another key.  How about "mods" or
"site_mods"?

> +++ b/include/linux/static_call_types.h
> @@ -2,14 +2,27 @@
>  #ifndef _STATIC_CALL_TYPES_H
>  #define _STATIC_CALL_TYPES_H
>  
> +#include <linux/types.h>
>  #include <linux/stringify.h>
>  
>  #define STATIC_CALL_PREFIX		__SC__
> +#define STATIC_CALL_PREFIX_STR		__stringify(STATIC_CALL_PREFIX)
> +#define STATIC_CALL_PREFIX_LEN		(sizeof(STATIC_CALL_PREFIX_STR) - 1)

STATIC_CALL_KEY_PREFIX_STR
STATIC_CALL_KEY_PREFIX_LEN

> +void __static_call_update(struct static_call_key *key, void *tramp, void *func)
> +{
> +	struct static_call_site *site, *stop;
> +	struct static_call_mod *site_mod;
> +
> +	cpus_read_lock();
> +	static_call_lock();
> +
> +	if (key->func == func)
> +		goto done;
> +
> +	key->func = func;
> +
> +	arch_static_call_transform(NULL, tramp, func);
> +
> +	/*
> +	 * If uninitialized, we'll not update the callsites, but they still
> +	 * point to the trampoline and we just patched that.
> +	 */
> +	if (WARN_ON_ONCE(!static_call_initialized))
> +		goto done;
> +
> +	for (site_mod = key->next; site_mod; site_mod = site_mod->next) {
> +		if (!site_mod->sites) {
> +			/*
> +			 * This can happen if the static call key is defined in
> +			 * a module which doesn't use it.
> +			 */
> +			continue;
> +		}
> +
> +		stop = __stop_static_call_sites;
> +
> +#ifdef CONFIG_MODULES
> +		if (site_mod->mod) {
> +			stop = site_mod->mod->static_call_sites +
> +			       site_mod->mod->num_static_call_sites;
> +		}
> +#endif

Instead of defining 'mod' in the inner loop below, it can be set at the
top of the outer loop above.  Then the above 'stop' calculation can
be a little less verbose.

-- 
Josh

