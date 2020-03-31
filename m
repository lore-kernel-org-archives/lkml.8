Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9CFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C92921473
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCaSWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:22:05 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:33610 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726194AbgCaSWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:22:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 0E3D5180286D8;
        Tue, 31 Mar 2020 18:22:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ice31_864618078355f
X-Filterd-Recvd-Size: 2749
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 31 Mar 2020 18:22:02 +0000 (UTC)
Message-ID: <dc53b8704ec674cba636b41d7f55bf507a7bd7aa.camel@perches.com>
Subject: Re: [PATCH] compiler.h: fix error in BUILD_BUG_ON() reporting
From:   Joe Perches <joe@perches.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Santos <daniel.santos@pobox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ian Abbott <abbotti@mev.co.uk>
Date:   Tue, 31 Mar 2020 11:20:07 -0700
In-Reply-To: <20200331112637.25047-1-vegard.nossum@oracle.com>
References: <20200331112637.25047-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-31 at 13:26 +0200, Vegard Nossum wrote:
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
> ./include/linux/compiler.h:350:38: error: call to ‘__compiletime_assert_9’ declared with attribute error: BUILD_BUG_ON failed: 0
>   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> 
> However, it was not the BUILD_BUG_ON(0) that failed, so it should say 1
> instead of 0. With this patch, we use __COUNTER__ instead of __LINE__, so
> each BUILD_BUG_ON() gets a different function name and the correct
> condition is printed:
> 
> ./include/linux/compiler.h:350:38: error: call to ‘__compiletime_assert_0’ declared with attribute error: BUILD_BUG_ON failed: 1
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
[]
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
[]
> @@ -347,7 +347,7 @@ static inline void *offset_to_ptr(const int *off)
>   * compiler has support to do so.
>   */
>  #define compiletime_assert(condition, msg) \
> -	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> +	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)

This might be better using something like __LINE__ ## _ ## __COUNTER__

as line # is somewhat useful to identify the specific assert in a file.


