Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978B7C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC5E20737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Y52U9w6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgCZPy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:54:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39140 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbgCZPy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:54:26 -0400
Received: from zn.tnic (p200300EC2F0A4900B0CADCDCA21F3A81.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:4900:b0ca:dcdc:a21f:3a81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC8011EC071C;
        Thu, 26 Mar 2020 16:54:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585238064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rhNDehhRHOjQ0g6g3hTypMi7Mz8SaoyRrmcWsFMIGcw=;
        b=Y52U9w6nE7ruAh3wjd1avqlVu9jGjJEZIhzjTjwiIHmZiysIAlMgxjBI63U44p94684+qg
        Vq/nIhXhGY36aF95UDqFqv+tGqO3Au6BySXj/XAukXg39oq+ocoS1kOml5A0dxuSTBDbJd
        5gIY6K6bv6XDGufFIze3Mjp0G3Yz99w=
Date:   Thu, 26 Mar 2020 16:54:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [RESEND][PATCH v3 07/17] static_call: Add inline static call
 infrastructure
Message-ID: <20200326155425.GE11398@zn.tnic>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.694414364@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324142245.694414364@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 02:56:10PM +0100, Peter Zijlstra wrote:
> +#define DEFINE_STATIC_CALL(name, _func)					\
> +	DECLARE_STATIC_CALL(name, _func);				\
> +	struct static_call_key STATIC_CALL_NAME(name) = {		\
> +		.func = _func,						\
> +		.next = NULL,						\
> +	};								\
> +	__ADDRESSABLE(STATIC_CALL_NAME(name));				\
> +	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
> +
> +#define static_call(name)	STATIC_CALL_TRAMP(name)
> +
> +#define EXPORT_STATIC_CALL(name)					\
> +	EXPORT_SYMBOL(STATIC_CALL_NAME(name));				\
> +	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))

I think we want only the _GPL versions below - not those. As you said on
IRC, jump_label/static_branch is GPL only.

> +
> +#define EXPORT_STATIC_CALL_GPL(name)					\
> +	EXPORT_SYMBOL_GPL(STATIC_CALL_NAME(name));			\
> +	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
