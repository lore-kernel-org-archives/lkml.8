Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EF5C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC2E2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KbV95ITg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbgCaW1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:27:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58708 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaW1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:27:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71AA55E8E1;
        Tue, 31 Mar 2020 18:27:28 -0400 (EDT)
        (envelope-from daniel.santos@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=tUAISgeTECuY
        FozM2eCvQreWHGo=; b=KbV95ITg+JUShCGHOrSj7y8wcyLrS+gMEJQANLLJlcBu
        IZ1FDL3h4p/l7EiIe2MTIDk0avSD1aVw0/+YelC+kyW85JDv56GIfNLhxkaCXYbo
        WYGck/y7BGUri5PeYTYXH3UzF/e+HH1Y+Hg3WNkU5rG3p4kzwnG0pKi0/5hEaVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pKtTVz
        pVmKpiAD46FKIPLPkbpCwYT+f1KloLBZGudrzoU463tZVoyarfFB4px6DEaxScSL
        Jv7QgZGtRpHebTCn+2XZL4MJ7q1gSBUnzTAexjCOq1LWWoN7cV9WEWQ7Gfp7Jaqz
        S/vHp4csFKxxIfKB5Y07BuUoZ3g8MC1TsqTW8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6946D5E8E0;
        Tue, 31 Mar 2020 18:27:28 -0400 (EDT)
        (envelope-from daniel.santos@pobox.com)
Received: from [192.168.0.8] (unknown [76.183.130.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C4465E8DF;
        Tue, 31 Mar 2020 18:27:27 -0400 (EDT)
        (envelope-from daniel.santos@pobox.com)
Subject: Re: [PATCH] compiler.h: fix error in BUILD_BUG_ON() reporting
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ian Abbott <abbotti@mev.co.uk>
References: <20200331112637.25047-1-vegard.nossum@oracle.com>
From:   Daniel Santos <daniel.santos@pobox.com>
Message-ID: <91730318-da0e-c992-f154-a74044b26650@pobox.com>
Date:   Tue, 31 Mar 2020 17:25:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200331112637.25047-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: CD919292-739E-11EA-A683-C28CBED8090B-06139138!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/20 6:26 AM, Vegard Nossum wrote:
> compiletime_assert() uses __LINE__ to create a unique function name.
> This means that if you have more than one BUILD_BUG_ON() in the same
> source line (which can happen if they appear e.g. in a macro), then
> the error message from the compiler might output the wrong condition.
>
> For this source file:
>
> 	#include <linux/build_bug.h>
>
> 	#define macro() \
> 		BUILD_BUG_ON(1); \
> 		BUILD_BUG_ON(0);
>
> 	void foo()
> 	{
> 		macro();
> 	}
>
> gcc would output:
>
> ./include/linux/compiler.h:350:38: error: call to =E2=80=98__compiletim=
e_assert_9=E2=80=99 declared with attribute error: BUILD_BUG_ON failed: 0
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>
> However, it was not the BUILD_BUG_ON(0) that failed, so it should say 1
> instead of 0. With this patch, we use __COUNTER__ instead of __LINE__, =
so
> each BUILD_BUG_ON() gets a different function name and the correct
> condition is printed:
>
> ./include/linux/compiler.h:350:38: error: call to =E2=80=98__compiletim=
e_assert_0=E2=80=99 declared with attribute error: BUILD_BUG_ON failed: 1
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER_=
_)
>
> Cc: Daniel Santos <daniel.santos@pobox.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Ian Abbott <abbotti@mev.co.uk>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  include/linux/compiler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 5e88e7e33abec..034b0a644efcc 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -347,7 +347,7 @@ static inline void *offset_to_ptr(const int *off)
>   * compiler has support to do so.
>   */
>  #define compiletime_assert(condition, msg) \
> -	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> +	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER_=
_)
> =20
>  #define compiletime_assert_atomic_type(t)				\
>  	compiletime_assert(__native_word(t),				\

This will break builds using gcc 4.2 and earlier and the expectation was
that you don't put two of them on the same line -- not helpful in macros
where it all must be on the same line.=C2=A0 Is gcc 4.2 still supported?=C2=
=A0 If
so, I recommend using another macro for the unique number that uses
__COUNTER__ if available and __LINE__ otherwise.=C2=A0 This was the decis=
ion
for using __LINE__ when I wrote the original anyway.

Also note that this construct:

BUILD_BUG_ON_MSG(0, "I like chicken"); BUILD_BUG_ON_MSG(1, "I don't like
chicken");

will incorrectly claim that I like chicken.=C2=A0 This is because of how
__attribute__((error)) works -- gcc will use the first declaration to
define the error message.

I couple of years ago, I almost wrote a gcc extension to get rid of this
whole mess and just __builtin_const_assert(cond, msg).=C2=A0 Maybe I'll
finish that this year.

Daniel
