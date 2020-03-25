Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5859CC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319E120714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCYLpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:45:40 -0400
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:4930 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgCYLpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:45:39 -0400
X-Greylist: delayed 686 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2020 07:45:39 EDT
Received: from thorin.petrovitsch.priv.at (80-110-108-220.cgn.dynamic.surfer.at [80.110.108.220])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id 02PBXCX5024904
        (version=TLSv1 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Wed, 25 Mar 2020 12:33:13 +0100
Subject: Re: [PATCH v3] x86: Alias memset to __builtin_memset.
To:     Clement Courbet <courbet@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20200323114207.222412-1-courbet@google.com>
 <20200324155907.97184-1-courbet@google.com>
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Message-ID: <fdcd36df-e2a2-b8b8-abec-8448412af360@petrovitsch.priv.at>
Date:   Wed, 25 Mar 2020 12:33:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324155907.97184-1-courbet@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-DCC-wuwien-Metrics: esgaroth.tuxoid.at 1290; Body=12 Fuz1=12 Fuz2=12
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Sry for being late at the party:

On 24/03/2020 16:59, Clement Courbet wrote:
[...]
> ---
>   arch/x86/include/asm/string_64.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
> index 75314c3dbe47..9cfce0a840a4 100644
> --- a/arch/x86/include/asm/string_64.h
> +++ b/arch/x86/include/asm/string_64.h
> @@ -18,6 +18,15 @@ extern void *__memcpy(void *to, const void *from, size_t len);
>   void *memset(void *s, int c, size_t n);
>   void *__memset(void *s, int c, size_t n);
>   
> +/* Recent compilers can generate much better code for known size and/or
> + * fill values, and will fallback on `memset` if they fail.
> + * We alias `memset` to `__builtin_memset` explicitly to inform the compiler to
> + * perform this optimization even when -ffreestanding is used.
> + */
> +#if !defined(CONFIG_FORTIFY_SOURCE)
> +#define memset(s, c, count) __builtin_memset(s, c, count)
To be on the safe side, the usual way to write macros is like

#define memset(s, c, count) __builtin_memset((s), (c), (count))

as no one know what is passed as parameter to memset() and the extra 
pair of parentheses don't hurt.

And similar below (and I fear there are more places).

Or did I miss something in the Kernel?

> +#endif
> +
>   #define __HAVE_ARCH_MEMSET16
>   static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
>   {
> @@ -74,6 +83,7 @@ int strcmp(const char *cs, const char *ct);
>   #undef memcpy
>   #define memcpy(dst, src, len) __memcpy(dst, src, len)
#define memcpy(dst, src, len) __memcpy((dst), (src), (len))
>   #define memmove(dst, src, len) __memmove(dst, src, len)
#define memmove(dst, src, len) __memmove((dst), (src), (len))
> +#undef memset
>   #define memset(s, c, n) __memset(s, c, n)
#define memset(s, c, n) __memset((s), (c), (n))
>   
>   #ifndef __NO_FORTIFY
> 

MfG,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                      LUGA : http://www.luga.at
