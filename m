Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E231C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D702073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gswVKwMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgCZPR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:17:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33878 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCZPRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:17:55 -0400
Received: from zn.tnic (p200300EC2F0A4900341618FA2426449A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:4900:3416:18fa:2426:449a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 97BA51EC0469;
        Thu, 26 Mar 2020 16:17:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585235874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PoN/7rYz9AoBh8GJI/bdaHsVDtWJ4mFyOEFbfYWnBeQ=;
        b=gswVKwMcy+eO7uaRwRU7TB7DSqgNABIC2my5gmEVw3JGtgB78N4IawmXs0OcpJwFgZNW6y
        XYbwynQJ4WaZXx216v/0SVwTDS5jlBg5M3UnWhfBTygQIhgEyj6NRzpnS+OhzanfvGJQ7t
        iqNQykMOWxj4VTnDdxK8W6/N2569auY=
Date:   Thu, 26 Mar 2020 16:17:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [RESEND][PATCH v3 10/17] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20200326151750.GC11398@zn.tnic>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.880990363@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324142245.880990363@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 02:56:13PM +0100, Peter Zijlstra wrote:
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -15,6 +15,7 @@
>  
>  #include <linux/hashtable.h>
>  #include <linux/kernel.h>
> +#include <linux/static_call_types.h>
>  
>  #define FAKE_JUMP_OFFSET -1
>  
> @@ -1345,6 +1346,21 @@ static int read_retpoline_hints(struct o
>  	return 0;
>  }
>  
> +static int read_static_call_tramps(struct objtool_file *file)
> +{
> +	struct section *sec, *sc_sec = find_section_by_name(file->elf, ".static_call.text");
> +	struct symbol *func;

	if (!sc_sec)
		return;

no?

I mean, it is enabled by default on X86_64 but not on 32-bit. Or will it
be?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
