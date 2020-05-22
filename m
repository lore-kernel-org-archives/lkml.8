Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A358C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D882072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qdA9OPqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgEVK0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:26:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54840 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbgEVK0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:26:38 -0400
Received: from zn.tnic (p200300ec2f0d490039ac3da161697ee8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4900:39ac:3da1:6169:7ee8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 12E0A1EC02B2;
        Fri, 22 May 2020 12:26:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590143197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/XDVTKccx+x8Mgp+Gyd+1EjhHIf2Ys7dOXVJ8hPhJY=;
        b=qdA9OPqs3YetfQHsMojsLfh9BL0lLbfpHgSoVKShuV4ZH0no/JNOV7SPTR2aKbltkV92mt
        RHxHUObr70T0RJJfT1UHZOF8sGadQBNsSooyELgHC0iho0taZWcHaKaUDp7UFRFP/1AUfy
        8ae0py51cA7JkVzn2yMTShQ+y+PTF04=
Date:   Fri, 22 May 2020 12:26:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH -tip v3 03/11] kcsan: Support distinguishing volatile
 accesses
Message-ID: <20200522102630.GC28750@zn.tnic>
References: <20200521142047.169334-1-elver@google.com>
 <20200521142047.169334-4-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200521142047.169334-4-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 04:20:39PM +0200, Marco Elver wrote:
> diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
> index 20337a7ecf54..75d2942b9437 100644
> --- a/scripts/Makefile.kcsan
> +++ b/scripts/Makefile.kcsan
> @@ -9,7 +9,10 @@ else
>  cc-param = --param -$(1)
>  endif
>  
> +# Keep most options here optional, to allow enabling more compilers if absence
> +# of some options does not break KCSAN nor causes false positive reports.
>  CFLAGS_KCSAN := -fsanitize=thread \
> -	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls)
> +	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls) \
> +	$(call cc-param,tsan-distinguish-volatile=1)

gcc 9 doesn't like this:

cc1: error: invalid --param name ‘-tsan-distinguish-volatile’
make[1]: *** [scripts/Makefile.build:100: scripts/mod/devicetable-offsets.s] Error 1
make[1]: *** Waiting for unfinished jobs....
cc1: error: invalid --param name ‘-tsan-distinguish-volatile’
make[1]: *** [scripts/Makefile.build:267: scripts/mod/empty.o] Error 1
make: *** [Makefile:1141: prepare0] Error 2
make: *** Waiting for unfinished jobs....

git grep "tsan-distinguish-volatile" in gcc's git doesn't give anything.

Hmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
