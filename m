Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FEEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D77D20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ZHFbqW/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgCDT1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:27:51 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.94]:44440 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbgCDT1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 14:27:50 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id B0250312148
        for <linux-kernel@vger.kernel.org>; Wed,  4 Mar 2020 13:27:49 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9ZgLjAPehSl8q9ZgLjn2sw; Wed, 04 Mar 2020 13:27:49 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yV3RHTJGEJ6X5MtVLixPDzRdxD9I2sP1TZY5RWDJRi4=; b=ZHFbqW/8vWTeVjXhQrEzeourHs
        R1Vt5jRPS076UUyTOM5125y6VgEjm97vvSsu6ET/V5HWsjrDiPpHJoOlUx4daZ20aOsU7hBHLcS5w
        Mz4CYkQGB/SRzkHpBJ5uQ1vbk9xAtfmcB+uZJQotKNAi96vJN1HRu8ZRtkhAhjabeRIQTa+JhE8gD
        w2paeJ4AVcUvsS2ElKVRMy6GSytV4GFQQ0MuBdGvb3ccQdlFYgdXzZAl3mEFsMwdwWXlGEetr0QzN
        8zFKU0DmhlXMJE2EwTDTfjqeH0Kz2hXlaZKlWWipdvp1PKa+o1aWPwPDD5swZ/3lFOrWgbV8uD7//
        RBC4VMwg==;
Received: from [200.39.25.77] (port=10307 helo=[192.168.43.132])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j9ZgL-004JcY-4q; Wed, 04 Mar 2020 13:27:49 -0600
Subject: Re: [PATCH] docs: deprecated.rst: Clean up fall-through details
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Joe Perches <joe@perches.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202003041102.47A4E4B62@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <a8aa5d75-9a4e-1a84-b3ed-f868206ddee7@embeddedor.com>
Date:   Wed, 4 Mar 2020 13:30:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <202003041102.47A4E4B62@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.39.25.77
X-Source-L: No
X-Exim-ID: 1j9ZgL-004JcY-4q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.132]) [200.39.25.77]:10307
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/20 13:03, Kees Cook wrote:
> Add example of fall-through, list-ify the case ending statements, and
> adjust the markup for links and readability. While here, adjust
> strscpy() details to mention strscpy_pad().
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

> ---
>  Documentation/process/deprecated.rst | 48 +++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 179f2a5625a0..f9f196d3a69b 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -94,8 +94,8 @@ and other misbehavior due to the missing termination. It also NUL-pads the
>  destination buffer if the source contents are shorter than the destination
>  buffer size, which may be a needless performance penalty for callers using
>  only NUL-terminated strings. The safe replacement is :c:func:`strscpy`.
> -(Users of :c:func:`strscpy` still needing NUL-padding will need an
> -explicit :c:func:`memset` added.)
> +(Users of :c:func:`strscpy` still needing NUL-padding should instead
> +use strscpy_pad().)
>  
>  If a caller is using non-NUL-terminated strings, :c:func:`strncpy()` can
>  still be used, but destinations should be marked with the `__nonstring
> @@ -122,27 +122,37 @@ memory adjacent to the stack (when built without `CONFIG_VMAP_STACK=y`)
>  
>  Implicit switch case fall-through
>  ---------------------------------
> -The C language allows switch cases to "fall-through" when a "break" statement
> -is missing at the end of a case. This, however, introduces ambiguity in the
> -code, as it's not always clear if the missing break is intentional or a bug.
> +The C language allows switch cases to fall through to the next case
> +when a "break" statement is missing at the end of a case. This, however,
> +introduces ambiguity in the code, as it's not always clear if the missing
> +break is intentional or a bug. For example, it's not obvious just from
> +looking at the code if `STATE_ONE` is intentionally designed to fall
> +through into `STATE_TWO`::
> +
> +	switch (value) {
> +	case STATE_ONE:
> +		do_something();
> +	case STATE_TWO:
> +		do_other();
> +		break;
> +	default:
> +		WARN("unknown state");
> +	}
>  
>  As there have been a long list of flaws `due to missing "break" statements
>  <https://cwe.mitre.org/data/definitions/484.html>`_, we no longer allow
> -"implicit fall-through".
> -
> -In order to identify intentional fall-through cases, we have adopted a
> -pseudo-keyword macro 'fallthrough' which expands to gcc's extension
> -__attribute__((__fallthrough__)).  `Statement Attributes
> -<https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html>`_
> -
> -When the C17/C18  [[fallthrough]] syntax is more commonly supported by
> +implicit fall-through. In order to identify intentional fall-through
> +cases, we have adopted a pseudo-keyword macro "fallthrough" which
> +expands to gcc's extension `__attribute__((__fallthrough__))
> +<https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html>`_.
> +(When the C17/C18  `[[fallthrough]]` syntax is more commonly supported by
>  C compilers, static analyzers, and IDEs, we can switch to using that syntax
> -for the macro pseudo-keyword.
> +for the macro pseudo-keyword.)
>  
>  All switch/case blocks must end in one of:
>  
> -	break;
> -	fallthrough;
> -	continue;
> -	goto <label>;
> -	return [expression];
> +* break;
> +* fallthrough;
> +* continue;
> +* goto <label>;
> +* return [expression];
> 
